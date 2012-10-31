Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45495 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185Ab2JaBea (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Oct 2012 21:34:30 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so426204bkc.19
        for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 18:34:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20121031095148.75dbb6e8.izumi.taku@jp.fujitsu.com>
References: <20121031095148.75dbb6e8.izumi.taku@jp.fujitsu.com>
Date: Tue, 30 Oct 2012 18:34:29 -0700
Message-ID: <CAE9FiQVoNm3Wsi4LM1Hhk3RXyLr-UXPggSdJ6Y1Ha7BjjApC5A@mail.gmail.com>
Subject: Re: [PATCH] PCI/portdrv: Fix regression introduced by commit 2dcfaf85
From: Yinghai Lu <yinghai@kernel.org>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jiang Liu <jiang.liu@huawei.com>, wangyijing@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 30, 2012 at 5:51 PM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>
> PCI/portdrv: Fix regression introduced by commit 2dcfaf85
>
> After commit 2dcfaf85, hotplug slots for port devices
> w/o slot implementation come to be created.
> This patch fixes this problem.
>
> Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
> ---
>  drivers/pci/pcie/portdrv_core.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Index: pci/drivers/pci/pcie/portdrv_core.c
> ===================================================================
> --- pci.orig/drivers/pci/pcie/portdrv_core.c
> +++ pci/drivers/pci/pcie/portdrv_core.c
> @@ -272,7 +272,8 @@ static int get_port_device_capability(st
>         }
>
>         /* Hot-Plug Capable */
> -       if (cap_mask & PCIE_PORT_SERVICE_HP) {
> +       if ((cap_mask & PCIE_PORT_SERVICE_HP) &&
> +           dev->pcie_flags_reg & PCI_EXP_FLAGS_SLOT) {
>                 pcie_capability_read_dword(dev, PCI_EXP_SLTCAP, &reg32);
>                 if (reg32 & PCI_EXP_SLTCAP_HPC) {
>                         services |= PCIE_PORT_SERVICE_HP;
>

Acked-by: Yinghai Lu <yinghai@kernel.org>
