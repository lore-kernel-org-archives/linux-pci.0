Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C772364EB0;
	Tue, 30 Jun 2026 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782850438; cv=none; b=uRAdBhnKvLVyN89tpO/eRqAmcWlkJdb+elzb3XnslRgQ9veVGYQq7NsFaPs82/F0cOzUl0NLVg57CZiAQYlXzIce6dwYfHMY0wFT9URgZ6b8pwjQrDLEE1OXG4g3lZ9hJAayfoDml90uHH4A7Cb1GAlEEjp150aM+trwrkdONOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782850438; c=relaxed/simple;
	bh=f8QDbkAksamBomFoeUhrLyS2qHFemLsXIetHLlXjnKk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=U11McoOB8bFXvNu1jtQ/JAHllBG8BnrdyisZ08C5WJMChu3A5reK+D6j8owBjiTTe/D7FMQciPUEhb8ha+H0CFNPEBwTThXGNccCzc4HqwquMxoZk2ANvDWWVZ+KVZhTYUUMIAgIxa598U9JcnfubXugzEM7/eUrEyd7rgha9Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhIeJz3J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhIeJz3J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725461F000E9;
	Tue, 30 Jun 2026 20:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782850436;
	bh=PZYf4Vwez8GJq9I3WvAYOkbLhk26eGFt/+e8TLUuyHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=lhIeJz3JM3MkT3jBMvoqFKIRXj5FP1wYrEj3ZP7Vrox3COPzDuXJ3H2ApcqemT6C5
	 slYah7vEgTxLHPww06byXICKKx6ktkXyNpJ6tLQQyWs5Om/6FC1xuo4AUWTLr36eR6
	 aizxrASoQDiTyzlnpi+zJWBplWpp2cQl5KqVCrF75ZrkJ3ecD8EyEYmszYrCQ6g0jz
	 P7CNaQFyBKvv6frhy2SfwOKi1YzanVJLE0GMsL2JAENxq4vOjCQXOrBsE8xOFBRRy+
	 POjUiwzfWlRiaIjwr5E/X8/vn8e1EcHCdmv2Hgz7qnYKHw0xGmGD2+QIQQ7mdR9iki
	 n/rXaVx23zhhQ==
Date: Tue, 30 Jun 2026 15:13:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Kevin Xie <kevin.xie@starfivetech.com>, Aksh Garg <a-garg7@ti.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v7 1/4] dt-bindings: pci: Strictly distinguish C0 from
 C1-C5
Message-ID: <20260630201355.GA233513@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617-tegra264-pcie-v7-1-eae7ae964629@nvidia.com>

On Wed, Jun 17, 2026 at 06:01:28PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Instead of using the ECAM registers as the first entry, strictly make a
> distinction between C0 and C1-C5. This is needed because otherwise the
> unit address doesn't match the first "reg" entry. We also cannot change
> the ordering of these nodes to follow the ECAM addresses because that
> would put them outside of their "control bus" hierarchy since the ECAM
> address space is a global one outside of any of the control busses.

Can you make the subject line a little more specific?  Something like:

  dt-bindings: PCI: tegra264: Strictly ...

would match the history of
Documentation/devicetree/bindings/pci/nvidia*

We can do while merging if there's no v8.
