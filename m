Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70D629E0E8;
	Tue, 20 Jan 2026 22:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768946683; cv=none; b=nn2Mh0/wzwQ2953iksCakPHvPb9xh81yoIuI7iDyPgdd06Ah4YpOKDWGceTnLYOSr0XI3E5P6vGD6nMQIY2ks5ZsNbcMuqirm3U7rNjLCUyaCPVwnekPisB1CTcdzsOITkhnRvTgGHiLUCWzpJKBz0f92LNY1wQv/NvMFI/xqXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768946683; c=relaxed/simple;
	bh=Ksd7axcgTS0Lavz7Iw2jFrS2gsUr2aSKtbp2LAryPmk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=C+AJRkTnLgYLbLJFMdBO0/7LB4nSsLsDhNSVVCzC3KffhNJnEOcDwawrRkzBRkclntXEV6TWJ80D0u70vnWSKOYKp2I8k/zw43S1PLnmMHX6W04x1XMC3j2GjGmNFCD9/YiOgeHLMy/ZIUf1jfpzl5X/fyCEbntiHmU1tnGpD/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laUvCro2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laUvCro2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF7FC16AAE;
	Tue, 20 Jan 2026 22:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768946682;
	bh=Ksd7axcgTS0Lavz7Iw2jFrS2gsUr2aSKtbp2LAryPmk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=laUvCro2hjtkpMTyGGJ9dHJXz8JR1c4XofHhT5wJf+CPN8Qo9/ULqHboEeChcQIrc
	 ZdxPuldd8oR/hlIMOVXWM0l15XGGzhvBYSlZ0tz4POx2KCuVpjZcTFXbsBvVqhWbUY
	 9SCowjOihAhnpzvVcDLNwDr5cOaisQeeQdOP0t5cOgWWwPHKo2IpM5FA9nBcf9JG4W
	 nN4u5A8aYkx5OleM2+2Rhcpt0mxqd2hfCW2dDzY3375uO5Gzf/7RjxcxvpZiiCxvYZ
	 hre4i0DyrOzTLJ8XFevDbrz7Ge0RLz5K9N8fXYTXbPShr0CFHVReq4My4QB8bpi7X2
	 ESpPrzrZXBhKA==
Date: Tue, 20 Jan 2026 16:04:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Frank Li <frank.li@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 08/11] PCI: dwc: Invoke post_init in
 dw_pcie_resume_noirq()
Message-ID: <20260120220441.GA1170239@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109152750.GA544801@bhelgaas>

On Fri, Jan 09, 2026 at 09:27:50AM -0600, Bjorn Helgaas wrote:
> ...

> The current commit log for this patch is this:
> 
>   Some SoCs like i.MX95 require enabling REFCLK after resuming from suspend
>   in their post_init callback. So invoke the callback at the end of
>   dw_pcie_resume_noirq() if available.
> 
> When .post_init() is called, the link is already up and PCIe devices
> have already been enumerated.  I think REFCLK is required for the link
> to come up, so it doesn't sound right to me that .post_init() would be
> *enabling* REFCLK.

This never got resolved.

https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc-imx6&id=199c18221622
says imx_pcie_host_post_init() enables REFCLK by applying the
IMX_PCIE_FLAG_8GT_ECN_ERR051586 workaround.

I don't think that commit log is correct.  Can you please supply some
correct text for that commit?

Bjorn
