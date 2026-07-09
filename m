Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4657832B10F
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 04:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783569692; cv=none; b=lnWuPZu5BnW/WRxifvJBp8wcC5rlj6Csdoe2wz7MWbL0r3vnOkx6HT+unc8E9g7N19djXiQ1XpTOv9xzNLSTNYftqy+RgJE3qC5Lm+gFCxQQgVQnNOn1ED85KFxfjrzdWSUFEp+32Aa7vm2XuDA4Yzmk/Ca0yT1L9rRYpVTa8PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783569692; c=relaxed/simple;
	bh=L3fsKyGi5rpLNg8G/ROz7kxtpDKTfFUi8q+A7hQ20Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npvIe5qlZgi15wYf5SEu7PMcxo1YsnpkmW/sT9HXiiKISO8MiwHSeHsHQm7tWaCQoFTWd0RvuqOZk0bxEj8DV75yMrYR3ykDg+yCqqUPSmD8Tg7BRSf6niv5IhwAc6uJ5a4zDjMu/op6Cx+LNJNaY7qWQvxjYoQkpK+yJ1gBxoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMukBshX; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMukBshX"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84861fc51a5so14621b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 21:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783569691; x=1784174491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7AEeGlWy9uXP/q/PPr93GfqgOECgNHQd0LWMUmr1tVw=;
        b=GMukBshXkJIxt9ZD5Bp3JJU6aJSmvW1u1O/0UI0stX8iYGTug6ol+VmX9z0K4k6A60
         5PSrtxcfXOQI9pp0sYKEGFIsoeFqtqAw4/gol1L1/SR/kHOQMGu23rnsvXc9tUzBDRKC
         ieCX2FDs7ImbMXxuxJVmArTlXDoNUOD2wHu3+j4Kh1nzhBDGOy2dz6Ag/TRSLqyGZMIh
         VWRgs8kA0jtmmBlPvjXY8L/NJtWQUMOQODdFChNLIxx+bMDUqMPa82AfRzPRcQ3rHM6O
         A3KZbvxXYCH4EEtg6id+RwM8MeeDCHN2eKnzs6IXyt6n56RP0kYsHmSvd35Qp8D2waVs
         X3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783569691; x=1784174491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7AEeGlWy9uXP/q/PPr93GfqgOECgNHQd0LWMUmr1tVw=;
        b=nT2dYFRbL/GHWnLmmdKbyecyAntICRSAlsMUyFAdiORjDIYabQf5btrkCFhmzm9KIk
         IXneUpLwIICianKEbRQbl4Uv3Rk9/VPUnOjJCxCX9/85GK5C8bnyESkRzgS+tF8VRaNc
         y/P8eFFqp4TWOhX/r1ep0zCwjGDldy1qCKmyzwaGdcIE50jMBPD6Mk9aSgc4xFmWhTBF
         7uAH49AWTVS6zWnwvnVaXe6qRYjakHOOi8geMWsvUYoWI9on07SSIn6E1wbF+EFtQQM0
         74ffCAf3IboVUwJHsK4jEou3OzesosKRw+PphmdqDcAgk4xjfXL1cFij4vWxgovwfIA7
         JrfQ==
X-Gm-Message-State: AOJu0Yx6Ww+bYAcv/EwTqWUUg7G+yGyJSsKDq3git31LtQDietZUESdv
	JpAem2a5N1iTIJsyq6bo7qW6LK49BDwHiR7HJFiVH/nFWuxrTGPgFZu7
X-Gm-Gg: AfdE7clltdTJONILdUTq3udi1PSiCGKifLlNiQs0MbWKM+xfCRa5g2OWQA0yu3A8Wt/
	sWRYGE/98HEMKPNBdktYAUKT35F9Rbr5JeZ0DQadVKRFXnKHry4fzneSIEN0rjEOfGX8ETwQanA
	M3HJ7zwjaEPn/31iZ87KtYAz3mhx9zh6tJkqLxw/FZ26eVsPWXqkRUYES4Jr5q/EGF9CBvXICA4
	0IcQPq6h04oHlj47HEFPnFR6Kq5JJFwjj7sYTBK5Tty5JcHwGlnLz8wE0B46IW9o9Tq3FxNbQLR
	vgoLpfpAUVESbBENBiX5qyv/YlQQerQ/bzodkMNtDJf79bP5D2aozQI7ZmQty83ahdxDM4XxCC1
	Un39r6eZK11dLiVkOb74PobU9Hotz4coChgN7l2/AnCu3XBBYNq616gUEADknjmR9
X-Received: by 2002:a05:6a00:c88:b0:847:881c:7026 with SMTP id d2e1a72fcca58-84842eb7ef9mr4875368b3a.3.1783569690624;
        Wed, 08 Jul 2026 21:01:30 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b93f8csm8273199b3a.19.2026.07.08.21.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 21:01:30 -0700 (PDT)
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
	Nam Cao <namcao@linutronix.de>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Alex Elder <elder@riscstar.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v4 4/6] dt-bindings: PCI: snps,dw-pcie: Add msi-parent for MSI handle check
Date: Thu,  9 Jul 2026 12:00:24 +0800
Message-ID: <20260709040027.958400-5-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709040027.958400-1-inochiama@gmail.com>
References: <20260709040027.958400-1-inochiama@gmail.com>
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

