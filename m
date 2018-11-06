Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B376C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 07:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2256520862
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 07:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XqdugwF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2256520862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387469AbeKFQeO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 11:34:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387457AbeKFQeN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Nov 2018 11:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IVqCC0dLaloKUV45k6EEuzAJeKXMExtN0y0EJMuwLQo=; b=XqdugwF4L9LEgS42iECj65GdL
        x9PSuJTpvB62Vef0YCnoTLEzgIirxLTgoaOn3YaZv2AFgSdB1a9Els9RnCKLKPRB6xh4emELfq21X
        +asD3cyAbg0rsz8KymAFe8VYD1NObwh1t6SkM0ZuwBRfT/fO6QDv3G3+w3r0CamtU8l4gPLaRScp4
        6ndpNSVwsBkZFwd5zAjymSbqSRn+uNMmLygq7p/zdLMPzkTETzXxd1VdvIJYDPRnPDQxjgZ/QMxAV
        2pfnFGrAPzAN1qef4dRKBYTnmuN/sTPvBwxtGUqbKb/K8CEKEiTRzpX2d/GlL/9vqqEdBxZIuP52+
        v8VouQJAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJvV5-0000iK-DS; Tue, 06 Nov 2018 07:10:11 +0000
Date:   Mon, 5 Nov 2018 23:10:11 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] pci: prevent sk hynix nvme from entering D3
Message-ID: <20181106071011.GA23935@infradead.org>
References: <20181106020402.21120-1-acelan.kao@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106020402.21120-1-acelan.kao@canonical.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 06, 2018 at 10:04:01AM +0800, AceLan Kao wrote:
> It leads to the power consumption raises to 2.2W during s2idle, while
> it consumes less than 1W during long idle if put SK hynix nvme to D3
> and then enter s2idle.
> >From SK hynix FE, MS Windows doesn't put nvme to D3, and uses its own
> APST feature to do the power management.
> To leverage its APST feature during s2idle, we can't disable nvme
> device while suspending, too.
> 
> BTW, prevent it from entering D3 will increase the power consumtion around
> 0.13W ~ 0.15W during short/long idle, and the power consumption during
> s2idle becomes 0.77W.

Please get this fixed in firmware.  And yes, depending on which Windows
driver you use Windows might be doing very agressive runtime D3, which
is parted of Windows modern standby, so it'll trip up there eventually 
as well.
