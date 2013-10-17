Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19672 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753811Ab3JQNEt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Oct 2013 09:04:49 -0400
Date: Thu, 17 Oct 2013 09:04:44 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Andrew Lunn' <andrew@lunn.ch>,
	'Gregory Clement' <gregory.clement@free-electrons.com>
Subject: Re: [PATCH V3 3/3] PCI: mvebu: return NULL instead of ERR_PTR(ret)
Message-ID: <20131017130444.GC22434@titan.lakedaemon.net>
References: <000c01ceb816$19f0dd10$4dd29730$%han@samsung.com>
 <000101ceb826$8695b7f0$93c127d0$%han@samsung.com>
 <000001cec986$9f8ef570$deace050$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000001cec986$9f8ef570$deace050$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 15, 2013 at 06:12:07PM +0900, Jingoo Han wrote:
> On Monday, September 23, 2013 3:31 PM, Jingoo Han wrote:
> > 
> > Return NULL instead of ERR_PTR(ret) in order to fix the following
> > sparse warning:
> > 
> > drivers/pci/host/pci-mvebu.c:744:31: warning: incorrect type in return expression (different address
> > spaces)
> > drivers/pci/host/pci-mvebu.c:744:31:    expected void [noderef] <asn:2>*
> > drivers/pci/host/pci-mvebu.c:744:31:    got void *
> > 
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> (+cc Andrew Lunn, Gregory Clement)
> 
> Hi Jason Cooper,
> 
> Would you apply this patch into your 'linux-mvebu.git' tree?
> It was already Acked by Thomas Petazzoni.
> Also, it is a trivial change to fix sparse warning.
> Thank you.

Applied to mvebu/drivers

thx,

Jason.
