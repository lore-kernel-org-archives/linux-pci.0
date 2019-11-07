Return-Path: <SRS0=9PB/=Y7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CE9C43331
	for <linux-pci@archiver.kernel.org>; Thu,  7 Nov 2019 15:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBF52178F
	for <linux-pci@archiver.kernel.org>; Thu,  7 Nov 2019 15:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bb6vI2fU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKGPhh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:37:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33820 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKGPhh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Nov 2019 10:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nGydLSsGxxmYrXGAw15Q8ycWDwl66hdCC3wCq7d7wXo=; b=bb6vI2fUQXVprSJX8mvHLWV0T
        qchAtG7zVD0aBCE9cQ+hgInMVqiVVtfX09jGUsqDkk4NpqCn09loxwLv48gsLbQnWgPvHf3HXF98s
        N//TD6YaMcBV4UPlu7REWBJxd2xHSwAbEQ5dXBj/5wgh31RbTeOS/IV/5We12Pb/N2b1qLZmr/GgF
        aF/uuUF8mixSFtrk0UomvYF2r8RGsCodfdc93wVqdE1mcC32D+9G2T9Xpx246w76UfWmze2sSwbZb
        /mri3tMLAjoALYoJGSskZk+GKM9qTPURjvcEGNYKRWvTnyeyr864SiOj8WMKYmPL24A6g2rQ6SSTj
        GyJ+2GijA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSjqq-0004Fj-2m; Thu, 07 Nov 2019 15:37:36 +0000
Date:   Thu, 7 Nov 2019 07:37:36 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH 0/3] PCI: vmd: Reducing tail latency by affining to the
 storage stack
Message-ID: <20191107153736.GA16006@infradead.org>
References: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
 <20191107093952.GA13826@infradead.org>
 <bfc69a54dc394ffb7580d14818047ec6a647536f.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfc69a54dc394ffb7580d14818047ec6a647536f.camel@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 07, 2019 at 02:12:50PM +0000, Derrick, Jonathan wrote:
> > How does this compare to simplify disabling VMD?
> 
> It's a moot point since Keith pointed out a few flaws with this set,
> however disabling VMD is not an option for users who wish to
> passthrough VMD

And why would you ever pass through vmd instead of the actual device?
That just makes things go slower and adds zero value.
