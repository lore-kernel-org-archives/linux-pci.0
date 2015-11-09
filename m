Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:63382 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752252AbbKIJAf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 Nov 2015 04:00:35 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Wolfram Sang <wsa@the-dreams.de>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Simon Horman <horms@verge.net.au>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: pcie-rcar: Fix OF node passed to MSI irq domain
Date: Mon, 9 Nov 2015 09:00:29 +0000
Message-ID: <PS1PR06MB11807448DF30AA68AC10B58BF5150@PS1PR06MB1180.apcprd06.prod.outlook.com>
References: <1446542899-25137-1-git-send-email-phil.edworthy@renesas.com>
 <20151107135951.GD21726@katana>
In-Reply-To: <20151107135951.GD21726@katana>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Wolfram,

On 07 November 2015 14:00, Wolfram wrote:
> On Tue, Nov 03, 2015 at 09:28:19AM +0000, Phil Edworthy wrote:
> > The OF node passed to irq_domain_add_linear() should be a
> > pointer to interrupt controller's device tree node, or NULL,
> > but not the PCI controller's node.
> >
> > This fixes an oops in msi_domain_alloc_irqs() when it tries
> > to call msi_check().
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> 
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Was this the MSI problem you were talking about?
Yes, that was the one.

Thanks for the review & test.
Phil
