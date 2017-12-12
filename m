Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 12 Dec 2017 15:14:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <jim2101024@gmail.com>
Subject: Re: [PATCH v3 1/8] SOC: brcmstb: add memory API
Message-ID: <20171212211404.GA95453@bhelgaas-glaptop.roam.corp.google.com>
References: <1510697532-32828-1-git-send-email-jim2101024@gmail.com>
 <1510697532-32828-2-git-send-email-jim2101024@gmail.com>
 <20171205205926.GJ23510@bhelgaas-glaptop.roam.corp.google.com>
 <CANCKTBvoXpF-H8Pck5TsH+7tNM=di1-uoedqACE+kjNEAUodYg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CANCKTBvoXpF-H8Pck5TsH+7tNM=di1-uoedqACE+kjNEAUodYg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Florian Fainelli <f.fainelli@gmail.com>,
 Linux-MIPS <linux-mips@linux-mips.org>, linux-pci <linux-pci@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Kevin Cernekee <cernekee@gmail.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Russell King <rmk+kernel@armlinux.org.uk>,
 Rob Herring <robh+dt@kernel.org>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 Gregory Fong <gregory.0xf0@gmail.com>, Jonas Gorski <jonas.gorski@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Lorenzo]

On Tue, Dec 12, 2017 at 03:53:28PM -0500, Jim Quinlan wrote:
> On Tue, Dec 5, 2017 at 3:59 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Nov 14, 2017 at 05:12:05PM -0500, Jim Quinlan wrote:
> >> From: Florian Fainelli <f.fainelli@gmail.com>
> >>
> >> This commit adds a memory API suitable for ascertaining the sizes of
> >> each of the N memory controllers in a Broadcom STB chip.  Its first
> >> user will be the Broadcom STB PCIe root complex driver, which needs
> >> to know these sizes to properly set up DMA mappings for inbound
> >> regions.
> >>
> >> We cannot use memblock here or anything like what Linux provides
> >> because it collapses adjacent regions within a larger block, and here
> >> we actually need per-memory controller addresses and sizes, which is
> >> why we resort to manual DT parsing.
> >>
> >> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> >> ---
> >>  drivers/soc/bcm/brcmstb/Makefile |   2 +-
> >>  drivers/soc/bcm/brcmstb/memory.c | 172 ++++++++++++++++++++++++++++++=
+++++++++
> >>  include/soc/brcmstb/memory_api.h |  25 ++++++
> >>  3 files changed, 198 insertions(+), 1 deletion(-)
> >>  create mode 100644 drivers/soc/bcm/brcmstb/memory.c
> >>  create mode 100644 include/soc/brcmstb/memory_api.h
> >>
> >> diff --git a/drivers/soc/bcm/brcmstb/Makefile b/drivers/soc/bcm/brcmst=
b/Makefile
> >> index 9120b27..4cea7b6 100644
> >> --- a/drivers/soc/bcm/brcmstb/Makefile
> >> +++ b/drivers/soc/bcm/brcmstb/Makefile
> >> @@ -1 +1 @@
> >> -obj-y                                +=3D common.o biuctrl.o
> >> +obj-y                                +=3D common.o biuctrl.o memory.o
> >> diff --git a/drivers/soc/bcm/brcmstb/memory.c b/drivers/soc/bcm/brcmst=
b/memory.c
> >> new file mode 100644
> >> index 0000000..eb647ad9
> >> --- /dev/null
> >> +++ b/drivers/soc/bcm/brcmstb/memory.c
> >
> > I sort of assume based on [1] that every new file should have an SPDX
> > identifier ("The Linux kernel requires the precise SPDX identifier in
> > all source files") and that the actual text of the GPL can be omitted.
> >
> > Only a few files in drivers/pci currently have an SPDX identifier.  I
> > don't know if that's oversight or work-in-progress or what.
> >
> > [1] https://lkml.kernel.org/r/20171204212120.484179273@linutronix.de
> >
> =

> Bjorn, Did you get a chance to review the other commits of this
> submission (V3)?  I would like any additional feedback before I send
> out a V4 with SPDX fixes.  Thanks, JimQ

Lorenzo is taking over drivers/pci/host/* and he'll no doubt have some
comments when he gets to this.  I'll point out a few quick formatting
things in the meantime.

> >> @@ -0,0 +1,172 @@
> >> +/*
> >> + * Copyright =A9 2015-2017 Broadcom
> >> + *
> >> + * This program is free software; you can redistribute it and/or modi=
fy
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> >> + * GNU General Public License for more details.
> >> + *
> >> + * A copy of the GPL is available at
> >> + * http://www.broadcom.com/licenses/GPLv2.php or from the Free Softwa=
re
> >> + * Foundation at https://www.gnu.org/licenses/ .

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
