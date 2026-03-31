Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846403A5437
	for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774987873; cv=none; b=iaJTjZbCPbPp0qsteAz7D5b0JWp5b/R0QZMoFszFM1FRA54wucdgGtu01lJCoZCGHSk+GDH8gFg0iklLG4v5J7c8AqNHgqalH+E9Shsc2zJueZIpy/ZFddTu4smmMGkniA+GEariMJdSZi8xuAw6N5PqSxx3G0MbBpdxWKR/GKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774987873; c=relaxed/simple;
	bh=qUqfU/0eeHsvuGrbuVEKnt0OsC87ViXJjPXnxGmC2To=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rC+MKoTgpCaySqPA3Xa2QXfDfeRlovx1fOaf263FD4xQVi2Rv2A+ySLeDBwE0BWnauKZVvoqLxDOgXV2YK8dkC2CGOJSR6i4zTxYz6B5tWhktDjkOiUE+GdnkPz5LkgPPqPQUjuKK+31nNKKQGXsN8N1ydrIWIyJkBks0aO88pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=fTw2Lgbk; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="fTw2Lgbk"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89f68634786so41697106d6.1
        for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 13:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1774987869; x=1775592669; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qUqfU/0eeHsvuGrbuVEKnt0OsC87ViXJjPXnxGmC2To=;
        b=fTw2LgbkNuMq3lVU42Z5MACSfjrtKiDxEMC2U0ziEhL5JJM05mELXJplCgvNl7gOJu
         h6WiXCnvTwR9UG1UnbcrW4U2J33/3dfHbRqYD0nU53FDr6/soKrnJHmHQ9oCR8H4L8yW
         zhHTOgrQhpEYjVrdtwQpbgEIEUZy+/xKGmEvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774987869; x=1775592669;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUqfU/0eeHsvuGrbuVEKnt0OsC87ViXJjPXnxGmC2To=;
        b=tDrc3ABeGM1N/ukOXYEJ5vCnCksQKX2kMpi5jYL3ornygb4VMquHPA5ebEuc/BkWAv
         P1yveYPbPhA5qKoNK+XFhSyYxKwWrdFr0+IFsi2yhGW6dCZMweLtX9UyLMVCftU2GrhV
         /NdoDwBrIwjLjz7hALl/MeA639y7nyOUo9OkehtPhLRlZBPBVfefwUT14aBDSYxHVFMk
         46ppaHqwDI5Q994vBpdMzEl6kDz7vAyWbVSvmgJoYERdMYdYZX4upM1EYN4GjTl16V/e
         WoH9kYZ91rNUPjbUQvTkFjijCMkattWf1sH2p+mpF+8wI1eT6/pz5dN5DB0mr3lluxll
         7DeA==
X-Gm-Message-State: AOJu0Ywj20ayP7BQpkRYsAWyuq0wr/U6fg/G30kEf4sMv7r6rYqAbybf
	9h9EXwbFaHs73CjyarxRGh1W5AML46rI7s0eroVNdNc5is9XF25VxCT0nfEOT1LZa5yKEwj4840
	KGw+taQ==
X-Gm-Gg: ATEYQzwG6QuGW63i5AAAjdikyxv0TiCmom/8hLPdnaRVF7PQWIgcAwfwI/QeZ/4IBhA
	TOQS1CAQNlbRGOUMgTk9Dfmi2pd24xftj7tA14HxTpnM+c6OOl44/z1+LxM2rrhZYOSbKbEBiU0
	xv5ADXi3ajfnAp0565P7Ht9uFjH7f2f2skRDSXVjuxECmJwTDDeFCzUUed+T1aksZBz5eIb35/T
	Om2MfNnQ2tv/0SVY2xNOnjyRoM1WQN1x5VqzmFdYVzoEQLBJkwwKKkHsczcXyH2yEcxrr199uR+
	Adqs3IVxTkTf7cMGLVnXhnFPSTpwcSwsJcJj3RGCZBHFd9QNM/ElsP0JR6FBsZQNsagCJNNMd2R
	PpKiUTUxRSYp1rfm2t22BP20xb71kj9SKJ2vC4zrUWVfoyDzJEL8qg/asP6x4tfa8xVxPrhBEhd
	MGP7LLZxFki3WO+KjXowODiyKsVXZSngFc1A==
X-Received: by 2002:ad4:5ba3:0:b0:89c:4914:e970 with SMTP id 6a1803df08f44-8a4394ab0acmr14157726d6.36.1774987869266;
        Tue, 31 Mar 2026 13:11:09 -0700 (PDT)
Received: from [192.168.153.215] ([73.29.38.247])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89f3b6a3c6asm90876846d6.26.2026.03.31.13.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 13:11:07 -0700 (PDT)
Message-ID: <cee12f402b93927a61c4587e11a9144f32ab1b19.camel@ieee.org>
Subject: Re: ReBAR over Thunderbolt
From: Cristian Cocos <cristi@ieee.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Date: Tue, 31 Mar 2026 16:11:07 -0400
In-Reply-To: <1b2f8cf5-777f-87b6-2829-50a6532e36df@linux.intel.com>
References: <a177e7cf1e638c874a7b2e9e68027094bca68041.camel@ieee.org>
	   <9cfa81e1-373c-cfdf-89a1-5d7c169f3577@linux.intel.com>
	  <46877507be26e594e42ccf8aa9daaac2656dbd1d.camel@ieee.org>
	  <2f6838fa-dd7f-848d-4788-8b04a23b5753@linux.intel.com>
	 <c0b1932ca75fc5eebb3aad97b76f88a9607875e3.camel@ieee.org>
	 <1b2f8cf5-777f-87b6-2829-50a6532e36df@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-30 at 18:33 +0300, Ilpo J=C3=A4rvinen wrote:
> I am already looking into resizable BAR aware resource fitting,
> hopefully we'll get there in this year. However, it's a very complex
> change due to fallbacks that have to be put into place and has
> various prerequisites that I've been slowly upstreaming (and fixing
> the issues they've caused).
>=20
> I've also considered not assigning bridge windows that do not have
> any real resources underneath them (but still consider them in the
> sizing decisions). It's not trivial to realize though, the assignment
> logic heavily depends on those placeholders resources to satisfy
> alignment constraints (so I've been thinking of walking through the
> assigned resources post-assignment algorithm and releasing to empty
> windows at that point to avoid violating the alignment constraints
> without extra state tracking logic).

Thank you, looking forward to witnessing this progress, hopefully
sooner rather than later. For the moment, I have designed a udev rule
and a systemd service that does this re-sizing upon hotplugging the
egpu, so I could say that I am set for now. It would, nevertheless, be
great if you could keep us posted (ideally on this thread) about major
breakthroughs in this regard, just so we can do some testing on our
own.

Finally, here's a wild thought: I am curious as=C2=A0to how Windows(!)
people solved this ReBAR-over-Thunderbolt-hotplug conundrum (have
they?). I am not aware of many complaints coming from Windows users
when it comes to ReBAR-over-Thunderbolt, even though, to be honest, I
lost touch with the Windows world a while ago.

C
