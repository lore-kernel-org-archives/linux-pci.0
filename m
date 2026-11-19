Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795103886;
	b=wOcjexSH2V1fS4LKEDyKg+sKKvsULl69oZEDFCau1IWkXNxtsHYpG34+pu4lUaADJ1Qq
	 Mbf6egO3hc3fturiXq70RhAIotIW3GNJIhVb8CCvZeOUEEdNNWTJ7G12FxuXMuNoaZQ88
	 Z0ddmocFS0Kzibet70oYJvMuE0d0YLId46caZDWV7j90D+ADVwKCDAi7ZCwpzOGXwhipy
	 JINJm3SBx6pCg/NEqXoqknFGxMSWs/9gPj84QyTv4SknOX8Cp93tS0NIi/epKoTOsoeq0
	 DbYHh3xVjWsC6yDj2kuDR795U6Wkw8HkVwLYeUJGHHeJykxaXzvMRnlP1i6qIrKGWVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Zfp/sSG5jLSQxyif0VfIAOH3AOIjZA6+lW+WncRGZ4Q=;
	b=rBvHf6CgGluvb5Cj76vQVAEjuqMJKkVx+xpxEE8GBD/p9bB8D9+o+9Ey/a5++0VmUftd
	 f7Hyz1h3QbK9uBGvFlhZ84Lno3zkX/X+d12uLoH+kI1qiyl99EMn4iyKqHSL018aq2as0
	 6GF1zcAloNW5YW1SVwzuTWf+rMETy0tsrXaeACk1CPEZhkVbZoMKwjwwNY2HZ9/U9q6to
	 xqUu1nF++tr3V+UxZvUvj2wuKXxnv+oh/esMwxBGv12SlBDlhnmtl2Fb3/9LHvwFIPXA+
	 6n19b3hxNtI99gXDxtonSF0cTrPkdWLjutl9FkeLjIUEm73LN0/9pl+xKYlgXuFGPPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="b8/KQKKL";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1813A606A33D
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 15:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1813A606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b8/KQKKL
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-571728135a4so65593b6e.0
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 07:58:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795103883; cv=none;
        d=google.com; s=arc-20260327;
        b=lbuCbg6I+2p2agW4gtnIxZViVva6U6Wqc6qZWd7v3jmn1E7iSmgKVZylasUM3dm4te
         pAa+8YRUqPFSUs8pHDBKxMtwJfPdYtKton4z0gIWBDyxlOZhq3znQjVXnqV65lE8hv+7
         gYTFnxoKWJ9wEUYhmXDfHiA4ZgYhMM9rkj+rTmuSxH1HV5vFZNOq3+3Gklx9nslcoC3y
         gRo1mgVo8w6RIPT9JgvqSlvlTpFy94UKCzzOVHU8uUTFToCpYgDMsNM79q66RZSCdvoM
         FjXY07ReR//jI3p2TXGD9sP9/4AruBn/vooiflvbIIlo2ygZKZKWvgArHzfF5P4n+cek
         oVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zfp/sSG5jLSQxyif0VfIAOH3AOIjZA6+lW+WncRGZ4Q=;
        fh=pcIXNg2jc1lHIvVVDNtPwmdjbgxYfMsob7p4rVKbA+Q=;
        b=nSP6WlQyb9NAHZudYnA+AWg5cojYDowlNVumcKU3I/6Cvw6IDg4oVbGNng23uRNg8u
         IgsT57IjeEWC4deFvML1zgMB2btbCWPA7FEmIGvBGixsSAhh6OUQggs7gz+Mk3NYqwXg
         A76tnvtnOp0l0AW8WBznMyAVNRYlKwrt46T7NVTC3B5Vwule8YPkQsQHMYN/9klKegm/
         WpNMLLYys/H/XNHD8rtr6nvgidhGYfZ0JdDNvHJTuVGBrav3i3X2HC79isbURTXijcfG
         B8T4gHb9Zb5RoyQue3473R6uL429a3zmULkZz2CLRnXaZCwm6PCBJdr11n6a0PjxsBfm
         2IIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795103883; x=1795708683; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zfp/sSG5jLSQxyif0VfIAOH3AOIjZA6+lW+WncRGZ4Q=;
        b=b8/KQKKLuLw2fjXCVKnXMz7WyMe+JMwIhTGJitl1GlmwrZYO1JaOlzINlAnLlovAEH
         UG3KRK3i6l2S4bF9VRNQa/Gic4Yqe129EEfGg/8NRUY29qsTv0Wf4Ng0fsCXrEiuTF8t
         6P4mD3ym2ErzUwo/z1hB91XGfre4iQFqt6cVNRGoqPNLVbdoHeOnIwAVAZ2E3Hd9wHru
         L+3PbDmr5F6g5UJ1S8wtedFVF7mp1U5tVl10y8paIAtzTcgx18oVGhDJcxGFqKrAfVqs
         Ly48oTfs74KEl3SVDwG2VsYSayc8T8AVKtTZOSwKy39TrhqThwe57trwFB0QqPnPHMgx
         Z9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795103883; x=1795708683;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zfp/sSG5jLSQxyif0VfIAOH3AOIjZA6+lW+WncRGZ4Q=;
        b=OXqsJPDLKBrJBAmB8gXzw0Dn9T/ONv55LLk9yaGPnfxbVIpNIux4tsmKeIZSHgPFJe
         2y6LXLmHH35E+xzUBv7htci0Fb4FJC6YRFpPVNVOF4DAMTtf8aMOYvrLkyKVt1LWV72V
         rkbNJfZGjTI9y8B03nuJJ3N/epLaU2nkSnBOxuS39UQ1iFWM1xZYZaz1F61k8RU0jLkV
         Na1YstouRTqdCirgZ+n6q/xF7TlWRFrVf24LsPy8PiH3S69Vx1D/LN1k6SnNgL/sHqv7
         QuF3uE368FFDExnHuI3lrz4E8NbUb/jSKpGJAcHefjyGSENK+USmg5H3ZTuhrKc1ssOF
         dxHQ==
X-Forwarded-Encrypted: i=1; AL+hErFHgMv5dJ1IbRvXiK2x657F3e69PWL8BjQddGDFFWIYmQNb1yZuyG5O2MY0oVusZcRaEkG4ZgLYULw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ta3rvdjz/u5R5GBdehQ+aXu5lLwzbPeq8T0agv+frROXeXzAW
	JVqrNmF6SeEmabLqh99KaHYaayOVqSZrG6CYl8D2dXHXSDJ7ybELSoeGOyraBwdaLXtqG0iAgdg
	gbZVPAOW/ORc2MkqrWzo2WJ5SRjjP40c=
X-Gm-Gg: AYBFou1nii4DiL0HL2YRfKAjfP0TaLVZL/fHkWZCj8YkNQAjXC11Nl77v0m7wMFDJoZ
	9WEGzgrED8CYgLSBvWANFxf+SVcMuuUCGGb7fIIaU2UpToLJO0lGjmCODAOVUXE3dWS5u27Ecem
	SMusDQPLNazz+etwIVraB3lUT54Tw4OB63gzYjc/lMsqmcGGMVhR80O4iCCv4gy5wnDMBqJvavK
	/L/enn6U2JIpZXkXAOvk9/x6pYbGGTh0NH43gEL2gtXgunCptD47fRxURZBN7+BYcJPsQlgECsm
	i0YYFl6GGWBApce22xh060nG+QjoXVIAnFJlBFiCbik4I/pgwAr6upsvnXNNB5b19McqzjTjcV1
	I03MxdG+PRtNDFvtLZiJAjsGFj1OUQlvG0r2+0vy2u81i6Bvsr7oQo14dquyxyy7RZd9/huHp8J
	Jz0lCHQ3Hz2lRkb5iDQndnJWYPZSijEHpMn25vNQHY9ZsO62NbOTRyj9CW/IkS
X-Received: by 2002:a05:6808:1a0f:b0:572:f9ab:c2c5 with SMTP id
 5614622812f47-57a0910b919mr443253b6e.4.1795103882844; Thu, 19 Nov 2026
 07:58:02 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-vfct-regression-v6-0-393797bbb6e3@amd.com> <5cf8f937-acc8-475e-ba0c-6be00defbb53@amd.com>
In-Reply-To: <5cf8f937-acc8-475e-ba0c-6be00defbb53@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 19 Nov 2026 10:57:49 -0500
X-Gm-Features: AclHuK-Pw2ItFRgv4vG8DuHpZH3Cm8ObSCuVEl9wVmjZ1BCfQqEiUUdyusvBEWI
Message-ID: <CADnq5_PAarNZ24xOU3MqVfEra1hSOqgrKQxvLppyCWZQebr_yw@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Fix amdgpu detection of pci=realloc
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Oz Tiram <oz@shift-computing.de>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, 
	Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 10:30=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 11/11/26 10:43, Mario Limonciello wrote:
> > amdgpu needs to know the bus number the platform assigned a device to
> > be able to match firmware images against the right device.
> >
> > This was previously adjusted to be a soft filter due to
> > commit 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with
> > soft filter") where if everything but the number matched to take a devi=
ce.
> >
> > This however fails when there are two identical devices.  Instead save =
the
> > initial bus number to the PCI device structure and then match that.
> >
> > Link: https://lore.kernel.org/linux-pci/20261015124843.203905-1-mario.l=
imonciello@amd.com/
> > Link: https://lore.kernel.org/amd-gfx/20261019194106.2796150-1-alexande=
r.deucher@amd.com/
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> > Changes in v6:
> > - Capture the firmware secondary bus number when reading bridge windows=
 and
> >    ignore unconfigured values so rescans cannot replace it with runtime=
 data
> >    (Sashiko).
> > - No change needed in the VFCT consumers; they continue to read the cac=
hed
> >    value from the upstream bridge.
> > - Link to v5: https://patch.msgid.link/20261110-vfct-regression-v5-0-f4=
9fae981bf3@amd.com
> >
> > Changes in v5:
> > - Record the firmware secondary bus number only on the bridge struct pc=
i_dev,
> >    guard it with a validity bit, and keep it across rescans (Bjorn, Lij=
o).
> > - Drop pci_bus::number_initial and have amdgpu/radeon read the saved br=
idge
> >    number when matching VFCT entries.
> >
> > Changes in v4:
> > - Retain secondary bus bus number for a bridge across rescans, and the =
child bus is initialized
> >    from it during allocation, before registration callbacks run. (Sashi=
ko)
> > - Rename variable to clarify it's for bridges (Lijo)
> > - Link to v3: https://patch.msgid.link/20261026-vfct-regression-v3-0-fe=
9586ed6978@amd.com
> >
> > Changes in v3:
> > - Preserve the firmware bus number across bridge renumbering, capturing=
 the
> >    secondary bus number before pci_scan_bridge_extend() clears it.
> > - Adjust member name in all patches
> > - Add tags
> > - Link to v2: https://patch.msgid.link/20261020-vfct-regression-v2-0-d2=
394d11450a@amd.com
> >
> > Changes in v2:
> > - pci_alloc_dev(NULL) remains safe.
> > - For buses behind a reassigned bridge, the PCI core now saves the firm=
ware secondary bus
> >    number before clearing the bridge configuration and carries it into =
the newly allocated bus.
> >    Devices discovered there inherit that original number.
> > - Add changes for radeon too.
> > - Link to v1: https://patch.msgid.link/20261019-vfct-regression-v1-0-5a=
63ddd378dd@amd.com
> >
> > ---
> > Mario Limonciello (3):
> >        PCI: Cache bridge firmware secondary bus number
> >        drm/amdgpu: Match VFCT using initial PCI bus number
> >        drm/radeon: Match VFCT using initial PCI bus number
> >
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23 ++++++++++-------------
> >   drivers/gpu/drm/radeon/radeon_bios.c     | 25 +++++++++++------------=
--
> >   drivers/pci/probe.c                      | 16 ++++++++++++++--
> >   include/linux/pci.h                      |  4 ++++
> >   4 files changed, 39 insertions(+), 29 deletions(-)
> > ---
> > base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> > change-id: 20261019-vfct-regression-2142fc52852a
> >
> > Best regards,
> > --
> > Mario Limonciello <mario.limonciello@amd.com>
>

Is v6 preferred to v7?

Alex
