Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7973B47D0;
	Sat, 15 Aug 2026 06:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786776773; cv=none; b=hQSxPhHow3sn+FbmSPowllk9aQlDo53IcGK6mjEhixyWa0euzwe72uMfLqXn5/BmT200DB/NQKOQnMkAVeXgAEc8SIuRl8xcS/t7z+hPoI/JELcXDsqt5kRvdBjzJXKtHqaWHGUJ0VMT63GiShFr/RK8GrrTBQlSouaeWIok1qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786776773; c=relaxed/simple;
	bh=V5ekeGm3gZXioCGpp9BDcZOU97NAdz/a0OhwPto4mO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyAQb+Dv5GkoiLz6iLwpLNxe1FX6peltgKXQCQ/S/alHNSS7ruJx9ssnmWgXMJPE5q0iab2HYCHSAZWNBPmAKz7j97p4DjqhCIA4+b+d2JykU27MOXd12jatV6Jyxb5qTJcRkE0pM7HmVBHU9vr7+BrnQ8B+yByQH0gXFQWtE5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G82hCjGq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G82hCjGq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C401F000E9;
	Sat, 15 Aug 2026 06:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786776757;
	bh=SOO4PTBjIrBj1DLwftmnetVO7a1uDaMSF8dYKtQH0zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G82hCjGqOgxpxNBebL1MWeSdMBlWcWVqL6adEDg7CdG8GxfnpFKa0Q4r5rJSOQoDI
	 tfCV/pIkdlTK+zPm2hJeVxOlFAtH59aX78g+x6rUELzzlXjKHUxPXBMOI+zf/CxPcw
	 5C7iYHM4wKtugqDLvkWCvYLok8HC9ZAE7RSqFVpOVsd3DvFnPyJHLjQoG12b9Am1HY
	 YVAbcS6owau8a4cLSz5+nVR2PfcAZwa2u5MCRNvQgHGB+P4Ju1gCEeGyIovRCWbchk
	 GEIhhZM8nErP1gs4ipZ+s4Lx/n6/bDmF/VFW+WPlrjCnuxAR2ukGYZp9+UmLELA05V
	 RahRwOSEPQNbw==
Date: Sat, 15 Aug 2026 08:52:26 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, 
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Kevin Xie <kevin.xie@starfivetech.com>, Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>, 
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: Re: [PATCH v10 3/5] PCI: tegra: Add Tegra264 support
Message-ID: <ajpntb2f62mpevhofuv2mdpgsktzp6gwcvu2euka7qu2n3f7at@fp3q5fowyvgg>
References: <20260814-tegra264-pcie-v10-0-05d08c592b05@nvidia.com>
 <20260814-tegra264-pcie-v10-3-05d08c592b05@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260814-tegra264-pcie-v10-3-05d08c592b05@nvidia.com>

On Fri, Aug 14, 2026 at 05:38:57PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Add a driver for the PCIe controller found on NVIDIA Tegra264 SoCs. The
> driver is very small, with its main purpose being to set up the address
> translation registers and then creating a standard PCI host using ECAM.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

This s-o-b chain is cobbled.

1. If Thierry is the Author, and if Manikanda co-developed the patch, then there
should be a Co-developed-by tag for Manikanda.

2. If Manikanda is the author of this patch and if Thierry is just sending it
along, then the authorship belongs to Manikanda.

I've applied this patch based on (1):
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/tegra264&id=d56131f7a401841c09b6611402a8d2e795da3a6b

If that is not correct, please let me know, I'll ammend it.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
