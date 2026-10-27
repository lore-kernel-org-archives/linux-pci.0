Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.217.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793114549;
	b=O0Am6yEnr2dSjtk15CCDGMBUGyJUND4/tbeAUtBiHRxfNL5AgVW6aFwctzZFe+3IGru/
	 mKa1d0hkDshmTK4DjaLlvDz410Z9z5AYp4bMX5VZM9Es5pg63a4ouHqqEnmlnameFszNP
	 HVl/dirtLJwj6jGUFuMlMr8Utpq3sYwyRhfoLCcfnsbS5UWqo6W+pPabQRysI/R3f3Cbz
	 Z0a3RfpSINo7Gwl/yxBHhLaMiiyX41UpiANzR28mNHeb/OPyUh6dt4lE6rGBiVmweN7RG
	 Sz7YJYTAowZlZK/R4fKLEydk5HD5IwxFt4d13xt9xPVZ07GqJ2UMBtoN9rNYHkUcbpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0gy1GbYoTDZfjLk4adPcTo+vL8RJLAqdM+FNRZN+GPw=;
	b=GTAfhn+dIbgMd1ykBEns6ZLl/QqFLuUu2sh/PUf3Gml833SVbKs23RFc3VU5jqZvlRpf
	 BGW6m8VzEqMRKUyu4yDShNZboCi+kW6m4BawEjHdjrXD0YVO01yIQyZDWaDfOuxi79kzg
	 k05PA3knxXuDF32gOt3tforY+jGyXAWlWPXwc/NT17k/zI87cTfD4umyeho/g6dlhjq6+
	 kJZzrCWF6Tp+2UU0UDIUrPGHlGm9VnOsR3fugkPRsK0roTVAc2NqxFEHHFu02J0WRmej3
	 mgnyYN3JNkgTl5vpLAYyqYCbG5G1Nsbv66xvX5NmX5hCs7L5U1qxnF2qQbjtmkAQdtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rSdHnOiB;
	arc=fail smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CE1606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 15:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84CE1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rSdHnOiB
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7cc30120465so184151137.1
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 08:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793114548; cv=none;
        d=google.com; s=arc-20260327;
        b=NupqlOezNWQXuxK3jyPtEsdNbN+JkCwuQBmSqljWyASdcnMdXCYYwfoD7CQEgjkQa+
         LubLF2ZbyMcYjN8SQgsRoaOZ/ig7qHssK2D6WqqhXFBukHT48a+Fm8m7ZaqZ69CZzLKJ
         l9x7g8YsbtxC0D1Nkc8GaSFZe3zublzGN6oLWK+byUs2WO8qS9tp+x7WqNJfrdJ31W61
         oxBY+mynIqOoPJdyZ4BGR2ZpBRcoTYfaw9XGw8laYuoObfIUdY3MM2JezTGDCrfBmGS4
         DwKgZHlcIiOQYyU2ii97E4EI5E1isE3sc0d7a+XAZS0QzXyBxhBp79ucYCvIdB0uyHG+
         f7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0gy1GbYoTDZfjLk4adPcTo+vL8RJLAqdM+FNRZN+GPw=;
        fh=/E5eqPQ8rAqmuAq5WMrfmxqp7fS9HwfLI7f8ZZBkLL0=;
        b=SCGR2OJiub4r4c9K6Gh2q49VjtR79vBC0hadT8ilXT6IbZIBLugXgFxbZfWGCpUs09
         FNsF5d7jlrHJ5EVEmogSlN5Iqayol8LLbW8Z51OdD3ODIT5hJVfa6uhtwyVW58sBXNBA
         EuBsZHWDR8kutQCVoAuuTJNc24I61IyKqzwM6tz8RhYi5eWF6rXh2B8VldJlwgYkdXWa
         5a1x4ryeUWdtPGjQoBFXHtDOFae/pG5NzevNcFcPefYCznOfhpgam4vMRpSId+esGweV
         CrBhB9spS/cFaPDGf2gr6QEBi4D8/bUfhe0HqQfW9zUMdNMFWPHSRqp9kuoTdPIxHBTt
         x2og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793114548; x=1793719348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0gy1GbYoTDZfjLk4adPcTo+vL8RJLAqdM+FNRZN+GPw=;
        b=rSdHnOiBHVDYoVQv5OsAPIJexs9GauRvr0qVYof54fNCMwrl2UeCsib7ZA3sPyHzg7
         EUmx2RJjAbgsE7vXgiJhaOeAN8ixi10oX9AR609nY7NabtRAsHdKeis97W1Pwf1YPgzi
         5tX3vTUeOHHd2H2V2LkSbI6f2HrGpB2I6Nz6V0T2nOgmMjzr8H4zdbr4FyI3Y5FdGSFY
         60h6IyWEhdSrI79pmztL47iXi7Bwyeqxp1Jxpoa/DTyRSO+JsTWk36Lg0C5INS1td/5r
         Sh/M9+SFnW/UAHqQXXcd58WcS634RkaxyeXMAFAlMKlEiHV+cEWctVBs+lZ/tbx0Qnao
         4nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793114548; x=1793719348;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0gy1GbYoTDZfjLk4adPcTo+vL8RJLAqdM+FNRZN+GPw=;
        b=NBdwOGPQXjwKWO/o7QdmSPv9HBSUdvyYQ+c/o/nTtqcQD/CjCJjOXBO+BdOCxJ0N71
         b+ETFMO+90Cj6gNifDePd6bYw70+uxatmF3mwqIBx06yfyZOd8ObCBL6g2UWrPj83bwZ
         JhQOaBO4eIdQdTuZFiV1UQHE9u04PCWJaQwLCsxIVBkUtuSpPwU6Jk8UpYnXM+/Xtn5F
         rUcVcfAaeCicN9m2uzL3j5SjF7KhaV4pa3UiWkcA3brahURhA8XKztwAHVHk0FMO3pGF
         2VQrpyi4t+S5mwL6ufc5oEplSdTAK7zGAp2NenoK2PSymhvbSR/uz9l4bGGx/MHoVvFM
         8v3Q==
X-Forwarded-Encrypted: i=1; AKwUvBw4PNKJnobAmR5XFLFiEnpJxG8PkqHEZ791q93DbqKRF3Wugq2u7ZhYC7VKQ7pxfcqDq4ihGsa/VpU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrxR68qHbebL6FssRDVTJG5DoEn+79Xod1kHrfF3qu62AVoKDn
	81bx63OJLdyKyLXWIJZp++dvZHMK6AiaIGRugykbe9lgaLEA1bsw4b4qg8nSMys/KQeEgf8s0Ck
	7g7nhzmUe6JG1XCrlJBtjy2F6TkftqS8=
X-Gm-Gg: AYBFou29imsfbIKRXotRFANmZh5GpoAuBOUN8NRZ1Nm/UfLX8MYkh/UC/niA2JnK1Ux
	UUPeUbTpddTd2WsmLHZt3wgdwN5tefkE46tKsp5l8qLgfqODzqsvc9dIF3qeWnZhELfvQmUu5He
	iYpy/fDHY8WTw4NeO6Bnd2DbyP7qflSB9ZPF1DD/p8ZWWB8yekurx2QNPseBP4a/txmNvyzEMIQ
	NnlLJ8tn98CzLu1d0w1i3JqPO/XgPefSFcs1Fk7w41LOAWadPO7Q/MHeGg6SlezugyNllYLvgqu
	+3k0+/jdy0jcSQgRIXfysajOMAyp9bNSmV+BdvfzaIc+gVyECbSqVa1rfg6wj3wwbPF4FuI70to
	PyqYdA88EoKhQ0YjkpUZUL9khQrDr4z8HC1D/S1ZiMITDy3W1TeKTyA3amJHC1j+VXRNzTaMMCo
	sWi4G4VlHe3NYOgUDcjuzQB9I=
X-Received: by 2002:a05:6102:3250:10b0:7cc:174b:f7ca with SMTP id
 ada2fe7eead31-7ce5c6ba0dfmr4003174137.0.1793114548478; Tue, 27 Oct 2026
 08:22:28 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CADnq5_O2tEUHOcbiKL8c4UHpy3AmOWtmM7A8o3jP2qLwkx2jUQ@mail.gmail.com>
 <20261027082913.8002-1-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20261027082913.8002-1-atharvatiwarilinuxdev@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Oct 2026 11:22:15 -0400
X-Gm-Features: AclHuK-Adz3pXhRznVuw9H0EI3Am4aff3rHKztB_BB4zRj3ojyCoORRQiP8JW0I
Message-ID: <CADnq5_PYSbB-Ges6vVgNcR4ZjYH4TxLZeAShifdV9uuH8swQzA@mail.gmail.com>
Subject: Re: [PATCH 10/13] drm/amdgpu: Catch register access while GMUX keeps
 the GPU off
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: airlied@gmail.com, alexander.deucher@amd.com, 
	amd-gfx@lists.freedesktop.org, bhelgaas@google.com, bp@alien8.de, 
	christian.koenig@amd.com, dave.hansen@linux.intel.com, dev@deq.rocks, 
	dri-devel@lists.freedesktop.org, hansg@kernel.org, harry.wentland@amd.com, 
	hpa@zytor.com, ilpo.jarvinen@linux.intel.com, kenneth.feng@amd.com, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, mingo@redhat.com, 
	platform-driver-x86@vger.kernel.org, simona@ffwll.ch, siqueira@igalia.com, 
	sunpeng.li@amd.com, tglx@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 4:29=E2=80=AFAM Atharva Tiwari
<atharvatiwarilinuxdev@gmail.com> wrote:
>
> > You can drop this.  Nothing about this is GMUX specific.
>
> I agree, but there needs to be another variable. Using pm_runtime_suspend=
ed
> or using any other pm function will not work, as amdgpu_pmops_runtime_res=
ume
> also requires hardware access and even though hardware is accessable by t=
hen
> pm core will show that its runtime suspended.
>

I guess the runpm code doesn't update the status until after
resume/suspend?  If so, call it something like runpm_active.

Alex
