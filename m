Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4EF2E7369;
	Tue,  1 Sep 2026 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256063; cv=none; b=RMxBDw1Uu6iEZ1nKV1fKltUB3V9Oe1Ye00OnEYSFt8yzP2W9pohreu2/bdilAJTZebQC7DqDOn9d6AGttUO5vOUAvtgWxWDX7XDSTKBOAkJI+MnND3RYLoNY/TvnenWK3TZWufKthfC1ISRSGZokMlGFlNGWmxe5WWf0jtJFF9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256063; c=relaxed/simple;
	bh=75gO+5cu2gKJN/b9kxom66eFznwP7/jUJ9pOLkUE3VE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eJlYmieR7gEoIVgfZiLyGTFrI4mi1JD3KYLEWrzSfBqdWKfonHlvb3Kv1FQUQMX6XVM9kupcLs3lJudrrA/PaYeLIISAGLXvZGAE/MiQjxHyy+Ihb/wOPUUxFRIYebHhRajxAju1Sg8tf9xXh4l5ma4BieHXfjxM1OReX+XLfuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RStzCTR2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RStzCTR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB251F000E9;
	Tue,  1 Sep 2026 09:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788256061;
	bh=75gO+5cu2gKJN/b9kxom66eFznwP7/jUJ9pOLkUE3VE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RStzCTR21dtbiexP8BzUQ0OhsbYnD1ycDmgxVEp/azRfFTAUkssQrSCtXvNH1VU2E
	 shBCaYzmfV5peBIcnTe+wwWeSgIlQ3+9VKLYZh0CH73YVVtS1anZZiYhPpwaNqT5k9
	 Gx3dJRNbVmyMjjtH5ASQZkuwWuA89By52/zzCgsgsQkbDmUcf2tFeIUOuHlN8CsAFQ
	 meg1erW40Bit9xY0bzdCAu+hGp7Iq3fQdPVgqK+B87BXF+7fPrL5C7Np8+U0YU9Sbw
	 9GMTTyH7qovTC+TTPJgzd8lNWjRTaQldHiJn0/IObVlP3QpvaCpUPHf34Xybs9ysrN
	 xsVSSDqhQsM5w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 07/19] vfio/pci: Retry BAR faults after temporary
 recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901093217.8539-8-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-8-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:47:40 +0000
Message-Id: <20260901094741.4EB251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> A guest can fault on a mapped BAR while host recovery is running. Do not
> insert the PFN in that case. The device is not usable until recovery is
> finished.
>=20
> Wait whenever access is blocked, not only while a recovery transaction is
> in progress. A function reset blocks access without starting one, and
> error_detected() blocks it before it publishes the flags, so a fault in
> either window would otherwise fail for good. Only a closed device, or one
> which has failed for good, ends the fault, which is what
> VFIO_PCI_RECOVERY_FAILED records.
>=20
> On the first attempt the fault lock can be dropped, so drop it, wait for
> recovery, and return VM_FAULT_RETRY to bring the fault back later. The
> wait is killable. Take a reference on the device registration before
> dropping the lock, because the wait outlives the lock and the device
> [ ... ]
> revoke everything, and the fault would then map a PFN for a device which
> was already revoked.
>=20
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901093217.8539=
-1-skolothumtho@nvidia.com?part=3D7

