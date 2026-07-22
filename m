Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E297403AF1;
	Wed, 22 Jul 2026 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739148; cv=none; b=CtchD1PSbV6ETm40RUCa4+qcNoFVEiXWoxcSaEHD/s+PiCPRDvZ7k7gDbMVophKcrYM5cH/Hu2Bdh05iUjzrW1Jju3lcP4cJQd0NOGu9ikPHKrJhNLT2OS4dvDSz/lty2qr8/DYqm6a2SFVa74NRzsf9FQ6od6DskaS2H3gkDqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739148; c=relaxed/simple;
	bh=yIhRkRrh0sn1tTFaoOyW1vk1VDgHT9zFdkvuhLp0+dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsmgTNab+TxJC2KqxX2SJ4qelT5i1bDNJzacgYi1NXQoHT8ZMccXIyqAgSA1DkBIAV09J/FY/MPR/3HTFUYMt3pZROgFy2/bHktdJFSisa+8PYmjvR2VtCcWO+enEduLMIIim0fTyGXcDET2BU91cR6rVJ4u7v0QpO9UAiRmcxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpFHoyV0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpFHoyV0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D851F000E9;
	Wed, 22 Jul 2026 16:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784739141;
	bh=GL2pSyfUqjuPmverPU2rNkWROn+3SQ8dGrBCAoNYays=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DpFHoyV0VFzABFLUPR7icr9hWT7ghJ6g3aNli0e/diFud0wL7Cm3kFotmEPSNYqHj
	 4WmkKbR8kP0jQFRPjeO5JmcDEGYx08WsaNe55rJZ/lx/OlHO/4TAIH32OMch3eu0+r
	 hEBY031rVJByEP4q9/pdc9MbqGiWu2j0dCeHvz7d1G6W76sT4KNnywdZUSc/kHDvRi
	 IRmUVnCUp6x1vGfZv71ZPpQjS9FRzGlNsbOCwUAvmMs0urk3vjTxkoz6Umm1NG9EAI
	 bS2umLIzRe5jJQx0+q784VYxhZON5JEwdkrw4Y4CE9ERy9LT+tZkN6uZfW4KAi/IpD
	 I9OoC79v7RBZw==
Date: Wed, 22 Jul 2026 11:52:19 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-clk@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-pci@vger.kernel.org, Brian Masney <bmasney@redhat.com>,
	devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	linux-mediatek@lists.infradead.org,
	Ryder Lee <ryder.lee@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v4 3/4] dt-bindings: PCI: mediatek-gen3: Split Airoha
 schema and document 2-lanes
Message-ID: <178473913929.1097113.176772633054348550.robh@kernel.org>
References: <20260714115848.8537-1-ansuelsmth@gmail.com>
 <20260714115848.8537-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714115848.8537-4-ansuelsmth@gmail.com>


On Tue, 14 Jul 2026 13:58:45 +0200, Christian Marangi wrote:
> To permit proper documentation of required property to support PCIe
> configured for 2-lanes mode, split the Airoha schema part from the
> mediatek-gen3 schema to a dedicated schema.
> 
> A PCIe configured for 2-lanes mode require an additional reg for the
> secondary PCIe to be configured and the airoha,scu phandle to correctly
> configure the PCIe MUX.
> 
> Rework the mediatek-gen3 schema to drop any redundant constraint previsouly
> introduced for Airoha PCIe properties.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/pci/airoha,en7581-pcie.yaml      | 244 ++++++++++++++++++
>  .../bindings/pci/mediatek-pcie-gen3.yaml      |  77 +-----
>  2 files changed, 249 insertions(+), 72 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/airoha,en7581-pcie.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

