Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD8D286A4
	for <linux-pci@vger.kernel.org>; Wed,  4 Feb 2026 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770221145; cv=none; b=YP3hXDE0nyZr9gFapKFwDnRx/zD9FdiLO+hHm34j+ZvERH/R/eekz8aGkAzeGpIaWwWfwPUyLpguDO3gkHNnm072r8V/OUlpxKBNQwIvgpxz4NsH25oP+lNhjgOGAzHes46JQ5ydkRsNSiHD6U4yXrtrG9EQeRoXO1B5Faw33Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770221145; c=relaxed/simple;
	bh=NuD3ADZp/5bkWy0gHpIg8R5nsKyr4DQ5aTmn9RFFLgk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UIZ4a0ajaqwFoxJF+CWkRwggGnBqs5nAoQCDd80wx76/jqmBCJC2cdVUV8Jp2ULS40QVeERT+nPGjfDdvqYYvsdM92+PdgdfPLrW+kBGHFqRsZSF2ij4u7edP943S2/ZuO/fZlAyihmCQOnuIyDg8R2aw9trtquBG4YDpm2UkaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 786919200B3; Wed,  4 Feb 2026 17:05:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 7457D92009C;
	Wed,  4 Feb 2026 16:05:43 +0000 (GMT)
Date: Wed, 4 Feb 2026 16:05:43 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Niklas Cassel <cassel@kernel.org>
cc: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
    Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
    Randolph Lin <randolph@andestech.com>, 
    Samuel Holland <samuel.holland@sifive.com>, Frank Li <Frank.Li@nxp.com>, 
    Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com, 
    dlemoal@kernel.org, stable+noautosel@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 3/3] PCI: dwc: Fix missing iATU setup when ECAM is
 enabled
In-Reply-To: <20260127151038.1484881-8-cassel@kernel.org>
Message-ID: <alpine.DEB.2.21.2602041605130.12532@angie.orcam.me.uk>
References: <20260127151038.1484881-5-cassel@kernel.org> <20260127151038.1484881-8-cassel@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 27 Jan 2026, Niklas Cassel wrote:

> To resolve these issues, the ECAM iATU configuration is moved into
> dw_pcie_iatu_setup(), and dw_pcie_iatu_setup() is invoked when ECAM is
> enabled.

Tested-by: Maciej W. Rozycki <macro@orcam.me.uk>

-- with SiFive FU740 RISC-V SoC onboard a HiFive Unmatched system.

  Maciej
