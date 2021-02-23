Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4E2C433E6
	for <linux-pci@archiver.kernel.org>; Tue, 23 Feb 2021 08:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C460264E4B
	for <linux-pci@archiver.kernel.org>; Tue, 23 Feb 2021 08:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhBWID4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Feb 2021 03:03:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232147AbhBWIDl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Feb 2021 03:03:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C976264DAF;
        Tue, 23 Feb 2021 08:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614067381;
        bh=jPx4LV2bldX3/+xhN+fFDKFW8lIjZrChpQM5Wnm09qQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YAQTMxw9sO/cekq6q7hkeSF9CuLk9KpT6pOH/OQcYRvwNWGOAIi5b4stdL9qLr2FJ
         MAr2cxJ0XMh0jyNPWgJ4yjgqLP2i9WHzk9zdRSw8u/xl+run4OV9mA2bCsdOAkyuyW
         M22hTM3begRWf8Uh731HentmfuP09gIg7wBoioqIRmuSnHX9YIuRBn2hcbXPF7JX/r
         mXDlG+3r59M5d+g79YGJmNUuRToBeYO6Ybfza7C1EQIlkVrsGxoO9rnfpWBDdWiKDP
         O+unDD0TL7w4MxTYAtSpkHl4F0zSxVAJRGDVtAWCDaXn/8KLPhC8ml/iZhlkRltpdY
         75p+g2z6DMmkw==
Date:   Tue, 23 Feb 2021 09:02:54 +0100
From:   Robert Richter <rric@kernel.org>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     corbet@lwn.net, jarkko.nikula@linux.intel.com,
        andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        bhelgaas@google.com, wsa@kernel.org, linux-doc@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] PCI: Introduce pcim_alloc_irq_vectors()
Message-ID: <YDS2rkJu7PTJJiZr@rric.localdomain>
References: <20210218150458.798347-1-zhengdejin5@gmail.com>
 <20210218150458.798347-2-zhengdejin5@gmail.com>
 <YC/NxfsQn2RKkrp8@rric.localdomain>
 <20210219164649.GA814637@nuc8i5>
 <YDONyMSHO9FDeY69@rric.localdomain>
 <20210222151415.GA896979@nuc8i5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222151415.GA896979@nuc8i5>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22.02.21 23:14:15, Dejin Zheng wrote:
> On Mon, Feb 22, 2021 at 11:56:08AM +0100, Robert Richter wrote:
> > On 20.02.21 00:46:49, Dejin Zheng wrote:
> > > > On 18.02.21 23:04:55, Dejin Zheng wrote:
> > 
> > > > > +	if (!dr || !dr->enabled)
> > > here checks whether the pci device is enabled.
> > 
> > What is the purpose of this? The device "is_managed" or not.
> >
> The device is managed or not by check whether "dr" is NULL. And
> check the "dr->enabled" is for the PCI device enable. I think it
> may not make sense to apply for irq vectors when PCI device is not
> enabled.

I don't see how a disabled device affects in any way the release of
the irq vectors during device removal. dr is always non-null in case
the device is managed, a check isn't needed for that.

-Robert
