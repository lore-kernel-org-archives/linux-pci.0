Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A77B238171;
	Wed,  4 Feb 2026 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770221633; cv=none; b=nk5bebffjZPNhOoNcEYTO89Zbgismq4HiCWGGpiiEhmRgCP8BEDHK864t3qFadnSRQp9y6lVsvdJAFolvBweUESqASluDBotf54RCs3vKGHwJbfs8GW3PYOcmjPaf8LPjFdh2hwHEkP+EBTF/aaM0XwedPPkNjznatuDSn0QamE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770221633; c=relaxed/simple;
	bh=3510jWJU6BaX1/NwPtwvhKUWAy8G/HuxQvk3XEutA2g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XZFNQtJCAeA+/BInyRhQAIs/X6MIiLhTSDXoQ+IeGBQDSBPZdSQMqneDAVYBbe4EsPzJKE2hRAGeBY+CTlqJBQbDJ89xkZIPvywQwPirOlu7VgzQQ6Pic1d84eHvmE+2itqMeiR9xqGCkIaNJyukBNJXnNMRDhpGxrEPn7TkVGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id EF97992009D; Wed,  4 Feb 2026 17:04:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id EC6CE92009C;
	Wed,  4 Feb 2026 16:04:26 +0000 (GMT)
Date: Wed, 4 Feb 2026 16:04:26 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Niklas Cassel <cassel@kernel.org>
cc: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
    Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    Frank Li <Frank.Li@nxp.com>, Randolph Lin <randolph@andestech.com>, 
    Samuel Holland <samuel.holland@sifive.com>, 
    Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com, 
    Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
    dlemoal@kernel.org, stable@vger.kernel.org, 
    Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 1/3] PCI: dwc: Fix msg_atu_index assignment
In-Reply-To: <20260127151038.1484881-6-cassel@kernel.org>
Message-ID: <alpine.DEB.2.21.2602041601380.12532@angie.orcam.me.uk>
References: <20260127151038.1484881-5-cassel@kernel.org> <20260127151038.1484881-6-cassel@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 27 Jan 2026, Niklas Cassel wrote:

> When dw_pcie_iatu_setup() configures outbound address translation for both
> type PCIE_ATU_TYPE_MEM and PCIE_ATU_TYPE_IO, the iATU index to use is
> incremented before calling dw_pcie_prog_outbound_atu().

Tested-by: Maciej W. Rozycki <macro@orcam.me.uk>

-- with SiFive FU740 RISC-V SoC onboard a HiFive Unmatched system.

  Maciej
