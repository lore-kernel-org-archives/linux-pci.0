Return-Path: <SRS0=Hm5h=NQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B0BC0044C
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 21:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40B720825
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 21:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40B720825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387600AbeKFHEZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:04:25 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43722 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387580AbeKFHEY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 02:04:24 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kPaOpK6EdSaq; Mon,  5 Nov 2018 22:42:39 +0100 (CET)
Received: from zn.tnic (p200300EC2BCD5300329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:5300:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 721A91EC0402;
        Mon,  5 Nov 2018 22:42:39 +0100 (CET)
Date:   Mon, 5 Nov 2018 22:42:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Woods, Brian" <Brian.Woods@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <bhelgaas@google.com>, Pu Wen <puwen@hygon.cn>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/4] x86/amd_nb: add support for newer PCI topologies
Message-ID: <20181105214233.GF26868@zn.tnic>
References: <20181102181055.130531-1-brian.woods@amd.com>
 <20181102181055.130531-3-brian.woods@amd.com>
 <20181105193840.GA26868@zn.tnic>
 <20181105203330.GB27399@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105203330.GB27399@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 05, 2018 at 08:33:34PM +0000, Woods, Brian wrote:
> I think having them togeter is cleaner. If you aren't finding any
> misc IDs, I highly doubt you'll find any root IDs.  There shouldn't
> be much of a difference in how fast the function exits, either way.
> If you want it the other way though, I don't mind changing it.

Yes please. Because this is the usual kernel coding style of calling a
function (or a loop which has some result in this case) and testing that
result immediately after the function call.

> Would
> 
> 		/*
> 		 * If there are more PCI root devices than data fabric/
> 		 * system management network interfaces, then the (N)
> 		 * PCI roots per DF/SMN interface are functionally the
> 		 * same (for DF/SMN access) and N-1 are redundant.  The
> 		 * N-1 PCI roots should be skipped per DF/SMN interface
> 		 * so the DF/SMN interfaces get mapped to the correct
> 		 * PCI root.

You say "correct" as there is a special one. But the text before it says
they're "functionally the same" wrt DF/SMN access so it sounds to me
like we wanna map the first one we find and ignore the others.

I.e., we wanna say

"... so the DF/SMN interfaces get mapped to the *first* PCI root and the
others N-1 ignored."

Or am I misreading this?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
