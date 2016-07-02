Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 2 Jul 2016 10:31:24 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, nikunj@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, linux-doc@vger.kernel.org, aik@ozlabs.ru,
	linux-pci@vger.kernel.org, corbet@lwn.net,
	linux-kernel@vger.kernel.org, bhelgaas@google.com,
	alex.williamson@redhat.com, paulus@samba.org,
	warrier@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 2/7] PCI: Ignore enforced alignment to VF BARs
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1467283993-3185-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1467283993-3185-3-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160701003959.GB15147@gwshan>
 <21112bd7-d343-46b6-1df1-b20cc1c1b24e@linux.vnet.ibm.com>
 <20160701060519.GA8863@gwshan>
 <ad90a18f-fcf3-b07d-f887-8daa6a313c77@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ad90a18f-fcf3-b07d-f887-8daa6a313c77@linux.vnet.ibm.com>
Message-Id: <20160702003124.GA7582@gwshan>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 01, 2016 at 02:40:16PM +0800, Yongji Xie wrote:
>Hi Gavin,
>
>On 2016/7/1 14:05, Gavin Shan wrote:
>
>>On Fri, Jul 01, 2016 at 01:27:17PM +0800, Yongji Xie wrote:
>>>>On Thu, Jun 30, 2016 at 06:53:08PM +0800, Yongji Xie wrote:
>>>>>VF BARs are read-only zeroes according to SRIOV spec,
>>>>>the normal way(writing BARs) of allocating resources wouldn't
>>>>>be applied to VFs. The VFs' resources would be allocated
>>>>>when we enable SR-IOV capability. So we should not try to
>>>>>reassign alignment after we enable VFs. It's meaningless
>>>>>and will release the allocated resources which leads to a bug.
>>>>>
>>>>>Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>>>>>---
>>>>>drivers/pci/pci.c |    4 ++++
>>>>>1 file changed, 4 insertions(+)
>>>>>
>>>>>diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>>index be8f72c..6ae02de 100644
>>>>>--- a/drivers/pci/pci.c
>>>>>+++ b/drivers/pci/pci.c
>>>>>@@ -4822,6 +4822,10 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>>>>>	resource_size_t align, size;
>>>>>	u16 command;
>>>>>
>>>>>+	/* We should never try to reassign VF's alignment */
>>>>>+	if (dev->is_virtfn)
>>>>>+		return;
>>>>>+
>>>>Yongji, I think it's correct to ignore VF's BARs. Another concern is:
>>>>it's safe to apply alignment to PF's IOV BARs? Lets have an extreme
>>>>example here: one PF has 16 VFs; each VF has only one 1KB. It means
>>>>the only PF IOV BAR is 16KB. I don't see how it works after expanding
>>>>it to 64KB which is the page size. It might be not a problem on PowerNV
>>>>platform, but potentially a issue on x86?
>>>Seems like the alignment would not be applied to IOV BARs because
>>>pci_reassigndev_resource_alignment() will be called before
>>>sriov_init().
>>>
>>Correct, thanks for the claim. I guess the alignment applied to PF IOV
>>BARs should be ignored as well? Anyway, the IOV BARs are retireved from
>>SRIOV capability. It deserves a comment if you plan to take the change.
>>Actually, the comment here (for ignoring alignment to VF BARs) can be
>>improved a bit as well, it'd better why the alignment cannot be applied.
>>
>
>Do you mean we should ignore PF IOV BARs like this:
>
>--- a/drivers/pci/pci.c
>+++ b/drivers/pci/pci.c
>@@ -4833,7 +4833,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev
>*dev)
>        command &= ~PCI_COMMAND_MEMORY;
>        pci_write_config_word(dev, PCI_COMMAND, command);
>
>-       for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
>+       for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
>                r = &dev->resource[i];
>                if (!(r->flags & IORESOURCE_MEM))
>                        continue;
>

Yeah, I think it's what I expected. Please add a comment to explain
why PCI bridge windows and PF's IOV BARs are not involed.

Thanks,
Gavin
