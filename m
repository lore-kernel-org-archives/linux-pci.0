Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:51643 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbbKJBVX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2015 20:21:23 -0500
Date: Tue, 10 Nov 2015 10:21:20 +0900
From: Simon Horman <horms@verge.net.au>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pcie-rcar: Fix OF node passed to MSI irq domain
Message-ID: <20151110012120.GI1040@verge.net.au>
References: <1446542899-25137-1-git-send-email-phil.edworthy@renesas.com>
 <20151107135951.GD21726@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151107135951.GD21726@katana>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Nov 07, 2015 at 02:59:51PM +0100, Wolfram Sang wrote:
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

Hi Bjorn,

please feel free to apply.

Acked-by: Simon Horman <horms+renesas@verge.net.au>


