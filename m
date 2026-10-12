Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F054A4407;
	Mon, 12 Oct 2026 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819155; cv=none; b=iszmKmlzksddQhJjQ9px0G8J2YczSrp1TePA8pO9q6pEPDSklIuzJpe4P+2yEbghbw7GUChRJdbbYLdX6Pmv1CaL7UdSUvsOW+pc5IE8lmqzSQmRcXq2YuXzQpzWfd5qHpqGFjEQsRxEk9R87nnweAl5u9qKTt4/C5zXzKXh+tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819155; c=relaxed/simple;
	bh=hPKrAxb/njSmvu8Wo6WPGK2fzdegjQ8qUg74SMm28FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/EruGhSIRkHNB+f6jehzubxV96oQNzJurbUjN9GSbrPDChfnLjdtp+U2iM/J4VMTLcq/8Gt4m5Xb/FBMuTFnHl6LvhjSWb7rpdNfjMJsNKcAftcm4cCLTMPy0CgjB6eYMriMirqRB8RtMO3JMyBCCVFMd1CD7FUb8TQBrYtUBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhj2mM+c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhj2mM+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834231F0089B;
	Mon, 12 Oct 2026 15:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819154;
	bh=VpxzDJstSsto0RTGs836L18/JiYYMQazVuw1Z3RZYlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fhj2mM+c+gtmIhtLFxRKOe0XW0PW3V45eNmHLhWzRc4QCP7mXRKTdDc56TbxiE8lt
	 OW2eUq8KZqLsVBuEpcQ0+wIELD0Q6f7wWoR897We/Y6RRUtHrtrAs9ubXob/wS3HRj
	 5fWC6rlnb3tqZj1gUCOJau1FL6GYAK7ccEcWn5i6yzvkOod65Iefa4O3rFol3RLe8F
	 UIpQKvzQ9HsyvXnwdfB0Abn2TFKoWOydrjrKdXqb5AFDmmVuUAad9PD3wHRrdgJu0K
	 Ya8FBC4Uiv1oF0G7aXfolae/fcSAbcgiHT8szvVYGl+Z+yq7JCyRiPVfJ++G0xjDGq
	 EGcc4LEemZJtA==
Date: Mon, 12 Oct 2026 21:02:24 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org
Subject: Re: [PATCH 3/4] phy: qcom-qmp-pcie-multiphy: Split phy_ops into
 init/exit/reset/power_on
Message-ID: <asz9ApG3h3EJC40t@debian>
References: <20260915-align_pcie_init_sequence_0916-v1-0-0b2195836f30@oss.qualcomm.com>
 <20260915-align_pcie_init_sequence_0916-v1-3-0b2195836f30@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915-align_pcie_init_sequence_0916-v1-3-0b2195836f30@oss.qualcomm.com>

On Tue, Sep 15, 2026 at 11:04:23PM -0700, Qiang Yu wrote:
> Per HPG, the controller now calls phy_init() from
> qcom_pcie_host_init() and phy_reset() from inside its own core reset
> assert/deassert. Making that actually happen here needs phy_ops::init
> and phy_ops::reset implemented, and phy_ops::power_on adjusted to
> match. Split the combined phy_ops::power_on/power_off into
> phy_ops::init/exit/reset/power_on to do that.
> 
> phy_ops::init enables power domains, regulators, and all PHY clocks
> (pipe clock first). phy_ops::reset does the no-CSR reset assert/
> delay/deassert/delay. phy_ops::power_on is left with just the PCS
> status poll. phy_ops::exit mirrors phy_ops::init in reverse;
> phy_ops::power_off is dropped since nothing remains for it to do.
> 
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
