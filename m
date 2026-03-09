Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B5A336894;
	Mon,  9 Mar 2026 06:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773036289; cv=none; b=I9gJGbXfYUIB1+HZgQUbSysn/k5DsvJerIRzmIOPFN/Slj3xH0aYCJUhyKVa93/NCfdj3gW95s8kJB8icw+1ZJX8Pzg/VY+tksF9d8U2v1MheKuyLbGtqdq8fx/CIfjDTCUsr+M0oOmnayggYDePdydRwfMRNpE6nruHjbqFMZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773036289; c=relaxed/simple;
	bh=VSp/JFre7rfvlSdc8ogjVgAQFD7dOJbtcrFM4JQR094=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEJ5jHkJJrinRYcmqejW0oGbF0htrKbhGrIkKnG//s+x1uRW75iBCObXvtpMiekyCNCh4otlgSO9K3v2C3YEX1zlxGSu9v81GUjAKvXQe3QN5KbbPilAG3IiEL8uGHkccVnFVS6feuuswylovNJe34CivUPZZpytMMOO3VVtsTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiWF6yAI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiWF6yAI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D9AC4CEF7;
	Mon,  9 Mar 2026 06:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773036289;
	bh=VSp/JFre7rfvlSdc8ogjVgAQFD7dOJbtcrFM4JQR094=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OiWF6yAI/htrfpTJqgmum/c4BAA743DuCx/lsQyGzvjRRDlEx8DUvI7Maw7+KDV5N
	 TM4M8leBXSYx4QaKWfI1ObSo+R+LSagtCdp0VGqcIMUD3YlPukVRf49RiLKdTs5WTo
	 W2BsSZJngCYLMTc34wzZEDMXxxreioYILfFTT6QgrOnyXNPFB/qP91uUosecp8Xkan
	 syimX3O4lL9/fSa2Ne8B+N7O7cEeEe8bftpvTLGcSdIvL6L0kD0YW0CU5uby8NZBrQ
	 6+I9Sc7LJHFwM8N+5MIroBE/vdj91twlmd4AKfridfSx6B2yl+VxVuj7wm7kjYYvoQ
	 e70nOitY9bzZw==
Date: Mon, 9 Mar 2026 11:34:35 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v3 5/7] PCI: mediatek-gen3: Integrate new pwrctrl API
Message-ID: <ybanlrmujb2ygjrlxe3occhffuygsmt3vpg7tukj4bq35e64gu@i7g2v53ayfgi>
References: <20260302053109.1117091-6-wenst@chromium.org>
 <20260306192134.GA142888@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260306192134.GA142888@bhelgaas>

On Fri, Mar 06, 2026 at 01:21:34PM -0600, Bjorn Helgaas wrote:
> On Mon, Mar 02, 2026 at 01:31:05PM +0800, Chen-Yu Tsai wrote:
> > With the new PCI pwrctrl API and PCI slot binding and power drivers, we
> > now have a way to describe and power up WiFi/BT adapters connected
> > through a PCIe or M.2 slot, or exploded onto the mainboard itself.
> > 
> > Integrate the PCI pwrctrl API into the PCIe driver, so that power is
> > properly enabled before PCIe link training is done, allowing the
> > card to successfully be detected.
> > ...
> 
> > @@ -1211,9 +1222,13 @@ static int mtk_pcie_probe(struct platform_device *pdev)
> >  	pcie->soc = device_get_match_data(dev);
> >  	platform_set_drvdata(pdev, pcie);
> >  
> > +	err = pci_pwrctrl_create_devices(pcie->dev);
> 
> AFAICT this has nothing at all to do with mediatek-gen3; it only has
> to do with the fact that the platform provides a way to control the
> main power to endpoints that happen to be connected to it.  Are we
> going to have to add this in every single native host controller
> driver?

Yes, I want this feature to be opt-in because, a lot of controller drivers
handle the device power themselves. We can convert these drivers one-by-one and
when atleast 50% of them are converted, we can move these calls to generic APIs
such as pci_host_probe().

- Mani

-- 
மணிவண்ணன் சதாசிவம்
