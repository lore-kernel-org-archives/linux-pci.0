Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0148.outbound.protection.outlook.com ([207.46.100.148]:5056
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751085AbcCICOp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 8 Mar 2016 21:14:45 -0500
Date: Tue, 8 Mar 2016 18:39:56 -0600
From: Michael Auchter <michael.auchter@ni.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci: add pci_clear_master() stub for !CONFIG_PCI
Message-ID: <20160309003955.GA1589@tilquin.amer.corp.natinst.com>
References: <1457476481-13654-1-git-send-email-michael.auchter@ni.com>
 <20160308231017.GA11153@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20160308231017.GA11153@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 08, 2016 at 05:10:17PM -0600, Bjorn Helgaas wrote:
> Hi Michael,
> 
> On Tue, Mar 08, 2016 at 04:34:41PM -0600, Michael Auchter wrote:
> > Add a stub for pci_clear_master() for when CONFIG_PCI is not set,
> > similar to what's done for pci_set_master().
> 
> Does this fix a problem?  If so, what is it?  Some driver that doesn't
> build when CONFIG_PCI is not set?

I ran into a build failure caused by this not being defined while
compile testing an out-of-tree driver with various configs. It seemed to
me that the lack of a stub may have just been an oversight from when
pci_clear_master() was added.

It looks like all in-tree users of pci_clear_master() correctly declare
a dependency on PCI via Kconfig, so this doesn't really fix a problem,
just makes pci_clear_master more symmetric with pci_set_master.

Cheers,
 Michael
