Return-Path: <SRS0=Lbw5=PZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E0EC43387
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 15:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52766205C9
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 15:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZxL+FoYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfAQPPj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:15:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45158 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfAQPPj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jan 2019 10:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fuO1jtnu7g3/srQXZxB644GHd0AArbzTMEoO2xuWQJY=; b=ZxL+FoYJGK6asvcyhg6+oiO9i
        1L4152hbeDohHNbYfmYH2W64BXpAhatY0F6lQQiHHjp2NN7rhxu1KFWL19JYOMJb/3SUtW+Nc5Wbh
        z/MqdvspaAyRmyxlM36HTei1+0xfVDA6AjtvcV6NGZJ8jarJr52fKWaE8npaJ7k2dIjquvYvd2Tb8
        JxDfsH6egOzi5frdJoLl9A9XUhL3sUIDqTyrS3N6Ldvgtog9Y+nuYPH0wi8IgN0XQ6JUsJ8KWjB4j
        6DL7rQjOzTwg9WNo+JOBmTd7580OCEfqw3vCc3zMw3XcufMu/NWYam5erRZOhoRJ/UhxUUS/hxe6r
        3uM6s1GCQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gk9OD-00054R-OL; Thu, 17 Jan 2019 15:15:29 +0000
Date:   Thu, 17 Jan 2019 07:15:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
Message-ID: <20190117151529.GA3471@infradead.org>
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
 <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
 <20190117105441.eqediwlekofp2srg@axis.com>
 <CAK8P3a2HtSJCLVdLcs=f0b5wv-k-6E_Z4Pt3Yp_kazUZh-Ek9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2HtSJCLVdLcs=f0b5wv-k-6E_Z4Pt3Yp_kazUZh-Ek9A@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 17, 2019 at 01:39:27PM +0100, Arnd Bergmann wrote:
> Can you describe how you expect a VOP device over NTB or
> PCIe-endpoint would get created, configured and used?
> Is there always one master side that is responsible for creating
> virtio devices on it, with the slave side automatically attaching to
> them, or can either side create virtio devices? Is there any limit on
> the number of virtio devices or queues within a VOP device?

For VOP device over NTB your configure your device using configfs
on one side, and for the other side it will just show up like any
other PCIe device, because it is.
