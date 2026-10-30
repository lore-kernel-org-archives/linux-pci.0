Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793360669;
	b=S7GqeanAMDSsIpWuWbAZTQy6l0NsoFV/SwZNlZYxwAYv5t9rNydu/D6RupPwofE9gA7m
	 s2CAlInjiGGChCLod2CfkaQugta/T6yD6U5bALNPlYgr7kgRItAAGwtP3g5mkXyapPQ8X
	 LfJaZWfely+/QbE9oJ2qIXIUptTEPFQdcOthd489yE8LsbLr8am2ecYDVGkXz+kA9LVBL
	 p7V3mTdyRMCbt6TBIz79x5DHQXMQAuvv4OQQ9bih8JN9dRLF5Du5UV26w9Y62sH1+VCWY
	 z6eAQUkTQEZTSaAVIwuBiz+56Lte6rMCWpH9GNsLRbjpeDsxt/8VjLGUdvTnWf8sNtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360669;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DpTDFSree3Cxk/D2Qxb1KtBNeieq6f1ZN5i6RF8Q5TM=;
	b=T2jkVHWK5h6t3qAHl/QGYsFMdZ2KOhC3RQZV3kk6JvGdLglJXH21QFaKR33AK2iZ7Iy9
	 DOPFEMQVR8yZuKcfWtGnTT99Rk+77xQmocF/Ur2dms6u+kD5Cgs9v01PBo1Ajoblxxzs5
	 Wv1fXx4sdHTa+S0BwSxIeERMX8W6B9SFIBKYxcPCeXBWva7dxMpYDlJw281n0vcfl8SFa
	 9U15gZOUn5tok+XG7YnaDb873lXMN67sHa5EnsX73X75D9RBDP8w2JsmM+RUcre9No6zc
	 eXFAu9GcvJmNwf9IMCXqxV2a20X1/Id5xxG6fMVgHsBEZixfQ+H6x5VZKOBa2so+7HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVQFq7eq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F020606A32D;
	Fri, 30 Oct 2026 11:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVQFq7eq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1C21F000C1;
	Fri, 30 Oct 2026 11:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793360669;
	bh=DpTDFSree3Cxk/D2Qxb1KtBNeieq6f1ZN5i6RF8Q5TM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OVQFq7eqKG529VBOc/jO+cib/pp2kbyG1EjsxMXt7na8IIN8Y14GWB1tIrUEFfEhl
	 gikZa5wkwtZm4XnNuXAzyjAHLYwZr14j9BBzWiRH7KqNgsrYd9N/ExkR2qIFjlms2P
	 wP5xZYRA1Zt3xo5/7wkRG+KkQMyil1rMKkoeCswuuyyx8WolJ2ajAH9yMyZa51m96/
	 n9s1r+jHtuZYP0CpHqwW/BxekParj4RbHycUsuAbwr/semsJrKEX29nJHQWLas2XLG
	 bgnrG2r6YqT580wVRdeDXjmzFC14L+kMFRfZyeQcyoik1NyYEqC47GujLyMkyDVs1o
	 CWnxQ38vFDZlQ==
Date: Fri, 30 Oct 2026 12:44:21 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/6] PCI: tegra264: Power endpoint devices before
 enumeration
Message-ID: <qlyd6q5o4ubkq23bn7xhgo2jmsfvhrzvp5fqvobq55ivzh4ie4@wbvvspjde25s>
References: <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
 <20261029-b4-t264-igpu-pci-v1-4-4d843dda0b02@nvidia.com>
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
In-Reply-To: <20261029-b4-t264-igpu-pci-v1-4-4d843dda0b02@nvidia.com>

On Thu, Oct 29, 2026 at 12:32:06PM +0900, Mikko Perttunen wrote:
> Add calls into the PCI pwrctrl framework to do required power sequencing
> for endpoint devices before attempting to enumerate them, and select
> PCI_PWRCTRL_GENERIC in Kconfig.
> 
> This is required for the integrated GB10B GPU on Tegra264 that requires
> a power domain to be enabled before it appears on the PCI bus.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
 
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
