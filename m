Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EDFC32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 07:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFC42085B
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 07:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ee/tFgIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFC42085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387428AbeKFQeu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 11:34:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387397AbeKFQeu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Nov 2018 11:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IqgWzHSO3NPpa0YZq3ziImuKKcRgfZe28vNyIprvSnQ=; b=ee/tFgIMZSthzocE44d+JLZet
        MwABvt6MGeJZ+lHdmIENR6ldtP41+X2w2mj+v8GXbgHdGAzpTA0HhR+b4Ow2Xmqqx5Y4NYgvdyFgi
        7cQ+zR4jd/fAA8qaZ/q/Y+Bt2lt0CXEq7okW3BfxDJLpwydYdsvGNY/UsyVNQE5sjUGCAJnobridz
        uUMS663I+xKGdJNnRzsKrEHCMSa4ifIxc3MYTf4lkyHeiscDKqq/ymMxGHUfVh8rGQHdgdnAN5aEb
        sgeJNQZujkRHWN/+Z+s2mCRHi/p2cDlYnBQOiAmP31EUpcn8PQCVK/SdCxZR5ep98rBnLWsX7X4+x
        XnRBXlD1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJvVp-0001CW-Fv; Tue, 06 Nov 2018 07:10:57 +0000
Date:   Mon, 5 Nov 2018 23:10:57 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: add quirk to not call disable function when
 suspending
Message-ID: <20181106071057.GB23935@infradead.org>
References: <20181106020402.21120-1-acelan.kao@canonical.com>
 <20181106020402.21120-2-acelan.kao@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106020402.21120-2-acelan.kao@canonical.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 06, 2018 at 10:04:02AM +0800, AceLan Kao wrote:
> Call nvme_dev_disable() function leads to the power consumption goes
> up to 2.2 Watt during suspend-to-idle, and from SK hynix FE, they
> suggest us to use its own APST feature to do the power management during
> s2idle.
> After D3 is diabled and nvme_dev_disable() is not called while
> suspending, the power consumption drops to 0.77 Watt during s2idle.

Same comment as previous one.  Get the firmware fixed please - this
doesn't prevent the drive from working, but it is a grave implementation
bug in it that needs to get fixed.
