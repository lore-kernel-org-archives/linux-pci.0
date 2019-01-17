Return-Path: <SRS0=Lbw5=PZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CF9C43387
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 15:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A0220851
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 15:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RykqyGgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfAQPqS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:46:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37028 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfAQPqS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jan 2019 10:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5uOvLZ7YdZQEYVquy8Opby5yGpZwzNhOFf+GdUTjQDc=; b=RykqyGgOBlCfqi9InNbzLnw0x
        3W441ABSTgW0olQbTUfju/SuIzShEU5V7DB9BN7dQdX2bEk+D1R24zf50qBUVthTUaf/n1uu1AkWh
        oD1ctebrctf0SMJ+wGkoZIdAwoVpaJIpV3fXAQGkWJQ3k7YwnYdsBezT4K/j08u6jOk7PJYL91gUS
        8TBtf1ZLdPaDqSYBP2aeQBWk7nG/SCJv+fyZIy71WX9PLEkndurIf8O6y3h0rhLOcb9pyeod4z3Ki
        1AIjZRthRN82CPUXT5RB4Vj2PERhzQWfC5i42XzVH2xyOXIbYOLROrAlzuj+wBDeND+oyhKCNNv42
        PpDpoHCvQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gk9rx-0001eV-06; Thu, 17 Jan 2019 15:46:13 +0000
Date:   Thu, 17 Jan 2019 07:46:12 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, sudeep.dutt@intel.com,
        ashutosh.dixit@intel.com, gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
Message-ID: <20190117154612.GA6262@infradead.org>
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
 <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
 <20190117105441.eqediwlekofp2srg@axis.com>
 <CAK8P3a2HtSJCLVdLcs=f0b5wv-k-6E_Z4Pt3Yp_kazUZh-Ek9A@mail.gmail.com>
 <20190117151906.odvozs6kz3uvx32y@axis.com>
 <20190117152142.GB20359@infradead.org>
 <20190117153206.2flxqb26tbdrwp4z@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117153206.2flxqb26tbdrwp4z@axis.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 17, 2019 at 04:32:06PM +0100, Vincent Whitchurch wrote:
> If I understand you correctly, I think you're talking about the RC
> running the virtio drivers and the endpoint implementing the virtio
> device?  This vop stuff is used for the other way around: the virtio
> device is implement on the RC and the endpoint runs the virtio drivers.

Oh.  That is really weird and not that way I'd implement it..
