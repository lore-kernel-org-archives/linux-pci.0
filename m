Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421833A9871
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211403; cv=none; b=G/wyt9MvLcTcr3sYlox+J61gIq6KGabFYlvPPnFUcpacn7H2dGZAlp083BPddrV/91glcm5U+wdtJi5tFi1T0AxEjNfXJnOsxC9T0Gg57/SMrNplsja7APzi4Fedt9Z3cyYiO7jU6OBpmS1ef8ibWDUlLhBXmz/sdMUjY8fWZKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211403; c=relaxed/simple;
	bh=VYZE0nAcvprEH93zh62ikZlyk6t3BMK2x/zxTmmmGjw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HVGnhNbjcp7r3LfCNxPuekO83gTSYGvBPjXYDu/LZp74wf59PMcsONzSw/moV1mqvwanxPREC17rAZapsecNn3tvlAwYWrYAE7kBOZ+NcVMqv6g/rQwTjbJir8+a6qB3ml3DUcT1tdfiLgspE6RtTCKQlgyCffJvk4x5GjwZyuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i936lf1Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i936lf1Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18601F00A3D;
	Mon, 31 Aug 2026 21:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788211401;
	bh=VYZE0nAcvprEH93zh62ikZlyk6t3BMK2x/zxTmmmGjw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i936lf1YeKog+mTkCLyvZDR0ZK3Gey8ESwsXZtz+sj+hkp/W5p92rp+z5/sY3afMr
	 rMWfw6EeT8eG9JjRE9aJP6kuG5Vv4sPD8iIeVFWbAE2i9aaB7E0GB8MXYQexonlWpx
	 xlJB3UpFb7r8bRBFqLse8W+nW+Un9xeLFWLn/AvcKBcpcYvDCYG0yD5i97o4KzM0qe
	 vizo4PUT/jGFQnuynnNMUJHva5bh9ZvtbUnddgdw+OAeE4qVPB0Kk6k/xIAHs5aMU6
	 JfRLQe+VUkictyaD968sskV81uxPVBn7I2Y+icRY59QuOM6/vatYnpllmwUMFVmlg5
	 1VZGRey0mIAcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 7/7] ACPI: scan: Take PCI device enumeration into
 account directly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <2497062.NG923GbCHz@rafael.j.wysocki>
References: <3435655.aeNJFYEL58@rafael.j.wysocki>
 <2497062.NG923GbCHz@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:23:21 +0000
Message-Id: <20260831212321.B18601F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> The ACPI companions of PCI devices are associated with the corresponding
> PCI devices before being processed by acpi_scan_attach() and by the time
> they are passed to attach_subtree(), the PCI devices associated with
> them have been already enumerated and initialized (including power
> management initialization).
>=20
> Accordingly, it is not necessary or even useful to check their status in
> attach_subtree(), so do not do that.
>=20
> Fixes: 2c22e6520ac8 ("ACPI / scan: Use direct recurrence for device hiera=
rchy walks")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/3435655.aeNJFYEL58@=
rafael.j.wysocki?part=3D7

