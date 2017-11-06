Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 6 Nov 2017 11:35:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ruben Guerra Marin <ruben.guerra.marin@axon.tv>
Subject: Re: Performance issues writing to PCIe in a Zynq
Message-ID: <20171106173549.GB31930@bhelgaas-glaptop.roam.corp.google.com>
References: <1509636637116.27702@axon.tv>
 <eca01e58-3da1-d5c4-00f7-71dd6a926870@xilinx.com>
 <20171103135457.GA8457@bhelgaas-glaptop.roam.corp.google.com>
 <1509958288489.45871@axon.tv>
MIME-Version: 1.0
In-Reply-To: <1509958288489.45871@axon.tv>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "bharat.kumar.gogada@xilinx.com" <bharat.kumar.gogada@xilinx.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Michal Simek <michal.simek@xilinx.com>,
 "soren.brinkmann@xilinx.com" <soren.brinkmann@xilinx.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 06, 2017 at 08:51:28AM +0000, Ruben Guerra Marin wrote:
> Hi, according to Xilinx, from a computer host it happens in a
> second, while for us in the Zynq (ARM) takes way more than that as
> explained before. And indeed the programming is done via config
> accesses, and can't happen otherwise as this is the way Xilinx
> created its FPGA IP (Intellectual Property) cores. Still if I do a
> baremetal test (so no Linux) and write from the ARMs to the FPGA via
> those registers, it takes only 17 cycles instead of the Linux
> implementation which takes 250 cycles. 

Which PCI host bridge driver are you using?

If you're using drivers/pci/host/pcie-xilinx.c, it uses
pci_generic_config_write(), which doesn't contain anything that looks
obviously expensive (except for the __iowmb() inside writeq(), and
it's hard to do much about that).

There is the pci_lock that's acquired in pci_bus_read_config_dword()
(see drivers/pci/access.c).  As I mentioned before, it looks like
xilinx could probably use the CONFIG_PCI_LOCKLESS_CONFIG strategy to
get rid of that lock.  Not sure how much that would buy you since
there's probably no contention, but you could experiment with it.

It sounds like you have some user-level code involved, too; I don't
know anything about what that code might be doing.

Can you do any profiling to figure out where the time is going?

> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, November 3, 2017 2:54 PM
> To: Michal Simek
> Cc: Ruben Guerra Marin; bhelgaas@google.com; soren.brinkmann@xilinx.com; bharat.kumar.gogada@xilinx.com; linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: Performance issues writing to PCIe in a Zynq
> 
> On Fri, Nov 03, 2017 at 09:12:04AM +0100, Michal Simek wrote:
> > On 2.11.2017 16:30, Ruben Guerra Marin wrote:
> > >
> > > I have the a Zynq board running petalinux, and it is connected
> > > through PCIe to a Virtex Ultrascale board. I configured the
> > > Ultrascale for Tandem PCIe, which the second stage bitstream is
> > > being programmed from the Zynq board (I crossed compiled the mcap
> > > application that Xilinx provides).
> > >
> > > This works perfectly, but takes around ~12 seconds to program the
> > > second stage bitstream (compressed is ~12 MB), which is quite
> > > slow. We also tried debugging the mcap application and pciutils.
> > > We found out the operation that takes long to execute: In
> > > pciutils, the instruction to actually call the write to the driver
> > > (pwrite) takes approximately 6uS, so if you add up this for 12 MB
> > > then you can see why it takes so long. Why is this so slow? Is
> > > this maybe a problem with the driver?
> > >
> > > For testing, I added an ILA to the AXI bus in between the Zynq GP1
> > > and the PCIe IP control registers port. I triggered halfway the
> > > programming of the bitstream using the mcap program provided by
> > > Xilinx. I can see that it is writing to address x358, which
> > > according to the *datasheet*
> > > (https://www.xilinx.com/Attachment/Xilinx_Answer_64761__UltraScale_Devices.pdf)
> > > is the Write Data Register, which is correct (and again, I know
> > > the whole bitstream gets programmed correctly).
> > >
> > > But what I also see is that a "awvalid" being asserted to the next
> > > one it takes 245 cycles, and I can imagine this is why it takes 12
> > > seconds to program a 12MB bitstream.
> 
> How long do you expect this to take?  What are the corresponding times
> on other hardware or other OSes?
> 
> It sounds like this programming is done via config accesses, which are
> definitely not a fast path, so I don't know if 12s is unreasonably
> slow or not.  The largest config write is 4 bytes, which means 12MB
> requires 3M writes, and if each takes 6us, that's 18s total.
> 
> Most platforms serialize config accesses with a lock, which also slows
> things down.  It looks like your hardware might support ECAM, which
> means you might be able to remove the locking overhead by using
> lockless config (see     CONFIG_    PCI_LOCKLESS_CONFIG).  This is a new
> feature currently only used by x86, and it's currently a system-wide
> compile-time switch, so it would require some work for you to use it.
> 
> The high bandwidth way to do this would be use a BAR and do PCI memory
> writes instead of PCI config writes.  Obviously the adapter determines
> whether this is possible.
> 
> Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
