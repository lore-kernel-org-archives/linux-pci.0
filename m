Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:35874 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757045Ab3DXQfq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2013 12:35:46 -0400
Received: by mail-ob0-f178.google.com with SMTP id 16so1712021obc.9
        for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2013 09:35:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130422231228.32621.88310.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop> <20130422231228.32621.88310.stgit@bhelgaas-glaptop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 24 Apr 2013 10:35:24 -0600
Message-ID: <CAErSpo7BU6xHaWFY9zK+fiKZbkXhTutqAcC6Nn1q-5X8vkw7KA@mail.gmail.com>
Subject: Re: [PATCH v4 20/22] xen/pci: Used cached MSI-X capability offset
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	xen-devel@lists.xensource.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Jeremy, xen-devel]

On Mon, Apr 22, 2013 at 5:12 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> We now cache the MSI-X capability offset in the struct pci_dev, so no
> need to find the capability again.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  arch/x86/pci/xen.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
> index b9d1ff2..7b521ef 100644
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -295,8 +295,7 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>                         int pos;
>                         u32 table_offset, bir;
>
> -                       pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
> -
> +                       pos = dev->msix_cap;
>                         pci_read_config_dword(dev, pos + PCI_MSIX_TABLE,
>                                               &table_offset);
>                         bir = (u8)(table_offset & PCI_MSIX_TABLE_BIR);
>
