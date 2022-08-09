Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC31C19F2D
	for <linux-pci@archiver.kernel.org>; Tue,  9 Aug 2022 08:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238932AbiHIIBE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Aug 2022 04:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240871AbiHIIAu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Aug 2022 04:00:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D001610A1;
        Tue,  9 Aug 2022 01:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hDBpP4uDRt2zuUoRgz7F9W9nhp5+fTzERpgmXxdqiU8=; b=Q6gIiB1ouX0R2+3djawK+betiN
        7GRTDMPpU86FB/GWnNkrwkXYIX1ZFehC77Otp5JXz2oz2zz+gI2N/fH952uTIyMTAppFH24QKZRI0
        HQ/9mTIfjcLOMAE13LtSIynOOF/p9huOVtywCUPR55oZujc2u38htj3/ZppjX/65eUhIxgJfgLBZ/
        zAYWzdq4n+YOFy6FfeSvdRqxRFngslM+hHwiCu/R1wOPMIKDyWeQN/rPIr+y8Rn2jOu51phEJ8Xjm
        uCndwM2prrLpE0Vvl29ZCc2+ruFwdjzx2ct8oJHaoVZTilQsoBuNsQTkKWJGRIjxa/iTJTIAd4cx1
        xMI2KzJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oLKAO-002blo-3J; Tue, 09 Aug 2022 08:00:44 +0000
Date:   Tue, 9 Aug 2022 01:00:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 27/32] PCI/P2PDMA: Convert to printbuf
Message-ID: <YvIULAsLGMNVdPek@infradead.org>
References: <1b92761a-c166-b84f-8d77-a966d4c0ef9a@gmail.com>
 <20220809020734.GA1260912@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809020734.GA1260912@bhelgaas>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 08, 2022 at 09:07:34PM -0500, Bjorn Helgaas wrote:
> This doesn't tell me what the advantage of this patch is, since I
> don't think *this* patch uses heap allocation.
> 
> As far as I can tell, this particular patch doesn't improve safety or
> readability, so "convert X to Y even though we don't use any fancy Y
> features" is a pointless message.
> 
> But if printbufs are better than seq_buf overall, and converting this
> gets us closer to the goal of removing seq_buf completely, that's a
> perfectly acceptable reason.  Just say that.

Which still brings me back to a point made long time ago:  Why are
we doing the renaming to start with?  Add the new functionality and
or changes to seq_buf gradually instead of doing a tree wide sweep.
I don't think the new naming has a huge advantage (in fact I think
the old one actually is a little better, but the biggest argument here
really is to not change something if we don't have to).

That will massively reduce the churn at the cost of Kent having to
rework the code a bit, but that seems like a worthwhile tradeoff and
one that we've usuall made in the past.
