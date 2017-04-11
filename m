Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 11 Apr 2017 15:08:57 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 00/32] PCI: fix config and I/O Address space memory
 mappings
Message-ID: <20170411140857.GA6821@red-moon>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <1491917906.7236.7.camel@kernel.crashing.org>
MIME-Version: 1.0
In-Reply-To: <1491917906.7236.7.camel@kernel.crashing.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jonas Bonn <jonas@southpole.se>, Rich Felker <dalias@libc.org>,
 linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Huacai Chen <chenhc@lemote.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>, linux-arch@vger.kernel.org,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>,
 Haavard Skinnemoen <hskinnemoen@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 James Hogan <james.hogan@imgtec.com>, Chris Metcalf <cmetcalf@mellanox.com>,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Mikael Starvik <starvik@axis.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Bjorn Helgaas <bhelgaas@google.com>, Stafford Horne <shorne@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>,
 Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>, Vineet Gupta <vgupta@synopsys.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Richard Kuo <rkuo@codeaurora.org>, Niklas Cassel <nks@flawful.org>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Ley Foon Tan <lftan@altera.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="iso-8859-1"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 11, 2017 at 11:38:26PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2017-04-11 at 13:28 +0100, Lorenzo Pieralisi wrote:
> > This patch series[1] is a v3 of a previous version:
> > =

> > v2: https://lkml.org/lkml/2017/3/27/220
> =

> I am not a fan of this at All.
> =

> That whole concept of "ioremap_nopost" is simply not applicable to the
> majority of architectures and certainly not in a way that can apply to
> arbitrary mappings.
> =

> It's also very wrong to provide a "default" operation whose semantics
> are weaker than what it's supposed to implement. Very wrong actually.
> People will use it assuming the non-posted behaviour and things will
> break in subtle way when it cannot be provided.

Well, what's very wrong for you it is not very wrong for others
(it is just v3, that's fine, see thread below).

I can easily make ioremap_nopost() mirror ioremap_uc() (ie return
NULL unless overriden so that basically you can't use in on an arch
that can't provide its semantics) but then that becomes very wrong
for other reviewers.

https://lkml.org/lkml/2017/4/6/396

> What exactly are you trying to fix here ?

I wrote in the commit logs and cover letter what I am fixing here.

Anyway:

"The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and
Posting") mandate non-posted configuration transactions. As further
highlighted in the PCIe specifications (4.0 - Rev0.3, "Ordering
Considerations for the Enhanced Configuration Access Mechanism"),
through ECAM and ECAM-derivative configuration mechanism, the memory
mapped transactions from the host CPU into Configuration Requests on the
PCI express fabric may create ordering problems for software because
writes to memory address are typically posted transactions (unless the
architecture can enforce through virtual address mapping non-posted
write transactions behaviour) but writes to Configuration Space are not
posted on the PCI express fabric."

On ARM64:

"This rule is reinforced by the ARM v8 architecture reference manual
(issue A.k, Early Write Acknowledgment) that explicitly recommends
that No Early Write Acknowledgment attribute should be used to map
PCI configuration (write) transactions."

> If a given PCIe host bridge (architecture specific) require a special
> sauce to provide the illusion of non-posting, then implement this in
> the actual root complex code.

> =

> BTW. I'm pretty sure we "accidentally" made config writes posted at
> least to the PHB on a number of powerpc systems forever and we *never*
> had a problem because of it ;)

Ok so we should ignore the PCIe specifications and ARM v8 reference
manual waiting for a kernel bug to appear ? Is that what you suggest
doing ?

Lorenzo

> > v2 -> v3:
> > 	- Created a default ioremap_nopost() implementation in a
> > separate
> > 	=A0=A0asm-generic header and patched all arches to make use of it
> > 	- Removed PCI drivers patches from the series to simplify the
> > 	=A0=A0review, they will be posted separately once the
> > ioremap_nopost()
> > 	=A0=A0interface is settled
> > 	- Fixed devm_ioremap_* BUS offset comments and implemented
> > 	=A0=A0nopost interface on top of it
> > 	- Added collected tags
> > =

> > v1: https://lkml.org/lkml/2017/2/27/228
> > =

> > v1 -> v2:
> > 	- Changed pci_remap_cfgspace() to more generic ioremap_nopost()
> > 	=A0=A0interface
> > 	- Added pgprot_nonposted
> > 	- Fixed build errors on arches not relying on asm-generic
> > headers
> > 	- Added PCI versatile host controller driver patch
> > 	- Added missing config space remapping to hisilicon host
> > controller
> > =

> > ---------------------
> > Original cover letter
> > ---------------------
> > =

> > PCI local bus specifications (Rev3.0, 3.2.5 "Transaction Ordering
> > and Posting") strictly require PCI configuration and I/O Address
> > space
> > write transactions to be non-posted.
> > =

> > Current crop of DT/ACPI PCI host controllers drivers relies on
> > the ioremap interface to map ECAM and ECAM-derivative PCI config
> > regions and pci_remap_iospace() to create a VMA for mapping
> > PCI host bridge I/O Address space transactions to CPU virtual address
> > space.
> > =

> > On some platforms (ie ARM/ARM64) ioremap fails to comply with the PCI
> > configuration non-posted write transactions requirement, because it
> > provides a memory mapping that issues "bufferable" or, in PCI terms
> > "posted" write transactions. Likewise, the current
> > pci_remap_iospace()
> > implementation maps the physical address range that the PCI
> > translates
> > to I/O space cycles to virtual address space through pgprot_device()
> > attributes that on eg ARM64 provides a memory mapping issuing
> > posted writes transactions, which is not PCI specifications
> > compliant.
> > =

> > This patch series[1] addresses both issues in one go:
> > =

> > - It updates the pci_remap_iospace() function to use a page mapping
> > =A0 that guarantees non-posted write transactions for I/O space
> > addresses
> > - It adds a kernel API to remap PCI config space resources, so that
> > =A0 architecture can override it with a mapping implementation that
> > =A0 guarantees PCI specifications compliancy wrt non-posted write
> > =A0 configuration transactions
> > - It updates all PCI host controller implementations (and the generic
> > =A0 ECAM layer) to use the newly introduced mapping interface
> > =

> > Tested on Juno ECAM based interface (DT/ACPI).
> > =

> > Non-ECAM PCI host controller drivers patches need checking to make
> > sure that:
> > =

> > - I patched the correct resource region mapping for config space
> > - There are not any other ways to ensure posted-write completion
> > =A0 in the respective pci_ops that make the relevant patch unnecessary
> > =

> > [1]
> > git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git
> > pci/config-io-mappings-fix-v3
> > =

> > Lorenzo Pieralisi (32):
> > =A0 PCI: remove __weak tag from pci_remap_iospace()
> > =A0 asm-generic/pgtable.h: introduce pgprot_nonposted remap attribute
> > =A0 PCI: fix pci_remap_iospace() remap attribute
> > =A0 asm-generic: add ioremap_nopost() remap interface
> > =A0 alpha: include default ioremap_nopost() implementation
> > =A0 avr32: include default ioremap_nopost() implementation
> > =A0 arc: include default ioremap_nopost() implementation
> > =A0 cris: include default ioremap_nopost() implementation
> > =A0 frv: include default ioremap_nopost() implementation
> > =A0 hexagon: include default ioremap_nopost() implementation
> > =A0 ia64: include default ioremap_nopost() implementation
> > =A0 m32r: include default ioremap_nopost() implementation
> > =A0 m68k: include default ioremap_nopost() implementation
> > =A0 metag: include default ioremap_nopost() implementation
> > =A0 microblaze: include default ioremap_nopost() implementation
> > =A0 mips: include default ioremap_nopost() implementation
> > =A0 mn10300: include default ioremap_nopost() implementation
> > =A0 nios2: include default ioremap_nopost() implementation
> > =A0 openrisc: include default ioremap_nopost() implementation
> > =A0 parisc: include default ioremap_nopost() implementation
> > =A0 powerpc: include default ioremap_nopost() implementation
> > =A0 s390: include default ioremap_nopost() implementation
> > =A0 sh: include default ioremap_nopost() implementation
> > =A0 sparc: include default ioremap_nopost() implementation
> > =A0 tile: include default ioremap_nopost() implementation
> > =A0 unicore32: include default ioremap_nopost() implementation
> > =A0 x86: include default ioremap_nopost() implementation
> > =A0 xtensa: include default ioremap_nopost() implementation
> > =A0 arm64: implement ioremap_nopost() interface
> > =A0 arm: implement ioremap_nopost() interface
> > =A0 lib: fix Devres devm_ioremap_* offset parameter kerneldoc
> > description
> > =A0 lib: implement Devres ioremap_nopost() interface
> > =

> > =A0Documentation/driver-model/devres.txt |=A0=A03 ++
> > =A0arch/alpha/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A01=
 +
> > =A0arch/arc/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=
=A01 +
> > =A0arch/arm/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=
=A09 ++++
> > =A0arch/arm/mm/ioremap.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0|=A0=A07 +++
> > =A0arch/arm/mm/nommu.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0|=A0=A09 ++++
> > =A0arch/arm64/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0| 12 +++=
++
> > =A0arch/avr32/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A01=
 +
> > =A0arch/cris/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=
=A01 +
> > =A0arch/frv/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=
=A01 +
> > =A0arch/hexagon/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A02 +
> > =A0arch/ia64/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=
=A01 +
> > =A0arch/m32r/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=
=A01 +
> > =A0arch/m68k/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=
=A01 +
> > =A0arch/metag/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A02=
 +
> > =A0arch/microblaze/include/asm/io.h=A0=A0=A0=A0=A0=A0|=A0=A01 +
> > =A0arch/mips/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=
=A01 +
> > =A0arch/mn10300/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A01 +
> > =A0arch/nios2/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A01=
 +
> > =A0arch/openrisc/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A02 +
> > =A0arch/parisc/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A01 +
> > =A0arch/powerpc/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A01 +
> > =A0arch/s390/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=
=A01 +
> > =A0arch/sh/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=
=A0=A01 +
> > =A0arch/sparc/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A01=
 +
> > =A0arch/tile/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=
=A01 +
> > =A0arch/unicore32/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0|=A0=A01 +
> > =A0arch/x86/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=
=A01 +
> > =A0arch/xtensa/include/asm/io.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A01 +
> > =A0drivers/pci/pci.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0|=A0=A04 +-
> > =A0include/asm-generic/ioremap-nopost.h=A0=A0|=A0=A09 ++++
> > =A0include/asm-generic/pgtable.h=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A04 ++
> > =A0include/linux/device.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0|=A0=A02 +
> > =A0include/linux/io.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0|=A0=A02 +
> > =A0lib/devres.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0| 84
> > +++++++++++++++++++++++++++++++++--
> > =A035 files changed, 167 insertions(+), 5 deletions(-)
> > =A0create mode 100644 include/asm-generic/ioremap-nopost.h
> > =


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
