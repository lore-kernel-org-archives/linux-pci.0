Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792575825;
	b=zvYx+B9+ZNyveG7Uw0tWlGVINk4kndCTFp8+bFjU6OdVEllYfMWSFrfFm1Cl91yG1yv3
	 lMYqHduA3MR0pH5wz1xnGJgK4oHzamo/ygFtwIIYvZIVmll5sH00AB8gRMookFQWjIMVF
	 nZsS86r8cp8wRASzE8VrKYH2q5wx7ErynSwZPX70KFLFu/LNr3+U3w2Bk4noiERNcF6er
	 pyuUqr1AEbF/YNQuYIzpLVJ3iMiJxey5hbxgCpwsqxta9rqWfDydWA2c7vZ/F4iPQQNom
	 YKZ+YC2kFEJ8Yic1pR6yGNr7TUrLL4qTIu6OIghpDhxw4HrMQpVt+PRx3Gvf8w/1HaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575825;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 Received:Received:From:In-Reply-To:MIME-Version:References:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=M9+hNfxaZh36tJO0QqNHySgIwpUhDy0fJXD1yCpECh0=;
	b=JWIc1HmSLcSfzsxHsn2MoLsXcXE23+KaOp/CtQXbkTKbT1QUmR8VFWWb9A27cjcVtudD
	 mllXiatorT5sOQy5MGpiKdQy+4xVn3dht9OnmOhEPOtEIayy7b7CD3W3WQi44zWN4pkav
	 L23RU+46I9lua5qEoYiRMXgsEEXzDUld8TrWBZ7oic/S7mhnAtaDtuFncPVWZDf7UnDh2
	 DmrUR/EdSZctpWjzheg6bDdkbG5Tw9g4eZrcer2p+W/b5bB7SZGZRL7RpegkNqbUqf4E8
	 Rj3vN2mAPBK5i95NM1NbfZddwIYgSZ/odadZE4+6AS4mkYoRUp8LU7wDQtDlb6sul0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kxemHx/f";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6057606A31A
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kxemHx/f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADBE1F000C9
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 09:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792575824;
	bh=M9+hNfxaZh36tJO0QqNHySgIwpUhDy0fJXD1yCpECh0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=kxemHx/fBXE/4Bu6ahv1yiGZMNdJ4QTNLuruLfYazHdFhqzPAV1tKxybYZJuqKlX+
	 tSADx5Q17J4bkFZKLS9Xr0zuOGlalBf4FjWsZ+ZQaz3ehezbq9CC7CS5l9VMikH8/G
	 h0df5snZwjDd9xwLG/XwU9mrx21EtkugaLR0l0vXDw7KEKsieuVSrSBPfeMlQOKFHf
	 ozSCRfuXw2+KBDXjWUa8aA6ZxEhJaRtMHH5W6c0bQXxhcf0x4n27cvK4Sc42O1c+aK
	 QLhdlvLdN6ECvL8i3Fam3W8+fEWmCKl275KLGzfWRt32opDbXFmPWLdmYFuTPjfN4e
	 bbv5neVc7YZ8A==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5be4c78e8caso428831e87.1
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 02:43:44 -0700 (PDT)
X-Gm-Message-State: AFq9FYK84/uYkLEm8xhctWMnZKYnCUvOek+JzTCiuzBHVbcgw8oP6lXd
	3c6w4b/t4uMTZq3dlmOxmDhSk0tQBBMVJ/mTzGcNop+iOxLV+e6VweMDSP7/9UcjNCKJml9XcxW
	HM6jeMnT89fM8kMuv5iL4DcEsRt6xecGRuQf05mWM+w==
X-Received: by 2002:a05:6512:2c8d:b0:5ba:3e11:5d3f with SMTP id
 2adb3069b0e04-5bfa1c3d7a2mr545704e87.41.1792575823202; Wed, 21 Oct 2026
 02:43:43 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 05:43:41 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 05:43:41 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <45484c37512a3102495d8b75b6e9f72a141ba42e.1792574560.git.geert+renesas@glider.be>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <45484c37512a3102495d8b75b6e9f72a141ba42e.1792574560.git.geert+renesas@glider.be>
Date: Wed, 21 Oct 2026 05:43:41 -0400
X-Gmail-Original-Message-ID: <CAMRc=Mc26=r5+pw1D03E1UWkmrdgtm_ZkesV7yzH2jdGB2U_Lw@mail.gmail.com>
X-Gm-Features: AclHuK93rwltI4nv5VA4V6ewSRua1UsdsQx5de-m7P_I1uO9BLJjDfU-0FxsoZE
Message-ID: <CAMRc=Mc26=r5+pw1D03E1UWkmrdgtm_ZkesV7yzH2jdGB2U_Lw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/pwrctrl/gpio: Correct GPIO_TC9563 /
 PCI_PWRCTRL_TC9563 dependency
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Alex Elder <elder@riscstar.com>, 
	Daniel Thompson <daniel@riscstar.com>, Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 11:23:52 +0200, Geert Uytterhoeven
<geert+renesas@glider.be> said:
> The Toshiba TC9563 GPIO controller is embedded in the Toshiba TC9563
> PCIe switch, and its auxiliary device is instantiated by the TC9563 PCI
> Power Control driver.  Hence make GPIO_TC9563 depend on
> PCI_PWRCTRL_TC9563, to prevent asking the user about the GPIO driver
> when configuring a kernel without TC9563 PCI Power Control support.
>
> Drop the dependency of PCI_PWRCTRL_TC9563 on GPIO_TC9563, which
> represents the inverse and wrong relationship.
> Let PCI_PWRCTRL_TC9563 select AUXILIARY_BUS, as this is no longer
> guaranteed through GPIO_TC9563.
>
> Fixes: eea9a072221d97ab ("PCI/pwrctrl: tc9563: Add GPIO auxiliary device support")
> Fixes: 81ec9c22d06aea92 ("gpio: tc9563: Add support for the embedded GPIO controller")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
