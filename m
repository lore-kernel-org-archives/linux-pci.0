Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A1254A7C5;
	Tue, 22 Sep 2026 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790086872; cv=none; b=Ndg/a73ik9zCEs+lfLZug6KYLO0oc1GN57WtHFFG9O7PQqRjHJH4mZpODdgb9cuWLLD+TLHCDhdfIjzBoGXeqkpeKt8LJvqt1OMtKzXO/RKnTL7ie3phoEUSuh/dfIvUz+HlRSmAk/0oHeRMxY2nsSsOghlMGkMrgswpFTTPpAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790086872; c=relaxed/simple;
	bh=lm0b8arJr3U/C35gumC0QuLjh3bHoL/gLPcFf9UQRAs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IlvWQt1+Zbk5uObOpQi3VKbqaQjk2tsfmJBOTsAn/DZbCgbctQ+RM1PQxMQ3SK/RmhvH3YTM3zfc9L69dmBQQopkkdcp1oe98llx6NnqnHUz+QH/TotmdQubXIWQpvkeb3L8iNkphwHUfeX8ZPX8E2nOs/1ZF7xhW6RP/PwiUUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfh+n3FK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfh+n3FK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CADC1F000FF;
	Tue, 22 Sep 2026 14:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790086871;
	bh=WbXEkPbd96PFMsC5IPy02gg3t0HDAYUBkTAyykgN0ns=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=jfh+n3FKHzmnQZnQumFfvm3l0WrXmlVZ5nkjwRjM9s2mblULrrDaFHaKvsbGeCUeT
	 Ja+iPSlQRbh3eV8GEjQjXawVIKi06qZ6no/oCeElwzqMw4j8rPUi18fh1nYW3HBFkj
	 sz1oLjjF4DytriUUdTAG5Bp7c1AJOfUFDJV08uGv5OD0VEf6Ig2o4kRZcnhoLqZoGJ
	 Rqye7ruytn7rFzPtTHUaTmR1TQrXu/Hc1p1dF9x6Pj2GSoSqj+mnxfBBrl4eSuYmLo
	 2H1298oDwe6RLQJTzFK3caOcF4GPBTTgqAmPKGVTt4eoZOfoOqBNLhIIdcHqfmh5Fi
	 VRJQpjzcCR3GA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org
In-Reply-To: <20260921202823.72620-1-marek.vasut+renesas@mailbox.org>
References: <20260921202823.72620-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v5 0/6] PCI: dwc: rcar-gen4: Add support for R-Car X5H
 PCIe4
Message-Id: <179008686672.45568.9383539899485486007.b4-ty@b4>
Date: Tue, 22 Sep 2026 16:21:06 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Mon, 21 Sep 2026 22:27:42 +0200, Marek Vasut wrote:
> Add support for R8A78000 (R-Car X5H) PCIe4.
> 
> This driver previously supported R-Car Gen4 S4/V4H/V4M. PCIe features
> of R-Car X5H PCIe4 are almost all the same, except for different PHY
> which has its own driver, slightly different initialization code and
> the DMA is no longer eDMA but HDMA.
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car X5H PCIe4 compatible
      commit: 5b555a496160914394c330748fc95e46a1d71800
[2/6] PCI: dwc: rcar-gen4: Rework rcar_gen4_pcie_drvdata .additional_common_init into .init
      commit: 0bc55fc989ea7933672004416ebf5b92e4e1fa5b
[3/6] PCI: dwc: rcar-gen4: Add .deinit callback
      commit: 038c1e5dea1d38227ffbd4fa27a1e544d0c3d1ef
[4/6] PCI: dwc: rcar-gen4: Split .start_link into ltssm_control and speed_control
      commit: 0505c5214a59a0e970000ef1613572a46e601ebe
[5/6] PCI: dwc: rcar-gen4: Handle PERST via reset subsystem
      commit: 66b25d01f59250dd96dc8789bdbdfa77cfdf668b
[6/6] PCI: dwc: rcar-gen4: Add support for R-Car X5H PCIe4
      commit: c02d41758316b324cf938c452cf51afe85fd0c90

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


