Return-Path: <SRS0=PvdH=CF=axon.tv=ruben.guerra.marin@kernel.org>
Return-Path: <SRS0=PvdH=CF=axon.tv=ruben.guerra.marin@kernel.org>
From: Ruben Guerra Marin <ruben.guerra.marin@axon.tv>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Michal Simek <michal.simek@xilinx.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "soren.brinkmann@xilinx.com"
	<soren.brinkmann@xilinx.com>, "bharat.kumar.gogada@xilinx.com"
	<bharat.kumar.gogada@xilinx.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: Performance issues writing to PCIe in a Zynq
Date: Tue, 7 Nov 2017 09:04:14 +0000
Message-ID: <1510045454475.74232@axon.tv>
References: <1509636637116.27702@axon.tv>
 <eca01e58-3da1-d5c4-00f7-71dd6a926870@xilinx.com>
 <20171103135457.GA8457@bhelgaas-glaptop.roam.corp.google.com>
 <1509958288489.45871@axon.tv>,<20171106173549.GB31930@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171106173549.GB31930@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

> Which PCI host bridge driver are you using?=0A=
Indeed I am using drivers/pci/host/pcie-xilinx.c=0A=
=0A=
> Can you do any profiling to figure out where the time is going?=0A=
So I did some profiling on the mcap application, and traced the bottleneck =
in a write call to pciutils. I added some debug to pciutils and could trace=
 it that the bottleneck is in a function called pwrite, which pretty much d=
oes this:=0A=
=0A=
syscall(SYS_pwrite, fd, buf, size, where);=0A=
=0A=
until now this is the last part I could trace it to.=0A=
=0A=
Ruben Guerra Marin=0A=
ruben.guerra.marin@axon.tv=0A=
=0A=
________________________________________=0A=
From: Bjorn Helgaas <helgaas@kernel.org>=0A=
Sent: Monday, November 6, 2017 6:35 PM=0A=
To: Ruben Guerra Marin=0A=
Cc: Michal Simek; bhelgaas@google.com; soren.brinkmann@xilinx.com; bharat.k=
umar.gogada@xilinx.com; linux-pci@vger.kernel.org; linux-arm-kernel@lists.i=
nfradead.org=0A=
Subject: Re: Performance issues writing to PCIe in a Zynq=0A=
=0A=
On Mon, Nov 06, 2017 at 08:51:28AM +0000, Ruben Guerra Marin wrote:=0A=
> Hi, according to Xilinx, from a computer host it happens in a=0A=
> second, while for us in the Zynq (ARM) takes way more than that as=0A=
> explained before. And indeed the programming is done via config=0A=
> accesses, and can't happen otherwise as this is the way Xilinx=0A=
> created its FPGA IP (Intellectual Property) cores. Still if I do a=0A=
> baremetal test (so no Linux) and write from the ARMs to the FPGA via=0A=
> those registers, it takes only 17 cycles instead of the Linux=0A=
> implementation which takes 250 cycles.=0A=
=0A=
Which PCI host bridge driver are you using?=0A=
=0A=
If you're using drivers/pci/host/pcie-xilinx.c, it uses=0A=
pci_generic_config_write(), which doesn't contain anything that looks=0A=
obviously expensive (except for the __iowmb() inside writeq(), and=0A=
it's hard to do much about that).=0A=
=0A=
There is the pci_lock that's acquired in pci_bus_read_config_dword()=0A=
(see drivers/pci/access.c).  As I mentioned before, it looks like=0A=
xilinx could probably use the CONFIG_PCI_LOCKLESS_CONFIG strategy to=0A=
get rid of that lock.  Not sure how much that would buy you since=0A=
there's probably no contention, but you could experiment with it.=0A=
=0A=
It sounds like you have some user-level code involved, too; I don't=0A=
know anything about what that code might be doing.=0A=
=0A=
Can you do any profiling to figure out where the time is going?=0A=
=0A=
> From: Bjorn Helgaas <helgaas@kernel.org>=0A=
> Sent: Friday, November 3, 2017 2:54 PM=0A=
> To: Michal Simek=0A=
> Cc: Ruben Guerra Marin; bhelgaas@google.com; soren.brinkmann@xilinx.com; =
bharat.kumar.gogada@xilinx.com; linux-pci@vger.kernel.org; linux-arm-kernel=
@lists.infradead.org=0A=
> Subject: Re: Performance issues writing to PCIe in a Zynq=0A=
>=0A=
> On Fri, Nov 03, 2017 at 09:12:04AM +0100, Michal Simek wrote:=0A=
> > On 2.11.2017 16:30, Ruben Guerra Marin wrote:=0A=
> > >=0A=
> > > I have the a Zynq board running petalinux, and it is connected=0A=
> > > through PCIe to a Virtex Ultrascale board. I configured the=0A=
> > > Ultrascale for Tandem PCIe, which the second stage bitstream is=0A=
> > > being programmed from the Zynq board (I crossed compiled the mcap=0A=
> > > application that Xilinx provides).=0A=
> > >=0A=
> > > This works perfectly, but takes around ~12 seconds to program the=0A=
> > > second stage bitstream (compressed is ~12 MB), which is quite=0A=
> > > slow. We also tried debugging the mcap application and pciutils.=0A=
> > > We found out the operation that takes long to execute: In=0A=
> > > pciutils, the instruction to actually call the write to the driver=0A=
> > > (pwrite) takes approximately 6uS, so if you add up this for 12 MB=0A=
> > > then you can see why it takes so long. Why is this so slow? Is=0A=
> > > this maybe a problem with the driver?=0A=
> > >=0A=
> > > For testing, I added an ILA to the AXI bus in between the Zynq GP1=0A=
> > > and the PCIe IP control registers port. I triggered halfway the=0A=
> > > programming of the bitstream using the mcap program provided by=0A=
> > > Xilinx. I can see that it is writing to address x358, which=0A=
> > > according to the *datasheet*=0A=
> > > (https://www.xilinx.com/Attachment/Xilinx_Answer_64761__UltraScale_De=
vices.pdf)=0A=
> > > is the Write Data Register, which is correct (and again, I know=0A=
> > > the whole bitstream gets programmed correctly).=0A=
> > >=0A=
> > > But what I also see is that a "awvalid" being asserted to the next=0A=
> > > one it takes 245 cycles, and I can imagine this is why it takes 12=0A=
> > > seconds to program a 12MB bitstream.=0A=
>=0A=
> How long do you expect this to take?  What are the corresponding times=0A=
> on other hardware or other OSes?=0A=
>=0A=
> It sounds like this programming is done via config accesses, which are=0A=
> definitely not a fast path, so I don't know if 12s is unreasonably=0A=
> slow or not.  The largest config write is 4 bytes, which means 12MB=0A=
> requires 3M writes, and if each takes 6us, that's 18s total.=0A=
>=0A=
> Most platforms serialize config accesses with a lock, which also slows=0A=
> things down.  It looks like your hardware might support ECAM, which=0A=
> means you might be able to remove the locking overhead by using=0A=
> lockless config (see     CONFIG_    PCI_LOCKLESS_CONFIG).  This is a new=
=0A=
> feature currently only used by x86, and it's currently a system-wide=0A=
> compile-time switch, so it would require some work for you to use it.=0A=
>=0A=
> The high bandwidth way to do this would be use a BAR and do PCI memory=0A=
> writes instead of PCI config writes.  Obviously the adapter determines=0A=
> whether this is possible.=0A=
>=0A=
> Bjorn=0A=
