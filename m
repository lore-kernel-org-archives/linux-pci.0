Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795075418;
	b=VBnqkHdCsLle4unFiXnkXczFEadq9/LIzXnd7dDFe1E10PlGP7hsUowHnl0l+nY97Ea3
	 lbmydpwTv61QziJMtkLkxxxy2+FPSmjD0YnNxUsp4H3J3AUnwMp3LkoYV6Tw6PCRNljun
	 12ZH6O7hh2rxYBPtCBShZ6cRLp304ZrW5TTE46t9dSKJNKXFNjYre2DtYh6KeNpAdwi4o
	 NLF3nRhaLDsSdtQ0YEjIgelUlHrKGNJwt6GCndvfhJavmsaMaJR+wJ6bkki7I9CVhaKVZ
	 GVuISI9yHMtXo7tf89dTSOKS6quO05lupnSIdJ8t/yWdB9nDdM9CJpys6QXf+Qn6hYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795075418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=4zyWgbXx4Q5+0M3EcfdpGNiWN2ml7oLzqm2D2qT58oE=;
	b=BIdm8q/aqSl0X8YfnezCWb5+90qZUWTNkez/rhfedUWZYhPidXBmLZBSSYe+NXv5PXAY
	 NZlCgJqI0NylgNxXUGhg7x9tFpQq1GD3gZsqwbOF8Grn43enbM3RdxAQQy6ozW5xef/Fi
	 n6WfdGFa5H/qGOk23N6YnNhd9p3V6OwGlkhs4BJDNM5CaK7AvpGXTsxwyJD27ulowlrmf
	 LwdrNcBDwdWoLKdIm6aRaKMOyyfcR0lWsmjnd8yN850BMZGku0vNBQldPHvJHeks02q2v
	 ep7ZkN9J1eVYYgWjKqcOBk9OoeqHJLC9adHYbrS2B5T8J8COUZDeru+dkQl2v2jXkfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=txf9AEnn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAEA606A330
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 08:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CAEA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=txf9AEnn
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b86fcbd647so1277946a12.1
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 00:03:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795075417; cv=none;
        d=google.com; s=arc-20260327;
        b=kUQupGWhtH0DHoJMEGti25f1f+m+SDSTtVqbPKv65FAGaCY2zE4K0BAnTLcj8mE634
         aJgnD48FaX2qrF2ekFHkIoei3H6nJgSC9l3mZrRh1WakzuvQs0iATnK8otjNhE4ImM4g
         Ev5qfl2Xe2T4tuyh5sF9H3kPmdg6sNkhJkTBY4Xh+7mjgW3n5BwZYykUXRd678ZTsz0T
         mTTWjcOrwk8yDetMdyHWJpJs87iIXqWkbgE/E8cXPgNm2++OIvdHo9daozJW/zj3UBKl
         OrIbmpGn31dF/Q92td1vdff/xcpW+lN6gs0OgTiyFrftxPzR5mWrTdAHo7TBn+JJeZAK
         jqjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4zyWgbXx4Q5+0M3EcfdpGNiWN2ml7oLzqm2D2qT58oE=;
        fh=nt9iCRTSxTY6/RTZC/dyR99mDA4cxJeIu//Rgl8qKVo=;
        b=lehs9xPlbUFmObQ500/iSwO0YboigJopEfanCAHZECuDbdBVkCEY7kvqpg6cAoZtU/
         sax62ums19VIltOTmrjil6vyHSx1VE0Bz3UETd3MItgRnDXqOHyAuHIgtB+HVP2pmTHE
         KJqaIvjL/mxJXVZMA/funmJP/Nl5uzGJ9AkS6jfaDrZlOI1b/ZsCyNEU6PA7yasn4PW6
         tydQrm1pBBLnVweHqawbDOsbWphSr94qA6U8TLDntQGxGGnV7+1RT03A+e588nu+5uk8
         zdI7e0MPCr7C8hUvf/bjQrqn6eCXkI4VHaNPD+ngmbOVj9kuGW5AAgMHvdxiVChQ2bCf
         jyHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795075417; x=1795680217; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4zyWgbXx4Q5+0M3EcfdpGNiWN2ml7oLzqm2D2qT58oE=;
        b=txf9AEnnq3VU5Rth/crTDgb2s4PApg8WmeRgoiQ0ILTAvewf+e28/4/CnBqJcnV+ZP
         E0rHclgvNTL2GCwk+A/TJorgUCWVVW/+k3La6gl7QetAhRYmRerQC/gmmTkPU/rXIiRC
         lSxMUG6Bz5tFM+tXFwXgKTfAs8Njh2aqPzVAvGWSa04lsDICVUWFBGlKQBW1GVJ7ItAK
         2Ftdka4dj5GGvdx8Hj1zwmcYQC3adrtzWh/erZc4GOvagaFZyIWf2ZzmhO8zXGyJAl7U
         eU9KARgQ7gwMAd/zzoC5i5xxACyzy3kMwPcQMjC3brX+NuCn7957iw89Es4rZn1Z0gq/
         FGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795075417; x=1795680217;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4zyWgbXx4Q5+0M3EcfdpGNiWN2ml7oLzqm2D2qT58oE=;
        b=OoDeU/IqyMzrNktvTqB8wEStDmSzO7qveKBKQ/MLt9ZaCSrIlgO0cUhdEzKJaVPOGj
         Uz8xkQTVCb9ADHuDRXPwJqXlAzVSEpBYPEQM6rklfQZ2oMff5sogDQT/xqL6QHpznwbu
         5UH08kRDhbZT+M3/owzovBTeLAzKYNp8y9tVkgR3Vy46fyu8csFUlSuv9QT6dkO2BMdg
         QBDQlchx/27V5NvgGDU5URTALkd/Nyjva/8byvzVmoiKk6jxWej7zBcoRaYUI2/6s7rf
         qzuDFhbzaYWbgch86yRY426U1fwwwoPez/Tz+nTyLGnDqP9KCJBKFTES5+WqoueXPCrx
         M6cw==
X-Forwarded-Encrypted: i=1; AL+hErHmJ1ccGUYBJ4n7el4f4D2dWNapJ32iBHEFHwiq+GdPIp5F0h4RC7oA6G9N98yfeRTC8hfczF2JZQ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8e/NhnIPljBY70+nCxu8h40g2VWC7wY3+nEYhqM2le4ULuRtSX
	+/unqEtY5A+ZH1BCFdXhB7vRhJeCz5TLu/mee7e5wgxMbJn5mo/pcvkUlK2LQds8iO+Xck9Fw9+
	BtV8pVWou6XIHlIVIeqRqfwWs0efR2n8=
X-Gm-Gg: AYBFou3In6FCZC2w5FlpMbQ1lAI2AGTNSYeeyIhRPC27NZrRYcvAqRzKN6o9mWMNrzT
	HAtfqqNa+MLRLeeHlKtlqLnP0s/Dfe5DFpxp+0aX03ZbcBPkZGO6ChHsOOsGNOPV2RshRhFu+Y9
	3LAN1US+as7uUsRHI/CRf5VOOOL2IvtRh76wuWTR/ebYz4LzgIRtty6MUXJzt22yryUVC6LKrX7
	wSWMhnBeMv9QHFFd1h+iDKXsdGJhX5sKlOBdNwDyr/fLmE7vb2S4sbixPBt4/hOk8Whlj46Y6gP
	uHhfRjPjS9jBwWKIqWh/s/OgY99oMZkxBVhaX9bNInVuG1cVbCw11WH/A/QaWTopqp8TODBsyPr
	s2GvejD2fOkXsi4iq/IzIU+4De13OMl94UTQ=
X-Received: by 2002:a05:6402:c51b:10b0:6ba:12d7:69b1 with SMTP id
 4fb4d7f45d1cf-6ba1f9ad159mr266992a12.12.1795075416554; Thu, 19 Nov 2026
 00:03:36 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119-b4-rockchip-pcie-hib-v1-1-05df24cc77e6@iav.lv>
 <CANAwSgRaHubdh8o5Zd3k5Sa_jf5fWuEuCXqbQu7gGL71MwC+8g@mail.gmail.com> <20261119-re-anand-rockchip-hib-rails@iav.lv>
In-Reply-To: <20261119-re-anand-rockchip-hib-rails@iav.lv>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 19 Nov 2026 13:33:19 +0530
X-Gm-Features: AclHuK8PCuggsZEUPGrild3UXx1VS_EuxaX_wfHV2ilz6neGEig8c1iMSX4XEY4
Message-ID: <CANAwSgSs75e6ACaP-bw_JGJ1=VrMGmvduDCx6HMhXSmLsOJddg@mail.gmail.com>
Subject: Re: [PATCH] PCI: rockchip-host: Support hibernation with endpoints in D0
To: Igor Velkov <iav@iav.lv>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Igor,

On Thu, 19 Nov 2026 at 11:54, Igor Velkov <iav@iav.lv> wrote:
>
> On Thu, 19 Nov 2026, Anand Moon wrote:
> > It looks like we aren't disabling all the PCIe regulators (0.9V, 1.8V,
> > 3.3V, and 12V)
> > during suspend and re-enabling them during resume.
> > Shouldn't we power down all of them on suspend and bring them back up on resume?
>
> This patch keeps the rails as they are: suspend_noirq() already turns
> off only vpcie0v9, and the other rails stay on from probe to remove.
> The 3.3 V and 12 V rails power the endpoint; cutting them in suspend
> loses the state that the PCI core and the endpoint driver expect to
> keep in D3hot. Doing that would be a separate change.
>
Makes sense. Thanks
I will check the disable and enable regulators to help with this issue
and will update you.
> --
> Igor Velkov <iav@iav.lv>

Thanks
-Anand
