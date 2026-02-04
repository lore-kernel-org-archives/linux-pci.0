Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB859423165
	for <linux-pci@vger.kernel.org>; Wed,  4 Feb 2026 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770221104; cv=none; b=ZBOuUES8E6GZfbiqyqMb6j/z/ptKSdhS27Bqt3LI0uUUPSNbEDkMqt8njUT7gXfJBJ8SvPOZLKE9E/0tr5Hs1DSusmQoOD3ntCuXSpK+cq9Ex21bo8zN4HGnlZIxGOZqeOdthYxutBuwKCk0LMHD6soe5Bd4dpXU7Rtwr7tZVEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770221104; c=relaxed/simple;
	bh=XfplidQfOUx9FGMP0rdcSG1Ln6aKsKmiYfJOflATN28=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UbAspzlmLck54QpyyI4xuvs5IS2uRFsnFKmDTzkzOaVwGHKB3e+9oW7boO/KT9g2UDGWedodL78noA1z/MIiv8+5j4HiFQeLdvO6sb+QXhNlypck7F/dXyYm+8AyykzB0I23mK+2WD2dM7eNDmd5viwr0XiNuV5Qo9HkYTOdV3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 0B33192009E; Wed,  4 Feb 2026 17:05:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 044EC92009C;
	Wed,  4 Feb 2026 16:05:01 +0000 (GMT)
Date: Wed, 4 Feb 2026 16:05:01 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Niklas Cassel <cassel@kernel.org>
cc: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
    Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    Randolph Lin <randolph@andestech.com>, 
    Samuel Holland <samuel.holland@sifive.com>, Frank Li <Frank.Li@nxp.com>, 
    Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com, 
    Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
    dlemoal@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 2/3] PCI: dwc: Clean up iATU index usage in
 dw_pcie_iatu_setup()
In-Reply-To: <20260127151038.1484881-7-cassel@kernel.org>
Message-ID: <alpine.DEB.2.21.2602041604320.12532@angie.orcam.me.uk>
References: <20260127151038.1484881-5-cassel@kernel.org> <20260127151038.1484881-7-cassel@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 27 Jan 2026, Niklas Cassel wrote:

> Create two new variables ob_iatu_index and ib_iatu_index, which makes
> it more clear from the name itself that it is a zeroes based index,
> and only increment the index if the iATU configuration call succeeded.

Tested-by: Maciej W. Rozycki <macro@orcam.me.uk>

-- with SiFive FU740 RISC-V SoC onboard a HiFive Unmatched system.

  Maciej
