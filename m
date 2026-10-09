Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C878626FA4B
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564678; cv=pass; b=JA30fgJCVvX6rO8Xre/Dy7jq5sZJ+vEiNsygjgskwX/9r2xeQsGLXd8E+1X8zwcXf0skgquJkJZDqKEoUxx5K4QRDnsvw57aQZiKMv0zn32uSokv51UmxT9vz2QCMoLUDDlEYRZBNlaXWoycBgRZM7PY+Keu6HkHePRIprxVsx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564678; c=relaxed/simple;
	bh=78cHai7ihd4+p39lusAWTnI9XfTfcoKEciRQ26SEZkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUiDUwUcVvm5OyRpwfRb+V19BxuFMJeu8lIkkX6cSOwnKQvImfeqSKZUV7K4aAPYSIWpBPPKnznLfNNC0A/1jROSERYo7bwsHRjh+rEpySON9RMvbwmpqCAHqbvRxx9vrCqXNYErNwpbpU172ThYTu+LL+vFbCj8dE3T0puQ/Yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYwv56ZJ; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYwv56ZJ"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2533d83e3bso7788366b.2
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2026 09:51:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791564675; cv=none;
        d=google.com; s=arc-20260327;
        b=UwBayG6c9i6OwOBjfndeVrgmSsfZMiNy0te4qIxXIFspNfIhNq37JjHXKn0qgiVC0y
         oEACQbRJFEAT6FKTakRzetn+o1FHJcs1vl/sQ+XMMvUvHlc+WZ2Odo6f3H+C4UTSeWrE
         MRSp5DnEEAJ3SYnGSz+cfhMfidtFZgWKp7i14CdjTcuS6MJrtrSP4zPEfq9WNp3b6iSd
         PVtmeWcfVmBHZpO5oADxHk2m2VGLyR9bW566+e8X1MctNyffnafNlti9O5AOltsIRTZZ
         048D6skWAdYEFw1/c+6xunQObq94gGdmekOLWyQZhN3BYeJHnsTM1pijEXiwB2QBNVfj
         MmLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n+8Tekpu+Ng6nSgWyCgi0KryBmJKh+vqeWpWiW1vi4I=;
        fh=eL94wBLYntKgQFsA5pno7hluVS6PTFsGpNYco6wz2B4=;
        b=FeKWvpXqAGn5nMdE7xsWqBwDd/ionDRLxHRhdvkJtbjl0d5g8wNqupzzlIHydvOAMh
         AMld8tD/RI20sIlyFOLjgGmtTIu35avvviDKO/+wW4TCplKHRVyMGTnxRdmB4GfUpH1c
         2U2X5xfuFMlSBeLj48tuqG7vsU18iHhEeo44bA6HtFhs/Fdl3noE/nbE/bvS9lhjERza
         TTa+LX/zIx39YDoU7aZkxiIy2jmfMfvDJLH3PorG80kF/8tWKWc/L+MsO+Y88TVryC/O
         GdL1YG9mIC55SMesD65CN8m6CeTuRXOEnQCVmr2F2h+0FbTwoHcLq7F479LAlNMiF8aJ
         fsTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791564675; x=1792169475; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n+8Tekpu+Ng6nSgWyCgi0KryBmJKh+vqeWpWiW1vi4I=;
        b=hYwv56ZJ9juZsW/WSLDaZdDAofbl8HpKcttt+YDG9jcJt87us6XqS7YsC/pwQQsKfX
         dfWpv+LmKFRr1qC1KJRvfCH2apjh5X9FdGKuu+YRtFHy6/WpjkMcWUVaz/ZJkMG2kgHy
         aqTDFzvOBou6HmD98fJXN4FCyyxqkPJ9dgOjtPypRv5UFR7H4LkyWWoKKAqldX3mmgZw
         n/K6/jCNIf9IFJjeUfnJnO2NhMLdUOT4FYCrcy8DRW3SV1pgs9nmzr3FNSMTfYb8iHck
         mbKmXO7Ve+zI5vNq1+omvDmkHRYRELMKDWLsQ97XgXFPCtohEdVWM5Mk0Hkj0zSBdKYm
         yc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791564675; x=1792169475;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n+8Tekpu+Ng6nSgWyCgi0KryBmJKh+vqeWpWiW1vi4I=;
        b=OQ6Hhi7nuElaqt85v3Gh1A6muxy5Yz4z7tkgZJfcibgexRtSKglz8C4365BmhiwXNm
         H8AijNsuVmu5IN2hKUR/GOlkBsF46wmN1hxSRBLWhhLK4Lp8YD+IqoEnKWaO6VLCjaAr
         AD6/lHx3fX/lHje5qfwuK3KoA4VVzh7/GU2mCEL8Ibnp4Aa6IAZH3spj5rqgZFkEf0dG
         gk7asktObP3/oQudFos+6rvJoUyjF2XRkX0AgtDAQdBwiOYkf5c+gbbcPSTOCWhhRiGt
         c4H+QAPGaPFWRq20bhxwjXvnxWKjD0d5Fwyxz74gCF/guycY9hPgOqGepzH8R5VeIZWK
         pd3A==
X-Forwarded-Encrypted: i=1; AKwUvByQbEI2WZ9eP114QPIoznwNhDxy8W485I8hOcOBhBwDh9Vh0mQg6qJEDTXinHXN9ZKXVI2oI+OQdtU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhBQgWHTseakJuqS5He6gRwJIieA4Ebet5nGWTTWHM9tVULjbW
	UP8tge8VKMGikM3xcS57I62VoKrVkO8ceAXTvJaPgqwrqLuzG4BbNScThSQKcS/yFgRHgHFffgZ
	sWUdJmF6Ajbn9UoIXws+eb2CT7PbwMKQ=
X-Gm-Gg: AYBFou1tPJwnd3KAe/mILXPkKnBbnOOt3NKEXrMdjgrhllJQeX3jcakhODj5lhhMCpl
	Xr2Ozo0E84th9P+QBpHbKMf4/ww99Uv9Uq+zRQOMkglCvC0uxJTxTdG2OilckIMeDUPPNiOI8u9
	+TXKkRLxzY4huGWtBVZlfCPQ4QMSoIbMmREhF2BD4d1Uv+N59YMnoVZ7xdF6U9IZ4jIZush5+qv
	SRL8gp+q0ddZ9VdG5w1u4S2PsTLDaaA3YshBo5Jtg477YC7JD7+4389a7g+xggFgZwooWxU6TNJ
	fSmtI9TUeR4GHeNRELr2dwnCwfdiA0duT61Dm7yPNUE0bQMSuJoZI6y0J7I8uHgBmdkcAIr7aQi
	H05MsWiGoZXjp6H28l4SmwHt2cAh5rmlJNscNjAnthT1X9gjb7CxKR8qMtAHx8Osmq+EHUnzkBJ
	XNN0EBdRKh0A3D16HiOFTH
X-Received: by 2002:a17:907:7b8a:b0:c2e:855:3375 with SMTP id
 a640c23a62f3a-c31aa05d48dmr267328266b.30.1791564674847; Fri, 09 Oct 2026
 09:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009161832.GA980777@bhelgaas>
In-Reply-To: <20261009161832.GA980777@bhelgaas>
From: "Perlow, Jason" <jperlow@gmail.com>
Date: Fri, 9 Oct 2026 12:51:03 -0400
X-Gm-Features: AclHuK-7AfAFQYv2cTll8HDVHIrz5FK0KVf6exm9S66osr63JbCL-_swxrWvd6k
Message-ID: <CABZrw2EnZzKCdJc2oCtm14YuDndpj=uAV+MRCmYEfimy_Zv5jg@mail.gmail.com>
Subject: Re: [GIT PULL] PCI fixes for v7.3
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Alex Deucher <alexander.deucher@amd.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver OHalloran <oohall@gmail.com>, Christian Koenig <christian.koenig@amd.com>, 
	Vitaly Prosyak <vitaly.prosyak@amd.com>, amd-gfx@lists.freedesktop.org, 
	Aditya Garg <aditya.garg@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am now producing a draft quirk that uses the known device IDs and
models for you. Will post shortly.


On Fri, Oct 9, 2026 at 12:18=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b9=
35:
>
>   Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.3=
-fixes-4
>
> for you to fetch changes up to 79c168e2aa957ed0054c93db17caba653b95e377:
>
>   PCI/AER: Skip error recovery on false alarms (2026-10-08 14:33:04 -0500=
)
>
> This fixes some GPU initialization regressions caused by eddba19b8b5f
> ("PCI/AER: Support Advisory Non-Fatal Errors"), which appeared in v7.3-rc=
1.
> That commit also caused a MacBookPro16,1 spontaneous power-off regression=
;
> I expect a fix for that next week.
>
> ----------------------------------------------------------------
>
>   - Skip error recovery if no unmasked errors were signaled, which fixes
>     GPU initialization regressions caused by new Advisory Non-Fatal Error
>     support (Lukas Wunner)
>
> ----------------------------------------------------------------
> Lukas Wunner (1):
>       PCI/AER: Skip error recovery on false alarms
>
>  drivers/pci/pcie/aer.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)



--=20
Jason Perlow | Argonaut Media Communications

Voice/Text  (954) 242-3484 | jperlow@gmail.com | Blog: techbroiler.net
Read my Tech and Food Industry articles: https://linktr.ee/jperlow
Bluesky: https://bsky.app/profile/jperlow.bsky.social

Need to schedule a meeting with me? https://bit.ly/3y8P3Gp
