Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF77DC67839
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 15:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6AA020870
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 15:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544714285;
	bh=WgWmozlRCMUjMdZXfuezx91DaoKxzC3HrnEGX8IAsl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I9s5lEUFPG6fb4yRsoafH7NVTLLTG4njq78xkT5L5AtV0ICy/pfMEHbeBduP8dLoI
	 Kee7hy5Xo3qgCpmPOejo0QHN+DTQPjlnmBZTD7TMiO0/8A5nICShHK7N8P46MpxHrb
	 BUEabuD9FY2edh72WPZacAbiejRdd1S/072kJ61E=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6AA020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbeLMPR6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:17:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:52340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729322AbeLMPR6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Dec 2018 10:17:58 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 828CD20851;
        Thu, 13 Dec 2018 15:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544714277;
        bh=WgWmozlRCMUjMdZXfuezx91DaoKxzC3HrnEGX8IAsl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xGMWHtScntu6bqUoExiiBr6ucHlrMaJfC50tGTyrBqh25LbahibznQFsB2Gozfvrd
         ugg8pKh8SrvtpcMYhnY47xadNuicp74q08Os7oNuNGUM9dfIUcec2xp/nmCZ3Qbd/C
         m+V2udK4wyD+Hui29eLQtCnf6qlxI0TqTDzHinBw=
Date:   Thu, 13 Dec 2018 09:17:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wesley Sheng <wesley.sheng@microchip.com>
Cc:     kurt.schwemmer@microsemi.com, logang@deltatee.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        wesleyshenggit@sina.com
Subject: Re: [PATCH 5/5] switchtec: MRPC DMA mode implementation
Message-ID: <20181213151756.GD4701@google.com>
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

>  static void init_pff(struct switchtec_dev *stdev)
> @@ -1294,6 +1367,19 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
>  
>  	pci_set_drvdata(pdev, stdev);
>  
> +	if (!use_dma_mrpc)
> +		return 0;
> +
> +	if (!(ioread32(&stdev->mmio_mrpc->dma_ver) ? true : false))
> +		return 0;

This is ... harder to decode than necessary.  It's obvious that the
intent is to return if the adapter firmware doesn't support DMA, but I
lost interest before I could verify that it works as intended.

Bjorn
