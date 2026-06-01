Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9781E366DA3
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780332899; cv=pass; b=XVpeetRuiKj2evzkrcqkuySbe4XX+78Kre8TmSGvxwOkncNa27LW7R2pTqNS+8J+n7DMbepZT/rSvtql8fvlu07rXbGu44LCqRrlj2qdlxDEocObmRJLq5kMIKn7ZCoBSPsk3rUu8bpjRVzPTQ444Tv28YBqMZTFPYhHkGk8q1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780332899; c=relaxed/simple;
	bh=0e7u8ODv5hGAN3SwrIVi3OVbVFu5joHm/GWqQlQCsiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZ5ZOEH2eBQe2qH74I1pu/ghfqJBGfUct3NIbFb1GFrQwnS+o4KJ8IS8xbgHNhCFPTUA9FEBrra8hzBWPPtZ5SdEMCrU0QmZWS3+QIV3sho/x/PLOpktqw2IdfzKWU6mR9LHeT0DqXpsVQoRI+VumFALIzeuGr1hECAMqNDIT2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqAM49f1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=J0HX1AoD; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqAM49f1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0HX1AoD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780332897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0e7u8ODv5hGAN3SwrIVi3OVbVFu5joHm/GWqQlQCsiU=;
	b=SqAM49f1CijyAxTLKqCZEa+VFjjHw1wLmdw+PI0W3jQqNEN/p1OecSMCXAc4Zk+PaToqKA
	2UkTIsM7YV5ml5MEry5h8Qiep52q21uJPS+5SH+UGUL8XJbY+4b2ySELFuLZ7LdgL6jIdL
	XCAoqUsKlbP0EFcVs9MqdGAc/dmd+tM=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-UZ5XmSzRNwO3T4cvbW1LMA-1; Mon, 01 Jun 2026 12:54:56 -0400
X-MC-Unique: UZ5XmSzRNwO3T4cvbW1LMA-1
X-Mimecast-MFC-AGG-ID: UZ5XmSzRNwO3T4cvbW1LMA_1780332896
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6c33d75153dso961917137.0
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 09:54:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780332896; cv=none;
        d=google.com; s=arc-20240605;
        b=dM48xmuRgx807OPHLzQpjkuMTWjXzIshdhUvMsuwjvCFq5Ddfes0V5o8AXRLLvBc/R
         1coxhizhOB468BZ4TXumtW/bUrvwQPJj1ahH9UexZTJLMytf9yBKWftXcFsIsuEVaJv4
         o7B8JRx72XYjPEIBrTCyqILI8vJkdQhQt7er0xYsU90LWW5cUS5j32xabnG+69FbBG8I
         /X+oayfExHS477pqYMGbXF+Ed7bD2yQR47bJSiAYjRnPUPKa6YssfvTdSqpjh5uxAdY0
         GKHPDKDrVhzsHn89eu5PB55amzhfSszJXO17jShE/6WhhXl4SP+urj3D9KvFecch6Sn9
         kktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0e7u8ODv5hGAN3SwrIVi3OVbVFu5joHm/GWqQlQCsiU=;
        fh=WhvoA/sn6fg/sXJZ2irYcAuDKUa4QBJgAzEjmIh9MRQ=;
        b=M59TgHW4a2N0vDA09+LOqkjf6AHJic8ACPv35/tzd0YEDW798uEabIe49DoQw9g/g8
         /wPkg/pLVhAK0p0QxlUQWxx7QBkGdqlsVaXFyCeU6iK0+V5frZq2envSsPSpAKCxoH9u
         j7QK+q3ZprirOZO0O4pyfUUFnQPR27HK5nRCZtrMcKI316OQNK0Ur5TnSbsrw8+XHILx
         g7cor0D6Jkw1cRnO2rR4MSs7nmyiIpvTjtId+9VDZZJL1UDcTTSY4Wt/F/NUVijDxYF7
         DXmon2+PEIXIEjdS7w/R0UohuhWs/AENSQEd+pEO3ESuZIDwgwQu6Jy3meMCFpoZ8+kW
         WVyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780332896; x=1780937696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0e7u8ODv5hGAN3SwrIVi3OVbVFu5joHm/GWqQlQCsiU=;
        b=J0HX1AoDeVOxNSBiVzNn9uDVmULOqZ90utszohtkv3W5QeQTflsrwgRYlMADl+J/jh
         SmkQw6NMu2Kmk4iABYTjAo+AnSGtm92DUNaU8ITg2lJOlbrDPZsD9lq0yo4YdT0xGtpb
         UfbpyhUBwtDl03On45DaG+0Xa65vlLGh7dS1IfT5cZlSBvh6opHI6bXkfkRVSG8booD7
         HxaKE+79KXmgtNGab6TovSFiK8+J2hROZREYXxUCAX4HAKtIvc4WMEddnhXTDPGVpB7o
         hzxolkMnaUvVR4PBj2gAcV/We8r+SbZcyIl9OINZuYJFnLLYVlUnOXUMQYLd0rjGflqq
         2ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780332896; x=1780937696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0e7u8ODv5hGAN3SwrIVi3OVbVFu5joHm/GWqQlQCsiU=;
        b=KJqdtPDyMlcbYZ8AilapIoRwkS80wxHA8npEUJc9QL3a5pbOvVFoGYo6K4aOIC2Z+M
         tpvdbwk5PN+JfNeuLO1gqQHofUtZgu41IsLUMux6rqz7LLo3UsTustrGk5WpTD2iukHj
         LowrNq5lBt+Z1lO+cOwrSkpnXDb7jJZeaM0ZVBgDvRt7a+4hFXLJI6sgszxVhrusw0xw
         avsIff4dYGofD3HP+M8Ct/lwgS3YFEA03Yq9RCx+i0rXAuHzOmEqVqmKcDH7A47m+ICT
         lNZgcdIUYXWL5yVb3/MNtHAzY8QuhO+xpOUgkbLa++msleK0ykntl8iK+0SJt6qweDLQ
         uCfg==
X-Forwarded-Encrypted: i=1; AFNElJ91qWwVbVIo3kQwiIllh+4s7aq2kM84ttdhIEVSXOllEPYFlCfQJC3CUhjJ4KJZOaeG/+Qmjb4vqQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydfja1w6W7Hsz3T3XL2kVGon6N2O0LnLOXb8zZNRkUbC8Hz1Qs
	EnP4aOJsr9im72JjQ87PYYJH40q/XMZ7C1PCRjTJKoo9DCJgr7v5JkQLJKS3fQu1j9itgKuCePI
	Z5Q/zKvNVS/TRPGgLmi5L8mRX888zpQZmE0ZfbTXNQWBUoYKFCPAZg+j5NHZTRk25fySvJy3bs2
	T8W0DnMhrz0aMEExllQi4KdgxfC0HDVhkGY49K
X-Gm-Gg: Acq92OEXK3gjtxzVOtOoFYh80fg5upCujELnzmRgbCWZp2aw8RgYjLokaLWrjSqEbEi
	F9ZADiK70+wSGjVmYmHY6V+HNvbE3MZBloT7OEhC1AdmZn2yFwZjkoP03kaXjKEaZfyb8b1NlLl
	ltzfP8RtVZm+mklH59Tg59ku+AVXJbOpJYOTe3UvVMHaX19bqgsWKY6MrUf72I6NI874p5e2sBC
	iXBzW3emQmxYF5VRWSgGEB/4Y+qj/RvGfyllWcPN/MVzIReXexPJ6ETFMVOIONUx2WpRlk=
X-Received: by 2002:a05:6102:41c1:b0:6d3:aad5:6d2d with SMTP id ada2fe7eead31-6d3aad571d5mr1975295137.18.1780332895716;
        Mon, 01 Jun 2026 09:54:55 -0700 (PDT)
X-Received: by 2002:a05:6102:41c1:b0:6d3:aad5:6d2d with SMTP id
 ada2fe7eead31-6d3aad571d5mr1975273137.18.1780332895334; Mon, 01 Jun 2026
 09:54:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518193204.14273-1-djeffery@redhat.com> <DIXT3WV9XAWK.3E0JOPV2K6NC1@kernel.org>
In-Reply-To: <DIXT3WV9XAWK.3E0JOPV2K6NC1@kernel.org>
From: David Jeffery <djeffery@redhat.com>
Date: Mon, 1 Jun 2026 12:54:42 -0400
X-Gm-Features: AVHnY4JlEP4O7SvjLzcCS-aNG7BrnY8TX1LnwVykV7UvnzLu5Qi3VLZ62Fw9ZAA
Message-ID: <CA+-xHTGSuo-i872=-SG5pf+xGAN71TDQ=5f-H0kuv9g8G3uqZA@mail.gmail.com>
Subject: Re: [PATCH v16 0/5] shut down devices asynchronously
To: Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tarun Sahu <tarunsahu@google.com>, Pasha Tatashin <tatashin@google.com>, 
	=?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>, 
	Jordan Richards <jordanrichards@google.com>, Ewan Milne <emilne@redhat.com>, 
	John Meneghini <jmeneghi@redhat.com>, "Lombardi, Maurizio" <mlombard@redhat.com>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, Laurence Oberman <loberman@redhat.com>, 
	Bart Van Assche <bvanassche@acm.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, John Garry <john.g.garry@oracle.com>, 
	kexec@lists.infradead.org, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 11:10=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Mon May 18, 2026 at 9:31 PM CEST, David Jeffery wrote:
> > These patches are now rebased against the driver-core tree's driver-cor=
e-next
> > branch.
>
> [...]
>
> > Changes from V15:
> >
> > The async_shutdown bit field is converted to a device flags bit Convert=
 all
> > patches to use the flag bit accessor macros to set or check if async sh=
utdown
> > should be used Added documentation on the kernel parameter to control u=
se of
> > async shutdown
>
> Did you have a look at the Sashiko report from v15 [1]? Some of the conce=
rns
> raised seem valid at a quick glance.
>
> (It seems that this version has not been picked up by Sashiko (despite yo=
u
> mentioning they are based on driver-core-next). I'd assume it doesn't lik=
e that
> the series was not sent with '--base'.)
>
> Can you have a look at [1] please?
>
> Thanks,
> Danilo
>
> [1] https://sashiko.dev/#/patchset/20260429175016.7915-1-djeffery%40redha=
t.com

This does look to have found some legitimate issues in need of
correction. I'll get them fixed.

Thanks,
David Jeffery

