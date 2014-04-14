Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:49320 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753732AbaDNRNS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Apr 2014 13:13:18 -0400
Date: Mon, 14 Apr 2014 18:13:00 +0100
From: Will Deacon <will.deacon@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"arnd@arndb.de" <arnd@arndb.de>, Liviu Dudau <Liviu.Dudau@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"mohit.kumar@st.com" <mohit.kumar@st.com>
Subject: Re: [PATCH 0/3] ARM: PCI: implement virtual PCI host controller
Message-ID: <20140414171300.GL12916@arm.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <20140403220713.GA23545@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140403220713.GA23545@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

(apologies for the delay, I've been away for a month)

On Thu, Apr 03, 2014 at 11:07:13PM +0100, Bjorn Helgaas wrote:
> On Tue, Feb 04, 2014 at 04:53:01PM +0000, Will Deacon wrote:
> > Hello,
> > 
> > This small set of patches brings PCI support to mach-virt based upon an
> > idealised host controller (see patch 2 for more details).
> > 
> > This has been tested with kvmtool, for which I have a corresponding set
> > of patches which you can find in my kvmtool/pci branch at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/will/kvmtool.git
> > 
> > Once the arm64 PCI patches from Liviu have stabilised, I plan to port
> > this host controller to work there as well.
> > 
> > The main issue I can see with this code is how to describe configuration
> > space in the device-tree. I'm following the ePAPR PCI bindings (SS == 0)
> > , but this adds an ugly 'case 0:' line in the pci range parser, which
> > also exists in mainline for the pcie-designware.c driver.
> 
> There was a long discussion about this (especially 2/3), and I didn't
> follow it closely enough to get the resolution, and I don't think I
> picked up the patches.
> 
> Can you post them again if they're still applicable?

I ended up at v5 of the series:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/237540.html

which hasn't received any feedback. My plan is to get the driver working
with arm64 once Liviu's series is merged, but I'd be happy to see this
merged for 32-bit ARM before then.

Arnd: Is there anything more you'd like me to do with this series? Given
that it would be targetting 3.16, there's still plenty of time to make
changes (we talked about extracting some library functions in the past).

Will
