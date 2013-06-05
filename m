Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:61970 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755354Ab3FESb6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jun 2013 14:31:58 -0400
Received: by mail-oa0-f46.google.com with SMTP id h2so1428027oag.19
        for <linux-pci@vger.kernel.org>; Wed, 05 Jun 2013 11:31:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369974092-11450-1-git-send-email-jiang.liu@huawei.com>
References: <1369974092-11450-1-git-send-email-jiang.liu@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 5 Jun 2013 12:31:37 -0600
Message-ID: <CAErSpo6VeT24CRZG=x2cpW+j9-R+ZRyDjceGNtXPnDTS8vrGGQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: set correct value for iov device before device
To: Jiang Liu <liuj97@gmail.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Xudong Hao <xudong.hao@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 30, 2013 at 10:21 PM, Jiang Liu <liuj97@gmail.com> wrote:
> From: Xudong Hao <xudong.hao@intel.com>
>
> Commit 4f535093cf8f6da8 "PCI: Put pci_dev in device tree as early as
> possible" moves device registering from pci_bus_add_devices() to
> pci_device_add(). That change causes troubles to PCI virtual functions
> because device_add(&virtfn->dev) is called before setting
> virtfn->is_virtfn flag, which then causes Xen to report PCI virtual
> functions as PCI physical functions.
>
> So fix it by setting virtfn->is_virtfn before calling pci_device_add().
>
> [Jiang Liu]:
> move the setting of virtfn->is_virtfn ahead further for better readability
> and modify changelog.
>
> Signed-off-by: Xudong Hao <xudong.hao@intel.com>
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> Cc: <stable@vger.kernel.org> # 3.9+
> ---
> Hi Bjorn and Yinghai,
>     How about this? I split out the bugfix patch as separate patch
> so it could be easily back ported to stable branches.

Applied to my -next branch for v3.11, thanks!

> ---
>  drivers/pci/iov.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 5fffca9..de8ffac 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -82,6 +82,8 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
>         pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_DID, &virtfn->device);
>         pci_setup_device(virtfn);
>         virtfn->dev.parent = dev->dev.parent;
> +       virtfn->physfn = pci_dev_get(dev);
> +       virtfn->is_virtfn = 1;
>
>         for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>                 res = dev->resource + PCI_IOV_RESOURCES + i;
> @@ -103,9 +105,6 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
>         pci_device_add(virtfn, virtfn->bus);
>         mutex_unlock(&iov->dev->sriov->lock);
>
> -       virtfn->physfn = pci_dev_get(dev);
> -       virtfn->is_virtfn = 1;
> -
>         rc = pci_bus_add_device(virtfn);
>         sprintf(buf, "virtfn%u", id);
>         rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
> --
> 1.8.1.2
>
