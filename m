Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794559625;
	b=I9kNEs9BEnxjq0JPZu/Jj8Xg6JoL/y6uSezek+ypX2FM+niHeV698eLNgrRyBXl+eGFl
	 xpH4mU/4uD4VScnga+y5bLlLpYi986aMqyje9ASLF2EX3G78PEW+8pZRugBnUSEeatCQv
	 OM5VoTA1yREdLmCuNP/cDqHjBpUcJtzMw4sGhFeURAbFwN4LfQe436Pm1EUuwhjrB6tA+
	 uRsCY5Ya2vIcwhl5UH79oLsqaWq1U0+/SC11hwqviMGDTf+1PN6RDUTnUYqQDFw68oHot
	 i9yqv0zzhb9yopSOYr0eji6nYVrYkRnnVyh4bqhGzO8S088aKwReinslJNXp+Xd4N/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qhNHjf1SdugrZ5BSNouBIP0FOeW62fEzpK61bFfdG/8=;
	b=V5wZfrR52yJuV6lVo3y6aYlnSd6svv2WTOHPg9ZlIi9q48t4ZtvPkB8fnCRQ7OlJ91JO
	 GySFZNnJQ74+WU9dunHBVUCQBtjji4a/h0kuCfRJ4PCY/kTaX8RLTweAvOc+EpjTU5Q5C
	 r1FUuGl6O9/Y5OM7fYihNvGIi7F4hEuxMGurXVye+FRsYK4cKuX0qQw2QmjuOHkMyvMir
	 8iJoHxs7XysjJav8z7Ft0lro/UF3J8wwtFjPR1RQT3sYNd/7OKYgpkQXTtebia8/JsLUf
	 An+42/fBozmSINeB7FjOFexwJ0ZgByuCQvn6fmaCQcrl9e1lEf0MJRdgIcZ+MoWD0Pg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=P9HefTdG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921AB606A33B
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 08:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 921AB606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=P9HefTdG
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so152850966b.3
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 00:47:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794559623; cv=none;
        d=google.com; s=arc-20260327;
        b=OiFGr+vi7YopIQH2cDbhQaIVAgvSFSFL4hKmMXRjAipn7nNcSrxojYB6va23/IcAJg
         c9hgt5ModUiyhoqG3kxJMlLEHeImrTaC/dSU/7kyXfpnWXteAxg3b43hwC3+nitNrpeY
         bAR12HCF0E81ISfzsgjHhlN2sDDTH3SBaUrIbL7Mp3j0HmcdGD9QdragDuTQJzvdUkvB
         74RbMpDaRIsv28v2dlH0R+6ZG9um4iYgP9hLgbkFJK3Z8qUMnuoCWXCEkrG5axvSM1GB
         TtTEn9ANWuAJi2h8JXVEd1p5jkyHuxO0t13XzvvdIITq7I420ZAV+RJbBty4DUch8qiB
         ScLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qhNHjf1SdugrZ5BSNouBIP0FOeW62fEzpK61bFfdG/8=;
        fh=wP8+fRVU/cDqNXkm4n28QO0qbAM26r9oMJ7JhzAuseA=;
        b=m7yZsUlOBx2NeTPA1oTkSvEmgULQ3aASKWb6JQ4omca2ELJSNup/neK37E7oy94Hc8
         dGOQPjdQmfa7lxfNEz9cnHP/7i5eAr4Ezi4Ugb7Qpc2Ab1LCWTCs93BvNpOa0E72F8cB
         ZJx16x1XRmtUGtYycKoXN6ugLRxtW4WeJvIwj7qyJp0O1HepPUjq1e6xdFtinIj2jPyk
         T0eKPtOGWtqVxZj7IkiEE5afaO8YsWtn3YxWF6V43AFFRq+/1IRkXqCyUyiA8n9vV8cD
         FxS+uluMS7Mb3uGD+E+cMziq1assqEzfW0qA+FsgJxF8z7HxZGs6nFOTeMzAdEOWDd1v
         Cotw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1794559623; x=1795164423; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qhNHjf1SdugrZ5BSNouBIP0FOeW62fEzpK61bFfdG/8=;
        b=P9HefTdGbOr3Cjx77WP/gONEScRFpMiSJdQhqlqAdbnzA9Cb49WtvT/xdoRlOKJt3K
         tF9lhpjLgfHYP3FeCYmS0DK+TqIIkmoVqW/RR7QDH/ywMAvHbFJlNr1UzLxKR48Yt8TN
         SjvmhPdm7vO6ZhfMPSSEfifIl1J5D1hCpTzLqJb0DC1wtYL0Y/B8Jgs1jW4xqrykALYs
         GXS7PBIPBKpbhmjYWJxlkG5U/8f9HrLA4Lvz6WBRffI5x9hFgAyL3/yiN9sc28wSlzNe
         HKQH8R+gU3pNiIgqsXfyp3p3Xdc9dbkcbmSwAkSQpSEkcIFkoU6ZT8MBMOrGSA7gqW4c
         HWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559623; x=1795164423;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qhNHjf1SdugrZ5BSNouBIP0FOeW62fEzpK61bFfdG/8=;
        b=iLoHMQTqK6u+S8yQvIDcDfRPlGx8eAWQ7zSMIss4us3Wr9DWZcHuxLiJfkvxiQ9wnP
         cPbw7fzjvjpAE91Y/D/lP6Y0jtzdtIawLSg25jobAGSKMsiXPlIOOZb8fU0P8dNbI+tA
         0lCDfVS2/XuSqhmCn3290GukobGUC+DCaBsnrstk89tJlPotAGt9NuquoXKhI5eeOywv
         3gvQ/Hza5KjyzhZN6I6IRlG5z/bJxMe3l9SWq57bD/aDFyT7qjmXWhvJMYO/7xDwjb7C
         awnDNzIPlaxKQtg/3xMH2JmHofiFymLhK+2m2LYoKuO/M26yl4lLSh2x0TFuhTyT5m9q
         /hsQ==
X-Forwarded-Encrypted: i=1; AL+hErFZH7W8Bk333yxKfmnHWGhhXAYTnUagWzKwidwiIrSymB40qt2E3wjn2jUhNb9xAlPUXPn4TX+fYKA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pq8C1s6/3v9jDZduVFeTjtR+kvYEaS2uDqIDsUyKV4CvceDqy
	pMmKqGaYuoZ4l6M1DH+vRpVazDq6+Mg6E2hZ2bNWMLlbfKjmMVIJnbrjJmGdrhwc9vrx2sIunrm
	/h+rftiYVAoppqiHgfwoFL1hBwKofHzKmQB26pH63JQ==
X-Gm-Gg: AYBFou3fvJBZpsXQkgWAZDsQE0yo4GEVOKlpM5T5mlHLl0s4Jve1DRg0yUxqWUPqTkY
	ovgfjUvUdSy+OHy7mHTuMl2mNcUxAE/GMvpGVxdSUz2K6yP1GkwnGS8JIohVXOM6pwsF89QJBNm
	8T43wBATNX1BWOE42QN3SgfW0ZPS+focZ6+bwbaowgbwOALJAI0yi2faFGX+K7shWLYPJIwG2fC
	LZ47h9Qk3fpTUk0KQgSIImbwlRAzebR0fozn50VfSmQqRp2cFOGBLWKWmF27y0KOVv/WhiIzWX0
	0PTPuQfnrzn6/aQwDk/SKsMFTgB7o6ZHqp64s9BK1CF7CBmikfGCvNXBemfwv1HmKwPAQyPQH1X
	5GGbg7Q7lfLEEGvMPEmNvhpOrQ7iNyRDzAeoEo/mbZjqBCD+cIuKBmV6ae5fTJ2Xmjfgk
X-Received: by 2002:a17:907:3e13:b0:c2e:3ed7:7db4 with SMTP id
 a640c23a62f3a-c5096340feamr135396666b.23.1794559622820; Fri, 13 Nov 2026
 00:47:02 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <1766560210-100883-1-git-send-email-shawn.lin@rock-chips.com> <1766560210-100883-5-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1766560210-100883-5-git-send-email-shawn.lin@rock-chips.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 13 Nov 2026 12:46:51 +0400
X-Gm-Features: AclHuK-fnCfqep89v60X_1kiVQLyjf-ZvvNw6LylrxXymHR-bVpgT9BeqYnaapI
Message-ID: <CAKTNdwFfQyMGJQnFU5cwQyOsXvEx4NowOT6n-jPkM4b0zGX50w@mail.gmail.com>
Subject: Re: [PATCH 4/5] phy: rockchip-snps-pcie3: Check more sram init status
 for RK3588
To: Shawn Lin <shawn.lin@rock-chips.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>, 
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-phy@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>, 
	Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

On Wed, Dec 24, 2025 at 11:10=E2=80=AFAM Shawn Lin <shawn.lin@rock-chips.co=
m> wrote:
>
> All the lower 4 bits should be checked which shows the mpllx_state.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>  drivers/phy/rockchip/phy-rockchip-snps-pcie3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy=
/rockchip/phy-rockchip-snps-pcie3.c
> index f5a5d0af..6cc38e3 100644
> --- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> +++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> @@ -43,7 +43,7 @@
>  #define RK3588_PCIE3PHY_GRF_PHY0_LN1_CON1      0x1104
>  #define RK3588_PCIE3PHY_GRF_PHY1_LN0_CON1      0x2004
>  #define RK3588_PCIE3PHY_GRF_PHY1_LN1_CON1      0x2104
> -#define RK3588_SRAM_INIT_DONE(reg)             (reg & BIT(0))
> +#define RK3588_SRAM_INIT_DONE(reg)              ((reg & 0xf) =3D=3D 0xf)

This breaks PCIe3x4 on my Radxa ROCK 5B, which then cannot find its
NVMe root filesystem. Sebastian's rockchip-devel branch carries this
series, and kernels built from it fail with:

  phy phy-fee80000.phy.13: lock failed 0x7, check input refclk and power su=
pply
  rockchip-dw-pcie a40000000.pcie: phy lock failed
  rockchip-dw-pcie a40000000.pcie: probe with driver rockchip-dw-pcie
failed with error -110

The RK3588 TRM (V1.0, Part 1) describes PCIe3PHY_GRF_PHY{0,1}_STATUS1
as follows:

  bit 0     sram_init_done
  bit 1     pcs_pwr_en     (reset value 1)
  bit 2     pma_pwr_en     (reset value 1)
  bit 3     mplla_state
  bits 5:4  reserved
  bit 6     mpllb_state

So the lower four bits are not all PLL states: bits 1 and 2 are power
switch enables, and the only PLL among them is MPLLA, while MPLLB is
bit 6.

On this board MPLLA is off even on a working link. With this patch
reverted, PHY0_STATUS1 and PHY1_STATUS1 both read 0x47 once the link
has trained at 8 GT/s x4: SRAM initialised, MPLLB running, MPLLA off.
When the check fails they read 0x7, so neither PLL is running yet at
that point, and checking for MPLLB instead would fail too.

Reverting only this patch, with the rest of the series applied
(rockchip-devel at d7436346fc31, v7.4-rc2), brings PCIe3x4 and the
NVMe back.

What is the check meant to catch? If it is PLL lock, which bits, and
at what point, would be right for a link that runs on MPLLB?
Otherwise, sram_init_done (bit 0) alone looks like the right condition
here.

Best regards,
Alexey
