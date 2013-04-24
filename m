Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:39496 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757045Ab3DXQfZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2013 12:35:25 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp18so1717404obc.34
        for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2013 09:35:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130422231221.32621.95466.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop> <20130422231221.32621.95466.stgit@bhelgaas-glaptop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 24 Apr 2013 10:35:04 -0600
Message-ID: <CAErSpo7wHct9EAdsgX+QaQAPyV_K7k9Eok90_+8izM4qkbR9TQ@mail.gmail.com>
Subject: Re: [PATCH v4 19/22] xen/pci: Use PCI_MSIX_TABLE_BIR, not PCI_MSIX_FLAGS_BIRMASK
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	xen-devel <xen-devel@lists.xensource.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Jeremy, xen-devel]

On Mon, Apr 22, 2013 at 5:12 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> PCI_MSIX_FLAGS_BIRMASK is mis-named because the BIR mask is in the
> Table Offset register, not the flags ("Message Control" per spec)
> register.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  arch/x86/pci/xen.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
> index 0e8a196..b9d1ff2 100644
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -299,7 +299,7 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>
>                         pci_read_config_dword(dev, pos + PCI_MSIX_TABLE,
>                                               &table_offset);
> -                       bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
> +                       bir = (u8)(table_offset & PCI_MSIX_TABLE_BIR);
>                         table_offset &= PCI_MSIX_TABLE_OFFSET;
>
>                         map_irq.table_base = pci_resource_start(dev, bir) +
>
