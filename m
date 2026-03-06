Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C3B36D4FC;
	Fri,  6 Mar 2026 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772824895; cv=none; b=mq9d/lI4sZ2Q/umKBj3lG32cxm917iC4RZLefFzpd8xATZmWx5E6an54R4bTIMQJizhmCYGbknCvZXo7H9YTbfDPRj913vzNQYpFuwyfia4re07KthWkC24o2PQExG5lbJnO1s8az7K/Qyki7l3mkEDpgpFE+wHQephOJAN8jsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772824895; c=relaxed/simple;
	bh=TQi45iay0AkGT6+H950UdfjyasSqqq8GcNC+15PNzf4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=flcbtUwhOmE+HZxzIwjt0eW3AW1PHSoSjxT3GDRqtLgXH7yTkPiI4bRN1FzLlLUjOKj/Cno24i9X72ZGEOPlgpDUTdufeCJCklcuYE/vK0onjm2kY4N/6lRKBorT+H6zFukZvH4G4zN4UjouWWVUyPGwpcm5gbpx1ERxqESE7FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dS5ieo3g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dS5ieo3g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA1BC4CEF7;
	Fri,  6 Mar 2026 19:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772824895;
	bh=TQi45iay0AkGT6+H950UdfjyasSqqq8GcNC+15PNzf4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dS5ieo3gMXMdovFSvI66LsDnoS2CdMPqUDSch0+EYcTM0T/nOmGUthg7dGu3u5CQ3
	 co6V7vQ8jGXKm+pDj4jDITLCzkFXoccmOrbW1g3h3lbJ3F+qTdzTAD/ipDjvIwY0B8
	 KqZyeJemPKUZJQFudfHzIrZISkqlTL1GQ2o+Dq5CcbytA293Pj0smcKJvxs0BHFGSU
	 1jMmW0ONc2x3eAcjteRmtHJHJgnA2KoxKsrhIoPBbaJyQELZmfafd8fbH7sktuHPXI
	 6rQhtiLyuGGT7Lqf76X3RU2HZmaIxzPjNc8Q9dpH775uhuc38+eviUqZHvp5m1eEvH
	 gUOkasu8NenFA==
Date: Fri, 6 Mar 2026 13:21:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v3 5/7] PCI: mediatek-gen3: Integrate new pwrctrl API
Message-ID: <20260306192134.GA142888@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302053109.1117091-6-wenst@chromium.org>

On Mon, Mar 02, 2026 at 01:31:05PM +0800, Chen-Yu Tsai wrote:
> With the new PCI pwrctrl API and PCI slot binding and power drivers, we
> now have a way to describe and power up WiFi/BT adapters connected
> through a PCIe or M.2 slot, or exploded onto the mainboard itself.
> 
> Integrate the PCI pwrctrl API into the PCIe driver, so that power is
> properly enabled before PCIe link training is done, allowing the
> card to successfully be detected.
> ...

> @@ -1211,9 +1222,13 @@ static int mtk_pcie_probe(struct platform_device *pdev)
>  	pcie->soc = device_get_match_data(dev);
>  	platform_set_drvdata(pdev, pcie);
>  
> +	err = pci_pwrctrl_create_devices(pcie->dev);

AFAICT this has nothing at all to do with mediatek-gen3; it only has
to do with the fact that the platform provides a way to control the
main power to endpoints that happen to be connected to it.  Are we
going to have to add this in every single native host controller
driver?
