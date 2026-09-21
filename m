Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11968484239;
	Mon, 21 Sep 2026 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989426; cv=none; b=lMevxPubRd+L+nfjnTH9hb4x4BNgggHLT4Qvod8JxsA93y20QohNHKlsYfvU9YKppzHHNF5U5WGKGx3TdHyH3obo//v533n+Bj52NWX5kS2vQRoqpxlo+Ndw8TG7nUIMJKOFzpacxSwYJaQxo87TS1cZGHug04FOOXD3aBqGsW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989426; c=relaxed/simple;
	bh=FPcITbEeIe3Lobqhom3a6DbS0CEVv1Mv3OpksN4M5LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvlMz27a6oAmvgHmNx7CIzbslkEuu2EH+N13mQtPRTjEHpOSqb+qRf3SKB6R5TQ38Pip7I+59pV67UVCWFfw/c6TVnv26BBu9dfD7c9l7Sad5m5xFV0JpbwSTfbk0UxSYJZwspw+/alhUepWYLHWiR7EUyATdE8cjSeC3EuS7nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhfZ6J3S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhfZ6J3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA791F00893;
	Mon, 21 Sep 2026 11:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789989423;
	bh=EWpvnS9sJSHrGCy+MFZE6qg3yzgkz6vfigCSQ78iMBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LhfZ6J3SDa1TNs3WY8M7GWvBfvuJ1Gf+IzRAbT9jLnwEskR2+sCXEQki59C3fFHNM
	 kCWJk1MOaJlXTnuPx6JT9+Jv76qTZgTspxBO1ZEi7SO/OA1u+mUTFFO+ZkLJrh8x+M
	 T6uxRFUx23szXsImepIHkY4328i7Wf0zquQ98Odwki9IFnVTdVyBsl9lr5ApuLDL3Q
	 eP94wzVnqzBxJ5SvV/gMgisLtWrp9CnD2TdhuOTvg3bgw67Qyd9pKUp/4wNbnprZbC
	 dS8+e+ucvdBdDMUNCryhioCUoZ0zHg3bDANz4nOp9fzanrjZxwxTw+d1tmMA6tYhzy
	 Rg4xDX07oikPg==
Date: Mon, 21 Sep 2026 13:16:55 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Qiang Yu <qiang.yu@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH 0/4] PCI: qcom: Align PHY init sequence with HPG
Message-ID: <u76xfze53ilx6pd7wydsutax7urcbvlhlos64o6cvzku6e5wrs@jugdukoksabu>
References: <20260915-align_pcie_init_sequence_0916-v1-0-0b2195836f30@oss.qualcomm.com>
 <20260916155504.GA926264@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260916155504.GA926264@bhelgaas>

On Wed, Sep 16, 2026 at 10:55:04AM -0500, Bjorn Helgaas wrote:
> On Tue, Sep 15, 2026 at 11:04:20PM -0700, Qiang Yu wrote:
> > HPG requires the controller/PHY GDSCs to be powered up and all
> > clocks enabled, then the controller's reset and the PHY's reset
> > toggled together as one group, with PARF_DEVICE_TYPE set right
> > after. This series adds the callbacks needed on both sides to
> > realize that sequence: a phy_reset() call the controller makes as
> > part of its own reset, and matching phy_ops::init/phy_ops::reset on
> > the PHY side.
> 
> This observation is not related to this series; it's a question about
> PCI host controller initialization ordering in general because it
> seems like this is a perennial issue.  Is there anything we can do to
> converge on some sort of generic standard or typical ordering across
> drivers?
> 
> For example, while looking at a patch that changed ordering in a
> different driver (not qcom), I asked Gemini for some guidance and it
> came up with the following ordering recommendations, which seem
> pretty generic:
> 
>   - assert downstream PERST# so physical lanes remain quiet while
>     setting up the host
> 
>   - assert local resets (core & PHY)
> 
>   - enable and stabilize power (IP core, I/O rails, PHYs)
> 
>   - enable and stabilize clocks, including refclk and T_PERST_CLK
> 
>   - initialize PHYs
> 
>     - deassert PHY reset or allow register access to PHY
> 
>     - wait for PHY PLL lock to refclk
> 
>     - program PHY parameters & calibration
> 
>     - verify PHY ready
> 
>   - deassert local core reset
> 
>   - configure RC (device type, MPS, max link speed, width, etc)
> 
>   - deassert downstream PERST#
> 
>   - enable LTSSM
> 
> If this could be made generic enough, maybe something like it could be
> included in Documentation/PCI/controller/pci-controller-drivers.rst?

Some of these sequences could be generalised, but the problem is, pretty much
each controller sequence follow a hardware reference manual and those
recommend a specific sequence. So if we diverge from that recommended sequence,
then getting help from the hardware team for any issue would be tricky. Atleast,
this is the case with Qcom controllers.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
