Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 15 Mar 2016 14:39:58 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Dave Airlie <airlied@gmail.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 1/2] vga_switcheroo: add power support for windows 10
 machines.
Message-ID: <20160315133958.GA27793@wunner.de>
References: <1457504045-12738-1-git-send-email-airlied@gmail.com>
 <2736217.utxPzJExd5@vostro.rjw.lan>
 <20160311105815.GS1796@lahna.fi.intel.com>
 <2759763.dR5D0KopkA@vostro.rjw.lan>
 <CAPM=9txo4aOOa-CS-mnyQe+vYDtAOCm1bzAgfMzwJJS8ZuYmwQ@mail.gmail.com>
 <20160314094335.GE1796@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160314094335.GE1796@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Mika,

On Mon, Mar 14, 2016 at 11:43:35AM +0200, Mika Westerberg wrote:
> On Mon, Mar 14, 2016 at 12:19:14PM +1000, Dave Airlie wrote:
> > On 11 March 2016 at 23:45, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > On Friday, March 11, 2016 12:58:15 PM Mika Westerberg wrote:
> > >> On Thu, Mar 10, 2016 at 09:57:09PM +0100, Rafael J. Wysocki wrote:
> > >> > > It doesn't seem to do any runtime PM,
> > >> > > I do wonder if pcieport should be doing it's own runtime PM handling,
> > >> > > but that is a
> > >> > > larger task than I'm thinking to tackle here.
> > >> >
> > >> > PCIe ports don't do PM - yet.  Mika has posted a series of patches to implement
> > >> > that, however, that are waiting for comments now:
> > >> >
> > >> > https://patchwork.kernel.org/patch/8453311/
> > >> > https://patchwork.kernel.org/patch/8453381/
> > >> > https://patchwork.kernel.org/patch/8453391/
> > >> > https://patchwork.kernel.org/patch/8453411/
> > >> > https://patchwork.kernel.org/patch/8453371/
> > >> > https://patchwork.kernel.org/patch/8453351/

If a pciehp port is runtime suspended and pciehp_poll_mode is enabled,
the poll timer needs to be disabled and later reenabled on runtime resume.

Don't we need to add runtime pm callbacks to struct pcie_port_service_driver
for that, and call them from pcie_port_runtime_*()?

Best regards,

Lukas
