Return-Path: <SRS0=l472=MF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041A7C433F4
	for <linux-pci@archiver.kernel.org>; Sun, 23 Sep 2018 11:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38A920C0A
	for <linux-pci@archiver.kernel.org>; Sun, 23 Sep 2018 11:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38A920C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbeIWRH5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 23 Sep 2018 13:07:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38458 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbeIWRH4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Sep 2018 13:07:56 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DZPzb-gkZM7R; Sun, 23 Sep 2018 13:10:49 +0200 (CEST)
Received: from zn.tnic (p200300EC2BDF9000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bdf:9000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DA3191EC0531;
        Sun, 23 Sep 2018 13:10:48 +0200 (CEST)
Date:   Sun, 23 Sep 2018 13:10:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 07/16] x86/pci: Add Hygon Dhyana support to PCI and
 north bridge
Message-ID: <20180923111046.GA20575@zn.tnic>
References: <cover.1537533368.git.puwen@hygon.cn>
 <580dc519d37ad9257520fe8c533f2c61d3e0cd83.1537533369.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <580dc519d37ad9257520fe8c533f2c61d3e0cd83.1537533369.git.puwen@hygon.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 23, 2018 at 05:35:13PM +0800, Pu Wen wrote:
> As Hygon registered its PCI Vendor ID as a new one 0x1d94, and there
> are PCI Devices 0x1450/0x1463/0x1464 for Host bridge on Hygon Dhyana
> platform, so add Hygon Dhyana support to the PCI and north bridge
> subsystem by using the code path of AMD family 17h.
> 
> To prevent further checking PCI device ids which cannot happen both on
> Hygon and Intel platform, the function amd_gart_present should return
> if it's not a AMD CPU.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h
> Reviewed-by: Borislav Petkov <bp@suse.de>

A note for your future submissions: if you rework a patch in a
non-trivial way, you *must* drop Reviewed-by/Acked-by tags because they
are not valid anymore.

In this case I guess Bjorn's tag can stay because he's acking the
pci_ids.h addition but mine definitely must go.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
