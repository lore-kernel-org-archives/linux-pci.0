Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FC859B45;
	Fri,  5 Apr 2024 13:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324488; cv=none; b=TE2dVF8BLhqkGMEjl2gpv4jCQR2W3cE3DvqngYq1lEpGKX6GKrglNpWFCsdr0qRXj/mDCOg2nz55AIgcAbjQojvbHW8v056mdLF5SkOrrNZXtBXw9M23xQq4xCfcZZZJh/Ba27oREDGp8BURBiW8TMtfMrUyJRjHS3H0w8KPofc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324488; c=relaxed/simple;
	bh=V+Xyb/jwNJsEvKzPZ1fkCMpDaQQ/EP8zA4y0v+msi18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhvmxbW7sSScOfAyqu/tM31k4lEPgyAIfNdXW8ZUtK30hgFtXbkZLz1vmBkkEzUTJP+HM60e1G4oRM276ssKw6X1V17CKoiMhTck9M3Y6+Xz9U+ksaCq4hV8Pg84sPm/WSFDwI4Jg+qwKsAavNPGJnQqk/2195LG/b55nUtSOe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIFGpFry; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIFGpFry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55874C433F1;
	Fri,  5 Apr 2024 13:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712324488;
	bh=V+Xyb/jwNJsEvKzPZ1fkCMpDaQQ/EP8zA4y0v+msi18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KIFGpFrycHM2ymqjL7xxbKsG27dgV8+Smtj/IGt6XTZQ7czeCZrCXeSAYBRuRzTPn
	 bI2iQJpYxjeOrbPje0qIVYrmB25ug6nkSjocCpZBtYs130izvlkDakf8zR/lPG7+F2
	 azDH0tKNAUjyorDkKggL1WJJaWdHhIulBKXZ/Z1rPqpHWMcbfkSUdk7rpk7apy2Jj2
	 w5MCn5wbZKTPIwX7fkY4jfOZ251RvEYH9t9b9zML8m0o1e2BhGLEt0A1C0sTCpNBaV
	 vwTle62EpO36T68fkrzfeL9gcKn+pPWNzvax3cWigZQ5c2qS7PrgxQzHCR1gs57pPS
	 6w+QiZ64eVn4A==
Date: Fri, 5 Apr 2024 15:41:19 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v2 05/18] PCI: endpoint: test: Synchronously cancel
 command handler work
Message-ID: <Zg//fzGM0ptjMM8s@x1-carbon>
References: <20240330041928.1555578-1-dlemoal@kernel.org>
 <20240330041928.1555578-6-dlemoal@kernel.org>
 <20240403074702.GD25309@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403074702.GD25309@thinkpad>

On Wed, Apr 03, 2024 at 01:17:02PM +0530, Manivannan Sadhasivam wrote:
> On Sat, Mar 30, 2024 at 01:19:15PM +0900, Damien Le Moal wrote:
> > Replace the call to cancel_delayed_work() with a call to
> > cancel_delayed_work_sync() in pci_epf_test_unbind(). This ensures that
> > the command handler is really stopped when proceeding with dma and bar
> > cleanup.
> > 
> > Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> - Mani
> 
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
