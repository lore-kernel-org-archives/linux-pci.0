Return-Path: <SRS0=t6io=DL=gmail.com=jim2101024@kernel.org>
Return-Path: <SRS0=t6io=DL=gmail.com=jim2101024@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171215171440.GB32131@red-moon>
References: <1510697532-32828-1-git-send-email-jim2101024@gmail.com>
 <1510697532-32828-2-git-send-email-jim2101024@gmail.com> <20171205205926.GJ23510@bhelgaas-glaptop.roam.corp.google.com>
 <CANCKTBvoXpF-H8Pck5TsH+7tNM=di1-uoedqACE+kjNEAUodYg@mail.gmail.com>
 <20171212211404.GA95453@bhelgaas-glaptop.roam.corp.google.com> <20171215171440.GB32131@red-moon>
From: Jim Quinlan <jim2101024@gmail.com>
Date: Fri, 15 Dec 2017 14:50:41 -0500
Message-ID: <CANCKTBsFQ7iTeaJ9GjELhYrY-e1C12-+b=EMy=p7npZutFVvvQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] SOC: brcmstb: add memory API
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>,
	Brian Norris <computersforpeace@gmail.com>, Russell King <rmk+kernel@armlinux.org.uk>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	Florian Fainelli <f.fainelli@gmail.com>, Jonas Gorski <jonas.gorski@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	Linux-MIPS <linux-mips@linux-mips.org>, linux-pci <linux-pci@vger.kernel.org>,
	Kevin Cernekee <cernekee@gmail.com>, Ralf Baechle <ralf@linux-mips.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
	Gregory Fong <gregory.0xf0@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 15, 2017 at 12:14 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Tue, Dec 12, 2017 at 03:14:04PM -0600, Bjorn Helgaas wrote:
>> [+cc Lorenzo]
>>
>> On Tue, Dec 12, 2017 at 03:53:28PM -0500, Jim Quinlan wrote:
>> > On Tue, Dec 5, 2017 at 3:59 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > > On Tue, Nov 14, 2017 at 05:12:05PM -0500, Jim Quinlan wrote:
>> > >> From: Florian Fainelli <f.fainelli@gmail.com>
>> > >>
>> > >> This commit adds a memory API suitable for ascertaining the sizes of
>> > >> each of the N memory controllers in a Broadcom STB chip.  Its first
>> > >> user will be the Broadcom STB PCIe root complex driver, which needs
>> > >> to know these sizes to properly set up DMA mappings for inbound
>> > >> regions.
>> > >>
>> > >> We cannot use memblock here or anything like what Linux provides
>> > >> because it collapses adjacent regions within a larger block, and here
>> > >> we actually need per-memory controller addresses and sizes, which is
>> > >> why we resort to manual DT parsing.
>> > >>
>> > >> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>> > >> ---
>> > >>  drivers/soc/bcm/brcmstb/Makefile |   2 +-
>> > >>  drivers/soc/bcm/brcmstb/memory.c | 172 +++++++++++++++++++++++++++++++++++++++
>> > >>  include/soc/brcmstb/memory_api.h |  25 ++++++
>> > >>  3 files changed, 198 insertions(+), 1 deletion(-)
>> > >>  create mode 100644 drivers/soc/bcm/brcmstb/memory.c
>> > >>  create mode 100644 include/soc/brcmstb/memory_api.h
>> > >>
>> > >> diff --git a/drivers/soc/bcm/brcmstb/Makefile b/drivers/soc/bcm/brcmstb/Makefile
>> > >> index 9120b27..4cea7b6 100644
>> > >> --- a/drivers/soc/bcm/brcmstb/Makefile
>> > >> +++ b/drivers/soc/bcm/brcmstb/Makefile
>> > >> @@ -1 +1 @@
>> > >> -obj-y                                += common.o biuctrl.o
>> > >> +obj-y                                += common.o biuctrl.o memory.o
>> > >> diff --git a/drivers/soc/bcm/brcmstb/memory.c b/drivers/soc/bcm/brcmstb/memory.c
>> > >> new file mode 100644
>> > >> index 0000000..eb647ad9
>> > >> --- /dev/null
>> > >> +++ b/drivers/soc/bcm/brcmstb/memory.c
>> > >
>> > > I sort of assume based on [1] that every new file should have an SPDX
>> > > identifier ("The Linux kernel requires the precise SPDX identifier in
>> > > all source files") and that the actual text of the GPL can be omitted.
>> > >
>> > > Only a few files in drivers/pci currently have an SPDX identifier.  I
>> > > don't know if that's oversight or work-in-progress or what.
>> > >
>> > > [1] https://lkml.kernel.org/r/20171204212120.484179273@linutronix.de
>> > >
>> >
>> > Bjorn, Did you get a chance to review the other commits of this
>> > submission (V3)?  I would like any additional feedback before I send
>> > out a V4 with SPDX fixes.  Thanks, JimQ
>>
>> Lorenzo is taking over drivers/pci/host/* and he'll no doubt have some
>> comments when he gets to this.  I'll point out a few quick formatting
>> things in the meantime.
>
> I need some time to review the code but overall I am quite worried about
> patches 1 and 4 in particular, it is ok to have platform host bridge
> drivers but we can't rewrite a DMA layer for a specific host bridge, I
> really do not like that - it is just not manageable from a maintenance
> perspective for the mainline kernel.
>
> Lorenzo
Hi Lorenzo,
First I note that the file drivers/pci/host/vmd.c appears to do the
same thing -- rewrite a layer over the DMA ops.  Secondly, there seems
to be no other way to accomplish what we need to do, especially that
will work with ARM, ARM64, and MIPs.  Someone raised the same point
you did and suggested I involve ARM/ARM64 maintainers, so I expanded
my "--to" list to include Russell.  I'm open to ideas.  I've asked the
HW PCIe folks to redesign the controller to accommodate an
identity-map for inbound memory, but it will be a while if that
happens, if ever. --Jim
