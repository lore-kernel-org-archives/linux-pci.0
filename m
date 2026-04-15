Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507AC39C63E;
	Wed, 15 Apr 2026 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776237706; cv=none; b=L8Bf//CXq8xsB+dAX6BMAwp/+MfnEZqbSUb5lDePQacEgnq0zuYrQa4uGds6ZeKPVQJIWSkmOTZSy04cSoVbNbZPLGY+rBZMGL6b4W3Ne2cznltdRt0WaR+uNz4HzgJArvehm0NrFEZ3ju6xSmRRmqHX1atEqR1W3iMJNuduK8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776237706; c=relaxed/simple;
	bh=Zl1FrIKf17blskhbPmYq7tClMDdF35LMCald+AmIzEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OqmP6o5RU4nS5t3Yat3+ihIcL3rmWNsotYZQMVnqGbGOUcXtfvqdx+DWZNFrah3JTktvTDJBsdqDc4airmRz+jF52frzI9U7ER8kfKnRefnHc8B7orY10IYDzZFz48/gqDNCXSWGAZ2h/LxCznktax/Nph5cxCDkTp/dQ6dn3TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=UD9mmmKm; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="UD9mmmKm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=93PIetLPlkIz5EwWi+bTHj9pG+9S4XC
	lsYq9hZG/hkc=; b=UD9mmmKmGqVC2BjXkzWl+dFin12e9M2e6bO1c/w8hIGVPiR
	XN7VXBRwcjrp0aQEbQKRZq3myeGDvaN27IXU59YjHbG0AvmcqxbAuqDmHAp82W1N
	mO+VZ9OwtC9f+hKrIJP2c6fJbytdjAxfJ4+s/rXTlreBQYsOqQJhdMYCiEeA=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnYUKdPN9poSgCAA--.1324S3;
	Wed, 15 Apr 2026 15:22:11 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Date: Wed, 15 Apr 2026 15:21:17 +0800
Subject: [PATCH v3 1/3] riscv: add UltraRISC SoC family Kconfig support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-ultrarisc-pcie-v3-1-73f06e972616@ultrarisc.com>
References: <20260415-ultrarisc-pcie-v3-0-73f06e972616@ultrarisc.com>
In-Reply-To: <20260415-ultrarisc-pcie-v3-0-73f06e972616@ultrarisc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776237679; l=758;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=Zl1FrIKf17blskhbPmYq7tClMDdF35LMCald+AmIzEY=;
 b=v0urUIZhmDHLcJS8l8hylWgWBx7DszuDyaecCFxXIGZ6mVxW7+E/46bwLHk1u35PH3Re4Nu6M
 nEXFzy8jO5KConmUiFmr1qOiBjw8zKh+HGYFVpQsayt9kaX9OX42VHg
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwAnYUKdPN9poSgCAA--.1324S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw45XFy3Xry8GFWDXw4Dtwb_yoW3GFg_G3
	4xJ348uFyrAFW8uFZ8Wrs3WFyrAws8WFy5Gr1ftryDu34xXw1xW3yDKF10yw1Uuw15Xa1k
	XrWfAr4fAry3tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbQAYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
	IE14v26r18M28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CE
	w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF
	7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4
	xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCa
	FVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI4
	02YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRIoGLUUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQASEWnfCz0AFAAAsW

The first SoC in the UltraRISC series is UR-DP1000, containing octa
UltraRISC CP100 cores.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
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

