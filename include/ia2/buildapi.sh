# run build.sh from the IA2 directory

# make sure we have Cygwin
if [ ! -d /cygdrive/c ]; then
    echo 'Expected to find Cygwin'
    exit 1
fi

# make sure we have the proper directory structure
if [ ! -d api ]; then
    echo 'Expected to find ./api'
    exit 1
fi

# make sure we have Doxygen
if [ ! -x /cygdrive/c/program\ files/doxygen/bin/doxygen.exe ]; then
    echo 'Expected to find c:/program files/doxygen/bin/doxygen.exe'
    exit 1
fi

cd api

# make sure we have a Doxygen configuration file
if [ ! -f ../doxygen.conf ]; then
    echo 'Expected to find doxygen.conf'
    exit 1
fi

# clean up test dir
if [ -f ../IDL-Test/dlldata.c ]; then
    rm ../IDL-Test/*.c
    rm ../IDL-Test/*.h
fi

cp ../IDL-Test/StdAfxSave/*.* ../IDL-Test

# remove previous autogenerated Doxygen files
if [ -d ../docs ]; then
    rm -rf ../docs
fi

# generate IDL documentation with Doxygen
/cygdrive/c/program\ files/doxygen/bin/doxygen ../doxygen.conf

# remove any previous autogenerated merged IDL file
if [ -f ../ia2_api_all.idl ]; then
    rm ../ia2_api_all.idl
fi

# generate merged IDL file - IA2TypeLibrary.idl must be at the end
cat Accessible2.idl Accessible2_2.idl Accessible2_3.idl AccessibleAction.idl AccessibleApplication.idl AccessibleComponent.idl AccessibleDocument.idl AccessibleEditableText.idl AccessibleEventId.idl AccessibleHyperlink.idl AccessibleHypertext.idl AccessibleHypertext2.idl AccessibleImage.idl AccessibleRelation.idl AccessibleRole.idl AccessibleStates.idl AccessibleTable.idl AccessibleTable2.idl AccessibleTableCell.idl AccessibleText.idl AccessibleText2.idl AccessibleValue.idl IA2CommonTypes.idl IA2TypeLibrary.idl | sed -e 's/import "[A-Za-z0-9].*$//g' - | cat api_all_headers.idl - > ../ia2_api_all.idl

cd ..

# remove previous autogenerated zip file
if [ -f ia2-api-`date +%Y%m%d`.zip ]; then
    rm ia2-api-`date +%Y%m%d`.zip
fi

# package merged IDL file and documentation
zip -9r ia2-api-`date +%Y%m%d`.zip ia2_api_all.idl api/*.idl docs

# list packaged file for visual confirmation
echo ''
ls -l ia2-api-`date +%Y%m%d`.zip
