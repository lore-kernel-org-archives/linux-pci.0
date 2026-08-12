Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68C02989B5;
	Wed, 12 Aug 2026 04:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786510791; cv=none; b=VUfcuCyEZgadf3TU6hxZaXmu/ByFflG9RIhL7f4mgvtEhZV01Jaaq0IpJxU3KdeAneMIihrxKZIPBW1SoW1BENDdyNFwWsXuB18tbYPqwCjGhYzl1Zey+5kqAxWCAT5KjkQUiyuOTy46wabEmV0LLb5b4htu9xI3zebTRbH73k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786510791; c=relaxed/simple;
	bh=1yoC2okdjWK1jfQHZqW/bWzzgQMO7aYyXKkKjBjpIrk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ly3r2GqohohNl9GZIPbDGSEE81u+cxMvmuD/0xC92xYpRgkiPOip1zTRmWBjEQB6ZnVcsD6jD3QcswlcjjJ2dertJFY3U9n1h+lHK0BG/SnUu2H97Fu6oU4hfe//BCLNOPD42tgQVGwszrteh5gBrHqZZ6YwNEodIwaM8gboP54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMoyXsCU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMoyXsCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343C11F000E9;
	Wed, 12 Aug 2026 04:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786510790;
	bh=8Fe+s4MADd+oYKlZOUMrJd6vgGeiz20ZlUn0wSJ4pQw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nMoyXsCUiZ4rr2T+fJYS1MJZZpaHNtnR5GR1+Q03EUQKWw7QIrxsfcFfambcN3Za6
	 DZIU9F1quseMrChkbIo2/SjOaiddR21Md0mmLrszRH9hJwmIPH/aC+XpfLRhCEauh8
	 IQrwT9FxKd3euWNNmRC1g5C/YZ7kkIcuhPO0tX5oN+Na+9iUAkmbsmOjjDD4qxQy3u
	 ywn6F68xxYRQ477Yc8q8pFtetVV4KtPsYYKmt2OS9T1pbyOQX0cJVgyrYtBIJCwAyH
	 cPRoVEFG5SBjHS3UFzzMrX73j1maowACQ6tISy2HiJnI+66ZZNivKqRyGpXHMLTEFn
	 +VHLWyPcBRKmA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/5] vfio/pci: Use pci_reset_supported() in place of
 reset_works
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Williamson" <alex.williamson@nvidia.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260812045325.2733631-6-alex.williamson@nvidia.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <20260812045325.2733631-6-alex.williamson@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 04:59:49 +0000
Message-Id: <20260812045950.343C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> vfio-pci latches whether pci_reset_function() works at open device and
> makes decisions based on this latched value at runtime.  With the
> introduction of the reset_method pci-sysfs attribute, this flag can
> be made stale at runtime by administrative action.  Further, with the
> SR-IOV active VFs gating of pci_reset_function(), the flag can be made
> stale via more subtle dependencies.
>=20
> Drop the latched flag and rely on pci_reset_supported() to indicate
> whether reset methods exist for the device.  This is no guarantee that
> those reset methods work, nor has the RESET flag in struct
> vfio_device_info ever been a guarantee of VFIO_DEVICE_RESET success.
> It's only a guarantee that there are reset methods that are
> applicable to the device at the instant it's called.
>=20
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812045325.2733=
631-1-alex.williamson@nvidia.com?part=3D5

