Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AA8372675;
	Tue,  7 Apr 2026 02:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775529766; cv=none; b=P3n+XVaxEqnaO0L0ADCbMSNi/HOyP4WsyyMtinyQeSq7P5gXZ0LR5tzj2yRd4Oel+zawoSrcxdZ4rKMRLPeMi7nU05BSXI/tx37Ib9hpoLm0Xw/X7sfkUwditoBYGtSzB03FC0ZY1xWdnANw1Jkc9nNCEf++e/84jcKC/1Zg8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775529766; c=relaxed/simple;
	bh=2BZqFPQe7ZUR/8QtDScuAwxFzFvibJ0/lbthK8okdZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K79Ok3+5e9S1DAgmACJ2wHgdpHSyQqsR9R8uUodVlw2/sbe2szgnf74M9hgXGW2l2ZM0YVF36LhxTyVcsmWvD2a2N3jFGn32u02aUmx1m+Vo10pgnXs4KpGbbRELjbgBOuhIPUtpnwTBABSVGPAoS3HJA9cyuGm6jNqH6/Lsqgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=peATmGC2; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="peATmGC2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=U2LYLqsQqE6vo0BCMVpbgQFy8GUf++Y
	cC5+RdbPFp0s=; b=peATmGC2Nt6AnZVXh4vJCYxT7dIck8q34/aJdlOl/qmDOgE
	XjjI6LEL5vt8mjeWz5vM+V+9J0nt+0GBTWb/FVEssQuuzBKg1RWvibK7Qz5++DAm
	wrYckE65GgDVXMIz1870A/3KF5LQos28hMqkjUBApP+rwRXXin0sjYxJSX5U=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDXEELwbtRpBZsBAA--.862S4;
	Tue, 07 Apr 2026 10:41:57 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Date: Tue, 07 Apr 2026 10:40:53 +0800
Subject: [PATCH v2 2/4] MAINTAINERS: Add entry for the UltraRISC DP1000
 PCIe controller driver and its DT binding
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-ultrarisc-pcie-v2-2-2aa2a19a7fb3@ultrarisc.com>
References: <20260407-ultrarisc-pcie-v2-0-2aa2a19a7fb3@ultrarisc.com>
In-Reply-To: <20260407-ultrarisc-pcie-v2-0-2aa2a19a7fb3@ultrarisc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775529665; l=906;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=2BZqFPQe7ZUR/8QtDScuAwxFzFvibJ0/lbthK8okdZ4=;
 b=kYprOHgEELwb1wXhKp6khEG6yvTvLN/ALPw31WwJTHU8D0+C+lQIqFY4SZUvB3MGNmgFg4dXc
 IMu61M8s7wTBFwH4YETQ/dzeYDPFWnAfeVpAVGrf4yI9G0s4d4s5PNW
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwDXEELwbtRpBZsBAA--.862S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZrykuryxZw1fKrWxJF4UXFb_yoWfuwb_Gr
	1xXrWxZFWUGFy0yayvkF4IyryYyw4xXF1Ik3WktanrZ3y8try5t34ktFySy3WDCr4rCanr
	JF97JFyv9r43ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbB8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
	0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
	ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCF
	s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
	1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
	JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
	JbIYCTnIWIevJa73UjIFyTuYvjTRRCJPDUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAKEWnTLbsAIgAAsU

Add a MAINTAINERS entry for the UltraRISC DP1000 PCIe host driver and its
DT binding.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3fe46d7c4bc..c8159670a14d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20582,6 +20582,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
 F:	drivers/pci/controller/plda/pcie-starfive.c
 
+PCIE DRIVER FOR ULTRARISC DP1000
+M:	Xincheng Zhang <zhangxincheng@ultrarisc.com>
+M:	Jia Wang <wangjia@ultrarisc.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml
+F:	drivers/pci/controller/dwc/pcie-ultrarisc.c
+
 PCIE ENDPOINT DRIVER FOR QUALCOMM
 M:	Manivannan Sadhasivam <mani@kernel.org>
 L:	linux-pci@vger.kernel.org

-- 
2.34.1

