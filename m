Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5CAC10F0E
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 16:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB001206BA
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 16:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfDDQ1c (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:27:32 -0400
Received: from foss.arm.com ([217.140.101.70]:35178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbfDDQ1c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Apr 2019 12:27:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0CD5169E;
        Thu,  4 Apr 2019 09:27:31 -0700 (PDT)
Received: from red-moon (unknown [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45C483F557;
        Thu,  4 Apr 2019 09:27:30 -0700 (PDT)
Date:   Thu, 4 Apr 2019 17:27:20 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V5 6/6] PCI: rcar: Fix 64bit MSI message address handling
Message-ID: <20190404162720.GA17233@red-moon>
References: <20190402013307.20912-1-marek.vasut@gmail.com>
 <20190402013307.20912-6-marek.vasut@gmail.com>
 <20190404092833.GA13236@red-moon>
 <267aa1b1-9761-aff7-8462-8efc644083bd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <267aa1b1-9761-aff7-8462-8efc644083bd@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 04, 2019 at 05:48:36PM +0200, Marek Vasut wrote:
> On 4/4/19 11:28 AM, Lorenzo Pieralisi wrote:
> > On Tue, Apr 02, 2019 at 03:33:07AM +0200, marek.vasut@gmail.com wrote:
> >> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> >>
> >> The MSI message address in the RC address space can be 64 bit. The
> >> R-Car PCIe RC supports such a 64bit MSI message address as well.
> >> The code currently uses virt_to_phys(__get_free_pages()) to obtain
> >> a reserved page for the MSI message address, and the return value
> >> of which can be a 64 bit physical address on 64 bit system.
> >>
> >> However, the driver only programs PCIEMSIALR register with the bottom
> >> 32 bits of the virt_to_phys(__get_free_pages()) return value and does
> >> not program the top 32 bits into PCIEMSIAUR, but rather programs the
> >> PCIEMSIAUR register with 0x0. This worked fine on older 32 bit R-Car
> >> SoCs, however may fail on new 64 bit R-Car SoCs.
> >>
> >> Since from a PCIe controller perspective, an inbound MSI is a memory
> >> write to a special address (in case of this controller, defined by
> >> the value in PCIEMSIAUR:PCIEMSIALR), which triggers an interrupt, but
> >> never hits the DRAM _and_ because allocation of an MSI by a PCIe card
> >> driver obtains the MSI message address by reading PCIEMSIAUR:PCIEMSIALR
> >> in rcar_msi_setup_irqs(), incorrectly programmed PCIEMSIAUR cannot
> >> cause memory corruption or other issues.
> >>
> >> There is however the possibility that if virt_to_phys(__get_free_pages())
> >> returned address above the 32bit boundary _and_ PCIEMSIAUR was programmed
> >> to 0x0 _and_ if the system had physical RAM at the address matching the
> >> value of PCIEMSIALR, a PCIe card driver could allocate a buffer with a
> >> physical address matching the value of PCIEMSIALR and a remote write to
> >> such a buffer by a PCIe card would trigger a spurious MSI.
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> >> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> >> Cc: Simon Horman <horms+renesas@verge.net.au>
> >> Cc: Wolfram Sang <wsa@the-dreams.de>
> >> Cc: linux-renesas-soc@vger.kernel.org
> >> To: linux-pci@vger.kernel.org
> >> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> ---
> >> V2: - s/it's/its/ in commit message
> >>     - Add R-B from Geert
> >> V3: - Reworded commit message and thus dropped Geerts R-B
> >> V4: - Add Geert's R-B again
> >> V5: - Rebase on next/master 20190401
> >>     - Use {lower,upper}_32_bits() instead of >> 32
> > 
> > If that's the only reason you resent this series I will add the
> > lower_32_bits() code myself.
> 
> Yes, you asked me to resend the whole series after the bot complained.

https://lists.01.org/pipermail/kbuild-all/2019-April/059428.html

> > Please do not rebase on top of next, apply code on top of a fixed -rc1
> > (we are currently using v5.1-rc1) and if there are dependencies on code
> > already queued do let us know, we will handle conflicts in next
> > ourselves.
> 
> So do you want me to resend this one more time ?

No, in the message above I wanted to say I would make the update
myself.

Regardless, please never send patches aimed at the PCI tree
on top on -next.

Thanks,
Lorenzo
