Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Alexander Graf <agraf@suse.de>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 4/4] arm64: dts: Drop linux,pci-probe-only from the Seattle DTS
Date: Fri,  4 Sep 2015 17:50:11 +0100
Message-Id: <1441385411-7624-5-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1441385411-7624-1-git-send-email-marc.zyngier@arm.com>
References: <1441385411-7624-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The linux,pci-probe-only property mandates an argument to indicate
whether or not to engage the "probe-only" mode, but the Seattle
DTS just provides a naked property, which is illegal.

Also, it turns out that the board is perfectly happy without
probe-only, so let's drop this altogether.

Acked-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/boot/dts/amd/amd-overdrive.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amd/amd-overdrive.dts b/arch/arm64/boot/dts/amd/amd-overdrive.dts
index 564a3f7..128fa94 100644
--- a/arch/arm64/boot/dts/amd/amd-overdrive.dts
+++ b/arch/arm64/boot/dts/amd/amd-overdrive.dts
@@ -14,7 +14,6 @@
 
 	chosen {
 		stdout-path = &serial0;
-		linux,pci-probe-only;
 	};
 };
 
-- 
2.1.4

