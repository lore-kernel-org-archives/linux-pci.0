Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A2542C4FF;
	Wed, 29 Jul 2026 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343422; cv=none; b=TUArGcwGjwho6OAADC0ASunvdV8tcSftxzwDqQkbcyf58svajivo/FWtyJg2ZvfRVh99s7aCifB2W4g7Zuz7ZU00XTRmlT7FQ4BgFdndfhHdoO4L/zfM2+Jz7hWngOm9txRmvggMDTBvEYayRNuCUHgUQp2heRuDm38HMWVRvMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343422; c=relaxed/simple;
	bh=SSCtxAozcydbsiQzx6xoqZTXIauqcbVSM0+FgC59xGY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=X5Gjw1BpwB1zzidMdRYhg5buIPx9L4/An5ywpqSgv16j2Qfy7xoDhwE5ZEpDXb7X7MS/VPPuN3NqKS7/l3Y6NAFmTZODjUok1QtNPsunPRMgi6sScpxtf9ezGAgst5d+nOeSN2jQ1iAbpDegy87zr91Lbbw0wmHRVb93O7NVF7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD551F000E9;
	Wed, 29 Jul 2026 16:43:38 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Kevin Xie <kevin.xie@starfivetech.com>, 
 Ali Tariq <alitariq45892@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Mayank Rana <quic_mrana@quicinc.com>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260718153352.661930-1-alitariq45892@gmail.com>
References: <20260718153352.661930-1-alitariq45892@gmail.com>
Subject: Re: [PATCH v2] PCI: starfive: Fix unchecked pm_runtime_get_sync()
 in probe
Message-Id: <178534341803.895624.4395284068749198386.b4-ty@b4>
Date: Wed, 29 Jul 2026 18:43:38 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Sat, 18 Jul 2026 20:33:51 +0500, Ali Tariq wrote:
> pm_runtime_get_sync() is called in starfive_pcie_probe() without
> checking its return value. If runtime resume fails, the driver
> proceeds to configure PCIe hardware through regmap_update_bits(),
> enable clocks and resets, and power on the PHY, even though the
> device may not actually be powered.
> 
> pm_runtime_get_sync() also increments the usage counter even when
> resume fails, which would leave the counter unbalanced if this
> error path were later handled without additional cleanup.
> 
> [...]

Applied, thanks!

[1/1] PCI: starfive: Fix unchecked pm_runtime_get_sync() in probe
      commit: aaae917990623a6ca6b638557056606a1ae4a8d6

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


