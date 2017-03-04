Return-Path: <SRS0=Ymp8=2N=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=Ymp8=2N=wunner.de=lukas@kernel.org>
Date: Sat, 4 Mar 2017 12:14:46 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	platform-driver-x86@vger.kernel.org,
	Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian Koenig <christian.koenig@amd.com>,
	amd-gfx@lists.freedesktop.org, Peter Wu <peter@lekensteyn.nl>,
	Amir Levy <amir.jer.levy@intel.com>
Subject: Re: [PATCH 1/5] PCI: Recognize Thunderbolt devices
Message-ID: <20170304111446.GB3143@wunner.de>
References: <cover.1487938188.git.lukas@wunner.de>
 <c42a235e126f273e9b8712a7154f813f757db507.1487938188.git.lukas@wunner.de>
 <20170224221724.GA26430@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170224221724.GA26430@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 24, 2017 at 04:17:24PM -0600, Bjorn Helgaas wrote:
> On Fri, Feb 24, 2017 at 08:19:45PM +0100, Lukas Wunner wrote:
> > Detect on probe whether a PCI device is part of a Thunderbolt controller.
[...]
> > * If an external Thunderbolt GPU is connected to a dual GPU laptop (Mac
> >   or not), that GPU is currently registered with vga_switcheroo even
> >   though it can neither drive the laptop's panel nor be powered off by
> >   the platform.  To vga_switcheroo it will appear as if two discrete
> >   GPUs are present.  As a result, when the external GPU is runtime
> >   suspended, vga_switcheroo will cut power to the internal discrete GPU
> >   which may not be runtime suspended at all at this moment.  The
> >   solution is to not register external GPUs with vga_switcheroo, which
> >   necessitates a way to recognize if they're on a Thunderbolt daisy
> >   chain.
> 
> If I understand correctly, vga_switcheroo manages two GPUs that have a
> single output: either there's a mux that connects one GPU or the other
> to the output, or one GPU is permanently connected to the output and
> the other does offline rendering.

There are two aspects to hybrid graphics, switching the panel between
GPUs and powering off the discrete GPU.  (Some laptops can also switch
external DP ports between GPUs and some, as you say, cannot switch the
panel and only use the discrete GPU for render offloading.)


> To this non-GPU person, it sounds like the important question is
> whether two GPUs are related in this way (either they feed the same
> mux, or there's some special offline rendering connection between
> them).  That sounds unrelated to the question of how the GPUs
> themselves are connected to the PCI hierarchy.

To the best of my knowledge there's no definite way to determine whether
two GPUs are connected to the same panel via a mux.

There is also no such thing as a special render offloading connection:
Frames are computed on a discrete GPU, then copied over PCIe into the
framebuffer of the integrated GPU.  Whether that discrete GPU is
on-board or externally connected is completely transparent and not
discernible other than by looking at the PCI hierarchy.

The same issue exists for HD Audio controllers integrated into many
discrete GPUs:  To the OS these look like separate PCI functions
and in sound/pci/hda/hda_intel.c:get_bound_vga() we leverage the fact
that the GPU is always function 0 and the HD Audio is function 1 to
discover the GPU corresponding to a particular HD Audio controller.
So again that relationship is deduced from the PCI hierarchy.


> From a pure PCI perspective, I assume it would be conceivable to have
> two Thunderbolt-connected GPUs feeding into a mux.  Or to have a GPU
> (unrelated to the mux) in a non-Thunderbolt plugin slot or connected
> externally via a non-Thunderbolt switch and an iPass cable.

Technically such products would be possible, but I believe they don't
exist.  (Unlike Thunderbolt eGPUs, which have been on the market for
a few years.)

Thanks,

Lukas
