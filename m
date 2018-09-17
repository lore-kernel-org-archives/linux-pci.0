Return-Path: <SRS0=obOR=L7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92610ECE563
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 15:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5791F214C2
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 15:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5791F214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbeIQU3E (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:29:04 -0400
Received: from foss.arm.com ([217.140.101.70]:60546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728016AbeIQU3E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Sep 2018 16:29:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFA51ED1;
        Mon, 17 Sep 2018 08:01:21 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A0563F5BD;
        Mon, 17 Sep 2018 08:01:20 -0700 (PDT)
Date:   Mon, 17 Sep 2018 16:01:17 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Subject: Re: [PATCH] PCI: iproc: Remove PAXC slot check to allow VF support
Message-ID: <20180917150117.GG7239@e107981-ln.cambridge.arm.com>
References: <20180828172258.76629-1-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828172258.76629-1-ray.jui@broadcom.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180917150117.Z0qCbDvwIXYIWaR-03diThiBQKbd47XnhL82mdcsoNI@z>

On Tue, Aug 28, 2018 at 10:22:58AM -0700, Ray Jui wrote:
> From: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
> 
> Fix previous incorrect logic that limits PAXC slot number to zero only.
> In order for SRIOV/VF to work, we need to allow the slot number to be
> greater than zero.
> 
> Fixes: 46560388c476c ("PCI: iproc: Allow multiple devices except on PAXC")
> Signed-off-by: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> ---
>  drivers/pci/controller/pcie-iproc.c | 8 --------
>  1 file changed, 8 deletions(-)

Applied to pci/iproc for v4.20, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index 3160e9342a2f..c20fd6bd68fd 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -630,14 +630,6 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct iproc_pcie *pcie,
>  			return (pcie->base + offset);
>  	}
>  
> -	/*
> -	 * PAXC is connected to an internally emulated EP within the SoC.  It
> -	 * allows only one device.
> -	 */
> -	if (pcie->ep_is_internal)
> -		if (slot > 0)
> -			return NULL;
> -
>  	return iproc_pcie_map_ep_cfg_reg(pcie, busno, slot, fn, where);
>  }
>  
> -- 
> 2.17.1
> 
