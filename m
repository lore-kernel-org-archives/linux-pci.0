Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DD4397E73;
	Tue, 30 Jun 2026 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837577; cv=none; b=tMQHgiVg6bLR2ek8tYKBjdw4XK9IVSXwcIq1Om+7qE4ZxP7twOaWBvY5BaDimMSzTsWI6E9qtsAA6C0liXrJt3ngIj4wYlY0CrMi/4KeAPS81FmOiz2IVwnRKmJKNA3PTrhygQHHhKAaM+OamUi1PKIFSSNpdqYvaNvtNytklx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837577; c=relaxed/simple;
	bh=Rikpi7pPgOmeEsr1F3K6MYEisg8kPO5U/COrf+QAQp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPL+qUVhRK6IXE3iV7NE8o7dHHtYrDdt2hXIJT+AP4DQNlgXY0XIuBikKrZZlA7g5vd7hL1pcKYjWfao7pYNtmX6MvSGeyDrJUi27hRuffa19yJ/0hdDns2h3qCGwcU1zgpc2oTBkLhO+ve2n/qRSw7/4EBIX+LMFKCTVNwPmRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2jZtrhL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2jZtrhL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415601F000E9;
	Tue, 30 Jun 2026 16:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782837576;
	bh=5y1+upEHw2aVmmfQc7NmwlD1vJ7ldcPCjL3K67v3kVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c2jZtrhLB2/QXI1U1YIaFApsftQcs9m8LqVlyzcANboeutPLdeCkiwTnVEZjDCyit
	 X0Y95SAAFZgUpm79p1I3UcPbtEE5ZfChErW8ImZ8QQQi+s/CoOWak3a0TkOzFFp4OV
	 a3GvWRGmUMRGgLCitrKIltfYT/jx8mT/FDP8R52885EKIIBJIrwR/LkBmkY1aTBYbo
	 Lb+NkW/k9yRSJHsXzz8Kv7x6/Mnj1AFFigALczLhMUCmIY/L4tpMbHaRh4FTUqcA13
	 Gxw92QgmmLPLkhff3nVK5s7Wt5roeuaD9CgYhtEgHvTSlj5UhfeGVFbyVVrueMX7Xa
	 REMo4LW/Z/R4A==
Date: Tue, 30 Jun 2026 11:39:35 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-clk@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Brian Masney <bmasney@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: PCI: mediatek-gen3: Split Airoha
 schema and document 2-lanes
Message-ID: <178283757491.3920026.421543369418004225.robh@kernel.org>
References: <20260626092029.3525264-1-ansuelsmth@gmail.com>
 <20260626092029.3525264-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626092029.3525264-4-ansuelsmth@gmail.com>


On Fri, 26 Jun 2026 11:20:27 +0200, Christian Marangi wrote:
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
>  .../bindings/pci/airoha,en7581-pcie.yaml      | 251 ++++++++++++++++++
>  .../bindings/pci/mediatek-pcie-gen3.yaml      |  77 +-----
>  2 files changed, 256 insertions(+), 72 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/airoha,en7581-pcie.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

