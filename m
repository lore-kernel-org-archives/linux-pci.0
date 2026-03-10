Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5F03CF046
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773161170; cv=pass; b=KeW2+bOag8Duc3JpkooUUL/z0GE3Cj80UcPze+vwcSuR/AbwDoz5RgDa0HoCiFSJF3aJY1CRWsONYhv6VYWlC9iLqabgF1DwuyfK3yqzu3qy4lK5y5p5evHfUdOKEuA3FJnWkW8HexYXzu9S531QfzXsdJDnao+PnQtMPL3ij3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773161170; c=relaxed/simple;
	bh=W4UUoMCxfEZ7BVklQrFF8Qlkt9KjG0xmQgYXi6Y0450=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ftZTNGqqzPWpqa5LSflCnKZ+tG5DbGebBu5eMuzyNbukoLaIkMp+Bji+O11SIqfX5R20Dw384GtOG5HCti9o/ylJTVNcT/fr6Pnxu5252PGRmHHcHFnOz2IH4sKJL3xtKcRCMN+pJh6M8F6cHZEG8qn3FDfIbj5iOxtwvzibCWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFZ7sSA3; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFZ7sSA3"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38a01c80c34so141809141fa.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 09:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773161167; cv=none;
        d=google.com; s=arc-20240605;
        b=hcjEUCjj1Vn2o5vGQ2KACKKKdddogpI8MnLxuG0HUp617VLmEMv7yQv2uTJ4Ps3ZDP
         uG7Fdv9lbEdK1i0tPdNzRZlOIw/hwOqfloEGReDX50OaZWRKoAZhb1k9KjCGyr2awn27
         tiNvlum95OggugGOUVYycacPCrg+Rllw6shtea65hYijXFttxpxFlbrQ0Z66zc7bzqg8
         AT3+4yog2gLjQIAixQEyhjjdypI3PaYXBjsD+riqs+8XZnLNaRwtxVICeMWBPWPhJT0Z
         hYf2AgFV8/giV0PEazhw/EGSbs7M5btom1T3vfrzPhe57l5/rFPc/eOP7K6eENKdFK6u
         36Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6QTUF0rve9LkHPmJW8pUUJ/gPbkWowjU6eSADSpNkBM=;
        fh=ukumusKjPCPNBcq2YDxuVNi2DxAoknhlYNLwoeduvVg=;
        b=WHyHh1NeBYRBY8JrfQqxUZBK2IppspREKOoU2GPVuRX9yMwd4ATjsefoaEL32WJOoz
         ofe0YSuGREVFZ/J0Xggv/LWAAmIHDQq0VtXFbddf+X0QeDauHFtSYwCTPqcofOVthFQY
         f23vsvk788iNhr7+nMaznFY6QZnkdzoI8ChfpRXz4a8DCW4iZeMJQPqVRb9yODJEqj5P
         ESXlhMgTmhaYUouHqdA6C7S2ZLIfpUjJavcpgE+butk2iPK7xE3DHq/BhLQEk1W0PGsU
         0ZhwOPjnIhpdOqe6USSPwQBfxJqp8c8Bpa0ca8313aVUGn8hFxj2RPpSbKtLNsBtLB4h
         Hkow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773161167; x=1773765967; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QTUF0rve9LkHPmJW8pUUJ/gPbkWowjU6eSADSpNkBM=;
        b=GFZ7sSA39fHjxQ5qRzhsHfm4I3IAoNMalMgFrkCJeRW+1mPomf5oDawv1pS7u3R/Nx
         Nk7tLGrJu/yCrZGOfseFtLAZp05BCUMLx5pez5o3cZHC05Y5uSKs+MYCtLjjmaXEAt8n
         o4QRXULsVxdNFnv++c8KFzWv+oDvGjY9X9M9gVh1K2IUxUnZ7jEKTw94lEIxhrKqHuqg
         WrUDL56Utj1Q74guRkDLj+r1Y/5FewVn/k83alQN14yIfndSfTh3du8mWKbK6QiVcEVl
         6WgTjdRhGn9SzyX3y1mm/Jn9glqppWNU9SVh7AEX7Vhg104Ju8Z7DmmJ4invLywXsVxg
         JoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773161167; x=1773765967;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6QTUF0rve9LkHPmJW8pUUJ/gPbkWowjU6eSADSpNkBM=;
        b=vqoQScYTn0Ppwke4BmhXIG84kMuYWEWyscQZE3J/Fc2YNK8gVlPGkxyQmwGtN42TBY
         pnfm8eieHvw98BFIJWhDlKaiXcCfxBBmLGYGj5XhHBdolBda2xA/CCzEQ2waDQIfS0x7
         hZbemi4w/X7jLTxDBtWZxkvUTsa+WItocqebS1ElTK7jL9cXW/v7WWjepvaVh9+CoK1y
         T1UbuubKv4TwC9VtugupruDVbIckqek9+XyLMrbSf6wH41/JxmOlyWLBR5Xu6pOMqndh
         QBmfgpBgCLRFDP6HbGt8axhKWk6lmstVg07HKaX2OOtR1liVOnbGn8LGsJa8fnP1CtA/
         G/+Q==
X-Gm-Message-State: AOJu0YxOJrgxJtLgpY3BaPIz1Vl8DxnZnLTIo56SfnSPNi28pw/iEXnu
	lG0K90fHBelMQYiIMtUA1Vw+MTY59TGE1VTZlNukUAKGYC3fhlH4FhPLy1ESxndsGR7XSNFCX+w
	2TArVyl57xzEq98gfiReG2TK++g9/JprTNiqS
X-Gm-Gg: ATEYQzzJmy0Uu/SuzuaHGOErka4+K3WeQR4a58ha1ga7dDdD1OZm+FWsxSn0RPAS5uW
	ITTZPGtkkOHbtUsr8YRtHnt+A2zLgCuzIuo453WiEIwLKFBPeFS+zUsy7vYbx1Ea2gXo8JmkgQh
	lVdaOKP6YDxJqKi+yzExDsQnKKbb/LREhLhhJYwK7e/PW9pVAhCxUiXmDJTavHa47cr8CiPR7AB
	NnxByc78m3VLKCsUTlZ6hPAHs7EohFsf12FkXEVKZxabUMpyJWrxcyKfe8GHPSyAnd82E9Rh2x6
	dYuPJTtmGGvwGAxh5UTzHXY/EfequHGga7Pe/PJAE71vDA4lMIiBrG+TsqeB2q6+tj84j5Ud7Fr
	dsFgS
X-Received: by 2002:a2e:9cd7:0:b0:38a:3dcb:927 with SMTP id
 38308e7fff4ca-38a40d98832mr38624571fa.35.1773161167209; Tue, 10 Mar 2026
 09:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bug-221205-41252@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221205-41252@https.bugzilla.kernel.org/>
Reply-To: bjorn@helgaas.com
From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date: Tue, 10 Mar 2026 11:45:55 -0500
X-Gm-Features: AaiRm50skEEq5WC2dP-dpps2yRU2BcFpPst7HRvORWpSYpqrcBu4tUBTbjyUOlM
Message-ID: <CABhMZUWESYKvKxeRvXhF2gkXxAakV0zWR4hjE=50-teHRLLgug@mail.gmail.com>
Subject: Fwd: [Bug 221205] New: pci=relloc fails on 6.18.16 and 6.19.6
To: Linux PCI <linux-pci@vger.kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[to Ilpo and linux-pci for visibility, reporter in bcc]

[xiferdev: Sorry about the regression and thanks for the report and
debugging.  It's best if you can attach the complete dmesg logs
instead of extracting just the things that look related.  If you can
attach the dmesg logs from the newest working kernel and the oldest
broken one, that would be helpful as well.]

---------- Forwarded message ---------
From: <bugzilla-daemon@kernel.org>
Date: Tue, Mar 10, 2026 at 8:01=E2=80=AFAM
Subject: [Bug 221205] New: pci=3Drelloc fails on 6.18.16 and 6.19.6
To: <bjorn@helgaas.com>


https://bugzilla.kernel.org/show_bug.cgi?id=3D221205

            Bug ID: 221205
           Summary: pci=3Drelloc fails on 6.18.16 and 6.19.6
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: xiferdev@gmail.com
        Regression: No

Created attachment 309606
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309606&action=3Dedit
6.18.16 pci errors

I've been relying on pci=3Drealloc to get an Nvidia P40 24GB running on an =
Ivy
Bridge system with DSDT modification.  This system also has an Nvidia 1070 =
8GB
but that one doesn't rely on pci=3Drealloc.

Arch updated linux to 6.19.6 and linux-lts to 6.18.16 recently and the P40
fails to work on both of them.  dmesg had logs about "can't assign; no spac=
e"
and "failed to assign" (see attached).

I downgraded back to 6.18.13 and 6.12.75-1 and both work fine again.


Perhaps the problem is related to this recent change?

6.19.6:
commit 5bd7c96a61cfa147b0039399f3cd7ec8e15f38c5
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Date:   Fri Dec 19 19:40:14 2025 +0200

    PCI: Fix bridge window alignment with optional resources
[ Upstream commit 7e90360e6d4599795b6f4e094e20d0bdf3b2615f ]

6.18.16:
commit 995240f823a320ecb16afe0429b23793145dfab2
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Date:   Fri Dec 19 19:40:14 2025 +0200

    PCI: Fix bridge window alignment with optional resources
[ Upstream commit 7e90360e6d4599795b6f4e094e20d0bdf3b2615f ]


Happy to help test and can pull more detailed logs if they'd be helpful.

--
