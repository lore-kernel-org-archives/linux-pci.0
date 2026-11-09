Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794189793;
	b=3fxVyQGnBjPDZztWV7EM59tyBkWa9xc6WmjpidMTtShsObG4so6TkyB1M3nIpZzOvI0Y
	 VRiiXugGPNUUBzn9ZIbptnnHyKuXnuxQeUSoZHjRpwzpy+WzGmsy3RQZ4yBykBg9pucdO
	 mHoQQc+yiZXSsaX2c5W7Sl4xwc4HMTrgz621tF/L2KU/BTz5iLW4yGqWUfYaiLTPpw5Nr
	 eEEn1RpIY/nHHTYIRM1ovfjsRPp2oUisHbHGH1ZMn2sMDxShHMMQgcSYZuqd3Vo3ueq88
	 h9wEIDFtwzTsBUBN85qCNmwxyPtUDXCWnbwk0S1w9fQiVeH8uNVfUsIm8Qe/O4ye9dQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JHVLOFSLCv9GVsq054d9bMCs6jEJnblXl1piTel5GUI=;
	b=WIj9Qc5F5fS9SISSPIeuJ3TeGi/PosYC287x2TJ/efYNikQ/eJpw3VKiPhzwfQZi7wMW
	 584GQKmXvNlliC1onGlPd2Dc6uKvV/42rxq+W/+3556+PhoQF822DS0m37o7TcdotJum/
	 vvqJaG+MqxLSbXTt3SIbY7X0cByhDNS/oJUlfPkJ1Ov5JPR9U3Nc27z1xIauqU9bmjz2P
	 1aztjbTA5tl3uO7O14qkUyX3+uZDStrFx+X5CJ+FKZ009vvdmBcElrx35AhnhJ4ZlxXQV
	 eAyTi3HaiKuc0+R05jZSEA9hJ72UWp4Ra4nfvDvKyjyj28jcp4ErpEPJ9Mi84f0IS1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gU7tzgd7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.42
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B36C606A31C
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 02:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B36C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gU7tzgd7
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5c10dc41270so283463e87.2
        for <linux-pci@vger.kernel.org>; Sun, 08 Nov 2026 18:03:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794189791; cv=none;
        d=google.com; s=arc-20260327;
        b=SeqZZh+96wKcsEcNA8Y8iqCv18uZA4LrGG/akc6oIanIoy018Ux1OQdIJtT9Qgy7HG
         0iSXuE5v25a8LzkdioJnyvpmWtD87OKVh8TgcYCdciU3HPHAhjsepA1Sa5qYkTpwA0Pw
         /lhLiL4PnXHAFueTtv0YKpdVjFHeInJplx4vy3Wm6QRJzIGZhbWUX75yuz/zQ/lbLQYV
         Z9fQDM2FvRKga57JQBJH5+tTPYVmqBGaFIBHHiR27oLKZ0N0hw20d10wT5Nx4mFrYuMk
         XHsiQu5g08To88MbTuaXUqtpZNeafaLu5PAB2rST4NlKJ4P235AioeDIpThLqgbNf2Ps
         VdWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JHVLOFSLCv9GVsq054d9bMCs6jEJnblXl1piTel5GUI=;
        fh=I08A8X3XL2YfAhi6PTzwZAmBgVurAup1SFQDjQRaNww=;
        b=pBRs5oRqS6d4KkTD9Q1bCRPOwkCPsRTWGhKUVFSi7aJIWZvTgdXkz7ngcLqOJRH9tE
         HUtbWG3YUKkq7Id808j3RG1cpGMhLfz6LC+BvaGFTWZl2c8cG1yEL8XQaRFrfom5/BDc
         v2K8+L63DhTtgNDZM7fUDeL8xZe6mhME0/ErxQsYJsul6/HyVVO5u0CBhY75JCdkUS/x
         4kNivE9Zx+ybAqVZhVtXgtOne7IaJ1mbqzQqavXINTpsM1anhKWtqTezQ4CmNY65fJfR
         ctwve1Dyz4Qr50kw3fbQoQlyAPVMht72xVGWksaWqSy2IdKQfFf6wKqJhSI6o1HW5RgX
         BGcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794189791; x=1794794591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JHVLOFSLCv9GVsq054d9bMCs6jEJnblXl1piTel5GUI=;
        b=gU7tzgd7MExahHiRbCCINPw5gun+4aXU1RjNEpt8Ppsbkxat0Yvq9blzj1LZyk91Yo
         v2GvsProReBVRBMqbOtskIRTtpmIml8qt9GbxKw9ivXfFXJgr4sG/RJ3Gkc1EDx1UpV1
         WIhdtbeRwOKtoz3wz6/n2N/Nw57+Jt0GWBSsInBIqwgA2q14XWc2JV85gyQSDLn5AwSw
         JOW9KBrBouqJfL0Lq5HKHvQaeZf1Uk9wbq0Iry/CIjE8RLu0PapRJ++n/SvUuI2LV4cb
         /dgXLi/EvjD6dHgznH6UtPMd5/2BFfZ9zYn1Jl3zD+X2P+TL7pNZbIB7a9XrE7opbNgu
         8IFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794189791; x=1794794591;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JHVLOFSLCv9GVsq054d9bMCs6jEJnblXl1piTel5GUI=;
        b=KW6sEJsQRHZvovS2ALwTtPi3WXjPwyluNxTSBXGKJvuNHXxH9SbKwbf/hSC8V6ttAl
         mhPkyJ8JfWkVgCaqIwevX3DVbyxtSteldBh3plJE4AaN+TUqbrPzhiHYhVFQUuzT0s+0
         EIgSwi4a/IBwp9FlzQOD+/hmCclDaZHYgwqv2x8G0T8EfFQp/9uJw11OJFX5+yxyfnE8
         8CqWafe0kyB360gDolx/Mojs7hO/1L6enEQIe1OrclZvj+3wg4E0JPGDHE+vaykZ+SoJ
         Lae10be5TMfIcqKcYRNE5MC3TOEVZMuKqvY0D9UFSRpndKmTrOoRkgnM+MP9qaREayZT
         +zdQ==
X-Forwarded-Encrypted: i=1; AL+hErETwwlP9AGhdWZfgu76YmsybfeSBkCU371+ZRcOI7dm8dxed49i1p9yXB3CnJebtUWzVetn8KV0yco=@vger.kernel.org
X-Gm-Message-State: APuU4Z/W7xhvvbSjCIugIH3Lg8a2NbBhxalYdAcKJhX+iyXSEEl0Cv+0
	ln2GMiXZDuFWOOpRX3Pk38OKPWQtByUPcD18bfuA5d4uo/ckt2g8qjvcVeROybyWyPxbniQ3vFB
	wVnByk3z3l+2qWVo4+E47C1koLsFmfE4=
X-Gm-Gg: AYBFou1jKfJ+4hROtTsvG1AYZ7Or0RTCDwXxbVzZgHNnPZjH6GKyfhjM1+k+fBsWeqW
	ZGItDvyIGFPrBUAF7rQFqk4ig+nG9o4w98IMFAc1DZEoKA6qrcOzG6VUWQXNzGPCsRi3dEi2U8h
	Oe93gFDDYSD0Bf3ShNLZYj3vsc1bJeDOAlAS4+ONXhTB9C/Np7BapFDgocljc5iaVXKzUGaeBBb
	beIBanAGpCmyePaWB0eBzMfwlm8P3TyAS0MSJwawE4yrvZzqtub+Qjm17bNXqksnyzgUhpCMuRE
	yadSOouu8/m0u5vU9IjgrJEq9MC+ujoJ5KsFyIDXI8WCd9zI5BW/oyNUCHy0lDTC0xXg26KS5nP
	fw8oYKHsCv17krrsiLF8G+Kd7Nd1UkmPDdw6uwFhuadhNhXTgIRurOVnR65Q1KM5rNlGFa/zSRl
	TFL9JXebE99J6gK7YNqOkNXa0qCz4=
X-Received: by 2002:a05:6512:220e:b0:5bf:bbcb:509f with SMTP id
 2adb3069b0e04-5c14c02e15emr627836e87.37.1794189790992; Sun, 08 Nov 2026
 18:03:10 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106090342.2601665-1-hongxing.zhu@oss.nxp.com>
 <CAOMZO5CQtcpb04Vp49Rg_+DHoozRpQthW3_YNAYQHqi=VOmpEg@mail.gmail.com> <GV2PR04MB120197A63428B4142714A8F148C732@GV2PR04MB12019.eurprd04.prod.outlook.com>
In-Reply-To: <GV2PR04MB120197A63428B4142714A8F148C732@GV2PR04MB12019.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 8 Nov 2026 23:02:59 -0300
X-Gm-Features: AclHuK-L3h5gzP6mZBeJdIsXpM-rka8mrZeT_p3Ww2YWyi1VobDmgIX4-64aPE0
Message-ID: <CAOMZO5BLAnXVRMQLz2pJuJfcGgDWiQcoZ+APfYkBd4UainfJrg@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: imx6: Enable L1SS support when supports_clkreq is true
To: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
Cc: "Frank Li (OSS)" <frank.li@oss.nxp.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>, 
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hongxing Zhu <hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Sun, Nov 8, 2026 at 11:00=E2=80=AFPM Hongxing Zhu (OSS)
<hongxing.zhu@oss.nxp.com> wrote:

> How about to update the commit as below?

Yes, it looks much better. Please send a v2 with this explanation.

Thanks
