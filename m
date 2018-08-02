Return-Path: <SRS0=3hoA=KR=oracle.com=thomas.tai@kernel.org>
Return-Path: <SRS0=3hoA=KR=oracle.com=thomas.tai@kernel.org>
Subject: Re: [PATCH] PCI: pciehp: Differentiate between surprise and safe
 removal
To: Lukas Wunner <lukas@wunner.de>, gokul cg <gokuljnpr@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>, Yinghai Lu <yinghai@kernel.org>,
        Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
References: <dac488604766f3dcb948e702210ecc381c4f907b.1533015755.git.lukas@wunner.de>
 <20180801164358.GI2534@lahna.fi.intel.com> <20180801171512.GA28440@wunner.de>
 <20180802072036.GN2534@lahna.fi.intel.com>
 <CAFP4jM8AYG7hmkC_rYgXAfLoJmkJuW0e1UbgiayGrCPbb_yw8A@mail.gmail.com>
 <20180802084657.GA21267@wunner.de> <20180802150749.GA31683@wunner.de>
From: Thomas Tai <thomas.tai@oracle.com>
Message-ID: <ebb526d2-0440-6bd7-765c-b7489d75d830@oracle.com>
Date: Thu, 2 Aug 2018 13:09:18 -0400
MIME-Version: 1.0
In-Reply-To: <20180802150749.GA31683@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>


On 08/02/2018 11:07 AM, Lukas Wunner wrote:
> [cc += Thomas Tai]

Hi Lukas,
Thank you very much for cc me.
> 
> On Thu, Aug 02, 2018 at 10:46:57AM +0200, Lukas Wunner wrote:
>> On Thu, Aug 02, 2018 at 12:59:18PM +0530, gokul cg wrote:
>>> I am suspecting a possible race condition in the kernel between PCI driver
>>> and AER handling.
>>
>> The solution is to acquire a ref on each device in add_error_device().
>> Then release the ref aer_process_err_devices() by calling pci_dev_put().
> 
> So in case it wasn't clear, the below is what I had in mind.
> Completely untested though.  Does this work for you?
> 
> For v3.10 compatibility, cherry-pick 89ee9f768003 (or alternatively
> cherry-pick 8496e85c20e7 and replace pci_dev_is_disconnected(dev)
> with !pci_device_is_present(dev)).
> 
> -- >8 --
> Subject: [PATCH] PCI/AER: Fix use-after-free on surprise removal
> 
> The work item to consume errors, aer_isr(), walks the hierarchy using
> pci_walk_bus() and stores a pointer to PCI devices which reported an
> error in an array.  As long as pci_walk_bus() runs, those pointers are
> valid because pci_bus_sem is held.  But once pci_walk_bus() finishes,
> nothing prevents the pointers from becoming invalid, e.g. through
> unplugging of the PCI devices.  The unprotected pointers are then
> dereferenced in aer_process_err_devices(), which may oops:

I like your idea to increment the refcount during pci_walk_bus(), that 
should fix the use-after-free issue. We just need Gokul to confirm if it 
fixes his issue or not.

Thanks,
Thomas

> 
>    #5  general_protection at ffffffff8176cdf2
>        [exception RIP: pci_bus_read_config_dword+100]
>    #6  pci_find_next_ext_capability at ffffffff81345d7b
>    #7  pci_find_ext_capability at ffffffff81347225
>    #8  get_device_error_info at ffffffff81356c4d
>    #9  aer_isr at ffffffff81357a38
> 
> Fix by holding a ref on the devices until they have been processed.
> Skip processing of unplugged devices.
> 
> Reported-by: gokul cg <gokuljnpr@gmail.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>   drivers/pci/pcie/aer.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a2e8838..937592e 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -657,7 +657,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
>   static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
>   {
>   	if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
> -		e_info->dev[e_info->error_dev_num] = dev;
> +		e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
>   		e_info->error_dev_num++;
>   		return 0;
>   	}
> @@ -898,6 +898,9 @@ static int get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>   	if (!pos)
>   		return 0;
>   
> +	if (pci_dev_is_disconnected(dev))
> +		return 0;
> +
>   	if (info->severity == AER_CORRECTABLE) {
>   		pci_read_config_dword(dev, pos + PCI_ERR_COR_STATUS,
>   			&info->status);
> @@ -948,6 +951,7 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
>   	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
>   		if (get_device_error_info(e_info->dev[i], e_info))
>   			handle_error_source(e_info->dev[i], e_info);
> +		pci_dev_put(e_info->dev[i]);
>   	}
>   }
>   
> 
