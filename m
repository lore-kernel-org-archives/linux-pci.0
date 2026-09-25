Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C954E37B010;
	Fri, 25 Sep 2026 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349934; cv=none; b=Cmns0YJfFbgvbPRczHOMkQ9H4RnFAR33V0klZw7kPSFPr/DCEG39j5e8mqFw1Ij/io6dd9yW6Q4rZ6c//gEvz1GfUFOS0LZp7O0FMElQoik+J4ZD12PnpCF91AJ20surH50ekGOdLBsZy7kpli+8DpVTgCCqCwel/uD5D71/miY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349934; c=relaxed/simple;
	bh=8oTDXYZ0a/tY7uho0asmRnYog3FDhF0bwW68FLL7OEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=indhB7ZgT8d50FBChV2YT4/nyg5kn8koqt8JQoxStxz1xFEQhzyQfa1zfxoWjciy2B9QFbD0GaEDMPIjSfv+uozI1Ue+vSUfrgZ3IulVnxYNB1HWFCsqUVoc25BYFZWWaYkCmFoLvqfPemmp5c+8Y/qDV+qRme9HoT5dCcIMG2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TklBtAtv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TklBtAtv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE2E1F000FF;
	Fri, 25 Sep 2026 15:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790349933;
	bh=XjJu85d7wfISfmZzNSzPkWwyChELnjkdxti837YiI74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TklBtAtvfD4nKCooVinJbxY9ggCZg+43JN5Q8zDDCGOS4uG5RKMm55zXl3VbJpGKg
	 J47SESdECcQgOBxpGz0mKeWEcyGcDOXNiN3eXsjOLxhXyi/5xF09/VxrH3D6USBb6W
	 tbCKDpLicK7Hkus/J5y85XbqUhWWHw9BLpaQF+rplzaH9zNmLelzrjShAA6cVbeNon
	 Isfq6SxEv7TD8gHhILn9TsO053Hk/dQNU58rhuhrb5IYURSuhpvY/cuLFGLuXq6qWr
	 isHX+UVJ3uALkTHTFdq+eI/K+eMvShr5z6+MwTnbNoAi2WpI0RBiK/FUcQ2gIvCG62
	 Vzsk3UmQnlLzg==
Date: Fri, 25 Sep 2026 17:25:13 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	shengchao.guo@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 6/6] phy: qcom: qmp-pcie: Add Nord Gen5x16 PCIe
 multi-PHY support
Message-ID: <q6trptalussxqayvkvfti7cm2uje4a6novrhelxp4adzd7smtu@3j5rpztp7jmr>
References: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
 <20260921-nord-v4-6-ed05c6e09240@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260921-nord-v4-6-ed05c6e09240@oss.qualcomm.com>

On Mon, Sep 21, 2026 at 11:07:14AM +0530, Krishna Chaitanya Chundru wrote:
> Add support for the Nord Gen5x16 bifurcated QMP PCIe PHY.
> 
> Nord has a single PCIe PHY block split into four ports which can be
> used in multiple lane configurations: x16, x8+x8, x8+x4+x4 and
> x8+x4+x2+x2. The active topology is selected through the link mode
> configuration register, and the driver exposes the corresponding PHY
> instances based on that mode.
> 
> Unlike Glymur, where the PHY is initialized by firmware, Nord requires
> Linux to program the PHY registers. Add the PLL, TXRXZ, PCS and PCS
> lane initialization tables, along with the required power-up,
> power-down and soft-reset sequencing.
> 
> Add per-port and grouped PHY configurations for all supported Nord
> lane modes. Also add support for regular PHY resets in addition to the
> NOCSR reset.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
