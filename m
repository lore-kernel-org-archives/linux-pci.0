Return-Path: <SRS0=MCOJ=OA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B8FC43441
	for <linux-pci@archiver.kernel.org>; Wed, 21 Nov 2018 14:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3EE92147D
	for <linux-pci@archiver.kernel.org>; Wed, 21 Nov 2018 14:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3EE92147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbeKVAwJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:52:09 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51212 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbeKVAwI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Nov 2018 19:52:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAB3E22F8;
        Wed, 21 Nov 2018 06:17:32 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E974A3F575;
        Wed, 21 Nov 2018 06:17:30 -0800 (PST)
Date:   Wed, 21 Nov 2018 14:17:25 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "stefan@agner.ch" <stefan@agner.ch>,
        Trent Piepho <tpiepho@impinj.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v3 2/2] PCI: imx6: limit DBI register length
Message-ID: <20181121141725.GA24537@e107981-ln.cambridge.arm.com>
References: <20181120165626.26424-1-stefan@agner.ch>
 <20181120165626.26424-2-stefan@agner.ch>
 <581b9548043d5276f6685f534386180fd0673a9a.camel@nxp.com>
 <1542741198.30311.608.camel@impinj.com>
 <268e109e1c6b309454bd5a313078894c@agner.ch>
 <1542749302.30311.624.camel@impinj.com>
 <VI1PR04MB5533BBC2B45752ED84E4D037EEDA0@VI1PR04MB5533.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB5533BBC2B45752ED84E4D037EEDA0@VI1PR04MB5533.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 21, 2018 at 01:47:05PM +0000, Leonard Crestez wrote:
> On 11/20/2018 11:28 PM, Trent Piepho wrote:
> > On Tue, 2018-11-20 at 21:42 +0100, Stefan Agner wrote:
> >> On 20.11.2018 20:13, Trent Piepho wrote:
> 
> >>> It also seems to me that this doesn't need to be in the internal pci
> >>> config access functions.  The driver shouldn't be reading registers
> >>> that don't exist anyway.  It's really about trying to fix sysfs access
> >>> to registers that don't exist.  So maybe it should be done there.
> >>
> >> That was my first approach, see:
> > 
> > Yes, but that just used the pci device id which applies to every IMX
> > design.
> > 
> > It's also not totally correct, as it seems real registers after 0x200
> > do work on imx6, and that would prevent access to them.
> 
> I see that Lorenzo already accepted the patch in pci/dwc:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/commit/?h=pci/dwc&id=f14eaec153aaebbe940ddd21e4198cc2abc927c2
> 
> My tests show that this series breaks pci cards on 6qdl and I think it 
> should be reverted until a fix is found. Are you OK with this?

I will drop the patches from the PCI queue.

Lorenzo
