Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42439466AEC;
	Wed, 22 Jul 2026 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738691; cv=none; b=pbtx7+kgI3Fk2iekdsSkDN96SwDMzWQEJWFp1aKbTOLtZGx6hjj6qNAxn5gF+dK9BgCsiAcSHLXLIeAndbEg7yn0GtGw7U1ZB6dr5NgAbPFXXDJsZz2lvZRsUU14VpcDbQfL91rFL68FyPg7kqFYoeqeze/xVwbgLALzbsrNZPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738691; c=relaxed/simple;
	bh=cD/qDXqn7t3SNaRLZcAKutYl+gV2fE2dSuv7RQVm/X0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sONeM8G8oabaOkoeobFhfOHDjg6h2UUl+boINuSh+0dMR+BOUWPPpm2C7MF6Z+RX78YW54dJGn4yEuxN2zrCLSPEhD2ZeRntRdfV7JLB3BCuzboSCOWy0m+9REZ69XSjLumf1jN2R96Tf2igemQ48115P/anVdCYWf0itYtfRa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVHw4FJ8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVHw4FJ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5E91F000E9;
	Wed, 22 Jul 2026 16:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784738683;
	bh=8G4blgcZphXiC5BXNXULNi1/KsmrDWO8yQMPeL7wdUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=MVHw4FJ83+OxlV4XAR180oMC8CBNtKJgBX/aWLiOB4zHtUJsJAu6zosfPHl1+mJH7
	 H2CEUBVtYHZqnygyNVKrWWYnQxMAgnfV3SSfi+EDntXv0YGiDmTVVZLf+w27tXfv72
	 GadQfdXJCrKLBkCrMVHTYQlnU4DJyii6fZ4etmnc4kTiJ2T37y9gMRTp+btvC7z13P
	 9AtV1GflF5xxk1NvFpcsrncULkBqr7gaJspKXWeI9zYluWuXjcQbs0LNLZGvrzLeeE
	 2NhhBtEZzkBmbEfm20AxK5CstZ+YBHSsTedXcWl4dPdxZ7k7s0VF+JNN/xd107CGLb
	 4/Sm1CDdP9aBQ==
Date: Wed, 22 Jul 2026 11:44:42 -0500
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
	Thierry Reding <treding@nvidia.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: Re: [PATCH v8 4/6] PCI: tegra: Add Tegra264 support
Message-ID: <20260722164442.GA742885@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-tegra264-pcie-v8-4-23e51589229b@nvidia.com>

On Thu, Jul 16, 2026 at 07:07:15PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Add a driver for the PCIe controller found on NVIDIA Tegra264 SoCs. The
> driver is very small, with its main purpose being to set up the address
> translation registers and then creating a standard PCI host using ECAM.
> ...

> + * The various memory regions used by the controller (I/O, memory, ECAM) are
> + * set up during early boot and have hardware-level protections in place. If
> + * the DT ranges don't match what's been setup, the controller won't be able
> + * to write the address endpoints properly, so make sure to validate that DT
> + * and firmware programming agree on these ranges.
> + */
> +static bool tegra264_pcie_check_ranges(struct platform_device *pdev)

Drive-by comment: I have a bit of an aversion to boolean functions
named "check" because "check" is not a predicate with a true/false or
yes/no answer.

"true" usually means success, which is the opposite of functions that
return 0 for success.

In this case, it looks like "if (tegra264_pcie_check_ranges())" means
the DT ranges match the hardware configuration.  If it were named
"tegra264_pcie_valid_ranges()" or similar, an "if" test like that
would read better.
