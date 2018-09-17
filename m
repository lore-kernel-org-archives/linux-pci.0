Return-Path: <SRS0=obOR=L7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67E2ECE560
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 16:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99701214D5
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 16:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99701214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbeIQWVO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:21:14 -0400
Received: from foss.arm.com ([217.140.101.70]:33832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728143AbeIQWVO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Sep 2018 18:21:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CAEA1596;
        Mon, 17 Sep 2018 09:53:03 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B58E3F557;
        Mon, 17 Sep 2018 09:53:00 -0700 (PDT)
Date:   Mon, 17 Sep 2018 17:52:57 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Anson Huang <anson.huang@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v4 0/6] PCI: imx: Initial imx7d suspend/resume support
Message-ID: <20180917165257.GJ7239@e107981-ln.cambridge.arm.com>
References: <cover.1534264292.git.leonard.crestez@nxp.com>
 <20180917150941.GH7239@e107981-ln.cambridge.arm.com>
 <16d68541fd499dfda88e79d4386be7ad6d0919d9.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16d68541fd499dfda88e79d4386be7ad6d0919d9.camel@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180917165257.L3R-ZSTvTZT6xy4v0KSe9MO5yzjuUGOvVx2U1iQYMCE@z>

On Mon, Sep 17, 2018 at 04:01:21PM +0000, Leonard Crestez wrote:
> On Mon, 2018-09-17 at 16:09 +0100, Lorenzo Pieralisi wrote:
> > On Tue, Aug 14, 2018 at 07:50:14PM +0300, Leonard Crestez wrote:
> 
> > > V4 adds 4 more patches with PME_Turn_Off support on top, using a new
> > > reset bit. I generally try to keep series short but in this case some
> > > planning might be needed to get patches into 4.20.
> > > 
> > > Since the new reset is treated as optional with old DTB there should be
> > > again no problem if reset and pci are merged out of order.
> > > 
> > > Shawn/Philipp/Lorenzo: Would it make sense to merge this series through a
> > > single specific tree, such as the one for imx?
> > 
> > This series is a bit of a mixture of multiple things hard to discern
> > (actually I already merged patch 2 and patch 1 seems completely
> > unrelated).
> > 
> > I would take the series through the PCI tree but I need an ACK for
> > patches 5 and 6, please let me know how you want to handle it.
> 
> Patches 1 and 2 are already in, the rest need review. I can now just
> resend patches 3-6 as a separate series, unless somebody complains
> about spam.

What do you mean by "are already in" ? Patch 2 I queued via the PCI
tree, patch 1 ? Can I drop it from the PCI patch queue ?

I do not think there is any need to resend, I can merge patches 3-4
since they have been reviewed but patches 5 and 6 need review.

Lorenzo

> Multiple separate patches are required because it touches reset + dt +
> pci. I guess adding the include constant should be moved from the dts
> patch to dt-bindings though.
> 
> Merging reset and pci out of order should be fine here and is required
> by DT compatibility rules anyway.
> 
> --
> Regards,
> Leonard
