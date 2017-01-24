Return-Path: <SRS0=F0bw=ZG=redhat.com=lyude@kernel.org>
Return-Path: <SRS0=F0bw=ZG=redhat.com=lyude@kernel.org>
Message-ID: <1485284971.7738.3.camel@redhat.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
From: Lyude Paul <lyude@redhat.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Kilian Singer <kilian.singer@quantumtechnology.info>, David Airlie
	 <airlied@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Peter Jones
	 <pjones@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Wu
	 <peter@lekensteyn.nl>, Bjorn Helgaas <helgaas@kernel.org>, Mika Westerberg
	 <mika.westerberg@linux.intel.com>, linux-pci <linux-pci@vger.kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>
Date: Tue, 24 Jan 2017 14:09:31 -0500
In-Reply-To: <20170124045919.GB27136@wunner.de>
References: <1456065516.8360056.1483572074197.JavaMail.zimbra@redhat.com>
	 <20170105150646.GB21446@wunner.de>
	 <20170105181322.wnvdytpgddcdk3ry@redhat.com>
	 <1931628154.8613274.1483644995907.JavaMail.zimbra@redhat.com>
	 <1483974686.28993.3.camel@redhat.com>
	 <e16ce603-1d40-9aef-c755-5e2e0322668a@redhat.com>
	 <c0d105a6-0913-3293-d98e-17f0461f21ab@quantumtechnology.info>
	 <1304522798.9524227.1484008399844.JavaMail.zimbra@redhat.com>
	 <724341af-4122-8601-8426-ab7cd10a365c@quantumtechnology.info>
	 <1484244635.7089.1.camel@redhat.com> <20170124045919.GB27136@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2017-01-24 at 05:59 +0100, Lukas Wunner wrote:
> On Thu, Jan 12, 2017 at 01:10:35PM -0500, Lyude Paul wrote:
> > Fwiw, danvet showed me a patch he had already submitted that
> > actually
> > fixes this issue as well:
> > 
> > https://patchwork.freedesktop.org/patch/132477/
> > 
> > So we're going to go with that. This doesn't fix the race
> > conditions
> > I've noticed in fbcon(), but danvet suggested that some of the code
> > for
> > that in nouveau should be cleaned up anyway.
fwiw, this should only ever come up if you are manually trying to turn
the GPU on or off using the debugfs interface with vga-switcheroo
> 
> @Lyude:  Since Daniel's patch landed in Linus' tree tonight, what
> else
> is needed to fix the race conditions you mention above that might be
> at
> the root of Kilian's as well as Peter's issues with nouveau?

I'm not sure what you mean here, are you still seeing these issues?
Daniel's patch should be all that's required for fixing this

> 
> See:
> https://bugzilla.kernel.org/show_bug.cgi?id=190861
> https://bugzilla.kernel.org/show_bug.cgi?id=156341
> 
> Could you propose a patch on top of Daniel's fix?
> 
> Thanks,
> 
> Lukas
-- 
Cheers,
	Lyude
