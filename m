Return-Path: <fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
Date: Thu, 6 Oct 2016 17:27:08 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, shawn.lin@rock-chips.com, luto@kernel.org,
	Sergey.Semin@t-platforms.ru, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] PCI: Fix kernel panic of root-port-less PCIe enum due to
 ASPM
Message-ID: <20161006142708.GA12584@mobilestation>
References: <1475746455-20665-1-git-send-email-fancer.lancer@gmail.com>
 <20161006131358.GA1263@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20161006131358.GA1263@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 06, 2016 at 08:13:58AM -0500, Bjorn Helgaas <helgaas@kernel.org> wrote:
> Hi Serge,
> 
> On Thu, Oct 06, 2016 at 12:34:15PM +0300, Serge Semin wrote:
> > Hello linux folks,
> > 
> >     Sometime ago I discovered a kernel panic popping up when PCI subsystem was
> > trying to enumerate PCI express bus with ASPM service enabled. Here it is:
> > 
> > [    5.089667] CPU 0 Unable to handle kernel paging request at virtual
> > address 00000060, epc == 80317004, ra == 80316ac8
> > [    5.120952] Oops[#1]:
> >           ...
> > [    5.528438] Call Trace:
> > [    5.535640] [<80317004>] pcie_aspm_init_link_state+0x6c0/0x814
> > [    5.552843] [<80300c44>] pci_scan_slot+0x140/0x148
> > [    5.566957] [<80301dcc>] pci_scan_child_bus+0x50/0x1b0
> > [    5.582096] [<80301944>] pci_scan_bridge+0x25c/0x694
> > [    5.596724] [<80301e78>] pci_scan_child_bus+0xfc/0x1b0
> > [    5.611862] [<80301944>] pci_scan_bridge+0x25c/0x694
> > [    5.626488] [<80301e78>] pci_scan_child_bus+0xfc/0x1b0
> > [    5.641628] [<8030215c>] pci_scan_root_bus+0x64/0x124
> > [    5.656528] [<804ca298>] pcibios_scanbus+0xa8/0x188
> > 
> >     I more than sure you are familiar with the issue, since I've found the
> > mailing discussion: "PCI: avoid NULL deref in alloc_pcie_link_state"
> > https://patchwork.kernel.org/patch/2751651/
> > https://bugzilla.kernel.org/show_bug.cgi?id=60111
> > 
> >     You closed the bugzilla ticket with the next statement:
> > "I'm closing this as invalid because the simulated machine where the problem
> > occurs has an invalid PCIe topology (an Upstream Port with no Downstream Port
> > or Root Port above it).  As far as I know, there is no valid topology, e.g.,
> > a real hardware machine in the field, that would cause this failure."
> > 
> >     I'm strongly disagree with it, since I've got at least two hardware with
> > PCIe-bus hierarchy as described in the mailing list. One of them is based on
> > Cavium Octeon III CN7020. Here is a ASCII-diagram of PCIe-bus:
> 
> Thanks for this information.  I reopened that bugzilla; can you attach
> complete dmesg logs and "lspci -vv" output for your systems?  As I
> mentioned in comment #4, I'm completely open to fixing this.  My
> objections at the time were (1) there was no known hardware that could
> trigger the problem, and (2) the proposed fix was ugly and prone to
> future breakage.  Since we now have real systems that trip over this,
> we need to revisit it.
> 
> Bjorn
> 

Done. Welcome back to the bugzilla thread.

-Serge

> > -+-[0000:01]---00.0-[02-06]--+-02.0-[03-05]--+-00.0-[04-05]----00.0-[05]--
> >  |                           |               \-00.1  Device [111d:808f]
> >  |                           \-04.0-[06]----00.0  Device [126f:0750]
> >  \-[0000:00]-
> > 
> > where 01:00.0 is an Upstream port of IDT PCIe-swtich.
> > / # /usr/local/sbin/lspci -v -s 01:00.0
> > 01:00.0 Class 0604: Device 111d:8061
> >         Flags: bus master, fast devsel, latency 0
> >         Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
> >         Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
> >         Bus: primary=01, secondary=02, subordinate=06, sec-latency=0
> >         Memory behind bridge: 08000000-0dffffff
> >         Expansion ROM at <unassigned> [disabled] [size=2]
> >         Capabilities: [40] Express Upstream Port, MSI 00
> >         Capabilities: [c0] Power Management version 3
> >         Capabilities: [100] Advanced Error Reporting
> >         Capabilities: [200] Virtual Channel
> >         Kernel driver in use: pcieport
> > 
> > As you can see PCI-bus hierarchy doesn't have root port and the very first
> > upstream port is directly connected to Host-PCIe bridge of MCU, which of
> > course is not listed by the lspci utility.
> > 
> > Despite of Radim Kr?má?, who suggested a fix, which would de-facto just
> > turned ASPM off, I found a quick solution, which disabled ASPM only in 
> > the first link (Host-PCIe=>Upstream port) of PCIe-bus for such hierarchy.
> > ASPM for other PCIe-bus topologies shall work the way it was.
> > 
> > I hope the fix will be helpful.
> > Thanks,
> > 
> > =============================
> > Serge V. Semin
> > Leading Programmer
> > Embedded SW development group
> > T-platforms
> > =============================
> > 
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > 
> > ---
> >  drivers/pci/pcie/aspm.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 0ec649d..a9295f29 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -522,7 +522,8 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
> >  	INIT_LIST_HEAD(&link->children);
> >  	INIT_LIST_HEAD(&link->link);
> >  	link->pdev = pdev;
> > -	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) {
> > +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
> > +	    (!pci_is_root_bus(pdev->bus->parent))) {
> >  		struct pcie_link_state *parent;
> >  		parent = pdev->bus->parent->self->link_state;
> >  		if (!parent) {
> > -- 
> > 2.6.6
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
