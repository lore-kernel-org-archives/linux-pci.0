Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:61528 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625Ab3KEAEr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Nov 2013 19:04:47 -0500
Received: by mail-ie0-f169.google.com with SMTP id ar20so14131902iec.0
        for <linux-pci@vger.kernel.org>; Mon, 04 Nov 2013 16:04:47 -0800 (PST)
Date: Mon, 4 Nov 2013 17:04:40 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, Kumar Gala <galak@kernel.crashing.org>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Changes for v3.13 merge window
Message-ID: <20131105000440.GA16478@google.com>
References: <20131101152102.GA27643@google.com>
 <5276FA23.3040402@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5276FA23.3040402@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Kumar, Gavin, Ben, Paul]

On Mon, Nov 04, 2013 at 09:36:35AM +0800, Yijing Wang wrote:
> > Yijing Wang (17):
> >       PCI: Use pci_is_pcie() to simplify code
> >       x86/pci: Use cached pci_dev->pcie_cap to simplify code
> >       [SCSI] bfa: Use pcie_set()/get_readrq() to simplify code
> >       [SCSI] csiostor: Use pcie_capability_clear_and_set_word() to simplify code
> >       [SCSI] qla2xxx: Use pcie_is_pcie() to simplify code
> >       powerpc/pci: Use pci_is_pcie() to simplify code
> 
> Hi Bjorn,
>    Can you help update the patch "powerpc/pci: Use pci_is_pcie() to simplify code" by using the latest version v3 ?
> Because Benjamin Herrenschmidt found that "cap" in this patch is stale variable after applied this patch.
> Here is the link, https://patchwork.kernel.org/patch/3021121/

I merged the following additional patch, which should get make this
up-to-date.  Sorry I missed this.


powerpc/pci: Use pci_is_pcie() to simplify code [fix]

From: Yijing Wang <wangyijing@huawei.com>

Fix f0308261b1 ("powerpc/pci: Use pci_is_pcie() to simplify code").  I
accidentally merged v2 instead of v3, so this adds the difference.  Without
this, "cap" is the left-over PCI-X capability offset, and we're using it as
the PCIe capability offset.

[bhelgaas: extracted v2->v3 diff]
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/kernel/eeh.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 6ebbe54..db86f97 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -195,7 +195,7 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
 		       "EEH: PCI-E capabilities and status follow:\n");
 
 		for (i=0; i<=8; i++) {
-			eeh_ops->read_config(dn, cap+4*i, 4, &cfg);
+			eeh_ops->read_config(dn, dev->pcie_cap+4*i, 4, &cfg);
 			n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
 			printk(KERN_WARNING "EEH: PCI-E %02x: %08x\n", i, cfg);
 		}
