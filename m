Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35DC3A7F50;
	Tue, 30 Jun 2026 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847358; cv=none; b=avVPFN0guvUgTG3fnfGqcPgaCOqBMwXsnfnzD/VhwhDYleNisyuQ9ML74mDuhO4k8jrBxjyIvXyo/kQm3I+Okr3Y0ne6m5BrVuPbTuhN/WmXxnuzbp4VlxT9VC4IqSoKdKcTCVos7Mg2g/C1KYl3VCT5h8sR4XCfyQEM298LkZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847358; c=relaxed/simple;
	bh=8BJ4FLb4iY9Yx8V0ZL2/VtDwLa9LTvH8Am7OoD3eWJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R1AhzOEagn1qztixxeh8sTM4Q6h1hi6MmQsbnDfqC/p8Tz63QSAXpBSAI6z8iV0yXtTRTXOX42ZolATT9WB4tBajeXfZBjOZPGY8Wp2Gi3F2kcUx/Ls97ExkbzhbJaGMDdBrzma7XBCWFq1XrjgJzkO3H96n5fbBAI497G+qwzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nz0M/7vs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nz0M/7vs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF2C1F00A3A;
	Tue, 30 Jun 2026 19:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782847357;
	bh=93+khCzYAxSuZ6LAEDHQmhDcBOzCoIbxXWmUh6yplEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=nz0M/7vsVhwb0KqueOLLKIaOEdw/r77pfoDWR/QRvJRlF9Lso4B/URWwYHVsWxXOm
	 p95jCHvlo9k0RPeP+2NDP8OI7dIj6TZ3N3zQ50um+qzPLwwW/vo/AG5yzelDF6w8bM
	 YunrhVD746DO8HyOajx7JbmLqf+UhrtZAn+x0yNjwbc6fVeWnC85AhRcN1CsYiSb00
	 391uAs5DSybPVvI+QoxOGett5drXd63ntnXxZXSGB1Ydh2pgQl4BHwYJaencGZlKiU
	 EkLbIxout9q3KhhqryruTvRLvi3wKtROK1N+RXQQEYqBROFN1aBM+FKC+8nH0yMkty
	 sMRHi/HqTj2yA==
Date: Tue, 30 Jun 2026 14:22:36 -0500
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
Subject: Re: [PATCH 3/9] dt-bindings: PCI: Add bindings for endpoint gpios
Message-ID: <20260630192236.GA222338@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701-shikra-upstream-v1-3-e1a721eb8943@oss.qualcomm.com>

On Wed, Jul 01, 2026 at 12:32:45AM +0530, Sushrut Shree Trivedi wrote:
> Add devicetree bindings for TC9563 GPIO's which are
> used to control endpoint power and reset.

Include context in subject line.  Regrettably, previous commits to
toshiba,tc9563.yaml don't include that either, but I think something
like this would be good:

  dt-bindings: PCI: toshiba,tc9563: Add endpoint GPIO bindings

s/GPIO's/GPIOs/

Wrap to fill 75 columns.
