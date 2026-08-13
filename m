Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD73388880;
	Thu, 13 Aug 2026 05:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786598526; cv=none; b=AnqbI6rN/9Izh9uqBKHkYFtcap2GYzJJVebcDC20T4J1VCebkSzWtz5bHiDdgeIx+6uJE5khy1eHZfrkTctZYpSwvQasEdkgST2k6PVdf8IAkyfLB72C9SoTMJ+jw2Bbswh092DvgA0m79x6ABoxmRB1R7YK84H7gc4YoldaalY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786598526; c=relaxed/simple;
	bh=vNkIQJmIOgAn2Tp1XM31BwFPcnmlpDy+Fi4/g+OjiBk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HW2QlMKUYqPerzZBLEPoNrK4Q0nW87l9nbr+1f3w9fclSuvr33Aj4mAa9RZlGq50U0OfAq8WbQrSEYlAXfpRNbGx1wiUGKGjfeOGF9xMqdbi4rE+W5pmN0fRmYRPoUVr2wo2xdOTb83loUgsDOQaCtqc6N3uOi18h4wLBtkbNOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD61B1F000E9;
	Thu, 13 Aug 2026 05:21:54 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20260806165334.7328-1-ansuelsmth@gmail.com>
References: <20260806165334.7328-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH v5 0/2] PCI: mediatek-gen3: Add 2-lanes mode support +
 clock
Message-Id: <178659851441.407130.13996130568120882339.b4-ty@b4>
Date: Thu, 13 Aug 2026 07:21:54 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Thu, 06 Aug 2026 18:53:30 +0200, Christian Marangi wrote:
> This small series introduce support for 2-lanes mode for Airoha AN7581
> SoC. This is needed for correctly functionality of Eagle WiFi Card
> normally attached to this SoC that require a 2-line PCIe card to
> correctly work (and give the proper performance)
> 
> The first 2 patch address a limitation of the PCIe implementation
> where the PERSTOUT reset were indirectly asserted and deasserted
> all at the same time (for all the 3 PCIe card) with PCIe
> enable and disable.
> The 2 patch address this and introduce correct reset to control
> reset line for the relevant PCIe line.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: PCI: mediatek-gen3: Split Airoha schema and document 2-lanes
      commit: c48c637255625f23bbeabbe63dc2d6a4b70c680a
[2/2] PCI: mediatek-gen3: Add 2-lanes mode support for Airoha AN7581
      commit: 8d076be9a10c68f7fac5d6a180bff19053b91dca

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


