Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D6A415F3E
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148211; cv=none; b=VhMwHFJZk4UUzK8bcMZFDLTLU0WA0SaEZe4Ipa2jM2LoyME2RsrtHj9P4MROg0fiTEBnLEPJ0dVKJXJWE9/j52i4Rw6GQe4FuIMMTDnhgpseAeu+ja3s4giXpHn4PvOuE/pwBYUs2YFy63QKTnjr4QNXSiSZXMeLF/oD5EBm4Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148211; c=relaxed/simple;
	bh=4OgopQ3I7rQAMXzp9k5LGbihWnB2OsJ5r2EzInf3ZTA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JclI81655PinMdoAKkGwOk/SGMchasaGnB+PHGcpMZClln+NlBq7WXi5NBgPNyv0emMGC6JjexMEc6XPXN+8/9BN6g0x7ajDmTJzKc0Om19D7rMu6kGlbln0H+6kQ5A4cn6q2WqleJUlphwHpG2tsEV3J+ooOB2xneXAv36Vyvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDHPuxEe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDHPuxEe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A001B1F000FF;
	Wed, 23 Sep 2026 07:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148206;
	bh=4OgopQ3I7rQAMXzp9k5LGbihWnB2OsJ5r2EzInf3ZTA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UDHPuxEetWYV+YCZ7JlWukfKjUSUShSw6vDG2WTIphryVVns+OJyeW+G/O6wqPEd3
	 MClLXHKUXaS+YR84FcHtDkvXajolsBk4zJxHYdzFixoeVLaJZjP2eGk7Ue101phPdd
	 WW9p0t3A+AsOO2dj127zMYa8cJuTrw9J/t8DjZligxihLITSNFnrW0Prioy7vsux2Y
	 lhllMMuBOWNW3jgiGeSFtZOj9Ho7i4BJcRe6D9EDfdSR5ubNe4ZOLJjyvBQDbLkZPK
	 lfMegQXbFJ3VL3lu2G7NW1ifNzcrhTNJdc/5hTzAQaIUFCN0bXhBVmsr08RiCV2M8p
	 ROAazeYZWShnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] PCI: dwc: Add RAS event counter field masks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260923071706.1134320-2-mmaddireddy@nvidia.com>
References: <20260923071706.1134320-1-mmaddireddy@nvidia.com>
 <20260923071706.1134320-2-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:23:26 +0000
Message-Id: <20260923072326.A001B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add complete bit masks for the DesignWare RAS-DES event counter
> fields so consumers can use FIELD_PREP() and FIELD_MODIFY() without
> open-coded shifts.
>=20
> Keep the existing shift-based definitions for now so current users
> keep building until their call sites are converted.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923071706.1134=
320-1-mmaddireddy@nvidia.com?part=3D1

