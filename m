Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA30C433B4
	for <linux-pci@archiver.kernel.org>; Mon, 26 Apr 2021 18:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9FCD613BD
	for <linux-pci@archiver.kernel.org>; Mon, 26 Apr 2021 18:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbhDZSUr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 26 Apr 2021 14:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbhDZSUq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Apr 2021 14:20:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF342C061574;
        Mon, 26 Apr 2021 11:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E3C4pfph80R4Pj5PGNlzdZfhkld0FgHj6ptMt/qt7jg=; b=YwdEHkQummZO6aFcElh23/lEDN
        CFFoFJBWo4gQBML0lCrczPEhY/pkBPptZCTDoYFN1Vgh+SgD4LKnnZ3c0oYNbWEbDbk2tyFerzlK3
        MBzGiCbXTlsyo/DiGc/KdZxO0SMSWa/OIZC46lH+6khXEBhdm/bGECZhv+dzP9yr7sqboUNW52y9z
        v1yd1Rviv9j5LFs81ft2ECQjcq59HBg3antlZDUBmzG+GB5/ZedGCbEMN7AR+nuBvYCopUCprCAkw
        QVEHlFTvJaiowWRcW4xVcgulpS+q8xdP0vpcwH2HStQwB5YY1rzo4xDwTAgfLaGsoLqIQQcBJEc52
        w6c8iFHA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lb5pf-005x4E-Gp; Mon, 26 Apr 2021 18:19:44 +0000
Date:   Mon, 26 Apr 2021 19:19:43 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Shanker R Donthineni <sdonthineni@nvidia.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Sinan Kaya <okaya@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH 1/1] PCI: Add pci reset quirk for Nvidia GPUs
Message-ID: <20210426181943.GA1418150@infradead.org>
References: <20210423145402.14559-1-sdonthineni@nvidia.com>
 <ff4812ba-ec1d-9462-0cbd-029635af3267@kernel.org>
 <20210423093701.594efd86@redhat.com>
 <c758d8a8-4f8b-c505-118e-b364e93ae539@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c758d8a8-4f8b-c505-118e-b364e93ae539@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 23, 2021 at 04:45:15PM -0500, Shanker R Donthineni wrote:
> > specific platforms (embedded device?), and the failure mode of the SBR.
> These are not plug-in PCIe GPU cards, will exist on upcoming
> server baseboards. Triggering SBR without firmware notification

Please submit the quirks together with the actual support for the GPUs
in the nouveau driver, as they are completely useless without that.
