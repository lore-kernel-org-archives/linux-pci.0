Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9751F192E
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544912; cv=pass; b=qC7B5ho0k9DK3kzQZoSOAAUXvZOIxzMhonkq15d6h8ix+PblQ6tpF172Hj2NR1J4oDIY5+v4RoFcae5wWPI7AeSM2fyUJB+HGb9E4skJ2pF9QMN4DxKl5Xs/R9ViMBkz+MNa6SFFJdsRPSxeBwDG5Utt3acmUIlOSPdGdeWV8jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544912; c=relaxed/simple;
	bh=FXSfYUR2HIvDIuHag7AiEWUwQzFfrlbzYK3tgKFdTAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNHRu/Njc+BUBuW1RLVHPvDC3WJPYYijQjgwx4fSkIH44KVPCB+QjLzqwoX+X5q5rELrwSDhFwgHTYFSL49BN5LkEgCB8fky+VXiGjKhNdhU+cCplR1bScDRhD57IJs0+ijt4JwmSQqxzfKqbUea8KJ4patBY6vqrpzE37YS240=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2/8Lw3f; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2/8Lw3f"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d4c7d04890so5239803a34.3
        for <linux-pci@vger.kernel.org>; Tue, 03 Mar 2026 05:35:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772544910; cv=none;
        d=google.com; s=arc-20240605;
        b=T01EGxA0+fzc2JdWoXhVZHOrCkMDrpBXXBK8Os9vpxIyfrM//AUFIjBuClmfuQv1w3
         1bKHrx8EnqAVQa66jQuSlbz0X22h4/DPegNV/AOfnMsHJzhnaQbPQuj9VFF9I4LuvTeY
         v+mqIw8iX488E/beSYJMoEpM/OudirMxWhGgL8BisfztckLvHC0Sylrn/4zAhM8QfwkA
         f6EcJO+XTu8OSpGLDi0U3DoFYTafNFQPz1vwRBIxQm/9qDu42XLEUsuRcB7g073Y7WoR
         D7J23CMMom08qGcGZhGreGg29saV/+RnQAgJ8V8jMaM1VmLL1szjXIz8brqWBTY6m/gs
         WB8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GtWnbP2vLg/V5psPbYC64D/GVUAPbJVYNAu7+YDtaSI=;
        fh=fOKDrMngv10IAG60tlceqvARyg24D0QGUQUNXKhk4sQ=;
        b=lb2a+x2SmCD0aVnkZyTiM77SrlRNZZ3V1DqTvYTN3l/uh4E7ucv6kae2lGkr6PujnP
         pxubAalQn62IOEN1+SyCq1qsrrgXnwmHG4cbXQ7II6cnwn2YL58xRBRom45tcVep8sZ/
         MZJcr/kfcxcEifTByrexrJXuSZ/tu/e4DjCegOQ1NCGkZRGU0/1AwMjZD/VOfVpsNB/K
         hBC69OfIfkzOMJzGhE8zrZOzgZ/aWqC5KXWHnbqz+xumJt59cz13xyP7UqOMx62uvlby
         X82i2hcdz5qoYjenWNsGPqXNQjtmQ23oyNpL5GYojLZcRZy47RXvepY/g43rK7lnWKuz
         Y3hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772544910; x=1773149710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtWnbP2vLg/V5psPbYC64D/GVUAPbJVYNAu7+YDtaSI=;
        b=l2/8Lw3f87MNAnGCzfWQF9B2QOvAqhTAU8G0sWrG+h9I8i5vJWWbXEeYLKwkwa2Tvi
         DoOUB+/JiJtEUlayOuiekovFJoAr/ajL+HZNEL790v2HNhxOFHuLaOlsp6mC87Ynsd7E
         6ms73hpWPibdLQpM4tjDvXCoDw1gGa8qsPfjiBviVOxIvUf3u4+yEAcqkzZzN4a33p8F
         Ei9op+NxGPWoLFPNIvV38GZCk0A7ekk9q2Ma1v3M1JlPpLwfzcoMRvkJOeSk7rFUMFFe
         mbo9gOd72rhnjyLBtqLc0sWvr4ifrc1R/awzZO9rfGrc3QGsEm4YVJPvHiZb0wVL+aNW
         hcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772544910; x=1773149710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GtWnbP2vLg/V5psPbYC64D/GVUAPbJVYNAu7+YDtaSI=;
        b=I4rwLk1ueLKDPBIv+56MBQHWobO5X2X1xShyNgpTlMC3yE7zRpk2VpXUWIOgpmEcre
         LyRWOVi1Wq15LMmtXAx/sPERtVSdDc7D/uTA6dsEh08s4yhWMhUJ0LHPIsQ3NVjm2dDE
         82NvqD9uv5YOxmct+VWvjVaNPq8jKbrOcHK2X5CpTEBYBpPC+rPafy81RyBS8VqZr3lT
         U1TH0+t6Q5+98SWi4i/e/garNaPBrPgTuOL5jkZjinfxhm0cQopivYmL6N7Ro5+2pFoT
         J97kOE6tfNrGqEzp965XLwPHoKpI8jkyscGMtpT7t6CNE3pyg5lrv4cndIPI835B11KG
         z4Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXOjNJh2iItwuB+mLPTkEVnMG6HfAkmJ7tb5oh5aQkajsdNvoibSPZ4VcHC0VCvE89y+kP9CaUIW04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn9Cu8zXMGsSFN2SIlMCebq5RTkjoo8iTL9DO4St49KrNHG18U
	XeSBwNtJNQEepAWCA/OBLH6xgO+byXvFtuYXbaFvcBDvrdvF3j6YMqRnSIcnntrqkC1ehAXF4Mk
	Hy1NQBtJldS83eu34hfa74uK/eLYWI+JO1Jd+
X-Gm-Gg: ATEYQzxQu3YNdfGujlCkU8ZshWb0nivYhjcnWukEPqSR61CVBEFdDXCJHmydy0LiFD5
	q4iZexyxJCpSnmolzJZBdxhL6P3pZ2nNUIVgLnnia0tN+0yesEeU59f5dXXfq2TXMaHA/JCD0eL
	ECGGhIjbKrOX5xrHNONK5r0UY3QEFG+QTd8BRMp3ufPdO7PRooQ4mDPhZ6ROoSRVdauxko378+F
	PCGCQ0QXi4u2T99FPjO76oJoJ4TD3DkzrZdqWZVOBCl0AnqAWjoQppKJvUDB+UlmY0h3JX3ZMOI
	aBrmJhU7mz1AxjTP9ig=
X-Received: by 2002:a05:6830:6ad8:b0:7cf:d150:8251 with SMTP id
 46e09a7af769-7d591c22eddmr10114290a34.33.1772544910423; Tue, 03 Mar 2026
 05:35:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN7C2SC_2k6+dvBTRoV1_trpPEF5h+k9KDOapTwcb90+=BUatw@mail.gmail.com>
 <20260302235100.GA4037767@bhelgaas> <CAN7C2SAcJp8nAhbRT9OyLeT2YsvmX=+Y4qhBZR_WQ3aDqNHywA@mail.gmail.com>
 <8d5cdf11-b5ba-2b10-c2ba-76d4aedb5197@linux.intel.com>
In-Reply-To: <8d5cdf11-b5ba-2b10-c2ba-76d4aedb5197@linux.intel.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 3 Mar 2026 21:34:59 +0800
X-Gm-Features: AaiRm52hhi8eayFn46dxamTIBLMjlNwewVx3ZXWe-4dBZ7pb8NEgK4d5kyb7vNo
Message-ID: <CAN7C2SAzfTTiViekA7kkYo2At+qYVSv-y22DyJC5RtdrfLYWjw@mail.gmail.com>
Subject: Re: [BUG] PCIe Stall on USB_PCI=y with SoCFPGA Root Port
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, mathias.nyman@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 9:06=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Tue, 3 Mar 2026, Sune Brian wrote:
>
> > On Tue, Mar 3, 2026 at 7:51=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
> > >
> > > [+to Joyce, pcie-altera.c maintainer]
> > >
> > > On Sat, Feb 28, 2026 at 11:05:17PM +0800, Sune Brian wrote:
> > > > Dear PCI maintainers,
> > > >
> > > > Root Port: Cyclone V HPS Root Port PCIe
> > > > Endpoint: uPD720202 Card
> > > > Kernel version: 6.12.33-g3234b1ed8956-dirty
> > >
> > > v6.12 is fairly old; can you reproduce a problem with v6.19 or
> > > v7.0-rc1?
> >
> > Had tried 6.19 same situation USB_PCI=3Dy simply repeatable hang.
> > No message shown or tells what happened.
>
> Hi,
>

Hi all,

After a hard working day to repeatedly check and check.
I finally got it to work.

The reason why it is not working in the first place is caused by
INTEL-Altera PCIe driver having some registers shadowing bugs.
Neither NVMe nor WIFI card had unraveled the inherent issue.
While the USB slot card successfully triggered the inherent bug.

So the hang and stall is triggered by wrong register mapping under
the PCIe driver not USB_PCI flag.

The uPD720202 card can run USB devices with SuperSpeed.

> Has it worked with some kernel at some point in the past (in which case
> git bisect might be possible to pinpoint what broke it)?

Yes the same slot card does work on the ARM 64 bit platform.

Thanks again to all responses,
Brian

>
> --
>  i.
>
> > > > Sanity confirmation of PCIe RP:
> > > > Both NVMe and Realtek WIFI cards are tested
> > > > and show no major issue with MSI/MSI-X enabled.
> > > >
> > > > Repeatable Result:
> > > > When uPD720202 card is applied onto the PCIe slot.
> > > > Either module or included driver could stall during kernel boot.
> > > > The stall can be resolved by setting USB_PCI=3Dn and
> > > > after boot under distro lspci -vvv can disable the card info [2].
> > > > All nosmi noaspm etc are tested and state the same stall.
> > > >
> > > > The root port info is shown in [1].
> > > > Based on the above behavior we had also tried to reflash the
> > > > ROM of the uPD720202 card and no difference was shown
> > > > on the stall issue.
> > > > The uPD720202 card is tested on another ARM 64 board and
> > > > shows no stall issue.
> > >
> > > Do you have any details about what the actual issue is?  I guess it's
> > > some kind of hang, but you don't know exactly where in the code it
> > > happens?
> >
> > I can't have tried so many basic dmesg and possible runtime debug metho=
ds.
> > It just simply hangs or stalls.
> > Maybe more guidance on how to turn on more debug messages could help.
> >
> > The best I can do to know what triggered is USB_PCI=3Dy.
> >
> > Thanks,
> > Brian
> >
> > >
> > > > With USB_PCI=3Dn it is sure this is driver issue between
> > > > pcie-altera.c & pcie-altera-msi.c
> > > >
> > > > Additional boot log [3] with USB_PCI=3Dn
> > > >
> > > > Thanks,
> > > > Brian
> > > >
> >
