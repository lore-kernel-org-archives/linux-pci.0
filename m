Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369CA37D10D;
	Tue, 31 Mar 2026 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774983494; cv=none; b=ZwyD9RUSYEibj/rjAgD2Q9ryMbWlOwDGwzRUqnf+E4zezY6YGZ2IDlKyjJySAbt5c+poM03MZe28kI1/uniTKILpN8IbAB+M7KJHeBeKUrlBSmNnOAiPwnXVLTVeLT0NeT+93JLxo7ulmswKcuyAODXWQW0ptVDUV3cYUmZngWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774983494; c=relaxed/simple;
	bh=R9tENQJj5RpB7yiX+vDr+ilXcYesSJp5Vks3izvT3Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ki7BnU05Dl0m9uKsHxAxhNaVs2DK01DmcME9oRlM5cc+MKtPj6yFCieX6Prxb/GlsoWR1umrwPaPJREPx9VZpELdQ64PtUbVewjRaiTQkkONfEC69lqMQ1JS8iK3UzsgnCYcCyui/FPy8bPA6vT9FGQtrBONWk29q81RLw8s4xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 28B51361;
	Tue, 31 Mar 2026 20:58:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 16AC560293F2; Tue, 31 Mar 2026 20:58:03 +0200 (CEST)
Date: Tue, 31 Mar 2026 20:58:03 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Han Gao <gaohan@iscas.ac.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kees Cook <kees@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <zhengxingda@iscas.ac.cn>,
	Inochi Amaoto <inochiama@gmail.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH 0/2] PCI: Allow disabling port services on broken root
 ports
Message-ID: <acwZOxbEJoAJrvGb@wunner.de>
References: <20260331175658.1015829-1-gaohan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331175658.1015829-1-gaohan@iscas.ac.cn>

On Wed, Apr 01, 2026 at 01:56:56AM +0800, Han Gao wrote:
> SG2042's PCIe root ports only support MSI, not MSI-X. The MSI
> controller provides only 32 vectors shared across all devices behind
> each root port. When native port services claim vectors from this
> limited pool, downstream devices are starved of interrupts, resulting
> in zero interrupts delivered and driver timeouts (e.g. amdgpu fence
> fallback timer expired on all rings).

Have you considered setting the pci_dev::no_msi flag on the Root Ports
to force them to use INTx interrupts instead of MSI?  That would seem
like a cleaner solution.  There are already several devices for which
the flag is set in drivers/pci/quirks.c, see quirk_no_msi().

> Some PCIe root ports break MSI delivery to downstream devices when
> native port services (AER, PME, bwctrl, etc.) are active. The existing
> pcie_ports=compat kernel parameter works around this globally, but
> affects all ports on the system.
> 
> This series adds a per-device mechanism to skip port service probing:
>   1. Introduce PCI_DEV_FLAGS_NO_PORT_SERVICES flag and wire it into
>      the PCIe port driver
>   2. Apply it via quirk to Sophgo SG2042 root ports [1f1c:2042], which
>      fail to deliver MSI interrupts when port services are enabled

I think we should try to minimize such workarounds or at least make them
as non-intrusive as possible, so please try the no_msi approach instead.

I also don't see why the stable designation is needed TBH.

Thanks,

Lukas
