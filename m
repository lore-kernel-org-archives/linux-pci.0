Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50D9C64ED6
	for <linux-pci@archiver.kernel.org>; Wed,  1 Mar 2023 13:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCANPE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 1 Mar 2023 08:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCANPD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Mar 2023 08:15:03 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4CC429E1C;
        Wed,  1 Mar 2023 05:15:01 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 6C23792009C; Wed,  1 Mar 2023 14:14:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 5EC1F92009B;
        Wed,  1 Mar 2023 13:14:59 +0000 (GMT)
Date:   Wed, 1 Mar 2023 13:14:59 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PING^3][RESEND^3][PATCH v3] x86/PCI: Add support for the Intel
 82378ZB/82379AB (SIO/SIO.A) PIRQ router
In-Reply-To: <alpine.DEB.2.21.2301081956290.65308@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2303011311540.57556@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2301081956290.65308@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 8 Jan 2023, Maciej W. Rozycki wrote:

> The Intel 82378ZB System I/O (SIO) and 82379AB System I/O APIC (SIO.A) 
> ISA bridges implement PCI interrupt steering with a PIRQ router[1][2] 
> that is exactly the same as that of the PIIX and ICH southbridges (or 
> actually the other way round, given that the SIO ASIC was there first).

 Ping for:
<https://lore.kernel.org/lkml/alpine.DEB.2.21.2301081956290.65308@angie.orcam.me.uk/>.

 I think the patch is fairly obvious.  Are there any outstanding concerns 
that prevent it from being applied?

  Maciej

