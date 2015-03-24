Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5510B158.6060006@intel.com>
Date: Tue, 24 Mar 2015 08:35:36 +0800
From: Aaron Lu <aaron.lu@intel.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI: rename dsm uuid for PCI
References: <54FD4FB9.2060802@intel.com> <20150320210354.GK26935@google.com> <550FD9DF.7050306@intel.com> <1641780.MlgGlmpUFR@vostro.rjw.lan>
In-Reply-To: <1641780.MlgGlmpUFR@vostro.rjw.lan>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/24/2015 08:24 AM, Rafael J. Wysocki wrote:
> So _DSM is an ACPI-defined object and please spell its name like that.
> Also please spell UUID in capitals if that's not a problem.

Something like acpi_pci_dsm_UUID?

> 
> On Monday, March 23, 2015 05:16:15 PM Aaron Lu wrote:
>> According to the PCI firmware spec, there is only one assigned UUID used
>> for PCI system so rename the device_label_dsm_uuid to something more
>> common as: pci_acpi_dsm_uuid and put it in drivers/pci/pci-acpi.c. Make
>> that uuid array extern in the pci.h so that other code can also make use
>> of it.
>>
>> This patch shouldn't bring any functional change.
>>
>> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
>> ---
>>  drivers/pci/pci-acpi.c  |  5 +++++
>>  drivers/pci/pci-label.c | 11 ++---------
>>  drivers/pci/pci.h       |  6 ++++++
>>  3 files changed, 13 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index 489063987325..6ef2019073e2 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -18,6 +18,11 @@
>>  #include <linux/pm_qos.h>
>>  #include "pci.h"
>>  
> 
> Please add a comment referring to the document defining the UUID here.

OK.

> 
>> +const u8 pci_acpi_dsm_uuid[] = {
>> +	0xd0, 0x37, 0xc9, 0xe5, 0x53, 0x35, 0x7a, 0x4d,
>> +	0x91, 0x17, 0xea, 0x4d, 0x19, 0xc3, 0x43, 0x4d
>> +};
>> +
>>  phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
>>  {
>>  	acpi_status status = AE_NOT_EXIST;
>> diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
>> index 2ab1b47c7651..024b5c179348 100644
>> --- a/drivers/pci/pci-label.c
>> +++ b/drivers/pci/pci-label.c
>> @@ -31,8 +31,6 @@
>>  #include <linux/pci-acpi.h>
>>  #include "pci.h"
>>  
>> -#define	DEVICE_LABEL_DSM	0x07
>> -
>>  #ifdef CONFIG_DMI
>>  enum smbios_attr_enum {
>>  	SMBIOS_ATTR_NONE = 0,
>> @@ -148,11 +146,6 @@ static inline void pci_remove_smbiosname_file(struct pci_dev *pdev)
>>  #endif
>>  
>>  #ifdef CONFIG_ACPI
>> -static const char device_label_dsm_uuid[] = {
>> -	0xD0, 0x37, 0xC9, 0xE5, 0x53, 0x35, 0x7A, 0x4D,
>> -	0x91, 0x17, 0xEA, 0x4D, 0x19, 0xC3, 0x43, 0x4D
>> -};
>> -
>>  enum acpi_attr_enum {
>>  	ACPI_ATTR_LABEL_SHOW,
>>  	ACPI_ATTR_INDEX_SHOW,
>> @@ -179,7 +172,7 @@ static int dsm_get_label(struct device *dev, char *buf,
>>  	if (!handle)
>>  		return -1;
>>  
>> -	obj = acpi_evaluate_dsm(handle, device_label_dsm_uuid, 0x2,
>> +	obj = acpi_evaluate_dsm(handle, pci_acpi_dsm_uuid, 0x2,
>>  				DEVICE_LABEL_DSM, NULL);
>>  	if (!obj)
>>  		return -1;
>> @@ -219,7 +212,7 @@ static bool device_has_dsm(struct device *dev)
>>  	if (!handle)
>>  		return false;
>>  
>> -	return !!acpi_check_dsm(handle, device_label_dsm_uuid, 0x2,
>> +	return !!acpi_check_dsm(handle, pci_acpi_dsm_uuid, 0x2,
>>  				1 << DEVICE_LABEL_DSM);
>>  }
>>  
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 4091f82239cd..c901ab84cf3b 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -321,4 +321,10 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
>>  }
>>  #endif
>>  
>> +#ifdef CONFIG_ACPI
>> +extern const u8 pci_acpi_dsm_uuid[];
>> +
>> +#define DEVICE_LABEL_DSM	0x07
>> +#endif
> 
> We have pci-acpi.h.  Maybe define this stuff in there and make the user(s)
> include that?

No problem.

Thanks,
Aaron

> 
>> +
>>  #endif /* DRIVERS_PCI_H */
>>
> 

