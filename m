Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C39248886;
	Wed, 25 Feb 2026 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772043391; cv=none; b=MPvGHJsU/W6EPTaaI/GVGxKS+hmlPNgREPe5Rkqgvheo332KZ+WPkBlLq94jxSDItEQhFEfxBdIbJk/q/T52Vl0lc0xNpNhuIBsHFUEBJ4et7RTf3gg4BoOzU0tL/lfhV08wIeoMowMBEPASct6NE2PcHJzIIiCmkDuTK9pqT84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772043391; c=relaxed/simple;
	bh=H3+gaRTUetNdz8V6pycFxyvTZ3xqU0RFjO73I1/4kwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBH7ZLnAEsll2gRYA97EidQsI3KIHqqL143hqCO8j4ZwXzgECmRVadB6dKRZYkeyCvnYEfYW9nHqHdUMriIPGPO/CZG43J8ESaZqYBo2PKuyw2d2T3KXGCmTsaRmP9vBybuYCHyT10JYQqQDa01eM8yYi8vB0XsSBdwNsiZ+IlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFXxthqe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFXxthqe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EB0C116D0;
	Wed, 25 Feb 2026 18:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772043391;
	bh=H3+gaRTUetNdz8V6pycFxyvTZ3xqU0RFjO73I1/4kwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sFXxthqeiJf+ZnT2LFgxFZV0X2ODVrdAExu6h48HlSvkN0QRV8qOxtwf2Il4yZNDp
	 Lbpmeu+42/3uLGmekogpVOjsA0NWkCTalwLChyrIqoQeqrsgy8X+Vta21rhOYVvV7y
	 mdqcc54S1AtiDj2N3/0quboB7k3v9E0h2kNYxNivszMfWghgmKALEjr12d9nOhDfjy
	 WCnBUQM9BPH4HKTX1Gm+fVTzt1miuamBCXKgjj8K/hHPvB0wDCuqXQRjChAZHr8Bmu
	 NhnJJtwdyuRdnZWlbBW6Nv2cS5fqlwd6z8u50+4smWuleEwkKuTGRg0xYycRa6eOEi
	 liLdY/ObiXyTQ==
Date: Wed, 25 Feb 2026 19:16:24 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
	kishon@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	Frank.Li@nxp.com, den@valinux.co.jp, hongxing.zhu@nxp.com,
	jingoohan1@gmail.com, vidyas@nvidia.com, 18255117159@163.com,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] misc: pci_endpoint_test: Add Tegra194 and Tegra234
 device table entries
Message-ID: <aZ88eNfiiMD8a7Gr@ryzen>
References: <20260222193456.2460963-1-mmaddireddy@nvidia.com>
 <20260222193456.2460963-5-mmaddireddy@nvidia.com>
 <aZ84XkM3RzJLCIYX@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ84XkM3RzJLCIYX@ryzen>

On Wed, Feb 25, 2026 at 06:59:02PM +0100, Niklas Cassel wrote:
> On Mon, Feb 23, 2026 at 01:04:56AM +0530, Manikanta Maddireddy wrote:
> > Add PCI device IDs and test data for Tegra194 (0x1ad4) and Tegra234
> > (0x229b) endpoints so pci_endpoint_test can bind and run on these
> > controllers (64K BAR alignment).
> > 
> > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > ---
> >  drivers/misc/pci_endpoint_test.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > index f166b6fea698..43545dbad26f 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -106,6 +106,9 @@
> >  
> >  #define PCI_DEVICE_ID_ROCKCHIP_RK3588		0x3588
> >  
> > +#define PCI_DEVICE_ID_NVIDIA_TEGRA194_EP	0x1ad4
> > +#define PCI_DEVICE_ID_NVIDIA_TEGRA234_EP	0x229b
> > +
> >  static DEFINE_IDA(pci_endpoint_test_ida);
> >  
> >  #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
> > @@ -1202,6 +1205,10 @@ static const struct pci_endpoint_test_data rk3588_data = {
> >  	.alignment = SZ_64K,
> >  };
> >  
> > +static const struct pci_endpoint_test_data tegra_ep_data = {
> > +	.alignment = SZ_64K,
> > +};
> 
> An explcit .alignment is not needed anymore, it was only needed before we
> introduced capabilities. New entries should be added without an explicit
> alignment, since it will be provided by the capabilties register.

Sorry, small clarification:
Allocating extra large buffers on the host side (.alignment) is not needed
anymore, since pci-epf-test (the endpoint side) nowadays can do unaligned
accesses using pci_epc_mem_map()/unmap().

See:
ce1dfe6d3289 ("PCI: endpoint: Introduce pci_epc_mem_map()/unmap()")
08cac1006bfc ("PCI: endpoint: test: Use pci_epc_mem_map/unmap()")
8a02612f8566 ("PCI: endpoint: pci-epf-test: Add support for capabilities")


Kind regards,
Niklas
