Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C633876C7
	for <linux-pci@vger.kernel.org>; Thu,  2 Apr 2026 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775165581; cv=pass; b=lSDMWXbRhK7w1pt6t2psQRUNClwrNujOwwsxrKNuNNi3Rf4ZrBVm/BtWcxbB1V6i3i7U58J1uq3YzGXOeidZ17B9rwAIFxmWWbScpTitiVwGf0e6jQlRB0NR2PQmLS5cybKVVpdu2Q7C8KC7R46k9JX/zZJOme9XcRRLw0lb+Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775165581; c=relaxed/simple;
	bh=I/iSptK1BbUczXUEXqn8QfJWGkzsfP/xsuvtoUZvNf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqg81vmepmHeDZkhm+eJhxWURl3H6vByFpjgidl7/3wwqjXvRNlkRF2MpqASfhoffTD7ZX2spGpVZu9+seQnJTciDcK/nBNLcYvaZrIe+3N7t9rFVqScB7Pybi7fNV4BdYPX2/zKRGbtnyO/4xFInDrN1K1swDJ98JMO69Zn7uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joyfullee.me; spf=none smtp.mailfrom=joyfullee.me; dkim=pass (2048-bit key) header.d=joyfullee-me.20251104.gappssmtp.com header.i=@joyfullee-me.20251104.gappssmtp.com header.b=Y3g/Tk1i; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joyfullee.me
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=joyfullee.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joyfullee-me.20251104.gappssmtp.com header.i=@joyfullee-me.20251104.gappssmtp.com header.b="Y3g/Tk1i"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b93698bb57aso279204666b.0
        for <linux-pci@vger.kernel.org>; Thu, 02 Apr 2026 14:32:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775165578; cv=none;
        d=google.com; s=arc-20240605;
        b=ZkOEQwO7bY8hRllYOFSTcsOBwxeR8J9horsDcQAa1FQNV3nFIrQwplgEyg2ybfThH5
         zsu/HuobVpCzO7TmkO8UWg57tDg1GFw6/pazNpc62rSLM/mDRZuW+PuiEYfDwinXmnhn
         3gmxpq4AY278G0DrtZX2BCBn/a6Wo0lcfatLPk+1tMnAWv48BGKkU6FlJ3synh/Smtb1
         xpO/Ivm4Qg5/SxPwkl6TQRmirCyOkZu0lvY+W0dGyWqMV5wWnKlWnkYCsKcdz8xSijo6
         cnnXdzxypiCuNRZRba+P7glGjP2IMvWmuPKEvLLbhcbkI7jmb4N5BEgsONSm+EwjM9B0
         zq6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MqhKLfahGrgncfeqRqjGzkN2toMZpIx78EgbNIy9990=;
        fh=k+0aM7DSBh5wOh0VhKJrPqX5SPc0CxvEZ5MEyxzp504=;
        b=FeDl1573ghFTtQ3oBhhaV1vTfN4xRs3NtDWOB4H7r6Ktv2A1OwEK9pkSs5PBi4dIzZ
         uixUVVoJUWA6W3azvxho54iduASOjs1JWx123hbCM/6tFn5c8IoZHayjst2k+K2Ajavk
         /IhgKhH8mJRIZlQgyuWf6vvmuHF8MYhgpUxGVFo3uSHcf1aFHpm9a3sDp9ZyWsgOVO+/
         e5bcUwL4vMWSvojCFjEsG+vBWHBCuouW3PzqFBfMPwNd6xta6qH7qy0EIqhIsncR/smN
         WkwtkupK+8hv7cbDdQbwYuYYBQIYBqqVzEOqNj4zgSPhOurxVadjyx8pQohboFHiZQC/
         12ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joyfullee-me.20251104.gappssmtp.com; s=20251104; t=1775165578; x=1775770378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqhKLfahGrgncfeqRqjGzkN2toMZpIx78EgbNIy9990=;
        b=Y3g/Tk1ikpTnBZMua7iRJ/SWoOLit1ReMbdLFKM5atwJ/oKYRqbwhsNcL6l2Iwvwkg
         v6br7WZz20V1BT2d5zP/5kjBXRfGwwyvmpy/UPjOTktHDmoYgWY23LY8Nbf9fuYBcrPF
         MWy3ZTYxPwooaDyoyBsPrQhJJN7gD+83YffopURCxET1dOdR2qjX+GlXikwM7ESKMG4W
         6KXE+e+00GaW9K7A3hfwviqEEfhyPj8tK47EwQa+rMuS0TMfg0JZVXYuKDp6mj3BrkFR
         MXQIkCoPQoGMIoqe8xzt2tCfzhrcrGQAx4nNEO5989EJBMMQ1TCyS+L6vPpVH6D7HBYt
         l7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775165578; x=1775770378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MqhKLfahGrgncfeqRqjGzkN2toMZpIx78EgbNIy9990=;
        b=a0ArzSQ3MJNJtgDMc+7aciHqRASj3Hh+Y3xYn9Ul5m1oBLAsfcsG4/0tnCnd+YAe9/
         uylL+8WzCf1Xz3gQXCl0equFbjCxP/INCorhluB/a/z/V3tVuEDj2j2JGKjcPRovGKUe
         tYapS4K20dd8SDN9pyY3eRIguh2lZ5fDAxOJT8wYuI+Cf446VbwetbeG9HYTBZv8h9ln
         h0gOcie7Y8PHu0sv5U9DrLpt5+NkQRXFylDl+EXSf6VszCrvq81xP4HmBNtMUAlSMAAw
         QNf3B4Gw+2ebLUzHVK1lPBykuhgJ4nC4imZSnJieAkwfmcgSWz2xoK/PXc5WGXZ2cFZh
         AK7g==
X-Forwarded-Encrypted: i=1; AJvYcCU8aXPeUbiE1DtpC8AUwZAi8w8dmstXGQi3IQgd9LCUrQk+tTgIhczJAzmddJ+Y+WCPLiK0hqzQxpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDCkj4iqHTZp8c0C4B40sNRu1ogH5ZuF2l5uUOf6NFb40sOM9o
	DOCxxSXnSOqzKKwifEBWVKWk/XC1NChN1a/uZ/F66IUOmsbWouFS9UrmYo6kSWaIpZZg4blWO74
	jCtSAomVA1RlkOdPPf1X8EkqOWBfMwIrOxOWdcu7aDw==
X-Gm-Gg: AeBDievAmAVgWhANB6p2yE5EHOxe4YrOpRFsadX6E15iWBF7OJ5oRbTAfyTCYPF7ps5
	U9lkdwfhhQRKTP/Shk2DMD7LnjBuPiHACScUVhSqA24uGn2egypK7wEtb7bkbOJHq4LoJc2VnIX
	oiIIC8kNhvJmUFc11tCf+iKYEvIwaa0ptA0wE7FsFEl9cvcgvg1/yCCEDkTtKROjpmLHjOXQXKu
	yXG6SvnsJDIQxXJB+k1kuCLnWm/TlID/eJuXoAxQqpcBHm38S7zzZT7CEUKbLhUUe6k06LDctCx
	1GhFiw==
X-Received: by 2002:a17:907:3f26:b0:b9b:6b86:66cb with SMTP id
 a640c23a62f3a-b9c46de6747mr174196666b.2.1775165578007; Thu, 02 Apr 2026
 14:32:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADj6jrgK+sRXoNaYH90Rdc8DYEFK2iSF4vkJC=KE4UaZ73y67A@mail.gmail.com>
 <a935b2e3-e11d-47ec-af47-7eb7e86a9dd0@amd.com> <CADj6jrgcuz=Bcp0q7BHVizVeF=C2r_8qXw7r0Mc5X9Vd8uWK-w@mail.gmail.com>
 <4192851c-20d1-4185-9f63-32c66ed2a664@amd.com>
In-Reply-To: <4192851c-20d1-4185-9f63-32c66ed2a664@amd.com>
From: Joyful Lee <joy@joyfullee.me>
Date: Thu, 2 Apr 2026 17:32:47 -0400
X-Gm-Features: AQROBzARiAf_yZZwTk3-KCMyBYeIOnmMVmiItOYF1PDxghtRboGkZ851yyqqxZ4
Message-ID: <CADj6jrgse2NksUgkHUzTm0332ba4qnV=0QOJAnupS=Lr=5hh4A@mail.gmail.com>
Subject: Re: [BUG] ASUS ProArt PX13 HN7306WU: amd_pmc s2idle S0ix corrupts AMD
 1022:150b root port, NVIDIA dGPU returns header type 7f
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: platform-driver-x86@vger.kernel.org, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 5:14=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
> Can you please explain what root port corruption means?  Are you
> actually meaning graphical corruption?
>
> A few things I want to point out after resume that might be relevant.
>
>  > pci 0000:c4:00.0: Unable to change power state from D0 to D0, device
> inaccessible
>  > snd_hda_intel 0000:c4:00.1: Unable to change power state from D3hot
> to D0, device inaccessible
>
> Both of these devices are part of the discrete GPU (VGA and Audio class
> endpoints).  So neither came back to the right state, which to me has me
> wondering if the EC is cutting a power rail used for the discrete GPU
> and it's coming back at the wrong time.
>
> It wouldn't be the first time that the kernel raced with firmware and los=
t.
>
> What happens if you pass a PCIe reset to the root port above them after
> resume?  Does it recover?

Corruption is just the best word I have to describe the way the dGPU
bridge (00:03.1) comes back in an unexpected state after resume and the
two devices under it (the NVIDIA GPU c4:00.0 and its audio device
c4:00.1) become unresponsive. The two lspci attachments on my original
post really demonstrate that weird state.

Indeed, the "Unable to change power state from D0/D3hot/D3cold to D0,
device inaccessible" messages are the main symptom of the problem. I'm
purposefully avoiding the nouveau and nvidia drivers at this point to
reduce confusion, but the problem happens even when they are loaded, and
both of them crash upon resume.

When I issue a reset to the root port after resume, it does not recover.
The kernel prints the "unable to change power state" messages again and
the devices remain unresponsive.

Joy
