Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013036;
	b=Xr2FQ00PI3a+zpAcwrqLvdfy8FB+x9nt79KFHKz4oP2N+H4KNAinYhTPo22buAXAvAsO
	 R5+oC+09KG37rg0Nij9m/aOlI8OGrEZ4l4+PUQwpe07tKNQbxGIJrg+wQNo0J3dr/2LVy
	 xzSeCfLD7/9yC+fEG9UMAeDjkqc76/AF+Y6M26Sift7tebxPs7CSXOm2kO5/M2mRvoWT/
	 ZYBMnAVI6Yn3jM4xYVrbY1y6m609G5fui+8cn+ZrLW8bRwQRgnrNK9a1ZZpuI8/J0qwSG
	 j/syfJbatWe0xASgPtn1fFTKibMQyeDdB82sRRBq9yTtKACC6AUza4vA//AEpwguHBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013036;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cXUV7hKDsKpkJr1SARjDVAABt9+8XnSa63DJnjuCLmI=;
	b=3FZKQouiRIHCQVjsK49G7USylfPkfjgX9R0P2qwjK6+oqBzlY0BcnEixT7OnQ9iW3Pkx
	 fcncRB9lKl/DGmWPX5LdrUB/qI08eWO7Loxh3TJTwnBwregSAd+uOLFqot6tktSiwj+tb
	 SStVzanCnuJcJJf1VLyiAiqMOylm5A/EoQpiC/Z5G3Zh6Kwxy0h0Se0rpX3nWJfvgeBwL
	 t/g3bzlylJQxNC3qt1HEb5cmw20fZZdiz0+V/zETVmOwclghYG0+geGhyUAo7nI8idORN
	 eBno+O1Z1ry/BEry1ZdZFNKZZGOf6U7sXt5T4pRG71tqnQSAYW2Pw/sOP9oG6XJQEEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LQJ0awWo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8630A606A330
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LQJ0awWo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FA11F000C5;
	Wed, 18 Nov 2026 14:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795013036;
	bh=cXUV7hKDsKpkJr1SARjDVAABt9+8XnSa63DJnjuCLmI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LQJ0awWoKGG8YPPENy/lUYu+Mx+E8yX2FQUl9bJTKNEM/iib/LkT+x+nHBBxfH9Iv
	 2y1K3C6mFmrBD94Oc/T1E/FEI7GpIO7BrtBbn48HNbYVtbQCyy5B6l8F1F6dWy4+lN
	 zjiMpY+9KinVtYvRIm6ENpnIil61v0g/KdujuTaePOwUzqWZNFEnO93hTLjQKJKwrY
	 4A9qD4RWP/aS/N9qpLJ1sXgzNcZb7hzlTAxPQeL9l/G4gm+bI6SFFrHoqvOM06tOEm
	 w1/7Ye0BODgs1ex/jCVKjrILgktQP1s/Vxh/PKyLbyZ0ku46hkPA3QILuSrZnf5k6O
	 QfTwnM67SPoJw==
Message-ID: <sashiko-outbox-221245@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: meson: Fix potential use-after-free after PHY
 provider removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <liguangshuo@mail.sdu.edu.cn>
Cc: linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org, neil.armstrong@linaro.org
In-Reply-To: <20261118-324f82bd41-pci-meson-0@mail.sdu.edu.cn>
References: <20261118-324f82bd41-pci-meson-0@mail.sdu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:43:55 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI: meson: open-coded device_link_add() on mp->phy->dev.parent
  in meson_pcie_probe()
--

commit c65612b1d0d3578038649d0fdc61a7521f33e1fc
Author: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>

PCI: meson: Fix potential use-after-free after PHY provider removal

This commit adds a managed device link from the Meson PCIe device to its
PHY provider in meson_pcie_probe() so the PCIe controller is unbound
before the PHY provider releases its resources.

> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/control=
ler/dwc/pci-meson.c
> index 8559d132dcde8..251673bc5963c 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -401,6 +401,10 @@ static int meson_pcie_probe(struct platform_device *=
pdev)
>  		return PTR_ERR(mp->phy);
>  	}
> =20
> +	if (!device_link_add(dev, mp->phy->dev.parent,
> +			     DL_FLAG_AUTOREMOVE_CONSUMER))
> +		return dev_err_probe(dev, -EINVAL, "failed to link PHY provider\n");

[Severity: Low]
Should a PHY consumer driver reach into mp->phy->dev.parent to call
device_link_add() directly?

On Device Tree platforms, fw_devlink already parses the "phys" property
in drivers/of/property.c (parse_phys()) and creates a managed device
link between dev and the PHY provider, which causes
__device_release_driver() to unbind meson-pcie before the PHY provider
releases its devres resources; device_link_add() here just finds that
existing link and returns it without adding DL_FLAG_AUTOREMOVE_CONSUMER.
Reaching into struct phy internals also bypasses struct phy
encapsulation, and any provider device link needed when fw_devlink is
disabled belongs in the PHY core (phy_get() in drivers/phy/phy-core.c)
rather than in individual consumer drivers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-324f82bd41=
-pci-meson-0@mail.sdu.edu.cn?part=3D1
