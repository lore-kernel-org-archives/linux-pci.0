Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:50883 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128Ab3LSSTI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2013 13:19:08 -0500
Received: by mail-ie0-f172.google.com with SMTP id qd12so1840302ieb.17
        for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2013 10:19:08 -0800 (PST)
Date: Thu, 19 Dec 2013 11:19:05 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pci@vger.kernel.org, jason@lakedaemon.net,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH Resend 1/1] PCI: mvebu: Remove redundant of_match_ptr
Message-ID: <20131219181905.GA15201@google.com>
References: <1387443899-7149-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387443899-7149-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 19, 2013 at 02:34:59PM +0530, Sachin Kamat wrote:
> mvebu_pcie_of_match_table is always compiled in. Hence of_match_ptr is
> not required.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks, applied with Thomas's ack to pci/host-mvebu for v3.14.

Bjorn

> ---
>  drivers/pci/host/pci-mvebu.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index 533e0df02718..bedc0b1562b9 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -1012,8 +1012,7 @@ static struct platform_driver mvebu_pcie_driver = {
>  	.driver = {
>  		.owner = THIS_MODULE,
>  		.name = "mvebu-pcie",
> -		.of_match_table =
> -		   of_match_ptr(mvebu_pcie_of_match_table),
> +		.of_match_table = mvebu_pcie_of_match_table,
>  		/* driver unloading/unbinding currently not supported */
>  		.suppress_bind_attrs = true,
>  	},
> -- 
> 1.7.9.5
> 
