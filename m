Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:62342 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbaDVBel (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Apr 2014 21:34:41 -0400
Received: by mail-ob0-f180.google.com with SMTP id wm4so5013205obc.39
        for <linux-pci@vger.kernel.org>; Mon, 21 Apr 2014 18:34:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1397000541-1085-2-git-send-email-keith.busch@intel.com>
References: <1397000541-1085-1-git-send-email-keith.busch@intel.com> <1397000541-1085-2-git-send-email-keith.busch@intel.com>
From: Learner Study <learner.study@gmail.com>
Date: Mon, 21 Apr 2014 18:34:20 -0700
Message-ID: <CAP8+hKWcybw5u_m5M4c1p4eUAaTq4x+kO+tnegwD2ciDMEFNCw@mail.gmail.com>
Subject: Re: [PATCH 2/2] NVMe: Implement PCI-e reset notification callback
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org,
	linux-nvme <linux-nvme@lists.infradead.org>, bhelgaas@google.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith,

I think NVMe Reset should apply to PF mode driver only, and not to VF
mode driver.
Is that understanding correct? Does the NVMe driver know which mode
its running in?

Thanks!


On Tue, Apr 8, 2014 at 4:42 PM, Keith Busch <keith.busch@intel.com> wrote:
>
> Disable and shutdown the device prior to reset, and restart the device
> after.
>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/block/nvme-core.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index 625259d..273ff12 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -2605,6 +2605,16 @@ static void nvme_reset_failed_dev(struct work_struct *ws)
>         nvme_dev_reset(dev);
>  }
>
> +static void nvme_reset_notify(struct pci_dev *pdev, int prepare)
> +{
> +       struct nvme_dev *dev = pci_get_drvdata(pdev);
> +
> +       if (prepare)
> +               nvme_dev_shutdown(dev);
> +       else
> +               nvme_dev_resume(dev);
> +}
> +
>  static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>         int result = -ENOMEM;
> @@ -2744,6 +2754,7 @@ static const struct pci_error_handlers nvme_err_handler = {
>         .link_reset     = nvme_link_reset,
>         .slot_reset     = nvme_slot_reset,
>         .resume         = nvme_error_resume,
> +       .reset_notify   = nvme_reset_notify,
>  };
>
>  /* Move to pci_ids.h later */
> --
> 1.7.10.4
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://merlin.infradead.org/mailman/listinfo/linux-nvme
