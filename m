Return-Path: <SRS0=xRnl=JS=gmail.com=ckoenig.leichtzumerken@kernel.org>
Return-Path: <SRS0=xRnl=JS=gmail.com=ckoenig.leichtzumerken@kernel.org>
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 1/2] PCI: fix restoring resized BAR state on resume
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20180614122146.62118-1-christian.koenig@amd.com>
 <20180630005718.GJ40928@bhelgaas-glaptop.roam.corp.google.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <064ebaf7-8953-fd29-a688-26a5646111a0@gmail.com>
Date: Mon, 2 Jul 2018 15:20:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180630005718.GJ40928@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Am 30.06.2018 um 02:57 schrieb Bjorn Helgaas:
> On Thu, Jun 14, 2018 at 02:21:45PM +0200, Christian König wrote:
>> Resize BARs after resume to the expected size again.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=199959
>> CC: stable@vger.kernel.org      # v4.15+
> I applied both of these to pci/resource for v4.19, thanks!  It'd be nice to
> have them in v4.18, but since it's not a regression and the problem has
> been there since v4.15, I'm not sure I could justify it.

Well it is a regression. The change to enable this in the upstream 
driver was added in 4.16, but a good bunch of people also compile our 
backported DKMS module.

And now those people are complaining that the driver stopped working 
after resume in 4.15 with the DKMS module and with 4.16 with the 
upstream module.

Alternatively I can disable resizing from the driver from kernels older 
than v4.19.

Christian.

>
>> ---
>>   drivers/pci/pci.c | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index bd6f156dc3cf..d4685090378b 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1159,6 +1159,33 @@ static void pci_restore_config_space(struct pci_dev *pdev)
>>   	}
>>   }
>>   
>> +static void pci_restore_rebar_state(struct pci_dev *pdev)
>> +{
>> +	unsigned int pos, nbars, i;
>> +	u32 ctrl;
>> +
>> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
>> +	if (!pos)
>> +		return;
>> +
>> +	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
>> +	nbars = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >>
>> +		    PCI_REBAR_CTRL_NBAR_SHIFT;
>> +
>> +	for (i = 0; i < nbars; i++, pos += 8) {
>> +		struct resource *res;
>> +		int bar_idx, size;
>> +
>> +		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
>> +		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
>> +		res = pdev->resource + bar_idx;
>> +		size = order_base_2((resource_size(res) >> 20) | 1) - 1;
>> +		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
>> +		ctrl |= size << 8;
>> +		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
>> +	}
>> +}
>> +
>>   /**
>>    * pci_restore_state - Restore the saved state of a PCI device
>>    * @dev: - PCI device that we're dealing with
>> @@ -1174,6 +1201,7 @@ void pci_restore_state(struct pci_dev *dev)
>>   	pci_restore_pri_state(dev);
>>   	pci_restore_ats_state(dev);
>>   	pci_restore_vc_state(dev);
>> +	pci_restore_rebar_state(dev);
>>   
>>   	pci_cleanup_aer_error_status_regs(dev);
>>   
>> -- 
>> 2.14.1
>>
