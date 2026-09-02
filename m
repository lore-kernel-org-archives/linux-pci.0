Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193EA29D260;
	Wed,  2 Sep 2026 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359486; cv=none; b=M4RlWp5UMf0fAuk+mYSxhTo8g+U243i3pQogOi7BXfgHnP544G/bY4qgqElibcouYFlzj/y4M6eohFTEv5+nb2Zkgxv6YVqVp+gYCoqSWKctEIN4rgCKahcHvRVhDOMl6L+xEbcff+HVEwufNCy732DXqdrWiIONklghtvT8aOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359486; c=relaxed/simple;
	bh=3eawx3LCwdCGNmPGTF3MOpwdYRKpenv4KMSvkMrFndA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=apcmvuf1+okRj5eF4xNK9X5+4Qi+mznN1ziNK+qhTgCsWI1fG2eB17Vkiqamuc7P4xUBByF93dLxMQmktfj/F+LVjlvaz11Pvh0itvXvcar6jHiMn+fLVvrh4bMhOluvJK4T+D4R1YQfpztrGeAgos8pPZN+xT3VMHYHGnmfax0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C4D1F000E9;
	Wed,  2 Sep 2026 14:31:19 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Michal Gorlas <michal.gorlas@9elements.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260827-l1-conditional-imx-v2-1-40b324aa2a94@9elements.com>
References: <20260827-l1-conditional-imx-v2-1-40b324aa2a94@9elements.com>
Subject: Re: [PATCH RESEND v2] PCI: imx6: Enable ASPM L1 only iff CLKREQ#
 is supported
Message-Id: <178835947957.88571.7553170178358028044.b4-ty@b4>
Date: Wed, 02 Sep 2026 16:31:19 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Thu, 27 Aug 2026 18:51:00 +0200, Michal Gorlas wrote:
> Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
> states for devicetree platforms"), ASPM states are force enabled
> on all devicetree platforms. This causes PCI devices on some i.MX SoCs
> (for e.g. i.MX 8M Plus Kontron SMARC eval carrier) to enter L1 even
> though CLKREQ# is not supported (and consequently supports-clkreq is
> not set in pcie controller node of their DT), which causes the device to
> never wake up from L1.
> 
> [...]

Applied, thanks!

[1/1] PCI: imx6: Enable ASPM L1 only iff CLKREQ# is supported
      commit: 94420d27973f567e5c10b631115ea8b9abc0172e

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


