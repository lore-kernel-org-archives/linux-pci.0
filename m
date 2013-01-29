Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:36746 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753849Ab3A2GQJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Jan 2013 01:16:09 -0500
Date: Mon, 28 Jan 2013 23:16:02 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 07/27] PCI: Add software-emulated host bridge
Message-ID: <20130129061602.GB3339@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <201301282018.17714.arnd@arndb.de>
 <5106F5CB.8050304@wwwdotorg.org>
 <20130128220904.GA21446@obsidianresearch.com>
 <CAErSpo7-qXZTri-T+v4O3rKk9AXjHE4ckkWZ1UT63SC1fG02-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo7-qXZTri-T+v4O3rKk9AXjHE4ckkWZ1UT63SC1fG02-A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 28, 2013 at 07:40:16PM -0700, Bjorn Helgaas wrote:
> On Mon, Jan 28, 2013 at 3:09 PM, Jason Gunthorpe
> <jgunthorpe@obsidianresearch.com> wrote:
> > On Mon, Jan 28, 2013 at 03:03:55PM -0700, Stephen Warren wrote:
> >> On 01/28/2013 01:18 PM, Arnd Bergmann wrote:
> >> > On Monday 28 January 2013, Thomas Petazzoni wrote:
> >> >> From: Thierry Reding <thierry.reding@avionic-design.de>
> >> >>
> >> >> [Thomas Petazzoni:
> >> >>  - Simplify capabilities handling.
> >> >>  - Move to a separate file.
> >> >>  - Fix mask used when writing a 4 bytes value.]
> >> >>
> >> >> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> >> >> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> >> >
> >> > Not even a description why this is needed?
> >> >
> >> > This patch (together with patch 8) seems like the most controversial
> >> > one of the series, so you should better provide a really good reason
> >> > why we would emulate something in software rather than using whatever
> >> > hardware is there.
> >>
> >> At least on Tegra, there is no HW that exposes PCI configuration
> >> registers for the host bridge itself. Only the root ports have exposed
> >> PCI configuration registers. There was some debate re: whether a host
> >> bridge device needed to exist or not. This patch makes such a device
> >> exist if it's required.
> 
> Host bridges are not actually PCI devices on any architecture.  The
> upstream side of a host bridge is by definition not on a PCI bus.  On
> some architectures, it *looks* like the host bridge is a PCI device
> because it responds to PCI config accesses and you can get to

Sure, you can't discover domains through any standard means, but once
you have found a domain (notably a way to issue config transactions)
then the PCI-E standard actually does place requirements on what
config transactions should return:
 - 0:00.0 is a host bridge config space.
 - 0:XX.X will be one of:
   - A root complex internal function, with some restrictions this
     is basically a PCI end device
   - A PCI-PCI bridge with various mandatory capability headers.
     One of these must show up for every physical PCI-E link
     on the root complex.
This collection of stuff on bus 0 is called the 'root complex'. This
is new in PCI-E, PCI-X and PCI didn't have such requirements.

SOC vendors are taking various liberties with their PCI-E implementations.
 - nvidia followed the standard but did not include the host bridge
   at 0:00.0
 - Marvell ignored everything about the root complex config space
   behavior :)

There are two patch sets in this subject, one for nvidia tegra and one
for Marvell, both presenting to Linux a view of the HW that matches
what the PCI-E spec describes - specifically that there is one domain,
and each PCI-E link/controller shows up as a PCI-PCI bridge on bus 0.

In this model, there is no 'host bridge aperture' hardware, each PCI-E
link has a dedicated aperture and control of that aperture is through
the PCI-PCI bridge window registers, again as PCI-E specifies.

Jason
