Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Daniel Axtens <dja@axtens.net>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/4] Allow non-legacy cards to be vgaarb default
Date: Wed, 19 Jul 2017 12:15:12 +1000
Message-Id: <20170719021516.24718-1-dja@axtens.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: gabriele.paoloni@huawei.com, airlied@linux.ie, benh@kernel.crashing.org,
 will.deacon@arm.com, z.liuxinliang@hisilicon.com, bhelgaas@google.com,
 alex.williamson@redhat.com, catalin.marinas@arm.com, zourongrong@gmail.com,
 daniel.vetter@intel.com, Daniel Axtens <dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[v2, in which I send the right patches. My apologies to you all.]

Hi all,

Previously I posted a patch that provided a quirk for a hibmc card
behind a particular Huawei bridge that allowed it to be marked as the
default device in the VGA arbiter.[0] This lead to some discussion.[1]
It was broadly suggested that a more generic solution would be better,
something in the style of powerpc's fixup_vga() quirk.

Here is my suggested solution:

 - Create a Kconfig option ARCH_WANT_VGA_ARB_FALLBACK
 
 - if an arch selects that option, install PCI_FIXUP_CLASS_ENABLE
   hook. This hook fires when a card is enabled, which will require
   that a driver has been bound.

 - if there is no default device when the hook fires, and the device
   can control memory and I/O, mark it as default.

The patches are as follows:

 (1) powerpc: simplify and fix VGA default device behaviour

     This cleans up some quirks in the powerpc implementation of the
     vga_fixup. It should make the behaviour match the original
     intention.

 (2) vgaarb: allow non-legacy cards to be marked as default

     Add the Kconfig option, and create the fixup in vgaarb.c gated
     behind the option. Nothing happens at this stage because no arch
     has selected the option yet.

 (3) powerpc: replace vga_fixup() with generic code

     Select the option on powerpc and remove the old code. The only
     change is that it moves from being a final fixup to an enable
     fixup.
 
 (4) arm64: allow non-legacy VGA devices to be default

     Select the option on arm64. This solves my problem with the D05,
     but may cause other cards to be marked as default on other
     boards. This shouldn't cause any real issues but is worth being
     aware of.

Regards,
Daniel

[0]: https://patchwork.ozlabs.org/patch/787003/
[1]: https://www.spinics.net/lists/arm-kernel/msg593656.html

Daniel Axtens (4):
  powerpc: simplify and fix VGA default device behaviour
  vgaarb: allow non-legacy cards to be marked as default
  powerpc: replace vga_fixup() with generic code
  arm64: allow non-legacy VGA devices to be default

 arch/arm64/Kconfig               |  1 +
 arch/powerpc/Kconfig             |  1 +
 arch/powerpc/kernel/pci-common.c | 12 ------------
 drivers/gpu/vga/Kconfig          |  7 +++++++
 drivers/gpu/vga/vgaarb.c         | 21 +++++++++++++++++++++
 5 files changed, 30 insertions(+), 12 deletions(-)

-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
