Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F881C5D57;
	Thu, 26 Feb 2026 12:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772107625; cv=none; b=soCv7YfORQZTCmroY/HKkCPcXbDc+by7s/Mucv5P2Gbwb4cMBvVJ4wa7d0lCCF30eAml76Ni7DgZZuc6kv+MHC5gvy5l6a34Hmw7oNWoyYDZ/SmtQbsQKFuMxp+/uaNFyLRfLiBDlsv5GrVtoXR3Msu2KVvYc+XzqOoT6kpkYLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772107625; c=relaxed/simple;
	bh=NvaYmWmPw9TAYgQzAiJzQLK+RAHS9O3xu7w8WLHGVRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFRwLOmsK+XkRpPvIOuGUPVZrH7QXODWQao8xYPa3pTiAeyxbEVGUB//gyvfB8q+eVMGxftLn/ofS0dmU8KDPOBKab4/Abb4GNG9V9WGdUcnMGSEV9Fr7A+dvPamUy/46Yfoh1sPGFlQmp0VP+u7lp6/Rbu3kTZvcOSF53SMpcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2BzMFvB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2BzMFvB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78142C116C6;
	Thu, 26 Feb 2026 12:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772107624;
	bh=NvaYmWmPw9TAYgQzAiJzQLK+RAHS9O3xu7w8WLHGVRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a2BzMFvBcZePIpUeBoVmsEcTdQuoGLhg3eMYxEqqbbH/BAV8ScM+j0up4zRBRiK4H
	 ANmYS9NlwhW4nrY8Ogce7WuOeU1m1rVpYFscAO9XBsnz1QJbcOwNDCzWdQT1E2mk7V
	 bVhUqw17Y1tLWhT7gC2FMzmrKiV6u5/s5rHgGQHqy87IcmFEABcXwtlgmQKAAozO4U
	 Z/crJJ+qUSQuJhIdQjIHj3pv6yb7qXzBEvoUcg6gHUAWw/9Je1/7EEV47T/uxaboP0
	 3D4fTA6zziA2UZKNrwqrsIQ6K3TtxELO+knokt0Pv9rDkCsR16muPRk+8pPYW6UZf/
	 +y3moALOiaeSg==
Date: Thu, 26 Feb 2026 13:06:58 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Hans Zhang <18255117159@163.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	Grimmauld <grimmauld@grimmauld.de>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
Message-ID: <aaA3YuIOK_Q0MPi-@ryzen>
References: <20260226101032.1042-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226101032.1042-1-linux.amoon@gmail.com>

On Thu, Feb 26, 2026 at 03:40:23PM +0530, Anand Moon wrote:
> Rockchip DWC PCIe driver currently performs synchronous link training for
> combo PHYs (PCIe 3.0/2.0 and SATA 3.0) during boot. This process waits for
> the link to be fully established, adding several milliseconds to the boot
> sequence. To optimize boot time, this change enables asynchronous probing,
> allowing link establishment to proceed in the background while the kernel
> continues probing other devices.
> 
> Cc: Grimmauld <grimmauld@grimmauld.de>
> Cc: Niklas Cassel <cassel@kernel.org>
> Tested-by: Grimmauld <grimmauld@grimmauld.de>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
