Return-Path: <SRS0=ddhW=NH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB62BC46475
	for <linux-pci@archiver.kernel.org>; Sat, 27 Oct 2018 07:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F4620868
	for <linux-pci@archiver.kernel.org>; Sat, 27 Oct 2018 07:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ikANX6k1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F4620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbeJ0QO4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 27 Oct 2018 12:14:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48544 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727643AbeJ0QO4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Oct 2018 12:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kAR1ai/S1gEoexvLzEpemQBBndgOUaUOpPDik2CRLFw=; b=ikANX6k1GJaXTHUQ1U45DpvI1
        WdOGM1JKTK6qtgypvXmqmJVqzcbVDMORTr3Upecmt05j0Gfp94PxW8IjzcqSd0EyPTgYBGDiI9MEa
        neWeD4v9UohwLJ1hwnC0bofTHDKlrvnnJvuXSCzKLAUpeqwuKfqHhK3KmC9cqrqAyLizmHeD8np1j
        pfMblUHpHENWu+cdAfinnBsp73nwjVlzBEJoZEQt9fndET08gKp9MQ4DrlRXTjqCUu+HX/tTwkw2k
        HUFWNbWF2RCuf2AOBqhsgfPvyduMt21Oyz5OrnF2E8E2WY97Myu0BMrjdeL1pFZ1wyoAcgGrjEWNI
        YTdOf/myg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gGJ7U-0007FK-FM; Sat, 27 Oct 2018 07:34:52 +0000
Date:   Sat, 27 Oct 2018 00:34:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 3/3] PCI/VMD: Enable firmware-first combined model
Message-ID: <20181027073452.GA15476@infradead.org>
References: <1540585146-31876-1-git-send-email-jonathan.derrick@intel.com>
 <1540585146-31876-3-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540585146-31876-3-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 26, 2018 at 02:19:06PM -0600, Jon Derrick wrote:
> The VMD endpoint acts as a host bridge for a nested PCIe segment. This
> segment and its ports and endpoints are not represented in ACPI tables
> such as DSDT and HEST, so "firmware first" error handling is currently
> unsupported in the driver in favor of OS native error handling.
> 
> VMD does support firmware error handling where errors are signaled to
> host firmware via SMI. VMD supports a "combined model" [1] where
> OS-native error handling is used in addition to firmware. Because of
> this combined model, this patch does not subscribe to the kernel
> firmware-first architecture which would prevent OS native error
> handling.

This sounds really horrible.  Why can't Intel just offer a tweak to
disable this whole VMD nightmare and treat it like a normal PCIe bus,
which would leave everyone much better off?
