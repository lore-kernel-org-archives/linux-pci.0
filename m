Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFCA39F16B;
	Thu, 10 Sep 2026 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029224; cv=none; b=guYjq/mZhXdIqAz2u7GciAeBxqxzfjageeK5wuNaUQlJ74K1om1aKmmBd+0dke4qjmGdsLRQa2DXM2XJiw1gM/TQl4XuvtQcAFWFuud3t2b+8ty8rDDM3QAagkPr8qYzBrGqZST3pG1GmRbmmGxcHO8AIyp6gTD61XwiNffYK/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029224; c=relaxed/simple;
	bh=gdYOtIiiM1d64GNCOjYt4zaDuFap+mvzsv8IisPl8eo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PXg6awydZLTOvcBP+KDRazcoVsGCSALbtxqwUD8wVnpO0WdS4CkwMEbiFplMFWkNDKGIKWKbzZzXDcncS7Hmu9b0xPwNTOBOqK4FX4HNxQu2YscYVEhLYhM0ii+dsZisPkID3y2iCORwyols2aop45Oci2OiBmqrc4KWRSrrfz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055781F000FF;
	Thu, 10 Sep 2026 08:33:39 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: toan@os.amperecomputing.com, lpieralisi@kernel.org, 
 kwilczynski@kernel.org, mani@kernel.org, bhelgaas@google.com, 
 Yuho Choi <dbgh9129@gmail.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260802221146.573233-1-dbgh9129@gmail.com>
References: <20260802221146.573233-1-dbgh9129@gmail.com>
Subject: Re: [PATCH v1] PCI: xgene: Use managed clock for PCIe controller
Message-Id: <178902921961.4253.14812402144849584392.b4-ty@b4>
Date: Thu, 10 Sep 2026 10:33:39 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Sun, 02 Aug 2026 18:11:46 -0400, Yuho Choi wrote:
> xgene_pcie_init_port() obtains and enables the controller clock manually.
> When xgene_pcie_setup() or pci_host_probe() fails, probe returns without
> disabling, unpreparing, or releasing the clock. A failed enable also leaves
> the clk_get() reference unreleased.
> 
> Use devm_clk_get_enabled() so the clock is unwound automatically on probe
> failure and device removal.
> 
> [...]

Applied, thanks!

[1/1] PCI: xgene: Use managed clock for PCIe controller
      commit: b9022584ebbae81f7bbe4a61bd1df0d0a95e1a99

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


