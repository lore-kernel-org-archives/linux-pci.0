Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEF8569F29;
	Tue, 22 Sep 2026 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790095005; cv=none; b=Occ9tEetWBnLH80+WYxUmtItYkYI0CpUy28rOWzijMTnmuskds7cNRkPl9KpeM15cdK81QIXJO2JNMcREotQY1S/6cpY44I4g5SS1JKtkcltYTTnpWoaeEWeVkjfjwwJZFqGh4C4CwCaRKADWK/4hBi9GVYME8ujtUSzKLL1MGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790095005; c=relaxed/simple;
	bh=JHTB8sd6jNyQ9p+FEIjv2G6LlQH34g4QS0KCiAaClPo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Oa7hmOD+sDrCEPG329loP4MnetrbWIovfucQwYmKHuvpPCWWk85zCbeigNa4tAd3sCEiCrpVO0fyy5YP0mHRv1wkUn+8HKk4UkDsbIT+0/Ise4rL6bnT8ACI6U/gm32xsP29SR+9Ump0TPDQ3kN4b2I+jIGeoaFhPwu08On+27Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fw6YGeVH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fw6YGeVH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F9B1F000FF;
	Tue, 22 Sep 2026 16:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790094998;
	bh=B8Z0pD/ma+V7F4Eb4/a1KsfqWZzZZ+OZaCFFfV1XhxM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=fw6YGeVHDr+R7SgoWSTXATTIo3hYzUfkKsXg9gozGxvpBk4fzqwDtW5xZnYvALi+5
	 N7duEStGtOqQUVhgiX8MuNIotF6nGA0Q/56T5fAX+IVHayaO0G7F1qd6FPPCvSVDTN
	 LttD++0jR62WFI5Ch4mugFQ6CylKkGUXDYoU786+XfvsHdod9mMCzaUn4ikL52Kgyr
	 iD/vawBxb6FPf2FyybYsSBmUWTAfdlJxpv1EFfqidT1r1MNQHnKVE96m2ffQd7C+L5
	 p0qKaqdbcJEIYBnYbD+61T5dQPBwSKaKRkG+thtm2FasTkHB3uF4/kFuYx2DK/2TB+
	 ZvDuh+UY5I1QQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Zhijian Han <hanzhijian1991@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, sashiko-bot@kernel.org
In-Reply-To: <20260904012307.3434449-1-hanzhijian1991@gmail.com>
References: <20260904012307.3434449-1-hanzhijian1991@gmail.com>
Subject: Re: [PATCH v7] PCI: imx6: fix resource leaks in probe error paths
Message-Id: <179009499346.50213.9073558313167610848.b4-ty@b4>
Date: Tue, 22 Sep 2026 18:36:33 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Fri, 04 Sep 2026 09:23:07 +0800, Zhijian Han wrote:
> imx_pcie_probe() leaks both pwrctrl devices and power domains on failure:
> 
> - imx_pcie_attach_pd() attaches the "pcie" and "pcie_phy" power domains
>   and adds device links to them, but nothing detaches the domains or
>   removes the links on probe failure or deferral, so they leak.
> 
> - A failure of devm_pm_runtime_set_active_enabled() returns directly
>   without destroying the pwrctrl devices.
> 
> [...]

Applied, thanks!

[1/1] PCI: imx6: fix resource leaks in probe error paths
      commit: 3e7a0a4f2aa5e8392f005d7ea1c8e783e90453cd

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


