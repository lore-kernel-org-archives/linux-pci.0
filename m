Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BCE372049
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791993073; cv=none; b=X5Ot27IdPXMSGaeK0MlhUPTlPFibZ2ffTRplHZIiBjI/jfKVtfjMCH3nLR+30DxJWN+THhBo7IWIQTt4WAzuaNgPxy/kWhuy9gNLaBAXJ8u5btknKJn0vQEiLtMHTxppTwSAkFaufxk7fWPhUeYksEm54uGW6YtBDkhnopemxT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791993073; c=relaxed/simple;
	bh=LkQyiiB+wHUUXFgoM66GWcLqnWlR2Q3l+XzrP3OaUrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4pojWWB6hF0o6GLp3bXtrIHfB+gguFRoSxlNhui0UHZgOrmvFDPKsiKOjB0HXbG17dJawSawGiiyO5SCgiXe3B4j+2JN31KlBHzjFObhqWrY+/9Q+PJyNZscA4xBPLagtgAPnaxuRNwLCh73JtByiV5LKMHRxSrWQEbYeInLQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMZrZBP2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMZrZBP2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1D31F000CF
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 15:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791993071;
	bh=LkQyiiB+wHUUXFgoM66GWcLqnWlR2Q3l+XzrP3OaUrY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fMZrZBP2h15Ckue5HhxpgTi19nwEBw3ZH+JV3Vb5rZpIiZpdeAzzp00oTwxQOqhNI
	 t6O8jSs3gQjB0sSjuB66M3WpaQBrGnFsvNPYpaEQgWesT4bOtLVAf54u+YQyz3SFgz
	 bWRgNXoO8n5huC1uMvz5DndkVMV8uGrOsuf4NEk3jgvvXEEfe+t4J/j+muo03r6dBD
	 mDLJt2AjV7YjCXt80twTy97lf49LxrNGWSqJXQ3d0FmFBf/qrFu/hVpZ+qd5eQ+8/r
	 ZIYsBjnv7GRhHz7bQ20bd/0vLF0FWcEpwfE4MuoWzBeTmz/CqBS+rGzCcQhnF21846
	 ut/A7FQz2R4QA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bcb4f23ddeso570853e87.3
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 08:51:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzucccZlHhDmvplpXBmP0s8zq+kBAw6mn5clPSVPSMVdeFLcillls140GLoQErcj8wy3sYSL44q41Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZAAAKWGI/qbb2gRXp0UqQog71ADz0sZKdJS4CqRsgHmLKyJcH
	BEcJRunOtCZZ7A/fW2R8t7x0+DeiBQXpY8lmU3U1/1bTTP1WdzjUt0YkKYSwJ8uEh4CY+7LkI2M
	b3i6nw3DUHNUzhOtq/KNoHTGXQhUAWS0=
X-Received: by 2002:a05:6512:1255:b0:5ba:eed2:d491 with SMTP id
 2adb3069b0e04-5bcde8e8208mr5678635e87.66.1791993069662; Wed, 14 Oct 2026
 08:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012104645.975190-1-keng-yu.lin@hpe.com> <CAJZ5v0iGhqaF1m-Vc2xdXQXj_BxPFFWCBTP=Ypg_gWQEqWkNfg@mail.gmail.com>
 <642c49e1-7d47-44fd-b597-e5ff0877bb56@amd.com> <20261013060957.1023448-1-keng-yu.lin@hpe.com>
 <CAJZ5v0hndk_ck1hcgWXyGX=OHmbfbhKsrJQsNQF9DQrucRNMDw@mail.gmail.com>
 <d11aa70c-4753-4a28-9955-990c45649677@amd.com> <CAJZ5v0h2-S=Yf84LveK=36AkeutJxj5qYzVXnjhAnawi097x0g@mail.gmail.com>
 <CAJZ5v0ie2AvCbdv8-zkpYzHLcTwUPUj+=WWOQjDAPmSepSAQPg@mail.gmail.com>
 <80c964e1-30d3-4b09-aef8-08c04e119e79@amd.com> <20261014043150.1094480-1-keng-yu.lin@hpe.com>
In-Reply-To: <20261014043150.1094480-1-keng-yu.lin@hpe.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 14 Oct 2026 17:49:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ij6n2XESGGaMGB5nMtNKemo48yjxc=Ym35L-ei7XpMCA@mail.gmail.com>
X-Gm-Features: AclHuK9yA7mthcUmp_RjxB7MFzcwwXBNhBXDAN-m2mJX30WBW-TJuhOfAS1TYfM
Message-ID: <CAJZ5v0ij6n2XESGGaMGB5nMtNKemo48yjxc=Ym35L-ei7XpMCA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/PM: Restore BARs after powering up during enumeration
To: Keng-Yu Lin <keng-yu.lin@hpe.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Matthew Ruffell <matthew.ruffell@canonical.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, andy.liang@hpe.com, 
	david.chang@hpe.com, s.collins@hpe.com, jenifer.golmitz@hpe.com, 
	pravallika.kamma@hpe.com, zhen-dong.lai@hpe.com, zachary.pabor-ext@hpe.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 6:32=E2=80=AFAM Keng-Yu Lin <keng-yu.lin@hpe.com> w=
rote:
>
> Hi Rafael, Mario,
>
> I tested this sequence on AMD Venice SP7 and Turin, with debug
> prints added. Both systems saved a vmcore and rebooted successfully.
>
> There were no BAR writes from this path on normal boot. In the
> crash kernels, only the cleared xHCI BARs were restored: two on
> Venice and one on Turin. All readbacks matched.
>
> Rafael, would you prefer to send a patch with this sequence, or
> should I send v3 with your Suggested-by?

You have all of the background, so feel free to add a Suggested-by
from me and send a v3.

Thanks!
