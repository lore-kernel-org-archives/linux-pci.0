Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:46092 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764252AbdJQUZ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2017 16:25:56 -0400
Received: by mail-vk0-f66.google.com with SMTP id k123so1962155vkb.3
        for <linux-pci@vger.kernel.org>; Tue, 17 Oct 2017 13:25:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508271773-17827-1-git-send-email-dmeyer@gigaio.com>
References: <1508271773-17827-1-git-send-email-dmeyer@gigaio.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 17 Oct 2017 16:25:54 -0400
Message-ID: <CAPoiz9y-6kyjF1ypt7p+7K6E-m55_Fra5hgFYy--5YXz7V2PdQ@mail.gmail.com>
Subject: Re: [PATCH] NTB: ntb_hw_switchtec: Fix peer BAR bug in switchtec_ntb_init_shared_mw
To: D Meyer <dmeyer@gigaio.com>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        stephen.bates@microsemi.com, Logan Gunthorpe <logang@deltatee.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Hubbe, Allen" <Allen.Hubbe@emc.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-ntb@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 17, 2017 at 4:22 PM,  <dmeyer@gigaio.com> wrote:
> From: Doug Meyer <dmeyer@gigaio.com>
>
> This resolves a bug which may incorrectly configure the peer host's
> LUT for shared memory window access. The code was using the local
> host's first BAR number, rather than the peer hosts's first BAR
> number, to determine what peer NT control register to program.
>
> The bug will cause the Switchtec NTB link to work only if both peers
> have the same first NTB BAR configured. In all other configurations,
> the link will not come up, failing silently.
>
> When both hosts have the same first BAR, the configuration works only
> because the first BAR numbers happent to be the same. When the hosts
> do not have the same first BAR, then the LUT translation will not be
> configured in the correct peer LUT and will not give the peer the
> shared memory window access required for the link to operate.
>
> Signed-off-by: Doug Meyer <dmeyer@gigaio.com>

Looks good to me.  I'd prefer to have a "Fixes: " here, but I can add
it if there are no other objections to this patch.

Thanks,
Jon

> ---
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> index afe8ed6..ca0334a 100644
> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> @@ -964,7 +964,8 @@ static void switchtec_ntb_init_shared(struct switchtec_ntb *sndev)
>  static int switchtec_ntb_init_shared_mw(struct switchtec_ntb *sndev)
>  {
>         struct ntb_ctrl_regs __iomem *ctl = sndev->mmio_peer_ctrl;
> -       int bar = sndev->direct_mw_to_bar[0];
> +       int self_bar = sndev->direct_mw_to_bar[0];
> +       int peer_bar = sndev->peer_direct_mw_to_bar[0];
>         u32 ctl_val;
>         int rc;
>
> @@ -985,12 +986,12 @@ static int switchtec_ntb_init_shared_mw(struct switchtec_ntb *sndev)
>         if (rc)
>                 goto unalloc_and_exit;
>
> -       ctl_val = ioread32(&ctl->bar_entry[bar].ctl);
> +       ctl_val = ioread32(&ctl->bar_entry[peer_bar].ctl);
>         ctl_val &= 0xFF;
>         ctl_val |= NTB_CTRL_BAR_LUT_WIN_EN;
>         ctl_val |= ilog2(LUT_SIZE) << 8;
>         ctl_val |= (sndev->nr_lut_mw - 1) << 14;
> -       iowrite32(ctl_val, &ctl->bar_entry[bar].ctl);
> +       iowrite32(ctl_val, &ctl->bar_entry[peer_bar].ctl);
>
>         iowrite64((NTB_CTRL_LUT_EN | (sndev->self_partition << 1) |
>                    sndev->self_shared_dma),
> @@ -1009,7 +1010,7 @@ static int switchtec_ntb_init_shared_mw(struct switchtec_ntb *sndev)
>                 goto unalloc_and_exit;
>         }
>
> -       sndev->peer_shared = pci_iomap(sndev->stdev->pdev, bar, LUT_SIZE);
> +       sndev->peer_shared = pci_iomap(sndev->stdev->pdev, self_bar, LUT_SIZE);
>         if (!sndev->peer_shared) {
>                 rc = -ENOMEM;
>                 goto unalloc_and_exit;
> --
> 1.8.3.1
>
