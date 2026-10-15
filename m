Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B30C475350;
	Thu, 15 Oct 2026 20:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095009; cv=none; b=M04xUKrPYJ8EUK+SAixn8UKqvROJ3nqBvDi1YbA0DW6utEhZPOu5gFT6sSMj6OGUhG/OIS++6WX8KvBFjVH+8gF0sgP0wIqK4jFxO8Mn65tM/guN4gWhyYLk+ee3krCZ0WSmAQ9mX/G0AM+u2qL+2kQv8LX4+AUg9uv7gbUyedk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095009; c=relaxed/simple;
	bh=5+ITx/IV/BoxeXsLcjNXvtzt06iKyo8dX2YvX/hAwNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jR8AY+Bv1B6WuAHrAMrYxguwjKokalnwBaVq9r3ACpmHhiZMeQ0QI5XNOnS6/C6b8xf/JMz012uMZWObfEoclPj0pGHNhYEW6V7ER7XvVRisbqkum9Fpl4sEmrIFyoVPmGmm4qu6zRfn9OdmQQumPqAkQ/bxpt6P1YWZBw3jvos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcaNxYGX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcaNxYGX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349D41F000C4;
	Thu, 15 Oct 2026 20:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792095007;
	bh=vGkzpNU4gEbEI0HBSrDSBMbVcu/OtmqB0nVCCkvCRSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZcaNxYGXNMGp5Yrju7JyTI4kvcvqFC4t+hvx5QEaD6PRkpeipBX8SBeRfajgWY/7v
	 lXlooyOgiHXpgjqwREXb3WXmjLNroziatAm4oYrY1/4exZyN/48+uKSxbiaE0rR/Lm
	 ENDS0EnqpqLWCyZSzXDJ8QvwBGyHkMMNQlCKIoV7VtsRHv1dW3QzrVIUUwyIua8mZL
	 bxHEumb73EhE/PYOTL8HSmdSUVaXd8cRpwG19kfCJK4WIjK6xdEonXQ8qjCIHRvExS
	 bEe+dCquaRNw34y6xMaICo5G9Bpe1XV/rOmYLseSlwPBtNPaw4pjhRaJOT2J2x+P2K
	 1JpPIlW4ZiarA==
Date: Thu, 15 Oct 2026 15:10:05 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank Li <Frank.Li@nxp.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Niklas Cassel <cassel@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v4 04/18] dt-bindings: PCI: rcar-gen4: Add optional "aer"
 interrupt for R-Car Gen4 SoCs
Message-ID: <179209500464.2848447.6678039207382562663.robh@kernel.org>
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-5-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015033103.3076869-5-den@valinux.co.jp>


On Thu, 15 Oct 2026 12:30:49 +0900, Koichiro Den wrote:
> The intreq_pcim_lperr interrupt carries Root Port AER notifications,
> separately from the integrated MSI receiver interrupt. Describe it with
> the "aer" name so the controller driver can use it for Root Port error
> reporting.
> 
> Keep the fifth interrupt optional on R-Car Gen4 SoCs so existing device
> trees remain valid. Extend the example accordingly.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes since v3:
>   - Rebase on Marek's Gen5 AER binding fix:
>     https://lore.kernel.org/r/20261003215710.792518-1-marek.vasut+renesas@mailbox.org/
>     This requires "aer" for the Gen5 SoC PCIe4 controller from the
>     beginning. Update the subject to clarify that it is optional only
>     on Gen4 SoCs, for compatibility with existing DTs.
>   - Drop R-b tags due to the changes.
> 
> v3: https://lore.kernel.org/r/20261006084638.3821710-5-den@valinux.co.jp/
> 
>  .../devicetree/bindings/pci/rcar-gen4-pci-host.yaml | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

