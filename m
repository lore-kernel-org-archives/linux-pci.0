Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141C5499F15;
	Thu, 13 Aug 2026 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640903; cv=none; b=XQFrV/S/9rp3kSfjnZkUPuEpxM7ZUG/e8teZ0k1B7R0z9bCuJ8W54Lph1fN6M9c+5ihZBeMWngeJyjIWtZdMD5VvT5Sc2k0Shzj9yV6FK7EjinwDcYo65FF/ItIS9zvumIYobbRQ7D88Np4fEwZQ1JNC/aVNJWuTSbhVSsDJi1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640903; c=relaxed/simple;
	bh=6ejOHroDsSTZfWUQykWe0DhGDiou1QMbMw11Hct4uLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hvwgBfT1Y4Rj1awXjGYzxwAFi2pPVf0B/mn+lARyB+0oo1Kf9DoImZwA8fbGQsh3BNLt0dkSIEUWYrFGaPJZSvLj+hg+k1SlSjRAiVFDFNjx/elW/jhi6KPYQKqxyaMhbkx+y7SBJaRtI/xZyOQlVEJ9ckgEUTPoJxDUOYxOIoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMexpM9H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMexpM9H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB171F000E9;
	Thu, 13 Aug 2026 17:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786640902;
	bh=VWzDmzaSohfXNDpzSvOTbywfXkmzWVFikcHjO6Hw6u4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=oMexpM9HgR/F0qhmie3lMLfDUJpZIBemLcjAJuOeeXJ7qClvyHWtAJ7CACr2xcuca
	 PI15FrVmdVqRoxp0SvaXKM5/JljD20eiiESKQyaqqyIRjYhc/EOwME1AZBJrqjLV+1
	 q20DhdzMkeIvxgOxDTTFthCM9BV6rNF5lZyMY8RflP51tVam2ROq+LJ6M+H9BF+T8Y
	 3T60TyZBPTn1crYl9EO4WTzem+JiL7xet9FlLKkEiKIixiKu9WaHTYQgDxEdcf+lmh
	 p+9A1YSS9kBCyQjMvaSkyqceLZW4q1dAsGi8LBwFo5YliGzhxUFcuO3wjGtVDfjh8p
	 o6WUseK5r910Q==
Date: Thu, 13 Aug 2026 12:08:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/2] PCI: mediatek-gen3: Add 2-lanes mode support for
 Airoha AN7581
Message-ID: <20260813170820.GA1143871@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806165334.7328-3-ansuelsmth@gmail.com>

On Thu, Aug 06, 2026 at 06:53:32PM +0200, Christian Marangi wrote:
> The Airoha AN7581 SoC supports configuring the first PCIe0 lane to 2-lanes
> mode (x2 link) by bonding it with the second PCIe lane (PCIe1). This is
> done by configuring the PCIe MUX in the SCU register.
> 
> To correctly configure PCIe0 in x2 link, define in DT the following
> additional properties:
> 
>   - additional reg, 'sec-pcie-mac' for the secondary PCIe.
>   - PERSTOUT reset for both main and secondary PCIE0, called 'perstout' and
>     'sec-perstout'
>   - 'airoha,scu' property to correctly configure the SCU register for the
>     PCIe MUX
>   - 'num-lanes' set to '2' to enable PCIe0 in x2 link
> 
> In such configuration the EQ preset are configured to the same values.
> 
> To permit correct configuration of the PCIe link, additional logic is added
> to assert and deassert the PERSTOUT resets. Support of these additional
> reset was introduced in Airoha clk driver with commit
> 6712f48eb3a1 ("clk: en7523: add support for dedicated PCIe PERSTOUT reset")
> and on backporting of this commit also the clk driver change will be
> needed.

I don't see 6712f48eb3a1 in upstream or linux-next.  Is this SHA1
going to valid if we merge this for v7.3?
