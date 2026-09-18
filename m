Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB071502554
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745229; cv=none; b=BX7ZhNbF9eHinE2W4NhPxchLFFfVblQPNAMD5Usrzul4HbFtC8v0wlOj1XQh63BounqeDx5Na5Lukt3zZzfEjsBln+LaoKGV186yElWtdp/u6+ND1KeRUJYV1/orhpzEKaK5gk2PDBkNKcVNOIRPk3+CcekhcK6BduPn+qnQ3Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745229; c=relaxed/simple;
	bh=DtwhmvfmmK5pIr/RR1hrMie23QMNX8VOipziXz4rrfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PO1htZRFdk8sAT38jQgo1eAc3w/uYqV+Pd5dwLlfRavjX33kcuF9/mkNgn4EBDwiEg5m0NZbnXwJ4rKVzJuDrZ/R+OOexCqpY55lLJ4DDiHH55W2jccLM07wt9gEOxAxTW1EQKFoMypfsWlBEL5V0i7P8RYLXDTmrBjwQp4KF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=aBbFvpgF; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="aBbFvpgF"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfe57a3bso7382116d6.1
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 08:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789745225; x=1790350025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yc71JJZaAOPgE/2sEPFAn2J0YmVKQfWX+0ylD9XYCsk=;
        b=aBbFvpgFvX/rl5MO6/YG5yp30+HVL644hPLFWGHC6r40PkZpoUdAhowqmonHvfzFhu
         OtuaN63BIpn9bFL+qlDt4GNhJZtE5ot4gi0V0Pgj5/trxR3i8T12KcFT0BemPPp+PQUF
         6y5DXd0Xke4wZFs8YJW3nK3GEYgeJvDklKMrj2EUZXd0fWk+xbG3laF4H9xa63WF+xby
         Pt8yE+4FwOuR7WYWXvylGkvJKOWMzc9vNKbWz6vqP0Xjfqpol6Ph06Dej9YGumF0dFk3
         0wFOWKyLYIA4H6CzcnnzexDGwIJVJNwVhiAADzWtogXzG+eXY6KHDMAXhtfOU6548dJX
         6fWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745225; x=1790350025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yc71JJZaAOPgE/2sEPFAn2J0YmVKQfWX+0ylD9XYCsk=;
        b=Z2wcp4A63pbQ1TiIjnBC/WTLUxN5U5dzl9+45pTdm880JIuZzhFNtPjJ+MJYmJJ6yu
         6ymuMiWDcAhQHczRBY536lPvQxlZX6+yk1O7i4V7NpwRZLR3cywJ0OkAkqb5IKg0YliK
         l0iJOw8BO4f5bmxKv0zFp0B4B+E5Va5aLIxzXG/0GV7VqpHqxKr475YOMYhZPuXyXtle
         mGf7QH+PPqXio4HURGT/vDqEPQpM8nOAt8mDvUugop3T8xlSIBB5Ttvo4EZ5gViCD94H
         rc9v+H/baeomC5YI+rlqxJ/7TBEa/GmXt3q9keKurEV1/GTtRhbjl/cdjffI4vqGKUvR
         0TCQ==
X-Forwarded-Encrypted: i=1; AKwUvBwYYdqyQ5/xlrnM9orEymNSIsbvJm70130XLv53BN9bOU5RTR8kf+KPQYBPqmKMX0xCwoRPF8+zg6Y=@vger.kernel.org
X-Gm-Message-State: AFuF++m+knKgTXjjhX40JI07nxZ7WDxi2mVd5PgH3efmiV6QEZVGLNQE
	Ajmz/xBsZAMumAyHFskl9+CpYmA4ZsLKLLPKIopAN7yAmDOQu0HRMj2uzTAsQW3YePw=
X-Gm-Gg: AYBFou0vr0zncMr3jxWbNmxcCJ2ATgfVFQQPHIgovz7UgTIlmdmY90/isU/3gWnSSLN
	WlrCfK5u3Tpa3JRRXEm8PSlKYuA14y4uOSskarupX4/RGgP8kL0nPdHRPQSnX0pDNrgQWebrxW4
	FR/X2Fg0v/5cHKl2zID/g5F8RRUEkhpZYEi46kSDDWy04TjsfjuF6yfHZOnMfXXWQaqsxVELV69
	R/gHXqul/SBEHLhwt9PTlyxMeQlNMBQvzpNn3oomRFKez5rANomHqzkU4n7HwPXJ/DH9B1y7yap
	3F8vPl98B9mrXxNmg1gKsdUQLuTvZU8GesRjQ6YyXjo1s2dV1E1u5x2OM6XSF6cJztsltENS4Wo
	blS3QakcYTQYvRrTFa33bi0hnxoA2zcTD8cj27UrFtmo/najJJtJNYbINJtHoxpV78ESWMi1URu
	PZoDhOTQgL2ckWZIvK3O4m2G+OcEqMNvKXRICacwnr4c5CfO0Piso2HAvkYiQglkA8lFt1bFw9v
	WI=
X-Received: by 2002:a05:6214:80d6:10b0:90e:98c9:548 with SMTP id 6a1803df08f44-91254ba3a7dmr37466856d6.1.1789745225031;
        Fri, 18 Sep 2026 08:27:05 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91257f326d8sm15099766d6.6.2026.09.18.08.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:27:04 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	bhelgaas@google.com,
	andersson@kernel.org,
	konradybcio@kernel.org,
	abelvesa@kernel.org
Cc: daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: misc: introduce pci1179,0220.yaml
Date: Fri, 18 Sep 2026 10:26:56 -0500
Message-ID: <20260918152659.413268-2-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918152659.413268-1-elder@riscstar.com>
References: <20260918152659.413268-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define the binding for the Toshiba TC9564 PCI endpoint function device.
The third downstream PCIe switch port within this chip has an embedded
PCIe controller, and that implements two of these PCIe functions.

Multiple internal components are accessed via PCI function BARs, as
indicated in the diagram below.  This is facilitated by the use of the
devicetree pci-ep-bus mechanism, and is demonstrated in the example.

Co-developed-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
v4: - Dropped pci-ep-bus@0 node from the example

 .../bindings/misc/pci1179,0220.yaml           | 146 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 152 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/pci1179,0220.yaml

diff --git a/Documentation/devicetree/bindings/misc/pci1179,0220.yaml b/Documentation/devicetree/bindings/misc/pci1179,0220.yaml
new file mode 100644
index 0000000000000..c92c8d3d33f76
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/pci1179,0220.yaml
@@ -0,0 +1,146 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/pci1179,0220.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toshiba TC9564 internal PCI endpoint function
+
+maintainers:
+  - Alex Elder <elder@kernel.org>
+  - Daniel Thompson <danielt@kernel.org>
+
+description: >
+  The Toshiba TC9564 is specialized SoC that implements a PCIe switch
+  as well as an Ethernet AVB/TSN bridge.  In addition to these, the SoC
+  implements other functions, including a reset and clock controller,
+  an address translation unit, and a few other devices.
+
+  The PCI switch has three downstream ports.  The first two are exposed
+  externally, while the third is used by an internal PCIe endpoint.  The
+  internal endpoint implements two PCIe functions, and attached to each
+  of these is a 10 Gbps capable Synopsys Ethernet controller and an
+  interrupt controller that converts internal "wired" interrupts into
+  MSIs delivered to the host.
+
+  PCIe BARs provide access to registers that manage almost all IP blocks.
+  The SoC is modeled using a PCI endpoint bus.  The IP blocks are bound
+  to platform drivers that access the hardware using MMIO through the
+  PCI BARs.
+
+          ------------------------------------
+          |               Host               |
+          -----........---------------...-----
+              |        |             |   |
+              |  PCIe  |             |I2C|
+              |        |             |   |
+    ----------+........+-------------+...+-------------------------------
+    |         |upstream|          |          |       ----------------   |
+    | Toshiba | Port 0 |          |          +-------+ PCIe pwrctrl |   |
+    | TC9564  ----++----          |   I2C    |       ----------------   |
+    |  SoC        ||              |controller|       ----------------   |
+    |             ||              |          +-------+     GPIO     |   |
+    |             ||              |          |       |  controller  |   |
+    |       ------++------        ------------       ----------------   |
+    |       |     US     |                                              |
+    |       |            |    ----------------------------------------  |
+    |       |         DS3+====+          downstream port 3           |  |
+    |       |            |    |--------------------------------------|  |
+    |       |    PCIe    |    |        embedded PCIe endpoint        |  |
+    |       |   switch   |    |~~~~~~~~~~~~~~~~~~~++~~~~~~~~~~~~~~~~~|  |
+    |       |            |    |  PCIe function 0  || PCIe function 1 |  |
+    |       |            |    |-------------------||-----------------|  |
+    |       |            |    | BAR || BAR || BAR || BAR | BAR | BAR |  |
+    |       |            |    |  0  ||  2  ||  4  ||  0  |  2  |  4  |  |
+    |       | DS1    DS2 |    ---.------.------.--++--------------.---  |
+    |       --++------++--       :      :      :                  :     |
+    |         ||      ||         :   ---.--    :.......           :     |
+    |         ||      ||         :   |SRAM|    :      :           :     |
+    |         ||      ||         :   ------    :   ---.---        :     |
+    |         ||      ||         :         ....:   |clock|    ....:     |
+    |         ||      ||         :         :   :   -------    :   :     |
+    |         ||      ||   ------.----    -.-  :             -.-  :     |
+    |         ||      ||   |translate|    |M|  :.......      |M|  :     |
+    |         ||      ||   -----------    |S|  :      :      |S|  :     |
+    |         ||      ||                  |I|  :   ---.---   |I|  :     |
+    |         ||      ||                  |G|  :   |reset|   |G|  :     |
+    |         ||      ||                  |E|  :   -------   |E|  :     |
+    | --------++--  --++--------          |N|  :             |N|  :     |
+    | |downstream|  |downstream|         ------.----        ------.---- |
+    | |  port 1  |  |  port 2  |         | XGMAC 0 |        | XGMAC 1 | |
+    --+..........+--+..........+----------+.......+-----------+.....+----
+                                          |       |           |     |
+                                          |USXGMII|           |SGMII|
+                                          |       |           |     |
+                                        --+.......+--      ---+.....+---
+                                        | Ethernet  |      | Ethernet  |
+                                        |    PHY    |      |    PHY    |
+                                        -------------      -------------
+
+allOf:
+  - $ref: /schemas/pci/pci-ep-bus.yaml
+
+properties:
+  compatible:
+    const: pci1179,0220         # Toshiba TC9564 (a.k.a. Qualcomm QPS615)
+
+  reg:
+    maxItems: 1
+    description: PCI Bus/Device/Function config space address
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+  - ranges
+
+examples:
+  - |
+    pcie@0,0 {
+        reg = <0x0  0x0>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+        ranges = <0x83000000 0x0 0x0  0x0  0x0 0x1fd00000>;
+
+        dev@0,0 {
+            compatible = "pci1179,0220";
+            reg = <0x0 0x0 0x0 0x0 0x0>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            /* Ranges will be updated dynamically */
+            ranges = <0x0 0x0 0x0  0x83000000 0x0 0x0  0x0 0x4000>,
+                     <0x2 0x0 0x0  0x83000000 0x0 0x4000  0x0 0x80000>,
+                     <0x4 0x0 0x0  0x83000000 0x0 0x84000  0x0 0x200000>;
+
+            pci-ep-bus@4 {
+                compatible = "simple-bus";
+                #address-cells = <1>;
+                #size-cells = <1>;
+                /* Map 0x0-0x1fffff to BAR 4 */
+                ranges = <0x0  0x4 0x0 0x0  0x200000>;
+            };
+        };
+
+        dev@0,1 {
+            compatible = "pci1179,0220";
+            reg = <0x100 0x0 0x0 0x0 0x0>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            /* Ranges will be updated dynamically */
+            ranges = <0x0 0x0 0x0  0x83000100 0x0 0x0  0x0 0x4000>,
+                     <0x2 0x0 0x0  0x83000100 0x0 0x4000  0x0 0x80000>,
+                     <0x4 0x0 0x0  0x83000100 0x0 0x84000  0x0 0x200000>;
+
+            pci-ep-bus@4 {
+                compatible = "simple-bus";
+                #address-cells = <1>;
+                #size-cells = <1>;
+                /* Map 0x0-0x1fffff to BAR 4 */
+                ranges = <0x0  0x4 0x0 0x0  0x200000>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 6096dab7121e8..aa6b805e1ab2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27670,6 +27670,12 @@ F:	Documentation/devicetree/bindings/media/i2c/toshiba,tc358743.txt
 F:	drivers/media/i2c/tc358743*
 F:	include/media/i2c/tc358743.h
 
+TOSHIBA TC9564 PCI DRIVER
+M:	Alex Elder <elder@kernel.org>
+M:	Daniel Thompson <danielt@kernel.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/misc/pci1179,0220.yaml
+
 TOSHIBA WMI HOTKEYS DRIVER
 M:	Azael Avalos <coproscefalo@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.53.0

