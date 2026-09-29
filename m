Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4FB47F3C2
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671100; cv=none; b=nbYHm3mvqYtxCDe5MlNFDz9BaOGY9l2LibllOxYWRBP9ncLFjDDLUmX5/PV88v+G5R4utP5AQwvI8ZUc3cco124VYDiCCKAgxDVopzM//P+8O8IA+LYQcWpyGf8ZHkIESBOG36bfQGEaHkn4rbGpqjS3Up+A2ogszU5m6B9Ofkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671100; c=relaxed/simple;
	bh=L3fsKyGi5rpLNg8G/ROz7kxtpDKTfFUi8q+A7hQ20Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Df6UNXApF64N4fbt+uy/j2BXy1cuAFeYdhHVIklEG7DxVseiIUBJa3k/raIrWYEWvP7YJgvnk8TsM1S/HoNs6OCRUHz7lX3I1xbRHa9iy9sTfLKkSBvWHT7nFNB84R6iBtz3jz0Bkw1wbhquLu7i8ubDOUV/c5DT9ABbYfpdjv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfLf0uyW; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfLf0uyW"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd4f99dso2535025a91.2
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 01:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790671098; x=1791275898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7AEeGlWy9uXP/q/PPr93GfqgOECgNHQd0LWMUmr1tVw=;
        b=DfLf0uyWUU5DYCLeqZXxmnCbBMN8XZfYhdj2XXgoLkQpaN4Rfk/3a8q/ujgZcpohtu
         PFEUCIM0fb3bkSUmB7AhBX1GjpbPPElQvTEK5bL8nT/0wAXVTHgu+aWYZkwF/YPPCIoY
         DP0k4STUBwTea3C1e1p/DYVWIAAjK11tjo61MmjGfoY39Rc56RdwpcapGVoqnDKuCjbn
         +iSTkSTpAC4M+e3FLDeDpX2ufWNpoXo2N0IhlDD/KlAYxGOVdD+nOppzOdaQyKKJ6k4K
         CKE3ql6ZRw4OTkSGnr50g9T7UH1DNEgm3IWtQg0Hmtu+I0emaNgHoC+4P2CptcMWdxbM
         HcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790671098; x=1791275898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7AEeGlWy9uXP/q/PPr93GfqgOECgNHQd0LWMUmr1tVw=;
        b=vhniTC3W6bs6f+YnJx86g1tMr+fQ7Fg5D4z1oZZTrKlIIeTpt96SSmMPJzz/GMB9uo
         vIYaQxsyXHzAaocMU6bzqQyJclRVDMjm9kCnh4Xvy+bI3vo6d3OnpqDP6lpoP2+OF0M3
         JDVzxaBscd+VLfW798KR7bM6IYz3O/5KnDxb4HzuBJHKPDWMfCotFHuEL8vQ2eFcrm20
         0NZxik2myR8419uOPwLvgiC9rRF6TvIKkTudzT2JlHFXv5Thh9QSyrLegqqPZUTwNuSF
         LUxndm6YfLQyqs5mtmTfMDdXK1APqePACj+5Hz0HsrWs7IQhJcxeBXZOruDNUJG1pMgS
         O1UA==
X-Gm-Message-State: AFq9FYKpgoCH+BBQA+zK2t7Ko13g22baVYmQuDlEwB4FQE3uXUlpqWCd
	PSXA2u71be5oFLEVKbVRDjvFc8Z8V7smDay9KNBBEmGilFDraXgC4T0F
X-Gm-Gg: AYBFou1y+I+9RBxXp0rsiK9cjxQKQAkdIlwPZ9e1gGiw7+66BS7HLXg9iTe0knd3Mpe
	80yF9u3BTQcoR22SLch/1lXzCzluV8l+UVboJXj15yn2yjVWBczMiK8jgriI2GF6lVd8bGZU0Oq
	lWrs91RIy589o895Eo++dmYooyUrXS7tvvRm7+g8x/csVtPbicRbcWl6A9Mk58AITS1lQeLjNI8
	WSL7EGgPTb2sKuyIiXUu5CFnYk1B1A54ALHA1gJ/QTTYoDX+Cj1FSlFXiDY1zaFHAh7O9JHuQOb
	xXYYROdmY3yV0hsMQnuyJaXFIrI9feq5Hc9ZCrDkKBjra4HVVrE/SUu+YEHx6mJhdQQBNEMjvsI
	GiUH95ghGdvXU8TPP9vAuo9Qacw0di2ZPrsYDPBMxkjTYsLXBm9u8w+a3vXoWU0DRJFBaNIY9Gy
	TDbQ39rCsmrNXvi1MOnmdZsKxwbKMsiYIBK+a/8EWB5FD5/q8a++Guqk0KlhKVGDKvNSQ4
X-Received: by 2002:a17:90b:2251:b0:3a0:9640:8031 with SMTP id 98e67ed59e1d1-3a098d4364cmr12391254a91.8.1790671098293;
        Tue, 29 Sep 2026 01:38:18 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7a3b8d70csm3751988a12.9.2026.09.29.01.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 01:38:17 -0700 (PDT)
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
	Arnd Bergmann <arnd@arndb.de>,
	Niklas Cassel <cassel@kernel.org>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Randolph Lin <randolph@andestech.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Alex Elder <elder@riscstar.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v7 4/6] dt-bindings: PCI: snps,dw-pcie: Add msi-parent for MSI handle check
Date: Tue, 29 Sep 2026 16:37:50 +0800
Message-ID: <20260929083755.458238-5-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929083755.458238-1-inochiama@gmail.com>
References: <20260929083755.458238-1-inochiama@gmail.com>
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

