Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF95F3382FC;
	Fri, 14 Aug 2026 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721962; cv=none; b=ko60OAA+Ri/FDcjpo6ntgQ9zntKRkyTtw67jpYqIuUfERmjk1TlBhuf767DBMIWnFsSxzVUD9jL/ZCFjvi0KEkPzHwWuzMTB2wqOWIhVf4W5rb1dllnSWDDs0d0SDZlpmadP34LJlYb8EBYNPz8pXboEaRPZNR40Yrmuo/Ect8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721962; c=relaxed/simple;
	bh=CC582akEQKxNpN8EcZcq2Yi/v5FMMcKYYTglNAXB2Hw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G1ZjAXVsmB1Lx9/GNIIVZSo5tPBOmG65QLRxLbVGp92BiKX05WR9ChC8fx0iBtoAcjbnQAVYmBjYR3mjpR7hKBkUHLkCW5ZPsw+JAqGhABB9c4pnMO8S1VPU8g665OVIUMAcdFEwz/AYsHqkHh4afLqtlcJ9YIocUa9z+4e29sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNk8vWrr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNk8vWrr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE311F000E9;
	Fri, 14 Aug 2026 15:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786721959;
	bh=WTU4rKoCuNIWwmP06D5AYy719XUngvGdKxTCifYWBEg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UNk8vWrrfGrTrRvFwV6Q97e/So934xNYhgnz+P03wNfbcXB2DRZreJwAQZB0pbdBo
	 zhNIN2sSVCDWJjKxF4njT6Ikzv1imrysfLL8eFayA/REPL3XmnQ0/k3qh9dj+QFncE
	 3kamK56TucH76Y+1GmMO83MpE3iprsGMO9GW3aHqE/MnwYkfbyus4SCWWcDtDb7Wlh
	 D+K4FmGkhqmg/U+IpWxhRvhH2kuFRPvBidV+J2JCPE3LrRlXuLbI8PWmKahHJZTnBl
	 qNnCoCUAbiqHgbtBB132ApYa97Ctk8WinRYOoRVTBNYyq1+140Y2CwVOBNHMKz4FmM
	 ODMU/w8q4MyDA==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 14 Aug 2026 17:38:59 +0200
Subject: [PATCH v10 5/5] arm64: tegra: Add PCIe root ports on Tegra264
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-tegra264-pcie-v10-5-05d08c592b05@nvidia.com>
References: <20260814-tegra264-pcie-v10-0-05d08c592b05@nvidia.com>
In-Reply-To: <20260814-tegra264-pcie-v10-0-05d08c592b05@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Kevin Xie <kevin.xie@starfivetech.com>, 
 Thierry Reding <thierry.reding@kernel.org>, Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4514; i=treding@nvidia.com;
 h=from:subject:message-id; bh=uwzcY4itT9MMOHxh6BOCpBg+SC59ccFzs5RX826Wlz0=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqfzaW4YIYb6uN8x540XtICYs8H7pIA4yy6T0P4
 bdVmbjUPI6JAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCan82lgAKCRDdI6zXfz6z
 oVaED/0bLQ8HxXJtuWtiwdg+VWi9iBMVPs+nW+dSxgZL74efhTeXijIIrSmdUUH5wuhthB6CEwC
 lADNWPjzhSXLAHG54fMUocJB1d7H1ALF8yLyXxiAVbF18ntkN/TfWLRLjYcKml5qQV1HbPv6m9T
 uZxgz3Vfw/ZM7vrlKR8GVjipN+cdPC2fuMJZijC+/d++VA6Vg0ZpXswvSGIaSM+YG+rkwhP51Zh
 MvJdYeCXFx/rIhuOqTdnuwbfSh1z1kAeAN5h2v4il9oZlTqYnK2hgsMn3ChXyFIZLCOkQ1vETg1
 K3HIFOL3NYT3zRVi0oeNQ1TTljS9va0wIes8I24SJ4Q8eAJ91C3Qy0V21rSqhswPh3GvGDloHWD
 mweywfT6RcloS+K9/sFGUzGfO4itxHb+1c1h3/SpnJfFUfm0t/N6OBb8ycSW5NwG5DvgkpPYRhv
 gBuBXz0iZpK642dJ9bCPWmTCRiehVUgE+QxFAjKhT74aXaXKvuivPn7Bg7LJaV7kpGnVO32qiBZ
 aeqrOOLLa5NE2XOckAfXqpQi3AqXHR/pIo5mNfOiW15Zn5qJZbtlhSbI0JjEH4P3ECpjfuS74QV
 9Jts21I1N3LH/NYfSzb3c4BbmYgDfMNjZVBNG4l6hIiwYLLEsBFhnkgIyMg22GxUISw89Bocucs
 a1l/UPW5+Hil0pw==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

The bindings have been updated to use the PCIe root port bindings, so
the nodes for the root ports must be added.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra264.dtsi | 66 +++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index cf9760c681b1..31bd29df8e46 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -3562,10 +3562,19 @@ pci@c000000 {
 			ranges = <0x81000000 0x00 0x84000000 0xd0 0x84000000 0x00 0x00200000>, /* I/O */
 				 <0x82000000 0x00 0x20000000 0x00 0x20000000 0x00 0x08000000>, /* non-prefetchable memory (128 MiB) */
 				 <0xc3000000 0xd0 0xc0000000 0xd0 0xc0000000 0x07 0xc0000000>; /* prefetchable memory */
-			bus-range = <0x0 0xff>;
 
 			nvidia,bpmp = <&bpmp 0>;
 			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				compatible = "pciclass,0604";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pinmux_main: pinmux@c281000 {
@@ -4015,10 +4024,19 @@ pci@8400000 {
 			ranges = <0x81000000 0x00 0x84000000 0xa8 0x84000000 0x00 0x00200000>, /* I/O */
 				 <0x82000000 0x00 0x28000000 0x00 0x28000000 0x00 0x08000000>, /* non-prefetchable memory */
 				 <0xc3000000 0xa8 0xc0000000 0xa8 0xc0000000 0x07 0xc0000000>; /* prefetchable memory */
-			bus-range = <0x00 0xff>;
 
 			nvidia,bpmp = <&bpmp 1>;
 			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				compatible = "pciclass,0604";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pci@8420000 {
@@ -4047,10 +4065,19 @@ pci@8420000 {
 			ranges = <0x81000000 0x00 0x84000000 0xb0 0x84000000 0x00 0x00200000>, /* I/O */
 				 <0x82000000 0x00 0x30000000 0x00 0x30000000 0x00 0x08000000>, /* non-prefetchable memory */
 				 <0xc3000000 0xb0 0xc0000000 0xb0 0xc0000000 0x07 0xc0000000>; /* prefetchable memory */
-			bus-range = <0x00 0xff>;
 
 			nvidia,bpmp = <&bpmp 2>;
 			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				compatible = "pciclass,0604";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pci@8440000 {
@@ -4079,10 +4106,19 @@ pci@8440000 {
 			ranges = <0x81000000 0x00 0x84000000 0xb8 0x84000000 0x00 0x00200000>, /* I/O */
 				 <0x82000000 0x00 0x38000000 0x00 0x38000000 0x00 0x08000000>, /* non-prefetchable memory */
 				 <0xc3000000 0xb8 0xc0000000 0xb8 0xc0000000 0x07 0xc0000000>; /* prefetchable memory */
-			bus-range = <0x00 0xff>;
 
 			nvidia,bpmp = <&bpmp 3>;
 			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				compatible = "pciclass,0604";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pci@8460000 {
@@ -4111,10 +4147,19 @@ pci@8460000 {
 			ranges = <0x81000000 0x00 0x84000000 0xc0 0x84000000 0x00 0x00200000>, /* I/O */
 				 <0x82000000 0x00 0x40000000 0x00 0x40000000 0x00 0x08000000>, /* non-prefetchable memory */
 				 <0xc3000000 0xc0 0xc0000000 0xc0 0xc0000000 0x07 0xc0000000>; /* prefetchable memory */
-			bus-range = <0x00 0xff>;
 
 			nvidia,bpmp = <&bpmp 4>;
 			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				compatible = "pciclass,0604";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pci@8480000 {
@@ -4143,10 +4188,19 @@ pci@8480000 {
 			ranges = <0x81000000 0x00 0x84000000 0xc8 0x84000000 0x00 0x00200000>, /* I/O */
 				 <0x82000000 0x00 0x48000000 0x00 0x48000000 0x00 0x08000000>, /* non-prefetchable memory */
 				 <0xc3000000 0xc8 0xc0000000 0xc8 0xc0000000 0x07 0xc0000000>; /* prefetchable memory */
-			bus-range = <0x00 0xff>;
 
 			nvidia,bpmp = <&bpmp 5>;
 			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				compatible = "pciclass,0604";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 	};
 

-- 
2.55.0

