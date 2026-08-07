Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69CE3EC80E;
	Fri,  7 Aug 2026 05:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786079880; cv=none; b=RL/hNWvkyLawpHmEtzAxfSzep7j7qxWlBgcMEbxPmh5mmOxJ1B+LsuJHNdtCX8z6hmfa5tErMmzRVEJxjQbjFw3h7ZXeCRGlXPmHnAz5VT0+GBlnG05WQfo+mnXxMbnzZUmEoEz2kZcK0BEzWl1A44ISMvOzIQWz9HDa2MHyFRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786079880; c=relaxed/simple;
	bh=4brngzrers1xDZQqQmwUhaP3XRhfqaEllucCwkZyGqs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nMcoGA27u3JeWSsPYwvuz4IoL6HwqC7NfRzqdtO+p/bttYB5kxHaR8ggLabQEOcH4v+3ogkGwvHuABk72w25F9yBA7YBctBq4sIV/SFJwJ91F0hq0Hu7gzRgZbkp9VST5+0hc+VgMoVRq+VpuSye/3Ke6IWhWik/ckFbULLVsDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF661F000E9;
	Fri,  7 Aug 2026 05:17:53 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jia Wang <wangjia@ultrarisc.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20260731-ultrarisc-pci-clk-v4-0-d738b491e49a@ultrarisc.com>
References: <20260731-ultrarisc-pci-clk-v4-0-d738b491e49a@ultrarisc.com>
Subject: Re: [PATCH v4 0/3] PCI: ultrarisc: Add DP1000 PCIe clock support
Message-Id: <178607987296.222033.489723434098522246.b4-ty@b4>
Date: Fri, 07 Aug 2026 07:17:52 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Fri, 31 Jul 2026 09:14:27 +0800, Jia Wang wrote:
> Add clock handling for the UltraRISC DP1000 DesignWare PCIe host
> controller.
> 
> The DP1000 PCIe controller depends on three input clocks: core, dbi, and
> aux. The driver accesses DBI registers during host initialization, so the
> clocks must be enabled before the controller registers are touched.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: pci: ultrarisc: add required DP1000 PCIe clocks
      commit: 1db733541d2ead366e0b894e1f15f1a4c4e86376
[2/3] PCI: ultrarisc: get and enable DP1000 PCIe clocks
      commit: a3564a2a610e24a0201736cafc44ec068d01cc2a
[3/3] PCI: ultrarisc: use module_platform_driver()
      commit: 30f22cc3ca904597193029929760186cf16033fe

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


