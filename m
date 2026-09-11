Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF2B37475B;
	Fri, 11 Sep 2026 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114602; cv=none; b=H0slKNgAFtf6TB7AUsfrO2gBu4vO6ipg5d/G3VNj9qCT0vflGib/nyj2c31ZlSkr488CWD70fYz4GIBazuo7Q6ZHpyBtopyNrqrmQ9vULNcUevSPoxf+WZF8epe6Kr86OodopTrcuWJu/YTJ3W37C/7BBglIZmdh8f1RjVrn7XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114602; c=relaxed/simple;
	bh=aZ1+2Eh5haz+cfMOf8ik6GbVtPCnrVLbTojRg1U1mWk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uYVQbotmS5PNgAi8kkKhIxG/P60ScfYWGt6+/oqnt/whRQqEnVK0d9YlI18E81KGCAydI8qemcWWEPkYdLH0ukDZ++LQPA9JnWrH2hPy+8uCVp12l1KVxLNK5Wr8EqJ6U/YnWzt0uELktpO5rht+Y5oR7iBuP4WBCBKoaCY2bjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB871F000FF;
	Fri, 11 Sep 2026 08:16:35 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>
Cc: Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 Chris Paterson <Chris.Paterson2@renesas.com>, 
 Biju Das <biju.das@bp.renesas.com>, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260903133320.144245-1-biju.das.jz@bp.renesas.com>
References: <20260903133320.144245-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 0/2] Add RZ/G3L PCIe support
Message-Id: <178911459580.22755.7730662955791225724.b4-ty@b4>
Date: Fri, 11 Sep 2026 10:16:35 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Thu, 03 Sep 2026 14:33:09 +0100, Biju Das wrote:
> The RZ/G3L PCIe controller is similar to RZ/G3S but has
> some key differences:
>      - Has 3 clocks compared to 2 on other SoCs.
>      - Has a different set of reset signals
> Add support for RZ/G3L PCIe.
> 
> Patch 2 apply on top of [1] and [2]
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document RZ/G3L SoC
      commit: 55f914fdc951fe86a4845dedaf7ffe8e9ff66574
[2/2] PCI: rzg3s-host: Add support for RZ/G3L SoC
      commit: c56d39e0f68d49ee45e610714bcfc87e14208498

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


