Return-Path: <SRS0=Ab4q=BR=chromium.org=briannorris@kernel.org>
Return-Path: <SRS0=Ab4q=BR=chromium.org=briannorris@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171017233904.GA65743@google.com>
References: <20171012205220.130048-1-briannorris@chromium.org>
 <20171012205220.130048-2-briannorris@chromium.org> <20171013165152.GE25517@bhelgaas-glaptop.roam.corp.google.com>
 <20171017233904.GA65743@google.com>
From: Brian Norris <briannorris@chromium.org>
Date: Tue, 17 Oct 2017 17:56:32 -0700
Message-ID: <CA+ASDXPNcoUE=F+TWsYpxw=e-NcPaqguSRb5fEYC+zoCCdvDvg@mail.gmail.com>
Subject: Re: [PATCH 1/3] Documentation/devicetree: Add pcie-reset-suspend property
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Frank Rowand <frowand.list@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, linux-arm-kernel@lists.infradead.org,
	Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 17, 2017 at 4:39 PM, Brian Norris <briannorris@chromium.org> wrote:
> On Fri, Oct 13, 2017 at 11:51:52AM -0500, Bjorn Helgaas wrote:
> > If so, I really don't want to get involved in that, because that's an
> > issue that needs to be resolved by the vendors and the PCI-SIG.  If we
>
> Judging by conversations with these vendors, I can't really imagine them
> proactively dealing with the PCI-SIG on this. Is that really what you
> think will work best?
>
> I personally believe deferring (i.e., ignoring) the problem will not
> cause any change; badly behaved vendors will just do whatever suits
> them, and system designers will have to figure it out somehow -- ACPI
> systems will have platform-specific behavior hidden in firmware; device
> tree systems will do whatever they want out of tree; and the rare device
> tree system that gets upstream support will either have suboptimal power
> management, or have to have these sorts of conversations again. None of
> that puts pressure on an endpoint vendor to talk to the PCI-SIG.

I'll add a little more to my claim about ACPI systems. I chatted a
little more with another engineer on my team who has dealt with ACPI
firmware for a few generations of Intel platforms. Even among the
latest two platforms he dealt with, there have been two different
sorts of chipset bugs (at the host/root complex side, not just the
endpoint) that have yielded different decisions on how to handle
PERST#. This was opaque to Linux though, since that's how system
firmware rolls :)

I expect this will not be the last discrepancy on how to handle
PERST#. And to my knowledge, none of the above initiated any
discussion with the PCI-SIG.

Brian
