Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6244E48033C
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188882; cv=pass; b=de8sAMvR3V+0Xsm2V2VFC57YkoXsIl8idg8uBUyrW67ELvDAJ6I+UtsYMAceYRKiRq5FeSZxNDGQ6JwKn/0NORJZPqsjesa4H7GS5st+mXfnJ5jCfgaVMMNDCILqR0KJYZy4u6OOrXv6IdXynSynMxAfqhpyjxN9okAxdSrRWZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188882; c=relaxed/simple;
	bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJx5MlhHfBSkXLWTKL7ijyMk0UCVz0wXrZhLAdoS5GvW96IM8hwpNRp/yloWdxYYVNxq2ksSQ5daxuGt+MJL5Z2IR5zemuz3IsB6101k31Q39pFxVqT4UJNG91Q+z/fDmxRhMau7OUWxqCDbmtbXL5Z09chLOtDkyhdhoL188P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkzOT8mX; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkzOT8mX"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bda3b4318dso271293eec.1
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 04:08:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779188879; cv=none;
        d=google.com; s=arc-20240605;
        b=S+07F3GJ6uEO4dWiPoGIRPX6kHW37pbLI5NUn3FdIhUIDgq+AhOksI3vxZY+PNfFtL
         vhWIWQU4Liko9EfUPxK772tlLqc+PHZRTmFGH2qIUp43chmqcbR7cKYsJopx9ap3XktG
         Y+tEhNHdPoQIkk0XhQASkRc6CCX/MgfE2N8QKjirZCg7r127g8z0JRDvlP4EZNvPTlSW
         c7PMtZbtUgLDtAGFjpcBxwUCOD3uIwyMEvhY8aWcZkf71omhXX8ZXM1PNi0pB48i5UY9
         JOW7OVNa0ywqpuvozDZSweuTY+vOm8/d8z+LaXXvXkFz6ntbTXCZjhbE+EV+gaSzPGpS
         p6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
        fh=UnPvwrQYew1YBL1qEwKnPfguJQN6rfZ0gHiy+mrm0VA=;
        b=S9VjUEiZMHBPgAw88ZHDMWifutwN6JY6r3GYb268RhbU7vpyaxUMtssxbi4HUtVP1v
         +eodmKDef2bZUO9sUiWhdh2TmZ6xAuRNrMmBC+EDu+5Gyw2E/UTumWwVQei6yXazrii6
         +Q6NW29SLwosOAVWKHUVeCHyajgkPIwNDrku7Fw66eiagQB87acOyKGO5lUMrwmp46BB
         PhpxT8fSolZurkMzdhYYfIedR8FPxrYL1GcjM7+GmqKAgnQy4yNVjfaGgZ1ir96v+bQ4
         X5N9x9Z68n6lifJVXOledOihUqv1jxHXP+Ml6O6LHAFsnggPkx5oqxyCLkxA1jCIluIi
         bfCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779188879; x=1779793679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
        b=NkzOT8mXh6bXhnJvqEtApaE4S4veNhy2u4ev1hghBlqH6x0n92yVBDsJ2dVI/ZJivu
         9A8hpggl+UV+EG+gZ3coLNVauocffm06kPS6Vsilr4oCfGSd+pU0V/7UWBN7MJ69Qwj4
         R1O1gypG77mvtOgIEZmtoiOoxIxx/0pznmMVmWyQ4agGZcSLDIFoxyo9RDUI+MxRlN+5
         IdgW+epOIw+p0gT6dT9gkmNG7DD8Tr7Gq7TAph8w2yFKfIgDr2gJ4ppcyT6UkCIFCNyf
         8Jw0CWqYMJEIAQUcdMZMca1DkDroniAfLQjNSAqdcZYDK/d8nqv1CAJ1GQZJXX93ZFJ9
         eCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188879; x=1779793679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
        b=PocRIRcdtlUh5GAQW56m3yXcv0jXKJ4+JKRArdrRguHoKHDGR8W9s9vlhO9OKmWxEO
         16axsB/3PCciR+RMV4oPe9gdR2rW2h/mHAsX/dNQzoNMPeEPRd2QwnJ4+H6PMFDm3u1X
         8D8zQPZen0SZgp6cvA9vhghn+qcpmiYdTT7OvIyriRcdRgYURlhtt6Kio9+xtHm5UVpb
         6v2GVAUUqXqg62o9DGsWACRB0f6eRb1rFYPG/oal+Xl+5q6iAJFyDaUzLYt75K3LS+mM
         ZPIlt6+Mji6V4oXb/swRAN6epJ07hZc+FcsGUG0XwFae33i8TbLxmCK3dHWllp/grENf
         MLCg==
X-Forwarded-Encrypted: i=1; AFNElJ8Dqh7KuQoI0ldgfg5d5XUvxFDw8OFmPdHHjD48kA6vXoYzZyhcpS59qiEet2yZUZGslFdPdBeZy2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDoyzau7zTTHQKIkWD+B3i8vkM5EI5xqedbc7B6V4xFTbUlZve
	V0xvqB1Tn1UPL0L7UGAEbGylQ1moL9vz21yibqkn84fILFYOQcSlCsASTZkezvwf8qQ/h94eJwQ
	5egh0qG+Sv4gg06+3a9rfDasGIHyI9UI=
X-Gm-Gg: Acq92OFE4HFtpCqYNu1r0U9G+Je9WLIezbWJCdwZpz8YWj+OgECYBr0DahZlnDq4K14
	g5S+JQEneWjm+KHwVUW53YrZqKAIlkg95zYV5J3LRGOMSrCR/G5YsR95saOb8eIJh6oEVXRdQVa
	Bt/HqSqOxnrTUgGaOD0CsOwGESpMF1Aw4lyPlhkBcViozYEv430U63iwhdA6nGUynWod4cRi66O
	G4IT5t/f/mnn6mqxXwQzWim86BH3dEmpHsfwckQxc8FdeJYMAQFLbFaPA2BXrXAXG8LYQbYkCz+
	wOjYol8aRpeW4IFeEqL0dxoU+9XBENK1idm2TU6utM0P4fHSMh+aQmL2SVYa3oyL/1r0yERO8ff
	7slANncWvN2KOMt1Rh5z0EkI=
X-Received: by 2002:a05:7301:6785:b0:2f3:3835:2010 with SMTP id
 5a478bee46e88-3039870650cmr4323491eec.6.1779188879399; Tue, 19 May 2026
 04:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
 <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com> <20260518105735.GW3126523@noisy.programming.kicks-ass.net>
 <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster> <CADkSEUjhq6HSdg4ignzbuJiN5uXATsTdxFbRJ3BMxs5=WUWLDg@mail.gmail.com>
 <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
In-Reply-To: <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 19 May 2026 13:07:46 +0200
X-Gm-Features: AVHnY4KWOiWEY77zuE66kq3xKsBRyVSkUGj1e6jCXaPb6QA3ygej9CY3aqSmM8c
Message-ID: <CANiq72=6oYtHf0Q1NaLXZ+25uQyYbej2xnvUhtgpHyvozhP7_Q@mail.gmail.com>
Subject: Re: [PATCH] nios2: remove the architecture
To: Simon Schuster <schuster.simon@siemens-energy.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Dinh Nguyen <dinguyen@kernel.org>, 
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	workflows@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-iio@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
	linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hu Haowen <2023002089@link.tyut.edu.cn>, Kees Cook <kees@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Dave Penkler <dpenkler@gmail.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof WilczyDski <kwilczynski@kernel.org>, 
	Andreas Oetken <andreas.oetken@siemens-energy.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 12:41=E2=80=AFPM Simon Schuster
<schuster.simon@siemens-energy.com> wrote:
>
> Sure, I'd be glad to do so, but so far I refrained from it as I was a bit
> unsure about the netiquette (can I simply do so by self-proclamation? At
> least the git history seems to suggest so...).

Up to the existing maintainer, in general.

I would also suggest changing the support level to "Supported",
instead of "Maintained" -- that would help justify keeping it in
mainline.

I hope that helps a bit...

Cheers,
Miguel
