Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBD4C0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 17:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18F52086C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 17:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18F52086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeKHCss (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:48:48 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47468 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbeKHCsr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 21:48:47 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gwmEntzY_Thu; Wed,  7 Nov 2018 18:17:27 +0100 (CET)
Received: from zn.tnic (p200300EC2BCBE000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:e000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BCA7C1EC0291;
        Wed,  7 Nov 2018 18:17:27 +0100 (CET)
Date:   Wed, 7 Nov 2018 18:17:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Woods, Brian" <Brian.Woods@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, Pu Wen <puwen@hygon.cn>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        Takashi Iwai <tiwai@suse.de>,
        Andy Whitcroft <apw@canonical.com>,
        Colin Ian King <colin.king@canonical.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/4] x86/amd_nb: add support for newer PCI topologies
Message-ID: <20181107171721.GC14169@zn.tnic>
References: <20181102232948.GC26770@zn.tnic>
 <20181105214537.GA19420@google.com>
 <20181105215650.GG26868@zn.tnic>
 <20181106214256.GA65443@google.com>
 <20181106220059.GA4139@zn.tnic>
 <20181106232040.GA85755@google.com>
 <20181107091838.GA10835@zn.tnic>
 <20181107133856.GA238955@google.com>
 <20181107160707.GA14169@zn.tnic>
 <20181107171044.GA261200@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181107171044.GA261200@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 07, 2018 at 11:10:44AM -0600, Bjorn Helgaas wrote:
> No, the idea was more that that temp monitoring, e.g., k10temp, could
> be independent of amd_nb.
> 
> But I can tell this idea isn't going anywhere, so let's just forget
> that I stuck my neck out and let it die on the vine :)

No no, your idea makes sense. I see the advantage of not having to do
enablement so that old k10temp can load on new machines. Sure.

We just need to find out about the PNP ID...

:-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
