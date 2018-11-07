Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9DBC0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 11:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7F32086B
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 11:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7F32086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeKGUhk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:37:40 -0500
Received: from foss.arm.com ([217.140.101.70]:49120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbeKGUhj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 15:37:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFE42EBD;
        Wed,  7 Nov 2018 03:07:46 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 000393F718;
        Wed,  7 Nov 2018 03:07:44 -0800 (PST)
Date:   Wed, 7 Nov 2018 11:07:39 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "jpinto@synopsys.com" <jpinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>
Subject: Re: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
Message-ID: <20181107110739.GA11586@e107981-ln.cambridge.arm.com>
References: <20181027000028.21343-1-tpiepho@impinj.com>
 <20181106145347.GB19060@e107981-ln.cambridge.arm.com>
 <db3462e2-422c-161a-1f58-135bc4eab7eb@arm.com>
 <1541533217.30311.263.camel@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541533217.30311.263.camel@impinj.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 06, 2018 at 07:40:18PM +0000, Trent Piepho wrote:
> On Tue, 2018-11-06 at 16:00 +0000, Marc Zyngier wrote:
> > 
> > It is hard to decide what the right solution is without understanding
> > exactly what this particular write actually does. It seems to be some
> > form of acknowledgement, but I'm only making an educated guess, and some
> > of the defines suggest that there might be another register for that.
> 
> Unfortunately, there are no docs for this controller.  I've determined
> that it sets a bit in this register when an MSI is received.  Once set,
> it acts as a mask and the controller will generate no interrupts when
> the same MSI is subsequently received.  Writing a 1 to a bit clears
> that mask bit, obviously so that each bit can be cleared atomically vs
> a non-atomic RMW.  The controller does not queue any MSIs received
> while the interrupt was masked.

I would like to understand if this is the expected behaviour across
dwc controllers but to understand that, as Marc mentioned, we would
need some input from Synopsys (if that's not customizable option).

Side note: what's the register at offset PCIE_MSI_INTR0_MASK
supposed to do ? It seems unused in the current kernel, with
a macro name hinting at MSI masking so I am asking.

> > What I'm interested in is the relationship this has with the mask/unmask
> > callbacks, and whether masking the interrupt before acking it would help.
> 
> 
> > 
> > Gustavo, can you help here?
> > 
> > In any way, moving the action of acknowledging the interrupt to its
> > right spot in the kernel (dw_pci_bottom_ack) would be a good start.
> 
> What about stable kernels that don't have the hierarchical API?

We will have to backport the patches.

Lorenzo
