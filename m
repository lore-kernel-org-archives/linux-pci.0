Return-Path: <SRS0=UeAH=N3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC91C43441
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 12:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E324B2089D
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 12:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E324B2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389577AbeKPWWz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Nov 2018 17:22:55 -0500
Received: from foss.arm.com ([217.140.101.70]:50452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbeKPWWy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Nov 2018 17:22:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC62280D;
        Fri, 16 Nov 2018 04:10:47 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65C023F718;
        Fri, 16 Nov 2018 04:10:46 -0800 (PST)
Date:   Fri, 16 Nov 2018 12:10:43 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Baruch Siach <baruch@tkos.co.il>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: armada8k: add support for gpio controlled reset
 signal
Message-ID: <20181116121043.GC3228@e107981-ln.cambridge.arm.com>
References: <405efb21a4600efad10413fcf4c72aacce180125.1538570983.git.baruch@tkos.co.il>
 <20181003132811.GC427@lunn.ch>
 <20181003133543.t7laclm5wbj2olhq@sapphire.tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003133543.t7laclm5wbj2olhq@sapphire.tkos.co.il>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 03, 2018 at 04:35:43PM +0300, Baruch Siach wrote:
> Hi Andrew,
> 
> On Wed, Oct 03, 2018 at 03:28:11PM +0200, Andrew Lunn wrote:
> > On Wed, Oct 03, 2018 at 03:49:43PM +0300, Baruch Siach wrote:
> > > This commit adds support for the gpio reset signal binding as described
> > > in the designware-pcie.txt DT binding document. Both the documented
> > > 'reset-gpio' property name, and the more standard 'reset-gpios' name are
> > > supported.
> > 
> > I don't know this code at all, so maybe a dumb question. Why support
> > the old none-standard binding of reset-gpio on new hardware? I'm
> > assuming reset-gpio is marked a deprecated and reset-gpios is
> > recommended?
> 
> This is all hidden behind the devm_gpiod_get_optional() call that only sees 
> the "reset" string. The generic code supports both the new property name and 
> also the older one for backward compatibility. This patch changes nothing in 
> this regard.
> 
> The designware-pcie.txt document mentions the older 'reset-gpio' name. So I 
> mentioned that name as well in the commit log.

I need Thomas' ACK to proceed with this patch.

Thanks,
Lorenzo
