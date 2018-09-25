Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E3FC43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 15:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E90020C0A
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 15:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E90020C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbeIYVoO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:44:14 -0400
Received: from verein.lst.de ([213.95.11.211]:33106 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729306AbeIYVoN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 17:44:13 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 43FB068AFE; Tue, 25 Sep 2018 17:36:09 +0200 (CEST)
Date:   Tue, 25 Sep 2018 17:36:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     xiangxia.m.yue@gmail.com
Cc:     helgaas@kernel.org, hch@lst.de, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: msi: return error code instead of only warn
Message-ID: <20180925153609.GB404@lst.de>
References: <1537797641-6868-1-git-send-email-xiangxia.m.yue@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537797641-6868-1-git-send-email-xiangxia.m.yue@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 24, 2018 at 07:00:41AM -0700, xiangxia.m.yue@gmail.com wrote:
> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> 
> The drivers may enable the msi/msix more than once.
> Actually, this is the driver bug. But the bug may panic
> the kernel and should be fixed. We can return the error
> code instead of WARN_ON, to tell the drivers that the
> msi/msix is already enabled.
> 
> When enable them again, the call tree is shown on kernel
> 3.10.0, but linux upstream in the same way.

You can use up to 73 characters per line for your changelog, and doing so
makes it a little more readable.

> +	if (WARN_ON_ONCE(!!dev->msi_enabled))
> +		return  -EINVAL;
> +
>  	nvec = pci_msi_vec_count(dev);
>  	if (nvec < 0)
>  		return nvec;
> @@ -1087,6 +1087,9 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
>  	if (maxvec < minvec)
>  		return -ERANGE;
>  
> +	if (WARN_ON_ONCE(!!dev->msix_enabled))
> +		return  -EINVAL;
> +

You can drop the "!!", WARN_ON_ONCE will do the implicit bool conversion
for you.

Except for that the patch looks good to me.
