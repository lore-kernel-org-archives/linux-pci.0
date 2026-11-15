Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794707273;
	b=I8+9HXBZf9xGM2/NSD79gc0SJxcL42w9ffGkaB2R6OJOoWyVFjB/FR0nvT37ryFwH32O
	 Krooiny2c/LGy9ez6Y5Q+hHUJ+VrsDvCdHGaR9kgR3M3eRoa6ZxSWjP+ApXKr3xkzbVD8
	 WuICHfmW9sjjsgpVh0ZN3fIMsyzhZ6hDXLvVcbyUOhF+PjSMMu4tm9Occ2QNBwVo/ZU4/
	 +NMk2TxbxdiPKIxOsWwUGMTNqXVQjFecbmNkmXkdPbVca3XrnO1GWO/dT6/XyRFukw/s6
	 pmyVS6oF3IgSjvJPHydQFLzNg9z+zVlAR8pRJo4wHw9EGpu2astm7l6NcqQwBiRkUIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794707273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OE0V4hDYj6rciPValeql+PDftw1T5fn9De/8GtPo6aI=;
	b=BQ6oksjOeet8y/sRNGGbDjMP8fc/K3gMDJ3LGnsXr68HJZ75/rE4Rt++DRC1s6UTWskh
	 Ee247gp/yfZhXFeCV47cNIvhMY/8cY0HLNNOna9xaSvKfR4cT7hQcLgPEm7PEQDtp76hT
	 lGT4GXXeS9sijO4T4IUlOUyj2el2yT44Ijx39UyxQ2CUtCBBZ7QYOPXosk/9lyqD2IclB
	 dGSFYxCZIxtobfrN4ew1vtYU3ZuHYfkULyVrkTRRCpvklnbgTWP193O63B8kyjZQy+vqu
	 8UjktEiYRJx/GoRIA4J8iJg1bnoN/VaHkqmVQY6D0IBHq3pNML1rpnHFIlqyf7pynzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z2gVAHL2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4476606A327
	for <linux-pci@vger.kernel.org>; Sun, 15 Nov 2026 01:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4476606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z2gVAHL2
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4d473cfff6so327674166b.0
        for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 17:47:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794707271; cv=none;
        d=google.com; s=arc-20260327;
        b=YpS1PaavZIGNwJCQ3Ss0q5Ix7YH535A8vcHe9l3QFRmY5AxBQm/v/rOxP/pfwr7Shx
         ZO493uBR6a4c1R2VmlsnaOzBEQntmKEmm+UcYQGwAoTG2puj3zJyBUMwS4gCoZw5/jhe
         YbU+fB3aO8C1UlnbsM7tYcRfjWDlbnnh3LzdMnnztEbDqAx8gIaBB7CSpGRP21LRPKHs
         e9Lqw1CopyL6X8RQMWwchuWfH3Kncrc1yiPIu52m3/kg/N0GYTwQo+UPXXw1rwiJ4K9Y
         rCctzbq1YGwT66VlX8AjEtCp2uAwrWm1TLCF14Gm1jeMY179EreqnhNn1FPtyyJv5GdJ
         gLMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OE0V4hDYj6rciPValeql+PDftw1T5fn9De/8GtPo6aI=;
        fh=gDtuP35fP591LHH9bzYF0D1iMKn2PAw3yj1SNNdKSlM=;
        b=fFJJxfqXm5+1SKGi/Q4a1UKAXKK9j4P6z+V9sVB+9RF2Y81CJTtm3dBcbnDrtaXNs3
         lkPpj/Smx8vDxQ1j8mjBgIbWlrw7SZEc4HAHxFOJ5eorPOmIRpRJ2vSXUgJoJoSTeTZz
         5MulEpZBFcRF+a/lIcKkp1iHC5BC1b9AoqN49li6iDbB8ul5vG2FEtSgdyWDZ6g+IGgP
         xL7EjCknDR0F5Az2d2RhGcl9qSabWlJPWZK989LYUpVr1oUQQ4uN6VcRgmDazYYk52ec
         WObsf77pDGKihdoImv3hb3BLOEmlm4c/Z8lkHZHxiUJFe5rN1e144cyl2CAY1QHI3Qfe
         61cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794707271; x=1795312071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OE0V4hDYj6rciPValeql+PDftw1T5fn9De/8GtPo6aI=;
        b=z2gVAHL2z+x8knWv91TPYYOz6MOsnsUKca8jKwGhSeucc+ZXvt1GALAUWo1aWaFcI5
         ng3uFS3yt//zqgciRT/DBMTOx1x5hPkA5DkQSK6bPTzS7Q+nwvtz+BqWv7Ef+1B8vEBJ
         oTxO+lsUQED7F8x1UKB3uU+wrZf7DWSN76v23rINlQwzuLU8WwhM+PejbCtbeMzh4rk+
         Ajs3d/7o+QxOnfL5aOtmX6IVez1+1FcNy4cT0z2L/kKY/5kg16k/jFs6D71/mKgpnkME
         vGPj9Op5uNNQcDMHWSkbIl+fyPd/DSBFTYZHoShZY3+Br9aVFpoVTEtTkdTrKokbYFkW
         wI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794707271; x=1795312071;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OE0V4hDYj6rciPValeql+PDftw1T5fn9De/8GtPo6aI=;
        b=uifvR/murawmx55hYJVtJhhhf5iAacjUhaP1L+jMW8aW5CnQky1OwII4UZwRWyuXfr
         i90ZSwRm7TqakchTzSsjrJi+aLjA6/PPYcogbP0goteG1ZeErLX+k9v6WMAkj3NwbztI
         uJ5Fg0Nxlva3TCUhMbGW9NsELKUjQq3UvgF78mQa8ZNm2dLP+UDR9uNbNPYweTLVE6iO
         nn1dx+UtDTqqTDRv1I4BbsoYxfZA67QYFkpAlfhvDR5ZDzJUCifLweWSHvMglC7/bj/i
         O3+hKtcb2o4hI5ZtDC7vwoEMnvJVaMIVCLL2DBygNe96/QBteLaWHxs93NFWu2bs5q9V
         4k8w==
X-Forwarded-Encrypted: i=1; AL+hErH225TAT3kPJWl/sigFAyR+y1dVVT6oSXsXXe7F0S8Yl2QWpxHR2hw/SjNH4HV5FK8vLQOZx76F9+I=@vger.kernel.org
X-Gm-Message-State: APuU4Z/eHIOa6KkzKSb3WAJjhhlVAqxcJDuIaXfrWwr1u22y2v6j9P2e
	h0cjAgwI214XGbFgqlpha4N2MZit/VM8dCVOPYRl1J64HBmZyNAxEmp4vHSj5PP0NIF/NQz7el6
	7Y5RKK+yjVEqrHlR/8uKzvuvrrsrzTvo=
X-Gm-Gg: AYBFou3zN1J3ilfIkubifvNe+eDiwrmNAxAbuMNudapKoy2rylQqP3X/o5FxFQyyUVB
	6+UbSlXHceL6Gi0rPvEhEjaCVWJ2n3CILHwDGh46kuVnYFqx6SofuCWbcVQaup7M+0U0mxV/Sch
	Q9K37k9GfhwnEYF1AHJqbJu6e85nY7VhBpl5ml94gDtno86ZVkmwiUHlCqQk7xpW2WHF4i2NffD
	oZWZ9A2pFuqdOMYw+oJbJ4pKiUAluElLPgo49vjkkeVjIyg25GwgeIXLzN0ysNk4tsYTFL8PECy
	qc3XD/VlM6z2RiaC6T40kEhO1O2PANzWv09HwEAnwLYer22gPiU8R2jZwMoTMrcFGgxi649pRmR
	/VT1w0dPnqydvHghAEjo5srBHQa0IIMWDSxkDrwlF2uwKiNEvg6EaHKK8MynaIYDdgSDHV7CeWT
	ZuS/+kxw8fRec=
X-Received: by 2002:a17:907:9443:b0:c46:75e7:25af with SMTP id
 a640c23a62f3a-c50963446c5mr535005266b.11.1794707271041; Sat, 14 Nov 2026
 17:47:51 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAPZV9qUk3-eKOGEjVc7f0QzZcjb3L5QwUceAEUV0nuCdo90eGw@mail.gmail.com>
 <20261114235828.GF3706007@nvidia.com> <CAPZV9qUvgKjoBXGjYXJzwnCmqzSfu781ZSG8zW6Fn4PokUN2uQ@mail.gmail.com>
In-Reply-To: <CAPZV9qUvgKjoBXGjYXJzwnCmqzSfu781ZSG8zW6Fn4PokUN2uQ@mail.gmail.com>
From: Gustavo Andrade <gustavogyn@gmail.com>
Date: Sat, 14 Nov 2026 22:47:34 -0300
X-Gm-Features: AclHuK-T0Xx18CWBs0ljRBJr9OWFzUd844AH_e8W_0A95quNMuvEFSNR0XQKFu0
Message-ID: <CAPZV9qUMZcwVF=CUK4LY4G6Qoqd5ykCXE5ocX8VCy_f1c6+aBw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] vfio/pci: Wait for GB202 firmware after reset
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason,

Thanks for the feedback. I submitted this as an RFC because, while the
workaround solved the issue for me, it seemed unusual that only my
card required it, since I haven't seen recent reports of this issue.

How would you suggest I proceed? I am currently running the latest
VBIOS available for my card (Palit RTX 5090 GameRock, version
98.02.2E.80.10), which is also the most recent version listed in the
TechPowerUp database.

Best regards,
Gustavo Andrade


On Sat, Nov 14, 2026 at 10:44=E2=80=AFPM Gustavo Andrade <gustavogyn@gmail.=
com> wrote:
>
> Hi Jason,
>
> Thanks for the feedback. I submitted this as an RFC because, while the wo=
rkaround solved the issue for me, it seemed unusual that only my card requi=
red it, since I haven't seen recent reports of this issue.
>
> How would you suggest I proceed? I am currently running the latest VBIOS =
available for my card (Palit RTX 5090 GameRock, version 98.02.2E.80.10), wh=
ich is also the most recent version listed in the TechPowerUp database.
>
> Best regards,
> Gustavo Andrade
>
>
> On Sat, Nov 14, 2026 at 8:58=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> =
wrote:
>>
>> On Sat, Nov 14, 2026 at 02:48:53AM +0000, Gustavo A. wrote:
>>
>> > PCI reset returns successfully while the Firmware Security Processor (=
FSP)
>> > is still initializing. Restricting BAR1 to 4 KiB mappings masks the pr=
oblem.
>> > Waiting for FSP completion after reset restores normal output with sto=
ck
>> > KVM and verified 1 GiB BAR1 mappings.
>>
>> That doesn't really make any sense, you are probably hitting a race
>> condition somewhere since 1G/4k changes the timing. And possibly
>> because your new kernel versions boot VFIO faster than older ones.
>>
>> IIRC there was some VBIOS bug in old versions that caused issues with
>> vfio.
>>
>> VFIO should definately not be doing things like this.
>>
>> Jason
