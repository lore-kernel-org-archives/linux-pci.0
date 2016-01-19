Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:52748 "EHLO mail5.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755809AbcASET7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 18 Jan 2016 23:19:59 -0500
Date: Mon, 18 Jan 2016 23:19:44 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Simon Horman <horms@verge.net.au>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	<linux-pci@vger.kernel.org>, <linux-sh@vger.kernel.org>
Subject: Re: [PATCH 0/2] drivers/pci: use builtin_platform_driver in renesas
Message-ID: <20160119041943.GB1696@windriver.com>
References: <1450745949-23882-1-git-send-email-paul.gortmaker@windriver.com>
 <20160108203737.GJ5354@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20160108203737.GJ5354@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Re: [PATCH 0/2] drivers/pci: use builtin_platform_driver in renesas] On 08/01/2016 (Fri 14:37) Bjorn Helgaas wrote:

> On Mon, Dec 21, 2015 at 07:59:07PM -0500, Paul Gortmaker wrote:
> > These two commits are extracted from what was a larger series[1] of
> > demodularization in PCI host code that was bool Kconfig.
> > 
> > With the other commits, there was some mixed opinions whether we
> > should make it explicitly non-modular or move towards making it
> > functionally working as a tristate in order to reduce the size of
> > built-in code for multi-platform kernels.
> > 
> > However with the renesas changes, there was no ".remove" and no
> > "module_exit" code stripped out ; it is just a straight 1:1 mapping
> > of the modular macros onto what they become in the non-modular case
> > anyway -- meaning the runtime remains unchanged.
> 
> Is there any reason these drivers can't be made modular?  I'd rather
> do that, if we can.

Per the above comments, the renesas drivers were a no-op and and got
Ack:  from appropriate people hence why I forked them out of the earlier
bigger series, in thinking they were OK'd and done as-is.

That said, if "be modular, or die trying" is the desired approach for
PCI code, I can do my best to work within that constraint.  It just
won't be the no-op 1:1 mapping that the original proposed changes were.

P.
--

> 
> Bjorn
