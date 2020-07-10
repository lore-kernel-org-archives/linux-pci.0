Return-Path: <SRS0=O/bX=AV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2661EC433E1
	for <linux-pci@archiver.kernel.org>; Fri, 10 Jul 2020 06:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F29BD207BC
	for <linux-pci@archiver.kernel.org>; Fri, 10 Jul 2020 06:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eEdo/Wlz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgGJGpk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 10 Jul 2020 02:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgGJGpi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jul 2020 02:45:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD44C08C5CE
        for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2020 23:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+SmqHy8CMc3iuhAwtq/TSsrsRiGcdEkFZjK7CnvrgAE=; b=eEdo/Wlzp9/NMwwjgF/2faPJo5
        +sTG0Jui3RcDB0iFzSeku+tWGzALbabBaOyANtd2TBjQnOAeTFWk0UZdy21fI739vrhFN2LatLUc9
        iVxohDeteTya4EBA3M+zfpIflZmfzVltT2dJSKf7ugDRNzyW7Yyt7jo4J4YDvCmr/J/0V8BgXcowY
        6UIwBmgCAw5nA5Rx9Reyj3LweQ+DxTOGgS87jYPgr+eVpgjYbNHIL1WHgDN6DcAnVposdGRSfIwR7
        3xe85NVuDG31m8WRklA1n0KCEH5jxZ7eXIXUEOiMFmkgiCilC/3CZXQx52Ytp3Z4I2AYpHEs/SUky
        W/KInjjA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtmmt-0002Sr-KP; Fri, 10 Jul 2020 06:45:35 +0000
Date:   Fri, 10 Jul 2020 07:45:35 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Oliver O'Halloran <oohall@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: PowerNV PCI & SR-IOV cleanups
Message-ID: <20200710064535.GA8354@infradead.org>
References: <20200710052340.737567-1-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710052340.737567-1-oohall@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 10, 2020 at 03:23:25PM +1000, Oliver O'Halloran wrote:
> This is largely prep work for supporting VFs in the 32bit MMIO window.
> This is an unfortunate necessity due to how the Linux BAR allocator
> handles BARs marked as non-prefetchable. The distinction
> between prefetch and non-prefetchable BARs was made largely irrelevant
> with the introduction of PCIe, but the BAR allocator is overly
> conservative. It will always place non-pref bars in the prefetchable
> window, which is 32bit only. This results in us being unable to use VFs
> from NVMe drives and a few different RAID cards.

How about fixing that in the core PCI code?

(nothing against this series through, as it seems like a massive
cleanup)
