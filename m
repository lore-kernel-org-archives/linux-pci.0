Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8AB48A2D4;
	Wed, 21 Jan 2026 13:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001743; cv=none; b=M7ol5rAtFLQYIvbd2mW41Bdih68PavOaRI7a7zIjd83PHp2QeSrU/81j6hvHawLrKHXSG61wbt0uS2Gg1LafhVVZvWjSGs+CL1r3r3evAZeYGfoXVwy2mujJw9M2F94bDdnHmmuLjGbS8ejCiOxBkCGU451MHutixjBTyZAlCnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001743; c=relaxed/simple;
	bh=Un9wOgMG/Zbi1KG3E5xTS1pHOurZnitKkvLwZoIuPiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZHgNb2Mofj51FK7LL7d5EpFHJlgpmHn2xXOjo5SMaF4ki1ltNlv6+n1kZZkLioSbA3FMOM5EHou9JIpOSkEJg2fQzGveSj2tGK8dv/FHfAJIEf3G4Eqoeq1to7pl28EkVFlkpO89hpWhCaUjZBPzt2TCehqqnGjqSlO6FSipqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCJiz75c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCJiz75c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC671C116D0;
	Wed, 21 Jan 2026 13:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769001742;
	bh=Un9wOgMG/Zbi1KG3E5xTS1pHOurZnitKkvLwZoIuPiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OCJiz75clgBdIvHpHxOlyNnk2IRAHPQovqsd1w67xDXOqSPYGVTZwDU+hfkupuhfV
	 yc27eEK/YifNOT/07P7O7t8d284Rd2Sdvo05DY/BNLcAXins5rWnNTyNbZpswrDSvR
	 KBpC3GuC93qHG/gk3zrzEdek6QBqXEovlQFgL2bP0VHFETtvMmRhVLMx3AlZZuHkUS
	 yP59YIOfXV5qSCbj8FoyCp9p7MILvfYCtRG+xXcd+Y7zkOudD7hC8SgEVwCJGpSulm
	 Z3d1MLT7KVaAmKv/uTIQCu7L9o0BkTcIvjSDTm91hxpq+/tJMCgWQuC5Ijc7KQqZlV
	 O6bsmiA1ndQJw==
Date: Wed, 21 Jan 2026 14:22:17 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com,
	dlemoal@kernel.org, manivannan.sadhasivam@oss.qualcomm.com
Subject: Re: [PATCH v3 0/4] PCI: dwc: Rework the error handling of
 dw_pcie_wait_for_link() API
Message-ID: <aXDTCQeP3CDv5qv8@ryzen>
References: <20251230-pci-dwc-suspend-rework-v3-0-40cd485714f5@oss.qualcomm.com>
 <aVezfq-8bTKczYkp@ryzen>
 <b7d7ae6b-d0e7-47f2-ac84-8b0fdb395a59@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7d7ae6b-d0e7-47f2-ac84-8b0fdb395a59@rock-chips.com>

Hello Shawn,

On Wed, Jan 21, 2026 at 08:45:39PM +0800, Shawn Lin wrote:
> 在 2026/01/02 星期五 20:01, Niklas Cassel 写道:
> 
> Hi Niklas,
> 
> Sorry for chiming in on this so late. There is a register called
> PCIE_CLIENT_GENERAL_DEBUG_CON you may find on RK3588 TRM, you could
> hold LTSSM on EP side in DETECT_QUIET before enabling trainning, by
> setting BIT(6). And when EP side is ready to go, just clear BIT(6),
> so the link is able to be established and host side can rescan to
> find the EP properly.

Thank you for the suggestion.

Reading the register description of this debug control register.
For as log as sd_hold_ltssm is set, the controller stays in the
current LTSSM.

We could probably set this on the EP side, and only when starting
the link do we clear this bit.

However, I think that Mani's current proposal:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc&id=01d16b8afb7afcc17f999f8b4a9b9cfe6c6fae71


Will work with more controllers running in EP mode, not just rk3588.

Also, when powering on both boards at the same time, it is possible that
the host side driver gets probed before the EP side.
If the EP side driver has not been probed to set bit sd_hold_ltssm,
the host will still see a load connected, but link training will fail,
so it will still jump to Poll.Compliance.

So AFAICT, Mani's proposal:
1) Seems more generic.
2) Seems less racy.


Kind regards,
Niklas
