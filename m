Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F363DC43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 10:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30FF2250F
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 10:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30FF2250F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbeKMUeZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:34:25 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51744 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732292AbeKMUeZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Nov 2018 15:34:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EAD01596;
        Tue, 13 Nov 2018 02:36:55 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C209E3F5CF;
        Tue, 13 Nov 2018 02:36:53 -0800 (PST)
Date:   Tue, 13 Nov 2018 10:36:46 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "joao.pinto@synopsys.com" <joao.pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>
Subject: Re: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
Message-ID: <20181113103646.GA11202@e107981-ln.cambridge.arm.com>
References: <20181106145347.GB19060@e107981-ln.cambridge.arm.com>
 <db3462e2-422c-161a-1f58-135bc4eab7eb@arm.com>
 <1541533217.30311.263.camel@impinj.com>
 <597d9ebd-f95f-0a4d-e1a3-fe79d4333879@arm.com>
 <1541621853.30311.294.camel@impinj.com>
 <268eae88-274e-edfe-5668-5759efae62e6@arm.com>
 <1541706591.30311.308.camel@impinj.com>
 <b4dfa6e0-c569-c669-d3f1-b1016eecefa8@arm.com>
 <f474f03d-4b3f-9175-f91f-327f67060936@synopsys.com>
 <1542071920.30311.411.camel@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542071920.30311.411.camel@impinj.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 13, 2018 at 01:18:41AM +0000, Trent Piepho wrote:

[...]

> > Based on the information provided, its very likely that I should use the
> > PCIE_MSI_INTR0_MASK register instead of PCIE_MSI_INTR0_ENABLE on the
> > dw_pci_bottom_mask() and dw_pci_bottom_unmask() callbacks. As soon as I return
> > from Linux plumbers conference, I will test the system using the
> > PCIE_MSI_INTR0_MASK register.
> 
> Using enable to mask the interrupt is broken.  It will allow an MSI to
> be lost if it arrives while the MSI in not enabled.  It is impossible
> to prevent that from racing against the pci device driver's final check
> that no MSI-signaled condition in the hardware is present.

That's exactly why I raised the point. I would like to understand if
this means that this revert is not enough to fix the underlying issue
or we need this revert AND correct mask/unmask operations.

Thanks,
Lorenzo
