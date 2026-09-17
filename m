Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8FA497380;
	Thu, 17 Sep 2026 23:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789686047; cv=none; b=e2TVlik/teJeHufLb3tsaG/EtQQAnJ/wsLvhpEULNBsYSKt5Oswe6W3BtyPYAvk9JNIU15sN1ekT01k4e8Bf961PKhpuW1fsYASAvFNL9A6NwAZu2q/lPJzpUbPhWOs+VUS96yrJpEZdyrztu4d0QuRzQzNFcSjtFkZHvkHwgx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789686047; c=relaxed/simple;
	bh=gXuGyLy2tmRszawmUKlyiTtyX4tL2WlZ3pUjxElD5+A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=p9cWPdhPeDpe4Q+uJ9bloGq+D+vyaz8XY8ynvxFEq0ZQiRFiDp8fiTuHKEONucggQNoEWS6ocw0vPiFEn0eXZdXe1RjGlIV12OxBz5JU0SUbDc6lGWC1tYTJiLaRt7vOFxPdTDDVoqkjzP2F/szJ9Og0BN160oIuCPDeOzi5pUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hk95nq6E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hk95nq6E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4D51F000FF;
	Thu, 17 Sep 2026 23:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789686043;
	bh=4peBAsnWme09BQ6woZ305p/0tw0c7pP6SdCRfkMgd/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=hk95nq6EWlvY2MjWuIEtn9vj8KRLS9zn5Le2QUthvZbNDuGnEzRmzpOzl1E3IQ3nO
	 /vqpQw9EiTp80get3fNEVJlriq+qaOoWaqQrWiApbEQgR7u4RHgKfEnz8q5tB0O197
	 EQL9q/ddlt5WoeovLzzxCuOofyjEkbG10ZBcYS8M7bccJbkAH6nPMqJo3nRImz2OXp
	 CvBAEh9rTuDEqOTqRho5IhsqSTJqkXokd9HgWPVf8xA7cBiT6gPT3Z+DtvXM3Sm1EF
	 RIz7Vg1UTqMKf97cYz6Bc1MCXC59qiC34OzWPpv2i2ugCganI175vCM4ST6YXlwQKL
	 S8lAxC+QAnRKw==
Date: Thu, 17 Sep 2026 18:00:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: vladimir.oltean@nxp.com
Cc: linux-pci@vger.kernel.org, Aksh Garg <a-garg7@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Manikandan K Pillai <mpillai@cadence.com>,
	Felix Gu <ustc.gu@gmail.com>, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] PCI: Remove device links to Generic PHY
Message-ID: <20260917230042.GA1091862@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912161440.1032188-1-vladimir.oltean@nxp.com>

On Sat, Sep 12, 2026 at 07:14:37PM +0300, vladimir.oltean@nxp.com wrote:
> This is a request from Bjorn Helgaas to replace commit 9a9d18547ddc
> ("PCI: Remove device links to PHY") from the pci/next branch with 3
> distinct changes, per PCI controller, to handle conflicts with bug fixes
> in the same area on dra7xx in a better way:
> https://lore.kernel.org/linux-pci/20260911221209.GA587622@bhelgaas/
> 
> The patches are formatted against the v7.3-rc1 tag. They do *not* apply
> to the current pci/next, as the change is already present there.
> 
> Previous submission was:
> https://lore.kernel.org/linux-pci/20260810124315.433448-1-vladimir.oltean@nxp.com/
> 
> There is no other change than splitting up into individual commits and
> adjusting each one's commit message. All review/ack tags were dropped in
> that process.
> 
> Vladimir Oltean (3):
>   PCI: cadence: Remove device links to PHY
>   PCI: dra7xx: Remove device links to PHY
>   PCI: keystone: Remove device links to PHY
> 
>  .../controller/cadence/pcie-cadence-plat.c    |  4 ---
>  drivers/pci/controller/cadence/pcie-cadence.c | 16 +---------
>  drivers/pci/controller/cadence/pcie-cadence.h |  2 --
>  drivers/pci/controller/dwc/pci-dra7xx.c       | 16 ----------
>  drivers/pci/controller/dwc/pci-keystone.c     | 31 +++----------------
>  5 files changed, 5 insertions(+), 64 deletions(-)

Thanks for this, I put these on:

  pci/controller/cadence
  pci/controller/dwc-dra7xx
  pci/controller/dwc-keystone

respectively for v7.4, and dropped the PHY link cleanup patches from
Felix that are no longer needed since the PHY links themselves are
gone.
