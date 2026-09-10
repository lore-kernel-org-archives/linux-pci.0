Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC33F428475;
	Thu, 10 Sep 2026 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027842; cv=none; b=KzAK09I1zzU2oqriD/DSgBYSIEAEU60uvnNjKmPuF38swdP2Lczk87RfvXJopgQW7rDv9biUDF7U3OQWiLwFqESd2m6rKWDtfbNLLvTxZhXWuKeAWxR66yHp0eQkMQaNW9kfNn6vWvpekr9LE1MjJO5c7wVcEhenTSdHBz1yUMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027842; c=relaxed/simple;
	bh=quxWlUrkcbLxr4TZCxfWvcObU+F4faMv1oH+IwgTIvw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MBcteOV6I+kelcfKKPx5juIuGt4/InGj3HIGIyPFbVbSoxlIh5cMIUbn8hhtQi9fcl83P6M+Wte1eypwAXSaw+7NFgAY5J8YSz9d4qO4tcmgetYQfSkwYD79RuQJsdnCIUmSdja+//Iuqoqodl9DS6HwcVT4vTvG758APt7/VFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3701F000FF;
	Thu, 10 Sep 2026 08:10:37 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: ryder.lee@mediatek.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
 mani@kernel.org, bhelgaas@google.com, 
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Cc: robh@kernel.org, matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, linux-pci@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260728122810.3475-1-sreekuttan2156239@gmail.com>
References: <20260728122810.3475-1-sreekuttan2156239@gmail.com>
Subject: Re: [PATCH v3] PCI: mediatek-gen3: Fix 64-bit type truncation in
 mtk_pcie_set_trans_table()
Message-Id: <178902783731.2684.801323745956768589.b4-ty@b4>
Date: Thu, 10 Sep 2026 10:10:37 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Tue, 28 Jul 2026 12:28:10 +0000, Sreeraj S Kurup wrote:
> The variables cpu_addr, pci_addr, and remaining in
> mtk_pcie_set_trans_table() are of type resource_size_t, which is 64-bit
> on 64-bit architectures.
> 
> Using 32-bit helpers fls(), ffs(), and BIT() causes 64-bit integer
> truncation when computing window sizes and address alignments above 4GB.
> 
> [...]

Applied, thanks!

[1/1] PCI: mediatek-gen3: Fix 64-bit type truncation in mtk_pcie_set_trans_table()
      commit: 13335fca4c23b1a6736ec9c7efc3750154a2ca24

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


