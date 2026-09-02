Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80D439E18F
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788379315; cv=none; b=kpFPPdotzhW+6vFIRuc4+6OQF3g3THX3IxT7P8udAXcqW/fEaLansWY7v/krEfjl7jD0zCMGYGS/jBb7N5unLL4BEDkVce5Eb0kgUopOXcb5nhCsxGF6wentI+uwInJTKmDGDdMiLkxW022epL+Gr0/QuDtvwZqFAmd1V0JEq1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788379315; c=relaxed/simple;
	bh=vLSLZMlSaH1eAuOuxqb+fT8Z+yxnTWghXKlLznnt8uQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IY289ht4evXVlEYXvQAWPz9OdDCFUafeP5yizBCx2eRjbdWwy93JwkNyq/oY/Y32I5xcluCmskQo7vWCDBzXVI1bmOknCJksTFPSSzldTaq7dc5djwej7lDKQ5qTajVBm/kyIzd0bKqoxsvlzy+ni06n/D07sPtbWeUTZ22kErw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eh0njEHD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eh0njEHD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDC71F000E9;
	Wed,  2 Sep 2026 20:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788379314;
	bh=vLSLZMlSaH1eAuOuxqb+fT8Z+yxnTWghXKlLznnt8uQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Eh0njEHDCKn2JUV6wlTXgErT1d8t13Sk9YFjfK7MRewmPnjeFCQNqd+r6YVHh5FK1
	 /ma5CCTh6a/mZXCVb3qJPiIFZXB6pkdBN4ptMXn5njBQ04M+Py7exj45U5tsM3M4oz
	 VlDphr+ippg+M5llPsecmDo2598LgeqN+LDk78IFlTrhpRcIWqUaGBsBEzgtx1p8ir
	 fc+JfOHa52mQ7MOQdp4uP3Fzylf5xd30CnYC1g3VZEn/6Ik9SETt/XJTWfwmHZ9nXJ
	 jLcDNvvMttCxo6IB9/xdoMlGgDjgkHcQz/lQ+cmbryPaNrPiiDD8zHVIUBcjRZHRB1
	 X7CFC/74XL8Qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] ACPI: scan: Combine two conditionals in
 acpi_bus_attach()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <8743568.T7Z3S40VBb@rafael.j.wysocki>
References: <5144065.31r3eYUQgx@rafael.j.wysocki>
 <8743568.T7Z3S40VBb@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 20:01:53 +0000
Message-Id: <20260902200154.2FDC71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> There are two conditionals in acpi_bus_attach() that can be combined,
> which slightly reduces the overhead and makes the code a bit easier
> to follow, so do that.
>=20
> No intentional functional impact.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/5144065.31r3eYUQgx@=
rafael.j.wysocki?part=3D3

