Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A140DC433F5
	for <linux-pci@archiver.kernel.org>; Tue,  1 Feb 2022 10:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbiBAKuv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 1 Feb 2022 05:50:51 -0500
Received: from angie.orcam.me.uk ([78.133.224.34]:44326 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236805AbiBAKuv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 05:50:51 -0500
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 23CAD92009C; Tue,  1 Feb 2022 11:50:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 2139F92009B;
        Tue,  1 Feb 2022 10:50:50 +0000 (GMT)
Date:   Tue, 1 Feb 2022 10:50:50 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Nikolai Zhubr <zhubr.2@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     Arnd Bergmann <arnd@kernel.org>,
        Michal Necasek <mnecasek@yahoo.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PING][PATCH v3 0/4] x86/PCI: Improve $PIR and add $IRT PIRQ routing
 support
In-Reply-To: <alpine.DEB.2.21.2201021821480.56863@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2202010143280.58572@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201021821480.56863@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 6 Jan 2022, Maciej W. Rozycki wrote:

>  This is a new patch series made around a discrete patch submitted earlier 
> on that has gone nowhere, which is now 1/4.  That change handles $PIR PIRQ 
> routing tables that lack router device information, fixing the inability 
> to route interrupts with a system using the SiS85C497 ISA bridge.  It has 
> been minimally updated from v1 by including router device information 
> reported with the change description, and by adding Nikolai's Tested-by 
> annotation.

 Ping for:

<https://lore.kernel.org/lkml/alpine.DEB.2.21.2201021821480.56863@angie.orcam.me.uk/>.

 Series re-verified against 5.17-rc2.

  Maciej
