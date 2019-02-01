Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E1BC282D8
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 17:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F5E20818
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 17:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbfBARNy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:13:54 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35668 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbfBARNy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Feb 2019 12:13:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25A3315BE;
        Fri,  1 Feb 2019 09:13:54 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BDCE3F589;
        Fri,  1 Feb 2019 09:13:52 -0800 (PST)
Date:   Fri, 1 Feb 2019 17:13:49 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        l.stach@pengutronix.de, tpiepho@impinj.com,
        leonard.crestez@nxp.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] PCI: dwc: allow to limit registers set length
Message-ID: <20190201171349.GC22887@e107981-ln.cambridge.arm.com>
References: <20181204165528.15534-1-stefan@agner.ch>
 <20190130175415.GA7715@e107981-ln.cambridge.arm.com>
 <f4f731d928293406e093ae9b23583510@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4f731d928293406e093ae9b23583510@agner.ch>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 31, 2019 at 10:08:11AM +0100, Stefan Agner wrote:
> On 30.01.2019 18:54, Lorenzo Pieralisi wrote:
> > On Tue, Dec 04, 2018 at 05:55:26PM +0100, Stefan Agner wrote:
> >> Add length to the struct dw_pcie and check that the accessors
> >> dw_pcie_(rd|wr)_conf() do not read/write beyond that point.
> >>
> >> Suggested-by: Trent Piepho <tpiepho@impinj.com>
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> ---
> >> Changes in v4:
> >> - Move length check to dw_pcie_rd_conf
> >>
> >>  .../pci/controller/dwc/pcie-designware-host.c    | 16 ++++++++++++++--
> >>  drivers/pci/controller/dwc/pcie-designware.h     |  1 +
> >>  2 files changed, 15 insertions(+), 2 deletions(-)
> > 
> > Hi Stefan,
> > 
> > I wanted to ask you if this series should be considered for v5.1
> > inclusion, it is in the PCI backlog. If it is, let me have a look
> > and if it is OK to go I will likely ask you to rebase it.
> 
> Yes please. With this last change I did not see any regression anymore
> so far.
> 
> Andrey Smirnov picked up the second patch: "PCI: imx6: introduce
> drvdata". Not sure what the plan is with his patchset, if it gets merged
> into v5.1 too then I probably better drop this patch and rebase ontop of
> his series.

Ok, I will get back to you when I merged Andrey's series so that you
can rebase on top of my pci/dwc branch with Andrey's patches applied.

Lorenzo
