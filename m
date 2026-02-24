Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB42D3EBF08
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 00:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771891288; cv=pass; b=manB15dLt7UPK/0ewluKHX6d05WRkY+Ajl2XL1nOfps/94Q6WZWWVxNZg5TcmrgwTZ/ueAUDdluIUWx1iHg99+mvF7x4OmVwtIx4CMzRYZEXOwpE4u+JwowJADKpO6GTh3idi5Ws5ENEwV4mD4gVqBJloWX3a/brgPt0NKcXcxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771891288; c=relaxed/simple;
	bh=aTxboB9GucgmRPcQO44MW8P/VNQdv72V6gXQcbjiD4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpO00VeI9lJ5tui2KRIdsixBYOk/TPwY9Wsbzv5oqjsElKKN9mSckWHguEMhdsH+QxgJ6/HugyX+lAySOtWv+gguLSAzJwmb+fe51ai4IZZSNNm6dH8sJtVt+gc7FLU/Q72EodTPy/urrWKplLN4hPXyYpVRbnPB0VAgGQp22EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kbdryrbW; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kbdryrbW"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38708180241so38653641fa.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 16:01:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771891285; cv=none;
        d=google.com; s=arc-20240605;
        b=DEUjABoAscDqq2SmfrKjoXnlraiiGt+h27RIVdyJeMbi9zWi79zU3XiLdYZa1aifIi
         xL2vTUpw95JoRAgxptYaMHa1oCQtfozTyxJ8zTEWqZ5BwMaXoxaO1pBk5AB6HbqTlMFH
         S4LKA8Nlu5hBIw0q50c9j4jz5nrNF6XGs0ZWtrC/oInjQK4jms52k5t9dSgn/tASvp0h
         x5vhg7JG4XuHmuTlzaB1b3p6f96dJ/uspQt/4QrbLQ6UqaWCB6S4tm7Ptcn6NuktgC1g
         xCd7INcApZ4culNYW5KN2VNqRf192f3Kx1vCKpQlqZgLoq8UGWc3oLhlaXlLyQp7gnx5
         Wnig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GriSu+rHCn93XDuWZWOQkqMZohlC+6Y/CRMlBkyQGvI=;
        fh=/BGpcyYJXPNMR/xhIOvQUFEKuv0NTDbB8WKjxRRh6Vc=;
        b=lkY9S+RKE+qg/HeHaOJUDlMlTVHeqyFww3HNJVrBgu3h6a2a//XJtoLrWC5MWfwH5J
         v1koJPJgAIkWIEle0e1aR4627NudoS/F6p66KgCHUce1P7JRDfAiWBLdj8KhOJ6Yunko
         /U7W4r35oqKEJzjCoyGyy2jNCtomg0bEUFEulk1nkRQ6xyiynLUgxWESRsC1P7caCklJ
         Qmy8EmYAHpSqdNqF+xQw9e8weHi+qy5LY72qe7rz3tlAwbSEJ9jromgxsGVFli9bfPaN
         esLIu5FEWKlxKYmbRHT8O1ZqRphVcyC+R7ydY6uTuVb2C5Ng1o/KBcOW4mg80FigYj8i
         538w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771891285; x=1772496085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GriSu+rHCn93XDuWZWOQkqMZohlC+6Y/CRMlBkyQGvI=;
        b=kbdryrbWSHHGm5iTQP90PmBJfqS6sz6+HaWhcI5gmuaBT/st9JgTmvff1uccm2oXX2
         Ujaryx+/uNxY5D1tnjOZACsbEQLejgaRR+D8/XrwNcQ1ivGf/IieQnqx1CqWFUwcJMrk
         80mMdPGTjFjai52mrSqnyfVanhWjQ1JhuscFG9RB8freLq7X+CFQaQuyycQ3dYOnWDgq
         bZYHsZu5rK2V8qr2DSRL1jPiXSmcV+Fz1s/1KmGV+FYnTeDc3DIYq21U1B1mrxC0rMX7
         sYuMk0buDVYZv8NmVJoWZoT3cwVw/6K9+qJdRdbFvNVxL82YlJoCRCexFGbrtSnZt6ZP
         1mIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771891285; x=1772496085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GriSu+rHCn93XDuWZWOQkqMZohlC+6Y/CRMlBkyQGvI=;
        b=hqzJGNhODUSZvx2WP0JyCuYixlL8R5sTEtNiFKh6HWDVjOmFC88m2l5p8mM911Kxj5
         if3Vv4u+x+LIspOZbsFKNTC+RFZaO0z/c3qKffb/o0DY0ta4Fds7WiuVNBFSi22Nfxky
         2NXE/CjlyvKp6Uia3rm96BG/gY0xoFFcYV9fLEX1HnTin2DPAlrVmiJTKoWga4IjJz4F
         ZGP9HhebR2FKuNGD8A46fmzNgrzwUMC/gGESWeelwt2tPnNLe9Jusz+j94iWwNxgAJdw
         F1dR58YTiTm099ck6/sSiZ+IWvLw7jUVfsLmleFGDwYcbn3WYr9Lu+WwGyI58GPX713O
         BZbA==
X-Forwarded-Encrypted: i=1; AJvYcCVZywoHpcx5aPxn8aHZtTKKjEcoCrazGMJuBx9LiG5nDUeACOXTesicYVmgZ2wIiCXlnMal/oStZIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNRnyO7Atr8mFLS8kt7fG5H+lIu2y2kk8HgdUkxzgx26+C0ogJ
	b2ggWK1m9VvJJlotKVxeR071WJkBITrFbq54kZJwsd99kB1XSX9OTyzHTL4+ZsUy/+FxWknVn4Y
	zRKO9C5xyCEAFBfFAtLW9ItIiwxJtUhnUWnRVGK9G
X-Gm-Gg: ATEYQzwfwaXk5EHi3au3Orwr31foHw97RFlAQIqc1fZOGZgWjdk8UaIOKY9UTn9N+AK
	+XN/c6B/n6TvEiPz4eK+5OhVr64j0IwJdd13qE/aBW9FH2iA7R1PNLBFZFvmfsDxHGTr8vancDk
	ZYMoC7JKobfaqRY1HzNozeEIFZ9nLAFbuZlK8Le+atKRhy4ewFwBJmj8l8OvdgGFcY6VkYAfauN
	LWGeBWGO/BYtFwzvMkZ7CQmqU8O4pEgsu6UsdLS04ct2uiHeffA/Gq6vvutIVRBEwrspFYz55jk
	lqWsYlY=
X-Received: by 2002:a05:651c:305b:b0:37c:c84a:99b9 with SMTP id
 38308e7fff4ca-389a5dbcff8mr25152861fa.24.1771891284261; Mon, 23 Feb 2026
 16:01:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-3-dmatlack@google.com>
 <4mbhcmimhin2ulz57mbzpe5p5dkhfziiyep5k3vgls4zmom3sb@g6jlouyvmpuz>
 <CALzav=eXY=ZBshmpi9axt+_0SxaAm0Xbo7w==nCWJwKK3xcThw@mail.gmail.com> <574e4wq43zm5tyfvvtjfvzqlhoyijcgvvk7gptghrx3ofq5ck2@l2q7xbmtibbq>
In-Reply-To: <574e4wq43zm5tyfvvtjfvzqlhoyijcgvvk7gptghrx3ofq5ck2@l2q7xbmtibbq>
From: David Matlack <dmatlack@google.com>
Date: Mon, 23 Feb 2026 16:00:56 -0800
X-Gm-Features: AaiRm52Dp6IBp6nUtMfXlMTK93T1cVz8F1V8LZFFdJp40no7f29X-MFiBmci9Nk
Message-ID: <CALzav=c1P7aoGzhSuGsFi6VYsNjygPvBR5jWXb9uqbJ+3MqARQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 3:43=E2=80=AFPM Samiullah Khawaja <skhawaja@google.=
com> wrote:
>
> On Mon, Feb 23, 2026 at 03:08:19PM -0800, David Matlack wrote:
> >On Mon, Feb 23, 2026 at 2:04=E2=80=AFPM Samiullah Khawaja <skhawaja@goog=
le.com> wrote:
> >> On Thu, Jan 29, 2026 at 09:24:49PM +0000, David Matlack wrote:
> >
> >> >Drivers can notify the PCI subsystem whenever a device is preserved a=
nd
> >> >unpreserved with the following APIs:
> >> >
> >> >  pci_liveupdate_outgoing_preserve(pci_dev)
> >> >  pci_liveupdate_outgoing_unpreserve(pci_dev)
> >>
> >> nit: Preserve and Unpreserve can only be done from outgoing kernel, ma=
ybe
> >> remove the "outgoing" from the function name.
> >
> >That's reasonable, I can make that change in v3.
>
> I should have added it earlier, but the same applies to the
> pci_liveupdate_incoming_finish() as it can only be done with incoming
> kernel. Maybe we can remove incoming from it also for consistency?

Yeah I can make that change as well.

I was erring on the side of being overly explicity with the
incoming/outgoing terminology, but I agree it's unnecessary in these
APIs.
