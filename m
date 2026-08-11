Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A79D3B8945;
	Tue, 11 Aug 2026 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465108; cv=none; b=FhdrZbLzoH6KA9MriZgt497NMBtcszm6Co59OWAGW4JM6QiO+OTpCdqI4QCyFlYR+0T54KHjqMlAb8pMQqqZ1QnqsLtHsr0cINourcN8wzq7Lu301rhpYG7UVESxYcXkjS3Bzr8etPPfCQUY6DXPcXrwpcg5PlhanhzFqX1Z6VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465108; c=relaxed/simple;
	bh=rB87TlUdMVoGhKmjFoI8OYxLXZXd5sWEzNLokLIGMWs=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pyJ57qwomURJxMKTbHgUldCEq7AW6qTLRIlEC47Z/SswfbKVuF6D3Voy7wai7HwlebY/+ICelKspRQBUURkgeGTX8Z9rkBZjyXin8GX5f+q7+I3wWkt9lSesE6nBNWtuxSIyM4/3rlYP8ZnYS+k32QX5XjKbnPqdEV7yOaOhF/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDB21F000E9;
	Tue, 11 Aug 2026 16:18:19 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Jim Quinlan <jim2101024@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-pci@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260801195517.235161-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260801195517.235161-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] dt-bindings: PCI: Correct white-space style
Message-Id: <178646509977.341711.3716669174459184382.b4-ty@b4>
Date: Tue, 11 Aug 2026 18:18:19 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Sat, 01 Aug 2026 21:55:18 +0200, Krzysztof Kozlowski wrote:
> Correct a few white-space issues, like double space after '=' or before
> bracket '{' characters, which will be flagged by dt-check-style.  No
> functional changes.

Applied, thanks!

[1/1] dt-bindings: PCI: Correct white-space style
      commit: f7b2ceb411479b4c95aee1c0dd720af53367ff8b

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


