Return-Path: <SRS0=lgj/=OY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C765C43387
	for <linux-pci@archiver.kernel.org>; Sat, 15 Dec 2018 17:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E562206C2
	for <linux-pci@archiver.kernel.org>; Sat, 15 Dec 2018 17:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aabPugNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeLORq6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 15 Dec 2018 12:46:58 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46105 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeLORq6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 Dec 2018 12:46:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so4345730pfe.13;
        Sat, 15 Dec 2018 09:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xNcNXk3nK/gFm08G0JiFWRjYDVrwTGUYpbu9Hf71oz4=;
        b=aabPugNQFwMWvUir9rBIxFHUAZNlnAeEsHlzUxKSbf/n2yFvZToYx7nf+K83w3ZCfw
         U5mLmbO0ry7hQh0XA1+a54x2hE65b+D+vkwPgxnwVeaaJQ6Q7WlBzt0Q9hMzD5/r1QbI
         ya+HFngHA2bJGUeVFL94Jjnox0KYSUGlSVdmqs1coZO9aotMDVIRaVXoodxEzSb12jjE
         WnGNH59+Tar5DIqqQ1f+eOcTdhnaLbSUYGbx+AjqVRxQWQcJCYs9pTguvUffbxd8guxQ
         dHyD01ZLJx+2xPAOO5LOHw+T6SmlexedUJ6nASIoMfoybmFjt6mFzoaS/KYkjJNfdLT0
         GXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xNcNXk3nK/gFm08G0JiFWRjYDVrwTGUYpbu9Hf71oz4=;
        b=OUwCKq9MXkVI9qb+7HxCMebFQMWXizz0v12DqH3JV0I+jbJJ9l1P8S8Kulm2Y5NBB/
         Kes3lw4o2Dmt+G2e9stmBkR2Bdb2jtvQmNVjJx4Rya8nxqkdIrZXq/a++Xb3vitdcB2N
         WwuCeWIrLDGT1m3Op2er+/8/vIlOTppAknK5q8mKvAWJ0mcmlZEsVvAnvGeYkVjAW1Sy
         O6MdbO+oZA1c6+Wh6XL9ieV2eXQxeKpB4soLirGVaC8erNgZZn1cTADrbcyV7ijbVbw6
         eZOQ+0S+H4UyyKvcMNy3WLLuNJLhQU9JjD0t7ynusbPD3w0v5P09GfqvtZXHPaXSZfDZ
         YgMw==
X-Gm-Message-State: AA+aEWZxk2TEefDSQS6zBL09tFeAlDZobffEj2l2jQcHXYVbhTxijqw4
        s4YrrhfK9aG1gnMEsECmZQedNvh4
X-Google-Smtp-Source: AFSGD/VsA+4jOUCx1D5RgLtPj4D0Qeedxpakp7Nr7Xqp8GdQWVVZzSGR88U6FCukuB9U9ReJAoyQEg==
X-Received: by 2002:a63:9306:: with SMTP id b6mr6469513pge.36.1544896017178;
        Sat, 15 Dec 2018 09:46:57 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b68sm14267699pfg.160.2018.12.15.09.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 09:46:56 -0800 (PST)
Date:   Sat, 15 Dec 2018 09:46:54 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, linux-ia64@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [15/15] dma-mapping: bypass indirect calls for dma-direct
Message-ID: <20181215174654.GA25694@roeck-us.net>
References: <20181207190720.18517-16-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207190720.18517-16-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Fri, Dec 07, 2018 at 11:07:20AM -0800, Christoph Hellwig wrote:
> Avoid expensive indirect calls in the fast path DMA mapping
> operations by directly calling the dma_direct_* ops if we are using
> the directly mapped DMA operations.
> 

This patch results in arm64 boot failures. Reverting the patch fixes
the problem. Bisect results are attached. Per logs, the system fails
to instantiate the root device. Examples from two logs:

[   22.843080] nvme nvme0: pci function 0000:00:02.0
[   22.853820] nvme 0000:00:02.0: enabling device (0000 -> 0002)
[   22.884178] nvme nvme0: Removing after probe failure status: -12

[   15.451963] xhci_hcd 0000:00:02.0: xHCI Host Controller
[   15.453294] xhci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
[   15.456042] xhci_hcd 0000:00:02.0: can't setup: -12
[   15.457003] xhci_hcd 0000:00:02.0: USB bus 1 deregistered
[   15.458340] xhci_hcd 0000:00:02.0: init 0000:00:02.0 fail, -12
[   15.458825] xhci_hcd: probe of 0000:00:02.0 failed with error -12

Guenter

---
# bad: [d14b746c6c1ca310f679ef13f661587454e2c588] Add linux-next specific files for 20181214
# good: [40e020c129cfc991e8ab4736d2665351ffd1468d] Linux 4.20-rc6
git bisect start 'HEAD' 'v4.20-rc6'
# bad: [ddfdda7f7d1ebdca0851f30a814e76749f08be99] Merge remote-tracking branch 'spi-nor/spi-nor/next'
git bisect bad ddfdda7f7d1ebdca0851f30a814e76749f08be99
# bad: [466d2f8b964745cc8db7f126607e19526385f2d5] Merge remote-tracking branch 'file-locks/locks-next'
git bisect bad 466d2f8b964745cc8db7f126607e19526385f2d5
# bad: [c43abf670f074a3eba2eebf9568ba95b2fe57f00] Merge remote-tracking branch 'arm-soc/for-next'
git bisect bad c43abf670f074a3eba2eebf9568ba95b2fe57f00
# good: [e4337d9d50eb940a25d3808ef76bb0eaa61a0146] Merge branch 'next/dt' into for-next
git bisect good e4337d9d50eb940a25d3808ef76bb0eaa61a0146
# bad: [32d851d8e81b1152d3e663b6c0b318474d649098] Merge remote-tracking branch 'dma-mapping/for-next'
git bisect bad 32d851d8e81b1152d3e663b6c0b318474d649098
# good: [32550839013d8e72d35c1cc0a756c818d7f9ae32] Merge remote-tracking branch 'scsi-fixes/fixes'
git bisect good 32550839013d8e72d35c1cc0a756c818d7f9ae32
# good: [8ea3ac17b6557f30697c624d1cd4ff2b30af82e1] Merge remote-tracking branch 'kbuild/for-next'
git bisect good 8ea3ac17b6557f30697c624d1cd4ff2b30af82e1
# good: [ad78dee0b630527bdfed809d1f5ed95c601886ae] dma-debug: Batch dma_debug_entry allocation
git bisect good ad78dee0b630527bdfed809d1f5ed95c601886ae
# good: [55897af63091ebc2c3f239c6a6666f748113ac50] dma-direct: merge swiotlb_dma_ops into the dma_direct code
git bisect good 55897af63091ebc2c3f239c6a6666f748113ac50
# good: [7d32be2e5abb2d88cf321357178d05c461b1cc83] leaking_addresses: do not parse binary files
git bisect good 7d32be2e5abb2d88cf321357178d05c461b1cc83
# good: [9db33987ee2e5abb32a40dca44a2953391786833] leaking_addresses: remove version number
git bisect good 9db33987ee2e5abb32a40dca44a2953391786833
# good: [7fd0d1346c1f96371a9a4996a590b86d570098f9] Merge remote-tracking branch 'leaks/leaks-next'
git bisect good 7fd0d1346c1f96371a9a4996a590b86d570098f9
# bad: [356da6d0cde3323236977fce54c1f9612a742036] dma-mapping: bypass indirect calls for dma-direct
git bisect bad 356da6d0cde3323236977fce54c1f9612a742036
# good: [190d4e5916a2d70a11009022b968fca948fb5dc7] vmd: use the proper dma_* APIs instead of direct methods calls
git bisect good 190d4e5916a2d70a11009022b968fca948fb5dc7
# first bad commit: [356da6d0cde3323236977fce54c1f9612a742036] dma-mapping: bypass indirect calls for dma-direct
