Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v3 00/32] PCI: fix config and I/O Address space memory mappings
Date: Tue, 11 Apr 2017 13:28:40 +0100
Message-Id: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jonas Bonn <jonas@southpole.se>, Rich Felker <dalias@libc.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Huacai Chen <chenhc@lemote.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>, linux-arch@vger.kernel.org,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Matt Turner <mattst88@gmail.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, James Hogan <james.hogan@imgtec.com>,
 Chris Metcalf <cmetcalf@mellanox.com>, Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

This patch series[1] is a v3 of a previous version:

v2: https://lkml.org/lkml/2017/3/27/220

v2 -> v3:
	- Created a default ioremap_nopost() implementation in a separate
	  asm-generic header and patched all arches to make use of it
	- Removed PCI drivers patches from the series to simplify the
	  review, they will be posted separately once the ioremap_nopost()
	  interface is settled
	- Fixed devm_ioremap_* BUS offset comments and implemented
	  nopost interface on top of it
	- Added collected tags

v1: https://lkml.org/lkml/2017/2/27/228

v1 -> v2:
	- Changed pci_remap_cfgspace() to more generic ioremap_nopost()
	  interface
	- Added pgprot_nonposted
	- Fixed build errors on arches not relying on asm-generic headers
	- Added PCI versatile host controller driver patch
	- Added missing config space remapping to hisilicon host controller

---------------------
Original cover letter
---------------------

PCI local bus specifications (Rev3.0, 3.2.5 "Transaction Ordering
and Posting") strictly require PCI configuration and I/O Address space
write transactions to be non-posted.

Current crop of DT/ACPI PCI host controllers drivers relies on
the ioremap interface to map ECAM and ECAM-derivative PCI config
regions and pci_remap_iospace() to create a VMA for mapping
PCI host bridge I/O Address space transactions to CPU virtual address
space.

On some platforms (ie ARM/ARM64) ioremap fails to comply with the PCI
configuration non-posted write transactions requirement, because it
provides a memory mapping that issues "bufferable" or, in PCI terms
"posted" write transactions. Likewise, the current pci_remap_iospace()
implementation maps the physical address range that the PCI translates
to I/O space cycles to virtual address space through pgprot_device()
attributes that on eg ARM64 provides a memory mapping issuing
posted writes transactions, which is not PCI specifications compliant.

This patch series[1] addresses both issues in one go:

- It updates the pci_remap_iospace() function to use a page mapping
  that guarantees non-posted write transactions for I/O space addresses
- It adds a kernel API to remap PCI config space resources, so that
  architecture can override it with a mapping implementation that
  guarantees PCI specifications compliancy wrt non-posted write
  configuration transactions
- It updates all PCI host controller implementations (and the generic
  ECAM layer) to use the newly introduced mapping interface

Tested on Juno ECAM based interface (DT/ACPI).

Non-ECAM PCI host controller drivers patches need checking to make
sure that:

- I patched the correct resource region mapping for config space
- There are not any other ways to ensure posted-write completion
  in the respective pci_ops that make the relevant patch unnecessary

[1] git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git
pci/config-io-mappings-fix-v3

Lorenzo Pieralisi (32):
  PCI: remove __weak tag from pci_remap_iospace()
  asm-generic/pgtable.h: introduce pgprot_nonposted remap attribute
  PCI: fix pci_remap_iospace() remap attribute
  asm-generic: add ioremap_nopost() remap interface
  alpha: include default ioremap_nopost() implementation
  avr32: include default ioremap_nopost() implementation
  arc: include default ioremap_nopost() implementation
  cris: include default ioremap_nopost() implementation
  frv: include default ioremap_nopost() implementation
  hexagon: include default ioremap_nopost() implementation
  ia64: include default ioremap_nopost() implementation
  m32r: include default ioremap_nopost() implementation
  m68k: include default ioremap_nopost() implementation
  metag: include default ioremap_nopost() implementation
  microblaze: include default ioremap_nopost() implementation
  mips: include default ioremap_nopost() implementation
  mn10300: include default ioremap_nopost() implementation
  nios2: include default ioremap_nopost() implementation
  openrisc: include default ioremap_nopost() implementation
  parisc: include default ioremap_nopost() implementation
  powerpc: include default ioremap_nopost() implementation
  s390: include default ioremap_nopost() implementation
  sh: include default ioremap_nopost() implementation
  sparc: include default ioremap_nopost() implementation
  tile: include default ioremap_nopost() implementation
  unicore32: include default ioremap_nopost() implementation
  x86: include default ioremap_nopost() implementation
  xtensa: include default ioremap_nopost() implementation
  arm64: implement ioremap_nopost() interface
  arm: implement ioremap_nopost() interface
  lib: fix Devres devm_ioremap_* offset parameter kerneldoc description
  lib: implement Devres ioremap_nopost() interface

 Documentation/driver-model/devres.txt |  3 ++
 arch/alpha/include/asm/io.h           |  1 +
 arch/arc/include/asm/io.h             |  1 +
 arch/arm/include/asm/io.h             |  9 ++++
 arch/arm/mm/ioremap.c                 |  7 +++
 arch/arm/mm/nommu.c                   |  9 ++++
 arch/arm64/include/asm/io.h           | 12 +++++
 arch/avr32/include/asm/io.h           |  1 +
 arch/cris/include/asm/io.h            |  1 +
 arch/frv/include/asm/io.h             |  1 +
 arch/hexagon/include/asm/io.h         |  2 +
 arch/ia64/include/asm/io.h            |  1 +
 arch/m32r/include/asm/io.h            |  1 +
 arch/m68k/include/asm/io.h            |  1 +
 arch/metag/include/asm/io.h           |  2 +
 arch/microblaze/include/asm/io.h      |  1 +
 arch/mips/include/asm/io.h            |  1 +
 arch/mn10300/include/asm/io.h         |  1 +
 arch/nios2/include/asm/io.h           |  1 +
 arch/openrisc/include/asm/io.h        |  2 +
 arch/parisc/include/asm/io.h          |  1 +
 arch/powerpc/include/asm/io.h         |  1 +
 arch/s390/include/asm/io.h            |  1 +
 arch/sh/include/asm/io.h              |  1 +
 arch/sparc/include/asm/io.h           |  1 +
 arch/tile/include/asm/io.h            |  1 +
 arch/unicore32/include/asm/io.h       |  1 +
 arch/x86/include/asm/io.h             |  1 +
 arch/xtensa/include/asm/io.h          |  1 +
 drivers/pci/pci.c                     |  4 +-
 include/asm-generic/ioremap-nopost.h  |  9 ++++
 include/asm-generic/pgtable.h         |  4 ++
 include/linux/device.h                |  2 +
 include/linux/io.h                    |  2 +
 lib/devres.c                          | 84 +++++++++++++++++++++++++++++++++--
 35 files changed, 167 insertions(+), 5 deletions(-)
 create mode 100644 include/asm-generic/ioremap-nopost.h

-- 
2.10.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
