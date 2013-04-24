Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:34047 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756980Ab3DXQeV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2013 12:34:21 -0400
Received: by mail-oa0-f50.google.com with SMTP id j6so1875894oag.23
        for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2013 09:34:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130422231214.32621.37394.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop> <20130422231214.32621.37394.stgit@bhelgaas-glaptop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 24 Apr 2013 10:34:00 -0600
Message-ID: <CAErSpo6BF0Uvf=7LwYYT2Qn6kf5uk+rVqY-cKOe2qnVwcj4-+w@mail.gmail.com>
Subject: Re: [PATCH v4 18/22] xen/pci: Pay attention to PCI_MSIX_TABLE_OFFSET
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	xen-devel@lists.xensource.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Jeremy, xen-devel]

Full series at https://lkml.kernel.org/r/20130422230012.32621.15224.stgit@bhelgaas-glaptop
(email archive) or
http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/gavin-msi-cleanup
(git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git branch
pci/gavin-msi-cleanup).

On Mon, Apr 22, 2013 at 5:12 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> The MSI-X Table structure may be at a non-zero offset into the
> device BAR, and we should account for that.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  arch/x86/pci/xen.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
> index 94e7662..0e8a196 100644
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -300,8 +300,10 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>                         pci_read_config_dword(dev, pos + PCI_MSIX_TABLE,
>                                               &table_offset);
>                         bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
> +                       table_offset &= PCI_MSIX_TABLE_OFFSET;
>
> -                       map_irq.table_base = pci_resource_start(dev, bir);
> +                       map_irq.table_base = pci_resource_start(dev, bir) +
> +                               table_offset;
>                         map_irq.entry_nr = msidesc->msi_attrib.entry_nr;
>                 }
>
>
