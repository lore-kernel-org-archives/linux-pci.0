Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3D73C4552
	for <linux-pci@vger.kernel.org>; Fri,  3 Apr 2026 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775225484; cv=pass; b=aC15WeonzESvf+f7f5TKMxbeJYQAf6sKUsHIwua83pcB+p8WJWUFYvvLDYjdTEHnzYwffjJnJXvfp0uNfrarKbiJb/M4AwZyc1V9ujtdN+7gcbhu2ZRSUeGwg/leP0qSmmqVIy+aPiwX8GYK5NEg0/U5I6P9ICAATLiG/Mcnff8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775225484; c=relaxed/simple;
	bh=IFY1epPJRbr7ePffEFt3cbANBhQ7V7M3EN+QpXKABqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TddpGOB+6oeGOZX38k4+DUdC9oVzbNl4QAR7rDm8Mn63Q95RDk3I6YY97uJahZ2C22kodcpkRolcbUDkiAR/bVy5sxaIzht1eLjeTDSLwdKmWBp/YandLySbkIw6A8NWRoC4MRvmS1k4InLLofJQI6pquGQEbtVC111H5z+VrK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joyfullee.me; spf=none smtp.mailfrom=joyfullee.me; dkim=pass (2048-bit key) header.d=joyfullee-me.20251104.gappssmtp.com header.i=@joyfullee-me.20251104.gappssmtp.com header.b=NK88hXH1; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joyfullee.me
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=joyfullee.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joyfullee-me.20251104.gappssmtp.com header.i=@joyfullee-me.20251104.gappssmtp.com header.b="NK88hXH1"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-66b2f6e983bso3189840a12.0
        for <linux-pci@vger.kernel.org>; Fri, 03 Apr 2026 07:11:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775225481; cv=none;
        d=google.com; s=arc-20240605;
        b=P0kZIMJQ2VZQwiAIGXvOjYqsnx/GZNhg4/uXa8wQV5OUg1jhyBDhhrmwb1g72jQ2zw
         JkTnPwrr3XfoRIRCFKT6UPh11V6FZQse1aCi/NoconEzMHKzDogvEkpIOUYmZOLXXEt9
         u78JeKFh9x4nO7AbVgBFQr5Om5aIU4qzeY2uZVnIbSvyiONpfanRfMkjLRn2/km+CFJZ
         TfGa5Zt3Wqj6vlRBXFMQWU9ay6zd2Lfr4hyHZyu0+GlvA2IhcLntDQS8fwHcG6nVgNO8
         uBVvVuHZtX89lxZkKUAt0NQhqzLW9etmmdJlaJJMh3ZUwPxahpzxX2TWbndYeSLU0neP
         HsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9XosnJ0YUN8ejBUAFunXeZZtgn4wh2tVN1eGiMvblyA=;
        fh=jVIKALAfvGuKUC7P6n5FnxEgR31vhl13Chueu0A8ess=;
        b=JEZnAOrpeSHmwdSqWm7ccy33WOnZGF0+dYeXh72NPzDNlqoPP1922g0uhE/Fg5OZ+/
         Fm7MUKdY1ALKmiEt92iPcsr9ER1U73OBljQ1xxb0lJD2TMA/cFNwLUCpKkZxUOreog/M
         y/cGMIBHOwulqCvM40YWn+Ui/IAt8eUfPGTS2AqQ2MycaTcZxeCf8jDTILJApbmCsnwU
         kCiIkCrmeA/PcFZOBvlQvL1uzWxmAsC5g38zpxUDNOiTjH2Ehof4x0XbDPLr3xIBz45w
         9bqY0XqOoBSuThHrL/RRb5KHe1DDzEe7eZ2LPfsZ4RcI01CUGSbpkvlZ35uGAN3ZHy9T
         qDcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joyfullee-me.20251104.gappssmtp.com; s=20251104; t=1775225481; x=1775830281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XosnJ0YUN8ejBUAFunXeZZtgn4wh2tVN1eGiMvblyA=;
        b=NK88hXH1Ygrx1vKvCdh7xU2Y+1GEFrtXvXFBPSYk9UPFU3RK8GvaufNoSz2z0RMIsX
         KP6YNObykukQcjUPISvkYbUgWGa+LaVjZcdA+lK8G2HD4vpIGvfmItx4YzX7QcuY1Fxc
         ZAeZLoqzq3s6zZ7DNC7MHJanC5vj+hdV7RzBVVp4NG9LNlEEPTYoDjSjSNVnnwqjsqX7
         Y2tzj0Itr+IBVh5/DpoBXHbDBi+V+QKJvekTHjKjJELz2AvMntdVHoZRD2sdtZhHMvkf
         Pn27yqDVWnbUH8XVdxOmWV4Z+rFqqF3v/aB4XRSIUBNbbX6IrclBGb4iawMU8NxANhyS
         iSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775225481; x=1775830281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9XosnJ0YUN8ejBUAFunXeZZtgn4wh2tVN1eGiMvblyA=;
        b=YNZg6MFXmrBGN7ew0m+Rh7n1+XOkp8y58gaWK3aD2WapqHIUgmujLghxugXetco/Q5
         IqH7B6om0/4lwt/0BAFgzwudCe1uronyKxhsE8s8UqX2ATswNHIGV3D7fqzo3qQkN3cQ
         iwhl8RTv3ieAJMr2X3NDviuZ7rwxvZjD4xc0V1VNOYgGSKFw1TWqoGydxuPE19gwPFC1
         oS435w6nqdq/ZcpSp+oCZF59VMxaHx2KZYdsh8fWQduH3upHqLgnBaFKzzIPitvSzfoA
         QjMJuuMbDhGa5Dq+Xzm1uQlgHME0VTRZRADRDoYkF2Vga2LyKzbnf2HVUILW8gO61JCj
         PGfA==
X-Forwarded-Encrypted: i=1; AJvYcCWRfv31WDMtVJyue7Lkr9dUd1W0zs+UZ6iRgvcfcT2zyWocHSWgy7wQ9ogGXVpBkwOBRUovHbwC1EU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6qKJCdROzvYWVv5XIjupNu3nDCJVh39B/HLTLzUPGIuWCsJfT
	W28FlvpDO4Y+FD9NhU4sZQDPaVOAf4jaDkzlW0p0RI+TnBCVVCiW5r2pI/oUVsxN6cFuvMFcaac
	yX6RGbI0MWFlEipiWCKvNXd/NSybQc5lambC/YhO2Qg==
X-Gm-Gg: AeBDieteAaKuKMy3Nmx9df9IMLTUtJcn1oiDzzikcbjbpwFrGa7vZ31YINClhPEVfTY
	AQJ8jK/0mlUjedvv+GKD0Qsid7wiBIBVFq8k9VFovHCeS0McdVk99Z9IlDbTjMrITaBiH6pYsui
	A/ZgP66kp3MekA8ctGVc9kxU8+eW8lz4YGk4KyLZav7cbCIPox4xkSFCNprtlzUDvZEily6bC9y
	9OWsfLCG8M6br5Ozv51BLuQCwFqvCCQj90CTcod4Ndp0oKnDVxmQcNgGrf84uaYEV6o99Zs+bjO
	maWIUQ==
X-Received: by 2002:a17:907:6d05:b0:b98:8e42:95ee with SMTP id
 a640c23a62f3a-b9c67b9e36cmr144796466b.46.1775225480967; Fri, 03 Apr 2026
 07:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADj6jrgK+sRXoNaYH90Rdc8DYEFK2iSF4vkJC=KE4UaZ73y67A@mail.gmail.com>
 <a935b2e3-e11d-47ec-af47-7eb7e86a9dd0@amd.com> <CADj6jrgcuz=Bcp0q7BHVizVeF=C2r_8qXw7r0Mc5X9Vd8uWK-w@mail.gmail.com>
 <4192851c-20d1-4185-9f63-32c66ed2a664@amd.com> <CADj6jrgse2NksUgkHUzTm0332ba4qnV=0QOJAnupS=Lr=5hh4A@mail.gmail.com>
 <4978c9b7-00bf-4562-baae-098bd0d09ba4@amd.com>
In-Reply-To: <4978c9b7-00bf-4562-baae-098bd0d09ba4@amd.com>
From: Joyful Lee <joy@joyfullee.me>
Date: Fri, 3 Apr 2026 10:11:09 -0400
X-Gm-Features: AQROBzBZsF6vCnurIxo_LP4rU-VgtPOhiDWv3gF24onCXf_ue1uebeHL-8ILQ08
Message-ID: <CADj6jrh2AT6vvQqujB5UN5tfcQ-qdDKjV_7fK18zsqkHpFTMzw@mail.gmail.com>
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

On Fri, Apr 3, 2026 at 9:23=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
> To your questions in the original post (again sorry for the original
> knee jerk reaction):

No worries. You are right to be skeptical.

> 1) Yes semantics of how AMD-PMC works are correct for this platform.
> There are lots of other Strix designs that do everything correctly.
> 2) Yes; there are FW dependencies that are design specific.
> 3) There are no quirks for working around this bug you've found right now=
.
>
> I believe this issue you're seeing is likely a platform firmware bug.
> Whether it's AGESA or it's ASUS firmware is unclear right now.
>
> I have not seen this specific symptom you mention on other systems
> (including AMD reference systems) so I am /leaning/ more on ASUS firmware=
.
>
> I notice that the BIOS you have from ASUS is quite old:
>
>  > bios_date| 03/18/2025
>
> Any chance there is a BIOS update available?
> Unfortunately ASUS doesn't always make flashing in Linux easy, but
> hopefully you can find a way to flash the update if one is available.

A firmware issue is what I was afraid of. That 2025 BIOS version 316 is
the latest release for this device. I'll reach out to ASUS to see if
they have an unreleased version they can send me, but I'm not
optimistic. I'm still in the return period so I'm feeling a sense of
urgency to either fix this or move on, but I'd rather try to get it
working because it's a nice little laptop aside from this issue.

Your first idea that the kernel could be racing the firmware prompted me
to try a few timing hacks--really just shots in the dark like inserting
a 2s delay immediately after resume prior to the kernel touching the
devices--but no luck. While I'm waiting for ASUS, I'm happy to try any
other ideas you got.
