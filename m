Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B727AC65BAF
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 22:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F09620870
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 22:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544655125;
	bh=trZ22U3D7b7sWDZJG9KhRvMX2v9Gex2HXhF0Y9cZKp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z5wM6974dJBlUkyForqW5Dp45yi5Q7FXv00zQ1SQmKDGNQt40cwKIjf0bWrm/kvBU
	 C/IFa5ErY1/Di4BOjg0Xrxu1WahJLaudd7C0UH9DrZW7OS8cyuNt/AAYlSIv2KkUA1
	 3ylC70rbN1SpeK5et96x9X0csa5hMstXhlmzH0+E=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F09620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbeLLWwE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:52:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:59986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbeLLWwE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Dec 2018 17:52:04 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5E2D20851;
        Wed, 12 Dec 2018 22:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544655123;
        bh=trZ22U3D7b7sWDZJG9KhRvMX2v9Gex2HXhF0Y9cZKp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zFgb4W4Fjl3AnPdHDoNscIFwPxWC47rjGtxuUeIhPo84ez7gN8SNjJniMhpIuiwbi
         sJtLKYipjHzDCz+P9tbXOjRGGnexVlbOHmsIOc2f2F7U/joUwEzSPjsDkOCiUAzbvv
         LjssoqQqF8zTbLbI5LHREmbdEpPxrzBVIWjRNCNw=
Date:   Wed, 12 Dec 2018 16:52:01 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wesley Sheng <wesley.sheng@microchip.com>
Cc:     kurt.schwemmer@microsemi.com, logang@deltatee.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        wesleyshenggit@sina.com
Subject: Re: [PATCH 5/5] switchtec: MRPC DMA mode implementation
Message-ID: <20181212225201.GL99796@google.com>
References: <1544433144-7563-1-git-send-email-wesley.sheng@microchip.com>
 <1544433144-7563-6-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544433144-7563-6-git-send-email-wesley.sheng@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 10, 2018 at 05:12:24PM +0800, Wesley Sheng wrote:
> MRPC normal mode requires the host to read the MRPC command status and
> output data from BAR. This results in high latency responses from the
> Memory Read TLP and potential Completion Timeout (CTO).
> 
> MRPC DMA mode implementation includes:
> Macro definitions for registers and data structures corresponding to
> MRPC DMA mode.
> 
> Add module parameter use_dma_mrpc to select between MRPC DMA mode and
> MRPC normal mode.
> 
> Add MRPC mode functionality to:
> * Retrieve MRPC DMA mode version
> * Allocate DMA buffer, ISR registration, and enable DMA function during
>   initialization
> * Check MRPC execution status and collect execution results from DMA buffer
> * Release DMA buffer and disable DMA function when unloading module
> 
> MRPC DMA mode is a new feature of firmware and the driver will fall back
> to MRPC normal mode if there is no support in the legacy firmware.
> 
> Include <linux/io-64-nonatomic-lo-hi.h> so that readq/writeq is replaced
> by two readl/writel on systems that do not support it.
> 
> Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/switch/switchtec.c | 108 +++++++++++++++++++++++++++++++++++++----
>  include/linux/switchtec.h      |  16 ++++++
>  2 files changed, 114 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 0b8862b..6b726cb 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -13,7 +13,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/poll.h>
>  #include <linux/wait.h>
> -
> +#include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/nospec.h>
>  
>  MODULE_DESCRIPTION("Microsemi Switchtec(tm) PCIe Management Driver");
> @@ -25,6 +25,11 @@ static int max_devices = 16;
>  module_param(max_devices, int, 0644);
>  MODULE_PARM_DESC(max_devices, "max number of switchtec device instances");
>  
> +static bool use_dma_mrpc = 1;
> +module_param(use_dma_mrpc, bool, 0644);
> +MODULE_PARM_DESC(use_dma_mrpc,
> +		 "Enable the use of the DMA MRPC feature");

What's the purpose of the module parameter?  Can't you automatically
figure out whether the firmware supports DMA mode?

Module parameters make life difficult for users and lead to code
that's rarely used and poorly tested, so I think we should avoid them
whenever we can.

If you *can't* automatically figure out when to use DMA, please make
it clear in the changelog that the "use_dma_mrpc" parameter is
required with legacy firmware.  And in that case, it seems like it
should be named "disable_dma" or similar, since it defaults to being
enabled.

Bjorn
