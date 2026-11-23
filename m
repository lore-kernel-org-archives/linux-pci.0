Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428201;
	b=Oy9Jr+dyvSiBjL0Q128Zexj5Uu0fU7+kSzZrIK+LB4TTwvlGo4xNf/Jn5H5nPQsvOZYx
	 oBlbM6qOgdbIiWkj8I6uDfZuhWeZ22IyrEVwysveUpvDQwkiqchneM0SCS5PuHsTNLpvD
	 PMJ18T8oLhjA/J/SgLbse2MKKjajCATjHlzRV/6Q053w923YSmY5X6S1sVbC0SqPIEJ3p
	 V/a+kWyEShEjytDhiRuvwnMsQ40RurRz/2vLhAGG8+vNRiQbFw4RDi8+ZfbLktfEJXeEP
	 123JcahI4x35TQ8JFfnQaFm5CjryjssdqkhaWJpaAwqimgcSASTziSZY2WNlUuhELAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428201;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pSx5Qtk4aSrB14LJF06/C0GElQKBFoGV9uZAL0Zwiow=;
	b=Pcrtf1da7BYpeGUlM7Y8GuwLhApESQe46QNbCe/R71r5mHl1XTGTQErKPvwrBvDgwomf
	 TUHcTwMkwyQgVxmOLlsLi+ocbuGNiCIay+4U+41Xx+9PlnpUveJb3FFTRxbAXjJVCVEyB
	 sNb1SDlyKPgslEy+wk+6fbJx0Wic5YyZbEQrQVwTHUkSjtzh1kB1UyZN0Pz4t02kfH9iT
	 +EPIZG0nSw1uJXcF52RAwZU7inrPGdNmX98mpkFPJo9rsXJCyCtrGqB1iK/A4t7sYd/ak
	 KQPqLt6L9FZkjv0k85ErCYtCMVCYu0JB+/yhraVtprnaGKky4iodxxFjIpZEklPSHvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Zc9zdBP/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFFE606A31A;
	Mon, 23 Nov 2026 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zc9zdBP/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAC01F000C4;
	Mon, 23 Nov 2026 10:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795428201;
	bh=pSx5Qtk4aSrB14LJF06/C0GElQKBFoGV9uZAL0Zwiow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zc9zdBP/RIkgPw6iGV8EBu6kZGmiLZS7bX7Tvq0ScDNF3vRS7e5qFzorVT3iT9jAu
	 Yib32wRC4tYj+5d0GeT06qzQNmGxym666WQmiui+2/NEey1/Gg/GiYKgy3YhLVaD0q
	 UOnwA2d3m344LvWcehmblIh7tqRNcF4wTWeBXKJGpewE+YuwdImSr77FjZ+oRX4Q0D
	 zwt8OKNYx6TM8pXegVwnVBzcaMZlu89Am+QP4DGaO1zmBylu5+Wpr0gmUK2aWN7TK4
	 lbtUfggQVPNdeDk+McVb35g/PkAdfMSIbEayEb7biLokfmNF1lrZkOUgsDPHpUGN2b
	 dCg0vrhkr7Exw==
Date: Mon, 23 Nov 2026 11:03:14 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH 01/11] PCI: epf-mhi: Pass the actual number of MSI
 vectors to pci_epc_set_msi()
Message-ID: <awQPYjRQgf2fLMZk@ryzen>
References: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
 <20261122-nord_ep-v1-1-6d8839ffa9aa@oss.qualcomm.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261122-nord_ep-v1-1-6d8839ffa9aa@oss.qualcomm.com>

On Sun, Nov 22, 2026 at 08:26:14AM +0530, Krishna Chaitanya Chundru wrote:
> Since commit f62da6e7270c ("PCI: endpoint: Align pci_epc_set_msi(),
> pci_epc_ops::set_msi() nr_irqs encoding"), pci_epc_set_msi() takes the
> number of MSI interrupts directly; the controller driver encodes it into
> the Multiple Message Capable field.
> 
> The MHI function driver still passes order_base_2(info->msi_count), which
> is now encoded a second time: for msi_count = 32 the controller advertises
> only 8 MSI vectors instead of 32.
> 
> Pass info->msi_count directly.
> 
> Fixes: f62da6e7270c ("PCI: endpoint: Align pci_epc_set_msi(), pci_epc_ops::set_msi() nr_irqs encoding")


As Sashiko already pointed out [1], this Fixes tag is wrong.

Please also reword the commit message, since it is based on the same
misunderstanding.

This matters for stable: commit 1bf5f25324f7 is in v6.5, but commit
f62da6e7270c is only in v6.16, so with the current tag, the stable
kernels in between would not get this fix.

The code change itself looks good to me.

[1] https://lore.kernel.org/all/sashiko-outbox-227654@kernel.org/


Kind regards,
Niklas
