Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303B1C67839
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA21D2086D
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA21D2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbeLJQSB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:18:01 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57422 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbeLJQSB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Dec 2018 11:18:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF65D1596;
        Mon, 10 Dec 2018 08:18:00 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11AD83F6A8;
        Mon, 10 Dec 2018 08:17:58 -0800 (PST)
Date:   Mon, 10 Dec 2018 16:17:53 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@google.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Jingoo Han <jingoohan1@gmail.com>, faiz_abbas@ti.com,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Message-ID: <20181210161753.GA12563@e107981-ln.cambridge.arm.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113225734.8026-1-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 13, 2018 at 10:57:31PM +0000, Marc Zyngier wrote:
> It recently came to light that the Designware PCIe driver is rather
> broken in the way it handles MSI[1]:
> 
> - It masks interrupt by disabling them, meaning that MSIs generated
>   during the masked window are simply lost. Oops.
> 
> - Acking of the currently pending MSI is done outside of the interrupt
>   flow, getting moved around randomly and ultimately breaking the
>   driver. Not great.
> 
> This series attempts to address this by switching to using the MASK
> register for masking interrupts (!), and move the ack into the
> appropriate callback, giving it a fixed place in the MSI handling
> flow.
> 
> Note that this is only compile-tested on my arm64 laptop, as I'm
> travelling and do not have the required HW to test it anyway. I'd
> welcome both review and testing by the interested parties (dwc
> maintainer and users affected by existing bugs).
> 
> Thanks,
> 
> 	M.
> 
> [1] https://patchwork.kernel.org/patch/10657987/
> 
> Marc Zyngier (3):
>   PCI: designware: Use interrupt masking instead of disabling
>   PCI: designware: Take lock when ACKing an interrupt
>   PCI: designware: Move interrupt acking into the proper callback
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 22 ++++++++++++-------
>  1 file changed, 14 insertions(+), 8 deletions(-)

Marc, Gustavo,

I have decided to queue this series - fixed-up as per this thread,
available at:

git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git test/pci-dwc-msi

We allowed enough time for people to test it, we can't leave mainline
broken for the, apparently few, people who care.

I *think* that this is the Fixes: tag to be added to all patches in this
series, @Gustavo please countercheck:

7c5925afbc58 ("PCI: dwc: Move MSI IRQs allocation to IRQ domains
hierarchical API")

I will mark them for stable too and we will work on backports to be
sent in due course.

Thanks,
Lorenzo
