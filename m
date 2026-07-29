Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBCC453A4D;
	Wed, 29 Jul 2026 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335919; cv=none; b=fD9SCSmxpnxzSGCVWUlHXmXufglcxQ1KBDzh4AnKfORQfc3u3MMHO2w+rPQ6pxOryO+ZPv0uMgJr04td3yTk86TNELv/KLN0K1QDf7nTnplk2RpHSGQPFgwJdolvCArxWnh5Eica7W+K+KwgIpLyrY8heSJjw6ew2spKyz0gT1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335919; c=relaxed/simple;
	bh=NKNiWvzjp9gS2bEARSfiVJuPEEYewhTm1ot+mZ+AARk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f/TThVzdGRoBgswWFRcAiYAn9gnvdKt05oFW+noE4/DHAz/er7Xx6JxgE2S+FS40RZZcHZxNj0rW0k/5Ny+5RPXpijIkwpPHTPp/84FXsUOoQpKzhhIQUYDwYpWMBEroK4VUhzbFs0wlQjCYVfGOhYpC59EtwuWzA2NGachhJbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7D31F00A3A;
	Wed, 29 Jul 2026 14:38:27 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Kevin Xie <kevin.xie@starfivetech.com>, 
 Aksh Garg <a-garg7@ti.com>, Thierry Reding <thierry.reding@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>, 
 Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <20260716-tegra264-pcie-v8-0-23e51589229b@nvidia.com>
References: <20260716-tegra264-pcie-v8-0-23e51589229b@nvidia.com>
Subject: Re: (subset) [PATCH v8 0/6] PCI: tegra: Add Tegra264 support
Message-Id: <178533590733.885241.18362795978523136400.b4-ty@b4>
Date: Wed, 29 Jul 2026 16:38:27 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Thu, 16 Jul 2026 19:07:11 +0200, Thierry Reding wrote:
> this series adds support for the PCIe controllers found on the Tegra264
> SoC. There are six instances, one of which is for internal purposes only
> and the other five are general purpose.
> 
> The first patch tweaks the DT bindings slightly to avoid new DT compiler
> warnings that slipped through because they are now disabled by default
> (-Wno-unit_address_vs_reg). The second patch references PCIe root port
> bindings from the controller bindings, which will allow using the
> standard WAKE# handling, among other things.
> 
> [...]

Applied, thanks!

[3/6] PCI: Use standard wait times for PCIe link monitoring
      commit: 9cb1b6a781ab5166a6afdd4bbcd6044d75bffed1

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


