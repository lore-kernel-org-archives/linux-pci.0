Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:51547 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbbKJBP5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2015 20:15:57 -0500
Date: Tue, 10 Nov 2015 10:15:53 +0900
From: Simon Horman <horms@verge.net.au>
To: Rob Herring <robh@kernel.org>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar (usb): DT can override default window settings
Message-ID: <20151110011553.GH1040@verge.net.au>
References: <1446567566-10952-1-git-send-email-phil.edworthy@renesas.com>
 <20151105134947.GA26919@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151105134947.GA26919@rob-hp-laptop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 05, 2015 at 07:49:47AM -0600, Rob Herring wrote:
> On Tue, Nov 03, 2015 at 04:19:26PM +0000, Phil Edworthy wrote:
> > If the dtb specifies dma-ranges, we use those values. Otherwise, we
> > default to the values that were previously hardcoded into the driver.
> > 
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> >  .../devicetree/bindings/pci/pci-rcar-gen2.txt      |  6 ++
> 
> Acked-by: Rob Herring <robh@kernel.org>

Bjorn,

this looks good to me. Please feel free to apply.

Acked-by: Simon Horman <horms+renesas@verge.net.au>
