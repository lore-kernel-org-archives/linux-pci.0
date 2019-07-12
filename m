Return-Path: <SRS0=xwzY=VJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E74C742BB
	for <linux-pci@archiver.kernel.org>; Fri, 12 Jul 2019 13:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B59D20863
	for <linux-pci@archiver.kernel.org>; Fri, 12 Jul 2019 13:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562936684;
	bh=4mBrSCUacgKVLtxc4StkbHFSAntgLgFfjJ86zJptCjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EhgitmLJvD+RzRCYvro9Q/2vIM3P9SZCtZ/Y0R2gRBCt0x4NnbarpwifNUfS3HVMg
	 +GxvFeaZ9gdA0aFFowmV88RUCh+bdDpZOQ/zb4ZBuBW4wPxi69t3DtwRa0p1UYcgy7
	 KU3XmUGJ2v3YdxFiPE1YmM0gb9zCgie10jnpkh0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfGLNEk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Jul 2019 09:04:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbfGLNEk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Jul 2019 09:04:40 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 281FD20863;
        Fri, 12 Jul 2019 13:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562936679;
        bh=4mBrSCUacgKVLtxc4StkbHFSAntgLgFfjJ86zJptCjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ANs7T0gODRypAqdeOVjXW4pmd5cpxWecO09Oor0igSqbRbcqXHXVVOoPiYwTlB6k3
         gyFB5I9EEvClzLXwuJxpyr5l/Y6nxXSzG75t5mTXBTlOPdSCg3txM5Sx/pr+0BkYtW
         8pTNdOovB0xUeO+Sy5ZwARMLjWGMxqGe8Xo29I70=
Date:   Fri, 12 Jul 2019 08:04:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Chocron <jonnyc@amazon.com>
Cc:     lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, robh+dt@kernel.org,
        mark.rutland@arm.com, dwmw@amazon.co.uk, benh@kernel.crashing.org,
        alisaidi@amazon.com, ronenk@amazon.com, barakw@amazon.com,
        talel@amazon.com, hanochu@amazon.com, hhhawa@amazon.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/8] PCI: Add Amazon's Annapurna Labs vendor ID
Message-ID: <20190712130437.GB46935@google.com>
References: <20190710164519.17883-1-jonnyc@amazon.com>
 <20190710164519.17883-2-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710164519.17883-2-jonnyc@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 11, 2019 at 05:53:31PM +0300, Jonathan Chocron wrote:
> Add Amazon's Annapurna Labs vendor ID to pci_ids.h.
> 
> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 0dd239f11e91..ed350fd522c6 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2568,6 +2568,8 @@
>  
>  #define PCI_VENDOR_ID_ASMEDIA		0x1b21
>  
> +#define PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS	0x1c36
> +
>  #define PCI_VENDOR_ID_CIRCUITCO		0x1cc8
>  #define PCI_SUBSYSTEM_ID_CIRCUITCO_MINNOWBOARD	0x0001
>  
> -- 
> 2.17.1
> 
> 
