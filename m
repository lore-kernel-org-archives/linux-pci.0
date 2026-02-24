Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45773A9D91
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771954649; cv=pass; b=QkeGhaO8QM4SEvdZ6GekFWbQHx1XIwBQxZmEXZSpndK7aFxJD1sASiaD1FKgoqX45I04n/U4pCKamxEHUEb6z09nPgSccUSQzQpjoHXRSGKnQsiAmJwqALw8V5rWU0sLYn/wqVQ52aeuaH2dcvQpXW+E1HUhOXV2rwCmN2kNTcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771954649; c=relaxed/simple;
	bh=NzE6Dg5T/WZzjhrxSxryu35IDaiffOedvMQkCnbUBbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ll6AuRxAOyFH4tZEj4LDltYyARGbUYNMweHVeV060pyjknHdHaMCZrXu4HSXErPTgBxPZU/LtQawnwA4P30aBoOqR0c/ppoIV1vi4TFnqBCjPc6aqsmo3G+RNaRs/9yAz50BTNBD/gy+G0CjpMzeHD7SdCnh/YYRxcz0m9B7avw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O+yyE1qx; arc=pass smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O+yyE1qx"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56641b5a471so4990194e0c.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 09:37:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771954647; cv=none;
        d=google.com; s=arc-20240605;
        b=AwzUz3s9y6BLGI7jZjI4G0dwD1VQslqKCAnu15QY/8pz5l3azIt1dpdfMIV5S2VvdP
         8ip9NrkZIbcOh8xHncUiYvc/810Nu5UwBgZancX5toE28zmmE9OzaSCFfIUjSAir+s8a
         D4fO1tc5mj/9CTt6m9NprU4I3c9mvdBo/aPVjBmy0kt9MyFMy2LSweb3uyOUksXlahSk
         urIp+SDld+GMyGfVWA7w54wWqzdAGfxYbHaEJh6jRCFqf3gsaGiXvaIaOYnkhO2mEYFY
         QLhjD7zpYrjkcHjLfg2SzdUL6NgOLnIclvr4LOVpgMiVUo5vKr0zPSSW7F4vXU5K1di9
         8IHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WVyG+GjslObEPoiorlcEtEb0lbImQuwl2+xBSlYjPvU=;
        fh=p12oZXS5w60C64d7baymOFHID56BhnKEGNRKjFiuWbo=;
        b=R1b/d+WQbnYwt9EVmJ7a76gjhWp+CGyQQdii2M5oD5eCLPv/vwgOQQn8mLr+lIGjxp
         6jgedj7M0AlqPxvrbRDvlsWA5ApNkvWwGS1K+Ikp4LMjhgUss5gb8AhAkDiSOQFahuaD
         bT0ClbIhmYXb1gEbEvf8fNYr5ouzgv/+AQ+9CNAMZaj25p+uAboJbGVbMYYGY5ok9dnk
         ASkHPlS3Bt82+gCUePLcOmxppCH5K3EpRnsFcW38W48lRVmyE8qbySHOVH7XNf+ryPHn
         gBAlOGS7NRbvzm+SdC6lml9Ti10o1gNHgAznV6cxLPRu1KnZuQqLBoVx5TUo0HlepHDc
         4ZuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771954647; x=1772559447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVyG+GjslObEPoiorlcEtEb0lbImQuwl2+xBSlYjPvU=;
        b=O+yyE1qxUOAg6dKVlAaP7DqeAKGiTg2vj+80mJTczPFmVifUrvXeiRAUTHwcY494hs
         nYb1zcEenz5Pr9R+S5wX2fzs6WzUVhJq3NHDLMU1dUIaQLuUMHJZppn+L6jA2ywQRraX
         e0mJSaajncxDDeSLw5ZGMRSxhBxvuucjh4gIMTqlxMEn9XOaUjH+JZpANuq66YMr/C77
         cVNZr4KOfDMzrm6CHNWYiua1MCYdmhCYINFR4ZAoUJe0W+1ywY/RGZKP0jA5xVOuFSPN
         CedJgKBY/KmNHzfLvo3a+Lt7jvxYnRPAZFJmKLozY4jiCcQo3hZpYtW8JIF7cczZ3JQp
         WWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771954647; x=1772559447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WVyG+GjslObEPoiorlcEtEb0lbImQuwl2+xBSlYjPvU=;
        b=egqJt2tWiS2rkixy85srhsPjuklXxbDsQ4azsfSHb2yDROJmt18qLJTDDbwad6w6j1
         386SkAXCP30kgEJzbj5dV+8Gd8r7zcwZwbFd4t1QJjUnQIe3OYwNTpyRvRiuQoVvc/St
         zyQlStmZkpSEn9snwBGFiqlZPKHDUh82oWSZE8AAR7FWnvTgoQbBSnZMSds1NIMfNJ8G
         WxDRjPZQ3YDWRz9D0zyNsAL85AtUVFuYF1j7X94E4MS8iidQnu1duyyO2xbOikBnUvem
         WyanUhOoNhzIFnanYfT8P9o1jS/NvbF3Pacb67voiAWzTN/Cw31eAqOZ/PL3yJl5xGc4
         oCQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgXXshtF2vH1sHcyiWClcAW+/E/v9tefsYbq1N17wE5C58L03TFV+sndtYGyKkyZlfUAhUS5sQeB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNdeKdxaO//IPCuxkeOjr5Ak2KlhDOhrcfEYiwTBdEmuPJTQ8Q
	98j/p4SuPpk2FCgDtdIBPWbEVrleF5lWfzUIWM922mnZDzPYvVLRg8cPAkqm9OT5R8VGjlTp1Le
	bBB04GFipDBGA5zxC0TTU+b8Pb1QEvy6qIvjIeKfb
X-Gm-Gg: ATEYQzxLgdUIpWiD2uBB/oo50R4+VGpr8oTBtnAExpJymtslrSLvPRVgCGZQlzZZpcm
	j39UTNSPaDVxgFfsh9+2EOahA8dtlJ6uurOzsYwfwbXQy9C8BsGQq9Mhak4SWXko2SdJFvY93MI
	8TmD1v5q6gWTtP/QrbCdsibMwuRw8rjc85AAUDl6kuqmWMV8mH34SkIszXMp1BfzHzT9tIuQmbL
	GyTMV9ZhM3ZkRvTi1YYtLG6dDCkaSfgsj4U4OL0vt4s9OpEfpTNBlwRnuTn5neTir2av1vZtzBd
	KvXQbM8=
X-Received: by 2002:a05:6102:e11:b0:5f5:3835:4796 with SMTP id
 ada2fe7eead31-5feb2eebe4fmr7234443137.15.1771954646379; Tue, 24 Feb 2026
 09:37:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-4-dmatlack@google.com>
 <aZ1xAyN0vgLWIi5y@google.com>
In-Reply-To: <aZ1xAyN0vgLWIi5y@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 24 Feb 2026 09:36:50 -0800
X-Gm-Features: AaiRm51zYRUGqNlquBQBjZ_Ao68Y3fgUdHKViouV8m9qg-AcIptaKIFOE6taQzc
Message-ID: <CALzav=cMsDyUrOPgkr5ouROPmsEAN2icsL266M4FxY3P6BNd1w@mail.gmail.com>
Subject: Re: [PATCH v2 03/22] PCI: Inherit bus numbers from previous kernel
 during Live Update
To: Pranjal Shrivastava <praan@google.com>
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
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 1:36=E2=80=AFAM Pranjal Shrivastava <praan@google.c=
om> wrote:
> On Thu, Jan 29, 2026 at 09:24:50PM +0000, David Matlack wrote:

> > +     if (pci_liveupdate_incoming_nr_devices())
> > +             return false;
>
> Following the comment on Patch 2 regarding propagating errors, the check
> if (pci_liveupdate_incoming_nr_devices()) should be made explicit to
> distinguish between "Preservation Active" and "Retrieval Failed".

As mentioned in the previous patch, the errors mean "no incoming
devices" rather than "retrieval failed".

> >                               while (parent->parent) {
> > -                                     if ((!pcibios_assign_all_busses()=
) &&
> > +                                     if (!assign_all_busses &&
> >                                           (parent->busn_res.end > max) =
&&
> >                                           (parent->busn_res.end <=3D ma=
x+i)) {
> >                                               j =3D 1;
>
> Looks like we over-ride the pci=3Dassign-busses boot param here.
> We should document how this change affects the pci=3Dassign-busses kernel
> command line. If both are present, the inheritance required by LUO would
> likely take precedence to prevent DMA corruption, but a doc update & a
> warning to the user would be nice.

Good call, I'll add a log message and update kernel-parameters.txt in v3.
