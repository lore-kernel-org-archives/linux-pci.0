Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:37234 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161077AbaDPOBB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Apr 2014 10:01:01 -0400
Date: Wed, 16 Apr 2014 14:58:50 +0100
From: Will Deacon <will.deacon@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"mohit.kumar@st.com" <mohit.kumar@st.com>
Subject: Re: [PATCH 0/3] ARM: PCI: implement virtual PCI host controller
Message-ID: <20140416135849.GA2005@arm.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <21141977.8ucQJzlJts@wuerfel>
 <20140415144735.GM17408@arm.com>
 <10739949.AxKDLcKlhj@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <10739949.AxKDLcKlhj@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 15, 2014 at 04:26:39PM +0100, Arnd Bergmann wrote:
> On Tuesday 15 April 2014 15:47:35 Will Deacon wrote:
> > > We also have discussed some ideas about how to restructure the PCI
> > > code layer to make it easier to share host drivers across architectures
> > > and clean up the interfaces in the process.
> > 
> > Ok. Whilst this all sounds good from an arm64 perspective (with Liviu
> > currently doing the work), it's not clear to me where that leaves my 32-bit
> > ARM kvmtool code. That was the main reason for me writing this driver, and it
> > seems a shame to have to wait for all the generic code to be sorted out
> > before it can be used on AArch32, where there is already a functional
> > pcibios implementation. The discussions mention things like generic
> > pci_host_bridge_ops, but having that for arch/arm/ doesn't sound like
> > something that is imminent.
> > 
> > Of course, I plan to port my driver to the new infrastructure when it lands
> > (since I want to support arm64), but it would be good to have something for
> > AArch32 in the meantime.
> 
> Agreed. You'll probably have to add a few #ifdef until we have the
> infrastructure in place. However, I'd prefer not having to do that for
> a lot of other drivers. It's only a matter of time until someone wants
> one of the existing arm32 drivers to work on arm64, and we really
> shouldn't have to duplicate a lot of #ifdef logic across them, just
> to deal with the architectures being different.

Ok, cheers Arnd. I'll repost the patches sometime next week.

Will
