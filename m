Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:59592 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab3HZVTN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Aug 2013 17:19:13 -0400
Received: by mail-ie0-f173.google.com with SMTP id qa5so2313115ieb.4
        for <linux-pci@vger.kernel.org>; Mon, 26 Aug 2013 14:19:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1377505986-7484-1-git-send-email-wangyijing@huawei.com>
References: <1377505986-7484-1-git-send-email-wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 26 Aug 2013 15:18:52 -0600
Message-ID: <CAErSpo68mhYOrYW6PWe7Tj9RY8ZBK6JkaFP7s=L3LtCVdOMr7A@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] PCI: Fix comment syntax
To: Yijing Wang <wangyijing@huawei.com>
Cc: Jon Mason <jdmason@kudzu.us>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 26, 2013 at 2:33 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> From: Jon Mason <jdmason@kudzu.us>
>
> Correct minor wording issue in MPS Peer-to-peer comment.
>
> Noticed by Don Dutile
>
> Signed-off-by: Jon Mason <jdmason@kudzu.us>

Applied to pci/yijing-mps-v8

> ---
>  drivers/pci/probe.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0e8cff2..21ca9a1 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1625,7 +1625,7 @@ void pcie_bus_configure_settings(struct pci_bus *bus)
>                 return;
>
>         /* FIXME - Peer to peer DMA is possible, though the endpoint would need
> -        * to be aware to the MPS of the destination.  To work around this,
> +        * to be aware of the MPS of the destination.  To work around this,
>          * simply force the MPS of the entire system to the smallest possible.
>          */
>         if (pcie_bus_config == PCIE_BUS_PEER2PEER)
> --
> 1.7.1
>
>
