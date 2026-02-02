Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB6815C158
	for <linux-pci@vger.kernel.org>; Mon,  2 Feb 2026 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770036442; cv=none; b=X0LUYsgbjq9YuJdhvFhDzrqcoreIE3YSNj4URTw2ZOiOtaL6LkX3n63w8IDeHHGZ0C490eF3FqdM1i9W1FUwN45IOiQOg6PTO9+3Cw+PoOKdO3iOCN2Z4WkuQdDBcv/lBmig8vl5zJGvmkIpPjoQOvNZwXVLxmGOn36nigj0GBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770036442; c=relaxed/simple;
	bh=SlalppItq7Kr0lE/TcLB1OUJUjyh4fVf1xQjZE8cDAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyfT1G9vvyh8tafW/AjyFKs1+rlcNEXRK+7W6q1mupNl3H+uriPm44wEKDTcondon/DG1gwAhQSATjIePem2Scobkf28xFk9W7cBitiCD0CZzMbtFi+29d2dD6ISlieSAAlH6nxVTuS9TvSKr7ijnltho0MweAyTFBoq4FESE8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmXrcYoN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmXrcYoN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C618DC116C6;
	Mon,  2 Feb 2026 12:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770036441;
	bh=SlalppItq7Kr0lE/TcLB1OUJUjyh4fVf1xQjZE8cDAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WmXrcYoNwUzipm7qk+XNNnbsbN6Be0fswNXJkvlkHIN1ABXJcrCR8RoARv/+c9ZWE
	 ljoMjOYCOs6bbQLaiSqbYLk8ykcJsT4nfNEfIlj5gZqnUWSrFEAQrEdHAdsGXKkZFN
	 075nzIKN5Qx40kzLbLcFoiR/Gy0rwwzqJbu1PzG7C82Mup01hTwhWXdbxcocY3wc7K
	 slfTiTDeFmGWCxsV2Mc+cypzq62aCJsUdMAKRvFfOrYReBGyGGfF1ZoyorFTHlagK6
	 /4NAu7di0l2mX3mZkYY80nxXBYePMX0FzbPBonH3mkHYw3L3z4AJK2pZVKMC3S58YI
	 dqUzeDe6NMosw==
Date: Mon, 2 Feb 2026 13:47:16 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Randolph Lin <randolph@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com,
	dlemoal@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 0/3] PCI: dwc: Clean up iATU index mess
Message-ID: <aYCc1GpSr4k2HdHJ@ryzen>
References: <20260127151038.1484881-5-cassel@kernel.org>
 <zdxpiisnc4eq5a26dlaelchri3vu4aoyndy2pnif2rotbiyj72@c3hbnd3cwubz>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zdxpiisnc4eq5a26dlaelchri3vu4aoyndy2pnif2rotbiyj72@c3hbnd3cwubz>

On Wed, Jan 28, 2026 at 01:32:04PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Jan 27, 2026 at 04:10:38PM +0100, Niklas Cassel wrote:
> > This series tries to clean up the iATU index mess, by treating
> > iATU indexing for outbound and inbound address translation in
> > a consistent way (increment the index after assignment, and only
> > if the function call succeeded).
> > 
> 
> Series looks good to me. However, I'd prefer waiting for Maciej's testing before
> merging.

Maciej,

Any chance to get a Tested-by?

6.19-rc8 is already out.

Even if they are fixes, it would be nice if it they could make it for 7.0.


Kind regards,
Niklas
