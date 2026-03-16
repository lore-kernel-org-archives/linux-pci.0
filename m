Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF1625A655;
	Mon, 16 Mar 2026 07:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644924; cv=none; b=W18JAr2GTpLOjNXYY4+JSYJ6Nm4LHkv7GOIX1sPVg/zZ+JK7borsoquqoTc1/xZovG4OIeLOIjf3n5V+OKQ/jg2BIJZ+/+y0hZ/DdRgeTkXVbTQv7zTrdrYVsm+WqEJQYxhgnUaSnM386axE0qNhUIGTA9cpXitXBpnb8jl0G2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644924; c=relaxed/simple;
	bh=z8b00Wpe0tqY2sdgNkFnxvoSlPzsj0DJD5o/z1/QSgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eSWPX2bjHodN9wqNQ8XAw0o7Yv3tFxNvIN+3mskACAIIhPlQt6jknKJQ19xHwD30dMS06G9NY1GamBodtlUkHI0KPRUuVD963mY4XJwtjmFmdx16AxXVDdd3kA0tYoCKfZITi9PUhet1aImQSlzQ8PUdcBRZ4oRPiyshVgpQkjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBOthhul; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBOthhul"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 664FAC2BC9E;
	Mon, 16 Mar 2026 07:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773644924;
	bh=z8b00Wpe0tqY2sdgNkFnxvoSlPzsj0DJD5o/z1/QSgU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sBOthhulWuTQZymZACqDS5N6zBdp+Cokaef4/Gqa23BIQRcaJrnJ99Ga/ojflkraO
	 jGrnkonOKdCxfAuIx/CWSVxT2iK2dIZIkoQHhhbZT9chxsZ0iSiT5grX8rSo9UqT7P
	 Exl8S0L5Fsv1GQrhhw9vjZaE4IIt57lkdxoPIkLOi+/KEOroedfOKi60sENSxuid4k
	 QkgHmPXG65aLuM7ae1TJttDEsgMP9qncKaFZ1uMXonMXDy535ftSH23rSr4tfLULVT
	 unhJTjwjPctp8ZtOKDO4OWfpxEYQtGUyTF/sVLit+Cg/7L1iCOE578p3hqd6ba0gXE
	 BoxBF3Hp+EeFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5538DEFCBBB;
	Mon, 16 Mar 2026 07:08:44 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Date: Mon, 16 Mar 2026 15:06:57 +0800
Subject: [PATCH 1/4] riscv: add UltraRISC SoC family Kconfig support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-ultrarisc-pcie-v1-1-ef2946ede698@ultrarisc.com>
References: <20260316-ultrarisc-pcie-v1-0-ef2946ede698@ultrarisc.com>
In-Reply-To: <20260316-ultrarisc-pcie-v1-0-ef2946ede698@ultrarisc.com>
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
 Jia Wang <wangjia@ultrarisc.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773644922; l=955;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=yTvCixoepaOP7H0g0NOlrwpugZtb4VLtAcECC0j8Mq8=;
 b=1g5NIQahZ7vZ6VjqyuGZB5s/gvegIH0PTVHfuyaBYDlH54vV/CScnL3pV3MVIlvRbTwOEuJA4
 ZPs04vuYuvzDhlUXRSp9XodapVXofPuuHk1D5doYu+D+/fmXQnoX+Nu
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-Endpoint-Received: by B4 Relay for wangjia@ultrarisc.com/20260309 with
 auth_id=682
X-Original-From: Jia Wang <wangjia@ultrarisc.com>
Reply-To: wangjia@ultrarisc.com

From: Jia Wang <wangjia@ultrarisc.com>

The first SoC in the UltraRISC series is UR-DP1000, containing octa
UltraRISC C100 cores.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 arch/riscv/Kconfig.socs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index d621b85dd63b..f49d3ccaacde 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -84,6 +84,16 @@ config ARCH_THEAD
 	help
 	  This enables support for the RISC-V based T-HEAD SoCs.
 
+config ARCH_ULTRARISC
+	bool "UltraRISC RISC-V SoCs"
+	depends on MMU && !XIP_KERNEL
+	help
+	 This enables support for UltraRISC SoC platform hardware,
+	 including boards based on the UR-DP1000.
+	 UR-DP1000 is an 8-core 64-bit RISC-V SoC that supports
+	 the RV64GCBHX ISA. It supports Hardware Virtualization
+	 and RISC-V RV64 ISA H(v1.0) Extension.
+
 config ARCH_VIRT
 	bool "QEMU Virt Machine"
 	select POWER_RESET

-- 
2.34.1


