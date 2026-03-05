Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6E13D1CAF
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739768; cv=pass; b=WoNr7+Qhm4lhATW0UJBkCpQL6QeEGWBR++pCNbBcolUTKN7aOMRkWHDAy2yVIyGJ4ECZ6vQwl6onz//1mXEclt0jfybfQyG4kvE8KO16OYpNMp0KsQPi3CBXo7JGj2tlxXcYTWg+9WGzpEjkHUAh5mcyD3vvu9gZjmgkO4kSyvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739768; c=relaxed/simple;
	bh=BFL2J/Icfk5z6sblaLG86L1o2xcdsDyOfso7V9JzEr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKx82dffhCFZ4Ja06fNkdvP8souYa7VG9RTvKfFJovKWYVNLU7F3sMLObTC5xOMh5ZqBRGMVLMfRZFG4dRwASaest//tQrA4p51Nxayy3CMx035EhbCw7P8f29dBOqFlOa+P5O85s+8b/2SsTXNriggA4t/5ioyC168Gek5EOlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J7y/Lq1I; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J7y/Lq1I"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a133b686f7so1169787e87.0
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 11:42:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772739765; cv=none;
        d=google.com; s=arc-20240605;
        b=CX4m+PYBZ9dGUcQL3KgsIwtuFAi+smJjWU2R6QvZBMa7wKhICl4lwmXG4uBlajEffT
         YxLdFBQ2teJPSGq9+PsR+doWIhxOcas5ht9i9xFzKqc8cJ3/kcAncbB9as7IVg9qsfrn
         czuU1Fj5dPVb03FiFm/FtIQ7KyGsnCcoPKjyFJvcoiuXlupCOQq8pvY9iYnR4w6dAkhK
         NHo771O542NB2Ma7XPQU6avLzS0Rjw9jNpV2UnCr58qCjhYvAp7L/0NO6rgqmDbJjZQd
         g/6c6KYbhlWH19bZurUoW+WELSHsM8YCxB1avtX3VWwAz62F5w6HWCX5AApcd9oFPfIc
         zcbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BFL2J/Icfk5z6sblaLG86L1o2xcdsDyOfso7V9JzEr4=;
        fh=UxfkuKzNZaBUZNt/LT+rUum959PflJ3aZkTExdAYEWM=;
        b=ANr1DlISbgvE7UMCuhWLAiJYrz6ARk9zNrsfBcobt1gqNmDFEpNA9/xCyMG6yt8v2v
         RIhbp881OuP4KT386GWqi+CfDtwcAUlORM7tmFdcwp2IYIDfio8M6otTjUNFSTfE4rKV
         XCIzrbhe80rqmW60zbqzfksbLVYz/ROiUjehDbGMHG0qKluRqufRJRr1zhuEMa2dwGat
         iOXgvaypGyAB7Cnwo4pecFowRySNnKOlrblJ2oiDHJi39rvp66nIeaKaxG7IJoVcO1Sp
         WHHMxSFUlZUQPYxqXAdFlqk3alXKCEyi0D4+sL8wKn5ZOSJe+AEJl7BowKGIwhAn96xF
         07Ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772739765; x=1773344565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFL2J/Icfk5z6sblaLG86L1o2xcdsDyOfso7V9JzEr4=;
        b=J7y/Lq1IxLU+Dz/yjyvb/dPGPWnJbQob8Q2QuxVwDq6DrAe8KOLBbCw/RJH28ZsIVm
         eLzXtNQcCvkAEH7bpRZF/pHYbvI0NuBd2MgR2c/Tmts2IWoPoUSUjur+tO8lJhe/JPu+
         wNIM01PysIEn8QP4iLyrMtWwOGswInpVK2slbAeLvCixJcS5Jcfm/YXy9W33WHWUlNiP
         +p8C9bhO6HnUerwsZkWaI2Fa4KQlt131xsUL2xLViCepC/XpkT2ZzP5F5tcH1trI7ll+
         91MgpSRqDkP3dwwPHNc+cwgxgozBIsjP9eh+BAsVQOwjVYYakt93rQClSztQIsXMrt+/
         C4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772739765; x=1773344565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BFL2J/Icfk5z6sblaLG86L1o2xcdsDyOfso7V9JzEr4=;
        b=Px7pFeNuLnAPPXrcvdVUmO322/wzyPFrvkUvZCudQlY1RTAuY8BAWrRJKlvpnbF5TA
         7YgRqVwZtaaw8rxW6HsgZOZQsoNN6+z9EHU8rXkt2ymrjidaVQGqg8DPfQ57LgjBHdcj
         x6yjtRAkBAyJesjAcV0teVrrD5RQkz6JwssPZCOsMad3adXnqmcFOLsIrgZQ+5+U6Wi7
         Hz1RqHPiHKHB2GCTAoxfuvc/mIScqozipJYq3j96YqBkHuM9c8SY73XB3byRNg+EKV1m
         cremC2j3vYXBMovlBUMVhpG+OhSaS0m+AWMVYbZ5Kf/t/qoXnbGDIFcbNGUs13ssiwvD
         lqfg==
X-Forwarded-Encrypted: i=1; AJvYcCUzHyD1wSlLEVLLyWe6D/pCZejM77LUmvri9/0pex9qWPFyi2Uo7TdwbTph+VSZQt3Lpp0lzOh5zbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YycOimBjLP3EZWZurb1N3Yqki3PTg0ZWdjqrPOTgBvBFHoUZsmH
	Cdn6wRC4o7OIiuicl3n4v5xurSgmzif8Bxj54q4eXXFXGNKxX+UqKlIvJDBXdV/KAEWO3EGIShV
	+EOFYfulije4N5FS+rIcxHMelJdpyB4pjhOynMb+R
X-Gm-Gg: ATEYQzwO4an2RL0njvEVbPp07POlh0ZWO8V7igldyot9LSFxKMaohfxNsZ4UMX4iFkN
	4wSbSZhTEWrLE7trUuqbUPjVPgaCDj6kJjf5XZdY1ui2y8YQPyl0NsiPtF2BeALR98tKSW84+CS
	dpeDh4T1fNgiEL69pdOdN5m9+Xr4z4WhVTNUDwMcLBXDcyvzTDBCv25246iIM3b1KPQ5yZ06COD
	rrFOrrcPoIstKRslgUQeWeNyxiM8Pa0iPDzmm8G3H5sEK/PZ9KrDVC+FYtkluUdWsrRwV2DfAvS
	44s6AfbU
X-Received: by 2002:a05:651c:1587:b0:38a:6f5:4b54 with SMTP id
 38308e7fff4ca-38a3c815300mr2046311fa.4.1772739764639; Thu, 05 Mar 2026
 11:42:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-3-dmatlack@google.com> <20260225224651.GA3711085@bhelgaas>
 <aZ-TrC8P0tLYhxXO@google.com> <20260227093233.45891424@shazbot.org>
 <CALzav=dxthSXYo13rOjY710uNbu=6UjzD-OJKm-Xt=wR7oc0mg@mail.gmail.com>
 <20260227112501.465e2a86@shazbot.org> <20260301192924.GR5933@nvidia.com>
In-Reply-To: <20260301192924.GR5933@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 5 Mar 2026 11:42:16 -0800
X-Gm-Features: AaiRm52QizUmbxb_ZZJRNIFYAvXcIrsVMR2oGVyxQJsUboHWoi4G3a03BNBWEM8
Message-ID: <CALzav=deyfyzGXzSGmEbjvLr8Nn9Rpeh9w9JVk0vmb9FcURYPw@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <helgaas@kernel.org>, 
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
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 1, 2026 at 11:29=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Fri, Feb 27, 2026 at 11:25:01AM -0700, Alex Williamson wrote:
>
> > There's obviously a knee jerk reaction that moving PF drivers into
> > userspace is a means to circumvent the GPL that was evident at LPC,
> > even if the real reason is "in-kernel is hard".
>
> Given we already have GPL licensed kernel drivers for the PFs it
> doesn't seem like a reasonable worry to me to fret about some cut down
> version of a kernel driver running in userspace.
>
> Further, let's be honest here, the people most interested in all of
> this are doing it to support their proprietary VMMs. I'm pushing that
> we must have at least a reference implementation in qemu before the
> kernel parts should be merged..

Yes, this is why we built VFIO selftests with the driver framework
[1]. We wanted to ensure Live Update support could be well tested
upstream independent of VMM adoption and without requiring complex
orchestration.

Google is also working on upstreaming Live Update support into Cloud
Hypervisor and the kernel pieces land.

[1] https://lore.kernel.org/kvm/20250523233018.1702151-1-dmatlack@google.co=
m/
