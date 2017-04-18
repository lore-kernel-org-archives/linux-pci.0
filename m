Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1492555416.25766.97.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 04/32] asm-generic: add ioremap_nopost() remap interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Russell King - ARM Linux
 <linux@armlinux.org.uk>
Date: Wed, 19 Apr 2017 08:43:36 +1000
In-Reply-To: <20170418154937.GA1006@red-moon>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <20170411122923.6285-5-lorenzo.pieralisi@arm.com>
 <1491917983.7236.9.camel@kernel.crashing.org>
 <20170412112022.GY17774@n2100.armlinux.org.uk>
 <20170418154937.GA1006@red-moon>
Mime-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jonas Bonn <jonas@southpole.se>, Rich Felker <dalias@libc.org>,
 linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Huacai Chen <chenhc@lemote.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>, linux-arch@vger.kernel.org,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>,
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
 Richard Kuo <rkuo@codeaurora.org>, Niklas Cassel <nks@flawful.org>, "Luis R .
 Rodriguez" <mcgrof@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Ley Foon Tan <lftan@altera.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2017-04-18 at 16:49 +0100, Lorenzo Pieralisi wrote:
> I can do that yes, which already means I have to know if eg microblaze
> (drivers/pci/host/pcie-xilinx.c) can provide a mapping with nonposted
> writes semantics, otherwise it is a dead-end.
> 
> Another option would be going back to what v1 did, namely, to implement
> a pci_remap_cfgspace() interface (it is the _nopost() suffix that stirred
> debate - nobody would object to having a default pci_remap_cfgspace()
> implementation that defaults to ioremap_nocache(), I know Bjorn does not
> like it to be PCI specific, just adding an option on the table to make
> progress).

Well, it boils down again to the fact that a mapping attribute isn't
sufficient.

Let's say I'm microblaze and I can't do non-posted mapping. Then the
Host Bridge driver needs to *know* that so it can implement a different
workaround, such as reading back from some bridge register after every
config write which ensures the previous write reached its destination
for example, or whatever other IP specific mechanism.

Cheers,
Ben.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
