Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B73E810AD
	for <linux-pci@archiver.kernel.org>; Wed, 27 Sep 2023 09:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjI0J1E (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Sep 2023 05:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjI0J1D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 05:27:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D0F19F;
        Wed, 27 Sep 2023 02:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Wf8zy0/8iT0rNsNSC1VeuJ4umg
        ebHsQRABbh3cOEE+1j/XBhwX40QlWgpajv8a8oGauvy3tDtfFZg2MMl7A6tB5I4nr1fbnlJhUmSTJ
        rKPCmqd7bZJSpTVl+yi2IZL/1ljVYO3QfoWhsv2IfhYusoo+RaVID/kGiPN3fvT7yXkVGYEweLsg5
        hg7z5LNB8e5OOgqtzHfS/otTphNKn+aleFa8IPILIJq50pygLetHq4zrgxWVHF+dMhWbJS/7J0WN7
        LK+cEAd+RFtMiapT53GgTrQrJmLcgHOS4DLEKhVEQkh+etZuvEwzBuHKmFF9s1RmrQ7bk6/SX9vHm
        Cw1EFU6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qlQom-000TDV-06;
        Wed, 27 Sep 2023 09:26:52 +0000
Date:   Wed, 27 Sep 2023 02:26:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     hch@infradead.org, bhelgaas@google.com,
        christophe.jaillet@wanadoo.fr, imx@lists.linux.dev, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lpieralisi@kernel.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        robh@kernel.org, roy.zang@nxp.com
Subject: Re: [PATCH v3 1/1] PCI: layerscape-ep: set 64-bit DMA mask
Message-ID: <ZRP1XOzN7xtKR2Ao@infradead.org>
References: <20230926140445.3855365-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926140445.3855365-1-Frank.Li@nxp.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

