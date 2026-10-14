Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362462931FB;
	Wed, 14 Oct 2026 05:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791955588; cv=none; b=HkGVjXxvTD+A0E9CAdn1UtFucFlrGyfb+f1xS7EZHSyGsBjIgbiz3Q2vA0W2iAxtuH3/3tTnITAEp4yaB5s4ztQ3JtEB7aR3Jn2/t8eVRnU91gj++wwSq31HBTdVA+R2p03I7HMnLskoa6mSHjh1xRWiZkMbLiwdfohczVdCtPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791955588; c=relaxed/simple;
	bh=c9AfFGNB8s4Z+HCmtKtYnibMoMxE9O4VvebdZYpYcps=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mhwA9V/7Xx0vVdH329wt9WBsCn58DPps1ugjfBGPWUh9124zRjWbRKD8qLRFyR3Q8Rh6ootgrIpNE3K0aow6+BGqnxPec1FG3aDI4LG2hlseNV3pnLuGyl67DJ8N0DYYfI/A04bUsY7M5YeBTO6ed+B3XukJCd/nxU5m9kWLgfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJuBiAEZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJuBiAEZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFF91F000FF;
	Wed, 14 Oct 2026 05:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791955586;
	bh=RKYhMjcdquQctXovoCvyjlBSW58IakiaspYG2NbsggE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TJuBiAEZRVGFKBEI+g+qdhcounkDdDDtV7vjYsd22pxHCLXIuDNV46SZ/ganIUoxM
	 I/ovGv+xxuWHfFX+aDErwdbmu1qOnp/QSgRbs7m2ympbASIM6/RSQFwaz+61JQB1ie
	 7E34R0iYHa+YTpdKWjZlKaaqjMr7RHuthMm7lqyBCG8vGI2F9RzHw7mxvNdi9qE0cB
	 0s8AZA3y12XnDxXpOpvhFKOlW1yoQAEFi4WwDWoJO3rFS0wSEOZ8iwkWpV58LZwZMM
	 0BoMgi6Xdg2OfMB0JIJ75kbOY3yK7yVSTZwkSM0+gXBCiZboEYh0AXeg5aWozI4Eq6
	 Gh/AoCNCncuzw==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260619112535.1127850-1-alexander.stein@ew.tq-group.com>
References: <20260619112535.1127850-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH 1/1] PCI: imx6: Use dev_err_probe
Message-Id: <179195558138.34437.14421683189304797818.b4-ty@b4>
Date: Wed, 14 Oct 2026 10:56:21 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0


On Fri, 19 Jun 2026 13:25:33 +0200, Alexander Stein wrote:
> pci_pwrctrl_power_on_devices() might return -EPROBE_DEFER resulting in
> an error message. Use dev_err_probe to silence this non-error message.

Applied, thanks!

[1/1] PCI: imx6: Use dev_err_probe
      commit: 2aed243fe21ec77c5682aa8ee6a5912d94b3a4ff

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


