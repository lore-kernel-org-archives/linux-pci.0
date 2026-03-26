Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A39393DD3
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 03:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774496932; cv=pass; b=cshKhJC5LSXiNoShh+WA9JTPFEFN3ij1SpD5I04o8uTTbUmh9Q7IFmuQ2/WGpFquDB+4XUSJ86yuQ2+kHsu1B5JFPMZaZ1H6bt+617vs8G59l4e3zT4utjgfCrdM7adILBe2ME4vynOO6RdzBKQaBJVxZiN/6DzmHWDjUk9xhjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774496932; c=relaxed/simple;
	bh=MH3p8Rq8n+uSxru3eIVnCkw7nOCUi0BFVhEsOO9JMXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FewTCFkbwgu/nsFNIlrQNahOhTpRPL2GwI5lIR65T6QmDlBFVO+DqZ17LmnLYv1Dq5g+z1exFcNU6qL9q6JbzWyFCyqhmBQ8joH08e6pwXbpWlklVSLmebuQSSzwkIc4jexZQUmd/tH/6JLT4Vj+7miSg1e4wVAIs6/oScR+cmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H6+cSRIt; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H6+cSRIt"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-509134ab2d2so5345681cf.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 20:48:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774496929; cv=none;
        d=google.com; s=arc-20240605;
        b=UiAsNZjM7E915DtxI7w6tDq1gUA2PBTA9eDTmuxH6jPhzzlq0jXbhYfNIPeDFrW6bT
         rSsBTbWLGd7otHTWqZbtJBn3xv1x7WSwtTkAs/ESITJhAivPo3iCfmBP3+Mnfutq/Nsk
         2xrONaF5Yw5bh8j7DLreOXTY8YNnzn+132btbJTrOHHC7f0H79+71J3gWkKjXb1DVNm/
         OLIiYQQlUbHtJxjiTZ9NUH3h3mEMMpd4T6aicjkO5+TiZ+Tp+xRoq2ZvMMUzPV94lWy/
         giWMZlvPARY5imku7vkCv7pBxO8tVL9Il6mWxksD8A9cPE3DcCCJpBBUNIvQ/M8M3Uvx
         gQag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=07/utsPXTfE9bIXIPc5MyGyaUqOr0SOGKlBDsG+5Q14=;
        fh=vD0BsegcoafdXV0LtPmlQ6MJ+tqrcERjE4UQcfuGomI=;
        b=CV9BMS/7XA7D1ZM2x/bK1MJjjd0F7HHW+GgDTPxf2lzsBRpjRG8PIYW91/U0FFrotO
         c69NOclswYOWxNtCBMTTs+CgzALuXs3nzNWHUFPN+hVIErrG65/rqaROhFmKf8vkgXA/
         Yg+TgC1Up+Rs/yqYwEFmsR5n7xljFd65o6CcHhULNw9I/a/IHTdVQ32iISc7eiZwnSft
         lZOl+jtfBcQMp8iV36MsstkHiKTySJ2uMNS+qAF+qi2SvdQX45QQ9KDotQB7z8aDqTQe
         QqJL4WyTt1jPyGkPn5AUAaRkR+YU4R4H46bW8qeh7+yK7q73F9eD/ci6q8TvG5FW/7zk
         wyeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774496929; x=1775101729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07/utsPXTfE9bIXIPc5MyGyaUqOr0SOGKlBDsG+5Q14=;
        b=H6+cSRIth+F0GnP4xYQ1m4BufU39k/GM9MsejKBhiy010mbT4ek6qz/3o1PpLbkDzv
         jx6aYbGG2Bb9WVGxlQeMfOJDcbUtznjOUEg0tpJlg8HpwjRrJqZ75d5GmhXyeHUT2e/e
         lgZpymrkeamayc0ra9guGldN+wM78IQ/C1PtTZChXxQt36KE2C5t7SA9Xw5cQFrVHXi9
         RCfBt43WZXt1+oP2X6oURHPW/dK01+xFpWiw8jn4EKrW88LRGhcq1RI1qrtSvzIpVmlB
         S8e+EsobtYyEbp+OhKHTb69NJWCbRziFKTLvhmYgFSwQOmdfkWNBt4+ge2MIwADh7Z21
         2ybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774496929; x=1775101729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=07/utsPXTfE9bIXIPc5MyGyaUqOr0SOGKlBDsG+5Q14=;
        b=UK8qIRKPabZKun6fyjHjgAKzr41YjWS7CIwHaqZI6VS11EaZvZiEHojtIJbtI5zylA
         zWYsHjsAn1QCR3iJi4BGp+OiTREnzfjCWL3XBYuOPj1XrcA5g+0aLum0gEYbxQSMIgvz
         bFYkBrno7hIgg9FpwQDZw1f+daRcMkfLIZcOBWZqrHqCSZzFvCblKtjaj7bv++0RlVaS
         KA115D/p+RVDPO2Q35G/S9lRTVvcOZJUC4Ea7iOKGmfusNW6QOCNvxhjXUubpsyhOrYI
         DdirEb5QY81I2LxQ7KFcCluNyB4Va3iEDlSiO1ioDJKw6WgtAviXtp4BZMZRR8m3i6sT
         y65A==
X-Forwarded-Encrypted: i=1; AJvYcCWX2bH6efJ9dZROWgk9Q+KdwfjAmi7XjXVC4pVA2IliW/g+F7jZrOkFYN9rc7rgb0Vr2DY/QQDmO9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlhf8vOzsKrW5EtAC24PIHHIwDYZMY15xnCC9WdgDDhnTyObPJ
	5k0H81W2P9dNXwFDgTdaTH09VqGhbEi+RqWeHGCjkYlBm9QAh5rncBKurfQDYW828Y/XScmTQEB
	0ZxFpZLTRNb/ozr/BMmVrpguRQCD+6SD/gdc+467I
X-Gm-Gg: ATEYQzwLF1XmxPH5KvfeW1mjFtxrBZCKC/leZS5lbyBFnp0MncC3+JwmK1zDezb6mRm
	gFjHNMhYpySsb1atQne06S//HaddOIDnPTkP5Fjvrl0Kz4yshSdwTHAyLaOcX/QYAKrGoFgCpQk
	YmHVD3l5H/iWdnJHFRWdpz2GAOq44ko62hQBTD/VZfSA2iuF9v2X641LMrANUth9jgpLZLVPFUe
	IeTJmntC5/7rZYEMvR5tDNJeRm6gF735brkmBjfn6gSHK0jf/rL9da90crdGN5xVTKi/9vY79PO
	uDZUpwrLl2NN48RCVbYsF6muUtAkhsVyWASy0IfIZDVEFSui
X-Received: by 2002:a05:622a:281:b0:50b:5146:8803 with SMTP id
 d75a77b69052e-50b80d3d8ddmr85893641cf.21.1774496928859; Wed, 25 Mar 2026
 20:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128212055.1409093-1-rrendec@redhat.com> <20251128212055.1409093-4-rrendec@redhat.com>
 <4e5b349c-6599-4871-9e3b-e10352ae0ca0@nvidia.com> <a8d841e870d6dbbabef7eadb774f2a58a96c57c7.camel@redhat.com>
 <cfe44924-3419-4f31-8ab3-87b769d21a5b@nvidia.com> <96c9d483f67be02fa1dba736fea465216d0c3269.camel@redhat.com>
 <87sebsdcte.ffs@tglx> <255713ca-bf91-4f7e-8df2-33b7b614a1bb@nvidia.com>
 <221f6dadb6d8ce06f30a24baaa2777e90d75b130.camel@redhat.com>
 <87h5s7bb5s.ffs@tglx> <87ecnbb2mn.ffs@tglx> <b5e33957-1b8d-436b-888e-2b6f13d30782@nvidia.com>
In-Reply-To: <b5e33957-1b8d-436b-888e-2b6f13d30782@nvidia.com>
From: Tsai Sung-Fu <danielsftsai@google.com>
Date: Thu, 26 Mar 2026 11:48:36 +0800
X-Gm-Features: AaiRm50LSOBGGeTsc-k8sx-ZC5DP0if3O1BxiToOLDGbs4CwHCrEIfEV5PdHh0Q
Message-ID: <CAK7fddBV6HHR-MTkRqH2gK=Ga16H6jjX0PsSaPUv-Cfef-WUbA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] PCI: dwc: Enable MSI affinity support
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Radu Rendec <rrendec@redhat.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Rob Herring <robh@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Brian Masney <bmasney@redhat.com>, Eric Chanudet <echanude@redhat.com>, 
	Alessandro Carminati <acarmina@redhat.com>, Jared Kangas <jkangas@redhat.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Do we have plan to land this feature upstream ?

Thanks

On Wed, Jan 28, 2026 at 1:09=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> w=
rote:
>
> Hi Thomas,
>
> On 27/01/2026 13:34, Thomas Gleixner wrote:
> > On Tue, Jan 27 2026 at 11:30, Thomas Gleixner wrote:
> >> The below untested hack should confirm that theory.
> >
> > Actually looking at it deeper the solution is trivial because in this
> > case writing the MSI message to the device is not required when the
> > affinity changes because the message does not change. It is set once vi=
a
> > msi_domain_activate() and stays the same for the life time of the
> > interrupt.
> >
> > So the below prevents the invocation of irq_chip_write_msi_msg() in
> > msi_domain_set_affinity(), but I would recommend to investigate the
> > actual underlying problem nevertheless:
> >
> > It is going to roar its ugly head at some other place sooner than later
> > as there are tons of other places which guard against
> > pci_dev::current_state !=3D PCI_D0.
> >
> > Thanks,
> >
> >          tglx
> > ---
> > --- a/kernel/irq/chip.c
> > +++ b/kernel/irq/chip.c
> > @@ -1495,7 +1495,7 @@ int irq_chip_redirect_set_affinity(struc
> >       WRITE_ONCE(redir->target_cpu, cpumask_first(dest));
> >       irq_data_update_effective_affinity(data, dest);
> >
> > -     return IRQ_SET_MASK_OK;
> > +     return IRQ_SET_MASK_OK_DONE;
> >   }
> >   EXPORT_SYMBOL_GPL(irq_chip_redirect_set_affinity);
> >   #endif
> >
>
> Yes that does fix it!
>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>
> Thanks!
> Jon
>
> --
> nvpublic
>
