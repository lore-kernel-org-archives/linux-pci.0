Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B62D3264E7
	for <linux-pci@vger.kernel.org>; Sat,  2 May 2026 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777716832; cv=none; b=LxVuXBZezmFzjVuYMFFmT/947zLwgrNdiRL3jc7h3IRMiybFn5Z9mp/1n6KnJ9UZyGhBFU+qz8dlYgy9P02CsiWxbOvG4qS9UyX181fu6Q2htVFra2iEqRy6mb8IpBusyY5ux+kVaSRhVeyB9vtnh+aNybEjAonyRCpB0utauok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777716832; c=relaxed/simple;
	bh=Qeyor5pnGeEUxHDLnSAUNrklZACkQd3iPe/8N51JgLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p482qd3h64hMdRtTmRTpKPiRRm8l+NXPEwUOA612jdO6LrLhWiuNiUB55i2QdWlu5kbxH5FAfrAil9ASMCs1A2Kha4/kzhlc/o3nz0I4hLQOdCRDA58vGDLAz+Has4w7HGvOBi0B4FvBa6GCMMON/lYj+tf7UdNcBXFuxbO9JWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiCgcBXU; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiCgcBXU"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c76cce85bd9so956452a12.1
        for <linux-pci@vger.kernel.org>; Sat, 02 May 2026 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777716829; x=1778321629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xxbrEotld4A1INaWDXAQzVmz+vSmMssLxNlmQzLKGY=;
        b=kiCgcBXUAWJwH10riDIuTSYrQlMnGZsVj4epzPPBHl080ttjr14cLDKL1p0snx+G28
         tQjqxbX5VnOLP+iq+VJjGLQtcXXPsxASvjFC0ApGjGhHTfnuoiLjAoDXQR6e8cmeCB7Q
         15KS27gs2IMoYMjl1veGxvx68ZUm74wG5isPB5cPprXApLamM8Pvp9khv4c0BB4QpOyl
         7VwNlMVd6pBprulFCc/qO0fPDqSKpfP2NkNsxKmq2rzzXw1z3Z86UC4n1ZbzQKY3mL1I
         McSAKrPWYBa4BP6DnDBf2+BU2JW8y7tlhd6VIneWs+hrpJiADqWIzoJ88j0CWZapX/CN
         OQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777716829; x=1778321629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/xxbrEotld4A1INaWDXAQzVmz+vSmMssLxNlmQzLKGY=;
        b=eB6hjLA7xGBsb9TIq8bmfvRVTGyd7y1l6lzLRPNROXJS+Oon7FesA7708f0yI7MHoM
         VN02q5S8hlyok2PIZB/N1fx3JBo3KLLP0K7WQtODPZ58xzAddSxHjDXKBFnjq50SdYsb
         LMuzJZNlouhOt9Vvzh+3Tqr4fLWldLIpkIzRczCLr6JJKfms0hMEC50W1+Vpb4OKrj/0
         Ol3k6f1qAGxN/KB0PSH5Zh2goLiBIONi7SoRkv0Qw/XtmAAr4xfEns0fII7gqojsEo6w
         1CiZtufW6XnUzZJL1Cnh5P+T0Fs4xgK2yYKH1N0Nk7IozC+QxG6zYnlEt1n724lnJYAi
         3zsg==
X-Gm-Message-State: AOJu0YzQQkLl0be22JIUkAf5QA6pzfZnB+EF3epmTkP8M5YvmngNTXdN
	uehAI+AxlZuGMTBxcQ7yqfdQCI9ihJmlazgmEoMyJon1VIz2Me0nKgB9
X-Gm-Gg: AeBDieuUXXh8Uu8pjyH1g4JtAAxPWX0dHWfn3OyKbWCILj/CAdOGr+t0htahI3bwIUg
	d9D7boOBr/FMHu2YYsSiSpkzUTPkU+6l37NxLT7N43gCQhpLloec/wwhVWHHzaIniFex/lqiHix
	Fl0LUe7G1UcAulV0ukJAvfbUM2nYj2cFtThUQC6dTH/tJwKFCTl/iteuuD05kxq/O3aaEp21PDt
	BQYduJo1o0hgWWrJpuPX3MMIWzz27hAv2UWIOKuV+ugTAtj8yp79zhow+888lCSYvbej5OdD3ou
	rZjlGv+Bchbore4CZqFvr3KQmZQq1UJ/qBsG85vlma4AxygPGEGDmj6O4kkDhW+znnkqbMfLdZ+
	vqdTQ59Y12cag/AOpz/thkXxgnqkqucr27KwLecan6o55sGfWV4Czn0tyRD2MkDb5fMuwiWZisH
	qGWNuK+jLvgPrtW23lEc7tCu4vWk1u5xCEhW/H30FuNxvI
X-Received: by 2002:a17:902:d20c:b0:2b9:ce81:fd75 with SMTP id d9443c01a7336-2b9f25674cemr17239855ad.11.1777716829028;
        Sat, 02 May 2026 03:13:49 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae6d123sm50453575ad.84.2026.05.02.03.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 03:13:48 -0700 (PDT)
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
	Alex Elder <elder@riscstar.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 3/5] dt-bindings: PCI: snps,dw-pcie: Add msi-parent for msi handle check
Date: Sat,  2 May 2026 18:13:16 +0800
Message-ID: <20260502101319.2364052-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260502101319.2364052-1-inochiama@gmail.com>
References: <20260502101319.2364052-1-inochiama@gmail.com>
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

Add new condition for msi handling on IMSIC based SoC.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index b3216141881c..6a595207fae1 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -27,8 +27,11 @@ allOf:
   - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
   - if:
       not:
-        required:
-          - msi-map
+        oneOf:
+          - required:
+              - msi-map
+          - required:
+              - msi-parent
     then:
       properties:
         interrupt-names:
-- 
2.54.0

