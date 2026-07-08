Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879353750DC
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526743; cv=pass; b=ln22NXApFJ2PNJVXvbuEjt7DckSYYnvsT1v5Cnxhu3kkFtQ9uFTLJkbKJrNBju5dNDpjJJtycyduSoLiPTeMUuYbfXKQXgFL8YuC9GBMtjw662KXMDwe/BoIYarnyHChYYyw3uoWcCGDsku4aF3+nXY8lNhFF8EHfgWAU6Ieg+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526743; c=relaxed/simple;
	bh=waOMVw2yTWW8WtkFsaHmffSfJuGkRkMHmMfBNtV/t98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlGY00L99J1kEc3Jo3LySsjruzhlKHkj4YWZvsc38mSOqBVu63FX/w/7BE4Su5Kw9/nwdJGa9QsHkQ4D3+rVzh9bETQG4TUTgZeQq2PWqseE8EnKunFE43hc5ysKtlq/Igg3vzID4h6BVT0glZ+ytefzDaE+K6OeZZrrjBaoqpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0V+MGgt; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0V+MGgt"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-664a09bc459so1213765d50.1
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 09:05:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783526740; cv=none;
        d=google.com; s=arc-20260327;
        b=cydC++yPR7TtwC7qgYRZo2rb+TudBy58zQFDoURab3h+ld102RxgxSLN5leYq9xSE1
         EUvGNmf79ff2ltn6A8g0DlnDiFGlHh2C9pFXWVoqootk6vccXXLUcO+jHfGDuTvHG08u
         COdkfQ1rsQfXt7KCYO2U8jtC4474oPJxybpICXHPuwmi0wDriKPvRvBV3ZAB8dZCEudP
         Jv5tL8mMmtWBC6pzS+Yjxehp034OIQKoGyFDuMmXtkA5Zbb4DqO8bb+lCCtRVPVH4B2i
         b1G/s/ZeC2MIjpUdW9OUP0b5Xj/XOcucjWAZTgngDEGlMGO3YZUwEuC+CoG5vFP9Emx4
         02kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FuShbMRKE0SZi3ijoimKFf4ervQLR1MwgbAPy6duExE=;
        fh=2hUtrZ6II0ABexS0H7AAmwsCRRHQ76SOrQV9v6Alg5w=;
        b=YqReoqHPpJDgcArtU0UFJaS2cXZSZN3x0sdcFL51vWLE8vLQhMFnTUYuL0Cjui6dos
         h0Jpb7rhuItT1vhHvP47HrgpC0IVzAk4+Ci6CcS661RJxtv+n6UW2cX1RJ07BrGEKpJp
         74PTPPd6/w6mIcspooneSlrB5+3s7T1PNI/11j7eJQm3U5NfcMBsB2BZWPO4ss0mcFIp
         jN/kkpSJCWFHIoAxtf4N94Qc/HYnmZ8RMrskRjh6V3ihQlemFjQNyPxsgBrivhk719L7
         BllZhO71RMzdsCpqcJZlDw3XQtbfSYpWjLZ2DZPn8t+v/BXlDf9RO5+qDQQWvVrFVv4e
         y++g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783526740; x=1784131540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FuShbMRKE0SZi3ijoimKFf4ervQLR1MwgbAPy6duExE=;
        b=N0V+MGgteouYwFDHm/PDZPIHiMNyjB2a7l6USpl0dDm55lKMdUS3isL4QP4UHzC7x0
         ejDilo22JtboF1qMjoHNNDXvSB2TtZ3eFq7fz1VLcLCEFVW7nXVGd9NSvBWoe3d4+yI+
         lzjAvxBPSGZc5klOYah9CkNCiAWkRtbZzZ4vQ8fhvks4Z1FPb5OmgNAVaBuF4U+ko8k4
         0XAJwLCWa4bRKyqce2ne84XroFJLntiDIWBF9Z0sYVgFixlYUAfDBFzbnY0ZUuVBJXVI
         brptftxgdVAAINd9lgIBlO3WgI1XcVyo2BNeorbYqvqvxdIpbrpu6UulQmD4DeX0nBZY
         sCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783526740; x=1784131540;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FuShbMRKE0SZi3ijoimKFf4ervQLR1MwgbAPy6duExE=;
        b=HCSDwpGWhnO9euPmgaxoo3dVfnNIHgTff2wraQmxTruGaFemtuWHbZoYVq/mypgch3
         89x7tszfVXQ+Aq9DgcWC9UAOzYUmin8Ck7uvPR4MjhB6LZtEbvFLpmSP/HDxGLCZ6vZM
         I4VUYD1fU8ovnCUTQdYW7ZgJZTtm4iZJ5AjHo9zMrrFaEnJxgWGQjTb7UvbTgQnwTI7x
         IqrsdGPlXcCYFg+GseAMDuMZCnsd7cbroKgHHzoK9aQB/RZwBL+SAtdcc+OhcZqV6RyC
         cZxdiR4yOWbsFLFWBfxkca0tEjiCYzK4GKh8I9sa7n/pLlIWsoFT4CY5lunaNYLpdog7
         AIuw==
X-Forwarded-Encrypted: i=1; AHgh+RqVk2s1HnKfbBqhEnDCyvVoEXhjx1JKxpTo0nJPypJdiAoXDAuXAYRW34xaDzpCxNpMIMmm0il3yYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOCbOwatbw+905o8NRTVUdPACtmL+Cjyqt8zWgfz7vU+daxfVy
	IuCk2XjwTNzJe4WY7E1QgEtlyyxFNQ/aYOFXQS2LCgcGI65ZFFW2Iz1qKdco7XqQwDk0heS1hAC
	/ZEJcoGyibdOZvXcVPgahXB7+tmGTsH2Au2oX
X-Gm-Gg: AfdE7cmN1R9nJdRte6jiePaIzujN5lkCi8aOzeFtquykxJzWMWuk5xjjrGRE9AfMfm5
	pGdthOuQOhotEp0dOLUne5f90mHojxE96PhMau6S14KTVD8BlbLMJRB81V+nNa1Yrd0PL9pDTQh
	3bKSWZhExj6Zv1ZfmjVBxH9A1JLukCPPb27pRRg5Du2G2L3/LHM4UsTrsjLpXmkyAl9aa4KOPmv
	UPdJg8VnrBN0dRoAMQTObjIF+nW3EgDU63+Y/foAZssDmx8oHgSG5m1UP26D2VdTHai0JDWKHBG
	mhZlyfot
X-Received: by 2002:a53:b117:0:b0:666:27de:9cb with SMTP id
 956f58d0204a3-6679f2042f6mr1904126d50.75.1783526740339; Wed, 08 Jul 2026
 09:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429-d3cold-v5-5-89e9735b9df6@oss.qualcomm.com>
 <20260629211614.6942-1-threeway@gmail.com> <hzv6l3g7q55ofr6hu7y7indrn2uzc5kdvlbu3q7om44iw35nbb@5rc5uuhqbnid>
In-Reply-To: <hzv6l3g7q55ofr6hu7y7indrn2uzc5kdvlbu3q7om44iw35nbb@5rc5uuhqbnid>
From: Steev Klimaszewski <threeway@gmail.com>
Date: Wed, 8 Jul 2026 11:05:27 -0500
X-Gm-Features: AVVi8CfNmJVMSvN9XdJeS7IaTnkgNSzIRTTUJaHWTxnojYvf0u8gwqelENm5DeQ
Message-ID: <CAOvMTZhpx57GGakfiS+1tz0t8XVPaydkaCONUxoPFdeXpv+xQA@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] PCI: qcom: Add D3cold support
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: krishna.chundru@oss.qualcomm.com, bhelgaas@google.com, 
	bjorn.andersson@oss.qualcomm.com, jingoohan1@gmail.com, jonathanh@nvidia.com, 
	kwilczynski@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, lpieralisi@kernel.org, robh@kernel.org, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mani,

On Wed, Jul 8, 2026 at 2:53=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.o=
rg> wrote:
>
> On Mon, Jun 29, 2026 at 04:16:14PM -0500, Steev Klimaszewski wrote:
> > Hi Krishna, and Mani,
> >
> > Turns out, this patchset causes issues but only on some machines.  On a=
 WDK2023
> > (Volterra), this breaks suspend, and on *my* X13s, it also seems to whe=
n using
> > the command `sudo rtcwake -m freeze -s 300` when resuming it crashes th=
e
> > machine.  Interestingly, it does not crash on another user's X13s.
> >
> > Included is the info from Volterra's lspci -vvv and further down will b=
e my
> > lspci -vvv - my X13s has a WD_BLACK 2TB SN770M in it which is not what =
it came
> > with from Lenovo.
> >
>
> I tested suspend/resume on my x13s and it did not crash. So the differenc=
e seems
> to be with the SSDs. I did compare my lspci output and yours, but couldn'=
t spot
> anything obvious.
>
> Since NVMe devices do not support wakeup, the pcie-qcom driver should be
> transitioning the devices into D3Cold. But I'm not sure why the crash hap=
pens
> only with these SSDs.
>
> Since both devices have ASPM enabled, can you quickly try booting with
> 'pcie_aspm=3Doff' in cmdline and suspend?
>
> - Mani

With pcie_aspm=3Doff it still crashes on my X13s when resuming from suspend
