Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E71202F71;
	Tue, 30 Jun 2026 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847862; cv=none; b=O96/562/zrhiQyHvYgD4RpAv11Og/7D0lXEe4NyVW+sRHxEkbll9RgKbjaX6HCKqa5n+aRNw/SzP3fUcL7J6ts8BfIh4+78gnzlfhdUhC144juOKsTmKWR55ZzuPsBwxtzTqnneNYLeyVlr9NkRKebxsyNkNPSeRjqrMpVI6Zjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847862; c=relaxed/simple;
	bh=mrE3w2IyYelypAl/GvSZByg873k6VhifiH6RGtmdHQI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aiD27/QNxq0pjKNkVPQyDCtQhjrZcqGFOsoFxIWl5KGdC29Xz8cuun3zIaharr9AMWVxYnj+QPxx8w7dBPGp2gHiKtxpRTF1R8oQ8PGTU/8SpaPpSXVblk/CDN8yTsOjUQT6u2QThnV50ebjaK1NfoffmR4ZigKmjyMdPcLN8fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JR5SiuS8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JR5SiuS8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D0F1F000E9;
	Tue, 30 Jun 2026 19:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782847860;
	bh=NbhZJUGJY7sFP1hmNAqTzufrLxATMRY8jzOc360bLeQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=JR5SiuS8mdLBZXGnDcx7YChTvK2UhAhsoecyiqWAjEK8YieU6hnMxYO2wi8LnPu+W
	 ixrAyB4fPn7FwhtiH5yRCRY3qoT6JfjQRe7H1BE/oj770B666T3L5G3G/jrWKxTJPP
	 ft9A0q4yApboMknGkELvNnEkr4CbBI9CA9KqHtmpTcLRqU6a/b4bc/atg2Iyzi/8A0
	 Ol9TWY1z8ptOv0TF3iR78TVJa/b0Hh4K8jI7iAGU54Y9ZOcwLpSQG36+VGYm2cfPLk
	 BmjfOrrDkdHnI4klR/OeRXsT0koSc+rgFy6Xb0IOq+kOwPie4CgPDNwGzckLXN7O7z
	 ridPQXL0cCcvQ==
Date: Tue, 30 Jun 2026 14:30:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 8/9] arm64: dts: qcom: shikra-evk: Add TC9563 PCIe switch
 node for PCIe
Message-ID: <20260630193059.GA225112@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701-shikra-upstream-v1-8-e1a721eb8943@oss.qualcomm.com>

On Wed, Jul 01, 2026 at 12:32:50AM +0530, Sushrut Shree Trivedi wrote:
> Add a node for the TC9563 PCIe switch connected to PCIe. The switch
> has three downstream ports.Two embedded Ethernet devices are present
> on one of the downstream ports. All the ports present in the
> node represent the downstream ports and embedded endpoints.
> 
> Power to the TC9563 is supplied through two LDO regulators, which
> are on by default and are added as fixed regulators. TC9563 can be
> configured through I2C.

s/ports.Two/ports. Two/

Possibly subject doesn't need two uses of "PCIe".
