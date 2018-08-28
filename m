Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Punit Agrawal <punit.agrawal@arm.com>
To: bhelgaas@google.com
Subject: [PATCH 0/2] Drop node-local allocation during host controller
 initialisation
Date: Tue, 28 Aug 2018 16:05:11 +0100
Message-Id: <20180828150513.32458-1-punit.agrawal@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Punit Agrawal <punit.agrawal@arm.com>, linux-pci@vger.kernel.org,
 x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

As discussed before[0], here are a couple of patches to drop
node-local allocations during host contoller initialisation. This set
covers both arm64 and x86.

I'm posting early to give the patches time on the list as well in next
in case there are issues we've missed.

The patches are based on v4.19-rc1 and has been boot tested on arm64
and compile tested on x86.

Thanks,
Punit

[0] https://www.spinics.net/lists/arm-kernel/msg669746.html

Punit Agrawal (2):
  arm64: PCI: Remove node-local allocations when initialising host
    controller
  x86/PCI: Remove node-local allocation when initialising host
    controller

 arch/arm64/kernel/pci.c | 5 ++---
 arch/x86/pci/acpi.c     | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
