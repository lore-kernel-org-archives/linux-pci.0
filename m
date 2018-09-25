Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490B8C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 12:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081112086E
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 12:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081112086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbeIYShy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:37:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55464 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbeIYShw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 14:37:52 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IPayG-mbWBFH; Tue, 25 Sep 2018 14:30:31 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC69500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:9500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7303D1EC00B9;
        Tue, 25 Sep 2018 14:30:31 +0200 (CEST)
Date:   Tue, 25 Sep 2018 14:30:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 07/16] x86/pci: Add Hygon Dhyana support to PCI and
 north bridge
Message-ID: <20180925123035.GC23986@zn.tnic>
References: <cover.1537533368.git.puwen@hygon.cn>
 <580dc519d37ad9257520fe8c533f2c61d3e0cd83.1537533369.git.puwen@hygon.cn>
 <20180924152448.GE20187@zn.tnic>
 <8ed72e5f-c85c-67f6-67e9-460ef99ab372@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ed72e5f-c85c-67f6-67e9-460ef99ab372@hygon.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 25, 2018 at 08:27:15PM +0800, Pu Wen wrote:
> All right, I will change these in the next version patch set.

Just send two patches as a reply to this thread here:

1. add the vendor check to both amd_gart_present() and early_is_amd_nb()
2. redo 7/16 ontop of the first patch.

I don't think you need to resend the whole patchset as the rest is still
good.

Right?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
