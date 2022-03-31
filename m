Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498A8C433F5
	for <linux-pci@archiver.kernel.org>; Thu, 31 Mar 2022 07:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiCaHL4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Mar 2022 03:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiCaHLz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 03:11:55 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AA451E3FF;
        Thu, 31 Mar 2022 00:10:07 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 35F8992009C; Thu, 31 Mar 2022 09:10:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 339DB92009B;
        Thu, 31 Mar 2022 08:10:06 +0100 (BST)
Date:   Thu, 31 Mar 2022 08:10:06 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND][PATCH v2 0/4] x86/PCI: Odd generic PIRQ router
 improvements
Message-ID: <alpine.DEB.2.21.2203301527270.22465@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

 This series was dropped from x86/irq due to a bug in a follow-up patch, 
so resending verbatim after re-verification.

 While working on the SiS85C497 PIRQ router I have noticed an odd
phenomenon with my venerable Tyan Tomcat IV S1564D board, where the PCI 
INTD# line of the USB host controller included as function 3 of the PIIX3 
southbridge cannot be routed in the `noapic' mode.  As it turns out the 
reason for this is the BIOS has two individual entries in its PIRQ table 
for two of its three functions, and the wrong one is chosen for routing 
said line.

 Strictly speaking this violates the PCI BIOS specification, but it can be 
easily worked around while preserving the semantics for compliant systems.

 Therefore I have come up with this patch series, which addresses this 
problem with 3/4, adds function reporting to the debug PIRQ table dump 
with 2/4 and also prints a usable physical memory address of the PIRQ 
table in a debug message with 1/4.

 Then 4/4 follows, addressing the inability to use a PIRQ table to route 
interrupts for devices placed behind PCI-to-PCI bridges on option cards, 
and especially where the BIOS has failed to enumerate the whole bus tree 
in the first place.

 See individual change descriptions for further details.

 Please apply.

  Maciej
