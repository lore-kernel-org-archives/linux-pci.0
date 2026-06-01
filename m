Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED5A2DAFBD;
	Mon,  1 Jun 2026 22:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780353746; cv=none; b=JB03EWMqNSuLYmsG/bCxeQ7onK/G3s+pu08FkZPrjdpR5yw3KMzewQNCL/9EUtdnWOQVg9jHCrlAtL+r9fw90PUma8n5LxGhZK1Efvyu6sRQYncgz8X6/oU8dknF6fKE94zcUvPlTe/WrVNEkkZ+wjI/EcNkjeeHswUee5DWxtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780353746; c=relaxed/simple;
	bh=wNGLFUTn0t6+IOaCNavAkSqQlewHHI2X5Kw7kaffiGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4mkqMjcm9jle4k75587rxU2h+c2jMTZu2xjvXUF/BRiYUh2QVU+OrvJJjtxVV7rxlDELlHgdR+yF/Att4PyoOkdGLRzfXW1IOzGe3chc2tW/QGfqO3NJPLVZ//Mol4n6pg8aVKAGnZa0v//HHOBRHOlGNWYGci19XZrsPc9JD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOlBjc3d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOlBjc3d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45991F00893;
	Mon,  1 Jun 2026 22:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780353745;
	bh=VMd//81yT+NVvlnl/F76YYhKc40UAK/meNTrVFMbKP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WOlBjc3dm2X6zFFAE34XdTKRjaGzUdXFgKnUF/EQvnfdRHFyxN6YZDNUuFKJPsCL4
	 H4NkZXVKMjkQBXunwR1bk6RWq7gdsLdzEalq+i0eDRhWeA1oR7g6DY2FWgt1nYDuKj
	 15mVLGYI7I+SBKDgQyN/sakwhLUPAusdYgLOLFgib6fW8KHqSerYBmDLadPt0H9pVo
	 FfbqkxXb7vjwrUmXsL5ouM9CmRCWzap1aJfbRsSS2dqfX/nmR+L87GF/qKVrL+kLyY
	 R6Yct8SgnKZNJum54VnYHLPKayZ7FxrsIRPL2XKWrWsESAd08uz21qz1RgFcyTT2Vk
	 fV989UQvpfw8A==
Date: Mon, 1 Jun 2026 17:42:24 -0500
From: Rob Herring <robh@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, devicetree@vger.kernel.org,
	conor+dt@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/5] dt-bindings: PCI: spacemit: Introduce Spacemit K3
 PCIe host controller
Message-ID: <20260601224224.GA116470-robh@kernel.org>
References: <20260517014841.254085-5-inochiama@gmail.com>
 <20260517024848.4F346C19425@smtp.kernel.org>
 <aglF_fbl--RgS7gQ@inochi.infowork>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aglF_fbl--RgS7gQ@inochi.infowork>

On Sun, May 17, 2026 at 12:38:39PM +0800, Inochi Amaoto wrote:
> On Sun, May 17, 2026 at 02:48:47AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> > - [Medium] The binding completely omits the `interrupts` and `interrupt-names` properties for the host controller.
> > - [Medium] The schema omits standard legacy INTx interrupt routing properties (`#interrupt-cells`, `interrupt-map`, `interrupt-map-mask`).
> > - [Low] The `phy-names` property lacks an `items` definition to restrict valid string values.
> > --
> > 
> > commit 7b8ba34456e71d6a9cf1028caa5504d64e8f58ba
> > Author: Inochi Amaoto <inochiama@gmail.com>
> > 
> > dt-bindings: PCI: spacemit: Introduce Spacemit K3 PCIe host controller
> > 
> > This commit adds device tree binding support for the PCIe controller on the
> > SpacemiT K3 SoC. The controller is based on the Synopsys DesignWare PCIe IP
> > with some extra link and reset state control.
> > 
> > > diff --git a/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml
> > > new file mode 100644
> > > index 0000000000000..46147a37a9ce6
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml
> > [ ... ]
> > > +  reset-names:
> > > +    items:
> > > +      - const: dbi
> > > +      - const: mstr
> > > +      - const: slv
> > > +
> > > +  msi-parent: true
> > > +
> > 
> > The driver implementation reads and clears interrupt status registers for
> > host-level events, and references registers for receiving INTx events from
> > downstream devices.
> > 
> > Should this binding include interrupts and interrupt-names properties to
> > document the host's interrupt routing?
> > 
> > Additionally, should standard legacy INTx interrupt routing properties like
> > #interrupt-cells, interrupt-map, and interrupt-map-mask be included in the
> > schema and example to support downstream devices that do not use MSI?
> > 
> 
> The driver just does the interrupt cleanup as it requires, and no
> additional interrupt is needed

Unless there are no interrupts and only MSIs are supported, then you 
need to define 'interrupts' property at least. The common schema only 
defines all possible names, but not which ones are used and the order.

Rob
