Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A7F3E95AB;
	Sat,  3 Oct 2026 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791020215; cv=none; b=VkMxvO6jNTKMSYnHWEpTuKmqieNj2/M+RtPI1WZDvCQgd99nRuE6FeLONFkRx0xCZ+oIpAAZKOfQ3J9uUC9JJnifpO1KaC1jrGm9G0WsmIK8JDdjl5WNj2HwoHTkNdj2WzjEaDpuJpqGC9Itm82CoFnlRQFXtREpPdiwmBhrDjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791020215; c=relaxed/simple;
	bh=Lvh14d+K7+iwAtZBey497VqhsCfcv9BKvhPddlpp/tk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MnC9lLFGkV7NPU57ZpCci+kpLQkP0IeBw5iMLhLdt/9X76vw2UCwx9aO2Uu81SIk7EuVgw3KneR6nuRQfucZ2gIdfttH2QwQa+adT4W5v+0KXerTcetxDhtwMCsR2c4KMG9dhNz9DXLHYdlfpd0hSjLAgtbts+gv1ciPZWo0q5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efutRHNo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efutRHNo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3E91F0089C;
	Sat,  3 Oct 2026 09:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791020207;
	bh=7gzunmSexxFvSdO6CQV0V+cHSmsOwsggeZ65H1G6LVE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=efutRHNo0mXv5gXDnQ+tGbE2ad864zg/a2diiPhhWdEfMCEwsuqaPXvoClgWYGCVp
	 6ILdp5yvGRPUQ9zL3Jv7GkWz4nPWiDq0rT4X5gypSY4TICE1Fu5R33WrKSVcdjKEEF
	 IS56BN+2WSPbCXLHVT8jmkDFMrue3LKo1Plc7Jc1hgQBXIRMy0OCIkcCDVyIXjCuzX
	 2X1E6jVXkN3gR/gthKJy3LU2A3C4qwA+EYYRna+d+K7GwAzPM9tyYDlCzaxKLwQ/EB
	 7efH6Tj7VHZJXQtnMJYW5ntIgCov554NZhVnJ7csTx/UR+c/Tn8wV2FSa5V1kXUsey
	 roebiVLoEaSmA==
From: Vinod Koul <vkoul@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: shengchao.guo@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Qiang Yu <qiang.yu@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
In-Reply-To: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
References: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v4 0/6] Add PCIe support for Qualcomm Nord
 platform
Message-Id: <179102020242.199361.10760570551982756754.b4-ty@kernel.org>
Date: Sat, 03 Oct 2026 11:36:42 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 21 Sep 2026 11:07:08 +0530, Krishna Chaitanya Chundru wrote:
> This series adds PCIe support for the Qualcomm Nord (SA8797P) platform.
> 
> Nord has a single Gen5-capable QMP PCIe PHY block split into four
> independently-clocked and independently-resettable ports (A/B/C/D).
> Firmware selects the active lane topology at boot via a TCSR
> configuration register, and the same PHY block can appear as a single
> x16 port, x8+x8, x8+x4+x4, or x8+x4+x2+x2 depending on that mode. This
> is similar in spirit to the Glymur multi-PHY support already posted,
> except Nord's PHY registers are programmed by Linux rather than by
> firmware, so this series adds the PLL, TXRXZ, PCS and PCS-lane init
> tables along with the power-up/power-down/soft-reset sequencing needed
> to bring each port up.
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: phy: qcom: add Nord QMP PCIe PHY binding
      commit: 1a60038589285eec5b345f1da05ba04a185b8db5
[4/6] phy: qcom: qmp: Move qphy_setbits/clrbits/checkbits to common header
      commit: 63cfcae23b2b4ca43994d507f5f04cba0306dd5a
[5/6] phy: qcom: qmp-pcie: Refactor common multiphy handling
      commit: 6dd77bf6a10d0eb9ed17f5b6093b3511052084db
[6/6] phy: qcom: qmp-pcie: Add Nord Gen5x16 PCIe multi-PHY support
      commit: e397c8507e362a29ecfb4aef38b408f2de731526

Best regards,
-- 
~Vinod


