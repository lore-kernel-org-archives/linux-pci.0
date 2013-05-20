Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:39800 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755974Ab3ETX1P (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 May 2013 19:27:15 -0400
Received: by mail-ob0-f169.google.com with SMTP id vb8so4787obc.14
        for <linux-pci@vger.kernel.org>; Mon, 20 May 2013 16:27:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130520231909.32416.81752.stgit@bhelgaas-glaptop>
References: <20130520231909.32416.81752.stgit@bhelgaas-glaptop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 20 May 2013 17:26:54 -0600
Message-ID: <CAErSpo7pWpDae2uOJq-F57YRmPEK3q1qD1aawM-NgEXMw-k8og@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/PCI: Use PCI_UNKNOWN for unknown power state
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 20, 2013 at 5:19 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Previously we initialized dev->current_state to 4 (PCI_D3cold), but I think
> we wanted PCI_UNKNOWN (5) here based on the comment and the fact that the
> generic version of this code, pci_setup_device(), uses PCI_UNKNOWN.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/powerpc/kernel/pci_of_scan.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
> index 2a67e9b..d2d407d 100644
> --- a/arch/powerpc/kernel/pci_of_scan.c
> +++ b/arch/powerpc/kernel/pci_of_scan.c
> @@ -165,7 +165,7 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
>         pr_debug("    class: 0x%x\n", dev->class);
>         pr_debug("    revision: 0x%x\n", dev->revision);
>
> -       dev->current_state = 4;         /* unknown power state */
> +       dev->current_state = PCI_UNKNOWN;       /* unknown power state */

If you're interested in the archaeology of this, I think it was first
introduced by 4267292b0 in 2005 for powerpc and subsequently copied
into sparc by a2fb23af1 in 2007.

Prior to the addition of PCI_UNKNOWN, pci_setup_device() set
current_state to 4, so I think 4267292b0 probably just copied that
code before 3fe9d19f9 added PCI_UNKNOWN and changed the initialization
in pci_setup_device().

>         dev->error_state = pci_channel_io_normal;
>         dev->dma_mask = 0xffffffff;
>
>
