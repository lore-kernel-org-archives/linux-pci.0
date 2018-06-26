Return-Path: <SRS0=R6/I=JM=gmail.com=mr.nuke.me@kernel.org>
Return-Path: <SRS0=R6/I=JM=gmail.com=mr.nuke.me@kernel.org>
Subject: Re: [PATCH] PCI: DPC: Clear AER status bits before disabling port
 containment
To: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, bhelgaas@google.com,
 alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com,
 Dongdong Liu <liudongdong3@huawei.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20180516213306.27027-1-mr.nuke.me@gmail.com>
 <605540c0-b6c5-89a2-9d50-12a3005d9f88@codeaurora.org>
 <20180516231220.GA21659@localhost.localdomain>
 <20180619215720.GE33049@bhelgaas-glaptop.roam.corp.google.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <bcaa5398-3306-7b25-3d1f-d2f0568fc72a@gmail.com>
Date: Tue, 26 Jun 2018 15:51:02 -0500
MIME-Version: 1.0
In-Reply-To: <20180619215720.GE33049@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>



On 06/19/2018 04:57 PM, Bjorn Helgaas wrote:
> On Wed, May 16, 2018 at 05:12:21PM -0600, Keith Busch wrote:
>> On Wed, May 16, 2018 at 06:44:22PM -0400, Sinan Kaya wrote:
>>> On 5/16/2018 5:33 PM, Alexandru Gagniuc wrote:
>>>> AER status bits are sticky, and they survive system resets. Downstream
>>>> devices are usually taken care of after re-enumerating the downstream
>>>> busses, as the AER bits are cleared during probe().
>>>>
>>>> However, nothing clears the bits of the port which contained the
>>>> error. These sticky bits may leave some BIOSes to think that something
>>>> bad happened, and print ominous messages on next boot. To prevent this,
>>>> tidy up the AER status bits before releasing containment.
>>>>
>>>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>>>> ---
>>>>  drivers/pci/pcie/dpc.c | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>>>> index 8c57d607e603..bf82d6936556 100644
>>>> --- a/drivers/pci/pcie/dpc.c
>>>> +++ b/drivers/pci/pcie/dpc.c
>>>> @@ -112,6 +112,10 @@ static void dpc_work(struct work_struct *work)
>>>>  		dpc->rp_pio_status = 0;
>>>>  	}
>>>>  
>>>> +	/* DPC event made a mess of our AER status bits. Clean them up. */
>>>> +	pci_cleanup_aer_error_status_regs(pdev);
>>>> +	/* TODO: Should we also use aer_print_error to log the event? */
>>>> +
>>>>  	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
>>>>  		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
>>>>  
>>>>
>>>
>>> I think Keith has a patch to fix this. It was under review at some point.
>>
>> Right, I do intend to following up on this, but I've had some trouble
>> finding time the last few weeks. Sorry about that, things will clear up
>> for me shortly.
> 
> I'll drop this (Alexandru's) patch for now, waiting for your update, Keith.

I wonder if clearing AER status bits is mutually exclusive with
refactoring other parts of DPC handling?

Alex
