Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE78479877
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780408; cv=none; b=hXKOl1JrMq1zdHehWV7LXleUhc1uzjpyW/E+/d24RUjDtf2dIrM4snUnzCXc6yuhiGxCEadR4zF86YqqT99jWHOW6i4BLdXpKjvC9IuO71vzep/5KqN46KWoy5Hig1K6zIo5BhHMQ8aRaNoSivfN/YV9430HBuZ4FrqjBCmwVQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780408; c=relaxed/simple;
	bh=L3fsKyGi5rpLNg8G/ROz7kxtpDKTfFUi8q+A7hQ20Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkdYYE++ZQY6XsmJZv/8Z4nl5sLTUh3I4w5zIziZrcpMkLe9oIVQuHzkRfqr0hv5V3B4s/Ft/I8ReOulqdLeZAkKOt+T6oHdScFpTDL/Mf4XnZdzzar2Ql+Ya56aQMBGJW9GcJ6SO/Jsn/qhbuCWJF2hltsZjJ0k9cNHOmbLDaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mR+NHtXX; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR+NHtXX"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8541875f596so1218369b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 07 Sep 2026 04:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788780407; x=1789385207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7AEeGlWy9uXP/q/PPr93GfqgOECgNHQd0LWMUmr1tVw=;
        b=mR+NHtXXZNgFzM27AhG2MF6G4HOtaLwfdm84EUEECwn5sJ7fFhnLdZTEAHKJeUuK2J
         V0q6tP1iDPwTVq9R2KrCpr70/qNf35QYsxIv7ghP/c6KLl/j0blnWOiOCVdb3besR39A
         W0HBh+U4aMzVE7yKdgL1htRWncl4cWetRukrks6P7jhTaF9GGlkKs5Ds+hluvk2ra42p
         Pf3gwPeWYLrXqKJL5mCuw9Q4uXJZlXTJMVq5EXBaCb0EW1Ki+WBcqrMb9gSHWnaEYGHh
         NW/nA5b3o3poax4mvarzaxndiPpTfvg8nliKK7t7TjbQ2BE+N9VV8tXOdGajeGhJ5yhG
         a8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788780407; x=1789385207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7AEeGlWy9uXP/q/PPr93GfqgOECgNHQd0LWMUmr1tVw=;
        b=jTEYlYoSO/ilD6RM0huPyGFSo+o5VyyHYSMeunT/hBUJ7Vlv3nFrPxCs1s+76iBSDq
         4VtbH2+Rj2s0ixlTv0c9b6NTXnkGYwe4Fnf9jwV6TMjSKfmdUPK08IJp8l/8+K9+37zq
         j6FuxmYjIMEKGC22mddYqh1Zy53GHoK7HzL5fII8gOcocxoDltY0T+PLD0ftLvGgmr+3
         DrYlP3Q/nWxHx/mQy/1hxaXLSmkHD8jWlotUfOlDQJ2CjTNLRsZVEhLOSd9/gVq6xcSe
         /eL7G/QRtESvaH2KMwKvgjeBA18C7C24LShuQzz64vsp2izHUM9dr/6zciZLsI5VCc2M
         puxg==
X-Gm-Message-State: AFuF++nNvA66N4CUD3TyJ8CvZpBtYQWQlEVVq4UOfnWATsekBz8fHCxB
	jYQhht0U3dHaaz0QOm054iRGcGobtQI9qEafzbR6Xs94+HEmDSETWYs2
X-Gm-Gg: AYBFou1W4PU1k40nDUKAD5piSWcDvMXp8MCyBRFSrsOIrcYkWACVLR1lb1yiQjAiypd
	XnxfAnTk1i8DchTNSGAQGkxZlR1uYRpjEnSD+M6na8UDw4+AaaXb39Imjn2NNpJZKfpwT0K2Vbt
	goCiirwmr5Shy9aDr8NC+rck90DT6c89pWutcPmTVgco3OcEgw3x40HSyuP3P//4Qp1sEsFCM5O
	nSChEuF8qDzWHcuoyr/xRsHAwiAgsPW/qkhywm3AqrUDj7tXQo5w2VLI/7Jud+3j+MTr40c/Snh
	aIxKTBvatz6hC7OBfZw7m8gfDQClZ8ht9dBhJKxn4/ng1/zt7mVfnyhJBb2FR6NtypnAFRxrxET
	Rj+PpwXmTDJiOMdAq5NVaPBkgxk92eOt2ddngtNlNFowZghMcT1P2smaf+jp40bfYv6Yl3GzK6Q
	1yoSkOax9J89FifmiuMJrelW/rd2xy+ziFjMDD
X-Received: by 2002:a05:6a00:32c4:b0:857:73e2:9107 with SMTP id d2e1a72fcca58-8616c8498dfmr29556641b3a.23.1788780406647;
        Mon, 07 Sep 2026 04:26:46 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152045f67sm4265654b3a.18.2026.09.07.04.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:26:46 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sherry Sun <sherry.sun@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Alex Elder <elder@riscstar.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Randolph Lin <randolph@andestech.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Danilo Krummrich <dakr@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v5 4/6] dt-bindings: PCI: snps,dw-pcie: Add msi-parent for MSI handle check
Date: Mon,  7 Sep 2026 19:26:03 +0800
Message-ID: <20260907112606.465778-5-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907112606.465778-1-inochiama@gmail.com>
References: <20260907112606.465778-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IMSIC device on RISC-V based system does not require ID
remapping for MSI. So this device only needs "msi-parent"
property for IMSIC-based SoC, and the "msi-map" is not a
necessary property.

Add new condition for MSI handling on IMSIC based SoC.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index b3216141881c..91bbbc8924f6 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -27,8 +27,11 @@ allOf:
   - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
   - if:
       not:
-        required:
-          - msi-map
+        anyOf:
+          - required:
+              - msi-map
+          - required:
+              - msi-parent
     then:
       properties:
         interrupt-names:
-- 
2.55.0

