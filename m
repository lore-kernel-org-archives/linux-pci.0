Return-Path: <SRS0=+N4N=XM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D627C4CECD
	for <linux-pci@archiver.kernel.org>; Tue, 17 Sep 2019 08:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F3E21881
	for <linux-pci@archiver.kernel.org>; Tue, 17 Sep 2019 08:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="njJ8oAn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404598AbfIQIEj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 17 Sep 2019 04:04:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60164 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbfIQIEj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Sep 2019 04:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ziG7cDWoOX8EG+PCQ4I/+FlUlyi7v/uDNlT777ESW0w=; b=njJ8oAn0sujUXkubrNOwwuj9t
        ki59KxhtBrgcyb6IxGRAnCYQEevecvAEBktvZrWo5tpq6q4LtWdVFpIQMyoNf/1vBDAbJJgL24gbR
        BxbWbSqIRHQGLFHJURqMsVzfdzz3UEsczrNO0H9dc2wWR0p7eZPvzHbA2pspTt2r0NPIN5o+jigVY
        1Hpt0jUMwjF4m1gTbNdTF++aJ0udXefcjgE0OVj+GSb13ChLGPJysufJJCLSA3KEDlY58VD48c3Fe
        gXqfP91lFVg2xYTo69Fe1ctccQz0M0PZJGD1jNooiDrhH5wOAY6sNLg10iTVgFdoc6PM+f3vmrB4f
        Kvb055D/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iA8TT-0001W0-Fa; Tue, 17 Sep 2019 08:04:35 +0000
Date:   Tue, 17 Sep 2019 01:04:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: vmd: Expose oob management window to users
Message-ID: <20190917080435.GA5666@infradead.org>
References: <20190916145128.5243-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916145128.5243-1-jonathan.derrick@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 16, 2019 at 08:51:28AM -0600, Jon Derrick wrote:
> Some VMD devices provide a management window within MEMBAR2 that is used
> to communicate out-of-band with child devices. This patch creates a
> binary file for interacting with the interface.
> 
> OOB Reads/Writes are bounds-checked by sysfs_fs_bin_{read,write}

I don't think this is a reasonable interface.  If the OOB interfae
is useful please provide an actual kernel driver for it.
