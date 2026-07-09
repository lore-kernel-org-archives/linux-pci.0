Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859FE1BC2A;
	Thu,  9 Jul 2026 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601874; cv=none; b=BZimwMkde6jWLAVoD4o57fzefW5BEwSc9pmdGvBR5oaL70KH2/SA4MqPeAaTDPoPb8B3HTCg75Q2ytBoCint7pXX0m1qQKRBOO3m8C7iUftHnaetvs9mzXTSplKNoSMWaBroUOVjHzfi1xEj56yLz9zKLsuZtc1vAKbWXOQyqcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601874; c=relaxed/simple;
	bh=F0oER7IoyDrtmtsUIKkpcAiKcgas2RA3SVo8D5bwGK0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=adL13CQkisLNGpYozatpvGo3g55jR3pXAj3IXSPIXz3KLQ2oEbT0LfIF6hjahoRnrvzIrm9Em7zo4Zk2vECWZll52mDCtIPP0pYuT0JePbmY57b/GC0+i2oy21r6tJQXLYMWbtk4ns5U6BynKn08OTjgr3wrkarWAMqCfGrjv7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbUXba24; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbUXba24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8821F000E9;
	Thu,  9 Jul 2026 12:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601873;
	bh=6DQgYYb1ZjZuVQhAXZ9Dw/wcVAeEIHHr3UiudwMdPGk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DbUXba24IANCw5itvm9+nGmYdLx9BDhyRI/sKjsmf/gDasQUJooWjWCVeo/JahFTO
	 Um5lOTXnY0vxU8XdKkvqeQkTodddTGnHSuVQ4FqPKOnmgAw3PK8o6dTHM5t4lrOIaM
	 nJDQ5c4CG27BsXc3cMgokIWbo27OjAZiHc+MzDBP/CHooI+hC4xNo34Vt0Pwz+ljBC
	 osSaHNrpzwdNi1hwWHcFAvb6xm0NDUhXL7M/fae6icEksWzCu1i+jkn0YRFQWc7Dzm
	 N9c9sHC/V6jAO0YBn7b5JoZByz9+p3QfxOc3sWkMKRvEI6rmhvZIq6/52wk6Zbjw4l
	 sgz13zoTARMQQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org
In-Reply-To: <20260707203743.88299-1-marek.vasut+renesas@mailbox.org>
References: <20260707203743.88299-1-marek.vasut+renesas@mailbox.org>
Subject: Re: (subset) [PATCH v4 0/5] PCI: rcar-gen4: irqchip/gic-v3: Handle
 GIC ITS
Message-Id: <178360186732.755595.3582150626313807959.b4-ty@b4>
Date: Thu, 09 Jul 2026 14:57:47 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Tue, 07 Jul 2026 22:35:38 +0200, Marek Vasut wrote:
> Configure all R-Car Gen4 PCIe controller MSI registers fully, both in
> case MSI are enabled and disabled.
> 
> Patch GIC ITS driver and add quirks for R-Car Gen4 GIC ITS, which is
> configured to 32-bit address width for AXI or APB interface.
> 
> Switch R-Car V4H to use GIC ITS in its DT and describe the GIC ITS
> implementation cacheable and shareable limitations.
> 
> [...]

Applied, thanks!

[3/5] irqchip/gic-v3: Refactor GIC600 limited to 32bit PA erratum handling
      commit: 96b193897fd374fcb63a782c52f8b079134d0222
[4/5] irqchip/gic-v3: Add Renesas R-Car Gen4 erratum workaround
      commit: 14e8394423ffd4fd28884ec8b4d5ba15be6e7e0d

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


