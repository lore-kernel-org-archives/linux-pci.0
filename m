Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:37313 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932320AbbLRNmO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 18 Dec 2015 08:42:14 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Wolfram Sang <wsa@the-dreams.de>
CC: Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Subject: RE: [PATCH 2/4] PCI: rcar: Support runtime PM link state L1 handling
 in pcie-rcar
Date: Fri, 18 Dec 2015 13:42:08 +0000
Message-ID: <PS1PR06MB1180304088ECF5384C497E40F5E10@PS1PR06MB1180.apcprd06.prod.outlook.com>
References: <1450358557-28376-1-git-send-email-phil.edworthy@renesas.com>
 <1450358557-28376-3-git-send-email-phil.edworthy@renesas.com>
 <20151217133058.GA20372@katana>
In-Reply-To: <20151217133058.GA20372@katana>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Wolfram,

On 17 December 2015 13:31, Wolfram Sang wrote:
> Hi Phil,
> 
> > +		/* Wait until we are in L1 */
> > +		while (!(val & L1FAEG))
> > +			val = rcar_pci_read_reg(pcie, PMSR);
> 
> No timeout?
Since the hardware doesn't support hot plug, I believe this loop will
always exit very quickly. Unless someone has taken a hammer to the HW
of course.
However, point taken. I'll add a timeout.

> Regards,
> 
>    Wolfram

