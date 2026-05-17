Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A1B1FECCD
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 01:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778982566; cv=none; b=aiYkZSs4U1ld4kDjvptjcFAq3M6CpuRmKIdNwFVQOoNu7CS/OnoKa25KOtfBw3nPKEIHbp1FX1NycKbIqyy2AECtkWHXWr3VitZFX0oATgHFdkVcdpUj7MJHw7bMBXoipXk7OZ54yBP81AQTfEs3WWtMN5AmhRCwdsZ8XQd39A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778982566; c=relaxed/simple;
	bh=0Oscz7/WLUKTye1b+R/+VWNQskuTvIsNTNGkBlIb80Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+OyRvTubY0z03eVrdDJnVXB4loLmu3Nm4gJFmhfbL49vQOzJF69z3WsLkzXD2BTwjfhnh6ZXBvljC6kdt+kn48X8456rrqleSaFNlA90tZNMsDi+F5QcKnZ+LTHWCX3YYLkC/ZUb1MaKAIQlnv9e7o2S1P9OvKRZCTo42PL5Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMLknvuo; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMLknvuo"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f8893bff3so464840b3a.2
        for <linux-pci@vger.kernel.org>; Sat, 16 May 2026 18:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778982562; x=1779587362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBf3UIF6lGXHsknt4Ghf3Tw97w9Ex+KKpzto98h8Prs=;
        b=TMLknvuoy/KmJN9iP776T4r+jgFJBMG/Az02z5KmsPmCfjY5/V/kgdUIqy+aHm9zCS
         oaHn6x7BMd4fzAuBqk0xcIeEoYpXOFwF4y8p133yyaVM4ed07CQIEyLZVdG7r6AMJzBb
         7PvTyqiBtVi/a3jszxdRbgQaGVvhd5YRMfNlzfVlcyvS+IrdUpjL6QvewZ1hvdFkGZlB
         tZP0xILnuDcJho7KmIUb2P+YH7OgZhha7Zf/BGgv8hwgX2SXCPctbnck+urVxdNz5UsJ
         e2UwjEeMEi9+mhsSo5yMfrDtqIIZNeuH0LV8/X9df4h2XOJ3OGjkul5uNy3KFbKw5Mp/
         xATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778982562; x=1779587362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pBf3UIF6lGXHsknt4Ghf3Tw97w9Ex+KKpzto98h8Prs=;
        b=i323OGxkJyctVj77QlufDMtn2EXtgh2ofZp6nX6T3YrwrX6xlE9rtypZ0mu4sUaBnS
         aNyZ2IjJx7B19qpdDJBh4IuQMbgSyf663zqDXxVSjRjReqRRxnXboY/Df4E/GNgdDoQC
         4XCIsi+2Cjqf8PAP7ZXisxWusqVLF0fww1pUYzP+/mWu90bAoQGzoHUT56/LkV0qciEN
         m1aqBJH+10wOQYXD6uTGsEJmm2UoCIUg9QmroG8cveD/USsCyeY+y4x5Z3qC3u24geAM
         kJAditXnaScaQYXo5/oBrZZfecAqn1hQfc5hojN2Tgk/JyYDxiv5dL9OZF/RWRHhvl98
         kltQ==
X-Gm-Message-State: AOJu0YxJ2f3kyu+zcvAsF5jES81TsFyvcGJ0+2ZrL+78DiGYBN/oToH4
	TWyNHlxmjQVbDQlvaqon8/ImMUiW3hw2BV7xYefRyDY0lz2JsdibK7uY
X-Gm-Gg: Acq92OHd1ZEjv6v8RkgwRjQ6fR0uxFQJmL5trIsanMTDP7TzlnioPWOKyzJsqWxOveL
	9RP6KDm3ttRTvCgNffu2E1KwXBcLRqdLsWhf1xUVy5bhCFXU+ek7L/yUOh53UyUDnCPRrfckRCw
	xwvdy3QsaQ84Og07SIwXz5lW6+64VvaWfiIdWFLomUfxeBieK8RkuEr9w76D4Bv0FLovG1k9dng
	hH1whjtJydEnWjXgYyGaYwLwwhwtJTBaF+LBj1pL6n0sr5CRnqxfLycsKXFcOl6cjKPPdXM+D2m
	OBWBkzGOgCn1PukYQ80FdcB3uuG4l91zuyzreU7IoIsTtI7ng5TxUWK77vOa3YYdapBoP5LJmVJ
	q/cNEn2WkVe1ctBKoAbg7rasw0H4b9sX3Rs30n45yROudohJSwZvv/AlHE3U54d9WLLxxEQ1oIn
	Wu/njYA2tvDvZ8WI15f1dMu4E=
X-Received: by 2002:a05:6a00:a20e:b0:82c:e1aa:21e3 with SMTP id d2e1a72fcca58-83f33bca81dmr10011080b3a.10.1778982562438;
        Sat, 16 May 2026 18:49:22 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19f7cc8bsm10511314b3a.55.2026.05.16.18.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 18:49:22 -0700 (PDT)
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
	Inochi Amaoto <inochiama@gmail.com>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Alex Elder <elder@riscstar.com>,
	Nam Cao <namcao@linutronix.de>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Randolph Lin <randolph@andestech.com>,
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
Subject: [PATCH v2 3/5] dt-bindings: PCI: snps,dw-pcie: Add msi-parent for MSI handle check
Date: Sun, 17 May 2026 09:48:38 +0800
Message-ID: <20260517014841.254085-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517014841.254085-1-inochiama@gmail.com>
References: <20260517014841.254085-1-inochiama@gmail.com>
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
2.54.0

