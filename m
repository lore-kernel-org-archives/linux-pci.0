Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:64162 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751242AbaBRTLi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Feb 2014 14:11:38 -0500
Date: Tue, 18 Feb 2014 19:10:50 +0000
From: Will Deacon <will.deacon@arm.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v3 2/3] ARM: bios32: use pci_enable_resource to enable
 PCI resources
Message-ID: <20140218191049.GH2010@mudshark.cambridge.arm.com>
References: <1392726043-31088-1-git-send-email-will.deacon@arm.com>
 <1392726043-31088-3-git-send-email-will.deacon@arm.com>
 <20140218154139.GF21483@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140218154139.GF21483@n2100.arm.linux.org.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 18, 2014 at 03:41:39PM +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 18, 2014 at 12:20:42PM +0000, Will Deacon wrote:
> > This patch moves bios32 over to using the generic code for enabling PCI
> > resources. Since the core code takes care of bridge resources too, we
> > can also drop the explicit IO and MEMORY enabling for them in the arch
> > code.
> > 
> > A side-effect of this change is that we no longer explicitly enable
> > devices when running in PCI_PROBE_ONLY mode. This stays closer to the
> > meaning of the option and prevents us from trying to enable devices
> > without any assigned resources (the core code refuses to enable
> > resources without parents).
> > 
> > Tested-By: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > Tested-by: Jingoo Han <jg1.han@samsung.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Tested acceptably fine here with crudbus-from-hell.
> 
> Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>

Cheers Russell.

Will
