Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7777442387
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788771959; cv=none; b=b9wQ5gigkSpGt1Hyf0L8kSV9Ct/KdzPv1PsssjR8tk8j3P0WcTXsxB28+jU14KkFSjmQhneJhtyxgADuJwl2L9Zn6ghChXUHmtNfTFof8YkQtKPJtBGjQsfRnpodxYVTczkPtWY+hiaajIjqrtCuClGQxeEAjRwekwqCR04mO5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788771959; c=relaxed/simple;
	bh=IUhJMavlC1/lJMymthsNxd9RSBSjVCnxZb9fSuoYzq4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VZHyl/6nVR4wy8GLuM2NyV7Yc9X0FbYaWir+AFknQU67sUkgWWezeFQlewwPMTqGqfr5bQ+lHRsuheGra65KWlhVxc0S9OpfaRYRjbL/HgbZHvkhUttr1bMKBrwMObT3Do6IHN2uySmFB2dBeKUj9XEyjcYK3K9K0meLJBxkpw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLq9oGo2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLq9oGo2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AC91F00A3A;
	Mon,  7 Sep 2026 09:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788771958;
	bh=1niFZ7sfKu23PqwyF1sk7aIHJKq4K77Kd4eY0QCPIV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GLq9oGo24yhSp9+FMGCLeSP3eW3w5trDBP7nLUKLaASgiziJFfxR6JaZF9lHcIOHI
	 k8dI4Dg+WaVQwHpmRsEf2M9S+RLKP4kNSjMS50inVldeji7uI1Sn7nqvx5kP8rW7jV
	 JhGMJ2KYd3tQxJMtE5Smy9/CGVJ8+Lo0XdYn7/+fLpi8HHXxhkjI1rrJ7xcidLrtFC
	 hnuzUxqt056o/r5ukDthSt+cwIKxz3Dq4a2WxOoorKudUvJ/rdZRQkLeDHPVPvTfTa
	 XlSxWMZtSd7GZTnaFDyzGHL08UvNdyFOw6ikdbfT8VEo6bGpxV2FlxZ7z2xrFT06wU
	 NEWxUJYykQ1tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: Disable not supported reset methods on DG1
 0x4905
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janusz Krzysztofik" <janusz.krzysztofik@linux.intel.com>
Cc: linux-pci@vger.kernel.org, intel-gfx@lists.freedesktop.org
In-Reply-To: <20260907090249.1348552-2-janusz.krzysztofik@linux.intel.com>
References: <20260907090249.1348552-2-janusz.krzysztofik@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 09:05:57 +0000
Message-Id: <20260907090558.16AC91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> DRM CI consistently reports failing device reset attempts on Intel DG1
> discrete graphics adapters.  Manual reproduction attempts allowed to
> narrow down the scope of that problem to a specific revision of that
> hardware, SKU 8086:4905.  It has been confirmed that both reset methods
> claimed by the device, i.e., flr and bus, suffer from that issue.
>=20
> Since consecutively failing device resets may lead to system hangs,
> disable both useless reset methods.  A respective CI test will then be
> skipped instead of aborting whole CI jobs.
>=20
> Suggested-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/11814
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>
> Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907090249.1348=
552-2-janusz.krzysztofik@linux.intel.com?part=3D1

