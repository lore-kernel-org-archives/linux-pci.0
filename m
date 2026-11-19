Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795124423;
	b=bJglxMerhiJo0TLiSx0/b1J0/wDl6Y4hE3EBfzGT1bTw9igzxVyaTu5eiea5zKiA/uad
	 mYviTONKR0DCUivo6DtxfGMP7r5PGLMxfR/vOth5fM/g2vKwXigVZV5V3vM51V6QXoKWC
	 KA9C4TltrH1nzLkqxGB8V56Pkhhsat5jH/57qu+PjH7sXDSOd3tuE3wpZTylSU7ukvmis
	 BZtSG8Tt8QsUnvirpqQvrPnzzkpyVvXGf00LQCTWiNfmviyIp+rvohZWKF8ncPX2eZgrQ
	 dsT6G9JeGtWpRFNNYZ63AO2AzAb3QM6hfiuOtSiEg+1l1LrCHbgbfBSzSZxmd7mT8mg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795124423;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dh8hPARkgkUETdolih7JoovnBIYD0QkI16GrSMzuIaU=;
	b=tAPMfrWnRF2voM0moQy3ZDRAA9Kke9uPh7KKuCfIz3u3Umm0O/iMKAvyBJiFm9O3vv7h
	 5bH4df/Xhm12EjhaiDOYrvSBZyiUabhDvepGwAXCfc2DmAuSbfWr+YVnUlMLW18aODyhK
	 SsInJ5Yil8PhYNXSo/nyZ6kS2+jQEhIlrrtvGKq2UeHiw4jGt6c1uTVeBY0A1W12iBqy0
	 KsBeSfEoF4YcmjFxRsakMR0cbD2amjpzX2wvPPlIViG1lb3BnQz5ibzlvFa1rGz95Q3Ph
	 PgJWL3E9pq0tALrfpIVW24E8UD/0i5q6HSIm+IcoRAtrv4hr2kEZXqrHlXYSVcO/6cw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vJhRNbPS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FF2606A326
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 21:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54FF2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vJhRNbPS
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-861967d1845so29533a34.2
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 13:40:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795124421; cv=none;
        d=google.com; s=arc-20260327;
        b=s9sfqtJhSIGib8PFAvOcwg5nlABvo9kwwPvHhDwr5lD7Rl9sdxMnsuf6dkXpfp5HxX
         xV3uxEQtHNYi/DmKwh9yb7fFru3wzhNTpsqByOOh8r1Zlu8rlo0LLCLNkCgvOwZDGFF1
         Ih+M+qv+Am1wtZo8+kGZoylom6vx/ou725Kq+Q8kF1LJjQjg7LkOsucPC9UWDI3TKR9H
         OLHpMde8q6B/V999KS3LYYZ9MbluN7Kr/PmHChPFaUSaqS+m+Uml0tsVJVaYZZr9i5+i
         2Oj9ropEL2bvrlkDe4cjabBTF+M/GbY7+TL7wqnomsAhkvZGbNPJWoNp/tm0N/oekq6o
         Gbaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dh8hPARkgkUETdolih7JoovnBIYD0QkI16GrSMzuIaU=;
        fh=E2bFrbf0AVBTG96wtvrlPdWUMAAjMQ5elnFkNT0CA4c=;
        b=dH4As7jXKfFsCvlppnuIYFBtLACAsgr6LT3H2kwZ+CaZEKidoSpR36JstG3cEyKoZZ
         UHE5pSYckh6I0Q2oDGpGBpZWK/HQ35F3SScYMY7dDZ516XdYxpvuCfUpOHZmQKwPGV2t
         lJzVXAxRkh6dtfb8a7RJ9gMhOphxgMEzNXGDEwpwn+PbTtKNT3eb8Ar9Cl4+wFM9exiB
         r5l4d1mvhfl3WfJd6NNba0wn6x3zzjabxYDLBBuq0jjX9Uu7bptSukJvFyX3A7+MIaJ9
         mmD/V7yprBHrxSx0BXUqXz4QIH5gGTSHM9Vjr0IlSBkFE1vDkggg25sJKHB6lhOzdifd
         B3wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795124421; x=1795729221; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dh8hPARkgkUETdolih7JoovnBIYD0QkI16GrSMzuIaU=;
        b=vJhRNbPSiDHBE00uSsi2Y4flMpDALYDutUsYLmkmNi1UK30agJNcP3TSt4lWDcFiNX
         RdIklrH1P3Ebs5rHilb0MzOq7gMDFHIobZQq+Y86Rnybix4evWvu3DP4OA/KLJIcBRBq
         cfbCSXvynM6qraQ/ZTjNstff8pbpz30UpkJR2nqMkENHus9XRLc0iAtMG70PXqpLq1mw
         yD8Rq3EshH1gsCEoY4h5Gxw8sGnMQLWgmtxc29pZPTax7i3W+zQ9yV81bJ91SoqxS7u1
         Acd9kKvu5/0NelVIMlBoI1md79lXcXRnFSe2J0pxe+v7xsVleyET+VLrn3p/7dVjELrG
         5nrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795124421; x=1795729221;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dh8hPARkgkUETdolih7JoovnBIYD0QkI16GrSMzuIaU=;
        b=UpeMw32IWp6xPw7B+06hOGUkc868X9XBFqdEljPQ/dEKtrjC33byirOCd12bJ2a+Mm
         LLZmBS63yAVYtAxTK5Ajq329YiqyOyWzyhOVcVzhu+CaIYP6hpoqz+AnlXt7P9Ks5BUN
         Q2++1+lYxiCpEBl87b6Q2AcVtBTEe+hfSwmjWxmgPljMVVLjCGOR2CqX4ceq56RMOiyw
         bd8tRtoZP/d13f9dnyXoNXciIH7NOAZXPfV+FbKHLKDLyCOpZt56nxm8U/ZFV6UA2O7i
         2pTp/D4ZrNytOUKC7KXJ8brzzi15J0OXbFmyyIgMiyWPRwpRYckCMgOVZMNJs47c90Nv
         tOcg==
X-Forwarded-Encrypted: i=1; AL+hErHYCkNyrySyZSPzYYa7rtQknt2U6B2u2NtBIFx5GfQI31RBPzu+MGWuXoZ2qNykb1N6100qFOTkKMw=@vger.kernel.org
X-Gm-Message-State: APuU4Z93nh/r7dAojn7sbBwCEpeJKL18jE7IQyk795vtNX1d1kalGBY6
	fmayYjA/FQPj7Jws29vSjFT8z/A00X97eYweIf2456VnxSaOTD4rmeNu38Aj/IKxtDAz1WPhIPy
	ilhym2YZpD/K/uIMiYQQbKUCETQjh+DA=
X-Gm-Gg: AYBFou2VZhEGb3YAaYoLJrd8br0JfQhvyl0JK9SndGPIxleO8mmzIAITmBfI60PdWPl
	8WYRZOse9zdSnVwMg5INoBUzvQo9jSRuPYb1wmKV7E3L4PMw01ZQalCXUD9U/nlt32B0jxXifeH
	D5LIKZp9/ir4pHFL7Svae3ECEmyi5s4pukTZuQKRlHHX36J0gGw+hh51KjhWMNRvAdeRKlpVwHX
	KkKERhtSiu3QBik57F4r0oJvZxrQgW6//JsxbE3yUhlv8iA/6BCilblcRubZFLX8ibOhTzAU35L
	xs6FRNghewsYRF3qbyc6IpeSALxiTotD2dxxAMAwPMmxu6oJth38nT/k25VpYYJG+MQiasrK0vh
	Db6HjikNeGcVWe7ikQIoWX3FpXQ5dmiKkFGh9LiKxULIm/hu/coqBumcN4gIdp4KIrjBkS957XA
	+mVVSQsxNPfVpJXpSO9T7QaW/k0wQig5fmqQXZ4LukN+Xs6vNcDeFS087BxpPR8CEMudd8HVsXH
	3bRPfCE
X-Received: by 2002:a05:6808:1997:b0:4e9:73ce:e2a5 with SMTP id
 5614622812f47-57a0cae51ddmr1946320b6e.6.1795124421207; Thu, 19 Nov 2026
 13:40:21 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119195553.GA835692@bhelgaas> <73e3f0a7-59a7-47f7-9136-9d0b2660c4c7@amd.com>
In-Reply-To: <73e3f0a7-59a7-47f7-9136-9d0b2660c4c7@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 19 Nov 2026 16:40:09 -0500
X-Gm-Features: AclHuK-ewSQRrgR13aE9Un8Yxknw3RfIgY0WWBo41PX4kT0S2asNr2h93nN3-9I
Message-ID: <CADnq5_MA9qEPSX_Bt-WToDh2x5R6VoTKxt9GAazsPcX3aBQXOw@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] PCI: Cache bridge firmware secondary bus number
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, linux-pci@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 4:31=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 11/19/26 13:55, Bjorn Helgaas wrote:
> > On Thu, Nov 19, 2026 at 01:21:19PM -0600, Mario Limonciello wrote:
> >> Drivers such as amdgpu and radeon need the bus number firmware assigne=
d
> >> to a device to match it against firmware tables like VFCT. The PCI cor=
e
> >> may renumber buses (e.g. with pci=3Drealloc), after which the runtime
> >> number no longer reflects what firmware programmed.
> >>
> >> Record the bridge's secondary bus number in its struct pci_dev when
> >> pci_read_bridge_windows() reads the bus number register. This happens
> >> once, when the bridge is first enumerated and before any renumbering,
> >> so the value is what firmware left at FW/OS handoff. Devices behind th=
e
> >> bridge can then retrieve their firmware bus number via their upstream
> >> bridge.
> >>
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >
> > I assume you'll merge via DRM?
>
> Thanks.
>
> Yeah, I'll merge this through drm-misc.

Might be better to take via the amdgpu tree since it affects radeon and amd=
gpu?

Alex

>
> >
> >> ---
> >>   drivers/pci/probe.c | 1 +
> >>   include/linux/pci.h | 2 ++
> >>   2 files changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> >> index 9a178e0e5f7f4..89a7c52ac3e5b 100644
> >> --- a/drivers/pci/probe.c
> >> +++ b/drivers/pci/probe.c
> >> @@ -513,6 +513,7 @@ static void pci_read_bridge_windows(struct pci_dev=
 *bridge)
> >>      res.flags =3D IORESOURCE_BUS;
> >>      res.start =3D FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
> >>      res.end =3D FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
> >> +    bridge->fw_sec_busnr =3D res.start;
> >>      pci_info(bridge, "PCI bridge to %pR%s\n", &res,
> >>               bridge->transparent ? " (subtractive decode)" : "");
> >>
> >> diff --git a/include/linux/pci.h b/include/linux/pci.h
> >> index aa3765a20a96c..4c1b1e557a607 100644
> >> --- a/include/linux/pci.h
> >> +++ b/include/linux/pci.h
> >> @@ -363,6 +363,8 @@ struct pci_dev {
> >>      struct pci_slot *slot;          /* Physical slot this device is i=
n */
> >>
> >>      unsigned int    devfn;          /* Encoded device & function inde=
x */
> >> +    /* Bridge secondary bus number at FW/OS handoff */
> >> +    unsigned char   fw_sec_busnr;
> >>      unsigned short  vendor;
> >>      unsigned short  device;
> >>      unsigned short  subsystem_vendor;
> >>
> >> --
> >> 2.43.0
> >>
>
