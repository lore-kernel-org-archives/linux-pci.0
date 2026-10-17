Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21364503B
	for <linux-pci@vger.kernel.org>; Sat, 17 Oct 2026 05:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792213516; cv=none; b=JrY6FkPLC2GgczuZUpO7Y9ae6jEmUF5ng/a/sVebmi+GNPhj1bJRIhoHuKS5hfMOGl3CQcKn/ovK1KUVuLP5q1tK1FvNeHLuO+zhA7et1UNOBqjj6tmiPBw8zT/iGprsI5c/XQaKRNizZqL298PslORLbjRt8eoRc+iG7WMS3fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792213516; c=relaxed/simple;
	bh=A/wsIXdnF5hAoLYTK9PXO/xkmhm+NVdxHMfZOrfD/no=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o1eNEmP3hU+hh6nlrs4T6Wc/d/zkiQjkQuNbhrrHpPN6+0F+XNsKwDwWmuxLRFHSVqTtjT3cXQ/mPk0rgCZ051wCSFwfDPr53UyRTfzOoj2/vaTFKbdVPCNRB3kDvo83qtj1kVN6Y9ViIEyh8WAIscKpF5jonqm2Qi4LHNn8KQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Epw9VXQU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Epw9VXQU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B79E1F000C4;
	Sat, 17 Oct 2026 05:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792213515;
	bh=fMkiOqz7yOVvd/FGiSqbAkWsz/PHKXvYjF0u+jq5oRU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Epw9VXQUdMadAZaVVFGLO8ZX+edV5AVn4UTt2VEmUMPjMIQXY+X7Oy7cPDE+yBJgd
	 uZuLjstbUJtCaet4oXSs6GBINznwHHhsuPFb2RwEYk18cj31E8qtwoZ58sIuIigBF9
	 UwO4f84QgahR2zpe6v2g67gpMyGrz0PcZqM+Est3qkDH0LsayFNb3utLe7fCM8fdfs
	 HzOQCws0YRt4Adh/eUoOdfXKFUAMvgmCwtcK1Mwj1Qxb4HzW10r+IzmZ400vt4H9Rr
	 3pvDm5nErM5vseBC4Oz8KnBcwiWg+e19rMb3VTF4zybCNsQevpgAj5F+jMBDyRurcS
	 VzAUWx3ekWa8w==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <1790734930-217000-1-git-send-email-shawn.lin@rock-chips.com>
References: <1790734930-217000-1-git-send-email-shawn.lin@rock-chips.com>
Subject: Re: [PATCH 0/2] PCI: dwc: Make the MSI domain naming explicit
Message-Id: <179221350012.2165.13239090578589363213.b4-ty@b4>
Date: Sat, 17 Oct 2026 10:35:00 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=812;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZutYSKINpC4dBsNX1VDGCS6WiFGxHD/UIq4TmEapULU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq0wIIyYh16Kv1JCjhStl/xEEFUmKn1G7IeB2bQ
 1FdZ7h0RKuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCatMCCAAKCRBVnxHm/pHO
 9XptCACAgvK7VNHbwad4x7zwWm4tfLOfJmOtixBN+w3n4PhUcTDNiufdG5uqhGSjelMWfhqwuXu
 0jzwwar1t2jUBOmZG7w/eBXczG3CHnrSbX4qrWH8N91doTXobcBphXzCeIEzdkR71Wgv3Skfj4A
 3dBNBBumFb8PVfdvcPZJB2GGdYNa2g+fcNYrrOR6O7r/4UYn+yjLAJgKPB9jfnfJDyhGKbuW8sk
 HHewxu14qg0HH8DRwBpudEWoEWsToH2add4NyyhMgr6417Rf9MJY7x4R168DaxS2kAy8EDbrflM
 cHf4ttlZwrzwZGbi1kmQeNvbsfJa++s9c17qSAtWYe7saVDd
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Wed, 30 Sep 2026 10:22:08 +0800, Shawn Lin wrote:
> PCI: dwc: Make the MSI domain naming explicit
> 
> I was looking into whether the DWC core provides a common INTx irq
> domain registration and handling flow, as several glue drivers owning
> a legacy interrupt controller copy-paste the same code (get the
> "legacy-interrupt-controller" child node, create a linear domain with
> a one-line .map callback, install a chained handler).
> 
> [...]

Applied, thanks!

[1/2] PCI: dwc: Rename dw_pcie_allocate_domains to dw_pcie_allocate_msi_domains
      commit: e078e64169b1da85c057092e2b2c673b21e08647
[2/2] PCI: dwc: Rename pp->irq_domain to pp->msi_irq_domain
      commit: 315ba6800480eb49fa0c37085c808fc6f2f9dcd6

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


