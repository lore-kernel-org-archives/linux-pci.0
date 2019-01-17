Return-Path: <SRS0=Lbw5=PZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2116BC43387
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 15:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72D1205C9
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 15:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dkXmhXtg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfAQPTY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:19:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46764 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfAQPTY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jan 2019 10:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XgYTtO+Evcv+RpUGULYQr7/V+/3q0FtiJLILWAy2PC8=; b=dkXmhXtg091iULodFxfgGBPhp
        TrnRLGpNvRKvW0DVCyZqmrU+8HGVuJ9ox9vnol0Tqc83mj2EjbsAu04k2mGLmC4cVelc+4JQW6HYs
        B+mgCnEFN+DnZHbv/33FhVIRUJvKAwvoH31mr3OTF/s/gqS9gD1VspCry4dA9hl7IFKPBwfnTH7YE
        IbeqyfF3oeWlKEFpG6KbP9EXtW9kFEUwr8zpfBLov/1XIrtgzX8eDS2USLtGDiM+PWNSieXa6Glyh
        ENU6vLaOVFY1Xc+NkdOyTAIDk+NreXhq7lP64L/s4LNXGzZ2MeiTipyixQk0g10ZdNn6HqfITy0kI
        1hiibzK9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gk9Rw-0005ht-SK; Thu, 17 Jan 2019 15:19:20 +0000
Date:   Thu, 17 Jan 2019 07:19:20 -0800
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
Message-ID: <20190117151920.GA20359@infradead.org>
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
 <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
 <20190117105441.eqediwlekofp2srg@axis.com>
 <CAK8P3a2HtSJCLVdLcs=f0b5wv-k-6E_Z4Pt3Yp_kazUZh-Ek9A@mail.gmail.com>
 <20190117151529.GA3471@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117151529.GA3471@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 17, 2019 at 07:15:29AM -0800, Christoph Hellwig wrote:
> On Thu, Jan 17, 2019 at 01:39:27PM +0100, Arnd Bergmann wrote:
> > Can you describe how you expect a VOP device over NTB or
> > PCIe-endpoint would get created, configured and used?
> > Is there always one master side that is responsible for creating
> > virtio devices on it, with the slave side automatically attaching to
> > them, or can either side create virtio devices? Is there any limit on
> > the number of virtio devices or queues within a VOP device?
> 
> For VOP device over NTB your configure your device using configfs
> on one side, and for the other side it will just show up like any
> other PCIe device, because it is.

Sorry, I mean over the PCI-EP infratructure of course.  NTB actually
is rather hairy and complicated.
