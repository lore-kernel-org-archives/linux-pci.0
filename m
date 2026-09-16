Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1714139CCEF;
	Wed, 16 Sep 2026 18:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583144; cv=none; b=AsxkWTBeVUCzxTvA7GKH1LmDXwW9amuNUu0sLIdiEcSiLgkFvZrKiE0dZfSkH61ou+/4pHiGNWHBP/LDvKixFqig5kxtgDbebT/0E1YG5r/AUp0fYPpAb5f+scyPXGb+9ICLn2uq7WBqKCoYStZKso4zmL0H1enXQzXJln0Tdhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583144; c=relaxed/simple;
	bh=WUnsJ15a2vdfFZJ3QbecQA7JQTVQ1yWYiCwe5jCkPXw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TrkPC7bzPjSeEQacKyL6M8sOr6JunSITN2fEu3W/j0T5U1yAsmmjBKbdTTSO4tJ060phRvuONIrJBn36N1vYIRQjti/2f8+odgM/7b5lKFhegVj5HEREoTDqg8sE4/kSdTYCsgg4z5KPe1UOtSHKovxCa8f9ArxNT6pJiwMXwBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2xA7D7z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2xA7D7z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE651F000FF;
	Wed, 16 Sep 2026 18:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583119;
	bh=Va42xDUxw3Ha13QgHOlSJnNxTf47U1kOlLIt+P89At4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=P2xA7D7zGPKwhboQgFoFmwpysEtGxI+V2h2GSj6IA/YgBa85bMaQLxzaFxULINGed
	 AEtc+voU6gqXMDlIskNI09FqisQhKRMmOWkHdE/pPbS4SJuP5YF0zkGANb07pGkKVP
	 qqfO/yR7DeItPjTJiYP+hYLH9jbp4YLqDtxavkvkfhVzgCWjsJYlV5//6kBpAC+Imm
	 BzUA36PrUrZwSPeHUiUOhw4Tvq9qAJ+G0AstgyZKggDzIiowzZ/GoYjNGP6iEhFzM4
	 4g4Q2Mc5YTibk/b+yFZDTdx+Uz5RgNDkfi244moTiPV8DsAQ1jLin/jFLYmuX5gUz8
	 OQPGZJUyOVkPg==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>,  kexec@lists.infradead.org,
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
 Shrivastava <praan@google.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Saeed Mahameed <saeedm@nvidia.com>,  Samiullah Khawaja
 <skhawaja@google.com>,  Shuah Khan <skhan@linuxfoundation.org>,  Vipin
 Sharma <vipinsh@google.com>,  William Tu <witu@nvidia.com>,  Yi Liu
 <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
In-Reply-To: <CALzav=eX0gVrbWCnYGwfqPHUkoVxqdr2nw3Tx6Aqze0XOcuwzA@mail.gmail.com>
	(David Matlack's message of "Wed, 16 Sep 2026 10:28:52 -0700")
References: <20260728221007.2098560-1-dmatlack@google.com>
	<20260728221007.2098560-4-dmatlack@google.com>
	<e099cbaf-3185-4c39-ae36-7f0e074ebff7@linux.dev>
	<CALzav=eX0gVrbWCnYGwfqPHUkoVxqdr2nw3Tx6Aqze0XOcuwzA@mail.gmail.com>
Date: Wed, 16 Sep 2026 20:25:12 +0200
Message-ID: <2vxzcxud6ol3.fsf@kernel.org>
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

> On Tue, Sep 15, 2026 at 8:31=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev>=
 wrote:
>> =E5=9C=A8 2026/7/28 15:09, David Matlack =E5=86=99=E9=81=93:
>
>> > CONFIG_64BIT is now required to enable CONFIG_PCI_LIVEUPDATE so that t=
he
>> > domain and bdf can be guaranteed to fit in an unsigned long and be used
>> > as the xarray key.
>
>> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> > index 3781e2b5f095..8af20f558086 100644
>> > --- a/drivers/pci/Kconfig
>> > +++ b/drivers/pci/Kconfig
>> > @@ -273,7 +273,7 @@ config VGA_ARB_MAX_GPUS
>> >
>> >   config PCI_LIVEUPDATE
>> >       bool "PCI Live Update Support"
>> > -     depends on PCI && LIVEUPDATE
>> > +     depends on PCI && LIVEUPDATE && 64BIT
>>
>> One question about adding 64BIT to the dependency:
>>
>> As I understand it, enabling CONFIG_64BIT essentially means that we are
>> building a 64-bit kernel, and a 32-bit architecture cannot normally
>> enable CONFIG_64BIT.
>>
>> If that is the case, would depends on 64BIT be necessary here? Or is PCI
>> Live Update already inherently restricted to 64-bit architectures by the
>> existing LIVEUPDATE/architecture configuration, so that this dependency
>> would be redundant?
>>
>> If this problem has already discussed, I am very sorry about this.
>
> The necessity is that the PCI core needs to store more than 32-bits in
> the unsigned long xarray key (see the snippet above). The dependency
> on CONFIG_64BIT ensures that unsigned long is big enough. We could
> probably remove the dependency but I would rather wait until someone
> with a 32-bit build has a real use-case for using PCI_LIVEUPDATE
> before putting any effort into it.

KHO or live update themselves don't support 32-bit platforms and there
are no plans to do so either. So I don't think you even need to have a
dependency on 64BIT in PCI_LIVEUPDATE. Only 64 bit architectures define
ARCH_SUPPORTS_KEXEC_HANDOVER, so PCI_LIVEUPDATE and others indirectly
inherit the dependency.

If you'd like to be extra safe, then probably you should add a
dependency to 64BIT in KEXEC_HANDOVER directly. Though I think that can
be a separate patch independent from this series.

--=20
Regards,
Pratyush Yadav
