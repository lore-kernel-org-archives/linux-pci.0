Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEBB3E1CFB;
	Wed, 16 Sep 2026 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585155; cv=none; b=Edgy3ctmhWkox11dulrgXcabRCxcMRGx/hqnGLlAwihxhPtOfo6O+QfB88UcAyzGaQPEk5E4k0u7QmiVKkwbPlADP+PxD30el/bHGzJGBynylf7rOOXNswCXfktKOIMM35qaZQF0n9xvRrgODk6wHOqMMF3nmM0aIrN9mGq/Upc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585155; c=relaxed/simple;
	bh=VSWJFFyILOifULHYldTAkG+40oNQYoyuQxpyJOfRaKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sZE8xUMgmo14lHpVXXuQdg/5bTlwK0c7i2oUvs6EdZD7zjYzkVyrNymqGhFdKZ6pSQIINVutKWx3/gTPZ2C9OKHFmqsKT1+MfuEN4SN2T2P3EVffNSTQG+mn/UNbjmmdTSbSpeDUZXju4heEt55KE5iTrVqm2pPh+mnSPkm5yVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpKfeOdn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpKfeOdn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575CF1F000FF;
	Wed, 16 Sep 2026 18:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789585127;
	bh=lSvr0vCtdCumQova2+QTaGAW1CeluERBIU1FmP9NgV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=dpKfeOdnhJbQOBnw3SyHypTt1bwo3khu9OjlnaFMto0eI+LryvCcytPSjazdhOHUR
	 s4du1cwq3DXECxApHbs7cf/wMeptDnEdlt2Pclae5BtOwLmGVkqOmtMcI0ZzkNUwTL
	 9YWSexTWum8n8WNCqEbnlTR40tO0Qrml0kRiC5M5x+wSbM14AnTazL5yCSRNfjugqy
	 JCXx1cKYMi8Z3Tti0pRbkYFQY0g9nmG5XSSThdECoh5+J5VCB4MTJdVcYvfjECDfap
	 FnkMzxpiuQfqYa0TZAX1sbBJEKIfu8jryKFSikfQZ4dfSWI8Qw0+FhRqLQhSc0p5xy
	 mjrO8itBp9hWg==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Zhu Yanjun
 <yanjun.zhu@linux.dev>,  kexec@lists.infradead.org,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  linux-pci@vger.kernel.org,  Adithya Jayachandran
 <ajayachandra@nvidia.com>,  Alexander Graf <graf@amazon.com>,  Alex
 Williamson <alex@shazbot.org>,  Bjorn Helgaas <bhelgaas@google.com>,
  Chris Li <chrisl@kernel.org>,  David Rientjes <rientjes@google.com>,
  Jacob Pan <jacob.pan@linux.microsoft.com>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Jonathan Corbet <corbet@lwn.net>,  Josh Hilke
 <jrhilke@google.com>,  Leon Romanovsky <leonro@nvidia.com>,  Lukas Wunner
 <lukas@wunner.de>,  Mike Rapoport <rppt@kernel.org>,  Parav Pandit
 <parav@nvidia.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pranjal
 Shrivastava <praan@google.com>,  Saeed Mahameed <saeedm@nvidia.com>,
  Samiullah Khawaja <skhawaja@google.com>,  Shuah Khan
 <skhan@linuxfoundation.org>,  Vipin Sharma <vipinsh@google.com>,  William
 Tu <witu@nvidia.com>,  Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
In-Reply-To: <CALzav=eBXsaZKNv1SNtuT9F6aX_2TS3u5kUtko5WMv2NWt3e+A@mail.gmail.com>
	(David Matlack's message of "Wed, 16 Sep 2026 11:31:17 -0700")
References: <20260728221007.2098560-1-dmatlack@google.com>
	<20260728221007.2098560-4-dmatlack@google.com>
	<e099cbaf-3185-4c39-ae36-7f0e074ebff7@linux.dev>
	<CALzav=eX0gVrbWCnYGwfqPHUkoVxqdr2nw3Tx6Aqze0XOcuwzA@mail.gmail.com>
	<2vxzcxud6ol3.fsf@kernel.org>
	<CALzav=eBXsaZKNv1SNtuT9F6aX_2TS3u5kUtko5WMv2NWt3e+A@mail.gmail.com>
Date: Wed, 16 Sep 2026 20:58:40 +0200
Message-ID: <2vxz5x056n1b.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16 2026, David Matlack wrote:

> On Wed, Sep 16, 2026 at 11:25=E2=80=AFAM Pratyush Yadav <pratyush@kernel.=
org> wrote:
>>
>> On Wed, Sep 16 2026, David Matlack wrote:
>>
>> > On Tue, Sep 15, 2026 at 8:31=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.d=
ev> wrote:
>> >> =E5=9C=A8 2026/7/28 15:09, David Matlack =E5=86=99=E9=81=93:
>> >
>> >> > CONFIG_64BIT is now required to enable CONFIG_PCI_LIVEUPDATE so tha=
t the
>> >> > domain and bdf can be guaranteed to fit in an unsigned long and be =
used
>> >> > as the xarray key.
>> >
>> >> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> >> > index 3781e2b5f095..8af20f558086 100644
>> >> > --- a/drivers/pci/Kconfig
>> >> > +++ b/drivers/pci/Kconfig
>> >> > @@ -273,7 +273,7 @@ config VGA_ARB_MAX_GPUS
>> >> >
>> >> >   config PCI_LIVEUPDATE
>> >> >       bool "PCI Live Update Support"
>> >> > -     depends on PCI && LIVEUPDATE
>> >> > +     depends on PCI && LIVEUPDATE && 64BIT
>> >>
>> >> One question about adding 64BIT to the dependency:
>> >>
>> >> As I understand it, enabling CONFIG_64BIT essentially means that we a=
re
>> >> building a 64-bit kernel, and a 32-bit architecture cannot normally
>> >> enable CONFIG_64BIT.
>> >>
>> >> If that is the case, would depends on 64BIT be necessary here? Or is =
PCI
>> >> Live Update already inherently restricted to 64-bit architectures by =
the
>> >> existing LIVEUPDATE/architecture configuration, so that this dependen=
cy
>> >> would be redundant?
>> >>
>> >> If this problem has already discussed, I am very sorry about this.
>> >
>> > The necessity is that the PCI core needs to store more than 32-bits in
>> > the unsigned long xarray key (see the snippet above). The dependency
>> > on CONFIG_64BIT ensures that unsigned long is big enough. We could
>> > probably remove the dependency but I would rather wait until someone
>> > with a 32-bit build has a real use-case for using PCI_LIVEUPDATE
>> > before putting any effort into it.
>>
>> KHO or live update themselves don't support 32-bit platforms and there
>> are no plans to do so either. So I don't think you even need to have a
>> dependency on 64BIT in PCI_LIVEUPDATE. Only 64 bit architectures define
>> ARCH_SUPPORTS_KEXEC_HANDOVER, so PCI_LIVEUPDATE and others indirectly
>> inherit the dependency.
>>
>> If you'd like to be extra safe, then probably you should add a
>> dependency to 64BIT in KEXEC_HANDOVER directly. Though I think that can
>> be a separate patch independent from this series.
>
> It should be in both places then. PCI_LIVEUPDATE explicitly requires
> 64BIT for its own use of unsigned long, so it should have an explicit
> dependency. If KEXEC_HANDOVER requires 64-bit for its own specific
> purposes, then it should have an explicit Kconfig dependency as well.
> That way if and when someone wants to add 32-bit support we know
> exactly which configs need to add support.

Well, I don't think we are ever adding 32-bit support. Most 32-bit
support in the kernel is being deprecated or removed, so I really don't
think it makes much sense to extend KHO/live update to 32-bit
architectures.

But anyway, if you'd like to explicitly mark PCI as needing 64-bit, that
sounds fine too in the very very unlikely event we do add 32-bit
support.

--=20
Regards,
Pratyush Yadav
