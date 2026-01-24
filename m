Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A917A2FA
	for <linux-pci@vger.kernel.org>; Sat, 24 Jan 2026 02:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769220100; cv=pass; b=K8s2+mIVRQRoeE9st9QEEM1S6wGWmSLQKP6TtbXkjeljOMn6EPVckoC5x5CVSGStvrA8y6TPmGsZjPs4vvtOw7tdDlL/+3HnsAvWlp0VDvEGVR+NCOqDeCIeFx23D8/x7vjjQby3UqO7+FQSLIlp9r+nD2iCJInymn7EJKmTN/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769220100; c=relaxed/simple;
	bh=jLt0PwGKxUNFP/UMurV5/9hmISNtz6t9H2HpKnVOTXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1/leD+4H+CmuR37ad9M2yiKczI9K0T4B0j5praKfGjfVoM93Asajn+zx9CO3ESun+/itkxiYeoZELjWImXK7FV+ErjkUGpdWhTmOccTAaYu6XylZSp8D5vDgudVKIwt0L/AiMVL7VLOaPbVa52Ei34TkvyXIQv6/XPjEEbJj3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EG0rLPz+; arc=pass smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EG0rLPz+"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-8946e32e534so37979736d6.3
        for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 18:01:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769220098; cv=none;
        d=google.com; s=arc-20240605;
        b=NloVAdVU1AeCqAI9nEcop/BtCW9FuevZ+2gU1FY+gCSwcdIbDDiscJyXbTicx/Z5Ja
         qoeHJV/rVIF6P25BBhjHZnL90Cnfvo0hGQsCKSXL6YoO+UbLcGyk1aX1mhZyMXHpKWAL
         USi4Nbd7ozh1VPTGaRck6uF01QqQL/kvZOzbgh2uD6nWxJpTyvKjRzfY4zGlAVJ/3V6T
         Hkn0HzFgNFv5lSggrpiL2Pi+FGUANmM/xuu5TldcIGOtpoc5NRl4eoRgSwHpK4slxa8X
         NvzavtyZsTyjIe00zWdWP3qb44mu3CwxXlEYB7YUxB4iLbG0MiNt4gpVOcbyqT1NRZHr
         zOog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GcF2ydOy+nfomakh5Blwon1hHz6tHyuDcePaQDWXLgo=;
        fh=VDuLfKBQ2iw+RoGyk+Q4Ubxb5iPa95uQ+5UKRP6Ztr0=;
        b=a/5il4+9NSJRiqBiQhNPk6WIvWrLDrAbBhN43ZkI+jvAlkqbxBJbmWgANk5RT5F85U
         /RWIEjyWO0ITho24XM8QwaIo7yzhWysW77M/pDPoPcdJvrf3T0v1ubc/yxy2+j84d+Jo
         V1qMv1z1DHHcIJbffpxwYEJgaAxt2awvlAfgu6MZlTib/2I+kqyQIAxUziC/uQmjal96
         8EeMaXNld9KmPX97o64c2vB/NCq3BDhuaWUHhGTClJP87uPX598Afn8h7ALUkuH6eC30
         4EJHeWuOwMc1DDyBrqG9sz6NT9OXT6aHKXg57gDgZu+pVXGJTx7VCy/m3n7Ax60pTDkh
         H1TQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769220098; x=1769824898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcF2ydOy+nfomakh5Blwon1hHz6tHyuDcePaQDWXLgo=;
        b=EG0rLPz+LZN8S8D6S6REH6p4GoDCsfaAUR85NwCduukox1DCZ+HEfuuqNbAfCJ+QDe
         CiYBXDaUGCkhddGQY0oRjA8Yym/iOdaly45K4bTE81xE8mj4rPZ8KSsN9IvbteJ+o6mv
         SRSW4SUKEhVPNKImR0azPDgFpprYsjACfbKwuA23XqfZRFcZyXY8d4fkzmcFd7AypE/w
         vfIa8phAFBy8QGBeN/AHASmAGZO50Q9k+c/9EYFCNgx/9P0z4CK7Jd3RbJKTjpuK7oW4
         xCOxlaygZtnPFg0hH+v6f8jU6Av/ONIJ5n5MccnaZOYDLc7JnzuPMl4OKQxlsc4H4PJb
         lnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769220098; x=1769824898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GcF2ydOy+nfomakh5Blwon1hHz6tHyuDcePaQDWXLgo=;
        b=xN8VmXwtEPSXh9JmPE3TVdgMkJOhSOZBCyrdwTExMs7f5QtJ1yBtSzxFFmg9+KuLpM
         4SbrKDpf+CzD5Cr+BlqUb/dis34741QCHESOyuWcRnu+Dxm/nLlLpWirsC+RJNYfF/kt
         eU1KTq9jy8om7JP+A3BMcuGQz+iTXlCHll/C/LP2EjpR2ZT4MtE4NxAlcfhGGsHMtLAz
         VTAjgVA46lFJuH0t8nM1nJUzgqicqj4udi7L55eIFQm51MXwGqSJfTG+L/gS7h1t9bp+
         lUbcPjQZV0pBE6fWSfuODx3il56NW0jI4tJpQ7RU7dQKLfF2NKinmhFV46fMobHuiXYa
         aikA==
X-Forwarded-Encrypted: i=1; AJvYcCXF4COkwHQCWydbnib8DH/TP05YGCI07uAN94QsEY35G2gYPXH8PXO2INKTaQhmpAW30+UphtaYE34=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJqUlqM+fpODA+X+ox2KXcByX2yTW+BYW1Q1ij1P++X5X4sgw4
	iDOJbDI1U1D/ZZX+WbDt4iOt7YanM5YxOrJvPIaW+1oiL4/Q2fD4t8b4L6xEHOZJV4HO53POl9L
	qfuk5f2rHj4D8FS/Ptr4ZkF5Y6gujtSg=
X-Gm-Gg: AZuq6aL6WCpIkoJArTS0UBiI0vWyhbiKR6kLCe5ib//aNBzus4GN2geulWtQdxsvhy7
	t0om74zD91leFabJUlUP3D+x7eN6FXTuzxjkjy37+X3sa/JbaCtGTWh1RFbA0jEMudAeXXyI4/I
	L5WfdaSpWoL84nrnrAIXps8GTrqx7FUKzfqEFxywOK6+I6sEed/wEU/hSi4RaPmwpU4sAvWMLR+
	Lb2IJI3tPkZtN1fI8CCpNdMA9nNv3mYPfo5eNdAGK3NQF54u/hnJsVartK3cguGcMDxKaO3l8DP
	yaIeFlwH4kol1vGd7ygBCHwI5CC0tOF36VlIoLcjj4OLj09XewnFRJ45
X-Received: by 2002:a05:6214:20ab:b0:890:5973:a567 with SMTP id
 6a1803df08f44-894901b45f3mr66553036d6.12.1769220097575; Fri, 23 Jan 2026
 18:01:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123033233.16906-1-enelsonmoore@gmail.com> <20260123181156.GA84531@bhelgaas>
In-Reply-To: <20260123181156.GA84531@bhelgaas>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Fri, 23 Jan 2026 18:01:26 -0800
X-Gm-Features: AZwV_Qihtc5vhyYPwevTdmoQ3m_JYluy6sboC_AzdDpVbJp4Phlr8m3XaH144WU
Message-ID: <CADkSEUg5EqpKg2_X3LRc1CaQ2RVFNucJbuxDcHQxvjdLq1Qg1A@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ethernet: neterion: s2io: remove unused driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Jon Mason <jdmason@kudzu.us>, Jonathan Corbet <corbet@lwn.net>, 
	Linas Vepstas <linasvepstas@gmail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Danilo Krummrich <dakr@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	=?UTF-8?Q?Martin_Kepplinger=2DNovakovi=C4=87?= <martink@posteo.de>, 
	Pavel Machek <pavel@ucw.cz>, MD Danish Anwar <danishanwar@ti.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Huacai Chen <chenhuacai@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, Takashi Iwai <tiwai@suse.de>, 
	Eric Biggers <ebiggers@google.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>, 
	Ard Biesheuvel <ardb@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Dong Yibo <dong100@mucse.com>, 
	Lukas Bulwahn <lukas.bulwahn@redhat.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 10:11=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
> Not sure there's value in removing the IDs from pci_ids.h.  It may
> lead to unnecessary conflicts later for stable and other backports.

Patches to remove drivers are generally not backported to stable
versions, even if the driver is broken, so I don't think this will be
an issue. There is no point in keeping unused IDs around.
