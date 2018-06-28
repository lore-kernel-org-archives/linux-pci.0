Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50618 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932186AbeF1RIh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Jun 2018 13:08:37 -0400
Date: Thu, 28 Jun 2018 18:08:33 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Colin King <colin.king@canonical.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devel@linuxdriverproject.org, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: hv: fix spelling mistake: "reqquest" -> "request"
Message-ID: <20180628170833.GB17808@e107981-ln.cambridge.arm.com>
References: <20180508214946.19772-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180508214946.19772-1-colin.king@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 08, 2018 at 10:49:46PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in dev_err error message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi Colin,

patch change was superseded, I will drop it from patchwork, thanks
for sending it anyway.

Lorenzo

> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 50cdefe3f6d3..7e93b4ffb162 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -2071,7 +2071,7 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev)
>  				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  		if (ret) {
>  			dev_err(&hdev->device,
> -				"PCI Pass-through VSP failed sending version reqquest: %#x",
> +				"PCI Pass-through VSP failed sending version request: %#x",
>  				ret);
>  			goto exit;
>  		}
> -- 
> 2.17.0
> 
