Return-Path: <SRS0=d/Ya=DI=Oracle.COM=Govinda.Tatti@kernel.org>
Return-Path: <SRS0=d/Ya=DI=Oracle.COM=Govinda.Tatti@kernel.org>
Subject: Re: [PATCH V3 1/2] Drivers/PCI: Export pcie_has_flr() interface
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        boris.ostrovsky@Oracle.COM, jgross@suse.com, JBeulich@suse.com,
        roger.pau@citrix.com, konrad.wilk@Oracle.COM
References: <20171207222145.9769-1-Govinda.Tatti@Oracle.COM>
 <20171207222145.9769-2-Govinda.Tatti@Oracle.COM>
 <20171208202424.GC12367@bhelgaas-glaptop.roam.corp.google.com>
From: Govinda Tatti <Govinda.Tatti@Oracle.COM>
Message-ID: <426eeeab-0dcd-8de3-9c5f-a166acf2c130@Oracle.COM>
Date: Mon, 11 Dec 2017 18:29:29 -0600
MIME-Version: 1.0
In-Reply-To: <20171208202424.GC12367@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>


Thanks Bjorn for your review comments. Please see below for my comments.

On 12/8/2017 2:24 PM, Bjorn Helgaas wrote:
> On Thu, Dec 07, 2017 at 05:21:44PM -0500, Govinda Tatti wrote:
>> This patch exports pcie_has_flr() and it is being used by Xen pciback
>> driver to reset (flr/slot/bus) PCI devices based on 'reset' SysFS
>> attribute.
>>
>> Signed-off-by: Govinda Tatti <Govinda.Tatti@Oracle.COM>
>> ---
>> v3: -New
>>
>>   drivers/pci/pci.c   | 3 ++-
>>   include/linux/pci.h | 1 +
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 6078dfc..499e922 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3872,7 +3872,7 @@ static void pci_flr_wait(struct pci_dev *dev)
>>    * Returns true if the device advertises support for PCIe function level
>>    * resets.
>>    */
>> -static bool pcie_has_flr(struct pci_dev *dev)
>> +bool pcie_has_flr(struct pci_dev *dev)
>>   {
>>   	u32 cap;
>>   
>> @@ -3882,6 +3882,7 @@ static bool pcie_has_flr(struct pci_dev *dev)
>>   	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
>>   	return cap & PCI_EXP_DEVCAP_FLR;
>>   }
>> +EXPORT_SYMBOL_GPL(pcie_has_flr);
> I'd rather change pcie_flr() so you could *always* call it, and it
> would return 0, -ENOTTY, or whatever, based on whether FLR is
> supported.  Is that feasible?
Sure, I will add pcie_has_flr() logic inside pcie_flr() and return 
appropriate
values as suggested by you. Do we still want to retain pcie_has_flr() and
its usage inside pci.c?.Otherwise, I will remove it and do required cleanup.

Please let me know.

Cheers
GOVINDA
