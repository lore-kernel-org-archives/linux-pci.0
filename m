Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7D63115B8;
	Mon, 28 Sep 2026 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620374; cv=none; b=tS4M/k4y9B18XTssxwWHUGhSPKACRVMu6qKuxsJOgpMBVmg2AaKQM8uNf6BoD4ggZwwf/BcQclmZdR2fBbzv3Vzfh4ahYVRMQvtspKLD1r2K+J+vh4rzhN+G0J8ajbpfXiTLQDo7bpfYej70VJH/xzfpoglESiesdDvPrafl0jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620374; c=relaxed/simple;
	bh=kteHbzA/cME0t66CPbcXb5fnQe41uG1k0J2szAWIUoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkfwGh9heyHVHLvZx6Z6o+Fr0d5NRiPJ5kDwJeYieXLf5QzGtcOwKttXjWruD9aaidhpC2oecAOpI/AsLSYrMzNn6L1FeU1WXkFsTaw60osdu2m7OFAQTbcZZYQuc+OKqrfNKLBJe8gF6vSnG5+hdh1scJv+C8EjVTcXGATXYLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ii3bCXzx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ii3bCXzx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332D71F000FF;
	Mon, 28 Sep 2026 18:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620372;
	bh=KTBfG0K3nu4nUS1bFyAD1F338UQwaB0hW7nroAfhRcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ii3bCXzxTOwniPbfUoOlhVF3sgxg611INtrkotvTS03WWO4J7s4jM4N2q28xpD2Kx
	 nxF1RFHmVPHAqGrdkLyx3gta4J9enjYPYpqKYvnw7lmEhLhBY1U/gUY42jO25XyTx5
	 LtpW3Fsl1eZ69BVAmaZKoG7pHte2sE3yUHy6lKrMlhwRigpKE17OA/3XgJ3BkCogo+
	 blY7T1axTn6iZKUcqdbEPSRmezuM7ObFc47PpY+//OF2tUXIWvGAjneqFLlZVoxD9b
	 TdcqU1AOjFy/ZYsPcM/8aAGfavr/k+8iDKoRp3eOcGPIBLAuCxcN+TdOt+0f2+WTyv
	 rVs301+kLukbw==
Date: Mon, 28 Sep 2026 13:32:50 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH 03/11] dt-bindings: PCI: rcar-gen4: Add optional "aer"
 interrupt
Message-ID: <179062037015.225190.14401669841079574917.robh@kernel.org>
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-4-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918032038.2216471-4-den@valinux.co.jp>


On Fri, 18 Sep 2026 12:20:30 +0900, Koichiro Den wrote:
> The intreq_pcim_lperr interrupt carries Root Port AER notifications,
> separately from the integrated MSI receiver interrupt. Describe it with
> the "aer" name so the controller driver can use it for Root Port error
> reporting.
> 
> Keep the fifth interrupt optional so existing device trees remain
> valid. Extend the example accordingly.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  .../devicetree/bindings/pci/rcar-gen4-pci-host.yaml    | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

