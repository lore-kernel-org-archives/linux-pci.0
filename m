Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17B828B4FD;
	Mon, 22 Jun 2026 17:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782148490; cv=none; b=uLijS7PgTA+8b1YDQG2AF5g4HSQvvjH3XAIahK0ckDH6cpFKhjUBOqaDADSs09C1nso6dbKtdDbGuFr1qxp76s2Fql+MUGs1TNcdyJxsjZJH9uy3ANyu+9sRFXoncQPh+7ODJnN6DJnSPFQ9uuCcfc+4PKLLEz96xKfmcp1PU4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782148490; c=relaxed/simple;
	bh=F57zRT3qf9ivHkzVyZmDF7HR3Qy1+FeiOa73Y3qwJEM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kvxSoNqVnh6wNhKxmjxJGFeJBiQ82ZG9+RRVwHI0abqNAj2UWaftddmNcd+HMqp7W07OB+W0JE3f19PNk2VEEp3kIRmd7Ys3o5MyTGPRtMLtjzq3ZCXY/ga+n8HCK8uPBYy4RtUTFOWZqU3D25HIGd/t3asK33WxSU3vy8WPUMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3jVb1nM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3jVb1nM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7771F000E9;
	Mon, 22 Jun 2026 17:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782148489;
	bh=qjzQ4WwEP4S9tC3oy8nVsiVMsWH0bk2/jHATvq8YN7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=T3jVb1nMf3BVbMVzJIa3+l8FyxOasvux+i+g5elRWyUJ3tKyCOVRbENnhNuQwA6G0
	 FaCXRZLUMsP7g3wqBRZyeXRqk4SRnQygKqCA44f5/gxdv+1xK/Vck+IP3MsWtA25OA
	 rJp/w7XbBoo+T8vxg2tIJ/F/KWFVM+RSjRSNvMv9kIk9a2jTGK7P3KIo9sqfSu+6FN
	 ZFyN+bVCG2aKNadAlcX+gXiN1ZMIjucS486ERjyxJIA0O5BmVKvcVF018PKmYwbOHi
	 39raliXBg05jeLL/fiXWcGJYzFqGfnepGprhNMbAwiue7GLqLTOuQUERN18GpEWh2Z
	 WiLWFooYByexQ==
Date: Mon, 22 Jun 2026 12:14:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, Manivannan Sadhasivam <mani@kernel.org>,
	lpieralisi@kernel.org, kwilczynski@kernel.org, heiko@sntech.de,
	yue.wang@amlogic.com, pali@kernel.org, neil.armstrong@linaro.org,
	robh@kernel.org, jingoohan1@gmail.com, khilman@baylibre.com,
	jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
	cassel@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v7 0/2] PCI: Configure Root Port MPS during host probing
Message-ID: <20260622171448.GA678675@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dae17d36-c7d2-467b-a621-3c55e08a67a8@163.com>

On Fri, Jun 19, 2026 at 11:29:39PM +0800, Hans Zhang wrote:
> On 5/6/26 22:00, Manivannan Sadhasivam wrote:
> > On Fri, Nov 28, 2025 at 01:09:06AM +0800, Hans Zhang wrote:
> > > Current PCIe initialization exhibits a key optimization gap: Root Ports
> > > may operate with non-optimal Maximum Payload Size (MPS) settings. While
> > > downstream device configuration is handled during bus enumeration, Root
> > > Port MPS values inherited from firmware or hardware defaults often fail
> > > to utilize the full capabilities supported by controller hardware. This
> > > results in suboptimal data transfer efficiency throughout the PCIe
> > > hierarchy.
> > > 
> > > This patch series addresses this by:
> > > 
> > > 1. Core PCI enhancement (Patch 1):
> > > - Proactively configures Root Port MPS during host controller probing
> > > - Sets initial MPS to hardware maximum (128 << dev->pcie_mpss)
> > > - Conditional on PCIe bus tuning being enabled (PCIE_BUS_TUNE_OFF unset)
> > >    and not in PCIE_BUS_PEER2PEER mode (which requires default 128 bytes)
> > > - Maintains backward compatibility via PCIE_BUS_TUNE_OFF check
> > > - Preserves standard MPS negotiation during downstream enumeration
> > > 
> > > 2. Driver cleanup (Patch 2):
> > > - Removes redundant MPS configuration from Meson PCIe controller driver
> > > - Functionality is now centralized in PCI core
> > > - Simplifies driver maintenance long-term
> > > 
> > 
> > For the series,
> > 
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > 
> > Bjorn: Could you please take a look? This series has been floating for a
> > while...
> 
> Hello Bjorn,
> 
> Any chance for this series to be applied?

It's too late for v7.2; we're already more than halfway through the
merge window.  We can look again for v7.3 after v7.2-rc1.
