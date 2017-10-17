Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out6.electric.net ([192.162.217.192]:63472 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932493AbdJQOpL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2017 10:45:11 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: 'Joe Perches' <joe@perches.com>, Faiz Abbas <faiz_abbas@ti.com>,
        "kishon@ti.com" <kishon@ti.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: dwc: dra7xx: Print link state to console for debug
Date: Tue, 17 Oct 2017 14:45:08 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD00997A7@AcuExch.aculab.com>
References: <1508219031-25592-1-git-send-email-faiz_abbas@ti.com>
 <1508222128.6530.22.camel@perches.com>
In-Reply-To: <1508222128.6530.22.camel@perches.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joe Perches
> Sent: 17 October 2017 07:35
> On Tue, 2017-10-17 at 11:13 +0530, Faiz Abbas wrote:
> > Enable support for printing the LTSSM link state for debugging PCI
> > when link is down.
> []
> > diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> > index 34427a6..7b150b0 100644
> > --- a/drivers/pci/dwc/pci-dra7xx.c
> > +++ b/drivers/pci/dwc/pci-dra7xx.c
> > @@ -98,6 +98,18 @@ struct dra7xx_pcie_of_data {
> >
> >  #define to_dra7xx_pcie(x)	dev_get_drvdata((x)->dev)
> >
> > +static char state[][20] = {
> > +	"DETECT_QUIET", "DETECT_ACT", "POLL_ACTIVE", "POLL_COMPLIANCE",
> > +	"POLL_CONFIG", "PRE_DETECT_QUIET", "DETECT_WAIT", "CFG_LINKWD_START",
> > +	"CFG_LINKWD_ACEPT", "CFG_LANENUM_WAIT", "CFG_LANENUM_ACEPT",
> > +	"CFG_COMPLETE", "CFG_IDLE", "RCVRY_LOCK", "RCVRY_SPEED",
> > +	"RCVRY_RCVRCFG", "RCVRY_IDLE", "L0", "L0S", "L123_SEND_EIDLE",
> > +	"L1_IDLE", "L2_IDLE", "L2_WAKE", "DISABLED_ENTRY", "DISABLED_IDLE",
> > +	"DISABLED", "LPBK_ENTRY", "LPBK_ACTIVE", "LPBK_EXIT",
> > +	"LPBK_EXIT_TIMEOUT", "HOT_RESET_ENTRY", "HOT_RESET", "RCVRY_EQ0",
> > +	"RCVRY_EQ1", "RCVRY_EQ2", "RCVRY_EQ3"
> 
> what's wrong with using the far more typical
> 
> static const char *link_state[] = {
> 	"DETECT_QUIET",
> 	...

Or 4 aligned columns.
Better still used named initialisers:
	[xxx_DETECT_QUIET] = "DETECT_QUIET",
you really don't want an 'off-by-one' in that list.

	David
