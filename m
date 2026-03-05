Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98F039F199
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714694; cv=none; b=O9dg1XEMkeKwSyuXAvVgZwlWpCGm3AIkq/2pxQN7xK2Ype1W0s49L3tfEoMEU5pZ2AL1O8qnRtmxDjNJcI+zInx5Vwn780n6OWYoxUKgZJnlYPOenfMEeXxzGxeyTjBfeZN94teozQRxl8D6Zlp+/3hYIL//hbKhfKeR4ksNU08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714694; c=relaxed/simple;
	bh=7/B3L3Xu38pLEI9aWzEuoVdxX7Qp2NIDeM+Gg1/xjBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r74e/WyKWy17LP+csteL1G/Rj/ioWxOvVFWoBaQMifD5YVlaU81j8wBjgTHNvBeJ3j5bu3rJ14aA0eTgwdv6Fv4oUWNy4+P+j/8Q9BVYeenjp0hkBq3++tYiFAoK8+wmNFZCYhBSeNdyKRCj5zVdb4oKNsxptczLyyvM+9qz5Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtqYMvb5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtqYMvb5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84201C2BCB2
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 12:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772714694;
	bh=7/B3L3Xu38pLEI9aWzEuoVdxX7Qp2NIDeM+Gg1/xjBI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OtqYMvb5oPxe5sMzeuWM/p9QhfY79P8WSa8Oc0dmxSoFCqAxC+CeiyJ4NR/CKYXp5
	 2pWsVJ/8dTjJPaOTsMOrLWg9QrWyIT17qWYKoWkp2uev1+hKn84FX5s0QnjAl8bNE/
	 7JpPIBkXPhGvuxF9NkQde6xY7s3+z78cNibHOOJcW8DPll2R+OOPS/ZPgglANmm0bm
	 z+fq9gwNqWVY2cpjU7AjP46t/Fi3qyyprLoCv6ETr3JC7/UsdbQoEj4fnlA7mjJ3u9
	 kpBnTLkqR3bbedcx3T7TtOd2iumdT2sN3/QFxWt88OY6wGjq0mmb5qwwhn72EVc8bD
	 zEhwMty5ybC+w==
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ad46a44easo7001849d50.0
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 04:44:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8pADf9XjP+MTcWY24dw5Uzq9sl6RsOOM//FmTr/zgRvwbdNRlhZvz6eTfzzRQJIJ7qDb1/Bdow+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1wfdRX9H0lXHBhzZ6dtqEts1yyQ+8o6/vBoBQzwHLD29gbD3O
	/hgRpwyZDKuLZqnkHv45g86P96+zydoC5cCR6y2Ukxpm06Yj93bzV2mCd4kDZY3RXItInhG6HMx
	TrSeCpX0r0J66Hoqx1iIV67Y260dJVcM=
X-Received: by 2002:a05:690e:1a12:b0:649:5a6e:bc88 with SMTP id
 956f58d0204a3-64cf9bac208mr3552462d50.46.1772714693758; Thu, 05 Mar 2026
 04:44:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-19-vladimir.oltean@nxp.com> <CAD++jLnCtu20rXcg7sMVLBi24EohscJoz0kN46XJaKPJt00O2w@mail.gmail.com>
In-Reply-To: <CAD++jLnCtu20rXcg7sMVLBi24EohscJoz0kN46XJaKPJt00O2w@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Mar 2026 13:44:42 +0100
X-Gmail-Original-Message-ID: <CAD++jL=m+cEcqy1i2H0tdeBa3Sy76myGAR9HdBqrT4u-x5v50A@mail.gmail.com>
X-Gm-Features: AaiRm53u9phsGhzUDeKiqEnTp_X3DfbqaQ7dJ0SVurbn78IH1263DExaHPtG4YM
Message-ID: <CAD++jL=m+cEcqy1i2H0tdeBa3Sy76myGAR9HdBqrT4u-x5v50A@mail.gmail.com>
Subject: Re: [PATCH phy-next 18/22] pinctrl: tegra-xusb: include PHY provider header
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, spacemit@lists.linux.dev, 
	UNGLinuxDriver@microchip.com, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 1:43=E2=80=AFPM Linus Walleij <linusw@kernel.org> wr=
ote:
> On Wed, Mar 4, 2026 at 7:00=E2=80=AFPM Vladimir Oltean <vladimir.oltean@n=
xp.com> wrote:
>
> > The tegra-xusb pinctrl driver is also a PHY provider (calls
> > devm_phy_create() for PCIe and SATA). However, according to Vinod Koul,
> > having PHY provider drivers outside of drivers/phy/ is discouraged,
> > although it would be difficult for me to address a proper movement here=
.
> >
> > Include the private provider API header from drivers/phy/, but leave a
> > FIXME in place. It will have to be moved, eventually.
> >
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>
> Fair enough, is this a regression so I should merge it for fixes
> or just a nonurgent fix that I can apply for next?

Sorry I realized it needs to go in with the series.
Reviewed-by: Linus Walleij <linusw@kernel.org>

You can take it from here.

Yours,
Linus Walleij
