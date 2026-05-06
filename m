Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E652A34CFD6
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778101837; cv=pass; b=jDUc1dn0cU/GBLjd+CzyyVkaHUFJzZwdTV/26osbh4qCLq+6MHItXSqZKSON/wrD/uBamYp3PFnLeHsusWNVNVQP6CT/rEaDuOJ3el3kIOdxwJEirXfXa4lhoT/PbXa2RVa3fCaYVv3oyPD7OkWWh8bq2cAOq3Wm0MsKf1X6Lr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778101837; c=relaxed/simple;
	bh=QqaD8UmQ8Z3VOreDAgWf/h1HMc4iYrLZBevxSmnzqSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWDdYkFc+JOZWwIMMFT1okOqUHFD8jCarXvK7+Raz8Pvlp9umaHjKdUKdXiabw2mDBGpQSf89xHz41VyX4/bivi0SGL68iPOAUYD+ayPUmdmbrmzImPRUK9BXUGWrue2Itimru4c6O3WlMMwbTflydhSEwUZtjzq09sqdhtYeXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZwV83VRD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Io/1TX9z; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwV83VRD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Io/1TX9z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778101835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxnLsY+y7KxAKQJwPXt/psWoOCQobXjWIWQgMudLMZw=;
	b=ZwV83VRDYxg55tckBhjXMhJn9oOk8kDusv+lDjNfTm92EBSdoM7OqBEY2Jv0mc+RaUWNah
	dxMUr63r1iHjEaMn4XuhrCkiLOj7IxaKuG5RxgXab5SI2IAycmhH24YM7jrkr9DKJ/VEys
	rFrCdmMqww0UCbAN9I2M3DbI6kKp0Ss=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-FiPhO5T8NEqHowR7I0YXYw-1; Wed, 06 May 2026 17:10:33 -0400
X-MC-Unique: FiPhO5T8NEqHowR7I0YXYw-1
X-Mimecast-MFC-AGG-ID: FiPhO5T8NEqHowR7I0YXYw_1778101833
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-950bdef305bso322949241.3
        for <linux-pci@vger.kernel.org>; Wed, 06 May 2026 14:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778101833; cv=none;
        d=google.com; s=arc-20240605;
        b=NzyRFKuSf7zinOW/Zeig1IkCPYbj2yG9LHQOpq6TioBnQqG+pY9cOouv8hXl9zUYPT
         JAEKFOsAj6dDbbTWrTof9Nl7unBvBkl3CvFMM7aWHO4ASWMHK43aNGvYXEcRAGz0DlY/
         jMIBNv+VHQTgPFJ2TYddV6vNMFWdIcp20VpcrbXm6fBfkfnJlXo7ToYZ+ub6WjzNb2R/
         tQBRx7u8eP4KrV92TLfCwAQjv6VmPQy04Pw5L9CZZtoTpumlKy2Xn0wzYKW6n/x8+7E7
         E/qarKG13v88B59rkv1g1IwAiSUk/H1OEDTvFN/X6ids5oK1mOUn49q8Mj9iJjcokylg
         1OXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wxnLsY+y7KxAKQJwPXt/psWoOCQobXjWIWQgMudLMZw=;
        fh=Uwa8l6HB2kJTGCbiz84BZE47dQtaZ3sXdMBO7FyGPR4=;
        b=fEIqCzm/DfnYAm4IRvmnVKagB0+CGr045/Ds7Sk1TkedaElxwc9Oh5KxibwI5Ixlir
         fEMm9rF5RjIrrDYuiJ2wfec4H460RVH57HulEp5/3NxhRYjS4ukekd2szDT2X1eTuXLI
         rSYdqM2+sVnOuE4za2nkV/ISoe6lfPstCAayR8ZDaRp7wXtPx6suUlaKMmt6zoPG5UAv
         WyuaOcHSpl+k/QytkXr4z7XZXxnfjlpq1KS0b9bL/PCXikOqzL3lHGI0BUepKvu8UyF5
         ima9kENZY/GIjGSdrDU9S3RVTRJ+GbhG6q2Vc4OJjxYIwnKLp/C30yjxsANgoyDQZ/1W
         T3AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778101833; x=1778706633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxnLsY+y7KxAKQJwPXt/psWoOCQobXjWIWQgMudLMZw=;
        b=Io/1TX9z1xev4nF01brEehtP0t1Xbm7nnX9/0owhkCO2Ussu9EnVk1mWc3P5TDazAI
         RFB6pAk9LEp8e9YnSbDq3y1ctRDD4BG/1IgXKrVRc5CFTcdjCoXV/gVz7eL4CU0N15cU
         3jzrHSCr0QaMwlRykw1sm8RjX0BIJB28f/1Ps4g/TWQAEfcuyTsedq03sUD65aA03Hbj
         8DhnqkJyEq0g4cPsrLaMnz4BugfloBrbntO+i38o46ZY8RsPV6RSehNhk+Ho6XJZtcSM
         WWpQHPchPgpGny8k2zxiV9sJ8H9k329F0YD1nO2S+zXc3pZ2NqnGQHsYRy8Omlp7xuDA
         LrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778101833; x=1778706633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wxnLsY+y7KxAKQJwPXt/psWoOCQobXjWIWQgMudLMZw=;
        b=Iq3BCHOFO6e09M6JuqjDrAuVcljTmmhoMxWgfJS9DK2/5JpmcTLCPC5l38CHQoipGj
         LOioSd9ZMPLiiMyXF0h44p4zK8gO1cNzpnOiekKzm1ja5ToFWus0T/fI/sQiu3YbFBEL
         EcE67FCGq3zztK1mPT4D7VxRUH/l3QmpDYGfzAeOKjYHXHMwpDE2Vu3k5+pImqtixA/D
         xeV+oM3uZW0WQ79oWC3z9OZOmQg1LMC8zh8anrkSh1GhI/Ktjo3oDphWP2QMc7FAOGT1
         kQpTFpFZGt9cNt/rPY/toAgLCdM0iD0GazGTzLHJk7op7bTjX5yUbYnKIUztqwiSsfQ5
         U0xg==
X-Forwarded-Encrypted: i=1; AFNElJ8fF3meyZiqfG0jfIBaT1QMWnCoZWy/wXLxsABCxIbkN6SJyKFuO+lcGkplIzLvTncWPHpQYYa349s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPQZ5MwNseqpev6wWfx2y5/1ly8BrRoiqt/xfpZnhAe+utUPfS
	f65he/zm6bfyHqxjsLgvLfTGZuzKPmkXnOWTYGML5RaqXTzDebgeFrR22U8Z0vayhViCpVDXWYG
	RD40Q1L2Czz2eMDdb4K5O0ILIHO7ES6tSPV1rKIB1mz59ntiRkZvtvNjT1GbYSousTSIGjE1tgc
	CAwTFllLxCV6HI5Na7B2j6OMN8yIiXS4yt/+df
X-Gm-Gg: AeBDievjhzLOhP1EvOPwI7Anu5qJ5l+mjaeAhca4o0xM0OntDdtSL60/g3rbdGDYdFs
	2R9F96i8f4GwHEbzyXvrqvK7lOfjw7B/lvB90pO27OI5NWBPURMXfdf+JS4pjDMYFpy+mUnOYJ4
	rZOn6OIHIfe3e8cWCIqpoEDV/Q6+X518rlScedJI/9m/OgIMVt2lBIBUORZWwGSp9gR/Upv+UwT
	5pUPHme1tIFqiGLxZ/A9nNIekwCUjW02Kh1He/VHagcx1Q5sZQVCLp3zA2pQ4lPxn4CibMe+Csc
	tsaoBA==
X-Received: by 2002:a05:6102:6a92:b0:605:8280:5e6b with SMTP id ada2fe7eead31-630f8fda840mr2980734137.16.1778101832519;
        Wed, 06 May 2026 14:10:32 -0700 (PDT)
X-Received: by 2002:a05:6102:6a92:b0:605:8280:5e6b with SMTP id
 ada2fe7eead31-630f8fda840mr2980722137.16.1778101832091; Wed, 06 May 2026
 14:10:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429175016.7915-5-djeffery@redhat.com> <20260506182801.GA805231@bhelgaas>
In-Reply-To: <20260506182801.GA805231@bhelgaas>
From: David Jeffery <djeffery@redhat.com>
Date: Wed, 6 May 2026 17:10:19 -0400
X-Gm-Features: AVHnY4IXvba8Tz17dkRY5kRjhQZN70nrQGJ8xeOK7b1DB0TCF0AP8sKV7dUTWys
Message-ID: <CA+-xHTFj_J4r2oqG8cPOU_wx7pChjHt9SgyHzKbTD8+KgeSFXw@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI: Enable async shutdown support
To: Bjorn Helgaas <helgaas@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <tatashin@google.com>, =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>, 
	Jordan Richards <jordanrichards@google.com>, Ewan Milne <emilne@redhat.com>, 
	John Meneghini <jmeneghi@redhat.com>, "Lombardi, Maurizio" <mlombard@redhat.com>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, Laurence Oberman <loberman@redhat.com>, 
	Bart Van Assche <bvanassche@acm.org>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	John Garry <john.g.garry@oracle.com>, kexec@lists.infradead.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 2:28=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Wed, Apr 29, 2026 at 01:50:15PM -0400, David Jeffery wrote:
> > Like its async suspend support, allow PCI device shutdown to be perform=
ed
> > asynchronously to reduce shutdown time.
> >
> > Signed-off-by: David Jeffery <djeffery@redhat.com>
> > Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> > Tested-by: Laurence Oberman <loberman@redhat.com>
> > Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
>
> I'm concerned about tripping over driver issues, but it's a pretty big
> benefit.  I think it's worth mentioning the "async_shutdown" module
> parameter somewhere in the commit logs and putting an example in
> Documentation/admin-guide/kernel-parameters.txt.

Sure, I can see about adding a document patch to it.

> Might even consider keeping in -next for a cycle+ and targeting v7.3.

I would be happy for it to spend as much time in linux-next as needed
for people to be comfortable with the risk of odd interactions with
all the pci drivers it will indirectly impact.

But I must admit my ignorance with some of the details of linux-next.
Looking at the main code changes, the patchset would seem to want to
go through driver-core to get to linux-next. But as far as indirect
impact, it is the diverse collection of devices and drivers under PCI
which are most affected by the changes. Is there a consensus on how to
steward a patchset like this one into linux-next?

David Jeffery

