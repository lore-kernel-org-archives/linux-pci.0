Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3D63E4508
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 07:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691516; cv=none; b=JUFTqeZayGMlpCTdgtdTCFrkdIqN9hy8HiZnl+lOsi6uDW8AgJHEqDdq7dSmOMSTHh2wDqdh4XqfpKJIG9oW6u5dWV/gQQzJZyio2fOdKwti9t0s7QgRG/sxo+DBzVQ01Bolmg4D0iehvIOG/Y6JSbUj6t/pqMf2UFi8xgoOqk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691516; c=relaxed/simple;
	bh=Q/SC4SoBXoZT02VpOcKJwkUHkdwowbrZDjMpJanXonY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GrCqxWOuKPe++NC8isTH2bRKEmr+2/F4wsIDx53+K+bY9l8Pos/zS6QOWQjf6ZdbcD4szYtxfsSwjIv03FecP6TdDbbKdCKTOMRZ6jVmtk6VPwIgdkIOLXEExDQZf6WkdcvUdrc8orrgoouEcRyxb9CiQ2c84e4hfQKmY+DGxA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXL86dg+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXL86dg+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151801F000E9;
	Fri, 14 Aug 2026 07:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786691514;
	bh=yzZEaCYNl0WAhu9QarmFmyKkgKcKM/5WabGXAm8XYGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GXL86dg+6eTDRTWDJPYhJTx5Ayf+T7Do1Wb14Btm4d7nQ5xfh4c9UDv9mf8pD0QVG
	 qRSloi2dU1BA8OB+8LAUTXBaPuEVCDdtrY56qNRJ+tCPCnCUzAwMPc4srjW6R84zqL
	 nIInzUTl/kgGfGVN+9y8IOdCAJB1uEXncdmCx8PtLzzZBalhuSjyUpBh3/ofnKPikS
	 YFNka84NoHSPKXsGxSGfuySWshWMsjP7pjIUilbf7xpAVv+aq2yZj6WfhfpxcvHJtE
	 TJZhoj+1+IjvykOncEiKZBe7f+tgRSXtjsDBgSIS7tFSaL4TusciLLZ95neJVELxK4
	 w8hzLMRetBT0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] PCI/sysfs: Decouple acpi_index from the optional
 device name element
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260814070522.2327975-3-kwilczynski@kernel.org>
References: <20260814070522.2327975-1-kwilczynski@kernel.org>
 <20260814070522.2327975-3-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 07:11:49 +0000
Message-Id: <20260814071150.151801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, dsm_get_label() validates both elements of the Device Name
> _DSM result in a single conditional.  The _DSM returns an ACPI package
> of two elements, the instance number and the device name, where the
> instance number is mandatory and the name is optional.  Firmware that
> implements no name must return a NULL string for it.
>=20
> Reads of "acpi_index" therefore fail whenever the name element is
> malformed.  That attribute exports only the instance number, and the
> two elements do not depend on each other.
>=20
> Thus, validate each element only for the attribute that exports it.
> So "acpi_index" now depends on the instance number alone, and "label"
> reads fail with -EIO when the name element is neither a string nor a
> buffer.  The package elements pointer is read only after the object
> type has been checked.
>=20
> On platforms with a valid instance number and a malformed name element
> the "acpi_index" attribute starts returning data.  Because udev derives
> the onboard interface name from "acpi_index", an interface on such a
> platform may be renamed once, on the first boot after this change.
> That is the attribute assuming the value the firmware always
> provided.
>=20
> Link: https://github.com/pciutils/pciutils/issues/175
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814070522.2327=
975-1-kwilczynski@kernel.org?part=3D2

