Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534BC4A8FED;
	Wed,  2 Sep 2026 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363416; cv=none; b=LdFHisXemc9MpUw1sYhm3W6CJ563Qv7aPy1YzmLwZsj1OgJLQOYHEKX442B0RnqqpbTFUSsk9tEqsP3SATDaE5HnUjggSonZDvbsnKTgHnBOgCoLxzgs9yUVGChaCOaL3GHQwBkIMzK62uIYz2MdT9E8fT8Zc0Sw8zB+oZei600=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363416; c=relaxed/simple;
	bh=47sISTufD/xt3yyHh3DkfpoKVrJ/foj2qLWquUnponw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VG2oiVrZJKU3VZaFihUSl0wTjNL78KBhPhtBU05D1wNWDln3CkHIrfiAcTJ+N0R7sHdr0GEM5Zl9i+MZQtCWOtw/E7bp3yW+kzL3cXFaPQUnov1yoSRC2HaLKeQR+W0gni5i+Knv5KDVYvn5Al8juvf0kNHOxSaqWRlGboBP9cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QylaVxbS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QylaVxbS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238F41F000E9;
	Wed,  2 Sep 2026 15:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788363402;
	bh=0TRg4LaK6NixUNgoD8Z3iZoWX9CdGYyQqUDBLKmNPXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QylaVxbS+g9l7ebe4a++AKnZ7Td4NBUuMdPvjTFp71Ro/u9oq4XmG80tBfvB5R16e
	 wwPqI72LaEihtmsNBa+JDs5DtTmV5odePW0x9H3Wj1njJIbYp20wZCNDBCk+rnyVsO
	 7c3GRPzwAJk6LLn+FsYtv3Ozel3KIUI7M0eqEnGfDSBTJYfIYFNZLiAWJotJJCQ5Fk
	 ISAc6FEIbmOILKgQQ9zYdtsybx2Qtetazj2A7Sb1bc5Eo73rdeVAXYcI+crC7BEGRD
	 hOd0sphSFBOUeasdXUkcRB60lVCCfr9D33oGtjcGsSkGeRqgLnlhSfEqB1BtlIg4or
	 bA8frFpvi3XkQ==
Date: Wed, 2 Sep 2026 17:36:24 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
	Lucas Stach <l.stach@pengutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michal Gorlas <michal.gorlas@9elements.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] PCI: imx6: Enable ASPM L1 only iff CLKREQ# is
 supported
Message-ID: <gayg4xafgxcog7f7jy2i2e3wctds3do2ytttgv74f3y6ed7qtg@mr3xfxugjfeh>
References: <20260827-l1-conditional-imx-v2-1-40b324aa2a94@9elements.com>
 <178835947957.88571.7553170178358028044.b4-ty@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178835947957.88571.7553170178358028044.b4-ty@b4>

On Wed, Sep 02, 2026 at 04:31:19PM +0200, Manivannan Sadhasivam wrote:
> 
> On Thu, 27 Aug 2026 18:51:00 +0200, Michal Gorlas wrote:
> > Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
> > states for devicetree platforms"), ASPM states are force enabled
> > on all devicetree platforms. This causes PCI devices on some i.MX SoCs
> > (for e.g. i.MX 8M Plus Kontron SMARC eval carrier) to enter L1 even
> > though CLKREQ# is not supported (and consequently supports-clkreq is
> > not set in pcie controller node of their DT), which causes the device to
> > never wake up from L1.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] PCI: imx6: Enable ASPM L1 only iff CLKREQ# is supported
>       commit: 94420d27973f567e5c10b631115ea8b9abc0172e
> 

I dropped this patch now as I completely missed that this patch incorrectly
assumed that ASPM L1 is controlled by the 'supports-clkreq' property. This
property is supposed to be used only for ASPM L1ss where REFCLK would be cut
off.

As Krishna explained in v3 [1], you should use 'aspm,no-l1' property in DT and
use it to disable ASPM L1.

- Mani

[1] https://lore.kernel.org/linux-pci/aabc3dbd-3e5b-4272-807f-f0743606e25a@oss.qualcomm.com/

-- 
மணிவண்ணன் சதாசிவம்
