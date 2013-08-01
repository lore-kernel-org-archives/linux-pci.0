Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:57231 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755708Ab3HARFK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Aug 2013 13:05:10 -0400
Received: by mail-ob0-f173.google.com with SMTP id ta17so4361537obb.18
        for <linux-pci@vger.kernel.org>; Thu, 01 Aug 2013 10:05:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1375362327-25404-1-git-send-email-wangyijing@huawei.com>
References: <1375362327-25404-1-git-send-email-wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 1 Aug 2013 11:04:49 -0600
Message-ID: <CAErSpo5Z-UQrXu_M1aMK5w++7P6EW-WDCG0qMPbvh9g8bLeT0w@mail.gmail.com>
Subject: Re: [PATCH] PCI/trivial: Fix comment typo for pci_add_cap_save_buffer()
To: Yijing Wang <wangyijing@huawei.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 1, 2013 at 7:05 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> Fix trivial comment typo for pci_add_cap_save_buffer().
>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

Applied to pci/misc for v3.12, thanks!

> ---
>  drivers/pci/pci.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a599a6b..a8d5fd0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1992,7 +1992,7 @@ static void pci_add_saved_cap(struct pci_dev *pci_dev,
>  }
>
>  /**
> - * pci_add_save_buffer - allocate buffer for saving given capability registers
> + * pci_add_cap_save_buffer - allocate buffer for saving given capability registers
>   * @dev: the PCI device
>   * @cap: the capability to allocate the buffer for
>   * @size: requested size of the buffer
> --
> 1.7.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
