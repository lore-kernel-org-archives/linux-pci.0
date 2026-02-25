Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26F93EDAD6
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 19:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048311; cv=pass; b=gDVsDT9QiT3uHf4BTl7WO/Jbr3hVYShJs6pSxSY0HzyHklbOvu5BhqFXb4WS+R0wuohphNd1+Vz5a9+BS2j8TzRE/BuHAPBOocZqevopADJU5ogguTOQAKkyXMBFFd3o0hGWstrpeo+u8CdeBpT/E4/mrcEYNYOMRBTRzdeBRKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048311; c=relaxed/simple;
	bh=Hmo3oDa3Cv086zgof3dOkp8NLgtKrbC0xTyF5LKmpE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=le97WoHyJlft3we69JtIszlsS1qk/m48okWqBjZkDHC3HNvOoMf3alH+7u9WCatZFCgk0HVqpp5ouiQMeh1f7jd/3VxpkjJZjEftqjJ2qu466t7RnLkyryMi2Ucr4dIENg8Qi4pxoq6BLEx4PMckCidRh5CB7u/rjKDH2c5MvsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mfeUP8Uc; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mfeUP8Uc"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59e63b427aaso7869288e87.2
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 11:38:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772048308; cv=none;
        d=google.com; s=arc-20240605;
        b=AqY3JcNceE2Ci3p1cVtMcihGR+aYxqDBbzZknJB261eVqu6esNWhBVjPzszJfel33T
         Ka8SxJGe494RmVzBOiUQnQWIto44Vg3raf++cYnD0s0zve9MjCwd3Trorb/KrtyF6FP5
         sLXBNE4f18iRJaq4OS67WoCZAbSiPrrC5eCZAp0RfaT4xUDdF4M0hevcPl+7/QMiQzB1
         5WLZIrKv3oqClUuv42MHwo9MIQWMjF/6d1nxdWako+XehWXL18Anh3/pwf5wLS7qppp+
         TPsfIs8COaJXSu5uctzUNoQltv2+QSH8n/wTS8sKaH4xuMZAIx9HjRhX4FA+8Opp5HwW
         pE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hmo3oDa3Cv086zgof3dOkp8NLgtKrbC0xTyF5LKmpE0=;
        fh=R7QbPBcQNL+YHQg2hi74IYt0+HGrgs+Mt3Ew2f77HSQ=;
        b=Oq4aVEawJX0Hp/CsG4u/RG6kAcQgxbT6HjxFQPHQPDkAB7Z7J7w4cKM93xdpKHY2OO
         bzlwtP/CDbpT9a4HJH+dcWT7NkiofOd3taa9pX845rNfY9EZWCdMxvgwEVr2oNeoMJGJ
         VVmPT+zhumKd7vci3AzxN88MOm9sVYib9I1wrOknY9ZvOIDZtK1h8TT29vuMSm75DE7X
         xLdbvT5o4QZ7+el7tqkPbf5LF3TslSs/Fkb0pAvnd1yL0VBH98OdbwmbImvlNzq5Uy09
         jIfeU/AA4rV56/Y+zv9UN5R/iCl2OvsQ1fgZIjtgFUNsUmgMzKiYCwZxwlSmzrSKv2Pa
         F/Yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772048308; x=1772653108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hmo3oDa3Cv086zgof3dOkp8NLgtKrbC0xTyF5LKmpE0=;
        b=mfeUP8UcmKH8ePJjxOzTvIHSgUN4airLqi5UY7sfBZE/hfPTt9lZDMQyvtjhMFot80
         Y5hv9YEJNB0yX/KHxTvVqVme+BY/mxq0SOoDuhHEPSQffKeFmUnSrUKCk13CXYr46r1+
         91U8dXpyBYu3du569iGKdREakXXQuc4KB0dlcwJmzJOfI0+6EcIaGeaO926BHVXEIq0s
         uFCllUTEPRo1Own0hox8Zt4FRb2S9IqGMXi7EukWeHwLWfeE6OUQ5WRHoULXJZ4hF71j
         TIGAw/mhDHuBTyADP2UXctV5vYtve81voky+5VNN9wcG5fiBuuJoR3Df7APfD29cfD/F
         B+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772048308; x=1772653108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hmo3oDa3Cv086zgof3dOkp8NLgtKrbC0xTyF5LKmpE0=;
        b=mlQr4t5BtkoTtjkgVOmeObMoBx4AyTjXd6IkeGhLxZrhI1alX+RLjKwJ4gc+xGVB6D
         swFpHKtSaHRptOYLN+8Tva/PrxtGuPdToOISLa5/VnV23ZKbX/NPPQRBxv54xix4dkgD
         8JVhYOaz2YFjKw5WIvAjP1qAQJrlk5DAp9lttkuvjlt7cFPf+7j+gebVSbOPvgleN48A
         fUsYK+k6OStMx12ERGVfV+8y2BhWzdnvbJ39t/UKXwf6RWK87XPh+FMvnLvLmPHlPjFX
         PdSnNRA9eJwAMLvJ/sjtxSK9qLVUYQB//qQB8I9yZEdHXdgmNJg6F8DL8566f2fYEMdA
         ZhLA==
X-Forwarded-Encrypted: i=1; AJvYcCXULyoJm808wM6OcspEOvyjCRZ5eNoqM85BwuCjU6f4FORiyiKvBmoW/8B7pXJ9PQwtOjflAoD3gRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn0q4+CbjZI1aoeIeFk76Y+4YGDufGp+FB5pWr71vLGUtWFFdk
	1E1NqnAydCB2UVHQwJ6Ynrbf9tzNIvz+7ZE1Ajb9YBbJIt29zjTbBRMoZfuTZ17ExbGWwV7g+A5
	ZqtLXg5P/zOcgZfHk8GGjB3OWVxN3eHCQnCKqxpeo
X-Gm-Gg: ATEYQzzUtTDXOUxZbeJbJJpBbRp3fYpNpaApw2bbXO8k7rKNCIg0o4bfrnnHLv492Iz
	zv9aPuC1izjtaqEC0Bvg2IaQJwuESS4GMFJXEoqyL2jTQd1BEvq05aK66aoRob/zlHP3W7swg4F
	nxvkhHQIu+opBWlCBG446MkJBl5Qc3iV4v8qycItCWbv9fTpaavSue0FcKPVz18Iz3jkGoC4bvM
	/k9Vm+rFYgy44OfRXMlnnLYZDXDlvDd7V1uYpkNFZNeR1t0NrQDKCvmYeHL5qLjIoGoMgVLEWqZ
	LiyA4RY=
X-Received: by 2002:a05:6512:31c7:b0:59e:45ae:7035 with SMTP id
 2adb3069b0e04-5a0ed88dc26mr6092032e87.3.1772048307624; Wed, 25 Feb 2026
 11:38:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223184017.688212-1-dmatlack@google.com> <aZy6cge_a9a7O03g@smile.fi.intel.com>
 <CALzav=f+p3bcq78dunjEqTOhRHxr8WhTxojYNwJOdYH49p0_Hw@mail.gmail.com>
 <aZ3fCdkCIAW-Q4-k@smile.fi.intel.com> <CALzav=eCZf_N=J9pfO8=-8k9TvCbT7m-=ByCL2jZYni=Kaeopw@mail.gmail.com>
 <aZ7EOa8NEMKAlGA_@smile.fi.intel.com>
In-Reply-To: <aZ7EOa8NEMKAlGA_@smile.fi.intel.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 25 Feb 2026 11:37:59 -0800
X-Gm-Features: AaiRm53hekLg6hh9uiJ_-J4HWrUo4bMuo2zeP1wB6eVI1ECvLj-J7HHR6VW4bZY
Message-ID: <CALzav=dnzZ8t4-dg6Q=TzgYt8aaZsytj8FUXPpifR+fXxnyg0Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: Disable ATS via quirk before notifying IOMMU drivers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Bartosz Pawlowski <bartosz.pawlowski@intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 1:43=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Feb 24, 2026 at 09:41:30AM -0800, David Matlack wrote:
> > On Tue, Feb 24, 2026 at 9:25=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Feb 24, 2026 at 09:19:05AM -0800, David Matlack wrote:
> > > > On Mon, Feb 23, 2026 at 12:37=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Mon, Feb 23, 2026 at 06:40:16PM +0000, David Matlack wrote:
>
> ...
>
> > > > > > Fix this by disabling ATS via quirk during "early" fixups inste=
ad of
> > > > > > "final" fixups.
> > > > >
> > > > > Hmm... Sounds to me like a premature disablement, but I leave it =
the experts.
> > > >
> > > > What do you mean by "premature disablement"?
> > >
> > > On early stage instead of final stage.
> >
> > Is your concern that applying the quirk at early stage won't be
> > effective because ATS will be enabled after early fixups are applied?
>
> My concern that applying this quirk too early may affect something else.
> But I'm not an expert in the PCI mysterious ways, I just share my feeling=
s.

Ahh ok, gotcha. Thanks for the raising the concern.

> > > > > What I think about the case, that IOMMU should be probably fixed =
to avoid such
> > > > > situation for all level of quirks. Can it be feasible?
> > > >
> > > > What do you mean by the "IOMMU should be fixed"? Are you saying the
> > > > IOMMU should be prepared to handle quirks disabling features on
> > > > devices after the IOMMU driver is notified about a device?
> > >
> > > Something like this, yes. At least the commit message is unclear why
> > > "This fixes at least one bug in the Intel IOMMU driver..." not in IOM=
MU
> > > driver code.
> >
> > Gotcha. It felt wrong to have the IOMMU driver be notified about a
> > device with ATS enabled and then have ATS later disabled. It seem like
> > it would add complexity to the IOMMU drivers to handle such a case,
> > and would be much simpler to have ATS in its final state when the
> > IOMMU driver is notified about the device being created.
>
> Can this be elaborated in the commit message? Then a reviewer will not
> have questions like me.

Will do in v2, thanks for the suggestion.
