Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F834C433EF
	for <linux-pci@archiver.kernel.org>; Thu, 24 Feb 2022 11:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbiBXLIC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Feb 2022 06:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiBXLIB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 06:08:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A10BCBE;
        Thu, 24 Feb 2022 03:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s+oFl0vWOonHrwSeNZUFJERIhMF8rGA7uA4JM5TBN7w=; b=kUxeBvzUY8AgM2GJqaBNyJArtC
        oWGIfnZ7fCzvbuMYVQKU3nmSVqj2tgX3kCOHKuUet29L7jbWdWLcNs+2p7QaHrX8MjRjhs9Duaf2m
        7y3OFKdiLqusIlJeagvoxhlI4Mrdf7Xc8BidDGH5f6wrLA23HUDWbnLWN/t2kOthuBT9+ukwjLKam
        LbrIsB2We6OlEkLsGiL5g/YROcfuPnt2z+cwOniJNujNctFCflqAIXMJR1rW14mRjxPhrOQ0nT+/y
        rJ4shbiDjvQgRYLZ3xnnz/In0K8UU03fDxamtI6ngc+VhUTCTeuqpS5H/NKSzt/COYWkxIspEPmpt
        2aAPQL2Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNBxz-000UeP-EV; Thu, 24 Feb 2022 11:07:23 +0000
Date:   Thu, 24 Feb 2022 03:07:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     helgaas@kernel.org, corbet@lwn.net, jarkko.nikula@linux.intel.com,
        andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        rric@kernel.org, bhelgaas@google.com, wsa@kernel.org,
        Sanket.Goswami@amd.com, linux-doc@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7 1/4] PCI: Introduce pcim_alloc_irq_vectors()
Message-ID: <Yhdm68HzOHhGNK4k@infradead.org>
References: <20210607153916.1021016-1-zhengdejin5@gmail.com>
 <20210607153916.1021016-2-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607153916.1021016-2-zhengdejin5@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 07, 2021 at 11:39:13PM +0800, Dejin Zheng wrote:
> Introduce pcim_alloc_irq_vectors(), a device-managed version of
> pci_alloc_irq_vectors(). Introducing this function can simplify
> the error handling path in many drivers.

How does it do that when it just is a trivial wrapper erroring out
for the unmanaged case?
