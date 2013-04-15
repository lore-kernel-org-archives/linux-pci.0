Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:61636 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753547Ab3DOP1m (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2013 11:27:42 -0400
Received: by mail-ob0-f177.google.com with SMTP id 16so2126305obc.22
        for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2013 08:27:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1366009135-19088-1-git-send-email-wangyijing@huawei.com>
References: <1366009135-19088-1-git-send-email-wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 15 Apr 2013 09:27:21 -0600
Message-ID: <CAErSpo7dgFR8a7Wee4CE7Rj+nZg_-+8uNOFq__d8EzY+gHQHGQ@mail.gmail.com>
Subject: Re: [PATCH -v2 1/2] PCI: decrease pci_dev->enable_cnt when no pcie
 capability found
To: Yijing Wang <wangyijing@huawei.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Shengzhou Liu <Shengzhou.Liu@freescale.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Huang Ying <ying.huang@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rafael, Huang]

On Mon, Apr 15, 2013 at 12:58 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> We should decrease dev->enable_cnt when no pcie port capability
> found for balance.
>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Cc: Jiang Liu <jiang.liu@huawei.com>
> Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> Cc: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
>  drivers/pci/pcie/portdrv_core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 31063ac..aef3fac 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -369,8 +369,8 @@ int pcie_port_device_register(struct pci_dev *dev)
>
>         /* Get and check PCI Express port services */
>         capabilities = get_port_device_capability(dev);
> -       if (!capabilities)
> -               return 0;
> +       if (!capabilities)
> +               goto error_disable;
>
>         pci_set_master(dev);
>         /*

Does this fix a problem you observed?  If so, please refer to it in
your changelog.

I think this patch is incorrect because pcie_portdrv_probe() will
return 0 (success) with the device disabled.  When we call
pcie_portdrv_remove(), we will attempt to disable the device again,
even though it's already disabled.

I don't know whether it is desirable for pcie_portdrv_probe() to
succeed when no capabilities are available or not.  Maybe somebody
else has an opinion.

Bjorn
