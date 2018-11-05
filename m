Return-Path: <SRS0=Hm5h=NQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF33C0044C
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 21:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAD02084F
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 21:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E8yoerK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CAD02084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387752AbeKFHTq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:19:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42992 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387580AbeKFHTq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Nov 2018 02:19:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QxadfPa3u1K8ALgcaMuzHbPz65rwtPPP01Zwshr7w5I=; b=E8yoerK+R5Pn9Zg2Wsv2zDQA4
        XkGhQx0RvhdCwRrGzvadmlSONd1MAvRBOPtnrViuCb8j5EflLa5bc4iWO7vgv+s/DPedBB7Q10k7e
        cgcmRjN4Ax4rUY3vO+D5o+Kq002GoAw507bAgf7l8kPGZLNRB809W+wfSLKIadQjFbyEbt5KstkRW
        vi/ptQCp/HNd06GhF89x3gSXncMIxTGRXWn1dSgXINBqHAYSVySqko5vYf/yR1lZYPJ5pvLgxBvPV
        CO6ut995ExjU8EJPI9gBsqe+LQLAqeJbeXM6S0JyLMIAueQD/CWrWCcKNoGk/h3ASyYB/kPjXpMAP
        sBBzNj5LQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJmsT-0002H1-Fl; Mon, 05 Nov 2018 21:57:45 +0000
Date:   Mon, 5 Nov 2018 13:57:45 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Zubin Mithra <zsm@chromium.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        groeck@chromium.org, keescook@chromium.org
Subject: Re: [PATCH] x86/pci: Annotate 'pci_root_ops' with __ro_after_init
Message-ID: <20181105215745.GB3160@infradead.org>
References: <20181105201735.72026-1-zsm@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105201735.72026-1-zsm@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 05, 2018 at 12:17:35PM -0800, Zubin Mithra wrote:
> When CONFIG_X86_INTEL_MID is set pci_root_ops is written to inside
> intel_mid_pci_init(which is marked __init) and not modified after. This
> makes pci_root_ops a suitable candidate for annotating as
> __ro_after_init.

Yikes.  pci_root_ops really should be const to start with, and we
should use a separate struct for MID.  Having structures that contain
function pointers not marked const is generally a bad idea to start with.
