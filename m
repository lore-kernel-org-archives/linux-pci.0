Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01BD24336D;
	Mon, 16 Mar 2026 07:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644924; cv=none; b=Pzh292HpuLpdP0ypvSIbr8UfSBxqrbmjd7EtyDS18Jj/vn8/40S2XDBxmIzpBCctYjHcWFtkKLQVMmUpbSjQ6KZul6Il7Pqnj7tAX42uLsO65f4Rb+q0x2WvHaGwNieBfS0aYR0JgEhJXjyBbrIrN+Nq5/l5mVgYgj0Bjc6B/Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644924; c=relaxed/simple;
	bh=BSadjRnDeeKrTMXv13HECk6Q7u4nlqDJGnI5AMOxSic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dL1mrgHwJopnagLOD2FgPN3XcUxenyQRtD6iy9NxzxcJsr1ZOIQMblFPz0cdhp5nZ0MEiyIiKupfzZ00D15ZyYLD63PKxjYr4TVtf0/5jPVEscTVpRA5wcbDG1wxQr4usxeYADMoKwy5BWGYVKNsUgYRmZVrrTWEsEBRZDsQci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JH4myvZC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JH4myvZC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72C20C19425;
	Mon, 16 Mar 2026 07:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773644924;
	bh=BSadjRnDeeKrTMXv13HECk6Q7u4nlqDJGnI5AMOxSic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JH4myvZC+SltuwWTqGSOGRM0Br6sS2itgGsMcplsDOsCs/6fqckhO5GV/TelEWRkD
	 0AyE0iItB3/YVmPsNb1elkTPuJG1fLV8GdtUvQf8dtXMeX63IuHrmVKBLBtyz96O2i
	 Ebzi3MOhrOFqjTjZBPj+jhT+IiZ5nImbiIo1iUaE+12YNOW9Zts1AB3/0LXlcPvnnD
	 HWHuEhQH+iXl9k6Ukp9NhXsiG9bgs8f7weHirz6BoFRpDSs/aEPMdrj8PXs6Pk6usD
	 sS4XG1vxz34uBO8bZJDkoIyHuJ4IdFMYEx31GgZPyKREtaFHguxKqAg4dmU1Mr8Bye
	 QBKsNTKBuUsEA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D59EFCBD4;
	Mon, 16 Mar 2026 07:08:44 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Date: Mon, 16 Mar 2026 15:06:58 +0800
Subject: [PATCH 2/4] MAINTAINERS: Add entry for the UltraRISC DP1000 PCIe
 controller driver and its DT binding
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-ultrarisc-pcie-v1-2-ef2946ede698@ultrarisc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773644922; l=906;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=S1wEZ7Qj4tYv0/nzKH9ecqpxkAyEAumj1u8QGL/LCmU=;
 b=k/OPXKc2hLilx+CL/XIe0/HcMf/WLkYIYOEZy5X0GAoCsCpp4g45Z9IQUE+FuAcOVj9/a46Nf
 v3UeZVX3eQtBa2SMl83GV0u3ThurTyk1um3TSrmBIRlCVuVe5p+3ZmN
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-Endpoint-Received: by B4 Relay for wangjia@ultrarisc.com/20260309 with
 auth_id=682
X-Original-From: Jia Wang <wangjia@ultrarisc.com>
Reply-To: wangjia@ultrarisc.com

From: Jia Wang <wangjia@ultrarisc.com>

Add a MAINTAINERS entry for the UltraRISC DP1000 PCIe host driver and its
DT binding.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96ea84948d76..5caa383fe0ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20571,6 +20571,14 @@ S:	Maintained
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


