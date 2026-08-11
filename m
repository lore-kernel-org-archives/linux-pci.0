Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B0930566B;
	Tue, 11 Aug 2026 21:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786484943; cv=none; b=QhrGwYG7pR28rE6GekzHCCSkmgZ2iIkfOtwxNzx9TVoSbp/s2TdouhvzELX/loGGT1FYICUHrAAoSwVsq3AlLu29l+OQMOKa1Ev0Jv+Sk8k0ZY8UP24YxpxMmVR2gH4jMs4yjQP8JLRHuKFeLsf3gBzLs6rQf+6+HYBbrdQBi3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786484943; c=relaxed/simple;
	bh=uKQMt6+SE2ZF5aqnMiLFGwt0Tm8Sg7up0mLVgeB2w5c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b5UlQbBw5I21k7FRGD1OJxHB4EpPqg1MaAyGcO/G3Bx6M0f58q+ZquohZoJ2ujeq2rMYqknXy1Yct2c6XHXoAMasMhuwXYtk+WNFNHLcTX+I1W45Q4zQeiAIAJOoFY7XqxxhHkI7gRaX+RSU8cum8eFvlFCBqsPqxt966DaBl20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwEC3WWH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwEC3WWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209A71F000E9;
	Tue, 11 Aug 2026 21:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786484942;
	bh=B0X6XgAAAhF113rxevrEnj0y6G30X+VD38KOAafz1OM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=lwEC3WWHEQGp0yk5pVCvSu2dvNiQss7sYpsE3idAKf0KzdjtaDZWhYvKYqw8nLF0P
	 QEyD6V6EofaEHC/iNXhyKxA7T3YVu5pjcc1WUX311W3d8AW75Mtjhg11vL0CX2mTUj
	 ngGaB9jWe3sL2m9mCs0xf1ch80+mYKMfLs5e1p0/kK7QjM6cYeFCLqaQKmVtwLmObv
	 l84skZmivfPK0UZYK1DtX75+sygQ9UWLjG6muqhNuO72EvwUWdg8snaGtm4TjliBfA
	 WVZpNLFnn4v8qmYKu1B/FINCQqE7giW3hsPjL+R4zxMai/rMe5Tmb3aq0nJJ0gOC83
	 z1FXacHYaWRAw==
Date: Tue, 11 Aug 2026 16:49:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leonardo Costa <leoreis.costa@gmail.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, Frank.Li@nxp.com, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	regressions@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, leonardo.costa@toradex.com,
	francesco@dolcini.it, Sherry Sun <sherry.sun@nxp.com>
Subject: Re: [REGRESSION] mainline/master: PCI link creation fails on Apalis
 iMX6
Message-ID: <20260811214900.GA763236@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bl7i3obu2clzsgeoct2a4mtfhv6typcjdqmgneropf3hpgwve6@n2m5uhlduw57>

[+cc Sherry]

On Mon, Aug 10, 2026 at 02:54:45PM -0300, Leonardo Costa wrote:
> Hello,
> 
> We are seeing a regression on Apalis iMX6 where connected PCI device
> links fail to come up at initialization, as shown below. The issue is
> not on the devices' physical connection, as they worked properly on v7.1
> and are working on other stable kernel versions.
> 
>     [    0.154243] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 ranges:
>     [    0.154400] imx6q-pcie 1ffc000.pcie:       IO 0x0001f80000..0x0001f8ffff -> 0x0000000000
>     [    0.154439] imx6q-pcie 1ffc000.pcie:      MEM 0x0001000000..0x0001efffff -> 0x0001000000
>     [    0.154553] imx6q-pcie 1ffc000.pcie: config reg[1] 0x01f00000 == cpu 0x01f00000
>     [    0.356072] imx6q-pcie 1ffc000.pcie: iATU: unroll F, 4 ob, 4 ib, align 64K, limit 4G
>     [    0.356181] imx6q-pcie 1ffc000.pcie: Link: Only Gen1 is enabled
>     [    1.364757] imx6q-pcie 1ffc000.pcie: Link failed to come up. LTSSM: POLL_CONFIG
>     [    1.365056] imx6q-pcie 1ffc000.pcie: probe with driver imx6q-pcie failed with error -110
> 
> Complete logs: https://paste.debian.net/hidden/f08cdf68
> 
> This may have been caused by commit [1], which was introduced to solve
> an issue where the Apalis iMX6 module wasn't booting, and this second
> regression went unnoticed since then.
> 
> Is it possible for all PCI changes to be reverted back to how they were
> in v7.1 before the next release?

It's *possible*, but it's tight and it would be a lot to revert.  I
think all these have been added since v7.1:

  aad953fb4eed ("PCI: imx6: Fix IMX6SX_GPR12_PCIE_TEST_POWERDOWN handling")
  610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
  250eea5c06f5 ("PCI: imx6: Parse 'reset-gpios' in Root Port nodes")
  0c26b1c34d12 ("PCI: imx6: Configure REF_USE_PAD before PHY reset for i.MX95")
  9dda3f83ba67 ("PCI: imx6: Assert ref_clk_en after reference clock stabilizes on i.MX95")
  85c1fcfa740d ("PCI: imx6: Integrate new pwrctrl API")
  d4b52f83f198 ("of: Add convenience wrappers for of_map_id()")
  f71f07bee9b5 ("of: Factor arguments passed to of_map_id() into a struct")
  3567bcf0e985 ("PCI: host-generic: Move legacy DT binding fallback decision to caller of pci_host_common_parse_ports()")
  2c5768344f88 ("PCI: imx6: Move pci_pwrctrl_create_devices() to imx_pcie_probe()")
  f26b1c697a2b ("PCI: imx6: Add 'skip_pwrctrl_off' flag support")
  c2b9620359b7 ("PCI: imx6: Add runtime PM support for i.MX95")
  7678e81498e2 ("PCI: imx6: Fix i.MX6Q/DL boot hang caused by improper PHY power sequencing")

I'm hoping Richard and Sherry can resolve this issue.  I guess maybe
the config details needed to reproduce it are in
https://lore.kernel.org/all/20260811063752.GA7332@francesco-nb ?

> [1] 7678e81498e2 ("PCI: imx6: Fix i.MX6Q/DL boot hang caused by improper PHY power sequencing")
> Link: https://lore.kernel.org/all/20260629143439.361560-1-leoreis.costa@gmail.com/
