Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC21C77B73
	for <linux-pci@archiver.kernel.org>; Mon,  8 May 2023 13:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjEHNoV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 May 2023 09:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjEHNoV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 09:44:21 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646CB18FE7;
        Mon,  8 May 2023 06:44:20 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CAAF51EC049C;
        Mon,  8 May 2023 15:44:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1683553458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=V9h3wVgD4SvTfC9wzvEApgVi6UevljPbyNre5lUODi0=;
        b=ie7TsdpOxuQSRbBrZut2/TrT34pTCvFbbeX6WL//32rnXRJt1A7A2friwfcuI0TWqq/GLv
        rufVejn/0WXOEs47exhYorZEWCPW/u3kWdOEnThVu4V68GBCk7VOtvNFJGJNG9cBWH19/r
        eM9N/OEzRNBoHXrP4Uhque/Df4O7h5k=
Date:   Mon, 8 May 2023 15:44:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        Richard gong <richard.gong@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] amd_nb: Add PCI ID for family 19h model 78h
Message-ID: <20230508134414.GCZFj8rieNwF1AOerB@fat_crate.local>
References: <20230427053338.16653-1-mario.limonciello@amd.com>
 <20230427053338.16653-2-mario.limonciello@amd.com>
 <7b74c389-97b7-4f56-851b-6ce17950a4d1@roeck-us.net>
 <f2b81356-e702-3026-660f-d9a88edff632@amd.com>
 <084837c4-72c8-be92-fd1c-5ccbd805c559@leemhuis.info>
 <20230508112543.GBZFjcN2oxk4do31w4@fat_crate.local>
 <a8b29619-f1da-4cb9-a5bd-a396b52e159f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8b29619-f1da-4cb9-a5bd-a396b52e159f@roeck-us.net>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 08, 2023 at 06:28:03AM -0700, Guenter Roeck wrote:
> Together with this patch there are now at least two regressions if
> -rc1 whch could have been avoided and may impact testability on
> affected systems.

Are you saying that this patch which fixes s2idle on some random box
should've gone to Linus *immediately*?

And read my mail again:

"Some fixes need longer testing because there have been cases where
a fix breaks something else."

So yes, I disagree with rushing fixes immediately. If they're obvious
- whatever that means - then sure but not all of them are such.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
