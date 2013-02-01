Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:45546 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757994Ab3BAXEE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Feb 2013 18:04:04 -0500
Received: by mail-vc0-f178.google.com with SMTP id m8so2761309vcd.23
        for <linux-pci@vger.kernel.org>; Fri, 01 Feb 2013 15:04:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1359519038-25424-1-git-send-email-wangyijing@huawei.com>
References: <1359519038-25424-1-git-send-email-wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 1 Feb 2013 16:03:43 -0700
Message-ID: <CAErSpo7USGyv-cKRrUEOBFWggp5AdRw5w4a+ZZaXuOgKqqCq-Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: fix build warning in iov.c
To: Yijing Wang <wangyijing@huawei.com>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
	Hanjun Guo <guohanjun@huawei.com>, jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 29, 2013 at 9:10 PM, Yijing Wang <wangyijing@huawei.com> wrote:
> Delete unused variable rc to fix build warning in driver/pci/iov.c
>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

Applied to my pci/yinghai-root-bus-hotplug branch for v3.9.  Thanks!

Bjorn

> ---
>  drivers/pci/iov.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index f8720af..4ea7139 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -33,7 +33,6 @@ static inline u8 virtfn_devfn(struct pci_dev *dev, int id)
>
>  static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
>  {
> -       int rc;
>         struct pci_bus *child;
>
>         if (bus->number == busnr)
> --
> 1.7.1
>
>
