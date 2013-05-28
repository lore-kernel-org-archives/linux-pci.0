Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:36496 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934735Ab3E1RZ2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 May 2013 13:25:28 -0400
Received: by mail-oa0-f53.google.com with SMTP id g12so10271617oah.26
        for <linux-pci@vger.kernel.org>; Tue, 28 May 2013 10:25:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369728202-31188-1-git-send-email-wangyijing@huawei.com>
References: <1369728202-31188-1-git-send-email-wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 28 May 2013 11:25:06 -0600
Message-ID: <CAErSpo4Gw7aH0uDcnfgCGRPTvsUxerUDux84turNMYwns=F=ow@mail.gmail.com>
Subject: Re: [PATCH] PCI: fix trivial comment for __pci_disable_link_state
To: Yijing Wang <wangyijing@huawei.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, Jiang Liu <liuj97@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 28, 2013 at 2:03 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> Fix trivial comments for __pci_disble_link_state
>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/pcie/aspm.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)

Applied (with typo fixes and expanded comment) to pci/misc for v3.11, thanks.

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index faa83b6..c7fd56b 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -714,10 +714,6 @@ void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
>         up_read(&pci_bus_sem);
>  }
>
> -/*
> - * pci_disable_link_state - disable pci device's link state, so the link will
> - * never enter specific states
> - */
>  static void __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem,
>                                      bool force)
>  {
> @@ -771,6 +767,12 @@ void pci_disable_link_state_locked(struct pci_dev *pdev, int state)
>  }
>  EXPORT_SYMBOL(pci_disable_link_state_locked);
>
> +/**
> + * pci_disable_link_state - disable pci device's link state, so the link will
> + * never enter specific states
> + * @pdev: PCI device on the link.
> + * @state: ASPM link state to disable
> + */
>  void pci_disable_link_state(struct pci_dev *pdev, int state)
>  {
>         __pci_disable_link_state(pdev, state, true, false);
> --
> 1.7.1
>
>
