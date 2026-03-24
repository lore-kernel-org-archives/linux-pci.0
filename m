Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677181DFDA1;
	Tue, 24 Mar 2026 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774351374; cv=none; b=OnD+e5wmRP6QychfF2iiVwRPBh2+L41e21g8HF477KnXx/wNmfxYHS3tvabLPHSHXVf4hTUAO5ZbNGBamU0fdbhVSoSHzZ+JWWCk9dwQU0PwMWoHwFd6F6+L8bXJj8m+eOdMCzWUeilArYpm5gvTVjvFNtixzZK+SocROc8cnXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774351374; c=relaxed/simple;
	bh=lgyctI8mPXT5BmzcI4K3XyS8EA03Fib895/wcgnTScM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmJp36fwJTiYqPjSBRZEPHdFS99dkIwsfNww7lD1jf/zzjiw0xp2w+BcTNIvXnjM8zt4r5rRsYu5GStOzDbu63c5mA6MiaRyyKy2ZL6kcSROhsoOpIphMgje78Enni/0YlsTfNB9HpMyOAr1beKqo3Qc/MYzWGTM3etm+gOEtwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+umHwGj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+umHwGj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364CAC19424;
	Tue, 24 Mar 2026 11:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774351374;
	bh=lgyctI8mPXT5BmzcI4K3XyS8EA03Fib895/wcgnTScM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A+umHwGjdtgUc1bvNI1Opk0K5EmJuRQoqE6hdzXSC9vHI+CbuE7IdCGH6U/oBl2bh
	 fGv2hX20rIha46ldXHQSayshS6/U2urP8EQqxxOG5MrB5psI4EufbEkzp8mPvoUg0E
	 P43MF3iJ45XZrPLvwzegLZzZNmUEVEX1pfzu3a75aRR9nsk0MKE2YsMwxFcHq1fC+T
	 NXy8URWY7I43KLsr0FzO/rD0rp0HT59kZjp/cvxNhEn8KDQNiC+20HvaCwftDnbJbd
	 FffSHxvUt76qv2Lr7/Pbq4RNxd8CAbmTobesiPcg71ctONu9zkeKs+idW2IOjHsFyl
	 89CSwNHLj1qag==
Date: Tue, 24 Mar 2026 16:52:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] PCI: mediatek-gen3: add power control support
Message-ID: <iaiiccyorgdhw2giejcl4dwigy2gqj4vdnw35kiekcuvwhaayo@j7m4ttrdli7j>
References: <20260324052002.4072430-1-wenst@chromium.org>
 <ojgwqrosft5x75y3yxdawrb72k4z3chc3m6uh4mkdv7dhta3ef@qcvotm36w3ly>
 <CAGXv+5E4V-zC8hfzZgXLL+Wbnw4jFfs0pvovU0xKeDmN17mwUw@mail.gmail.com>
 <jduc7ozg27bvrfxwpmswhxg4savnrkjcj5tqlluvmq5s6qiqnd@nrq6b36g25wq>
 <CAGXv+5ExO7h9VpXC=oV=bnb6k+vRA_OJH3tmPWVpxqs_hy=QJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5ExO7h9VpXC=oV=bnb6k+vRA_OJH3tmPWVpxqs_hy=QJg@mail.gmail.com>

On Tue, Mar 24, 2026 at 04:26:22PM +0800, Chen-Yu Tsai wrote:
> On Tue, Mar 24, 2026 at 4:01 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Tue, Mar 24, 2026 at 03:52:33PM +0800, Chen-Yu Tsai wrote:
> > > On Tue, Mar 24, 2026 at 3:44 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > >
> > > > On Tue, Mar 24, 2026 at 01:19:52PM +0800, Chen-Yu Tsai wrote:
> > > > > Hi folks,
> > > > >
> > > > > This is v6 of my MediaTek PCIe gen3 controller driver power control
> > > > > support series. This series is based on next-20260323, with the
> > > > > commit a2b2ca0c2477 ("Merge branch 'pci/controller/mediatek-gen3'")
> > > > > reverted to drop the older version.
> > > > >
> > > > > This series is ready to be merged. Please drop the older version and use
> > > > > this one instead.
> > > > >
> > > > > Changes since v5:
> > > > > - Link to v5: https://lore.kernel.org/all/20260311075223.3303497-1-wenst@chromium.org/
> > > > > - Adapt to PCI_PWRCTRL_SLOT -> PCI_PWRCTRL_GENERIC Kconfig symbol name change
> > > > >
> > > > > Changes since v4:
> > > > > - Link to v4: https://lore.kernel.org/all/20260310091947.2742004-1-wenst@chromium.org/
> > > > > - Patch 1
> > > > >   - Expanded tabs in commit message
> > > > > - Patch 5
> > > > >   - s/mtk_pcie_device_power_(up|down)/mtk_pcie_devices_power_(up|down)/
> > > > > - Patch 6
> > > > >   - Adapted to mtk_pcie_devices_power_down() name change
> > > > > - Patch 7
> > > > >   - Fixed label typo causing build break
> > > > >   - Replaced "exploded" with "populated" in commit message, and added
> > > > >     more explanation about what "populated onto the mainboard" means.
> > > > >
> > > > > Changes since v3:
> > > > > - Link to v3: https://lore.kernel.org/all/20260302053109.1117091-1-wenst@chromium.org/
> > > > > - Added two patches to move kernel setup code before controller setup
> > > > >   code, and controller setup code before device setup code, as requested
> > > > >   by Bjorn
> > > > > - Dropped dts patches as they are already merged
> > > > >
> > > > > I kept all the existing reviewed-by tags, since the changes to the
> > > > > existing patches aren't that big.
> > > > >
> > > > > Changes since v2:
> > > > > - Link to v2: https://lore.kernel.org/all/20260226092234.3859740-1-wenst@chromium.org/
> > > > > - Made PCIE_MEDIATEK_GEN3 select PCI_PWRCTRL_SLOT, following existing
> > > > >   examples
> > > > >
> > > > > I do wonder why the existing ones don't select PCI_PWRCTRL instead.
> > > > > As there are multiple providers, and now even the M.2 power sequencing
> > > > > driver, I think either we enable the common ones by default, or let
> > > > > the user pick and choose.
> > > > >
> > > >
> > > > I agree with you. I've sent a patch [1] to select these drivers in defconfig to
> > > > make the users life easier. But in the meantime, let's have this dependency
> > > > as-is, otherwise, until my defconfig patch lands, there is no guarantee that
> > > > these drivers will get selected by default.
> > >
> > > I would probably just make PCI_PWRCTRL_GENERIC default m or y.
> > >
> > > Or make CONFIG_PCI (and probably CONFIG_USB later on) imply
> > > CONFIG_POWER_SEQUENCING_PCIE_M2.
> > >
> >
> > The problem is, these drivers are mostly targeted for DT systems as of now. If
> > we select it by default for all archs, it will bloat the image size for other
> > archs that don't need these drivers. That's why I wanted to enable these in arch
> > defconfig.
> 
> How about
> 
>     imply CONFIG_POWER_SEQUENCING_PCIE_M2 if OF

I'm not sure if PCI Kconfig is the right place to put it. We don't select any
drivers using 'imply' as of now and OF conditional also means that this driver
could be selected for PowerPC archs which don't use this driver at all.

Same argument could be used for ARM defconfig as well as we have server based
ARM64 SoCs, but I don't have a better choice atm.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
