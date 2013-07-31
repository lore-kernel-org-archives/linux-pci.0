Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41202 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab3GaXb1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 31 Jul 2013 19:31:27 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd6so2555098obb.5
        for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2013 16:31:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1375278088-31260-1-git-send-email-sassmann@kpanic.de>
References: <1375278088-31260-1-git-send-email-sassmann@kpanic.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 31 Jul 2013 17:31:06 -0600
Message-ID: <CAErSpo7usQEGQOeDyY82vyObeRYsRb0btD=Rsr-nv+=qHu7D6Q@mail.gmail.com>
Subject: Re: [PATCH] pci: adjust return values for error cases of IOV functions
To: Stefan Assmann <sassmann@kpanic.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alex Duyck <alexander.h.duyck@intel.com>,
	Don Dutile <ddutile@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 31, 2013 at 7:41 AM, Stefan Assmann <sassmann@kpanic.de> wrote:
> Changing the return value to -ENOSYS if a device is not physical PCI function.
> Also have pci_sriov_get_totalvfs() return 0 in the error cae to make the
> behaviour consistent whether CONFIG_PCI_IOV is enabled or not.
> Some comment fixes.
>
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>

Applied to pci/misc for v3.12.  Thanks!

> ---
>  drivers/pci/iov.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index de8ffac..1fc9942 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -324,7 +324,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>
>                 if (!pdev->is_physfn) {
>                         pci_dev_put(pdev);
> -                       return -ENODEV;
> +                       return -ENOSYS;
>                 }
>
>                 rc = sysfs_create_link(&dev->dev.kobj,
> @@ -662,7 +662,7 @@ int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
>         might_sleep();
>
>         if (!dev->is_physfn)
> -               return -ENODEV;
> +               return -ENOSYS;
>
>         return sriov_enable(dev, nr_virtfn);
>  }
> @@ -722,7 +722,7 @@ EXPORT_SYMBOL_GPL(pci_num_vf);
>   * @dev: the PCI device
>   *
>   * Returns number of VFs belonging to this device that are assigned to a guest.
> - * If device is not a physical function returns -ENODEV.
> + * If device is not a physical function returns 0.
>   */
>  int pci_vfs_assigned(struct pci_dev *dev)
>  {
> @@ -767,12 +767,15 @@ EXPORT_SYMBOL_GPL(pci_vfs_assigned);
>   * device's mutex held.
>   *
>   * Returns 0 if PF is an SRIOV-capable device and
> - * value of numvfs valid. If not a PF with VFS, return -EINVAL;
> + * value of numvfs valid. If not a PF return -ENOSYS;
> + * if numvfs is invalid return -EINVAL;
>   * if VFs already enabled, return -EBUSY.
>   */
>  int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
>  {
> -       if (!dev->is_physfn || (numvfs > dev->sriov->total_VFs))
> +       if (!dev->is_physfn)
> +               return -ENOSYS;
> +       if (numvfs > dev->sriov->total_VFs)
>                 return -EINVAL;
>
>         /* Shouldn't change if VFs already enabled */
> @@ -786,17 +789,17 @@ int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
>  EXPORT_SYMBOL_GPL(pci_sriov_set_totalvfs);
>
>  /**
> - * pci_sriov_get_totalvfs -- get total VFs supported on this devic3
> + * pci_sriov_get_totalvfs -- get total VFs supported on this device
>   * @dev: the PCI PF device
>   *
>   * For a PCIe device with SRIOV support, return the PCIe
>   * SRIOV capability value of TotalVFs or the value of driver_max_VFs
> - * if the driver reduced it.  Otherwise, -EINVAL.
> + * if the driver reduced it.  Otherwise 0.
>   */
>  int pci_sriov_get_totalvfs(struct pci_dev *dev)
>  {
>         if (!dev->is_physfn)
> -               return -EINVAL;
> +               return 0;
>
>         if (dev->sriov->driver_max_VFs)
>                 return dev->sriov->driver_max_VFs;
> --
> 1.8.3.1
>
