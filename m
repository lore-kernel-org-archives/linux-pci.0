Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09766C282D9
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 17:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74B820870
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 17:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WXqkYgEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfA3R3A (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:29:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfA3R3A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jan 2019 12:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yEKnHHjycn02T1V1r5kuz9hdzMnfOyyx4Y/K/jcKGTs=; b=WXqkYgEXqFGeMd6zxvXpRLzt5
        O/+o6LGhE1/gveSHvQ1cGxak6bf4b49UpCbptlF5wtIlCfkRCWrSYuBJ9rvJPgV3W20PeqYTXpt6Z
        HEot6wFjBpaM0oLzXidFmxfVnjgY1GPfxRjf/9BAIk4uHrpBo8wvyhrqvEVXrm9bPA5V/Ekv3Eo17
        I/PTMf8L/ugR35Rg+BdeVojC7BiXjhmvJMQDC/R4CxRM1zxxeu6doV5wjmR2aaeRbZp1EQtv6KKTg
        hyoQCeJTpqySQtkcifmG5cV44x4imI2xMNrF9FGWJtfVZX0o3NA2uX6lC03VBHmtJnbT7kKA9jcHH
        KjA0HLtWQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gotfT-00017n-KT; Wed, 30 Jan 2019 17:28:55 +0000
Date:   Wed, 30 Jan 2019 09:28:55 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 6/7] MIPS: SGI-IP27: use generic PCI driver
Message-ID: <20190130172855.GA2962@infradead.org>
References: <20190124174728.28812-1-tbogendoerfer@suse.de>
 <20190124174728.28812-7-tbogendoerfer@suse.de>
 <20190128133215.GC744@infradead.org>
 <20190129162445.8584b58862068c0a7693718c@suse.de>
 <20190130091706.GA3617@infradead.org>
 <20190130182520.2864ad962605b43f1635e4fd@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130182520.2864ad962605b43f1635e4fd@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 30, 2019 at 06:25:20PM +0100, Thomas Bogendoerfer wrote:
> 
> and it's already there:-) Each struct device has a field numa_node and pci_bus has
> contains a struct device. arm64 is already using it only not so nice part is the
> usage of pcibios_root_bridge_prepare() to set the numa_node for the root bus.

Oh, great.  Maybe we can then just use that field for mips for now
and gradually move all architectures over.

> > Or add a add_dev callback, similar to what I did for a previous series
> > that we didn't end up needing after all:
> > 
> > http://git.infradead.org/users/hch/misc.git/commitdiff/06d9b4fc7deed336edc1292fe2e661729e98ec39
> 
> that's exactly what I'm looking for. Should I add the patch for my patchset or
> are you going to submit it after having a use case ?

Feel free to pick it up.  For the dma addressing limitations we
decided that exposing it through a DT property is the right way, so
that series isn't going anywhere.
