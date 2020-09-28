Return-Path: <SRS0=RmUR=DF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D2AC2D0A8
	for <linux-pci@archiver.kernel.org>; Mon, 28 Sep 2020 07:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 704862080C
	for <linux-pci@archiver.kernel.org>; Mon, 28 Sep 2020 07:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iZy1G5Kl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgI1HQl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Sep 2020 03:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgI1HQl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 03:16:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69418C0613CE
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2020 00:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PdTqHbxAzorkhof556wSIvFLOcjCvmNmWJ37riwkv0k=; b=iZy1G5KlOsR8Kg98/IUQqY0qbk
        MoOrq/XCdEtnJZn36cCANdP+W34PeKyjOP3qqSyyzcNmYeoqQp0w3z7HFcGBKHr02xc4bb8JHA4EY
        bOgIrZ7Ts70A6RatbQatSoZu6UcSfADnlai9R9VVlF+apAXd8d7TeiB8NC0FAnarZZiOMI/zSi0of
        VidjxugchMnEtcjXUfOfHRMx7DVmb/m2VNU5PQV3yoipdqlR3YI7GZ/unx+KGF2AO71mf4i9eJzXI
        Sco1zVbsi8PJxaSdnO9xzUUqBCbGYavFBXFOHdSEMdSsw/tDYIBYyrVRDqqmiXCcBAGrrQP6r4kRK
        HtRzID7g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMnOn-0006Vg-S3; Mon, 28 Sep 2020 07:16:37 +0000
Date:   Mon, 28 Sep 2020 08:16:37 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Dave Fugate <david.fugate@intel.com>
Subject: Re: [PATCH 0/3] PCI: Minimizing resource assignment algorithm
Message-ID: <20200928071637.GA24862@infradead.org>
References: <20200928010609.5375-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928010609.5375-1-jonathan.derrick@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

<broken record>
Intel, please just allow us to opt-out of using VMD as VMD just makes
life miserable.  Thanks!
</broken record>
