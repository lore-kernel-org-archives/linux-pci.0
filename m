Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF58C433EF
	for <linux-pci@archiver.kernel.org>; Thu, 10 Mar 2022 06:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbiCJG3a (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 10 Mar 2022 01:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238736AbiCJG33 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 01:29:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7578104A68;
        Wed,  9 Mar 2022 22:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qiDLieTHnLvo5edzObqqrpmJ2BBLE/6B8RtHxJrL1qM=; b=pZY68db+9l05C3bELeWeqKtbFo
        /OQc3y21jMULnEYn9VRUyYwwTkCeeNhtDDEg+7CTsMc9BmL6kMAwJXxMGPAYl8eUQJOxjKz9Cgo8N
        bRmK20ZFgRzgFIm41QeTJnovLZpmINxenVc6B/W23xUDEk9YyPdFEdAeQOzeMtILqRnbVnzd28UbI
        RsiOaj4afTFDXrDd4asL0LJ/1IG+2CJaGRhcnaFG2TwuWhllJwHZftsw8IxrDVFHEtiRyNcp1s6P/
        wzrEVJQAE4jCUXJiTEjGsYG5rnN9Kfh9TYeHGbzahwGvW1Gtfto6TQNFyjP19468SqbmRHdV+W4r1
        mlPSOEWQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSCHc-00BYzl-JD; Thu, 10 Mar 2022 06:28:20 +0000
Date:   Wed, 9 Mar 2022 22:28:20 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     bhelgaas@google.com, arnd@arndb.de, hch@infradead.org,
        akpm@linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: Remove the deprecated "pci-dma-compat.h" API
Message-ID: <YimahOUn2ck5QkJf@infradead.org>
References: <25d93797bd5a5bae5c7613ec42c01ecd7c69cd17.1646855282.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25d93797bd5a5bae5c7613ec42c01ecd7c69cd17.1646855282.git.christophe.jaillet@wanadoo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks.  Given that it depends on a few different trees I plan to send
this to Linus after -rc1.
