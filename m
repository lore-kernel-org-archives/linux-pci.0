Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582F133D6E6;
	Sat, 28 Feb 2026 06:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772259410; cv=none; b=Y789Qpfh5Jt3g6dMwX0BAHcY32yiG0FlKdDrceTSSezI8KJTU262Y1CXK2Tf8D+fn6AXIlG/OXEppimeOURRVEyhoFS9HjoFq/Hg0EPvywlhzWEfBQRtzHj5+FDvsg+2O0iz9QoICH+qWGNDLAnUo8hinsxKFvx8mXpcpxMegDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772259410; c=relaxed/simple;
	bh=2ffsW6GdGxZnvDDyk8rHFMnSQ21RRKEX069OdnQFCZc=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=c01BF3YCHD6eBJwr2UleF7FUUf1c/44B7v6a0GZTasnYBNiNALF/ClGakzE8GpXps3f88KxL8FTZ1v/ZlbpL0BlWM9iBLJJPBlL3kfCUNc8ywn3xB3gQhefJcMqYfeVusQeivTNlXmgfdQJhuMiPSsFLez/91S9KvvX0t0VLVcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=mifTh5yI; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="mifTh5yI"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id DD03E41FA1;
	Sat, 28 Feb 2026 07:16:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1772259405; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oCnDQ+Cgo3/mYIp2xchNf+7hSQRwKXW3o25K0mtFwcg=;
	b=mifTh5yIJLK1ISJhkH0iQu8WWSc8bdFeddn4Bp5PB7nMjY9UEFnsVtKWrT9n/hsh0rne8i
	Q1yNpcyfqlgTB/53328QujCxxaH7fzv40A1VNIE89O768UOfgljFJgqGzidJ29diO9PQsS
	Ye7udeuU/vN67DmhhUc5gEvXgFhzjVSSvuh2VomTnA+m9wsgCaYLCxKBsXTNL8bKr+FHcI
	5HuHwxB35suC08+u8pJ+s/f+7uvZypjgz+jAyCmawmiil56itFfTWuffodL8OjsFlq/nw8
	SjCs+hwYo0VRKnpGXrXwCOgSZym6l56fcwJ4aVijGMKkw3/ROO5hbaFaK/pgBA==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <2a0a4aa97bb8b0cb511cb651c5d66c9ec8bab97a.1772239598.git.geraldogabriel@gmail.com>
Content-Type: text/plain; charset="utf-8"
References: <cover.1772239598.git.geraldogabriel@gmail.com> <2a0a4aa97bb8b0cb511cb651c5d66c9ec8bab97a.1772239598.git.geraldogabriel@gmail.com>
Date: Sat, 28 Feb 2026 07:16:41 +0100
Cc: "Shawn Lin" <shawn.lin@rock-chips.com>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Heiko Stuebner" <heiko@sntech.de>, linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: "Geraldo Nascimento" <geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <d2b91260-7666-3606-69ec-0e7cb7a48c02@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH v5 3/4] =?utf-8?q?PCI=3A?==?utf-8?q?_rockchip=3A?= 
 drive at =?utf-8?q?2=2E5?==?utf-8?q?_GT/s=2C?= error other speeds
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Geraldo,

On Saturday, February 28, 2026 01:55 CET, Geraldo Nascimento <geraldoga=
briel@gmail.com> wrote:
> Configure the core to be driven at 2.5 GT/s Link Speed and ignore
> any other speed with a warning. The reason is that Shawn Lin from
> Rockchip has reiterated that there may be danger of "catastrophic
> failure" in using their PCIe with 5.0 GT/s speeds.
>=20
> While Rockchip has done so informally without issuing a proper errata=
,
> and the particulars are thus unknown, this may cause data loss or
> worse.
>=20
> This change is corroborated by RK3399 official datasheet [1], which
> states maximum link speed for this platform is 2.5 GT/s.
>=20
> [1] https://opensource.rock-chips.com/images/d/d7/Rockchip=5FRK3399=5F=
Datasheet=5FV2.1-20200323.pdf
>=20
> Fixes: 956cd99b35a8 ("PCI: rockchip: Separate common code from RC dri=
ver")
> Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21=
b@rock-chips.com/
> Cc: stable@vger.kernel.org
> Reported-by: Dragan Simic <dsimic@manjaro.org>
> Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>  drivers/pci/controller/pcie-rockchip.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/con=
troller/pcie-rockchip.c
> index 0f88da378805..2f211d1f4c7c 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -66,8 +66,10 @@ int rockchip=5Fpcie=5Fparse=5Fdt(struct rockchip=5F=
pcie *rockchip)
>  	}
> =20
>  	rockchip->link=5Fgen =3D of=5Fpci=5Fget=5Fmax=5Flink=5Fspeed(node);
> -	if (rockchip->link=5Fgen < 0 || rockchip->link=5Fgen > 2)
> -		rockchip->link=5Fgen =3D 2;
> +	if (rockchip->link=5Fgen < 0 || rockchip->link=5Fgen >=3D 2) {
> +		rockchip->link=5Fgen =3D 1;
> +		dev=5Fwarn(dev, "invalid max-link-speed, fix your DT\n");
> +	}

I'd suggest using a bit more formal message here, like the one below,
which would also avoid addressing the user directly:

  "Invalid max-link-speed found, limited to Gen1 to avoid data corrupti=
on"

>  	for (i =3D 0; i < ROCKCHIP=5FNUM=5FPM=5FRSTS; i++)
>  		rockchip->pm=5Frsts[i].id =3D rockchip=5Fpci=5Fpm=5Frsts[i];
> @@ -147,12 +149,13 @@ int rockchip=5Fpcie=5Finit=5Fport(struct rockch=
ip=5Fpcie *rockchip)
>  		goto err=5Fexit=5Fphy;
>  	}
> =20
> -	if (rockchip->link=5Fgen =3D=3D 2)
> -		rockchip=5Fpcie=5Fwrite(rockchip, PCIE=5FCLIENT=5FGEN=5FSEL=5F2,
> -				    PCIE=5FCLIENT=5FCONFIG);
> -	else
> +	if (rockchip->link=5Fgen =3D=3D 2) {
> +		/* 5.0 GT/s may cause catastrophic failure for this core */
> +		dev=5Fwarn(dev, "5.0 GT/s may cause data loss or worse\n");
> +	} else {
>  		rockchip=5Fpcie=5Fwrite(rockchip, PCIE=5FCLIENT=5FGEN=5FSEL=5F1,
>  				    PCIE=5FCLIENT=5FCONFIG);
> +	}

I don't think we need to emit a warning here, because, as we've already
established through earlier discussions, the rockchip=5Fpcie=5Finit=5Fp=
ort()
function should never receive an invalid speed value.

>  	regs =3D PCIE=5FCLIENT=5FARI=5FENABLE |
>  	       PCIE=5FCLIENT=5FCONF=5FLANE=5FNUM(rockchip->lanes);

It would make most sense to squash all three patches in this series
into a single patch, because they all form a single logical unit, which
introduces changes that are just going to be harder to track down later
if it's all scattered into multiple separate patches.

The only possible issue with the squashing comes from the inability to
have different patch subject prefixes for different driver changes, but
I think that's actually not an issue.  The long-term benefits of having
everything as a single patch outweighs the benefits of having different
patch subjects with separate patches.

