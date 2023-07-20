Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09367EB64DD
	for <linux-pci@archiver.kernel.org>; Thu, 20 Jul 2023 08:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjGTIHR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Jul 2023 04:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjGTIHN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 04:07:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CF52684
        for <linux-pci@vger.kernel.org>; Thu, 20 Jul 2023 01:07:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 062D96191C
        for <linux-pci@vger.kernel.org>; Thu, 20 Jul 2023 08:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEDCC433C8;
        Thu, 20 Jul 2023 08:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689840430;
        bh=vi5MjxIZvlklMNcaihqDgE+Ey3S6LNVaabLJhEHYLuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cPC6z0kskbvUNcv4M115MOTVLtsbglt8rK0i2KRR6rqcbgdsjw72deZsM6++xwAVZ
         nVG1uYY0fGPiSkZiWHkeOi2s8SU6PO1IB5U2L7QD8umvNiGttBCAC2A1UHOYmBhe8d
         WZqLWXfXCfmD8A7uLXQ0yFn+AmIK90Duq8fOkVWFMUnpxKfNWmYatXDzPpuJhyrIld
         +SwKbKFQdZqsrlnoqWHc8z2rcJEPqGuQpW9Y+Bf9+H1vT3xoPPsXJb7eDYPRx+BVjH
         M9g1ctOVesaK8lVtNqBlQxEWzrWv761zKFUM/IqfBAtKESy3l/zjgUiqco53fbF+xJ
         a45N+IOMY/nOg==
Date:   Thu, 20 Jul 2023 10:07:05 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     daire.mcnamara@microchip.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/8] PCI: microchip: Fixes and clean-ups
Message-ID: <ZLjrKTLhNhPhlEbg@lpieralisi>
References: <20230630154859.2049521-1-daire.mcnamara@microchip.com>
 <20230719-roster-preheated-799d7e103ddb@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230719-roster-preheated-799d7e103ddb@spud>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 19, 2023 at 06:00:37PM +0100, Conor Dooley wrote:
> Hey folks,
> 
> On Fri, Jun 30, 2023 at 04:48:51PM +0100, daire.mcnamara@microchip.com wrote:
> > From: Daire McNamara <daire.mcnamara@microchip.com>
> > 
> > This patch series contains fixes and clean-ups for the Microchip PolarFire SoC PCIe driver
> > 
> > These patches are extracted from the link below to separate them from the outbound and inbound
> > range handling which is taking considerable time.
> > Link: https://lore.kernel.org/linux-riscv/20230111125323.1911373-1-daire.mcnamara@microchip.com/
> > 
> > These patches are regenerated on v6.4-rc6.
> > 
> > Main Changes from v1:
> > - Dropped "Remove cast warning for devm_add_action_or_reset()". This
> >   has been overtaken by a patch series from Krzysztof Wilczynski.
> > - Improved the comment for "Enable building driver as a module" to
> >   clarify what enables building the driver as a module.
> > - Split "Gather MSI information from hardware config registers",
> >   for clarity, into:
> >    - "Gather MSI information from hardware config registers" purely
> >       changing the of source of MSI-related information (Num MSIs and
> >       MSI address) from #defines (which can be incorrect) to FPGA
> >       configuration registers (which is the ultimate source of truth),
> >       and a
> >    - "Rename and refactor ..." patch as a function's code is now clearly
> >       unrelated to its current name.
> 
> This series has been sitting with reviews (albeit from myself) for a
> couple of weeks. What's missing to get this series picked up?

We are at v6.5-rc2 - fixes are not urgent, there is nothing missing
other than us going through the patch queue and review it/pick it up.

Thanks,
Lorenzo

> Thanks,
> Conor.
> 
> > cc: Conor Dooley <conor.dooley@microchip.com>
> > cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > cc: "Krzysztof Wilczyński" <kw@linux.com>
> > cc: Rob Herring <robh@kernel.org>
> > cc: Bjorn Helgaas <bhelgaas@google.com>
> > cc: linux-riscv@lists.infradead.org
> > cc: linux-pci@vger.kernel.org
> > 
> > Daire McNamara (8):
> >   PCI: microchip: Correct the DED and SEC interrupt bit offsets
> >   PCI: microchip: Enable building driver as a module
> >   PCI: microchip: Align register, offset, and mask names with hw docs
> >   PCI: microchip: Enable event handlers to access bridge and ctrl ptrs
> >   PCI: microchip: Clean up initialisation of interrupts
> >   PCI: microchip: Gather MSI information from hardware config registers
> >   PCI: microchip: Rename and refactor mc_pcie_enable_msi()
> >   PCI: microchip: Re-partition code between probe() and init()
> > 
> >  drivers/pci/controller/Kconfig               |   2 +-
> >  drivers/pci/controller/pcie-microchip-host.c | 402 +++++++++++--------
> >  2 files changed, 238 insertions(+), 166 deletions(-)
> > 
> > 
> > base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
> > -- 
> > 2.25.1
> > 


