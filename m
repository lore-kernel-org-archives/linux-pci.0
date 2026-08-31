Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244C23932E0
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210363; cv=none; b=am2OxOWTnq/HPRbp/UwNhWCTH23LHFy7CbrYjJyp89hcaFCMOf7HodpglAuH//84ZKyTC4yiXThJyudnjj1fwPgPKB6MA7sHhO5p8qwizPC/cl/0zmkyKRQDGv+MvcE0LkZxR+zJ2imJVUk7/1D7oV2+IsJ+sQmqnj/okrm7fog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210363; c=relaxed/simple;
	bh=yFGb6rQQ/mbYX5+Jn9c8xDmzZ4+d6I6b9cOAsslrjXM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qUojNsBZVCPE1tdRCsKSYVXTtalJNV9XGKL5bIA2lEQ8mqBXMfUBKvV7dS5lBBFOIhn87ZT6/GpEOHhTjhzP4PjKq8KpoxP9VLSpQpx/NhEqKUX6HEv/J+SjWFS/UGgAi+L7Kk0AKQcEh7Qqse//pNJcp76RdUKb299oWalnW88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkIOvvj2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkIOvvj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BECA1F0155C;
	Mon, 31 Aug 2026 21:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210360;
	bh=yFGb6rQQ/mbYX5+Jn9c8xDmzZ4+d6I6b9cOAsslrjXM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jkIOvvj2XE9s8pUu9H/gh/af3glQKUGvtYNXLGNr/RMv4FXC2MQPRocAv4dXJS6Ov
	 HlOycBzdmlvQDtJmBEhoCBQgRBIK+GXel0sy0A9QC01HV85QD+33bsFq9+g/4dZ8PC
	 rta2IyWoK/T+FEu1hS6O81Qz6Kjoai5GSdwvFdI0iXgvyBk9fvF4GGAdiajKyzBH9x
	 phD+qaWJPRtBH6KtaiOOV990Q99sZH2KYp6BCIKp2G6VIAxjo8ip/jLCmljqYEMTpc
	 TiTzalOtiEx7uG3we+Hv0tOi/ZcCJ8ZZz0dkPVIUDm1zW24QVS0loVfnBAgk7WzcME
	 LGNFjv9vTLdEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/7] ACPI: scan: Combine two conditionals in
 acpi_bus_attach()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <2021470.taCxCBeP46@rafael.j.wysocki>
References: <3435655.aeNJFYEL58@rafael.j.wysocki>
 <2021470.taCxCBeP46@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:05:59 +0000
Message-Id: <20260831210600.5BECA1F0155C@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/3435655.aeNJFYEL58@=
rafael.j.wysocki?part=3D4

