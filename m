Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C5B32AAC3
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769587334; cv=none; b=ntkgCvrXeU9xbzTQsxr9u9ut/eF4/tiYTajKH7PyiMwvel7jtOTxMrZ+HgnFl9anqacBMMhvZ6Qa9f1kmAhgnHOEmugHWC2ZqUhJQJ2Xp79JvsATUdBHhXFsVfRwX7KZpDjUXM+gepKYxGi8QVAdiQwMaMxSpZLvqDXXoDg/eks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769587334; c=relaxed/simple;
	bh=iLTJpk81I6aTlzG5t5/8iy+cSX2HrlvGd8AOn3KynAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8821qa+AwpOfgYB+NgzkF3q6OJeRMEg9oNhhQagvl6LJywx59fERVjHYl/8fVeV2S5O4FoLS9fdurTxguIe46ng8/MnZ8XEYvQKAXa1vE+RhPOHerS/tZzuJAzASXZC61ZBc5p7AlZMQ9TQLoj+SWlCoXXXbAzjyCIsqbty+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILJFncf+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILJFncf+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F13DC4CEF1;
	Wed, 28 Jan 2026 08:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769587334;
	bh=iLTJpk81I6aTlzG5t5/8iy+cSX2HrlvGd8AOn3KynAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILJFncf+8PAJVWcIhmcKleNTDN8VR0YigIXN+8nGYkm/jHc1otcXz4F25nYfQ3Xxz
	 9Dt7Jv+ll5b8K6DhL1Pxe6Jw+W7zsEiABk/c+yfiOK1zXXi/UlUYtrGJK/WvG/ZCQy
	 Qdtvsk6uQk0+huRV6JflJ51I3c21TUdT8mjsCYo3boKqanCX1CKWDQdpJ6f1KrfsSc
	 RFY11NSieoRXY59/fi4Heitka2AnxX8tPAOwRYLEIgY6nzOiQeSum+zesXzAzHQOeL
	 B29MhfL2at6/mG+LPF9Z2kl76Q6pAPXsJ8FE7WJcc+bFivFawhogHlVWr9b3a3uINu
	 vlMvefCW3Qblw==
Date: Wed, 28 Jan 2026 13:32:04 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Randolph Lin <randolph@andestech.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com, 
	dlemoal@kernel.org, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 0/3] PCI: dwc: Clean up iATU index mess
Message-ID: <zdxpiisnc4eq5a26dlaelchri3vu4aoyndy2pnif2rotbiyj72@c3hbnd3cwubz>
References: <20260127151038.1484881-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127151038.1484881-5-cassel@kernel.org>

On Tue, Jan 27, 2026 at 04:10:38PM +0100, Niklas Cassel wrote:
> This series tries to clean up the iATU index mess, by treating
> iATU indexing for outbound and inbound address translation in
> a consistent way (increment the index after assignment, and only
> if the function call succeeded).
> 

Series looks good to me. However, I'd prefer waiting for Maciej's testing before
merging.

- Mani

> 
> Changes since v4:
> -Squashed patch 1 and 2, as suggested by Damien.
> -Added Cc: stable+noautosel for the ECAM patch, such that stable
>  maintainers will see the dependency needed by this patch.
> 
> 
> Link to v4:
> https://lore.kernel.org/linux-pci/20260123182835.831710-6-cassel@kernel.org/
> 
> Link to v3:
> https://lore.kernel.org/linux-pci/20260123093208.593506-6-cassel@kernel.org/
> 
> Link to v2:
> https://lore.kernel.org/linux-pci/20260122222914.523238-6-cassel@kernel.org/
> 
> Link to v1:
> https://lore.kernel.org/linux-pci/20260122145411.453291-4-cassel@kernel.org/
> 
> 
> Krishna Chaitanya Chundru (1):
>   PCI: dwc: Fix missing iATU setup when ECAM is enabled
> 
> Niklas Cassel (2):
>   PCI: dwc: Fix msg_atu_index assignment
>   PCI: dwc: Clean up iATU index usage in dw_pcie_iatu_setup()
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 91 ++++++++++++-------
>  drivers/pci/controller/dwc/pcie-designware.c  |  6 ++
>  2 files changed, 62 insertions(+), 35 deletions(-)
> 
> 
> base-commit: 0ecd890e3cf54a0586247b9a384702703277e4fd
> -- 
> 2.52.0
> 

-- 
மணிவண்ணன் சதாசிவம்
