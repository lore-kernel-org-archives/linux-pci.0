Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:56827 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932312Ab3JONUY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2013 09:20:24 -0400
Received: by mail-we0-f174.google.com with SMTP id u56so8391722wes.5
        for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2013 06:20:23 -0700 (PDT)
From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [RFC] Architecture independent pcibios?
To: Liviu Dudau <Liviu.Dudau@arm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Rob Herring <robherring2@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
	Michal Simek <monstr@monstr.eu>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
In-Reply-To: <20131009090923.GE25606@e102652-lin.cambridge.arm.com>
References: <20131008144211.GA25231@e102652-lin.cambridge.arm.com> <CAErSpo5=sUJDZGm+zHw+b1h_a1YYbaGBshAutAoPBZYUCRbYkw@mail.gmail.com> <525438F6.3090600@gmail.com> <1381264135.645.230.camel@pasglop> <20131009090923.GE25606@e102652-lin.cambridge.arm.com>
Date: Tue, 15 Oct 2013 12:48:27 +0100
Message-Id: <20131015114827.850BCC4009B@trevor.secretlab.ca>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 9 Oct 2013 10:09:23 +0100, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> On Tue, Oct 08, 2013 at 09:28:55PM +0100, Benjamin Herrenschmidt wrote:
> > On Tue, 2013-10-08 at 11:55 -0500, Rob Herring wrote:
> > 
> > > > I wonder if pci_process_bridge_OF_ranges() would fit somewhere in
> > > > drivers/of?  The implementations I looked at are mostly concerned with
> > > > parsing OF resources, and they don't have much to do with PCI
> > > > directly.
> > > 
> > > This was being done until Ben weighed in:
> > > 
> > > https://lkml.org/lkml/2013/5/4/103
> > 
> > Well, I proposed an alternative (better) approach which I of course had
> > no time to actually implement yet :-)
> 
> In order to avoid any confusion, could you please point me again to the
> relevant message(s) where you proposed your approach?
> 
> > 
> > I have done the changes I needed to do to powerpc
> > pci_process_bridge_OF_ranges so it would be possible to move that now to
> > a generic place, but I still think it's not a great idea. It means the
> > pci_controller structure with its resources will have to become generic
> > which somewhat overlaps with the pci_host_bridge that Bjorn introduced,
> > so that's really not great.
> > 
> > I still think an arch with DT and simpler PCI code that powerpc could
> > start looking at the transition to a better model that I hinted at...
> 
> As tempting as it is to start anew and with a cleaner code, I am wary
> that porting the existing platforms to the new code will take longer
> that way. My intentions are to make the (probably infrequent) task of
> adding a new architecture to the PCI infrastructure a simple and
> straighforward task. But adding code for my platform is no guarantee
> that new ones will have an easier job.

In the previous thread I Nacked an approach that creates new code
without making at least two existing platforms (microblaze & powerpc are
the easy targets because they are so similar) use said new code. I know
that makes things harder for you, but not migrating is a bigger
maintenance burden in the long run.

g.

