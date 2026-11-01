Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793523434;
	b=wrcfGdjCbVaF1LhNjoR69oYvlLD5AZJ+G4yIAQbIzOpWqJnfHBtlxo7Rdy3TEDG1HJR/
	 EsF7UqiICD9pfaD36QUsDMKDK0viMpF+4xufMsf2Xz91lkZ/8jmbPMymnc1c4/lDcdsnB
	 e62pLdxpDYJeBXbCWZf0YC5jhLAO/pmxgOd9FedvRb/mV3qZL3QJ75tHJf+24PjhpAOP3
	 oYHKyenxEcdoxTcpUeSqgveE45GKLKBIizCn5smYtrQb9pa3/y2WGFP8xlaVK7uj70Uti
	 zsTy38Ga+xzVm30bGk9HEXJW+4kz0gLmnJXsRMAzc+QJnIy6gobJ7RjscYsw0XNrehA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793523434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7EsnCPk4RiF2PEHjx3fU/KxMK5RivL58Fapzh0X8PUM=;
	b=W42yuPG/4dDHowvuOE0wA2z4HsaTRjjgCmtMqgq8vchAhGYT0SdXMSnDC+PD0C4TJDBO
	 BfU3i3MijtD0kQmA8OnqQ91xp0+ZAwxch7vAT/mjaH1KzfueCzQgRhce0hJS4II9ByhQC
	 dG4BZJ+UYhGdKSNb+7i6J4BQfG3ney6NFcy1tMaA/KLvO+axnyZliPcuCgmDzy+nxwLrI
	 jMPPz2VXHRGbz25xjUxj29v1c1W9H7uACGaewrAXZK7d35L4pP4FMT8LntF+CG+s628AJ
	 q+/nMbJjn8xIHoccER8HloPYcBXDKMNSqXCHdnhlGTzpkLQD970Jduvn7mQTh4uvFrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="lMY/TGSa";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37229606A324
	for <linux-pci@vger.kernel.org>; Sun,  1 Nov 2026 08:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37229606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lMY/TGSa
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-19305bcb72cso1431308c88.1
        for <linux-pci@vger.kernel.org>; Sun, 01 Nov 2026 01:57:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793523433; cv=none;
        d=google.com; s=arc-20260327;
        b=AxZxHNAuJHGclmXcHrkoAzWSknr0GGqQzcX8FMuuroVnTUxLNQz3JUKMPrZM12nkbE
         EQetpREcpv4C57KM0Z45uaI9s3bBfoeyWV6ihrUG79HUZ0vGSLHpV5TkI3M28WzlZyut
         yb+/O2Gz+sIxkM3u0PNLuMP9vKX5LZnee/B+J9321fLSPbsvDgccSTqQjIwozhTgnfxV
         x3Xp1GVChd8hzqxUf1TXSN67MJDJ+cuFQqqc+2xl80Ld6Igw2cYSTu8/MqS0bZ2ZGvoD
         c3vNZAjZB0uk0ccPOEOKd7Sqo/0EZVKk1lIoLSEl5W2TpOz9F+eqipnOhkIv9CdcqdOK
         /EiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7EsnCPk4RiF2PEHjx3fU/KxMK5RivL58Fapzh0X8PUM=;
        fh=qvOtzIi6K9YdPEd+wjp/8EsXxdvq56eAh/FKtQZPXQY=;
        b=lCkZ2sFSIVq47cZtKt4TY8myufOREAn7u+DoMjtCryJhnG9QvU7Xevfg0slmpGGg+K
         dy3/RF147hIaBEimElZK4j+Myau9coNAJ0S9X66inUF/Cc9dL6HoErdH26gWfBsJM1JM
         I36x41KaFzLAEGFtQAynLpzgy75N2t/3a1TA/PEzxssdcARm1rrt9EGQCVNVzkupc9IM
         ZxCthNqksEV29LJ9Gsrv3eeVyQKB9c88WzMIub/nKaV0LPq3iSYnHBii9DcFm9VCNkY/
         ixxKmNJsBX8NBJ2mw6bI6iYrjJlVmUhJ6wc4TQ0apY/yjzF4PV8BIne4dFxJ9Bfghpn9
         hMig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793523433; x=1794128233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7EsnCPk4RiF2PEHjx3fU/KxMK5RivL58Fapzh0X8PUM=;
        b=lMY/TGSaogsOEauCsh+CyhqkTn4rDWf8Essg3a2dLP0h9Gr/SrE7Sqw5hWF5VvHG8n
         JrJN0dHuk0hXdgN7eGUaZ9icXM9iH+Y8zt/d2BOXig6pNKJDCGSH7NBOhRRoZgMzEYK5
         9cmSZ/X/cZSVFTVaYxa03C0vDDlATRHBzpK9Dk+pQ/oob2ywC6MVfPoBl2cN3YkyfsRa
         WiMPxMMm4rDiGUlOqW9lYYe3fw/DBEkrj6SHt7OBX9WTbCiLCTFQJm1MPLUvF5hAjCUC
         3e7xAlSIOzO8SJ2QTQFgXcGvC6UJCFcGEf+4rSREknW04H6GqwnGziJf5tqaXNa2KNzP
         UqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793523433; x=1794128233;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7EsnCPk4RiF2PEHjx3fU/KxMK5RivL58Fapzh0X8PUM=;
        b=wv3CQ3cLyopY+TrUX+aOIyEmf3jyc3x+b81ZjX7sPmTIwpkUoYFM8nUnqG+zap0UsB
         kar/4c3Om9fdeCmxv6I21IgmRetMui0ebuqL62LCQnBunQsNzXeRADCFds9w6MQb5gil
         dPOgYaOY8Sc20RapnSPXEoq4eSbF/j1FodM+fmb8tv9Fh1fiJb48i+HrryAUPNcvCuJ2
         9FF9odSl+/tpxe01D6YD7zK8xWjF+RpPvI5F5Je6kCNAY+GiAklH3OClgkKTLYA+SXcV
         xiXBqlunHSrysYylaWy385/3DMf9skSCsQUFxWhvpcndijkMuDzPHfl4hOojGzxR1P4u
         AXiQ==
X-Forwarded-Encrypted: i=1; AKwUvBxmvV47OaFJfGA3AVBJauuXxHv0MFk472aR2xYrinIF9jeSFBec8Cq/vbN7wCUL4er+m8jfd9HujSM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcCDWZwPIsW6B7dCSS2zEu+G6aw6cc5CneWXeDWZe+ClOS7ZVY
	rIlCw5TBe7HE+dIcBzKTgC8MzAIMrH/KC/IXYRc694biwKg8kDhvBLN11wuN0GPqhrtqjqNYgWB
	OkMntym88NgIiOxu/sOpfdASU9PdKvJ4=
X-Gm-Gg: AYBFou15c7BbNBjd0KlAo4ztLmVC/5pw7u9c7E+ZvPJVpiHB3ldic9ZdLCshuwXZlfw
	RVWCwDbvdKRuh/47oaNeOJvAA8J5l4q59WCysLMWax0dL+UCQmJXxS59886XVUSGc8yXtLnAEp3
	LhmuIMu4UACKXo0mHkbSyDjCedEcD4abt5ZU2YTVgd+Jx2I4Yn3dVzGN6UiKOEutiAO/AP9TmBT
	+GC9NGt5h87PERh97eTsOKXrWzDuG/qMCWO2iU/1hr02acklG2R1oGdTeluBaHstF/KHLaKBsnj
	5X7cDh0Q+I4jio/m1CkbcnOzVJ7EQWlIitRRP+bPAGGfuno4F7zNaxje5MsaWf19oFmYPqq2IJU
	Pb4LaP5jcPUvzxKNsREZhae2IKbAVz4TEDA==
X-Received: by 2002:a05:701b:240f:b0:15e:6541:3099 with SMTP id
 a92af1059eb24-1ac5a0b8b3amr9647957c88.7.1793523433136; Sun, 01 Nov 2026
 01:57:13 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101070121.2714-1-sreekuttan2156239@gmail.com>
In-Reply-To: <20261101070121.2714-1-sreekuttan2156239@gmail.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Sun, 1 Nov 2026 09:57:02 +0100
X-Gm-Features: AclHuK9wgaJ_HkNnJv_xBJjiMMzCDxyfUAruQ6NGbegvoXIPxxM6IwWV1dPVkkM
Message-ID: <CAMhs-H8qmxZZ=6LD2qCJfM0AciX60AcPz3pqCp+gS5De2P-bYQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: mt7621: Fix reset control leak on PHY initialization failure
To: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 8:02=E2=80=AFAM Sreeraj S Kurup
<sreekuttan2156239@gmail.com> wrote:
>
> The PCIe port initialization code acquires a reset control handle using
> of_reset_control_get_exclusive(). However, when PHY initialization or
> power-on fails, the port is removed from the PCIe port list without
> releasing the acquired reset control handle.
>
> Since the reset control cleanup iterates over the remaining ports in
> the list, the removed port's reset control handle is never released.
>
> Call reset_control_put() before removing the failed port from the list
> to ensure that the reset control resource is properly released.
>
> Fixes a resource leak on PCIe PHY initialization failure.
>
> Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
> ---
>  drivers/pci/controller/pcie-mt7621.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
