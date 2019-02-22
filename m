Return-Path: <SRS0=XWMu=Q5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93EAC43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 11:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC6D206B6
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 11:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfBVLWq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Feb 2019 06:22:46 -0500
Received: from foss.arm.com ([217.140.101.70]:57968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbfBVLWp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Feb 2019 06:22:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFFCCA78;
        Fri, 22 Feb 2019 03:22:44 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F05EB3F5C1;
        Fri, 22 Feb 2019 03:22:42 -0800 (PST)
Date:   Fri, 22 Feb 2019 11:22:37 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Lu??s Mendes <luis.p.mendes@gmail.com>,
        Leigh Brown <leigh@solinno.co.uk>
Subject: Re: [PATCH 0/2] PCI: fix pci-mvebu after conversion to common bridge
 emul code
Message-ID: <20190222112237.GA630@e107981-ln.cambridge.arm.com>
References: <20190220094841.11129-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220094841.11129-1-thomas.petazzoni@bootlin.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 20, 2019 at 10:48:39AM +0100, Thomas Petazzoni wrote:
> Hello,
> 
> This set of two patches aim at fixing some regression reported by two
> users (Luis and Leigh), that were introduced by the conversion of the
> pci-mvebu driver to the common PCI bridge emulation code shared
> between pci-aardvark and pci-mvebu.
> 
> Due to this conversion, some registers of the PCI configuration that
> used to be read-only are now read-write, making the Linux PCI core
> believe that some features are implemented by the PCI bridge. Namely
> in the case of pci-mvebu, the prefetchable memory base/limit registers
> were read-only, while they are now read-write. Due to this, the Linux
> PCI core now believes it can configure a prefetchable memory area, but
> this is not supported by pci-mvebu, which does not have the logic to
> create the appropriate MBUs windows.
> 
> This set of two commits allow PCI controller code to tell the PCI
> bridge emulation logic about their capabilities. Because we envision
> that other capabilities than prefetchable memory support might need to
> be communicated from the PCI controller code to the PCI bridge
> emulation code in the future, we introduce a "flags" argument, even if
> for now only one flag is supported.
> 
> Lorenzo, let me know what you think about this approach. I am open to
> suggestions if the proposed approach is not satisfying.
> 
> Both patches have been confirmed by Luis and Leigh to fix the
> regression, but I'll let them give a formal Tested-by.
> 
> Best regards,
> 
> Thomas Petazzoni
> 
> Thomas Petazzoni (2):
>   PCI: pci-bridge-emul: Create per-bridge copy of register behavior
>   PCI: pci-bridge-emul: Extend pci_bridge_emul_init() with flags
> 
>  drivers/pci/controller/pci-aardvark.c |  2 +-
>  drivers/pci/controller/pci-mvebu.c    |  2 +-
>  drivers/pci/pci-bridge-emul.c         | 86 ++++++++++++++++++---------
>  drivers/pci/pci-bridge-emul.h         | 13 +++-
>  4 files changed, 73 insertions(+), 30 deletions(-)

I have applied the series to pci/misc for v5.1, thanks.

Lorenzo
