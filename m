Return-Path: <SRS0=vJ1S=YJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E19ECE599
	for <linux-pci@archiver.kernel.org>; Wed, 16 Oct 2019 06:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768F52168B
	for <linux-pci@archiver.kernel.org>; Wed, 16 Oct 2019 06:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YihJJmR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfJPG2e (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Oct 2019 02:28:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfJPG2e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 02:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ub26c8z5A9JfTFPI6SxDoFbuRhH0FWEJLyq04FuxNLU=; b=YihJJmR+AwWlBY07w47sBvJnO
        BNctRzzWJJNu7akowzBygWkDFrIRBDcnmryja6kX2DQm1+EsB0U3E1ca5vy7fvzkOqMhPMmu+I2E2
        /lJFlk64Qjm81ofdI+mrO62q/MTaD4GQHFHXdjruZOhCF/l3ieILlVT8ATvoYdlEVf9OM29XRDwR5
        vo4aHuZG/+ljQLi7eg2Db1U/Lh+68EeVD3up1lCdmakAgeyLOQcsSK8tfsHAQgneJnA5ceVJEzoYN
        HmfIUcWHO4E81jBV+mBXwEz37mwx1Hk1MlDWiZxKmzmRbJeNXHN/bAYfwZ3SM/X1MnJ630U/RMLPO
        tHtTlCblA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKcnP-0001ju-F0; Wed, 16 Oct 2019 06:28:31 +0000
Date:   Tue, 15 Oct 2019 23:28:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: sysfs: remove pci_bridge_groups and pcie_dev_groups
Message-ID: <20191016062831.GB6537@infradead.org>
References: <20191015140059.18660-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015140059.18660-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 15, 2019 at 03:00:59PM +0100, Ben Dooks wrote:
> The pci_bridge_groups and pcie_dev_groups objects are
> not exported and not used at-all, so remove them to
> fix the following warnings from sparse:
> 
> drivers/pci/pci-sysfs.c:1546:30: warning: symbol 'pci_bridge_groups' was not declared. Should it be static?
> drivers/pci/pci-sysfs.c:1555:30: warning: symbol 'pcie_dev_groups' was not declared. Should it be static?

But now pci_bridge_group is unused, and if you remove that the
attributes, etc..
