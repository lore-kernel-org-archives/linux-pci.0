Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14ED3806B4;
	Fri, 25 Sep 2026 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349799; cv=none; b=TuE8xYUSrD53PaxV4x2o5skS3lylSuW7c0Kdyu2jaBb+BRSaauh0H5wUdorc4bqEIviIrTms6dv2Qij3Hg7lksBaEtjDiYEg+XyFsHoOHgZOMkC9+k6IEglUxavut4zusIdEsuhk2E8Pj5k8FEi6PI2FpdHfVkBuICVSYrkbURU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349799; c=relaxed/simple;
	bh=ReN7FsgkHBI9g2zt6Ovr+zXCaoMegpmQ13vEQe++uNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbXqgVr+iETquu7VpmLNap2Dd+ccfKB4gxAE6Ou3/0whPdJFYs1RbwWgsqKXHO9ALvr46GPsadHIlIHHPrFw6zeXBtxAGiDkN1zlzgBwfVZbj3/tiTq/gVaXify04MbSWfFnnw98iM43tX11eW8xSOFwDvpbxaCPLmZA/MqLxNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxJ7jdQG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxJ7jdQG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15BC1F000FF;
	Fri, 25 Sep 2026 15:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790349798;
	bh=kANBcDB93ekcXy8yI3BeOtertVshNaMZPmStPqf4cgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BxJ7jdQGXHEFCGpvRSvy6X4RbrF+w+/idYZYlZDWY3IkIj+8XU7+vaMNIs6u85Sqk
	 FApFK4LsozIcAJ+tR/cRE6YJIq1uhICKpnGhkPjS8IVw29P1NzYdQ8whr7zYFMT0ks
	 sDaEG3lTrtpiwXBQQfvDX3NOyUYF4K4mHR8ETlR1nubSnb3o9mcxYr9nNeWLJOIr8O
	 mh4ebSKnw4Eo2ucS4LcTM24aVBwJ1ckFYsZHpccQ6ldklagEpzPEcN30pLYIcfm9mq
	 VUaJkLylpyv4P+Cpk55tUgdqHoPOn29LhpZN4rlMFBrvyWroSqh/gXNFhCqwq/CVKD
	 lCKuI3wxtk15g==
Date: Fri, 25 Sep 2026 17:23:02 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	shengchao.guo@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 5/6] phy: qcom: qmp-pcie: Refactor common multiphy
 handling
Message-ID: <kcatb2mcwqb64lk5afcq7dfn5mxmzd4d4ertblsryjilv373hb@ivbibuq7byma>
References: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
 <20260921-nord-v4-5-ed05c6e09240@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260921-nord-v4-5-ed05c6e09240@oss.qualcomm.com>

On Mon, Sep 21, 2026 at 11:07:13AM +0530, Krishna Chaitanya Chundru wrote:
> Reuse the existing port resource arrays for Glymur register regions,
> power domains, and NOCSR resets instead of maintaining duplicate
> Glymur-specific lists.
> 
> Attach each PHY instance's power domains to the device created for that
> PHY. This ensures that the associated GDSCs are managed with the
> lifetime of the individual PHY device rather than the parent multiphy
> platform device.
> 
> Validate the clock-output-names property before using its count for
> allocation, and use a generic module description.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
