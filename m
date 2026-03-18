Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D7B35F5FD
	for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 06:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773813788; cv=pass; b=cua7OOER2IQmrGiaqw7lrdiDQWM9qu6LHdM1CxGynydL0b0mhCUtxFtlIeb/Rf/ubO1D3VVZlsOL8TuaIAHcEUx1ZVknEvqfRpCi2Ny29AR87UYkKe4ooouVajoXG4aeU6beaGMcnqLJ7/IF/qO8k2wxQTdh6cKZmOk5QpAxkoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773813788; c=relaxed/simple;
	bh=pAszSs/49zboyQgDtEnHp5rVuVO4D9UBOFdQEAPpg4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2PP888PDZG8rSn/pS0FbtX7IMzC5STRsPVpe55eLhwfsS375CUGtqj4B+aqFM+d1wuQdjt0tTpzw0HP3ly+ewlOKIIbA6ERqmV1lWZb19xIbUt73/bTXJlxvKzA1eFd7S7awYXfolN5wGJU9GIiJuw4Mx2fexrDOi0/hhu9F3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YO+h2NyS; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YO+h2NyS"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b05fd1d147so10582385ad.2
        for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 23:03:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773813786; cv=none;
        d=google.com; s=arc-20240605;
        b=aIBBDzLOYrrKkWzJALKCdi0IDmnNi/Jim/H4sYBAPxdufSLgfldJQrMfznyNVJFCkq
         F8pyYTnX3QUQcVTbyUNOpnz0FdOMaxQ1fjRKGDB/9edDHTl2Tg1rSv5rXOFK4bXjGVLM
         5zMNJcyjDCrRede4bAdhUjtTELtaIABVlkrNcuxBDgFpXrz6qPN13A0y+qWbzaIlBGUU
         gA1j0vKfR026ObIlN7T7ZaseHuCmOwD8M2lh69ErTjoo99qh7oEqFI16ePXZkcwfdtm5
         qtV0QQIIp1Zx4WtSEPN3B6Lz+2MCgb9rPFLvwiVpzAuYp01C5fqONW3KGe6em5cHLPAp
         wOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pAszSs/49zboyQgDtEnHp5rVuVO4D9UBOFdQEAPpg4Y=;
        fh=f269WdAdzwlUzSlrtQWaCRIGVJibubUNmkAor0BYr3k=;
        b=FX7zJi3K8gsLVhKvxV2fZx2sHN5k1/hUpGF6iW1J9+rsEZ5oWSb4UVJgp6DIDue8Nm
         T84j8tLqTPBGPVdYf9aqk5yUkcGB/k8qDc/lGkSZhy4/TOKVUgu7c7WwxOeJPFuS97g9
         QwbfzIDqd0LmltzeSki3mXJ+Y6Qbc1IlSM4TMIaXPACmQwFd/MWQPP3mQ/QPsNfbLn+I
         HqMCC7ZDt+Qr7qRlxPc5BZWgjwEeQNMeiSmo3OSCdufoyWTF8HCr1YGjKtl1wv02D0J8
         dm8Y8vBQ4uhed478wAuTdwUJQiwj0ZdamqFIQIl/s5JgDjBHe8f3x4WIsVNpREQrD/Z4
         H4tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773813786; x=1774418586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAszSs/49zboyQgDtEnHp5rVuVO4D9UBOFdQEAPpg4Y=;
        b=YO+h2NyStrF/XisNXSgLUIRSRBGBuTXjlVwSPikgm1/Y1x4vxlNErSBO45iw96F/aF
         pvP7EAGZ8PUwKXYh+hNN/rfOdpQMt6PiBkzrHiwcFZTwzspluXReFwVQKKQcQxyu+zk7
         BGqxHMQkKXZ/Ji5XMi+4Q8wpf2vZndnKvMSUq7FO+Qb8OmpZJR+R03ak7SFmVBd1ShTk
         bpacuSQE0sUaBZ9No0NTYqmtONG2Sx4QemprM4hr37RVFM/+Fiw2Rcz+hP5hMLlFhseQ
         v0tRkcjlhYBU39jObZNpnnuuoJ5vc/3G14XxlkVlsVGB9UnVwFS9vcM4jH4S/I923HFS
         8GPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773813786; x=1774418586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pAszSs/49zboyQgDtEnHp5rVuVO4D9UBOFdQEAPpg4Y=;
        b=q1VSPs/ASApQZplePFWYLYURhWxwcbGDA/ZH/I2N21fv9PxBTcWTH/aiA+Qiorm/m8
         z3cnUZ+TVthhCGGuiTh/Tde0pbI1vTg+S8McTvcasTKGmEv4Ms0kZIgY167svVGEr3Zj
         ST81zcFgR/NAoQB0YTVMhQfhsj2w6/xJJJ6uCruzRt/D9ShuESVHfmBEzPuT/ZofPcXf
         edFdje5ktN4dhrMk2OLhNhqI9brZykDoB52iLFvTJH7dc+6s6rdIGWtYTOv6gcs/dlLC
         2Iq52RhPV7WepuAaX81qxyNzUIzZAac9+Sa73V1jvIbLwgGYMCjzPgAxycQRWB0byCZv
         MpKA==
X-Forwarded-Encrypted: i=1; AJvYcCWXgVPdJ9fkXqDyULW1UU8eNM49Y68NUbCg/54rUuUJuRG2n4BPoYQ0/tsWOobnEWIXCyUKs0cIaGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCtYn0CG9mTXElCxoBiEL+083Ci9SqwzMsLJh1tcDgqBpHvG7e
	j64oiiOuMGINc4Nj12u6uWjAwVnM88FQw4y5w3HS83E2yHe3wfmBAPwqnmnd1JHmXp+QVaYuNDY
	eiug1eSg7pXMy+9x1ZcKqpDXDGNq7F9g=
X-Gm-Gg: ATEYQzyrJDfyw+gWVoaDr27u74L37rZ5ESj2xKd2aJj1975kDrWP5EILsE/L8NWG0mn
	oIgBvjaRKNBjM13OwyTpP0jXBgFHVtHh0wO+TZ3qt1IKxvDoTnQHNUkYfP6KWZKyxImZWrZQhGD
	AX1WpwL1iOkJCvn9ue193hXMyuPlfPuEFcMmYB0/rtIFWYZ0N9kWlIJ6GVvFxN3b7nsdSMOrBoG
	j9ypxSZovy3AqkbIFUHYYRf7VaI/7dcJ+DGdWZqKU8U0ZKAoAzCE1AAbN5TkbKPWaKn6r9jexlk
	wFChcmJtOahP2cMAQ+l5tyzErEBPAmGwBC8uCg==
X-Received: by 2002:a17:903:4b43:b0:2b0:6d2d:f1d7 with SMTP id
 d9443c01a7336-2b06e42bcb5mr23101165ad.48.1773813786487; Tue, 17 Mar 2026
 23:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306143423.19562-16-john.madieu.xa@bp.renesas.com>
 <20260311043831.2576-1-phucduc.bui@gmail.com> <TY6PR01MB17377BF5B5B59022FB39AEA12FF41A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
In-Reply-To: <TY6PR01MB17377BF5B5B59022FB39AEA12FF41A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Wed, 18 Mar 2026 13:02:55 +0700
X-Gm-Features: AaiRm50Lyrt6jaVx-jDOI8ZexNpt-ne3CL_yu9V8PgLR4hVEocE_OODjZBPtK7w
Message-ID: <CAABR9nHZsnsEVcsb08YLaZKL_ofBkKhqGyLSdH65Vh-2we8O2g@mail.gmail.com>
Subject: Re: [PATCH v8 15/15] arm64: dts: renesas: r9a09g047e57-smarc:
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"geert+renesas@glider.be" <geert+renesas@glider.be>, "john.madieu@gmail.com" <john.madieu@gmail.com>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "magnus.damm" <magnus.damm@gmail.com>, 
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi John,

> Thanks for pointing it out. As per Biju's comment, there is a missing
> -hog at the end of node name. Thus, if we keep the schema-friendly node
> name 'pcie-clkreq-n-hog', then 'line-name =3D "pcie_clkreq_n";' can still
> be useful.

Thanks for the clarification, that makes sense.

Regarding the line-name property, I'd like to see what the maintainers thin=
k
about this direction. I also noticed that the usage of line-name across exi=
sting
Renesas DTS files are somewhat inconsistent. If the maintainer approves you=
r
suggested approach, I will follow it and include the line-name in my next p=
atch.

By the way, are you the author of the renowned books such as "Linux Device
Driver Development" and "Mastering Linux Device Driver Development"?

Best Regards,
Phuc

On Wed, Mar 18, 2026 at 6:31=E2=80=AFAM John Madieu
<john.madieu.xa@bp.renesas.com> wrote:
>
> Hi Phuc,
>
> Thanks for the feedback.
>
> > -----Original Message-----
> > From: phucduc.bui@gmail.com <phucduc.bui@gmail.com>
> > Sent: Wednesday, March 11, 2026 5:39 AM
> > To: John Madieu <john.madieu.xa@bp.renesas.com>
> > Subject: Re: [PATCH v8 15/15] arm64: dts: renesas: r9a09g047e57-smarc:
> >
> > [You don't often get email from phucduc.bui@gmail.com. Learn why this i=
s
> > important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > I noticed that for gpio-hog nodes, the kernel already uses the node nam=
e
> > as the default label in /sys/kernel/debug/gpio if line-name is missing.
> > Since the node name here is already pcie-clkreq-n, the line-name proper=
ty
> > seems redundant. Should we remove it to keep the DTS more concise?
> >
>
> Thanks for pointing it out. As per Biju's comment, there is a missing
> -hog at the end of node name. Thus, if we keep the schema-friendly node
> name 'pcie-clkreq-n-hog', then 'line-name =3D "pcie_clkreq_n";' can still
> be useful.
>
> Regards,
> John
>
>
> > Best regards,
> > Phuc
