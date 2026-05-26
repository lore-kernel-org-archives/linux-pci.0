Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C391A9F96
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 04:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779770634; cv=pass; b=qzyWUv1VbP0MfgVHDI4ZlO88CpXvZyZN+g5HlmQfULIcEo1e7c9yB+8Bxo1O8mwpxlnE9Yk69yJV3tUU5vDbXmNYzGuiiBjWlS2ogWzfo9kphb7a7Do/g8wyBbJjYEqiXwrmiUtx1ZfL5Kn/sNrHij9B4ewLOSYNA+sJV9yHui4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779770634; c=relaxed/simple;
	bh=if1b69KHATq0gJwTrfVpPLJ5q1oj3I/Hy53zknCCbWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUpNntS5pkxs57dXsaD+tyspHlQtzwB3dIMNOU+iM5qv4tTLn9NqoUbPQXtwz89EhJGfQA28UhAzkGI658QZhOSBkNYFIGRLBBf6nkzOCSLIaaFox2tjmCoyPcT1F6Nm63D+FtcxTvffN3TZBe5hjosswG7JrMxN85E8MSd9Fhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbYNxPFN; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbYNxPFN"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68707d88626so11990254a12.0
        for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 21:43:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779770632; cv=none;
        d=google.com; s=arc-20240605;
        b=CEe/JopwIIsp4Z2AHhju6HELW7kiAsP3pE019KN8GHBSEQMHinQ43OSuFoMtcMNa5N
         zLKR4p/H9Dc9gUkCEUmafMsIHEQUeyoa33bpWNgzxkNbyRfdN6VI72Kojvj4YrSvPI7Q
         sG59yqFqFb51UsJ8Fsul051DGHnuOtmimPO9m0xC+JmMos6EBm2dkMgls7/sLa/dyBP2
         KAdXzHtTWMHqgPSKKqLNSZXoqHCm+hdNvlqMxx53PmA3vrvo4Xhx5iI+yUkiS9iBpDtZ
         6nJRTRlj2H46rL9+I4PetL41zB10v2B4S7UQNaDae+6KWb0/4qBcsS+DQb/hCbFJumW9
         2R5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M/shEe3xqBpt5QuLR5/kC78Z1EP7DMk/aIHBbFQF1Fg=;
        fh=2E8G5L5HRIhYv0SLHRh0bmuG4bK/RxhrEd6+zC1U6gY=;
        b=lVQfSHuhbXN1Ni9IjjoErAun91thFnyGs8JWqAkeMvSB4Y/mMGM9dPfcHS1c889M0C
         p8yOOnQXlf3/JFE+OQrvO5vZQfIVy2fcN1c5P/5pqARGw2OUC/97yEPqjYItkMz6LLmw
         EYrgwpV0+CTd00SKXKm+vgl2uLBQp/cBrkb/1t5sbOwodI1ZqLpIrbIKxIopdRC5csuj
         XEYq6yBR2lxoGyBcZlTIFg1PByalyTt2XbzZsDQf2RdBHroENQlj1+iwSiOlnTnRFt2+
         mNF8DIOBKeCINdwJRBHd2c1Y112tfYYIACpZSOen8n+v82ghKVEGY1xmB8yISyriouEa
         wegg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779770632; x=1780375432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/shEe3xqBpt5QuLR5/kC78Z1EP7DMk/aIHBbFQF1Fg=;
        b=UbYNxPFN1fV3xiebPNtYHOyUY8zJX9coHS7qYXZp6nwI+vUm61kz/PYhaAygurZr/g
         RhKsCMEEaSCsWZXCrSO4gX0/maFxVKOD5MUruHiXXSDjM3ztLxqVmrevKfFnaQRQ3muS
         GKbdjrreMABZXMDB+l0Vxr1DwD0IAEFk+KO3ykRibPWo8JuA6ncxCSMl4SWI9rps1IKQ
         fP5n8/DZzRXQsupzmMufLaUay8Rz/3bozS4OeLWjeqpz0X+ZVpV0+MxdQS/E02ETAkFR
         EQgFCBP+tj8Tt1hoHv5aar3noijKzfSytWzKbZcSJ5vk7DSCqy10lsji8cRHUNveG1UA
         wbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779770632; x=1780375432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M/shEe3xqBpt5QuLR5/kC78Z1EP7DMk/aIHBbFQF1Fg=;
        b=Z23eO1BX+H/d+K68Helx5kwdAlyeYRSfqyl7cgbbTKRs9PlbZF4VbvH3TkoiuxnSEK
         fNineaL5hHnw94FSFGYzPyf4TPkNt8JIy04DFWtIDUak8jl36OSmskT8x516FCWEKaVP
         eziCsV9rdyn9mcm/u4D0swN5mKmIc2TFsVDuCFKI5qYkTvePsHqE7odNb2cUskqX7dqP
         8RIOnE5bvpDWevlL7Y+81kUBPfhXPazSDgEDxpJK1MIHaUKPsIBWlm8wic8SrKUP2VAU
         fT7k4gigh3DF0aZyjkkN7RoxoaYRaPVXXj7r8FWtLZ0TOvpn1iPPSzurXse+LKQnz/LQ
         c1Wg==
X-Gm-Message-State: AOJu0YzHyoKv7ahCRSuGRQaD2j2fboOuQxNmb5yR7MUF2XBiu0Q952X3
	QEUZCZ+gkV74ju4gvFm1KhzhJa2HvTHdGGpjfQd+iko7OkW3Juouq5hy9AynmJ7BY38Kt2Mx5x1
	A/0VEA96QInyxcY+kOzCfOCeCbQiF8sXQRw==
X-Gm-Gg: Acq92OGZ4YZLYuTp5nIKB1HZ9qsJ4ePFq/148I+erBDnmE6ZorUK6zh3ckyO39oATTm
	DBK4ov4AQZvOf4HjtVfm57vFi4Pmh6vJ5zxR96EWhHKlReh5mnynibaGSoRg82W2Pbcgy2pepyx
	5QAPvg6NdvS9scUICkNi+dhjkKZctCZCWxweUpEf1lbgh/Aou3Q3v4SvAZ4ymXbtlXDDCBqoI50
	lM58PlLP9BD5ltfDSfjHtoLMw8lQOSbzaGUiIvmDnMdaZbDxViQHv/dyByo38wM9qBTii30C1jT
	EJyIeuxwjwlgShyWrIi0enUMbMk0e4nhe3detxsV6z8eBVdlDkLXLiZom0RzIg89GeYqFkaMJXp
	2xxV8oaTvZZ0Cu8ulcjRqLEErk5qVyDs9YBvPoyHuHVaPjtTiXz/WvHtDNA==
X-Received: by 2002:a05:6402:4348:b0:67f:9124:8815 with SMTP id
 4fb4d7f45d1cf-6889cc4857emr8386542a12.17.1779770631555; Mon, 25 May 2026
 21:43:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526042614.1013867-1-rosenp@gmail.com> <20260526044110.29B821F000E9@smtp.kernel.org>
In-Reply-To: <20260526044110.29B821F000E9@smtp.kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 25 May 2026 21:43:40 -0700
X-Gm-Features: AVHnY4ITFCqWA77JZlqnmYcLNceVp4DKffune1OQTdWsfPcNqSegblQoB11lwv0
Message-ID: <CAKxU2N82jB9F_rArLtE5-xRVVZ8F5jYmbih=8cB9dsJUXuorZA@mail.gmail.com>
Subject: Re: [PATCHv2] PCI: hotplug: compaq: fix X86 dependency
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 9:41=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The commit introduces a redundant X86_32 dependency and the co=
mmit message falsely claims it fixes an x86_64 compilation failure.
Which is accurate. This should not build on x86_64.
> --
>
> commit 2f32c0aa3739414d8be655780c2734e155b45ea8
> Author: Rosen Penev <rosenp@gmail.com>
> PCI: hotplug: compaq: fix X86 dependency
>
> This commit restricts the HOTPLUG_PCI_COMPAQ Kconfig dependency from X86
> to X86_32. The commit message indicates this is to prevent x86_64 build
> failures caused by invalid assembly.
>
> > This driver needs X86_32, not X86. It does not compile on x86_64 becaus=
e
> > of invalid assembly there.
>
> [Severity: Medium]
> Is this description accurate?
>
> HOTPLUG_PCI_COMPAQ already depends on PCI_BIOS. In arch/x86/Kconfig,
> config PCI_BIOS is defined with depends on X86_32.
>
> Because of this dependency, the driver could not be selected or compiled
> on x86_64 even before this patch. Could the commit message be updated to
> reflect this?
>
> > diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> > index 3207860b52e42..5074c0ac4ce18 100644
> > --- a/drivers/pci/hotplug/Kconfig
> > +++ b/drivers/pci/hotplug/Kconfig
> > @@ -20,7 +20,7 @@ if HOTPLUG_PCI
> >
> >  config HOTPLUG_PCI_COMPAQ
> >       tristate "Compaq PCI Hotplug driver"
> > -     depends on X86 && PCI_BIOS
> > +     depends on X86_32 && PCI_BIOS
>
> [Severity: Medium]
> Does this introduce a redundant check?
>
> Since PCI_BIOS already restricts the build to X86_32, changing X86 to
> X86_32 appears to provide no functional difference.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526042614.10=
13867-1-rosenp@gmail.com?part=3D1
