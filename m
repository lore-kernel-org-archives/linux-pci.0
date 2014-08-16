Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:56313 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbaHPNNS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 16 Aug 2014 09:13:18 -0400
Received: by mail-qc0-f169.google.com with SMTP id c9so3345353qcz.14
        for <linux-pci@vger.kernel.org>; Sat, 16 Aug 2014 06:13:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1406137961-14684-4-git-send-email-l.stach@pengutronix.de>
References: <1406137961-14684-1-git-send-email-l.stach@pengutronix.de>
	<1406137961-14684-4-git-send-email-l.stach@pengutronix.de>
Date: Sat, 16 Aug 2014 18:43:17 +0530
Message-ID: <CAHM4w1nMxwfk9Vv37FO6Aa4-Zbb0tgCposakVzUm66B2BZobRQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] PCI: designware: remove pci_assign_unassigned_resources
 call
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>, yinghai@kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <r65037@freescale.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>, Marek Vasut <marex@denx.de>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	kernel@pengutronix.de, Pratyush ANAND <pratyush.anand@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 23, 2014 at 11:22 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> The pci_common_init_dev() call right before will already
> handle the device resource allocation, so this call
> was a no-op.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/pci/host/pcie-designware.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index b869e202367c..dde5e6d4afa2 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -568,7 +568,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>         dw_pci.private_data = (void **)&pp;
>
>         pci_common_init_dev(pp->dev, &dw_pci);
> -       pci_assign_unassigned_resources();

I am not sure here. IIRC, then calling  pci_assign_unassigned_resources after
pci_common_init_dev was needed to handle few PCIe cards with EP behind
bridge.

I do not have good understanding of pci resource allocation code.
@Yinghai: Can you please help(rather teach) with the description of
different resource allocator
available in setup-bus.c. Can try reading code, but if a documentation
exists, that would
be helpful.

 ~Pratyush
