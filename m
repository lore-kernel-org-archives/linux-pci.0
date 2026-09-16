Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5900D31E857;
	Wed, 16 Sep 2026 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574107; cv=none; b=k12GVLKfkn2zncZ2pllqAoJho5G3GS+p+GeFa/KgveENG1Boe71Bv0JBdPn1kScfVqAh2r5pMXuRLMIpffUgFY17aN0Ya9ZjjGiTW9/MezAE3DjGM9Y+G+0HvirCyBA4ZHIGoquB9zZUmITPPE7vTQycLR76gLaoXX3wCplIkbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574107; c=relaxed/simple;
	bh=hZKcwcHQRaMXNZrbmQImSW80gQNncSKO0SBUWbS0qsk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HFcQlbnoPX5p5LgRmjRv90DPIw5m2UMEzktuNAjKTc9grgZAESMj8G05Z57E+yQTP/GxpGXsO/GRs1ruiniyPJoMOmroOav2TppJkcZctSUIq7FTKxL68OH6A50hdRJMDKYFMyOR0nPAU7KgRZ3gDsdIcogp3z5c/iqgFcMWyyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDPg6XGj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDPg6XGj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AD11F000FF;
	Wed, 16 Sep 2026 15:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789574106;
	bh=XOZkV6IEsSIEMAuWCGLWEExcMJL19yV/VfUFygYmtfk=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=BDPg6XGjK+eUiOyjuE6n13hfmldAuixZfcYAgCO14yFoqpU0ajI1sH8KOF/bT6/aw
	 gP9HD+js1NZ962rSYp3/gFTA6jabIWDxCMJAJKL2+1RPdJUNdag/YiTvLqwh2Ibqvp
	 zYX1gDq0IyF0GX36MTirWD7KmRwUlo4KAF9XDd6ZUs8pZB+m8Y9mxKZRtjF2UjWEKv
	 +xv60V5vozNPin241bV0mplbr4VTgwmb0GivRcMAibe5nDPMI59NGuB3EHojcQ5t7O
	 rvRtE1duuBf5Hkv5Eipg9XtZcT9qbSapDgt4X6hKAaD/2787lGUunN4Do38ZE4hsOl
	 p5RAIbqNIH8Ag==
Date: Wed, 16 Sep 2026 10:55:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH 0/4] PCI: qcom: Align PHY init sequence with HPG
Message-ID: <20260916155504.GA926264@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915-align_pcie_init_sequence_0916-v1-0-0b2195836f30@oss.qualcomm.com>

On Tue, Sep 15, 2026 at 11:04:20PM -0700, Qiang Yu wrote:
> HPG requires the controller/PHY GDSCs to be powered up and all
> clocks enabled, then the controller's reset and the PHY's reset
> toggled together as one group, with PARF_DEVICE_TYPE set right
> after. This series adds the callbacks needed on both sides to
> realize that sequence: a phy_reset() call the controller makes as
> part of its own reset, and matching phy_ops::init/phy_ops::reset on
> the PHY side.

This observation is not related to this series; it's a question about
PCI host controller initialization ordering in general because it
seems like this is a perennial issue.  Is there anything we can do to
converge on some sort of generic standard or typical ordering across
drivers?

For example, while looking at a patch that changed ordering in a
different driver (not qcom), I asked Gemini for some guidance and it
came up with the following ordering recommendations, which seem
pretty generic:

  - assert downstream PERST# so physical lanes remain quiet while
    setting up the host

  - assert local resets (core & PHY)

  - enable and stabilize power (IP core, I/O rails, PHYs)

  - enable and stabilize clocks, including refclk and T_PERST_CLK

  - initialize PHYs

    - deassert PHY reset or allow register access to PHY

    - wait for PHY PLL lock to refclk

    - program PHY parameters & calibration

    - verify PHY ready

  - deassert local core reset

  - configure RC (device type, MPS, max link speed, width, etc)

  - deassert downstream PERST#

  - enable LTSSM

If this could be made generic enough, maybe something like it could be
included in Documentation/PCI/controller/pci-controller-drivers.rst?
