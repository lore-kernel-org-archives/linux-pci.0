Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9703C25B06
	for <linux-pci@archiver.kernel.org>; Sat,  6 Aug 2022 08:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbiHFIOJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 6 Aug 2022 04:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiHFIOI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Aug 2022 04:14:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AA3EE2C
        for <linux-pci@vger.kernel.org>; Sat,  6 Aug 2022 01:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xt6/r1gPFT/TzLV0NKT4atWiSTcK5SawGhgCt3BntG4=; b=NDsn7dSBOIcAD5aWiWn0US2tGT
        +HYIgIXRgd9473UzPhN7c9QLqqNHJXuchGfTalTlChJNwhs6mqaDBDXt+whO03YY7lXbHw3IBBFav
        uCbYkP+AS/86FOv7co4i4ktRyFv/pPAzNEThz6fED5UM9FF8Il9bdnHtVjVIUeBg195mjhiekMG+j
        DsJN2sbHrdGCDQA9GL1YbxtxyNDby9sXPkJxetAIm0X0yd66qijOr6GYwgIUKIH+b6HLnw2qCGW3L
        BiUxRcEngJkFoZdKz6TBGCEkuM+ppdWQU2eYKVkLE/qrLhCHLqUJd/uzyoUX4u6625y4R/jWWYnR+
        pJN++lPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKEwh-006Q0A-6s; Sat, 06 Aug 2022 08:14:07 +0000
Date:   Sat, 6 Aug 2022 01:14:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yang Wang <KevinYang.Wang@amd.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] PCI/IOV: export pci_vf_drivers_autoprobe() symbol
Message-ID: <Yu4iz9AsaUNcRqud@infradead.org>
References: <20220805085639.1629653-1-KevinYang.Wang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805085639.1629653-1-KevinYang.Wang@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 05, 2022 at 04:56:39PM +0800, Yang Wang wrote:
> make pci_vf_drivers_autoprobe() as export symbol.
> 
> the external module have no way to control vf autoprobe flag
> before pf driver call pci_enable_sriov().

But this does not actually seem to be used by any potentially
modular driver.
