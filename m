Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDFF20299B
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 00:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362047; cv=pass; b=P4OKrx+bR7XFNmgyriTNhSDSuWz/9O8Tvj/1qeHCGlBE7OVfAnfsG7s2wqc1XluzI0Bgy+KAYVQ+r8+Nzaya+6taoM5wWa2nXrJeQArGHBj4g4sgHtkXEuvOwi5RWSx/pMDmz717NcD5sVBzSZlWHRzTy44FSO/vTCKCsUEjZcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362047; c=relaxed/simple;
	bh=P9DYNvw0pXgKNQlqCuTgX5BsLWxpM/GHGwCmn4gqBFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTjqacm/ymuBgAO+BWQuszGLxjvTpW0IrzU2hpYLvzkFe0+oJfNdM48shnW64K4nhXWoEZDfRyLAxIm9SxE3xamfxwaMnx094c5WkoSps/hGtaQBNGsSLWw+RHkzU1sKXvo00SIs8L3UilKVRlF4uFGijWTP55ypxFzOrE6e/eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Vo4xbcbG; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Vo4xbcbG"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-662dc987dfdso2523253a12.1
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 17:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773362044; cv=none;
        d=google.com; s=arc-20240605;
        b=Q/zYDjeBqmybWiqCoB1ROdfHalzsMFmqmdbUrqaYvwf1HILmiEMOfQB+eE0H4btXTb
         qqfQdw7wYoi2CrTsXKejQY8PBlwzU3I8pgpGzDGYuIUBcsbIc3Y3zVJvJo9w1DcQo4+z
         SNsKtsB/BMhGXfSaFpeULJJ5X4hu69R0eg+n4OftEZAuDgJNciA9QCG6vd2mcfh3F0EG
         jm017uLyzdo0SsO9wEQCe2OkGIkoufRk/q+XJIsU8S2MaEtlHzG6leY8gaZbHjlS5TDF
         t8fb/wULCEpGqHNKd/nIoJkddgD+rv00F/V3oSswqNTslWIhU6URNb0w/3PyydCG4yOM
         SQ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pnJL3Iw0wwI9nfGsL4UNGadpWjx4M7Li4XWaHu9e8Ms=;
        fh=ZOKzRSdfdVhaIIHmJSZDVWNDZyzgBnvRoqQhezNkyFc=;
        b=X4CNO3DJ7yWr4Wh2S/P1BZPWuYoDkNb+qTkEfg/9MVn3gAN1E3lGYjSGmNVG3Jynhy
         VZ4aVPZAo3881f5Ny+UJkZOzqWcCP9IKisWvA6Sibuu+1jMqZFZYAVnSah5cRYAsPtxE
         /KlpsSXrrX6eQ8wQZzl3LX4uy8NoYpZegnFbUCxw7yEj3QDrAXGXHVz8bdV8ytgtbrx5
         ZfJU8vbIaYQtsvD52R6nFqkLGAkkQ+euaI1em2IsYDAi8c1YJXk4FMgHVgZQBTHDVqBI
         1IpsylhFP9v4ksHVSzVov1LCpdyJbk3Xz5WEGR6tvVBIys3U6qcYziDhG9kfdoPPJLc5
         rlNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1773362044; x=1773966844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnJL3Iw0wwI9nfGsL4UNGadpWjx4M7Li4XWaHu9e8Ms=;
        b=Vo4xbcbGVbDxB47s28JvwRyPuGtfhUdWydhmCZfZFIXwIoa4Nolcq1178Ix2aIR7FB
         r8v2I8q08uXsv6RRbkQyx/J8IkETMYbND4jJfuRMx+DOsB9K/PAnXSOpk/xGe4+FFVnY
         NPlR4d3w/YeSU9Y8BQRRUEGhqf6rDJX+b/7EAqF0bpeIputpz3HhnhP9env9yyvlcV8M
         6CF60BZb/c/ASGteI40pQ2Z/NPISEnB+B2jy+zyZAowFpJq3PvcpHATD/DnA6DihYKpc
         S1c3ryc+sbCygNaePFMbd3OB4TYVGxuhDi4cyqcpW1WLnQsu9ucW9sm5xTK7TLg7cS3e
         p8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773362044; x=1773966844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pnJL3Iw0wwI9nfGsL4UNGadpWjx4M7Li4XWaHu9e8Ms=;
        b=CR7MG2EERm1I9Z/tFsIxzW5uy/ixa4vM1R715R9m8AN6Qlyd4KZZAyYZMJfexznybU
         nIEeahRiWX8kEpLlDx0wwSK9MGq8y0af6R32VvZGP9kqwLS++2SOz7P3g2gtl7KYSGvw
         f4BieMbvTx7bqZ7Mb6zvBiHnwKvXKwDgY5ynjHN50d4L4b1dGWaDHn3eAqMyiSK5Dn5s
         Lf0eMT9KC+UU2g4GTEbqOFk7EZAWkcvN1b1E1HC4aZ4jvuDnPyuL9koVxu5B4dnMUbGk
         MhmwepXtJWxaearFI84Wv2+kLZm5AuvKK3hIyMxbw3GySOJfTMsXWB9L/yz+nf0RsJUL
         FpgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBPAWG+XFlgKqevDOqQGPDpkMS/ijxMZA9P1c6EDcEzBJIn9/F7iZfqq/lwUVSeetiqBYd9ONCAuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUh97mdVrjRSwaXxLqDVwMidM7fYYQ3ZD8RoVR2Wtu8yvgAc6/
	ok3ZYfrPB41qJxI1uP7jgO+PQFIIOS2fSNDB7b8tVcyKVPbgyvTrHNA3yXTFSJVV1Blcj0La7fe
	n+TWpCrQUSb2Z0gKaKGuNAVHsauQkq867J19e8dk2PA==
X-Gm-Gg: ATEYQzy/8HWv2vvY5jr8pb6OUBrT8PyqxPAqfDmxjVfMUOocARq20O1sbRjdC4Sjs+k
	8CON4UqZvBSudJEoMuJNVTg/Ve+qNW83JiYOG1/bnjaLXvRlIxTsU19EDPQl2csq7DFX1R+XQyL
	wytr2qe7EtHne2E43lOM6rtcmUMGxQzoVExeiOuMYa5ZO4xT5me8V321tHDrUcRvL7GxgEnAJ5o
	nTC4t4MMe1sG6BWTmMUuh74/bhE7htzmLyNjedt+J7o4lshEcGxJN32rEPDXUd7ADwfuK+zNbOX
	ibfa5Ht5vlKShhLMLO3gk2Zfmv+Ma6J7oH0Wvg==
X-Received: by 2002:a05:6402:3486:b0:662:e094:8dcd with SMTP id
 4fb4d7f45d1cf-663bb3d3be3mr643429a12.27.1773362043907; Thu, 12 Mar 2026
 17:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-8-dmatlack@google.com>
 <20260226160353.6f3371bc@shazbot.org> <20260303210733.GG972761@nvidia.com>
In-Reply-To: <20260303210733.GG972761@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 12 Mar 2026 20:33:27 -0400
X-Gm-Features: AaiRm50W9P4A7h3ayFJS5r_ZVIe8OM2EYEDEiGqBav5AUONhmByKJOVge3skGH0
Message-ID: <CA+CK2bDADhFcMVGoJew9RoJ-DsVhYhiZJGJVwfzTBZdGX++8Ng@mail.gmail.com>
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

On Tue, Mar 3, 2026 at 4:07=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Thu, Feb 26, 2026 at 04:03:53PM -0700, Alex Williamson wrote:
> > > @@ -203,5 +225,6 @@ void vfio_pci_liveupdate_cleanup(void)
> > >     if (!liveupdate_enabled())
> > >             return;
> > >
> > > +   WARN_ON_ONCE(pci_liveupdate_unregister_fh(&vfio_pci_liveupdate_fh=
));
> >
> > This is propagation of a poor API choice in liveupdate, the unregister
> > should return void, it shouldn't be allowed to fail, IMO.  Thanks,
>
> +1
>
> "destroy" functions that fail are evil. :)

Generally, I agree that unregister, free, or destroy functions
shouldn't return errors. However, this situation is tricky because the
state is controlled by user space. The only relavent scenario where
this function fails is:

"-EBUSY if the live update session is active and cannot be quiesced."

If there are active sessions (incoming or outgoing) with preserved
data, how can we safely unregister while they are in-flight? It is a
rare condition, but since the user can cause it, they need to be
notified that unloading the module right now is not a good idea.

Pasha

>
> Jason
