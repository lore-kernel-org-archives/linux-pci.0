Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF4624DD15
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783044052; cv=none; b=G0Gtp6Hrl2UTpTybQjgU1xfyx6xrIW6QLvcHHyMx/9ahKmtuvQBc+Vr46Lmzz+BsphoosYV++l4cmhLRnNZzPUJILOJ5DorWlSWshin299PkydIYnaJrrsOD89RiTFwzW4g0KZXSfpOm3uGe4ZRrSKpUu82dL89miiZLi8nIVAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783044052; c=relaxed/simple;
	bh=L3fsKyGi5rpLNg8G/ROz7kxtpDKTfFUi8q+A7hQ20Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USJZXs8JHgWOsM1LH9C7XP2RDA8yha9yChgRO2bO+gg5JSner0rNk+vf4nt/vLWwxpWR04Z7ZPTWXiKMrL1wj10zYrNyy1yG9qXA+8GKzH/tEEi8kWlxD7s906hw9si7sKe1qAMHZ0II6ghxXYZ5pttOybahm+aQgJpgjf9v0+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTw+VDYT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTw+VDYT"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c9ed0c7fc7so527955ad.1
        for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2026 19:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783044051; x=1783648851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AEeGlWy9uXP/q/PPr93GfqgOECgNHQd0LWMUmr1tVw=;
        b=OTw+VDYT42H1lp2ouGANe5zt3jLSfGJSwq08E9juDh8Yi3voOgvVK/K8ona4CPPNh4
         Uqrx2ucHOK80II3MQBk78EF+8Wek1/PwDHvYrkxwNU+tfmAa8zEadUN6nn2Ut3nzwtrQ
         PW9AtNM3Nb73aLI8m1tXOyURBl/Yp7KWIzPhf7dtUUfHciUu26wVMP/y8AWENSIIxK87
         e+QrOnKHA+oCM9Onny5hZKwdedUc2skV3bWpjXcQR9gtmbGkPGrNKhpqPQoTyPlnC/sW
         EoalO3MC2wvVB1YPNBvbfWzU2a/uv5Wj/iEd4vhSG5wZfg5C6fSnO+LmKxJ8IEbMiccX
         9Dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783044051; x=1783648851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7AEeGlWy9uXP/q/PPr93GfqgOECgNHQd0LWMUmr1tVw=;
        b=ZmQK9WEZfLxyYnZ3fTRLXCwMID3VmFJlrRdLGFo9cUlJs3Yt14AiPQSktd+MXTWjG1
         bQ7+1SB4uECmnBHAnKKrB4+mio9ZMx+bttB1idJKLI+iNruoawont213MKJ4iLHooxb6
         PBrWuv6l5v6wzuNaVPtPQAGntbYF0OmeCjGt7ZZ4+mozb7+NffIoLOjGMFyUpo0JYpVs
         gklYOfoXnKF1HSIZkHdJ3xUDfjqyr6qQmeAsgkp5MuqHjyQyjKmFp5uKvsa2b7tNq1du
         4gsNtxzuzu0GScGnG1G5hkARphhLK/0wI/nSozxh3VxCw4lg3k37PvhGIitpt0OSQ6jQ
         BE2A==
X-Gm-Message-State: AOJu0YyaeYLYKhIcgQnjJprHn6FV3q0qPN91UqbxVYu5omCzpbBAm/bf
	EJUXpLADZEkWW3Q3iswNHKrwuNrBQT63vhuPhr/V6BFOrIdIEMa+buhu
X-Gm-Gg: AfdE7cnpz6JIlZlgrLj+ByNUz6cc/GpDZ5HWkoQbJsNMbqyV6BYwrsndoWa6p9eVHXd
	Do9o0B3DRHLvm3LqfskcU9K1UhkWiCYJh90hUBhcwWo5ZMj7QRgaWG4P5mgmc4Hdcxt7gJR0yV6
	0tO2k+lT2IgtmRZkwi712izS3EAIBXcgUk4l5s1hdyMiZGDGBBGoDinFBWLOrMKdyMIwSNcMxOZ
	Z0DYwAvXoHxNPr7Rld2WpDIykzwRpCg+Ue0AulE+v6q3ZwHIYG40rXZM2bCdsIjiOFviDewfkz+
	60hpA4eR32FN2R+d2oatW+DiYO0B714eFNLLC7uv//VrnJeT/AOihKHd+/XgFoVkwZc3BqucFIH
	mbY4xiM9dpKNhZe0f0FTCo4bHU8chwHqmlSHd9aFqTbdrlUaHxfiMfya3D0SX/gWE9dwWzaz+DT
	EkvB0+x8xh0pY=
X-Received: by 2002:a17:902:d541:b0:2ca:e5c:7fba with SMTP id d9443c01a7336-2ca7e87f1f5mr99029145ad.39.1783044050535;
        Thu, 02 Jul 2026 19:00:50 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad71458f6sm1481975ad.32.2026.07.02.19.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 19:00:50 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Alex Elder <elder@riscstar.com>,
	Randolph Lin <randolph@andestech.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v3 4/6] dt-bindings: PCI: snps,dw-pcie: Add msi-parent for MSI handle check
Date: Fri,  3 Jul 2026 10:00:00 +0800
Message-ID: <20260703020003.485436-5-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703020003.485436-1-inochiama@gmail.com>
References: <20260703020003.485436-1-inochiama@gmail.com>
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

