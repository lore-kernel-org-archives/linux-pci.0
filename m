Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:60146 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750893AbaDOOru (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Apr 2014 10:47:50 -0400
Date: Tue, 15 Apr 2014 15:47:35 +0100
From: Will Deacon <will.deacon@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"mohit.kumar@st.com" <mohit.kumar@st.com>
Subject: Re: [PATCH 0/3] ARM: PCI: implement virtual PCI host controller
Message-ID: <20140415144735.GM17408@arm.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <20140403220713.GA23545@google.com>
 <20140414171300.GL12916@arm.com>
 <21141977.8ucQJzlJts@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <21141977.8ucQJzlJts@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On Mon, Apr 14, 2014 at 07:48:17PM +0100, Arnd Bergmann wrote:
> On Monday 14 April 2014 18:13:00 Will Deacon wrote:
> > Arnd: Is there anything more you'd like me to do with this series? Given
> > that it would be targetting 3.16, there's still plenty of time to make
> > changes (we talked about extracting some library functions in the past).
> 
> I don't remember the latest status of your patch set, but you might want
> to read the discussions we had about Liviu's patches last week.

The latest status (v5) was that I had something working (I got hung up on
the I/O offset handing), with all feedback addressed. The next step was to
try and move parts into library code, but it looks like Liviu is handling a
lot of that with his arm64 stuff.

> We still haven't figured out exactly how to handle I/O space in the common
> code, but I think we are making progress.

The discussions certainly seem to be making progress.

> We also have discussed some ideas about how to restructure the PCI
> code layer to make it easier to share host drivers across architectures
> and clean up the interfaces in the process.

Ok. Whilst this all sounds good from an arm64 perspective (with Liviu
currently doing the work), it's not clear to me where that leaves my 32-bit
ARM kvmtool code. That was the main reason for me writing this driver, and it
seems a shame to have to wait for all the generic code to be sorted out
before it can be used on AArch32, where there is already a functional
pcibios implementation. The discussions mention things like generic
pci_host_bridge_ops, but having that for arch/arm/ doesn't sound like
something that is imminent.

Of course, I plan to port my driver to the new infrastructure when it lands
(since I want to support arm64), but it would be good to have something for
AArch32 in the meantime.

Will
