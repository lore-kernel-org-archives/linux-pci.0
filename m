Return-Path: <SRS0=W5ki=4B=cavium.com=Jayachandran.Nair@kernel.org>
Return-Path: <SRS0=W5ki=4B=cavium.com=Jayachandran.Nair@kernel.org>
Date: Tue, 25 Apr 2017 13:03:47 +0000
From: Jayachandran C <jnair@caviumnetworks.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
	Jon Masters <jcm@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 2/2] PCI: quirks: Fix ThunderX2 dma alias handling
Message-ID: <20170425130346.GA30542@localhost>
References: <1492115445-4069-1-git-send-email-jnair@caviumnetworks.com>
 <1492115445-4069-3-git-send-email-jnair@caviumnetworks.com>
 <20170414001911.GA13163@bhelgaas-glaptop.roam.corp.google.com>
 <20170414210646.GA5346@localhost>
 <CAErSpo731xSzrnKF+G+8SA_UUHy7ROA1V9oFkpwKi85GQf9VAg@mail.gmail.com>
 <20170417174712.GA7575@localhost>
 <CAErSpo6+do8GXon3EzZAUpqc2TFsA0BDwWBULqZCd1ayCJhD6w@mail.gmail.com>
 <20170421170414.GA2429@localhost>
 <20170421175705.GB17916@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170421175705.GB17916@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 21, 2017 at 12:57:05PM -0500, Bjorn Helgaas wrote:
> On Fri, Apr 21, 2017 at 05:05:41PM +0000, Jayachandran C wrote:
> > On Fri, Apr 21, 2017 at 10:48:15AM -0500, Bjorn Helgaas wrote:
> > > On Mon, Apr 17, 2017 at 12:47 PM, Jayachandran C
> > > <jnair@caviumnetworks.com> wrote:
> > > > On Fri, Apr 14, 2017 at 09:00:06PM -0500, Bjorn Helgaas wrote:
> 
> > > >> Could you collect "lspci -vv" output from this system?  I'd like to
> > > >> archive that as background for this IOMMU issue and the ASPM tweaks I
> > > >> suspect we'll have to do.  I *wish* we had more information about that
> > > >> VIA thing, because I suspect we could get rid of it if we had more
> > > >> details.
> > > >
> > > > The full logs are slightly large, so I have kept them at:
> > > > https://github.com/jchandra-cavm/thunderx2/blob/master/logs/
> > > > The lspci -vv output is lspci-vv.txt and lspci -tvn output is lspci-tvn.txt
> > > >
> > > > The output is from 2 socket system, the cards are not on the first slot
> > > > like the example above, so the bus and device numbers are different.
> > > 
> > > Can somebody with this system collect the "lspci -xxxx" output as well?
> > > 
> > > I'm making some lspci changes to handle the PCI-to-PCIe bridge
> > > correctly, and I can use the "lspci -xxxx" output to create an lspci
> > > test case.
> > 
> > [Sorry was AFK for a few days]
> > 
> > I have updated the above directory with the log. Also tested your next branch
> > and it works fine on ThunderX2.
> 
> Thanks!
> 
> With regard to my lspci changes, they add "Slot-" here:
> 
>    01:0a.0 PCI bridge: Broadcom Corporation Device 9039
>    ...
>   -   Capabilities: [40] Express (v2) PCI/PCI-X to PCI-Express Bridge, MSI 00
>   +   Capabilities: [40] Express (v2) PCI/PCI-X to PCI-Express Bridge (Slot-), MSI 00
> 
> for all your PCI-to-PCIe bridges.  I assume the "Slot-" is correct, i.e.,
> the link is not connected to a slot, right?  This comes from the "Slot
> Implemented" bit in the PCIe Capabilities Register.

Yes, Slot- should be correct.
 
> I did notice that all the Root Port devices claim to *not* be connected to
> slots, which doesn't seem right.  For example,
> 
>   12:00.0 PCI bridge: Broadcom Corporation Device 9084
>       Bus: primary=12, secondary=13, subordinate=14, sec-latency=0
>       Capabilities: [ac] Express (v2) Root Port (Slot-), MSI 00
> 
>   13:00.0 Ethernet controller: Intel Corporation 82599EB 10-Gigabit SFI/SFP+ Network Connection
> 
> It seems strange because the 12:00.0 Root Port looks like it probably
> *does* lead to a slot where the NIC is plugged in.  Or is that NIC really
> soldered down?
> 
> But I assume there are *some* PCIe slots, so at some of those Root Ports
> should advertise "Slot+" (which by itself does not imply hotplug support,
> if that's the concern).

The Root Ports are connected to a slot, so I am not sure why the slot implemented
bit is not set. There seems to be nothing useful in the slot capabilites, so this
may be ok for now. I have reported this to the hardware team.

Thanks for the review and the comments,
JC.
