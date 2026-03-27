Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3995D3F0755
	for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620337; cv=none; b=g9Ow2WtSRnLbYjM7U+9G4BXo/dzvhJ9p/hxMfLEaLgQ0OzdB22Q0NkrXuScfdwjfGFBVHqDytoc9N4ZmLT9c5xWYgN3q4AADQe126g20JazEj9Ps1KoeiVhpz/HuhQ0Zx8fd7RAHkcxQhs0h4//FKwojK4KcqC/p9CVh1cgio5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620337; c=relaxed/simple;
	bh=uKIIBr/l94+O03R42gomjeawYPqIKEUMDu6Dlg1V39Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K5tQt+ujnw5Am/WjSto8owpqD/W7lqTARBIAiXrlveSwKsk60Fwq1wnTKzNaZGJUDC14CJqnoMPJkKXOX7LY1OpaqHaY4ELJFeh2FmztZEvZAxw8HTh2gjryxJWrWcorOCCpZiu93/MTHLqhuodE+my72HvDrmLhJklMlelau3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=HJMuViLO; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="HJMuViLO"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so2086027a91.1
        for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 07:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1774620333; x=1775225133; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uKIIBr/l94+O03R42gomjeawYPqIKEUMDu6Dlg1V39Y=;
        b=HJMuViLOioNkTbklSR87ujf94X07fuJK8EQRjWu5H7tcaPY4gBDXkGyEa34emaTkV2
         de9Eq+6i01m415R0QujGVvTDAAyJUwu1sPHZ5Sx4qsDTfmMfFhmP19UWD0ovF5+fQ/Qs
         zBnTa/X306hNHPDxS1b/UIqllu4nYpUMRjx24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774620333; x=1775225133;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uKIIBr/l94+O03R42gomjeawYPqIKEUMDu6Dlg1V39Y=;
        b=K2YosIhK3VblIM5NC3wSwSQ8VzNPF6cJ3X5rH1+nTCk5ZChFLfB3O76RpJe/qgtz8C
         BPwNYesxAR79yl2/k66quQPzPV/lBwlJN8IiM7y15KzcTvZm00TcCWFcniYQ2Jmuz6B4
         4onvGtBFz7dbOe+NvFoFHtoTv3aroSUsF3DPssqh9YZP0FLlqjdMIVurRHPoBroeH0fJ
         aZqQeS0irDOd+akTyJQCrFJQkJgeXCvfPbOfRzj/M7aSRi1riHkMf/7giK8266lLaqL0
         58gPj+arbhvHXbVFhnwGipKdsV9QqiUnSylWhfOk0xhTfrz7XP0m6AKHPFNagsDfGTGy
         cGpA==
X-Gm-Message-State: AOJu0YzZ97T+Wo1t+dDwmYYKpyBxEB2wJMTslQApBqDsiWuGUS1EjC3p
	amOUM/gJHto3WgZHvvp+MCavEYAPzE5O1vm3e2cWWPyJzTrv5JXcdOYsdq0mno/mX+2qeMSe067
	BqVxxPQ==
X-Gm-Gg: ATEYQzxXN3kQawqs1EaVAityvCuVa4pzFzzNoi5DszMpTo9gX2KJ2TduDaU2kV6Y4ky
	V0c/PLkkIIurr+4bzreh812qRg0F/th6jhngR/XGIPOBCmfTmNbqa//g4BHtqzv5mg8NrYBoF6t
	WmZm7iqmlj0Er2NYjCQG/fcLGwfY70gZb/kaZMqW1bfPK8FhEOma+YODMQSo0LjHRx5tvNwG3kj
	Nawi2MbrMvWOtv70PWULmnbDgE3LYkYmyTOq7OP5uMwSK/ZSTPqH2bmbPYEkiDR+TL8Sv3sodX5
	MUr+rU9b6R1VQdrRByCX2EE3O4I/EDZtUIXbt5+o7RyHT2owGpK8KVOhBW7NWgDdd6BuaaKa+ty
	1N4FdB8wjwQZx1fKhO7rD2ZfcCI5+8XeDIC6KaTV01Xnfj/CQqPBPzOTggmdE1CDdKLRrsFakGQ
	w2oPqRWRmUMCIqynEGvmmTKhg=
X-Received: by 2002:a05:620a:1726:b0:8cd:c011:dfc1 with SMTP id af79cd13be357-8d01c5bdfd7mr308360885a.5.1774620014914;
        Fri, 27 Mar 2026 07:00:14 -0700 (PDT)
Received: from [192.168.153.215] ([73.29.38.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e52cb49sm509097085a.43.2026.03.27.07.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 07:00:14 -0700 (PDT)
Message-ID: <c58cdee387a6cf10b1bfbed2fe2e817281eb1689.camel@ieee.org>
Subject: Re: ReBAR over Thunderbolt
From: Cristian Cocos <cristi@ieee.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 27 Mar 2026 10:00:13 -0400
In-Reply-To: <9cfa81e1-373c-cfdf-89a1-5d7c169f3577@linux.intel.com>
References: <a177e7cf1e638c874a7b2e9e68027094bca68041.camel@ieee.org>
	 <9cfa81e1-373c-cfdf-89a1-5d7c169f3577@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-27 at 12:15 +0200, Ilpo J=C3=A4rvinen wrote:
>=20
> You haven't indicated what kernel you run nor provided any logs, but
> there=20
> have been some improvements to this in general in the recent kernels.

Archlinux, current kernel 6.19.9. Will provide logs in a subsequent
post. (FWIW, I am a Clear Linux refugee.)

> And=20
> then there's also this patch which relates to thunderbolt cases
> (which was=20
> only accepted yesterday):
>=20
> https://lore.kernel.org/linux-pci/20260219153951.68869-1-
> ilpo.jarvinen@linux.intel.com
>
> That's being worked on. But it's not as easy as you depict it as
> kernel=20
> needs to be also able to fallback to some intermediate size if the
> largest=20
> supported size fails.
>=20
> We don't consider it unimportant usecase. It's just the resource
> fitting=20
> and assignment algorithm is very complex and hard to improve, because
> something usually breaks when trying to improve it. Thus, the
> progress is=20
> slow and everything has to be done carefully (when things break badly
> in=20
> this area, system doesn't even come up so there's not much room for=20
> error).

Thank you! I am encouraged to see that this area is under heavy
development,=C2=A0and this is pretty much all I wanted to achieve by postin=
g
here. I was, again, not aware that ReBAR-over-Thunderbolt is even being
investigated, and realizing now that this is actively looked at does
indeed put my mind at ease.

As I said above, I will post logs of my system's behavior in this
regard in a subsequent post in this thread, which I am hoping you will
find useful. I will not, unfortunately, be able to test kernels that
have not yet found their way among Archlinux's Core kernel releases,
but you can count on my input regarding those kernels that have been
released by the Arch devs.
