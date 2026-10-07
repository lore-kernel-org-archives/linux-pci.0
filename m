Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4EF3B05A7;
	Wed,  7 Oct 2026 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394753; cv=none; b=V/i3bW/fvafiOV/J1pCr37xR4DzXAj7mjs5gAwtxOUdcHLz9lW89YXHRPrv8te2xIiDuxo2M4e7DHahghUW59q7NyoMl57eencJSVxKx38eSNyZsVKx861Iy9Ggn5cbxp2sv5nqvsEJO+EFRvlbwPKuGM6RYC6qpGEM5+Dou34I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394753; c=relaxed/simple;
	bh=O/57xv8xoLkRWnqnHdElm1MmZ+p6nyiKXa3vcY+o/wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3Ab7FsJ4cffe+GMtkGXTrCltgxRbPGJOQltB1DPX0UaZ/3yi20TcK1oLcpnsxEP0exOXiR0uBcbqzVcSFyPTfA81jFd9XhXFnqTZGqImB2fYRygvDYkf8GM2prvwfGzMWCe+eqMAsflSIvN8thlI/Jfpu5W8FBPY9Sf6oAAmcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=tpizUNvP; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="tpizUNvP"
Received: from L30177.local (unknown [78.242.246.191])
	(Authenticated sender: vjardin@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 6F68C780371;
	Wed,  7 Oct 2026 19:38:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1791394749;
	bh=O/57xv8xoLkRWnqnHdElm1MmZ+p6nyiKXa3vcY+o/wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tpizUNvPtMKaEV4wbsM4GTgWFqsNqaTVu7N5L0esAWkEb+e5ReUKaWyb8H8YEr2cV
	 4zX97LdIRqgeQHy6I9etOl51HQDAz8g4F7Il8vnMlCqrwG2OLM/d4jNsxDJoDawAf9
	 vhBK+WmzR8lVlnjPHPrVR1/QX9UNnbT+Tqp5JfBmuHQ0oBVfQ39EkuxMZsnGPx+lc0
	 stFItnG0QDdJ2KYEoILf+D/8gyHD5co0NlQ74FZaWpcFf+xrGsVJpMwu2p73UjCTSj
	 uouTZgPP35jlREN1vVa+jQxJgUt8R1HiKEtRhqasJH59er3DPJnd4jKJofY0KQ/t3Q
	 pWq9tXUyZBiZQ==
Date: Wed, 7 Oct 2026 19:38:47 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
	Roy Zang <roy.zang@nxp.com>, Rob Herring <robh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: layerscape: async probe by default
Message-ID: <asaDp512mFdyCvXs@L30177.local>
References: <20260928-for-upstream-pci-layerscape-async-probe-v1-1-76412d887baa@free.fr>
 <arqSa0OwMd1Bx_Ex@SMW015318>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arqSa0OwMd1Bx_Ex@SMW015318>

Hi,

A gentle ping on this one lin paatch: is there anything else you'd need from me
to have it applied for v7.4 ?

It has the Frank Li's Reviewed-by, Sashiko found no issue, and it still
applies cleanly on the current pci/next from today.

  https://patchwork.kernel.org/project/linux-pci/patch/20260928-for-upstream-pci-layerscape-async-probe-v1-1-76412d887baa@free.fr/

Best regards,
  Vincent
