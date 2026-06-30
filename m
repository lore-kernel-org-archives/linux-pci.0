Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171EF2F549F;
	Tue, 30 Jun 2026 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827653; cv=none; b=ODOz+oN01ak0GItDPFW/OjYPAeogQw9hdUf/gjbtF+c7naE6Xy5mY7LNdE1f7cFHyJdkdZrolDz4lD6rudMOmjZBMYXKWw6iBF97ugEdXj0aGEHqlbMEWJuh9aWQtDEOicbaUhTVoOi9XS4os/7VVM/A0JgTFMb1JjPft3E1WqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827653; c=relaxed/simple;
	bh=NxVC72j41uPL+tI1Aj2Q6Xf57UFf9x2HMej7fgmMn5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THSnS+vuziKPy1ycHbrYFO2OSXh5msoJFGRS+inMtHrvTg4W7cxvX6Vxc1PRAnxnTbnKuURFTsBkwbab1uHyOno6dspJxMlMZUr94jmzz9PzUun/OMBHI2q7W+oV0wro0BqJHHVGGK694tKFSLe5BclFwm6Dx49f4VjsfHu1/3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxGtVFxE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxGtVFxE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0625D1F00A3A;
	Tue, 30 Jun 2026 13:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782827651;
	bh=ENHSujfSW+4v2CmIMIlvxia/sjQrFFZFjN+o8GUkyIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JxGtVFxEw8vaMhnYcCm+Cuq5e5W2cCsEJv7juEB5WY3jF7MEuDgDFV5eOxo+/XeFz
	 ZLv7D8eIpZCd2z14gLGNUzLnGi8UcT+WVI/A/UPlaNoZjtnWaZTRlQ0gPpMNZtmJGy
	 HgYnLXoRggBGE8lSDrlwb9eyJpsImD8KYjUl4uBOCEdq50OZ/hYpElxnGiXHM4vWaj
	 UEvTRTvJix5t2my6yHIsHifqnjUm2UUANKAyUUuWYfirY5u/XaBjYVhKgvFEm9azwP
	 EpgWQM6wMVAggjhqkSlZxs1mhWQq4DDPDhb2h6Ad3HjP0dhI3aTfZsQsFuctlD4MQO
	 2Rrxlpk9MOMcA==
Date: Tue, 30 Jun 2026 08:54:10 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-tegra@vger.kernel.org,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	devicetree@vger.kernel.org,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Aksh Garg <a-garg7@ti.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCH v7 1/4] dt-bindings: pci: Strictly distinguish C0 from
 C1-C5
Message-ID: <178282764964.2982344.701815323079264876.robh@kernel.org>
References: <20260617-tegra264-pcie-v7-0-eae7ae964629@nvidia.com>
 <20260617-tegra264-pcie-v7-1-eae7ae964629@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617-tegra264-pcie-v7-1-eae7ae964629@nvidia.com>


On Wed, 17 Jun 2026 18:01:28 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Instead of using the ECAM registers as the first entry, strictly make a
> distinction between C0 and C1-C5. This is needed because otherwise the
> unit address doesn't match the first "reg" entry. We also cannot change
> the ordering of these nodes to follow the ECAM addresses because that
> would put them outside of their "control bus" hierarchy since the ECAM
> address space is a global one outside of any of the control busses.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v7:
> - undo changes suggested by Sashiko, should've trust the dedicated tool
>   rather than the AI
> 
> Changes in v6:
> - add maxItems as suggested by Sashiko
> 
> Changes in v5:
> - rebase on top of v7.1-rc1, make it into a fix
> 
> Changes in v4:
> - ECAM is outside of the controller's region, so it cannot be the first
>   reg entry, otherwise we get warnings because it doesn't match the
>   unit-address, so revert back to oneOf construct
> 
> Changes in v2:
> - move ECAM region first and unify C0 vs. C1-C5
> - move unevaluatedProperties to right before the examples
> - add description to clarify the two types of controllers
> - add examples for C0 and C1-C5
> ---
>  .../bindings/pci/nvidia,tegra264-pcie.yaml         | 75 ++++++++++++++--------
>  1 file changed, 50 insertions(+), 25 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

