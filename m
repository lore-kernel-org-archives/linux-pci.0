Return-Path: <SRS0=XWMu=Q5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E468C43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 08:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3619D20823
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 08:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfBVIOU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:14:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:45980 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbfBVIOU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Feb 2019 03:14:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EB49EABC3;
        Fri, 22 Feb 2019 08:14:18 +0000 (UTC)
Date:   Fri, 22 Feb 2019 09:14:18 +0100
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 00/10] MIPS: SGI-IP27 rework
Message-Id: <20190222091418.7c0eeb0d5c11b68874d8fdc9@suse.de>
In-Reply-To: <20190221205038.hcov3n574a3zqip7@pburton-laptop>
References: <20190219155728.19163-1-tbogendoerfer@suse.de>
        <20190221205038.hcov3n574a3zqip7@pburton-laptop>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 21 Feb 2019 20:50:39 +0000
Paul Burton <paul.burton@mips.com> wrote:

> I don't appear to have received patches 7 or 9 but I see from archives
> there'll be a v3 of patch 9 at least.

I'm still fighting with git send-email to do proper collecting of addresses...
And the mails to your @mips.com address bounced yesterday.

> So I can either apply 1-6 for v5.1 or defer the whole series. Let me
> know - I'm happy either way.

All changes will happen in patches 7-10, so appreciate, if you could apply 1-6 :-)

Thank you,
Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
