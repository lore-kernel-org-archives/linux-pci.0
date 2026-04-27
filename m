Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A872726056C;
	Mon, 27 Apr 2026 01:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777253566; cv=none; b=Fb1X743AdCfZm4kTbyPPeW++yuoH2bzatZtKMIUO1B9SvHvuszpDCYFBA3u3k8iXqdlwM9NWa/yRCj3xU3j0HfGj9KvVnZttFUJ55KMlG+Ef2Zw+KRT/XjSBQ3I2DnFEAnckQJxSJWmI3RlS7dmsR1qy975bv69FLZCsEtYUxUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777253566; c=relaxed/simple;
	bh=k7xaltOxr1FPtLfLBpXG0T+uklw6wvxgverm552wOjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XKDU3w6KbBAVRj0Il5Pc6tSIcsBGT3DzYzf1jPxnbrBbInP3gBKgF0p/1x8/zbBjXR0zq3hpVujgpK5ZYfFB5RxwRb7QRuP1kntvrN3QST1D3cHZ+E7KSROOvNgmBvVtOMQ8Szz9HKPgwedtx4E2RZKWfNyk3T1D2VoX9MkxNn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=hKPFaOWu; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="hKPFaOWu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=eQFrKZlyykJUvAf7cH1ltvcwo0fJKri
	xuIUmANqBSKM=; b=hKPFaOWurshbXRPwokWX++MQJ0h5ALZ1vk7HqZrShy1ai5H
	aAH0+CUxhoA6I8YaI4p0ZUYf/mJ/3qJIaPb9JttMuVU6wDJ5FRJdrGtSTgt1aU1M
	Blc/rSuyD0KMUyvUqk+UFXreQEcDWSQE0XML9sg2mPg/RiKuTGx9GJB50oxo=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwA3cULPvO5ps_0CAA--.1758S3;
	Mon, 27 Apr 2026 09:33:06 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Date: Mon, 27 Apr 2026 09:32:10 +0800
Subject: [PATCH v4 1/3] riscv: add UltraRISC SoC family Kconfig support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-ultrarisc-pcie-v4-1-98935f6cdfb5@ultrarisc.com>
References: <20260427-ultrarisc-pcie-v4-0-98935f6cdfb5@ultrarisc.com>
In-Reply-To: <20260427-ultrarisc-pcie-v4-0-98935f6cdfb5@ultrarisc.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 Jia Wang <wangjia@ultrarisc.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777253539; l=811;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=k7xaltOxr1FPtLfLBpXG0T+uklw6wvxgverm552wOjM=;
 b=zaln2mLqZ1Yv0Fad/TPkjQDpkYqh8P2/CDZDbEDXOJQ2aHm+YQx0BCCsrZqUwqQ/c6+1CnQ7h
 jm6uQnLUiWhBRsVJyQ6/6hJBb9dWVbls9r9OlCy6OpCwlicJfG6NJO5
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwA3cULPvO5ps_0CAA--.1758S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw45XFy3Xry8JF1Uuw1Utrb_yoW3ZFb_C3
	4xJ348ZFyrAFW09a98Wrs3WF95Aws5WFy5Gr1ftryDuryxXw1xW3yDKr1jyw1Uuw15Xay8
	XrZayFWfAryayjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUUUUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAKEWnti78ABQAAsv

The first SoC in the UltraRISC series is UR-DP1000, containing octa
UltraRISC CP100 cores.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig.socs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index d621b85dd63b..0b4d06a7b4bf 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -84,6 +84,12 @@ config ARCH_THEAD
 	help
 	  This enables support for the RISC-V based T-HEAD SoCs.
 
+config ARCH_ULTRARISC
+	bool "UltraRISC RISC-V SoCs"
+	help
+	  This enables support for UltraRISC SoC platform hardware,
+	  including boards based on the UR-DP1000.
+
 config ARCH_VIRT
 	bool "QEMU Virt Machine"
 	select POWER_RESET

-- 
2.34.1

