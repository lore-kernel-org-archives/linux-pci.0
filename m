Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37541 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbaD2ARU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Apr 2014 20:17:20 -0400
Received: by mail-ig0-f180.google.com with SMTP id r2so357248igi.1
        for <linux-pci@vger.kernel.org>; Mon, 28 Apr 2014 17:17:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1398682281-18772-1-git-send-email-festevam@gmail.com>
References: <1398682281-18772-1-git-send-email-festevam@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 28 Apr 2014 18:16:58 -0600
Message-ID: <CAErSpo70h=DeE3=EpF9d=RQM5y-3tTJ9ZqDiGQ8t5rLfs_zx6w@mail.gmail.com>
Subject: Re: [PATCH] pci: pci-mvebu: Use '%pa' for printing 'phys_addr_t' type
To: Fabio Estevam <festevam@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 28, 2014 at 4:51 AM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Fix the following build warning that happens when building multi_v7_defconfig
> with CONFIG_ARM_LPAE=y:
>
> drivers/pci/host/pci-mvebu.c:334:5: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'phys_addr_t' [-Wformat=]
>
> While at it, also use '%zx' for printing 'size_t'.
>
> Reported-by: Olof's autobuilder <build@lixom.net>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/pci/host/pci-mvebu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index e384e25..572a7b5 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -330,8 +330,8 @@ static void mvebu_pcie_add_windows(struct mvebu_pcie_port *port,
>                                                         sz, remap);
>                 if (ret) {
>                         dev_err(&port->pcie->pdev->dev,
> -                               "Could not create MBus window at 0x%x, size 0x%x: %d\n",
> -                               base, sz, ret);
> +                               "Could not create MBus window at %pa, size 0x%zx: %d\n",
> +                               &base, sz, ret);

This is OK, but can we use the same "[mem 0x...-0x...]" format that
%pR prints a struct resource with?  That would make it look more like
other similar information we print elsewhere.  When you're debugging a
problem, sometimes you have to compare address information from
different places, and it's convenient if they all look similar.

>                         mvebu_pcie_del_windows(port, base - size_mapped,
>                                                size_mapped);
>                         return;
> --
> 1.8.3.2
>
