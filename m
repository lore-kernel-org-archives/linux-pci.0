Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7280B345724
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 23:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219175; cv=fail; b=qGbQHVyBGcxwRgeArowsJ1hUnfsa11fMJJiJs4DAifki9EaMZa6/I6SLvHIeTZfCNTBBTf8YO13xdtkFUdz7rusErec+BYXG9FaTTefUXqtxt5u1r0g+yS1YQOrQfVU1nskklC86+OyIC6PV7akQG7wM5O/dV2/kB9XuPUAzo80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219175; c=relaxed/simple;
	bh=8tl/mJ3jeelSsPisncFYTPJxxSNwXHFa0O0MaGwSjBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSOp31irxiRBaiKW6c5YPchOZ/aTaO1EBb3S5FqQ0AM6LoUhIn6eHioTbAPrj1UcbcFbN/oiHhF6NmTdZ8QQbx+jDxJpz5dD7V0kByne5GtuhScGV+zJeJ8QcUnNk8cmTXptlLbsC45EOnN7AqaNxfMg0eOV+rlsbshaUxUQfdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=aAliD7hP; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="aAliD7hP"
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BEQSDd2239347
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 16:06:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=efsnF3+1jWR8pvzMYJfBE7lVlQMbzzxbwMqOReRrznE=; b=aAliD7hP4Pnb
	sDHga9w9vOIaX4gPrLDH9CxWfUDul6tHQH4Xi0x95taVkfEY+GcuJ5llY9o7rdU/
	6IxhrOtNRPf0TZXzirIqsi4bvN0RdnQAebO3TXTwQ1ciy0nZK/Rpu2xM5w244SPJ
	RXgJk7lo9T1WisKqszJAd+5MNgI/KlpyBjNrdHxIF9RMJjY3r8Q959ivZHAEzgoG
	khu0ku8hPaoN7AYRRbn9WFZIlTuHEdyYgbXmb7kn2o0lgBqUwRaYgCIBG8ogF9SH
	Vazr4Xq0IrMxhXUedk59GhVrJIceY2weOoGa+2aM1YsFU9fskt3OQlTECK6T/8pJ
	mXSX9Zuhtw==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe81sa8q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 16:06:13 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-48637dce961so474332b6e.0
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 16:06:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781219173; cv=none;
        d=google.com; s=arc-20240605;
        b=O2JqKOTvGMCcqyoJlihUUCTpH8iGpR5D6pZqaRiAYoGifii0QpBNBqErgfTsLo6Qgl
         nR2z1WwcylUAkTj8s2dyNb4t1tuJa/qYt94J+NvnmG2dWAHm0aq+Q1Ny68m+A7F3HtE+
         kIld2nE7JuW8gAnQIZgYPoNe1zTtI7dq+8G+zcyjXaVEuiQIDoh8KcP7gYP3Fb0iq5IZ
         pwy+49lt72FuIGDQIKL4GN3VpTw3SMnRnN6D+X9pegn60+NXAvPHS6LFHcmmDe373SZI
         GDzkDK1py+MATPf18wcqKGZ13n+Z+nfkdDTyWYsjLfZOZHV4d7WYRWfLLiFRCcDUP150
         fr0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=5o88lgTdR3UljadKJlYcq0XYptrmydXykEVU7qCr7g8=;
        fh=ezNj7Add8bYRaMrUuIwU07MvAl4jMA+DsydlWu0YQek=;
        b=B/5AVuF4B9grje01IQUOTzUFDaxxh/KILXBlUVYXMdqzrwAQub5jJNA2PJYZ01iSX8
         i2oDFApGBp/85HfR8bKYdg6NuJpKE/drL7yWfJ4elZ35u9KOLwtC1e0E3zws7WpG6aR3
         qNa8PEPN/QJvxn0sjv38MsXvnT4TCrkNqrUfDW4Syd3bzSd5mZJ4ZFK1HFBqmjtMmqHO
         TvrZtvkLGEm+yjnKhlBtrfU8xtxWN1ykFPQJZqPgpWzu63D5RL/iukN70JknjIWNeVAr
         d1TVxIhmIqUaQhdcP7Nj5x+4vnvywiwsvl/NLrCoMQD4v+HzXGlKLzZJv0efiHcxkLHJ
         mvog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781219173; x=1781823973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5o88lgTdR3UljadKJlYcq0XYptrmydXykEVU7qCr7g8=;
        b=MDpidbA9pDc6VgfIn+INfM4n0ZrEr6dG+BQWouYOveE40WAhfoQWD44Yj64v6zvOJ2
         ITjy+rsEP9Qbl3XAAml4fa/zlDdFrzSfe775rX8ynhXOCqoLDNT5uxTKUnjkMTgIxiV9
         Dcj82RHpuX0+rdFlb+Z3vw5qdMf3zIsXi608EFoFy2EeBPp969VPja4za4msAXFdZLDs
         Xn/K2zXO/2YOrGANhk5RxK5bUHJ8f9/kauTBd9L7ld3pOIhmgPlMHkufEse4jdSliUr6
         rgV6eTQvA+wIYjTT8EteuvFcFIrrL8lGXWenEwy+6mik6M9xpwOfZgVKOkuRIzAgayFL
         uP5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8lCKUbtEZvBb5zhlHABhba7vVHbMYZG1ft9IsMOTgiKZ2vg+Z3Quu/1nR4BsxFaoLX996TOOoYItI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2rxm0yBmWZO8fM20wn9T2cos6Lat+xShORA8QaieLweJQbYlv
	PROIYjai5cu3yr1pQwA0EBkHSokn5PwjWnkVkzXlbJ9i5b2RGOuQfw9AiZ3VujRbt+kvzoOs0q1
	dbe3G4HxEiI3Vw8EDA5xO0qmUmGirUsCUVQ5O+BLEeCJKqYNRlIr1RFfbbyvA/UJrMYMus9MS1S
	7if61PjJ4fVVR99C6P1e02E4a9N2KjmM6R3ZySpir2tTrCrg==
X-Gm-Gg: Acq92OErV2eFvKLJ5C+WgOc/DheTXGP4UQhTdW3oJNO9GJ504yRpCR9QlsjdQq7AkuC
	qv0RCjSXhTKG6KhJEjcVSdHwfPZPV1c8bncPaqnZwruJEa4EZF/7HEEVUcE6f5HvVnMBHwp+os8
	YXcObt2UVIRvCjb1waIJzWdBheFMxCaBwYa/gL7sMgy6oX0vqoXCdP+82ZJho/1WR9QQpiXC4va
	jut384ias5cKbeFyQxenA==
X-Received: by 2002:a05:6808:3089:b0:486:3498:d1ae with SMTP id 5614622812f47-4872f397045mr351960b6e.18.1781219173054;
        Thu, 11 Jun 2026 16:06:13 -0700 (PDT)
X-Received: by 2002:a05:6808:3089:b0:486:3498:d1ae with SMTP id
 5614622812f47-4872f397045mr351942b6e.18.1781219172624; Thu, 11 Jun 2026
 16:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610193158.2614209-3-zhipingz@meta.com> <20260611202558.09C691F00A3A@smtp.kernel.org>
In-Reply-To: <20260611202558.09C691F00A3A@smtp.kernel.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 16:06:01 -0700
X-Gm-Features: AVVi8CeJj9q0ez37YfrPTO2KXyhyeT-bv8zCIdToMWZsgp_4cN-UqKdyKzNGj7A
Message-ID: <CAH3zFs24Gs6MSccrNoP-UmowvpcV8PmweegczKU7Ymq+kMtdxw@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] PCI/TPH: Add requester/completer type helpers
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=d8nFDxjE c=1 sm=1 tr=0 ts=6a2b3f65 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22
 a=VwQbUJbxAAAA:8 a=4OgE2WNpP8yww339eGMA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-GUID: zUJmugISG3I6a7i3QzJvMGJvjsLi6UHr
X-Proofpoint-ORIG-GUID: zUJmugISG3I6a7i3QzJvMGJvjsLi6UHr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzMSBTYWx0ZWRfX8Fa0k4XmzvD6
 0cLuLCO9vt10yg69Y8ilmvo4nRxh7hOiuNlwp36l3aXbh8wcQvRJ5YcOyVP3lU2LUzcoCJhUjFT
 H/Y6lueWPmvOq9toKgNPaQiaY0DU+tA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzMSBTYWx0ZWRfX4wugX+LIx7/I
 669S3flCzLMGbkC+b2WJvy97GbVRfUuJjit/l0rCDYbPyF0I+ReKfeAvEbG+E3xkmAUZTcgyypk
 ll3MDTqydRMs89WHVp5y2tFGLncCFLF7Il722e7j0wL6SC49V6AuxSw6278nlnRxwyKMCq9jhh5
 Ee2BpxdCtLCzAjsqLieZZwktxA67coD/qYLPPwxLPxhs938GH8VQxNMqbzFgvGgNzrA3woWXf+d
 8JFBSKja+jqGfaKCRlj4muACIZ/K7JJlew0ChhRgoBkWz30qX/BjgkxcLMk15wWCjH6C/tDgfxZ
 cPyt/nV/9WbC8qUf/R3MMfnuC5BahC8dB3uTkyYglrJGVgmoq2ZyWDCG75FCD9q8YWITdJBpqEL
 aH3N6ytk9J9+KHu6tnd9u/AfhWuG6rfcqjRTNpR9+w0oRoYZQhMSnptYt6lJ/Wp5oYpEFJl/KZn
 gv0XJEto11TqeoyJRzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01

On Thu, Jun 11, 2026 at 1:26=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> >

> > diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> > index 91145e8d9d951..4fe076bba953a 100644
> > --- a/drivers/pci/tph.c
> > +++ b/drivers/pci/tph.c
> [ ... ]
> > +u8 pcie_tph_completer_type(struct pci_dev *pdev)
> > +{
> > +     u32 reg;
> > +
> > +     if (pcie_capability_read_dword(pdev, PCI_EXP_DEVCAP2, &reg))
> > +             return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
> > +
> > +     switch (FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg)) {
>
> [Severity: Medium]
> If the device is hot-removed, pcie_capability_read_dword() returns succes=
s (0)
> but can leave reg as 0xFFFFFFFF (PCI_ERROR_RESPONSE due to master abort).
>

will fix this one with check like below before the switch statement:
 +     if (PCI_POSSIBLE_ERROR(reg))
 +             return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
