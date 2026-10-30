Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793341174;
	b=IJ18ykxu8ZvM5v+BT0Y81tDnKtG2KEFOerMEYDd+Za3iRZZLt20jEkFv9U20ogVdEgtd
	 ktKlEqlm3yFAvy+G9bvki3204jwrMTS5g3fX884dL+0cdqVlAHtqyeEiyFAmFARPv2Hx3
	 hMcyuTjzhFTFNmsgB1jODPrlNFbBdamms3LI1+Av3tdmnjkqHmBDBZF/B03D9lIdSXBzV
	 oBVNegKhz9ZplwAYJLwlYvTGR6Y3KePHBIjZFLnXnWCdAYZZP6GkRuTyI8IemziCzv0OW
	 iDZugunixbz6aK9sd+7PdIX8c2fc696rT51n/Ta4NM6GNCOz0zDXjkjXZ0ufDfCSARw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793341174;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=QaCFwLra8DnG82pikwLY7UmYZm2bl5OOaV+ZPa2+uIM=;
	b=fnrblpYtFF49ppHUdH7NrxbLoBrN+RXi9aAU+uZCMXo3b8ZGToxv2KOd+mUyF8IJgm1N
	 Ii6lR2yx/YQIWYi2tXtJ9kW21qltgG5NvLSsYoOs5nCDPMpTFMAzpf7i8Rkmmdp3ptdGf
	 i5OoYYAqVHZQAAUTvCy70taRAB/wymdZZ/F8jXyTlCogRBj+ZMk2JeStHCoMa0J8QCq08
	 RvTOLahJThU7qP9i3e9MAoWeRddJde+5N1KrvWLZ4OSb+uzb1wvnykxy+KVvDNDriDpQw
	 gRqPZwq4lGB1eB/c9wVcosn05NB7NMiO0NCiBo49BZZqTTmRmBMPx7P4Gxfi2/fSPTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FDVm/0ho";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50020606A31A;
	Fri, 30 Oct 2026 06:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FDVm/0ho
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D51E1F000C1;
	Fri, 30 Oct 2026 06:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793341173;
	bh=QaCFwLra8DnG82pikwLY7UmYZm2bl5OOaV+ZPa2+uIM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FDVm/0hoRpZ9k5NWBWvKxngEP4qLQOUtvrwb7n3FIpbbfW1XsljhWL5m5JX0V7Rxi
	 9ySOL0WV2YxVqusiZRCrvJsUL1xv/VjMg5dWRdVi1Ag+Rw7JPUzBB4BvRzS2zXnENd
	 dfBXZBnXYRbePFmGj6zU+DS9ReMiWA5njzT9lmxOOx7jHJVY+def2ZF0iOZPGJuOUp
	 sfzZDm7rjKklzV0M6wlCi0qvFbXRUMWVzIWZdHRg/gqhSsI8xnf28mTfRqyNZE01Ba
	 GGzdVXwvL0kXuTF9iP+K7FeWZ0DRiXueZKKUb59nQdWMSGMabRqI29Xtc5OCrT47Nd
	 9R62nHfMnuWEQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: shengchao.guo@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261029-nord-v5-0-1a13c214e89d@oss.qualcomm.com>
References: <20261029-nord-v5-0-1a13c214e89d@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/2] Add PCIe support for Qualcomm Nord platform
Message-Id: <179334114173.5551.12630399291214852327.b4-ty@b4>
Date: Fri, 30 Oct 2026 11:49:01 +0530
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=dib3mSnynAOgkHD90d30QPT5TiCCYKF0wRsK3qpWYr0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq5Dbo3c/+lc+jFOulS3o8sM9xyr6yXbWUBG5Ox
 vieb5JcpQaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauQ26AAKCRBVnxHm/pHO
 9b5UB/9jcGdxyvxObvaLWbqvQvDiutHu9IWoG+sqpN0II5IaReKNB4cCmo9OslGRwNBSe4ziHFm
 vWQXq4C1S6u7wnS7dPCOF7zI6j2eDHBJPq64BuHGGdzO3qmMGhAf2DPanIjmpKDxxqZXGpc/9/y
 TPpqS2jcTiINM464YGBV7HTyS4wLeV5KjHhrEYPmqlj1pPABZ5NNFXv4x2KOzbdlOXIDvIfDHuZ
 1CveXoBx27k1CmLI70GDsT1Ica/IWuA/CJme4xLHZjTJ+x032pt443vCoasq2uFNAdT513cjVsC
 h5PahdeTwNUfv9h/Ec/ZUtWybbOpj8CP6iZ4D2ruaCUE8aGE
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Thu, 29 Oct 2026 11:40:15 +0530, Krishna Chaitanya Chundru wrote:
> Add PCIe support for Qualcomm Nord platform
> 
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

[1/2] dt-bindings: pci: qcom: add Nord PCIe controller compatible
      commit: 08e7f53c77c7fa5d34f4cb69b9eed2664cccc670
[2/2] PCI: qcom: Add Nord PCIe controller support
      commit: 399fa58c3715c5a74a6fd468db73ce703193c4f7

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


