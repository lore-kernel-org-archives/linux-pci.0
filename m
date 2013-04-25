Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gg0-f172.google.com ([209.85.161.172]:39948 "EHLO
	mail-gg0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758982Ab3DYQmm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Apr 2013 12:42:42 -0400
Received: by mail-gg0-f172.google.com with SMTP id f1so419890ggn.31
        for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2013 09:42:41 -0700 (PDT)
Date: Thu, 25 Apr 2013 10:42:38 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jan Beulich <JBeulich@suse.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	xen-devel@lists.xensource.com,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH v4 18/22] xen/pci: Pay attention to
 PCI_MSIX_TABLE_OFFSET
Message-ID: <20130425164238.GA3052@google.com>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
 <20130422231214.32621.37394.stgit@bhelgaas-glaptop>
 <CAErSpo6BF0Uvf=7LwYYT2Qn6kf5uk+rVqY-cKOe2qnVwcj4-+w@mail.gmail.com>
 <5179164902000078000D0A26@nat28.tlf.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5179164902000078000D0A26@nat28.tlf.novell.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 25, 2013 at 10:40:57AM +0100, Jan Beulich wrote:
> >>> On 24.04.13 at 18:34, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > On Mon, Apr 22, 2013 at 5:12 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >> The MSI-X Table structure may be at a non-zero offset into the
> >> device BAR, and we should account for that.
> 
> NAK: The base is just being use to pass to the hypervisor, which
> then takes care to add the offset.

Thanks for noticing this.  I updated the patch to just add a comment to
avert future confusion, and refreshed the subsequent xen patches as below.

> Recent hypervisors will actually
> only consume this to issue a warning if not matching what gets
> read from the corresponding BAR. Earlier hypervisors used this
> instead of reading the BAR.

Note that pci_resource_start() gives you a CPU address, and what you
read from the BAR is a PCI bus address.  These are not in the same
address space and can't be directly compared.  I assume the
hypervisors take that into account and do the appropriate
conversions?

Bjorn


commit 34f394aad6706a42fb69922ed184c918ec9f9f81
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Apr 18 15:02:34 2013 -0600

    xen/pci: Comment on unusual PCI_MSIX_TABLE usage
    
    To find the MSI-X Table structure, you look at the BAR specified
    by PCI_MSIX_FLAGS_BIRMASK, then apply the PCI_MSIX_TABLE_OFFSET to
    the address from the BAR.  So most readers of PCI_MSIX_TABLE use
    PCI_MSIX_TABLE_OFFSET, but in xen's case, the hypervisor takes
    care of applying the offset, so we don't need to do it here.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    CC: Jan Beulich <JBeulich@suse.com>

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 94e7662..96e44fc 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -301,6 +301,7 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 					      &table_offset);
 			bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
 
+			/* Hypervisor takes care of PCI_MSIX_TABLE_OFFSET */
 			map_irq.table_base = pci_resource_start(dev, bir);
 			map_irq.entry_nr = msidesc->msi_attrib.entry_nr;
 		}

commit 311d82d74afa19cb0ea03c516e290457f9aab63d
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Apr 18 12:40:33 2013 -0600

    xen/pci: Use PCI_MSIX_TABLE_BIR, not PCI_MSIX_FLAGS_BIRMASK
    
    PCI_MSIX_FLAGS_BIRMASK is mis-named because the BIR mask is in the
    Table Offset register, not the flags ("Message Control" per spec)
    register.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    CC: Jan Beulich <JBeulich@suse.com>

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 96e44fc..bec03d4 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -299,7 +299,7 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 
 			pci_read_config_dword(dev, pos + PCI_MSIX_TABLE,
 					      &table_offset);
-			bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
+			bir = (u8)(table_offset & PCI_MSIX_TABLE_BIR);
 
 			/* Hypervisor takes care of PCI_MSIX_TABLE_OFFSET */
 			map_irq.table_base = pci_resource_start(dev, bir);

commit 4a5b938fe2ed3e5f5c51f4906c0d1c1486f37e49
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Apr 18 15:10:58 2013 -0600

    xen/pci: Used cached MSI-X capability offset
    
    We now cache the MSI-X capability offset in the struct pci_dev, so no
    need to find the capability again.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    CC: Jan Beulich <JBeulich@suse.com>

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index bec03d4..a151b02 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -295,8 +295,7 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 			int pos;
 			u32 table_offset, bir;
 
-			pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
-
+			pos = dev->msix_cap;
 			pci_read_config_dword(dev, pos + PCI_MSIX_TABLE,
 					      &table_offset);
 			bir = (u8)(table_offset & PCI_MSIX_TABLE_BIR);
