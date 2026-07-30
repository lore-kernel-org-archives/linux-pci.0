Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AE33914E1
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785430238; cv=none; b=JNgk32AKXGLVRCS748Dja7xqQ/j2dBkN4Ud5C4cjpiwXTH5Z2XT7W/G0IOKYVzQ5ZsJOnf9aO/fOPQwW5bLBVpgGskx1uS8XBWVv/2zM4yfxVqwvrn5U0+JO9fCXyMX17kVZ45lCL2KX81LylA8aWa21U9CpOi4jJTPOlEiX8kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785430238; c=relaxed/simple;
	bh=tSTsuNxXEklpVWUGWAQ4cfxoIkJqbmcxwzzzH8ryCSg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K2tE9qoqE3+ex67RxXFvguvcpGt3YVX2R4tej5k2xF+2i1fr1YQeQqisEGs+b5HWM5kn4J3U1m0/hsruiYgfdX36xFpAX4aq5R++FpBbEXz6z0ffkmbRjCqUqTaHdFzgUo7WeGGGbrOSRDdRY5UJ+93PuBLDCEm6o7X7hE35lWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98E41F000E9;
	Thu, 30 Jul 2026 16:50:33 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20260727172654.605988-4-cassel@kernel.org>
References: <20260727172654.605988-4-cassel@kernel.org>
Subject: Re: [PATCH 1/1] PCI: dw-rockchip: Add support to reset Root Port
 upon link down event
Message-Id: <178543023346.1027311.7750630092829191758.b4-ty@b4>
Date: Thu, 30 Jul 2026 18:50:33 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Mon, 27 Jul 2026 19:26:56 +0200, Niklas Cassel wrote:
> The PCIe link may go down in cases like firmware crashes or unstable
> connections. When this occurs, the PCIe Root Port must be reset to restore
> the functionality. However, the current driver lacks link down handling,
> forcing users to reboot the system to recover.
> 
> This patch implements the `reset_root_port` callback for link down handling
> for Rockchip DWC PCIe host controller. In which, the RC is reset,
> reconfigured and link training initiated to recover from the link down
> event.
> 
> [...]

Applied, thanks!

[1/1] PCI: dw-rockchip: Add support to reset Root Port upon link down event
      commit: 9225afa7a8637df41b8e4705ea7e7e890ce78084

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


