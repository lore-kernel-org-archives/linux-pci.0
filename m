Return-Path: <SRS0=X6Sb=BL=ellerman.id.au=mpe@kernel.org>
Return-Path: <SRS0=X6Sb=BL=ellerman.id.au=mpe@kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <helgaas@kernel.org>, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org, seroyer@linux.vnet.ibm.com, linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "Juan J . Alvarez" <jjalvare@us.ibm.com>
Subject: Re: [PATCH v3 2/2] pseries/eeh: Add Pseries pcibios_bus_add_device
In-Reply-To: <20171011200524.GR25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170922141928.49141-1-bryantly@linux.vnet.ibm.com> <20170922141928.49141-3-bryantly@linux.vnet.ibm.com> <20171011200524.GR25517@bhelgaas-glaptop.roam.corp.google.com>
Date: Thu, 12 Oct 2017 15:09:53 +1100
Message-ID: <87efq92ei6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Fri, Sep 22, 2017 at 09:19:28AM -0500, Bryant G. Ly wrote:
>> This patch adds the machine dependent call for
>> pcibios_bus_add_device, since the previous patch
>> separated the calls out between the PowerNV and PowerVM.
>> 
>> The difference here is that for the PowerVM environment
>> we do not want match_driver set because in this environment
>> we do not want the VF device drivers to load immediately, due to
>> firmware loading the device node when VF device is assigned to the
>> logical partition.
>> 
>> This patch will depend on the patch linked below, which is under
>> review.
>> 
>> https://patchwork.kernel.org/patch/9882915/
>> 
>> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
>> Signed-off-by: Juan J. Alvarez <jjalvare@us.ibm.com>
>> ---
>>  arch/powerpc/platforms/pseries/eeh_pseries.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>> 
>> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
>> index 6b812ad990e4..45946ee90985 100644
>> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>> @@ -64,6 +64,27 @@ static unsigned char slot_errbuf[RTAS_ERROR_LOG_MAX];
>>  static DEFINE_SPINLOCK(slot_errbuf_lock);
>>  static int eeh_error_buf_size;
>>  
>> +void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
>> +{
>> +	struct pci_dn *pdn = pci_get_pdn(pdev);
>> +
>> +	if (!pdev->is_virtfn)
>> +		return;
>> +
>> +	pdn->device_id  =  pdev->device;
>> +	pdn->vendor_id  =  pdev->vendor;
>> +	pdn->class_code =  pdev->class;
>> +
>> +	/*
>> +	 * The following operations will fail if VF's sysfs files
>> +	 * aren't created or its resources aren't finalized.
>> +	 */
>> +	eeh_add_device_early(pdn);
>> +	eeh_add_device_late(pdev);
>> +	eeh_sysfs_add_device(pdev);
>> +	pdev->match_driver = -1;
>
> match_driver is a bool, which should be assigned "true" or "false".

Above he mentioned a dependency on:

  [04/10] PCI: extend pci device match_driver state
  https://patchwork.kernel.org/patch/9882915/


Which makes it an int.

Or has that patch been rejected or something?

cheers
