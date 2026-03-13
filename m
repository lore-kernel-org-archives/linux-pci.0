Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C50326952
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412093; cv=pass; b=HkpIljRJjqt94MuNLr4aa4yIqKSSYE/EIMXNrw2rfn2SgNz1iEmZCdn5reRs3/bshMiRw6/7WLPKTIF01XYWyRDJ4jm1SfrAKj0v7saYkk0wG4A57/ZtnTaSGjdwbvH9EJRpKm1OnsQGR1Xl5wNRD4/pxKrT2hxigWrUmdMKvSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412093; c=relaxed/simple;
	bh=3DhJJ93cKQQk3SpyT61kIFsBKzCFpwnhRvsErphsARo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z79iEO1BXCV103I8fr/+T4MqXAkz2qDaDQZIRMOarocMhUzXR8YtCce+v5s1VD0kUQkNZuugrZWvaQ6M4gbszAcLuujG03dl69Q5aCG2XkkfVkde+1XaYhrFJ4ZoArpOQi+FNzsQPz/ncgI7qQtTGnOB0C/f9dnyu/hatgvlDWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=YWB87fJu; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="YWB87fJu"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6642c9254c2so1009265a12.2
        for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 07:28:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773412090; cv=none;
        d=google.com; s=arc-20240605;
        b=SM848AODm2mf0hMLFO1+BQnKj5mTauB6hkrYJ4yhrxGZEzqcna3ct+OPw8vpbylmkU
         HslqO3DxE+k3DbhYTDNUv1dEYSRrNhSD49uSurovSn5Npr+vQu2H/zN9PK+ByYLeeJS3
         HPxsiK8s6euLnwg4GP8+S1wfcTTQK0lkkCXaT7gzqruY2QSFYmuEHLHw+SmItDDr+6TV
         UAdi48rWgDuwqiKTTc0v/VvnKt7zw+cAT5Phi/ywrIM7N2jqb6DMXTrN6DzuOrqhywON
         kQgXhAoMDpVB9UmgVkCGoGMC/NdeuSQfxycQ5dzMuQvxgmr+uiVjUQzf5URGHF2/a6eq
         r9lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3DhJJ93cKQQk3SpyT61kIFsBKzCFpwnhRvsErphsARo=;
        fh=roSEUj2Rmvotw7sGh4vjx6/AgatL92Z6pHZkL9tnvfo=;
        b=j26DTTBvT6lqKeJqvilzhL5gJRbQLOWKoHPpWfc1P54KGD6gEZiF9CTHfzwDL6zxwo
         wb28k8f+hwX7U7Y5fDvWAVGzcrNVjThdHGo1rKxGd0ctyHtaSjfSV7AIaxdYviYJZmB9
         S/YP+Rd9GwGZdL7Nwfo+1w7nZmFBNQNfw+tqlUrWU9af1maGow75IdVLMehWY5X5C1fw
         9AyB+BsNMKVnvhyfuwkYjYSUPu/+/G0YRRUYLMPos1T3fHkXirONoT7oJMW++bY9EfR9
         yTMESIy52B3iyo5PJ+iIhVfvxswA5ZFPzNBSVcQJUS2NWK+2dtS65sW7HNCk0P+dFoy0
         2v8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1773412090; x=1774016890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DhJJ93cKQQk3SpyT61kIFsBKzCFpwnhRvsErphsARo=;
        b=YWB87fJu1urKVHYo0MietW1J8yEK9dBucNkODt2BZV7FSS2FrPohmTdi/nTZOWcvzL
         mWwh5Tq08dzYSAwWdFMpHd0JgwR5JJrMJkCNh94LNN+0BcBeR7VGRXO8B76QeamtUgDr
         pxPFHv+LxsPO7Osn3g840JJyjI6LgEKSzuISp9fpgbShhzaikX2bcX8d5+CQ71//B8H+
         w3rs3wMbtcj73jePmfDU1F6X1iH3OLkjbGX6ru6+drlOLnYyNLPJxNfF75eh3oJxxNOc
         b5B/yvERWCKrj3yt1SwhCPJJdJkhPRFb6ytDjFY/QAArmFB90B3Qs2XAB0dFFwgjdnFn
         4Nhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773412090; x=1774016890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3DhJJ93cKQQk3SpyT61kIFsBKzCFpwnhRvsErphsARo=;
        b=UAi++loD73QZQrsRGNEJxueBqLh+RnUGo/NeMMEixTsgKYrci0mkKYqVK7yJPJ/50A
         NPkkxuogQis/fqEaMEN6Fvb3KeG/bud3Q7eK4vmI5FtvKWcex4gTPYpFJylvcPv6JJDx
         QmjcE2+PsoYRT9V3RWen6jlKCzkS9StL7znusTbqCa/BhJQCT+SrUDJhPo+nHq/GwEfn
         e63hPKhdorOs6eDYRIyZSfaG3u24yaki8dYC8xCipxCg54MH61CJc1GXqU19BP93CxDm
         WKVvZionqRYeofjnJMeLha73/YHdaS9LhK38z3NIXpQILH2Yymdmr1t0p/tdRiLBg80C
         ur3w==
X-Forwarded-Encrypted: i=1; AJvYcCWymi80ZLyYbJcwYIzqFxfx867fdpdURTY9LWtchAQf/VYr1lNK6l+d7aNAvx67olIOPMPmxOhyS0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOhkW+20HorjD6pY6u/Es79NGLxkGnmj7eEgH8MxfbiIGIdhMP
	r+KUKdXlU0MufUVZ9Hi9lmnfph5+74VdP8uFoYIuktVJRHNjJuZsJppafm0wwxOLkCRXLrxeXtD
	Een3OZXkdVCWZrolTCjH/WSAoYuC2NAn5tgXqoY85KQ==
X-Gm-Gg: ATEYQzwgkHy052mKkS40qQw5LWObQL2J3LrD3acuVC0ORnh4SE5w3/2EeGDdWnGlJ2y
	a7BC4iT37Zh3Ml+ethX3KP+ZOEGRPXuLsoxe1Kd3fZabgPiQFCEeNum6kFWCAElZPv5Qbthm4Uk
	kFOLP9PXyOZj+aU9D1vDYQ24mVgO56sa5VlAKF/PUVa3/bORdXyidx+LfvbQRCSas0wUD0EPtGb
	OHap4qiAZbh4Pxxi+c07LdscEeOt5LEe0j91h0UeKcTzbmB9PC0DlxsUEA4Ghs0+GdyBOuLwqxZ
	VdhA2zTUhtlqUHEiRyeEqF/njq8xuRfJ5hE1Kg==
X-Received: by 2002:a05:6402:35cd:b0:663:8be1:3649 with SMTP id
 4fb4d7f45d1cf-663ba9b776dmr1936388a12.3.1773412090104; Fri, 13 Mar 2026
 07:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-8-dmatlack@google.com>
 <20260226160353.6f3371bc@shazbot.org> <20260303210733.GG972761@nvidia.com>
 <CA+CK2bDADhFcMVGoJew9RoJ-DsVhYhiZJGJVwfzTBZdGX++8Ng@mail.gmail.com> <20260313122525.GB1586734@nvidia.com>
In-Reply-To: <20260313122525.GB1586734@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 13 Mar 2026 10:27:33 -0400
X-Gm-Features: AaiRm524CkK4OBTNvXFWcAvWcl42dW_YCeYpiFYkXzW17TUn9itgLI7yXbb39d4
Message-ID: <CA+CK2bD2ryZsvgono-5Yg0jwwCa-p55wefT=hn3DRsDJVc0ADg@mail.gmail.com>
Subject: Re: [PATCH v2 07/22] vfio/pci: Notify PCI subsystem about devices
 preserved across Live Update
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 8:25=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Mar 12, 2026 at 08:33:27PM -0400, Pasha Tatashin wrote:
>
> > If there are active sessions (incoming or outgoing) with preserved
> > data, how can we safely unregister while they are in-flight? It is a
> > rare condition, but since the user can cause it, they need to be
> > notified that unloading the module right now is not a good idea.
>
> IMHO blow up the kernel or something in the core code, you can't stop
> module unloading once it starts so it is pointless to propogate this

I see, I will send a separate LUO patches to make unregister functions
return void.

Pasha

>
> Jason
