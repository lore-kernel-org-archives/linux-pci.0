Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:54972 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbbAWXW0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jan 2015 18:22:26 -0500
Received: by mail-ob0-f178.google.com with SMTP id nt9so186506obb.9
        for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2015 15:22:26 -0800 (PST)
Date: Fri, 23 Jan 2015 17:22:23 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>
Subject: Re: [PATCH] PCI: xgene: Include clk.h instead of clk-private.h
Message-ID: <20150123232223.GU29776@google.com>
References: <1421954754-3217-1-git-send-email-sboyd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421954754-3217-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 22, 2015 at 11:25:54AM -0800, Stephen Boyd wrote:
> This driver should be including clk.h as it's a clock consumer,
> not a clock provider that needs to register clocks early.
> 
> Cc: Tanmay Inamdar <tinamdar@apm.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Applied provisionally to pci/host-xgene for v3.20, thanks!

I'm hoping for an ack from Tanmay.

> ---
>  drivers/pci/host/pci-xgene.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> index b1d0596457c5..fdb348d3ccd3 100644
> --- a/drivers/pci/host/pci-xgene.c
> +++ b/drivers/pci/host/pci-xgene.c
> @@ -16,7 +16,7 @@
>   * GNU General Public License for more details.
>   *
>   */
> -#include <linux/clk-private.h>
> +#include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/jiffies.h>
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
