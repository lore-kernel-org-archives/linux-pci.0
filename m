Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD37400E0A
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 03:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789441849; cv=none; b=MxjZW0gGq7iAMOfLSSi3dunJBJJYiie24eKOA4OIa2ovSM4gjrUn3APzrgsJns7SX38WpQJM8+E//b0/C6Y30yCN3lWflTXewlWiJVGF2x9qfw+ww8IbyDhYbyhRoFF4q+rye4Erk+XDfiYNGMo4C+aw8p86dmGa0qigraJ0P0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789441849; c=relaxed/simple;
	bh=Tqm8mGXvI2nKoUm+9pLtaJ+uyO5KFGl5Yiy7z7wtnBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLAEVnOANhnj/z3i0vNVhkCEKMrdbFBnoJCV6/N45rI1n69EaNYMPzNaBQYMtxXXaTRK3MACzvz8Yf5cl+E2y3oIvZyd5FiUjw1OGsSskxV+2U/zJ23XcoPF3ODwfFHW6M6X5vvOfOMVVUVUK/RXOtqDiFOfS9kAQQUa4uxrqsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=tGa9frY1; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="tGa9frY1"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-530e1b6a689so22406901cf.3
        for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 20:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789441846; x=1790046646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xSNWHoyvKJfGdDxylfGmEXIoCFeqbapyGd1fgWyygV0=;
        b=tGa9frY1CyWiXP3Ve/Nl+X1cwDGI7vW6LYKcX9kUlCsoo4gg68RRZ+F/+XxLR/DHYF
         CkLjUkEygXTmYTxln3LzeYTwCKvxP4X+yVSwkM5F8Kf2vw5Igc0TKGUuqNo6Q1Gdj1pW
         SA7LVU441bJ+u3ZGtlQ+M1R+maw50Lnt54uTtBVAZFKaTjKjqJ0ztKK6MgzGD4E3LUGm
         I/Bwc5AW1Y+kwEra3LdsxTfeQjiz53Bo4o6RsnortHXK5t8YA07Xw6rOHse9DpGtmxHw
         R1UhP4r3Xa/+9fAChpR3zLNO72vFy6RMHcJ7RBy2mc+1MoMbfJlKmZCdMCmTyJ99bO/H
         SEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789441846; x=1790046646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xSNWHoyvKJfGdDxylfGmEXIoCFeqbapyGd1fgWyygV0=;
        b=rvQ7+qynZmfJPrtVVNQ8ysdKTQav1RqIGWm4joOl2VcR82L5njCL4cCF5cFd3q0jOp
         3ajZI31mOu77zBHEt0jE9bX7+mkM5Hawp0zBVfffKXcAtjcsjvSxz3dxfzhMoFBvcHQz
         /ZnrvojPKz8icqrKgljRPA2hUUg6T4Tow6Mfxl9FTc3Vc2CXMi4Xj95UKf7hNmBAJU+L
         1LAncN65fravwpE15bfrn6DbuMBk/Lu8NNojZXNn8724mA+N8c3JROnAPH3PMQicpKpK
         t8gjCMLzPow78zm0K6YbP/xYkiuVdkNxRQn9FVUDqaKXz1yFFwhIc8eIHNY/PZnAU5Fu
         A32Q==
X-Forwarded-Encrypted: i=1; AKwUvBzB0PNBelQg/3T1xHv1Nrb6IUv+D1ndd4NaoKSHkYBVv6pcNoP4VAF8ESFzT7ZfEPEiZGcJGEVgZVM=@vger.kernel.org
X-Gm-Message-State: AFuF++mK6llVx5I79/4JM1iqksC+38nJtqo8Xo8EFEPn5S3F0uoIazUQ
	3UhpoEiqK3G80iPiQjFVSFZvJjUe6CIwjwJozUbB+j49jqcdTE+nbXmpho9rZC86RdA=
X-Gm-Gg: AYBFou34Ykc+98BJc0Yy6vPWhzrl+vvBcHpf+96Fw/4dmlmbIofMOvP001ApB6AQoQD
	tDT3OpvLQ5vFRejiL2VZyTVJqvFb0CxZWnqPez9RPDIRFPbi6en2XL4HKzNY4RR1XNdMtWis4I9
	0bCrA0tvBLx1GTa6IST3VwQ0yojrWc3DV1hxJ7+qzfQPxDXxLjRbaOrIVPoVVw88il23A3VMKCZ
	LGN9gPX6EVfBf5oN48VIzpJTd2p/IXemikrhzcqXPP0Wx1h7zd0jrFm01aBpwwXgCdgGrLwOhrU
	5klTQDRVD85qwHzuXYPPOosce6X5Vgw6J4wX+9xp2axLskYkYUc5CkxGnng3lIhIsm8LGs9jlHG
	/aY3T+uD/tnUd3NkszfnWduPXscUTdneOnELeqAaXl14sKEzGE/esL2TUhDPn/jLhX6Ti5rX9w3
	INNi9dmW1eI8iRIpPAE+bohsbnEgUPOI/37CXyKZJMDAvbVFxVXzQlwaNiUhb5eI/PHlvnNxyaw
	dQ=
X-Received: by 2002:a05:622a:1919:b0:530:efea:7a55 with SMTP id d75a77b69052e-5310cef6b70mr77015881cf.4.1789441846176;
        Mon, 14 Sep 2026 20:10:46 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ce4ec298sm118563841cf.16.2026.09.14.20.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 20:10:45 -0700 (PDT)
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
	mohdayaa@qti.qualcomm.com,
	lbiancon@qti.qualcomm.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: qcom: qcs6490-rb3gen2: add endpoint buses
Date: Mon, 14 Sep 2026 22:10:37 -0500
Message-ID: <20260915031038.1087264-4-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915031038.1087264-1-elder@riscstar.com>
References: <20260915031038.1087264-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TC9564 SoC incorporates a PCIe switch, which is connected via
the second PCI segment (0001) on the RB3gen2 platform.  The third
downstream port of that switch (pcie@3,0) has an embedded PCIe
endpoint that implements two PCIe functions.

The SoC implements other peripherals, and they will be accessed via
PCI endpoint bus.  Define the devicetree nodes representing these
buses, including the mapping of each BAR's address range to its
local address space.

The endpoint's ranges property must be defined, but it will be
updated dynamically to include all BARs.  As a result of this update,
the parent address portion of each range will reflect the specific
address assigned to the BAR.

Co-developed-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
v2: - Added this patch to the series

 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 30 ++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 3bb5fca8e2b13..59fbb0444d9b7 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -955,11 +955,41 @@ pcie@3,0 {
 			bus-range = <0x5 0xff>;
 
 			dev@0,0 {
+				compatible = "pci1179,0220";
 				reg = <0x50000 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				/* Ranges will be updated dynamically */
+				ranges = <0x0 0x0 0x0  0x83050000 0x0 0x0 0x0 0x4000>,
+					 <0x2 0x0 0x0  0x83050000 0x0 0x0 0x0 0x80000>,
+					 <0x4 0x0 0x0  0x83050000 0x0 0x0 0x0 0x200000>;
+
+				pci-ep-bus@4 {
+					compatible = "simple-bus";
+					#address-cells = <1>;
+					#size-cells = <1>;
+					/* Map 0x0-0x1fffff to BAR 4 */
+					ranges = <0x0  0x4 0x0 0x0  0x200000>;
+				};
 			};
 
 			dev@0,1 {
+				compatible = "pci1179,0220";
 				reg = <0x50100 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				/* Ranges will be updated dynamically */
+				ranges = <0x0 0x0 0x0  0x83050100 0x0 0x0 0x0 0x4000>,
+					 <0x2 0x0 0x0  0x83050100 0x0 0x0 0x0 0x80000>,
+					 <0x4 0x0 0x0  0x83050100 0x0 0x0 0x0 0x200000>;
+
+				pci-ep-bus@4 {
+					compatible = "simple-bus";
+					#address-cells = <1>;
+					#size-cells = <1>;
+					/* Map 0x0-0x1fffff to BAR 4 */
+					ranges = <0x0  0x4 0x0 0x0  0x200000>;
+				};
 			};
 		};
 	};
-- 
2.53.0

