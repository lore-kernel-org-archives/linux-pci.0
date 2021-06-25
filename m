Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D1EC2B9F4
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jun 2021 09:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BAFF6141C
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jun 2021 09:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhFYJZh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jun 2021 05:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhFYJZh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jun 2021 05:25:37 -0400
X-Greylist: delayed 121451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Jun 2021 02:23:16 PDT
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB6F8C061574;
        Fri, 25 Jun 2021 02:23:16 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id BD9F792009C; Fri, 25 Jun 2021 11:23:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B9DA992009B;
        Fri, 25 Jun 2021 11:23:14 +0200 (CEST)
Date:   Fri, 25 Jun 2021 11:23:14 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] x86/PCI: Odd generic PIRQ router improvements
Message-ID: <alpine.DEB.2.21.2106240147570.37803@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

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
problem with 3/3, adds function reporting to the debug PIRQ table dump 
with 2/3 and also prints a usable physical memory address of the PIRQ 
table in a debug message with 1/3.

 See individual change descriptions for further details.

 Please apply.

  Maciej
