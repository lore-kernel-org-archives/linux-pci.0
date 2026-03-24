Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA67C3E5561;
	Tue, 24 Mar 2026 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349734; cv=none; b=LvkZ76XP3k9YxZtF+3xzdtrkVgZm+7ez9NKCADu5HHSBIoAeHelSM8/Ke6BV93h/15KqDApZ2Hwp0Gfu8RNPMXF9n1ykCU+MNBlG0/0p6VNX3ajM614zUSu5KSzXJVghzhm4HLKomOE1x/oEr0Py2J9+MJ4xLWwFggk9KNuoEJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349734; c=relaxed/simple;
	bh=vRpOiSyC6phYOwno04oAnBLQc2n2HqMG6w4tao+mkU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AH5Lg1Up55dx+3aVoULmBjnsW0qWjRsIZjJeobJcv7EYoOeecEnR5zJUEqcA9H28Vg4264mR77L2ckqbmktelQvx2nSxmYhL+TVltV+wp2EdpPcg91hhKv38m90DbbbgNQ8pXKDHRgh2D0i8hCNrl4dNTWPHRSloPTWdo3bQ64w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHTC0A7B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHTC0A7B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BECEC19424;
	Tue, 24 Mar 2026 10:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774349734;
	bh=vRpOiSyC6phYOwno04oAnBLQc2n2HqMG6w4tao+mkU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nHTC0A7B3O4knEDL+NkN7G1ZdxqUmEOFjjYS6EXLAq3i34tKErZxvazrG/pLMvXzO
	 URnDWB2hXDWZxht01dpYtsfR7bYZZQP/P0P1TqkD+5bPyOe72xskKs9gKPTu8IuDPQ
	 EXxkM3fwLycuur/i9KZL4OPCR36eoJ/DEZBrgITbeEwCPydgQvgOeXwwSCGg5wwZlE
	 iAD0nolZ4nfIoGaWtdiUoV3IPfwGrDZh9mrizwlc64BFLqfyauSpoXLlRTX7fYaalx
	 5Ex1MK/LgJDI/CgnscTM5eU3X8yPlBEQLBhEt5YlHsscM5vL7KSY8BEv1Eb/btRfWs
	 bPbhFvCBYM5DQ==
Date: Tue, 24 Mar 2026 16:25:21 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v6 5/7] PCI: mediatek-gen3: Split out device power helpers
Message-ID: <v544j33upuqwadnxvunnhpac7cctyffaclk3jadgpyvb2yuvrf@ci45anamvgjf>
References: <20260324052002.4072430-1-wenst@chromium.org>
 <20260324052002.4072430-6-wenst@chromium.org>
 <CAGXv+5Gg90cDAV5ntBet9QTnyxrpzoMSNTvJJs0da2C32AFE1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5Gg90cDAV5ntBet9QTnyxrpzoMSNTvJJs0da2C32AFE1w@mail.gmail.com>

On Tue, Mar 24, 2026 at 04:55:47PM +0800, Chen-Yu Tsai wrote:
> On Tue, Mar 24, 2026 at 1:20 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
> >
> > In preparation for adding full power on/off control with the pwrctrl
> > API, split out the existing code that only partially deals with device
> > power sequencing into separate helper functions. The existing code only
> > handles PERST#.
> >
> > This is purely moving code around, and brings no functional changes.
> >
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  drivers/pci/controller/pcie-mediatek-gen3.c | 87 ++++++++++++---------
> >  1 file changed, 52 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> > index 22a16e4ebc76..526db8815401 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > @@ -403,6 +403,54 @@ static void mtk_pcie_enable_msi(struct mtk_gen3_pcie *pcie)
> >         writel_relaxed(val, pcie->base + PCIE_INT_ENABLE_REG);
> >  }
> >
> > +static int mtk_pcie_devices_power_up(struct mtk_gen3_pcie *pcie)
> > +{
> > +       int err;
> 
> Sashiko pointed out that this addition would cause an unused variable
> warning. This line should be added in the last patch instead.
> 
> Do you want me to respin? Or is it fine since the end result is the same?
> 

I fixed it in the branch as we try not to introduce any warning even between the
commits.

> Sorry about this.
> 

Np!

- Mani

-- 
மணிவண்ணன் சதாசிவம்
