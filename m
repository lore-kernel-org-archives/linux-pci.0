Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD8E22D795
	for <linux-pci@vger.kernel.org>; Sat, 24 Jan 2026 23:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769297551; cv=pass; b=C0zs1jbyJtIY+DhSRs4BXVFJGF7SXoO8CNrqrdhC+1EIJiAAACE30ffusM/9t7Flx4XGgZzL3bZ+bx3pTcey/6n0duSRPU1xaAq1/7Y2hy2D8jsf9RDatT93wTgYse1gy1D2zwR+Y/eXe+QlX3YPwFj33oVK8/8GL9fyrCrnlNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769297551; c=relaxed/simple;
	bh=62AUfn3TepYhzwErRqoDeLZjyZJQUDkNhXA5ssHqF2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDNRa+FXWvdniiwQVjh9awfqketMwvG6VuwwJrx1WIijkFGSY42I9S/kPpe+ZkF20diARZMflC+Dj2sv5tPX8TJ35hcsMmC5LVn1DeX9y0PIId+sy+kE1xudTKQkmFUNOxta+qs1Fb4onPWts4fOtUNvW1xzHXKISp1r+uLeVOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaszhpSV; arc=pass smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaszhpSV"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-502acd495feso42419321cf.2
        for <linux-pci@vger.kernel.org>; Sat, 24 Jan 2026 15:32:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769297549; cv=none;
        d=google.com; s=arc-20240605;
        b=Dg4RUt8neBSJG04jXPGHL1tOb2z+CnlFxRiZEsMuz6nYpJeMe33uL90qC3vK83T6KI
         Ys7zkwAxhKMszhxCnXUnW50rZ0gWkYP1CIDNVPEPGh5NLdzU9sLHGqt+4K1xbfHuFjTi
         bpLH4rO8X4QbUfOHJaLksDraO0FjgRPeYFr2Ez3dCqT1Kawl4dfcOXauXH1Iwa4fYE20
         so2nCDCa3FUEUUGvvjYMG8h0QMNLRPPSvFMNaQAMuJIXD6h4qtZ/66d7Nz4u3OpOgE4Z
         5+DC4yq3Kyr1j5/i92KfyumYQu+8S1A47tOXwePVXjB2EdD5wBOEg2IksTJREQZ6zlKQ
         ttSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=62AUfn3TepYhzwErRqoDeLZjyZJQUDkNhXA5ssHqF2g=;
        fh=uKxMczr/Olxj53j1koKe1F6Y80VfSxaXynEKPNw4mHw=;
        b=FeW/fHzb5vWziVrTGMG4PDFdhK+br2dzEkxygfITJ4dno602NgjxiAARXi5W6pA3iy
         EkHOTWrihuacbgFJiXBR26XH6ZKngOBwBWg5HHs8rqCmY8BP0+RvAx2PL0JKgabKibQc
         hvvqLJo4yR6kKrM3HhvijvCmyZhGYM0cs5TBTOc0bi4HjJyKu4HuOjzXbtlFizn5liL5
         Yg28Q2lEWkwK6q+hLepJ6loQo2KF8l2ZL9dVpKDExMv2Cjn3s5NoMnml7XYsGuqVKXfX
         eOY+DFx2Dp+xYcQxae86NIoqu0clQvUhJrUYjl8kP7p33xe2ZE8Z9ke2cvG1+9zzW+gY
         YwRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769297549; x=1769902349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62AUfn3TepYhzwErRqoDeLZjyZJQUDkNhXA5ssHqF2g=;
        b=CaszhpSVDhvXzlO7i5v7MZuDpk3LEVYj90HYC5ggSo+i0hWCkXMXeL2ps/7SGClU0a
         oagfcI+67P9PYN50vUA1FDHzyLylIVj//6r7kPr33pdWNZG7OetHNJmVqH+RLue2f4Ti
         RyASq2nBsmRb82ZFGibxAdGiuiuySBj06PDEupDqzEYB0rBAYozg7/aJhtBCt3tt6xzL
         65TaECbGBd8wY8fCaLeVtZ6Vi86EIj8CBo5Wd1ntGwAZjFi+XN1qJ13vy8y6CTYTO0X8
         aN/lXBDHBZVyGzzEWqy6gkKrqikTEWYj1sr6AkDSoEB+QLGF5lPbzUj3fJXyyGRwSGcE
         xU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769297549; x=1769902349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62AUfn3TepYhzwErRqoDeLZjyZJQUDkNhXA5ssHqF2g=;
        b=JSMPjXRyyUxhpvmIEY7oKunyCBmJ1e8VG2SFIvkBmkFAzCHMlidM+9o1cm/ywf61v7
         bKGyY775gns2DRRxbjRUuPq3jVApmypqz7LnJmqYev0AgPPHmnm8ZcyTMbSwSRo0hnCP
         WTsFic6rw+59GDOmYkq9/QCKS2T1gaUODDCL4A3lAael2gTCNP9Bv4CyefDo1UpPxEGn
         sZ7W/uJn5NqJFXU7AvttflJnwdixQuO3++RmgbAkwsEEaWVcYYm6wsx5g+z4xz4l92n0
         /1hw74gIK7KWL8fNyaCqomw3Ps2VjuepC7UU/pzU59yrW4nC+IX8I1e2mwrnW1uOQmHy
         i9sA==
X-Forwarded-Encrypted: i=1; AJvYcCXLgh8ZK/lnYLQE6W0bpwdhpf/WfzQpLIVGUKgzgC8CrCB35qI4/8VUn2CJfIfXgK/QZOxqRU4qzD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEzPoOkfxoskt62fjSUklfdkhA7+LQJbw66MHhe74iDQ5usW1Q
	GQHtrouLEQ+yNHdOt8DvXRKGN5cIAAm6upyvDbwACDJs5OCEVLzdR/2GqEw+W5roTe8ENlxe8W3
	TU04hbcL4en18YWTn2y6uOPvXQmsg/tyDNiNCUGs=
X-Gm-Gg: AZuq6aIm9pzX8dtxQuiH2zGMMv1T1WFhpVqCCk06zwCCQ0z7CpfL+dCyX0+v/zTnJ9C
	b1rzRXIXF0D+x2P4SRMlwZD6foSqHmEdfEr4YbJXXOwwc58IDxudF90Jt7IeouyqjYFvr+THfA3
	0rLwoz5RTZw18SS0e35EQFF3HPWTvNASBIC9Doz3Qkx0Z5sN4duul08wZs00laJsWZaR9xl6iWm
	1ux16yWkL6V9fjeWSf6xnz2FOAKFoRLV9hTvFNZXyBdKzR1Mp5CSFsmicaXFjq+Pln1e5CV+vMD
	8lXMuYn4Tg5DLowu8n3KxtThRJy4GqNhNx95rjR7ngEW04wuSCe+4BfSeUy7BVM+9OdXWK+BTRK
	bnS/nRawBci9dmwA=
X-Received: by 2002:a05:622a:55:b0:502:6312:8d6 with SMTP id
 d75a77b69052e-50314b7a6e1mr2969171cf.12.1769297549164; Sat, 24 Jan 2026
 15:32:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123033233.16906-1-enelsonmoore@gmail.com>
 <20260123181156.GA84531@bhelgaas> <CADkSEUg5EqpKg2_X3LRc1CaQ2RVFNucJbuxDcHQxvjdLq1Qg1A@mail.gmail.com>
 <8477da83-2441-440c-80f1-66dac9700523@kernel.org>
In-Reply-To: <8477da83-2441-440c-80f1-66dac9700523@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sat, 24 Jan 2026 15:32:17 -0800
X-Gm-Features: AZwV_QgT7HJ5RzGZbmSKdUH5ZCEsN2PptDSPTNTy9vD6bN7Rq-MPZtQjsOmB-V8
Message-ID: <CADkSEUjyXH74izTrsfhdAjh=n-jnGx=tXbqPx86M9OYqjXj0PA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ethernet: neterion: s2io: remove unused driver
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Jon Mason <jdmason@kudzu.us>, Jonathan Corbet <corbet@lwn.net>, 
	Linas Vepstas <linasvepstas@gmail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Danilo Krummrich <dakr@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
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

On Fri, Jan 23, 2026 at 11:25=E2=80=AFPM Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
> Yes and that's exactly the reason why removing unused IDs will be a probl=
em.
>
> Let's take an exemple: some patch adds PCI_DEVICE_ID_ARECA_1682 after
> PCI_DEVICE_ID_ARECA_1681 in pci_ids.h in the mainline. That patch needs
> to be backported and it conflicts with PCI_VENDOR_ID_S2IO which is not
> anymore in the mainline but is still in stable.

Hi, Christophe,

I understand your reasoning now. Thanks for clarifying. In my opinion,
changes to pci_ids.h don't happen often enough for that to be a
problem. Unused IDs have been removed from it before.

Sincerely,
Ethan
