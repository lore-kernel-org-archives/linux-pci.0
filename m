Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9954457DA;
	Fri, 11 Sep 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789111754; cv=none; b=Krg68QzVZtCzj+rOKKPsx8mrseSl2kILlBgqm/ZDm+/O1wo4jQNT7iMqz18AKdghrCzU+oYp3+sKLDkIYjwMyfQBMl6tTCGQWdQuC9ATmceliGZYFEpW3a8gfAoYdAN7HCz94rrVaOE1CgKTUc0my9co64SHv15to7hIlI5qxt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789111754; c=relaxed/simple;
	bh=H2vKcrBeOf2KlTyDuSxatl6hblqRzQ/Id/Mhlhp6OU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byCQeiydHZVq5zSakx9kvShP63qIM2Qm3yGqFxYzz7Nf/ySk2NCkb2DRONTpZ3MTB3W41KhhV3SbfEQUscO+kUIHo8i7aL0rXCjEkmQ1E1Aom6smnLBF7Cxejx00hqnmG64VMBFv05yIx3Z+ZkBvbdKMeZlzooSVIuELM/jh+hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwEzf1jc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwEzf1jc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2F51F0089B;
	Fri, 11 Sep 2026 07:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789111752;
	bh=K7ria4gLd+ljva1/e0Ar6F7V+sxjRDUrOLPcuYFX6jY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JwEzf1jcwuPKInyZ9nq4F14+sjSSTGypdVJp++aFsELS2MKVdraMJCcHuiSmdtczs
	 VbsoVgg1JJ8mgrJFqAzTyhlzHfyrIkfwR/ikPB5DVkIkHSqZSdixAeDn+BkUn90Lrn
	 wPpPneVWkc4GBILmJDkzy38HJhnEwr6GpbqyrC40FTWJCqTszzFMO+7ZMrIhrZ8dGH
	 kVaQzmm4/43VHNrWsK9KjjOzhO8TDVQIEcanRhWVxYmRf16jJCSjjeE8DwlUItPPQe
	 6ypnqU8YlXPewuq0UJCtu7veuUiuOxLTF15GdrUlh7qoP8qA6+amKPGb+UG8+hA7Go
	 zYlbRk7DKh1sA==
Date: Fri, 11 Sep 2026 09:29:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Michael Walle <mwalle@kernel.org>, 
	Alex Elder <elder@riscstar.com>, Daniel Thompson <daniel@riscstar.com>, 
	Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 1/5] dt-bindings: PCI: toshiba,tc9563: Document
 embedded GPIO controller
Message-ID: <20260911-leech-of-ultimate-force-b08f28@quoll>
References: <20260909-pci-tc9563-aux-v5-0-c9b33f56c8d3@oss.qualcomm.com>
 <20260909-pci-tc9563-aux-v5-1-c9b33f56c8d3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909-pci-tc9563-aux-v5-1-c9b33f56c8d3@oss.qualcomm.com>

On Wed, Sep 09, 2026 at 04:55:53PM +0200, Lorenzo Bianconi wrote:
> The TC9563 PCIe switch embeds a GPIO controller providing 37 GPIO
> lines, accessed through the switch's I2C interface.
> 
> The controller is integrated in the switch rather than being a separate
> device, so expose it by adding the gpio-controller and #gpio-cells
> properties to the switch node itself, and extend the example to show
> the downstream ports' reset-gpios being driven from those lines.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

