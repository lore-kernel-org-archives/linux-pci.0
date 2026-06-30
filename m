Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2420A3E8C74
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 20:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851154; cv=pass; b=B2RWAu+71lzhFsMPd73VWUCkMhKJZJFRBDwguDS0/hiaOm+oOutfcOhkY38RNlDi0uQyne587t59uL/UxnfrbH8sGuqSo6HHCu1CmAxENDNUK+HBkhH6qquUOxIpulI4i2Cmmg2fuvtPdi2QB5WlO+9FK15fSpFoIy6lYDWBQHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851154; c=relaxed/simple;
	bh=woEJVo456NrwIsWH/wXSni7K2n8eZ9xu8Z8cS/c5ecM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkoX818lBttaXWBxfvsL8Tx9W/EBl+LC7A0QAnPdw6FHellIvNAYgAq+4uHLyOWO90zxq3SMymQDbmJ4fgLQKLmFmInJiCUuTML6j8vZaXqx7sFlz7ouUEkW1UozIZIKDu6I0Mq5BU17zBmc9zmpXDmoEkr22HPqrhmb2kF4DCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M8W8An0n; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M8W8An0n"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-137335bc3caso10525541c88.0
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 13:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782851152; cv=none;
        d=google.com; s=arc-20260327;
        b=MHB4mKm1AMiEZxGRmIofbFuAVH46DeDrdEQ7IEDqaV2LrWedcJ8lV3Y6nZglS9y4zr
         0tGS2nDYd5VRxo3nwQn7eGgAnQ4I55TnjDteV10sI9LxcvlghUk35szPx4q+Af2/IU6E
         EOkKnBh6wkfCzyFtHhjC6kZRwn21xmXK0DgJ2eV4g2cRLYI6CdVpbYUk9lgDU5R4jxnN
         Ubc//tA5jVMBc3d0wSETSd7IlJWav7NlMZqNJKBddEv9IcXea1ZaRHm+Dj0R6Hhd12vM
         sNst2ge4R6XJuc/ECgsl74mYA9lpQ4e/k2gd6Oln3F4dw1NmZbXqj3c99VDTqZ3swius
         Da0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UHtdbftmzwtk8eZlUQqO44pzJ12Z5O1UdIf5x8WuOoQ=;
        fh=7C4dn3wz73eeTbrE1SqQ0glsAB6TVxMU218KnGcz7Js=;
        b=pJSrnE7zmzcKTdREwW6LevGLMo6Ay4hC/NUKgHPaDXbyw5P6dg+Zwikdn/TN1cOrQl
         Oxwa89xjslb1OQkyiDWwk9HIHeX4CEg4IbHpqKWdKgFwLvjGBdAIRjWioor4GCV+Hi1k
         Z1NQ8EoSVa98DZyWlv+hzLDCqE+8w9Aa6MZMv2Y0LBNafXm+O3Ent/a3yw6SZ4X9s6TC
         sVmAv+w4zAtsIN27LIzex6CdWK3MmgkibR0wwzwldpulcPwAnbMQj0XncxUvAv0SIO3U
         FxLbaNbEf9pdS9da6/RoD/M93+DdjCif0bDQhrsBmIWUxRcnqsMJcad0wpVW1ca5+Cph
         QrtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782851152; x=1783455952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHtdbftmzwtk8eZlUQqO44pzJ12Z5O1UdIf5x8WuOoQ=;
        b=M8W8An0ndlJfLxRdlGsu4v2C1OvxpsT4rSzeMZ6qs4nyuC6VtN5cuMsBGNZ1twINTF
         K7gHGNN5FMmSXemRx5czkX314ulJZvbNn0JfuT2Eup1ZgrcG2Dwy18mh0zRXFPs8bVJ+
         AOPOfwcjNEzd810O6oLQwyCcbnnm/WmfjUqJ4teOmdzxY1K1+fRVKg2qYO/OV0kFiPLH
         NgoVD6ub2PYhRN3Ua0O13xlh2MA/MCW570jB0TbA2xcl0IkDFdnR4m/FrW3E1x32HPWB
         5JGQyOdu3xVDUVH47Hfvzf/NuCPjzbdqBe/nJ2ZDmOK6v3CW0k9bR+rHzVjIVwM9eTjT
         WmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782851152; x=1783455952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UHtdbftmzwtk8eZlUQqO44pzJ12Z5O1UdIf5x8WuOoQ=;
        b=kddiFnOsvEPg/X8guPftThyh1VV/p832TgSapQeubM8GEfGBkuUESx654rgac+yTpN
         PxTAuTxCY8ihPQoMvSVYrthqDK4ZeWldiccLOTpOALCYBEzU7Vrb5vXTijN31P5gi4Vz
         IS3HANZhNamvicCgsoP2zq7+j1pKItGzgV4xsuBbdHSJ3eGCGmaOHJH9dKP0/+Q63N4P
         w3txST8rlP9hn93BSToZQSicWFRVZ59yXS5fAqI+/dwWsTq/q/Gb2+HLdM/3HaCiGAqU
         En8js7zheP1cOzYTFI+bo8P3IdLJq1gvQbaGqBJ7zOCAU6XzAw+z5yQWh61+CS7S8EdX
         6LPg==
X-Forwarded-Encrypted: i=1; AFNElJ93LTQINc271cM67No8gynA5lA0884wy7CsfIQoprLVTTKYySMr8G6uBhQpxmYH7tEt2mycHBEgsvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU1C4eWubfgZmV3C0oB4gagHeIMI8itcReBimXldjETujyS+1O
	mPO00x0BJrsTFuco7wiNMUSu+eeq7ORqhE/h00pzhXvsIxoHNDRueeULVDd4SdsxHk4fmqoJUA3
	hhzj5sTRmj5m/TopxshyZ+N0kMBmEIpNn1Ym6nWq/
X-Gm-Gg: AfdE7cm+hjTxLoqwzroR4XLO8OVWKwkX/6CEU6FNGx55dvuaNimJFESLv98nbQVYXWv
	Sv/IOx0TbE9jigtwigLYgZ+tP9Wi50kxZey3dkCrCc3hs3I+ddxGfA6wE+YsJ0PmIg5o+TbAPkQ
	u0rJSV+CUSPBv/9lJ+YqlKUM/FArR4lBYJkXtklrzR5zX2e9FDWyM3sr9LQrDXXtuFtmLpQSKya
	xkrWIB1lW70TmuQOKcFrCpxoMBf5lIcCTpFLiIEhR3Ul/Oe/meCu9Sp58R5gIPIjZ83YKKP
X-Received: by 2002:a05:7022:eace:b0:138:51c:c5aa with SMTP id
 a92af1059eb24-13b2a1a6039mr3014339c88.27.1782851151608; Tue, 30 Jun 2026
 13:25:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626213047.189951-1-bhelgaas@google.com>
In-Reply-To: <20260626213047.189951-1-bhelgaas@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 30 Jun 2026 13:25:24 -0700
X-Gm-Features: AVVi8CcLLGKx4wcfKCWubTql2j3yzitehbvvvjO6jZlkZaxQmxBrWjfnRn8YDV8
Message-ID: <CALzav=dsWFJxc7WYKw7nvWpGPfqyjjQFkE=At5dLJsTTfpFe3A@mail.gmail.com>
Subject: Re: [PATCH v1] sysfs: Include bridge window address size flags
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Martin Mares <mj@ucw.cz>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 2:31=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> sysfs_get_resources() fills d->base_addr[] with CPU addresses of PCI BARs
> (the CPU addresses in sysfs 'resource' differ from the BARs when a host
> bridge applies an offset between CPU and PCI addresses).
>
> 119c1376f9ca ("libpci: Add support for filling bridge resources") fills
> d->bridge_base_addr[] for bridge windows, but unlike for d->base_addr[], =
it
> did not include the low-order four bits of 'flags'.  For I/O windows, tho=
se
> bits indicate 16- or 32-bit addressing; for prefetchable memory windows,
> they indicate 32- or 64-bit addressing.
>
> ccf68033a452 ("lspci: Use PCI_FILL_BRIDGE_BASES to detect if range behind
> bridge is disabled or unsupported") tests the d->bridge_base_addr[] flag
> bits to learn those properties, but since they weren't included by
> 119c1376f9ca, 32-bit I/O windows were labeled as "[16-bit]" and 64-bit
> prefetchable windows were labeled as "[32-bit]".
>
> Previous output of "lspci -v" on a bridge:
>
>   I/O behind bridge: 2000-2fff [size=3D4K] [16-bit]
>   Prefetchable memory behind bridge: 48030000000-480401fffff [size=3D258M=
] [32-bit]
>
> Similar output after this commit:
>
>   I/O behind bridge: 00002000-00002fff [size=3D4K] [32-bit]
>   Prefetchable memory behind bridge: 0000048030000000-00000480401fffff [s=
ize=3D258M] [64-bit]
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks for the fix!

Tested-by: David Matlack <dmatlack@google.com>
