Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8429317B43F;
	Sat,  2 May 2026 19:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777751249; cv=none; b=CIGAE8dTdmah26ftRlc1n7Pde6WIRX7HDObYfoxw47yw7CEU6I/3nBYUVXl+M9gtZDr27PfmbnrvfnkIsUoToO9s9cS+q5SY9l2mD9ryEnHoY4m1vNmnRpBk+kkh/mcEbQGqITR9112vd0oE7ImXzr3x4l3ff902Y+geEzbY278=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777751249; c=relaxed/simple;
	bh=RidMpHcPzz2n7kv4mCsdJULr7f4Z4t7Ti5cDaR0/2fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlIo42TI+0jfRqiGTiTq+AYrtQ6SV77OUZFu4f5umaiAXg3ZNOKzd3wCAnshXSa8tkga8hgceYV2d6bYIfeDemjBtiM0sc9kxhlqep3QSeIKNPmOllEYjRRr6Ug5OLh8mraIZdxhUaqdo/VeLAN+UZTV0HnJSz5R9XKWRpkKOBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 97365C1D;
	Sat, 02 May 2026 21:47:17 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 5975B600D3D5; Sat,  2 May 2026 21:47:17 +0200 (CEST)
Date: Sat, 2 May 2026 21:47:17 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Han Gao <gaohan@iscas.ac.cn>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kees Cook <kees@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
	linux-pci@vger.kernel.org, sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Han Gao <rabenda.cn@gmail.com>, Inochi Amaoto <inochiama@gmail.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <me@ziyao.cc>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Add quirk to disable PCIe port services on
 Sophgo SG2042
Message-ID: <afZUxYhkCQ0wG0Uu@wunner.de>
References: <20260331175658.1015829-1-gaohan@iscas.ac.cn>
 <20260331175658.1015829-3-gaohan@iscas.ac.cn>
 <q6wmn67lzk5c2pgmgkoezcvy3xj3yqecg675gx7xyrw3amjwpi@5pjla6j3krbv>
 <0f42afefd9322779af5463b696c55b08d2296ea8.camel@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f42afefd9322779af5463b696c55b08d2296ea8.camel@iscas.ac.cn>

On Sat, May 02, 2026 at 09:58:04PM +0800, Icenowy Zheng wrote:
> The problem is that the MSI controller has only 16 MSIs usable (it's
> wrongly described as 32 previously, a fix to this is pending[1]), and
> the failing device have an onboard PCIe switch, which created many PCIe
> ports (and corresponding pcieport devices).

Is the SG2042 only used in that single product?  If it is used in other
products which do not have an on-board PCIe switch, why do you want to
disable MSIs on those other products as well?

My point is, you want to constrain this to a specific product, not to
the SoC.  Can you maybe solve this by not specifying interrupts in the
devicetree for the PCIe switch?

> With pcieport devices activated, 11 MSIs are requested by the pcieport
> drivers -- 3 SoC PCIe ports and 8 switch downstream ports. Then only 5
> MSIs are available, but there're still 10 downstream-facing PCIe ports
> now (and 5 of them are hardwired to onboard peripherals).

pcieport can make do with a single MSI vector because all port services
support a shared interrupt.  But I assume your point is that this
particular product has so many PCIe ports that you're still close
to the 16 MSIs limit?

Thanks,

Lukas
