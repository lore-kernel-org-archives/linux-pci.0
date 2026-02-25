Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDD9387569
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 23:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772063703; cv=pass; b=RmLQB475lgD2fIYbkBAqOgJ+ox96QYTopjGYysKQnM2FS9+1jNebJRqfOmTEJPhBE2qT3K0tiCLi202E9ArbdRp2Ye+oMhZuX12ppD21mWsv8Ixi3S5Ll6y0ck4vVvFx9UX8cYbi/xkFW8sN2S5KoLdR8l+JrPocUCRjvAXfxRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772063703; c=relaxed/simple;
	bh=cHKbWLM0axLoVNaLpqGFg3zanhbcwqXxf0qoCpGOoI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bS7UXj1JkYyR+fHZjw4XLgBtOnVaSZzdfMiKG20X7rauXeHalpqvLA+4fsqjdP3rWudmQz476DxiSlDVEqHBN4pyKac8IH5+KUNXzdwYqTE2NCZzzskQMDRbILI4QX+omiBksznqFFfBKqHcMF6CaoFotHlF2GViX8OR8fMiLE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=woN/zIFu; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="woN/zIFu"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5069a785ed2so125951cf.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 15:55:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772063700; cv=none;
        d=google.com; s=arc-20240605;
        b=E8tyPRBtDD4AkIDGGF7/jEpsa9afrGRbmsutrrKf/VO4LHbpMmcV7kpzwH8igd03J3
         pUFAevFO5KwJj6fw2ZZWtO2hqftgqWHGszNCd7I31vDRqw5KgzsmD60oMxXVyj7fWIjD
         9ufwQ0dCA7l+/qiPFV+bejZoF6xLAic3aBG0VzvDRHvkvM0XAyWcj6Xs+rZG7fFHtVy/
         p0bJlP7DzpLLZYe/cgjZcK6EeyvRyPtBkh+cC3whOCBjtORvXsqsQAHwnlrJ6UKILY58
         zuejdyha8s4iDRCq6+lQ8Hb8jxakrIe/y6KGerTx4PVkIthgyvDdGu4Q0w0NP5EhfX6E
         hLYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/+d/kouLLf9iKHdyjkzWOU+gVjFz9R5tJbv1KqoUtQs=;
        fh=AhrI1xHP104wuHhmWpZ3cuqUqfW/2Cml8xiLViSGtl4=;
        b=cfF1g5S52kcXBDuGnHXR2zfrn4V+QGiTI+GTO1dRqJD6mJLQt0vazHsWkEmvbXGFw/
         Eu3CHYTGa9tMp5gS7zzS6KbY1dtPeSnAt71U+UBKgmqVwUgxuYwFG3ZlDSsGp+micTfE
         evfKmLEcDJrA5Xh+wI3Cny+I6pzMZa6IlJtU2bZm9l0XQaAqB0iOnGyYz6mOOpsPFv1u
         rFLnAnS95zjdHf3Ojb+2JwhXj6uLNaMU2UkcQosM44PAeoUx1h6bQgOmToLxnCA89BJt
         oxoqvHOBouvq1lRAWE7VwUw+H1QWeEqIRwyOCbf2cWRVSJkfZYILlw/qIMqrzkmyqAhs
         /Yxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772063700; x=1772668500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+d/kouLLf9iKHdyjkzWOU+gVjFz9R5tJbv1KqoUtQs=;
        b=woN/zIFu6BKihA15yC78RP29swvjyWELyfFC7nCXXjDp0MOYz9MeqkJAX7NZQgR8lr
         Q6jkd7crlbvBi6GHsRTr3yoQSm2ujmV+ZhBoLcjyGSGsmTM8gKVN0R0f+0jkKtwzIOLw
         UDkRV/IyBCd/7Oe4Jdj8DarsdRyaf4TOwiNfQOPJ/sUOz2m6p/8DAv8R/qEVBBxyrHDb
         8Hmz6XcJNmZud90aKSuqwDfE9JJQvgnrsw3+1maq7lPpkCXy2pgyH6X3XtN2pdlvbJ6e
         uG1jocZ16krKPFLckMlHcZ6Xv0qQ+NW3yR0d3FSAPtIZApnFPXupXpYF3IOLnBNdAJf3
         vIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772063700; x=1772668500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/+d/kouLLf9iKHdyjkzWOU+gVjFz9R5tJbv1KqoUtQs=;
        b=uT4KHx5i/Bc214Qaq32GBbF81MxKdeNj68rUOFpFvBY8hL/FScqLLYP3T7E8lXKAej
         kgzzF9zZO99ztCDi2izroT9+dhy2qagzxEpb1QsVLz3AaJL8YFjXnLGIVVKFsPJkLIVK
         vf8TwjZQseStqVtjXbuaXy0C48SXYSYFbHl99L4WKhTPNcVkfWCrlKpSQQqJpypFaT2Z
         GoKZaVSNIt/lhO8jn1PhPGujk4trmgKckWuYV+f1gk20SNNM/sysSZRLywuVDk34Cah0
         SUtwfwquuhK0iCeZ2Q+qRYdXuajh2lAO60k16eDH5G3JG2jnnepbFNbGzEjHHTbSw/v5
         wQRA==
X-Forwarded-Encrypted: i=1; AJvYcCUIhAqSzyEzUAc2XzMURuuBzdh+aiW9I2dOu2yB9TRG7Hs8mcodXsb8sdw6b2Aaj1f++CS/FmTBTBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKKQW6NzaHvM+laI04xC3lHND8iL1V/DAF6d2UOuEkIxR/pC8m
	PXKlpTRYG//RLHG4NN25R9godo0HvgdpLJG/IDyYxWTwv1POeLe3kfZgtKgdORq11N6bS/0R6Gz
	cwUR/RPOPLf7DoDDtCYC8OCU9DzSAmkCWoDYCJLJ6
X-Gm-Gg: ATEYQzw0umrIXZePEmvuRwsFhLPlf644D9OmMSTenvnCcyBoAuN+JwiuKdMBqrFzOHB
	mN1eZvEVjLz+42hOGakoTITXNcZoVLSfEASNdr6mesqRCDGk4Uh/7ngP46aA+deMrehpCBrFJSu
	eG+mfp0U6fySruxKvT5HbkNvhaphtrS6JILW9EMgKCsSXjNLODvKi5ROrNEc+nF/wSJeGOGnnp1
	CRBr5s5C+tNZCPMDH4NSzE4CBv7wXHE9I9/irMTdtnqrBpDluAabWRIdD/lK+LmYnMHRd5bCq8u
	b/J9mVfunznOH19K0TlIs/QQFoHEcKSG2bRjGpVdSQ==
X-Received: by 2002:a05:622a:4c:b0:4ff:cb25:998b with SMTP id
 d75a77b69052e-507441e2d95mr4895751cf.12.1772063699005; Wed, 25 Feb 2026
 15:54:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-5-dmatlack@google.com>
 <20260225143328.35be89f6@shazbot.org> <aZ-CnywNgMnr6f1k@google.com>
In-Reply-To: <aZ-CnywNgMnr6f1k@google.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 25 Feb 2026 15:54:47 -0800
X-Gm-Features: AaiRm51g4hX409PKMap5bNDNnG0XAykqCRndojsQbHHI9mzip6hP9-Z2S9ohyZI
Message-ID: <CAAywjhR4Azqx8hXRap0eLUrwetYRiX8TALEM=b+1BorPc3eJdQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/22] vfio/pci: Register a file handler with Live
 Update Orchestrator
To: David Matlack <dmatlack@google.com>
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

On Wed, Feb 25, 2026 at 3:15=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-02-25 02:33 PM, Alex Williamson wrote:
> > On Thu, 29 Jan 2026 21:24:51 +0000
> > David Matlack <dmatlack@google.com> wrote:
>
> > > +int __init vfio_pci_liveupdate_init(void)
> > > +{
> > > +   if (!liveupdate_enabled())
> > > +           return 0;
> > > +
> > > +   return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> > > +}
> >
> > liveupdate_register_file_handler() "pins" vfio-pci with a
> > try_module_get().  Since this is done in our module_init function and
> > unregister occurs in our module_exit function, rather than relative
> > to any actual device binding or usage, this means vfio-pci CANNOT be
> > unloaded.  That seems bad.  Thanks,
>
> Good point. So a better approach that would allow vfio-pci to be
> unloaded would be to register the file handler when the number of
> devices bound to vfio-pci goes from 0->1 and then unregister on 1->0.

Yeah maybe a kref that gets inc/dec in probe/remove. I have a similar
problem with iommufd preservation, but I think I can handle it based
on the number of iommufd open.

I am wondering whether this file handler registration kref stuff can
be moved into LUO by adding it to LUO file_handler and the modules
only call get/put?
