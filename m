Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6611537647B
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773700236; cv=pass; b=b9/4YYmrEe47dHdloD4hesT3xmYYtY+T3wuc5UH9LJ00alWt6IAaQL+muUcbRTMB8meURpjOan+TAJ9aDC+tGiXJsMZ37ooIWAcw7ibeO356w1vCR3LBqug7bSDdlliNJriDZC7GTszdge8tNxkViHib84rdkWXghObAfqOMewQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773700236; c=relaxed/simple;
	bh=zOX//qQWt0hksu4DcPXbpgchK0aDuV0IDH++kKVCMlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIF7P39aSI3WxTQFslT2d05hbIWRZUIwEwENg0pSySfvwBlGPv+EdPGxbcZgQ799DxCexrEQsnKQ7ZHEfkmdyNbInJTUSKpXCLggNbegE73c0Nkl9c5hFd/KpiRSeHxtT+MxJY17dhxRBjO7UlDwGyk6xfGLdXToozDYs7Hltnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S8OUYxBX; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S8OUYxBX"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a126c8aab9so6955138e87.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 15:30:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773700232; cv=none;
        d=google.com; s=arc-20240605;
        b=H9w2p4HlvfyJxl7+G7BHx7uBxQskLmgJXyuRM/YbPTUHobLxYWHRgRibDuBpj+Z7s6
         IFJzMsV3Xkk3L5GMd5EkO8E3BrRHblORF58Mz6JhW7Z1xqpYETFUGcg79VW3Pkkk26OY
         mwhck4yqL/eucuXqOKk3t8DgAyBSwLLgpgKyzlaowR1iCNIDIG1JqypBhihuwCPfBARr
         2QxW6ahNwnuHTSJVzlE61usU9ntZBNghY8QW2Ry/hw1779G6NkHKYXQp2gXApRklWoe6
         /B1BTGmRhj1JJRh9IJHIVPaERrB+2LEpYIpKMoJ3VYIXRgwmvQvqNiHuBwr6Rm+guvdj
         4pYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NHBApg3dIEw9R1t5Yh73owWQt2Uh584izEOKgKc7ZzQ=;
        fh=fKb80l2dtqcupzkzDVmix1UXptoep0OzV4Y1ZgiRnVw=;
        b=fXfOYC+i+eWAaQs0602knnyjgJJwKxbRKC8w9Qf/qKDxVjFNoDMQIIJ//jo0NYvk+B
         28Be8YJYLzwHCqVB723YwUJMHMHqIiVqunNEwEvCUtjuvgbE9KoFQwMpc+OhtX/J7JUZ
         ZHswmUZkex74md7+D3Cy6eLhWxcXDUhAyxgFy9TqTnPAV912WkTtlO+fKaMYioVHe/zi
         igBLNC7Ob4AjU7el9AI/ldkx5NyTqrhvDqF8Hij2La556KjamZdA++LftkSeVx52tFHL
         UXZIBJ51kBW1CsVjemf1Y2WW8QZRjFO+He4x/Lg5NbfuOgDbI6lk5sUf6iGg7bwDjD5t
         08ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773700232; x=1774305032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHBApg3dIEw9R1t5Yh73owWQt2Uh584izEOKgKc7ZzQ=;
        b=S8OUYxBXmFk+Y6amRZJ5f8g9oCUwoPge4lKp/bnqvsLpQu4TaBiY9YxmtvXAIPuwjQ
         vDaB5OERJhvwosImf1/dH1iHawVRNvO4e4jpO5ljBAIEiC0pxx5N5mOW4Ux+VN1rbT4I
         P/JY421qxcrNmXeReYWij9KJEL52vJALlXy80BOqjS/5RHl9Fu2GxuBnU2vGRUdIUBJo
         yDs43NE+RgmvVvitTglEHogh2VDT+QHcFABoCjX35EZhVkuGPxkqksZRGGlG5KrPumYN
         c8YtYpZhgEjhK3jFJnBCgoTLKfv4Gnj+bqiS+FubXg56kABqYwsNvpdy2QvDEKD/D96U
         UETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773700232; x=1774305032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NHBApg3dIEw9R1t5Yh73owWQt2Uh584izEOKgKc7ZzQ=;
        b=e5yU6PJbhw12Ei7h3VmLrCspQBf0e4FxXqllB1kxYK99PLAF0UfrnaTKCcLjeTbaYn
         PKozoxrarP7AVLFpzvE/Fb+3pqDyOCt9jsI8+hS8hv4YPjlWk2KXNfLVDz6wiftmywfB
         Zx7Z0hEWi1dhj6ewlO60HUDrBmALBlPD0iAE+P7OZKGdNv/+p/SNiIkAwggstnzFjMaf
         RKuSRSONWKwFnnKZ2wIw/YxmNZkLd6fN0hB6BfeZSbF+Yc31ERW3f9ICKjJbwUhIeWrz
         9/5W6LcCvq+fCh3axB0kKE6tJLcgR0XF3PWHGVQzt+hsYmhztwb/nUUPy70R3E3GX2UX
         xc1g==
X-Forwarded-Encrypted: i=1; AJvYcCUSlFh0d4EJA7VuwIg7E77e5DK8lqiJ+HlTZ3vnMm4mVFoxqNP+f7RmRJFcC4Wa5xtvi0LrLtJ/X4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvL+jASSa+vyfbSlQl6p6oE6OQZ14iIRL8F17yFomd8GnQNEuK
	ctteEulkk1HrVuiptOYoI8OoZ41+kNszakffFP5ZBVKWTWGmxI1FGBMIpMlVFjSKaG/Eh2kg92o
	SQ1aR167e2PrE4eGi7e/6x/krQbgqQS6AIpsVg7lt
X-Gm-Gg: ATEYQzycHax+SNLQmQbSaBFSyJ/op7IQpJLz0K6gsMOUcux19rOuEeuoJxtmp/L18W0
	R+cQXRH32pF5VPK4YPPFjnh7LRObO4xJIb173CwSdRquduh3NC/zEc+Qe3KoPSo+MVWTCJxRN9E
	t0eIKo2AYMie2qHxDx/rj7HH406aEgYApEwBx4WSY04uubCWhaEFEC+wlBd7ocarH3mgZdSbnzd
	M4uIHEULL0tSS2sbD4ifilHyavvmy9GYPxlmlUpGDh98rB0ynTum2Epc9QId6+zq+lVmR+8922V
	xUycx0TUuBVQVSkcWzk=
X-Received: by 2002:a05:6512:38a4:b0:5a1:2a64:202a with SMTP id
 2adb3069b0e04-5a162706bf5mr4418611e87.18.1773700231818; Mon, 16 Mar 2026
 15:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-12-dmatlack@google.com>
 <20260316215056.GC1846904.vipinsh@google.com>
In-Reply-To: <20260316215056.GC1846904.vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Mar 2026 15:30:04 -0700
X-Gm-Features: AaiRm51TsPFqmaxXeg5vtHycDWCNAMtrDhfsa1Ts3dgQ-gFDNbzitmE0jWYnMy4
Message-ID: <CALzav=eKbTiJYz4mCWTmVghnwFLHZOY096Pf=1GYpO_UBixozA@mail.gmail.com>
Subject: Re: [PATCH v2 11/22] docs: liveupdate: Document VFIO device file preservation
To: Vipin Sharma <vipinsh@google.com>
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
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 2:55=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On Thu, Jan 29, 2026 at 09:24:58PM +0000, David Matlack wrote:
> > Add documentation for preserving VFIO device files across a Live Update=
,
> > as well as some generic file preservation documentation. This
> > documentation will be extended in the future as new types of files are
> > supported and new dependency/ordering requirements are added.
> >
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> >  Documentation/userspace-api/liveupdate.rst | 144 +++++++++++++++++++++
> >  1 file changed, 144 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/liveupdate.rst b/Documentation=
/userspace-api/liveupdate.rst
> > index 41c0473e4f16..dbf1e4aeddd7 100644
> > --- a/Documentation/userspace-api/liveupdate.rst
> > +++ b/Documentation/userspace-api/liveupdate.rst
> > @@ -14,6 +14,150 @@ ioctl uAPI
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  .. kernel-doc:: include/uapi/linux/liveupdate.h
> >
> > +File Preservation
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Should we use the existing way where documentation is written in code
> files and referenced here? Maybe luo_file.c for this?

Good idea. I will look into that. It would be nice to also have this
documentation in the code.
