Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:47596 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147AbbIYBVU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2015 21:21:20 -0400
Date: Fri, 25 Sep 2015 10:21:18 +0900
From: Simon Horman <horms@verge.net.au>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	bhelgaas@google.com, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH] pci-rcar-gen2: add R8A7794 support
Message-ID: <20150925012118.GB4106@verge.net.au>
References: <2525770.ZsLzbliFPH@wasted.cogentembedded.com>
 <20150924200720.GD10481@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150924200720.GD10481@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 24, 2015 at 03:07:21PM -0500, Bjorn Helgaas wrote:
> On Sat, Sep 12, 2015 at 02:06:09AM +0300, Sergei Shtylyov wrote:
> > Add Renesas R8A7794 SoC support to the Renesas R-Car gen2 PCI driver.
> > 
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> Applied with Simon's ack to for-linus for v4.3, thanks!
> 
> I applied this for v4.3 instead of v4.4 because this is new hardware
> and I think the chance of breaking anything is minimal.

Thanks! Your logic for queueing this up for v4.3 sounds
entirely reasonable to me.
