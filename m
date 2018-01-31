Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:34945 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751899AbeAaPJ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Jan 2018 10:09:56 -0500
Received: by mail-ua0-f195.google.com with SMTP id n1so8135453uaa.2
        for <linux-pci@vger.kernel.org>; Wed, 31 Jan 2018 07:09:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1515104268-25087-3-git-send-email-Felix.Kuehling@amd.com>
References: <1515104268-25087-1-git-send-email-Felix.Kuehling@amd.com> <1515104268-25087-3-git-send-email-Felix.Kuehling@amd.com>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Wed, 31 Jan 2018 17:09:25 +0200
Message-ID: <CAFCwf10ZggYwRvriFkCH=HtSU8eANkF-fsVVxbreJS_maJx26Q@mail.gmail.com>
Subject: Re: [PATCH 2/9] drm/amdkfd: Conditionally enable PCIe atomics
To: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 5, 2018 at 12:17 AM, Felix Kuehling <Felix.Kuehling@amd.com> wrote:
> This will be needed for most dGPUs.
>
> CC: linux-pci@vger.kernel.org
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 17 +++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  1 +
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index a8fa33a..fafe971 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -41,6 +41,7 @@ static const struct kfd_device_info kaveri_device_info = {
>         .num_of_watch_points = 4,
>         .mqd_size_aligned = MQD_SIZE_ALIGNED,
>         .supports_cwsr = false,
> +       .needs_pci_atomics = false,
>  };
>
>  static const struct kfd_device_info carrizo_device_info = {
> @@ -53,6 +54,7 @@ static const struct kfd_device_info carrizo_device_info = {
>         .num_of_watch_points = 4,
>         .mqd_size_aligned = MQD_SIZE_ALIGNED,
>         .supports_cwsr = true,
> +       .needs_pci_atomics = false,
>  };
>
>  struct kfd_deviceid {
> @@ -127,6 +129,21 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
>                 return NULL;
>         }
>
> +       if (device_info->needs_pci_atomics) {
> +               /* Allow BIF to recode atomics to PCIe 3.0
> +                * AtomicOps. 32 and 64-bit requests are possible and
> +                * must be supported.
> +                */
> +               if (pci_enable_atomic_ops_to_root(pdev,
> +                               PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> +                               PCI_EXP_DEVCAP2_ATOMIC_COMP64) < 0) {
> +                       dev_info(kfd_device,
> +                               "skipped device %x:%x, PCI rejects atomics",
> +                                pdev->vendor, pdev->device);
> +                       return NULL;
> +               }
> +       }
> +
>         kfd = kzalloc(sizeof(*kfd), GFP_KERNEL);
>         if (!kfd)
>                 return NULL;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 6a48d29..eebfb1e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -158,6 +158,7 @@ struct kfd_device_info {
>         uint8_t num_of_watch_points;
>         uint16_t mqd_size_aligned;
>         bool supports_cwsr;
> +       bool needs_pci_atomics;
>  };
>
>  struct kfd_mem_obj {
> --
> 2.7.4
>
This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
