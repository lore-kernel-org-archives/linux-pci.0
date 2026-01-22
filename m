Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C3A3AEF54
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 23:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769124672; cv=none; b=gEspbLb9FfimEIw8t5RFALF/Tf1J2AY9JA1K09XGBsur2H8Nc1X0v0a4sDW3ZkyZvBc6sFXA51F05U516nlz6bTV6f75OXDmRjDZFKV/xQfVuaaL2gP2HfkLZbqI+xLT0kt7B82rO/K/93hI773GV/o9iuXUS6UbcVD+q3FnXiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769124672; c=relaxed/simple;
	bh=5WAixKHmsIvyis6YTtmuBV+gDtWyY2eKW0sd3IU1DQA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lx5OiEAw2rbAwR09Z+jIPoa1C53luPrzzUPqrFitSz+VIBZ/b5T3hAfGej2u1gJ5OAhG9BWf6idSO7slhxSTyWQArx3EJ0weAxO4UmrcSVR8kGIepYuOVFrvrfRkR811zS5VeMe9Tcxu2yvXfTsXSiSc97XnNTxO25UNz24wsUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HXe57wHu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDmvoKax; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXe57wHu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDmvoKax"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769124667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q3W7z6eAd14Mjwit6iOIu08lrtGt6c3kP9td1eyShu8=;
	b=HXe57wHuysjbmUgf2gvZPc7pJVP9wyMeHKJmDdi5OAcb0XnWU2V/lFTnlUeJhKAyiG92iA
	EWchYoQNKMt9+sPS1sPNuEavxv4VN8VhK0MOJsioJZWTJsRJ4KD/IvS7ZITWb/EHxR16ub
	Ra+7CZmieTpEam6e3xF26RQhUTgVxNA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-yHS-XjHCMp2Hkbx1k5Gc8Q-1; Thu, 22 Jan 2026 18:31:05 -0500
X-MC-Unique: yHS-XjHCMp2Hkbx1k5Gc8Q-1
X-Mimecast-MFC-AGG-ID: yHS-XjHCMp2Hkbx1k5Gc8Q_1769124665
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c6a69b7813so399176085a.0
        for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 15:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769124665; x=1769729465; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q3W7z6eAd14Mjwit6iOIu08lrtGt6c3kP9td1eyShu8=;
        b=bDmvoKaxaPQg1t/R86VbGhPVCQdSNuI0XRy/37oUO5B8kR16VUNGSvRYNJOzaFecIO
         pLP2szOqa+HLNAH1/wrKelp/Eu+cZ0nMitjT/176mHqUkovAFNaFednNCt7bcSdDWXY0
         F1yQ2zdmq9wB1tllgnPeDRrtvy9qX7WqapD5NuMtXRPtFXpANJOTVqTyFrLOW5VBIh3q
         Ak2y5JXkqH69NzqY65EWF3bl/N0HrOYt+7zu8oXufKzBpxaBLCN0nGs4sdVme0NTN56t
         ltNeGCFMCEtdtdipmmci59PCt3BJQyuYheJe42yXcpv3Onq7wCwk3YZUhTM+V4KjMmMO
         PnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769124665; x=1769729465;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3W7z6eAd14Mjwit6iOIu08lrtGt6c3kP9td1eyShu8=;
        b=VIZhYnirLYfTrVPAbbtZt4rAN6KLRFv+9XDSFiM78txF2ppfFqhJ7Hb5ZR82bTx2oz
         72423PdkIvcoRsytvNfBsuV0+OomboaIEkMbvbe1IYBdzqYP0tPrLjH3AkNVogWF+Rfb
         Ontq5ZVLgxX13PoCxSASiTqchJw8KBPL7PqsGbGu3/vSUhhqa6yR3asxuak8h+WDVG6V
         7Vd+UtVetq9R0vdWO496hCp7wtvdTg5I2eL7UZ+s75BznLHf2VpWfV3Zdqq/3AxBYaMi
         Glq9KWgTRjnOp6WqKCaE2HMw4M1EC/PTkD226oGs4BluzHOaQ83LI75wPXSc+apFgRoV
         C4dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfvbklPMOY7mWb44W4oeeXqE7wDIOq08lbsBeCvk7KO8+30XCU/oXEVzVE4S0ECYdieAT8HF3imyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsifMmu5xiUtkTHxHXmZyjoN38s9/x2egUsfg+vPbIAupvNbEV
	nm9wFk6nu6Fr5OueUDdTN5rwG35P5eVSG68q5A1oJ8iyxiM+h/Ydj8BeLXT5wzdR76ByQt+oysp
	/4jUklLkahnR1uT8GiNhgnqSSEFoZ+7Qr4a76bvglRYP8A+m/NuJMXRPtFNeg6w==
X-Gm-Gg: AZuq6aJG09TQFPs6s30YvO0UhDVYxRP1hSNYBILQNX5DuIgrJOkUyO+Ac28jwQxM45F
	psPJ9wYZs2meZlYOeZI+KkTCWQN9qY0PDwHd2t9bJa9RTPche9VEuVC/lGSIpG3skSkHi6zV6yL
	50I684iNmGX0/8p5cYU2xdPI5DMJ71C8VUTKMKPqSrYBIMHWkK5nxd0fUSELlHfiJBo+PWD2F2T
	LKCwGDVGn/lnwOkSxWaROLcLQfj7WkO7uykDluHVEh2P2THC63Ir4+nGnYNWIQWedaue1kvshAX
	NioKAFJ6LWv2N/oV8Z5RnpjpQ30BwgcMevgIYh/e42Hh0D14oqN3PYSbW9jpoHCFNThcBsSVAjz
	AoitYTmrlKLRSJ2u41EKhIGVEqPqHWRKvJTXrJ427YFH2EpglHek0/fAFEYGTGsbtNpEUz3fktP
	lz/A==
X-Received: by 2002:a05:620a:17a8:b0:8c5:390b:6eb4 with SMTP id af79cd13be357-8c6e2e2df7cmr161055485a.42.1769124664525;
        Thu, 22 Jan 2026 15:31:04 -0800 (PST)
X-Received: by 2002:a05:620a:17a8:b0:8c5:390b:6eb4 with SMTP id af79cd13be357-8c6e2e2df7cmr161050285a.42.1769124664062;
        Thu, 22 Jan 2026 15:31:04 -0800 (PST)
Received: from thinkpad-p1.localdomain (pool-174-112-193-187.cpe.net.cable.rogers.com. [174.112.193.187])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37c8fa6sm45616385a.4.2026.01.22.15.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 15:31:03 -0800 (PST)
Message-ID: <96c9d483f67be02fa1dba736fea465216d0c3269.camel@redhat.com>
Subject: Re: [PATCH v3 3/3] PCI: dwc: Enable MSI affinity support
From: Radu Rendec <rrendec@redhat.com>
To: Jon Hunter <jonathanh@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>,
  Manivannan Sadhasivam	 <mani@kernel.org>
Cc: Daniel Tsai <danielsftsai@google.com>, Marek =?ISO-8859-1?Q?Beh=FAn?=	
 <kabel@kernel.org>, Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
 Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	 <kwilczynski@kernel.org>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Jingoo Han	 <jingoohan1@gmail.com>,
 Brian Masney <bmasney@redhat.com>, Eric Chanudet	 <echanude@redhat.com>,
 Alessandro Carminati <acarmina@redhat.com>, Jared Kangas	
 <jkangas@redhat.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,  "linux-tegra@vger.kernel.org"	
 <linux-tegra@vger.kernel.org>
Date: Thu, 22 Jan 2026 18:31:01 -0500
In-Reply-To: <cfe44924-3419-4f31-8ab3-87b769d21a5b@nvidia.com>
References: <20251128212055.1409093-1-rrendec@redhat.com>
	 <20251128212055.1409093-4-rrendec@redhat.com>
	 <4e5b349c-6599-4871-9e3b-e10352ae0ca0@nvidia.com>
	 <a8d841e870d6dbbabef7eadb774f2a58a96c57c7.camel@redhat.com>
	 <cfe44924-3419-4f31-8ab3-87b769d21a5b@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jon,

On Wed, 2026-01-21 at 14:00 +0000, Jon Hunter wrote:
>=20
> On 20/01/2026 22:30, Radu Rendec wrote:
>=20
> ...
>=20
> > > So it looks like it is hanging when disabling the non-boot CPUs. So f=
ar
> > > it only appears to happen on Tegra194.
> > >=20
> > > Let me know if you have any suggestions.
> >=20
> > Ouch. I'm afraid this is going to be much harder to figure out than the
> > previous one, especially since I can't get access easily to a board to
> > test on. I will try to reserve a board and reproduce the bug.
> >=20
> > Meanwhile, if you (or someone else in your team) can spare a few cycles=
,
> > could you please try to reproduce the bug again with the debug patch
> > below applied, and a few other changes:
> > =C2=A0 * enable debug messages in kernel/irq/cpuhotplug.c;
> > =C2=A0 * save the contents of /proc/interrupts to a file before suspend=
ing;
> > =C2=A0 * add "no_console_suspend" to the kernel command line (although =
it
> > =C2=A0=C2=A0=C2=A0 looks like you already have it).
> >=20
> > It will be much more verbose during suspend but hopefully we can at
> > least figure out how far along it goes and how it's related to the MSI
> > affinity configuration.
>=20
>=20
> Thanks. I have dumped the boot log with the prints here:
>=20
> https://pastebin.com/G8c2ssdt
>=20
> And the dump of /proc/interrupts here:
>=20
> https://pastebin.com/Wqzxw3r6
>=20
> Looks like the last thing I see entering suspend is ...
>=20
> =C2=A0 irq_chip_redirect_set_affinity: irq 162 mask 0x7f
>=20
> That appears to be a PCIe interrupt. Let me know if there are more tests=
=20
> I can run.

Thanks very much for running the test and for the logs. The good news
is good ol' printk debugging seems to be working, and the last message
in the log is indeed related to dw-pci irq affinity control, which is
what the patch touches. So we're on to something. The bad news is I
can't yet figure out what's wrong.

The CPUs are taken offline one by one, starting with CPU 7. The code in
question runs on the dying CPU, and with hardware interrupts disabled
on all CPUs. The (simplified) call stack looks like this:

irq_migrate_all_off_this_cpu
  for_each_active_irq
    migrate_one_irq
      irq_do_set_affinity
        irq_chip_redirect_set_affinity (via chip->irq_set_affinity)

The debug patch I gave you adds:
 * a printk to irq_chip_redirect_set_affinity (which is very small)
 * a printk at the beginning of migrate_one_irq

Also, the call to irq_do_set_affinity is almost the last thing that
happens in migrate_one_irq, and that for_each_active_irq loop is quite
small too. So, there isn't much happening between the printk in
irq_chip_redirect_set_affinity for the msi irq (which we do see in the
log) and the printk in migrate_one_irq for the next irq (which we don't
see).

My first thought is to add more printk's between those two and narrow
down the spot where it gets stuck.

I think the fastest way to debug it is if I can test myself. I tried to
reproduce the issue on a Jetson AGX Orin, and I couldn't. By the way,
how often does it hang? e.g., out of say 10 suspend attempts, how many
fail?

I do have access to a Jetson Xavier NX (in theory) but it looks like
there's a lab issue with that board, which hopefully gets sorted out
tomorrow. If I can't get a hold of that board (or can't reproduce the
problem on it), I may ask you to try a few other things. In any case,
I'll update this thread again either tomorrow or (more likely) early
next week.

--=20
Thanks,
Radu

