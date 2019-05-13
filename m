Return-Path: <SRS0=Rht+=TN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B57C04AB1
	for <linux-pci@archiver.kernel.org>; Mon, 13 May 2019 07:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352FC20879
	for <linux-pci@archiver.kernel.org>; Mon, 13 May 2019 07:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QpVQM9nH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfEMHZr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 13 May 2019 03:25:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54426 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbfEMHZq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 03:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FepseJqUtrkKupverYm+/3v6WT5gLzsS2oUTxOu7nu4=; b=QpVQM9nHiNVRQNFKtFyPsQ7Xf
        C6KLxnEjuKDh+KHifrD4YZABIjsToiOM4LMHMdD0BAY1he1JJJnM/aBUaUfi/wUpMYlXJ1sD0VfhJ
        pzCt/ZiMcluQqV8BU4O8JzpwMvzy0oiDE16GgPxrKcN8RS5t0Wx10mFXdDS8fHO9zBFhg29swgyQO
        4BgI3iAakOQz9jz/JPwQbJX2/MfYNYAHIOEpFqeDLFfCwuXwYlbIgtAfAjHY42B6pZVa/ruT7yZw/
        GizKSLihsDXgyP0feeE7HTGY9pMpZBjnEXTcjvLe5a3oq9cseV/wNhbFy/dmebEHnLOhB5hRQdvQA
        3JUJVNXtA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQ5L9-00006V-Nu; Mon, 13 May 2019 07:25:39 +0000
Date:   Mon, 13 May 2019 00:25:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V6 02/15] PCI/PME: Export pcie_pme_disable_msi() &
 pcie_pme_no_msi() APIs
Message-ID: <20190513072539.GA27708@infradead.org>
References: <20190513050626.14991-1-vidyas@nvidia.com>
 <20190513050626.14991-3-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513050626.14991-3-vidyas@nvidia.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 13, 2019 at 10:36:13AM +0530, Vidya Sagar wrote:
> Export pcie_pme_disable_msi() & pcie_pme_no_msi() APIs to enable drivers
> using these APIs be able to build as loadable modules.

But this is a global setting.  If you root port is broken you need
a per-rootport quirk instead.
