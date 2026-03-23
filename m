Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B38E3C7E0A;
	Mon, 23 Mar 2026 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286688; cv=none; b=PDF3HagjlEL7TGHftNRpagIYOXNkn3y0IYjTKBfnF9orv0qEdiOYl0dq2/RArrTd4HecwX0wz3bZbrgC0vjVoGV2nj6AE4SkwMYSVToC2ZbsrPxxc/dViHkU4Kohk1gCc7psiGtey59UQVRufrei7uF+xH9FmW48bMyrEr1dyz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286688; c=relaxed/simple;
	bh=3b/Pf+efs6DwZxI9LgoT1yaJxrb4aklVz4R/Q630Z94=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HjMcrKToiRjzCOGS2avpOrm++qFCcK4abirHlHAb8ghU3gVYC7FL6WZN5uOGHmW3GuptFd+jH/9HyTFIf4AoRL+kqhju9V00cRaLdIDCNTGxuDlWU18DnxbFnSG1uTtKyZRDTn+ydAXmfntPpQK5QeopNouHP78j07O1sZfwML0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXPfHXzx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXPfHXzx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE3DC4CEF7;
	Mon, 23 Mar 2026 17:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774286688;
	bh=3b/Pf+efs6DwZxI9LgoT1yaJxrb4aklVz4R/Q630Z94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rXPfHXzxduQHADzoMNap8OhCb4omlnhmjF+TLKEANg3hJUcF9KhWLRvAVSdWGsczq
	 QAJv1Ad14K5pq7/eKchcxy2yyb+VmPkvCTYao8zeoulJQcW0I4t137BXVfJB1zU+fw
	 KwVcpHBSKhVHjO6LxvWqc5QUhxtpY/LH2unZ/McagPFgp/5q5iMXXc5jWyMkEBrwwz
	 Sygmx+KEt3pnHptuoTih+PutfpNiA7HU6fhbRMjFTg8vdBLoFGiY7bCDRkldH+a564
	 iOgjn8QVERZJWKMyHKmiENSkheJk7fEbt6SWvb1crmfhkGUF6Aoi9EpKLvrw14+d9l
	 kIGzbUsttPoGw==
Date: Mon, 23 Mar 2026 12:24:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Chen-Yu Tsai <wenst@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Nam Cao <namcao@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] PCI: mediatek-gen3: select PCI_PWRCTRL_GENERIC correctly
Message-ID: <20260323172445.GA880803@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <wlu2o3hx6yvpzs54mxsf24gmqwwudkixx7aylv4dkey744yify@eufscwyqiyhk>

On Mon, Mar 23, 2026 at 05:26:47PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Mar 23, 2026 at 11:55:06AM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The PCI_PWRCTRL_SLOT option was renamed to PCI_PWRCTRL_GENERIC, but a new
> > user showed up using the old name, which caused a build failure when
> > both conflicting patches are merged:
> > 
> > aarch64-linux-ld: drivers/pci/controller/pcie-mediatek-gen3.o: in function `mtk_pcie_remove':
> > pcie-mediatek-gen3.c:(.text+0x137c): undefined reference to `pci_pwrctrl_power_off_devices'
> > 
> > Use the correct symbol as intended originally.
> > 
> > Fixes: ff124bbbca1d ("PCI/pwrctrl: generic: Rename pci-pwrctrl-slot as generic")
> > Fixes: 073a7e1b7bcc ("PCI: mediatek-gen3: Integrate new pwrctrl API")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Bjorn, should I squash this fix with 073a7e1b7bcc so that pci/next will build
> properly?

If you squash this into 073a7e1b7bcc, I think the 0-day bot will
comlain about the resulting pci/controller/mediatek-gen3 branch
because it doesn't include ff124bbbca1d.

I can resolve it by hand when merging pci/controller/mediatek-gen3
into pci/next.

> > ---
> >  drivers/pci/controller/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > index e72ac6934379..686349e09cd3 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -222,7 +222,7 @@ config PCIE_MEDIATEK_GEN3
> >  	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
> >  	depends on PCI_MSI
> >  	select IRQ_MSI_LIB
> > -	select PCI_PWRCTRL_SLOT
> > +	select PCI_PWRCTRL_GENERIC
> >  	help
> >  	  Adds support for PCIe Gen3 MAC controller for MediaTek SoCs.
> >  	  This PCIe controller is compatible with Gen3, Gen2 and Gen1 speed,
> > -- 
> > 2.39.5
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
