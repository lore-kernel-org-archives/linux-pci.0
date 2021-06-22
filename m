Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14153C2B9F4
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jun 2021 06:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB3960FDC
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jun 2021 06:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhFVGWW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 22 Jun 2021 02:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVGWV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jun 2021 02:22:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D454C061574;
        Mon, 21 Jun 2021 23:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i7qw1P7cffyCFgbX14CbqUdWAzPNTF+txKSmBp9Yh1M=; b=KZ/I+55ap+o6tXTh99YDxMSxlv
        TGMr/88yh7Uv+6cIA/axZwCkDUwJ8Y9GW+OWu846zIqw64TILFXumV7A6hlHzBVSZU7OUapoLJlNC
        OFTgVSGa9g3vliCYAQl4vvHhA1+oRF7eWc1/ebDSi+6NJuTtZU0ByNYACJ6CEwIpyyogId/8P3oGi
        3Flt0ySU1jtkHlsrCBOPjnVeTTVrEY+tRcI3wOdtTdejMjrzmovzSfh8ZTp5ameDyFDZdR1YUYfci
        tg4d12c3XkAkojicZ/q00h/JNPFahAteftqoXu9KL6QykbVotngMrzfR/VofdddcjQAiEVTzd3gTz
        P8mvrHDw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvZkk-00DxQv-Sw; Tue, 22 Jun 2021 06:19:28 +0000
Date:   Tue, 22 Jun 2021 07:19:18 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dongdong Liu <liudongdong3@huawei.com>
Cc:     helgaas@kernel.org, hch@infradead.org, kw@linux.com,
        linux-pci@vger.kernel.org, rajur@chelsio.com,
        hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH V5 6/6] PCI: Enable 10-Bit tag support for PCIe RP devices
Message-ID: <YNGA5ie1nA4i5l4R@infradead.org>
References: <1624271242-111890-1-git-send-email-liudongdong3@huawei.com>
 <1624271242-111890-7-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624271242-111890-7-git-send-email-liudongdong3@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 21, 2021 at 06:27:22PM +0800, Dongdong Liu wrote:
> PCIe spec 5.0r1.0 section 2.2.6.2 implementation note, In configurations
> where a Requester with 10-Bit Tag Requester capability needs to target
> multiple Completers, one needs to ensure that the Requester sends 10-Bit
> Tag Requests only to Completers that have 10-Bit Tag Completer capability.
> So we enable 10-Bit Tag Requester for root port only when the devices
> under the root port support 10-Bit Tag Completer.
> 
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
