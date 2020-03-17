Return-Path: <SRS0=CoTa=5C=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4B2C3F2CE
	for <linux-pci@archiver.kernel.org>; Tue, 17 Mar 2020 14:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15F7205ED
	for <linux-pci@archiver.kernel.org>; Tue, 17 Mar 2020 14:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cni3IHCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgCQOp3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:45:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgCQOnp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2020 10:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S6NdTWibk79+YugWFTSLV3fGTXeAxQI8N46whgDUO3c=; b=Cni3IHCz/BEbBcs7bSSGQn3Guj
        3SLR4Fwdl6HMHn2vmXaKFOSKBvatq/MpRvt1QNhS9UXk5/ACO4wAxVd8QR9djzoiAZNT55VjXD6gR
        NfGS/AAR0rk1iHGWGiZH6hdWuDsZoeU56NdVzk1mH2lM24QqEL+K8nVLsLZKgnB2eUPVZPzK0mUHS
        qN05y0Zd6LZE8qZseYi6Nr66OBtIWPAQwiMl4nPu/THHbRhqhNoI2L3Sc/PBYQ2+nh1NO7rvkNgEE
        QJ15s8ln7aDj+EONSM30Y8rlTpUC/D+e88IyRMAIawn8sMMmOT/vESepCT8HjoxDzM38eEFPuv+Bk
        JubQnSwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEDRY-0006FO-0X; Tue, 17 Mar 2020 14:43:44 +0000
Date:   Tue, 17 Mar 2020 07:43:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [PATCH v17 10/12] PCI/DPC: Export DPC error recovery functions
Message-ID: <20200317144343.GF23471@infradead.org>
References: <cover.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <ac8816d4d41d0894720660f9b51dbeac0842869d.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac8816d4d41d0894720660f9b51dbeac0842869d.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Nothing is actually exported here (fortunately!).
