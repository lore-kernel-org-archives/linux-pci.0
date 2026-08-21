Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52B3495051
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 13:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787319992; cv=pass; b=Ua5br+e8wzbr56QAerHjE6DrLhWVCq7yyWE79Za2ykTSas4qFF5ft0hqIvnEU+1hgWx3bJh+wt7Vx8nTvGQ9kc2Hnw1J3O4ve9x035R3jv/7tmyGETLGY66ISYb3Bx9JwTcm6hyDeBhyxrQHqEQt6dp40iPXaENL+VZQ51uzaio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787319992; c=relaxed/simple;
	bh=IwrbM0dGxD6XKRAhQH2GAW1ispZsMa7niXHCi9W5sws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3G8p6K+HHn7giw3CKD/MwXzjFYUN3q71hrSffNXwlsAcbV9xiOHg9jYv16w3aqJx+OeRs45W7XpheJBf5PYXl0PTTyhVxbh/D+WE/G72+LB2SlBGfq+Oc53RHmGC3H/2CyOeC1zMpPL+IWGasz9UjN7OB56i+cZsPLYuPt6lIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UdE9X00g; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UdE9X00g"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so8726a12.1
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 06:46:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787319987; cv=none;
        d=google.com; s=arc-20260327;
        b=a8NWSvtHYw6dfGWBqwzGW2p4Jj1aXowsfEorZhZoSQ1JAF+xZf7GEZJkNg/VHo4rkx
         ZYAP66aQS1IwSP6L97148bBQoJuFSTUfrNCjEwn6f+2jL05P5LmR/yH4HgImeUR1tbO5
         T0E4+IODfC/jkIWE9p/9UhNsTpjMeTxynAO/Wm/C6ZTPFH8Omrt6oznFBM6GJE0ilTlt
         HzDS6kcuGtdtLxO3sIREicVe6cLypmUhADfNtXR0AGxATzVIwtRAqM17ShPJPX/ahAAs
         ECvQWhZACNVaStSNew6LbByMH8EbsJd0FBJjqRVreVoQJ14uvMr8WXsZoEmky3sWMpRl
         CIyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IwrbM0dGxD6XKRAhQH2GAW1ispZsMa7niXHCi9W5sws=;
        fh=2E8G5L5HRIhYv0SLHRh0bmuG4bK/RxhrEd6+zC1U6gY=;
        b=Y827Ch51b5v7efvFD0eWFrs6irjze5zjygsGD9x3K9c0FaHQ7+lPCkrYhAHoKjeYTe
         R4qHRRACA429EZb1RllWZ4g9BwlCfedNtYtfulOUh2haiLageR84OOu4w0JXTiVGO2UM
         TEN+jZozldRHhijK+8JNa08oimRW7PEP3ShdAoQ+GYBchvuWOdv/fswmOiQRimuJ4czi
         /Qm7C30rHzmbDxEaShEiH/f9tcfW62xiHJ2MdvJ1uCRCKET/GRAmuIg/vjXE1IFvkULH
         9WgPee+xOJpveQfVmvy0jweQdVm8Uz4p8l9kadcE7Eot7TqjZC8Ef55wYXEg2RdKyzcq
         gJzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787319987; x=1787924787; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IwrbM0dGxD6XKRAhQH2GAW1ispZsMa7niXHCi9W5sws=;
        b=UdE9X00g0b2f6FVedU3Agj5gyyJSe0RTZm27MCerGjy8kF5kVMQfnmiQGT1fxvHu17
         m9Fq5v8wXftZDXnVEFPH1MbxpBC8Dnnny4BEwEOVaV8MinmtXDF4iH7zvaiUuNdProK0
         OANXfO+ztUxNEGpAoYXPgiVWo5P+MRMCYtlnsAQzlG3Zq94j5u6Y2LncIJoNOtkU5Sjo
         jHZg4smw0FWfkexhoWf5Gm/qqx4P1rKo/JjI4VJFbTi/xGIPE66gebap78d4CnsT/rm5
         w10qaQnN6PSUV7NSo9NVEYVNRNeeEB2LqRQXUYM3wOHChk1+yI92k7YHPR+Htonos/GA
         cF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787319987; x=1787924787;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IwrbM0dGxD6XKRAhQH2GAW1ispZsMa7niXHCi9W5sws=;
        b=BwFK575Ac9xuZlUcpzFiis41gpgITqDUNxeYOtz8EhNUweQ2wYTiowWBaLaqxtpcR9
         ifVjVjbLNkA63kzCT2h61QjCGXkz1Liyt9emZDYcgZQWLX+7efHJoAmPiutrobchOCYp
         U6cXpYxzM4HN4hE85giBDozg6qycY+y26+Cz57lUsqpgfxEjRVNjaluJwmZUAyWlKc3k
         yhyXSMiG6mvZhFygteTUMzwAKenpPPdMnx3UK1jgUvZDHV6XJSiDxQYoD8WAL6bOs5oe
         IrFm8Fk9BlMY1j17Yv2AwM034QXZRQoSKBfx1eYjecTvPV6/pbzjBuv5FJ9R91e/7qYI
         r32g==
X-Gm-Message-State: AFuF++mFIdg7e/ilxrFF2B6w9ok+FJYT4DyzUqeakOwBbmc3udgCOZkz
	djTMJIGhu0y+I3Nklg78k7XrUhJu0zYMmPA2MOvjBSd/aOyUCNiuuokTSYW3stpvuAPSFAcRcGU
	gh1ESO3up52Zt7Q5DF49s98aBJ8verVaxAp5RdklEtnNqTzC5kwBR9Euq
X-Gm-Gg: AR+sD12MAO2OfuBSlPJsbmyE15+GcAKp14HS4mo2ygs8wk7xe3GqDcGLo4sHkNrppP7
	lK5JBAR8uIAEkaDUP2PDd+31L3CXOlF10BySAumU8QPQ6aSbkv+J310zj+SACT+IzKKSoXqQAgz
	1Q+P1xVZPrce6MkDUeVEQxT9/dzEa9UhlHoVgKmH+eu874PUEhAjNPMm9N1NCmA5ZpN86oeFSwb
	zNk9xwrF6+k1tw212mLkoiswV+8GzTe4fbm6PeAxZNQHW3Rrmcr6clvLvinBiLVCltbpGBY9PZj
	nTbxKR1ZHCQ8OmUa9i8RI/kVo2H5aGMSBlq+ytxm8JlcOGEvbvq8HpvjT7KCAD/+BYXatYdin8V
	Dk9gAfpKSAZIu4ED6ocHHIaBKn4qgUTfepCjcUGEFuag=
X-Received: by 2002:aa7:d34f:0:b0:6a4:abe:52db with SMTP id
 4fb4d7f45d1cf-6a42f60959cmr58394a12.12.1787319986991; Fri, 21 Aug 2026
 06:46:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821103214.2049218-1-aniketmaurya@google.com> <20260821104537.0A1F41F00A3A@smtp.kernel.org>
In-Reply-To: <20260821104537.0A1F41F00A3A@smtp.kernel.org>
From: "Aniket ." <aniketmaurya@google.com>
Date: Fri, 21 Aug 2026 19:16:14 +0530
X-Gm-Features: AcwNN1X4XAjG5YKpC7qstfzTEz9oZ7e6m-p8_oUMosCM4lbHn5_lekwf5qxL0yM
Message-ID: <CAMmmMt2iymRYnd6iVjSOBGqMu+i=AqJ9g-se44XfNfP1sVB5+A@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Clear L1SS capability when L1 latency is unacceptable
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Because the capability was stripped earlier in pcie_aspm_check_latency(),
> this condition evaluates to false. Will this bypass the hardware cleanup
> routine, leaving stale BIOS configurations active and causing L1 to be
> disabled while L1SS remains enabled in hardware?

Yeah this might lead to inconsistent states between the L1SS hardware
register and the software variable. Fixing this in v2.
