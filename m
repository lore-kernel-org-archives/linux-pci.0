Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C89372EC0;
	Sat, 15 Aug 2026 06:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786776102; cv=none; b=mM4m0cI8M/ZhcgV7KHTajI9fkFmlPqHHk0SFbgyIe5Ld7yJyXAieIAUJavpHF/2Qal+D75OI94esbtcYfUlBxuT/mmL6K1+dReiz0xcHZx4jYgf+XQNEcVGXdVH1nHkjwZT3bp4vAcZueo70kgcszENvS555B4vE2tz606Rtx2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786776102; c=relaxed/simple;
	bh=UasE/gtuzQs1vkPmOKn2V0nsW45ad60WZUCCmGlazBo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iMm0nLGGop7+EoA6Ph4MvSFajE8Mlrv+JD/W/B98ghsUxH2geeDyzv0nUwSMGvtjB4jJSTlogQ0WRWrgWfHzV5irQS62otiUKBhXMc16ekrTCYmavUWZM9YCCJpzHHZARBkLluE3QIiIMphIHWZ4xKFr3Xtmf5nx3/qSEY/b5Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF001F000E9;
	Sat, 15 Aug 2026 06:41:33 +0000 (UTC)
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
In-Reply-To: <20260814-tegra264-pcie-v10-0-05d08c592b05@nvidia.com>
References: <20260814-tegra264-pcie-v10-0-05d08c592b05@nvidia.com>
Subject: Re: (subset) [PATCH v10 0/5] PCI: tegra: Add Tegra264 support
Message-Id: <178677609346.498308.4041265473685850703.b4-ty@b4>
Date: Sat, 15 Aug 2026 08:41:33 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Fri, 14 Aug 2026 17:38:54 +0200, Thierry Reding wrote:
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

[1/5] dt-bindings: pci: tegra264: Strictly distinguish C0 from C1-C5
      commit: ba28f970791de8cf1bb352489a37307815d943d8
[2/5] dt-bindings: pci: tegra264: Switch to PCIe root port bindings
      commit: 66305010e3dbf9c27cb0abaa4726ccee5041f9ed
[3/5] PCI: tegra: Add Tegra264 support
      commit: f7349d6951ce4f21fe3c910a8ca93fabdd79c059

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


