Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA031427FB2;
	Thu, 17 Sep 2026 06:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789624820; cv=none; b=phk9AScLrnpQW7vw8wVxkq4ENE1BtiVwsDZupVh0AXXhZELjGsmhJIbWESTBeLtvURhWo+g2noRMVLbOLinbCqUfHhDbieUO/8wl9B9Jo5WM/8zwvTknrYOSB57xwY53oU36rtqtfsg3+roiBLDF/6AswGreYpa0zUCz7R9sSuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789624820; c=relaxed/simple;
	bh=na1/K5yqDdUslhebnj+S5JyeusZ+K4oPgKDft3hxQdM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eSFQi85iR/mZVCq1sOHNothGRR/jg5Z978WnflDQvKnuzf+cLGz1OTooRX3nt8UNNjpnOfyuTZzz/45WlzspildFGHf3WWNsv0YZIryEyVqWHLVW9W7H4ktD2dn6uPLhbNfG6gG5mxyMMHgc23BFS8oK4bk+q5WXV/xL/3U0wD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sua14KMW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sua14KMW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4C61F000FF;
	Thu, 17 Sep 2026 06:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789624818;
	bh=jy0QoLwovc0ip2NtOJhA20L7kP73o0+1mZlDXQRNpkU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Sua14KMWlmLmWZ0OkY2nk9rmcsY5bLahkAhEn6xrSpeaHEcxlfJ06vejBZwWgk3SX
	 AL/XBHC7fYgu/YxmYiB9UCMwSeMTvFe+Wn7/qUzjDE/Xguwgl3VsFL3XNhSdk1x3+I
	 q5MUZ3DIhQvYOUKsVZSRGt+zsXtqk/wClImiT7Dkrne0GkukzxclpARGWkPtshfdDg
	 SwF0S81fxpZdvmpdfHV0M2UhjbJxUJ4rZbQkxOerudKx+DVAFWqRUNgpwQTGYlTv8h
	 3w5Y0xxwwUEsblUP1SV4h3OXPg3i5X85xJqEd6GOz+aw76fAkFGUciSOk1mIYvGoqg
	 9DpD3tC+VDLXQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
 bhelgaas@google.com, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Loic Poulain <loic.poulain@oss.qualcomm.com>
In-Reply-To: <20260907143349.317495-1-mani@kernel.org>
References: <20260907143349.317495-1-mani@kernel.org>
Subject: Re: [PATCH] PCI: qcom: Honor IOMMU provider's #iommu-cells in
 qcom_pcie_config_sid_1_9_0()
Message-Id: <178962481504.121882.7536410500314384433.b4-ty@b4>
Date: Thu, 17 Sep 2026 08:00:15 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Mon, 07 Sep 2026 16:33:49 +0200, Manivannan Sadhasivam wrote:
> qcom_pcie_config_sid_1_9_0() reads the "iommu-map" property as an array
> of fixed four-word {rid-base, phandle, sid, rid-len} entries to program
> the BDF to SID translation table. But that layout only holds for an
> IOMMU with '#iommu-cells = <1>'. The PCIe SMMUs on these SoCs use
> '#iommu-cells = <2>' (SID and mask), so per the pci-iommu binding each
> entry is really five cells long.
> 
> [...]

Applied, thanks!

[1/1] PCI: qcom: Honor IOMMU provider's #iommu-cells in qcom_pcie_config_sid_1_9_0()
      commit: 626acf6efc69c666ffee50bf18e7b95e68670c6a

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


