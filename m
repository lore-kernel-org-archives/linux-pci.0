Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:57461 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755599AbaBFL3A (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Feb 2014 06:29:00 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Will Deacon <will.deacon@arm.com>
Cc: Anup Patel <anup@brainfault.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"mohit.kumar@st.com" <mohit.kumar@st.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
Date: Thu, 06 Feb 2014 12:28:20 +0100
Message-ID: <2047274.53Y3xD1lQ0@wuerfel>
In-Reply-To: <20140206110016.GI26035@mudshark.cambridge.arm.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com> <20140206105442.GB4993@e106497-lin.cambridge.arm.com> <20140206110016.GI26035@mudshark.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 06 February 2014 11:00:16 Will Deacon wrote:
> On Thu, Feb 06, 2014 at 10:54:42AM +0000, Liviu Dudau wrote:
> > On Thu, Feb 06, 2014 at 08:54:03AM +0000, Anup Patel wrote:
> > > On Tue, Feb 4, 2014 at 10:23 PM, Will Deacon <will.deacon@arm.com> wrote:
> > 
> > This is another reason why I prefer the reg property for specifying the configuration
> > space address range. I don't see a straight way of making the distinction you
> > need using the ranges property.
> 
> Well if we need to distinguish cam vs ecam, then adding ioport to the mix
> should be (conceptually) easy and I don't think it would involve the "reg"
> property.
> 
> However, I'm not planning to add ioport support myself.

Maybe it's better to have separate compatible strings for these cases,
can call it "pci-ecam-generic" or "pci-cam-generic" to have an easy
distinction. Or we just use the "reg-names" property so the device
can have a "cam" register or an "ecam" register or both.

I don't think we can make the driver generic enough for
x86 as Anup suggests though, since x86 has its own set of quirks to
deal with the various PCI config space access methods.

	Arnd
