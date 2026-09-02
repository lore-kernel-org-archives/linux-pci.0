Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3C93EEAE9
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 19:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378302; cv=none; b=ZNJYnCr450afHMcJPrDjhx6Fw2EQFXrOE2nkEAodEjJeEwkOwg8dK0vef5R8Yc9i9vdoQu/zIz24nbXbKoChEzMXMR562NSU1c09pb9fJtit7R2swRt+lNAD/w2Qnr6z86yDWvmQjQ3cnjjbfuJIrVO9XMeBmlg5eSlsJ29PI4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378302; c=relaxed/simple;
	bh=1xlRM1APFNd4cG8kZlm1fEDE0nCXG6R0HVSS1UpD9BE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XDSjXnC4/vY3kqgwmItGVtXsoo2M8+dTbXJQIXwFdXjclo79osVLva9I1lMenwzpzRwEz9PH1NCs+ruxRAVowx0A9BvbO6FAHaayNK95z6f8YGiHQRHNn4l6uEJHQMUsF1bBQLV5fArO9ojpsFuuzPVN0MGBfKXwDHr7PAE82ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ML5FQsWZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ML5FQsWZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6951F00A3A;
	Wed,  2 Sep 2026 19:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788378280;
	bh=FQ59A4b36CmQ3qk1zJntjqbygdyZBGI3CJ0IL+snHxk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ML5FQsWZvK6L/qeRFNNyEf7RhY3XI5gEafi9szzlOrhWMleQTN/buzcNqNy3apYvY
	 Qj515xIVQgWid/64sFPdoV0GL0MQ3QGnmp7p5nwuYDs6qcUDN59sYr1eDET8Arc4Ql
	 k6hEpbycdhWMVL0gVJA0qqzffD18NKorPW3lyfDiiHTX7vu69qdjD4fzzcOummbhI+
	 sq6ZC8RBp59zyWEtYkAcnGNZE1lew/zimXsFXTczsvMpt5CDQ5n3ZQSSBylT0kXVtJ
	 AwtfwTMk7iULA5gMEG4ys1hfdK5QiaZj5Cge4c3Um/oTe1SyVfD5y0mMi5tmMGtUQd
	 RhjMqtvYAjIPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] ACPI: PM: Drop parent state update from
 acpi_device_get_power()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <2292173.irdbgypaU6@rafael.j.wysocki>
References: <5144065.31r3eYUQgx@rafael.j.wysocki>
 <2292173.irdbgypaU6@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 19:44:39 +0000
Message-Id: <20260902194439.DE6951F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> The parent state update in acpi_device_get_power(), that occurs when the
> child device turns out to be in D0 and the parent's power state is still
> unknown, is highly questionable because it may cause the reference
> counters of the power resources used by the parent in D0 (if any) to
> underflow when the parent goes into a low-power state later.  Moreover,
> there is no reason to do it on reads from the real_power_state sysfs
> attribute of the child.
>=20
> That check had been added by commit 8f7412a792bc ("ACPI / PM: Infer
> parent power state from child if unknown, v2") before starting to
> handle the "missing _PSC and no power resources" case directly in
> acpi_bus_init_power(), as of commit b3785492268f ("ACPI / PM: Do not
> power manage devices in unknown initial states").  It is not necessary
> any more and commit b3785492268f should have removed it.
>=20
> Drop it now.
>=20
> Fixes: b3785492268f ("ACPI / PM: Do not power manage devices in unknown i=
nitial states")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/5144065.31r3eYUQgx@=
rafael.j.wysocki?part=3D1

