Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112784A8FF1;
	Thu,  3 Sep 2026 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443260; cv=none; b=Ey/q3VMahuNUqAQne4R7Tmd9Zyu6DtoQSnDiCFcIggrr2e3CFVdcMiE+axMKCSB06qRPoKlT9MSuCgBUHBe/wJw/7gLkbzCXUYGBg916nFnjxhg5j0LWaEbulzXyr15YEb5lGRBe2B4NM4ejspd6WRWl0uaETIh/CLst7C9+/jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443260; c=relaxed/simple;
	bh=fOtcCmlhybCj+7AQr2xFz8CmqmsOUn+94FPHpgWSpfs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iY+dANcPEQJ83RyQgIlJhu0iVvcAAFvZUhv/bg/fpHnlJJdRHY+2OFWEPYSM17viFfRAdQDNqnT7dHRJTssyooG/pv9Cx8cD5JUo/I2JEsU4nM0b7X7F1/SCmxC1QYVKnToCIzL08XpsKiVLl5JIimNTK2TiZfhUjx8Xm1TROcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1B61F000E9;
	Thu,  3 Sep 2026 13:47:19 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Rama Krishna <rama.krishna@oss.qualcomm.com>, 
 Rashmi A N <ayiluri.rashmi@oss.qualcomm.com>
In-Reply-To: <20260831-skip_suspend-v1-1-ba2d877e22b1@oss.qualcomm.com>
References: <20260831-skip_suspend-v1-1-ba2d877e22b1@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: qcom: Skip system suspend/resume for
 firmware-managed PCIe
Message-Id: <178844323897.126132.10981127519752342599.b4-ty@b4>
Date: Thu, 03 Sep 2026 15:47:18 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Mon, 31 Aug 2026 19:07:02 +0530, Mrinmay Sarkar wrote:
> For firmware-managed PCIe controllers, all resources, including clocks,
> regulators, resets, PHYs and link state, are owned and managed by
> firmware. The host driver must not attempt to manage these resources
> during system suspend or resume.
> 
> Skip the suspend and resume operations for firmware-managed controllers.
> The associated power domain transitions are handled independently by the
> genpd framework through its own system suspend/resume callbacks, so no
> explicit action is required by the PCIe driver.
> 
> [...]

Applied, thanks!

[1/1] PCI: qcom: Skip system suspend/resume for firmware-managed PCIe
      commit: 89d17a6331087a76aea1a3a6c03dc45a19d306f2

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


