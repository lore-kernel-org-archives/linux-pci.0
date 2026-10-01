Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C297360EF0
	for <linux-pci@vger.kernel.org>; Thu,  1 Oct 2026 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870681; cv=none; b=S5Ks7cH+Q+gEXRSgL38URmO9Oq7KrXklHvZDqlbx1+IpC8oCcaJBbam0tCaifEppThB1Ot2FokzU+mx6v6sKsa6NN+JlzG8jqTRmKojf0o7kUy9tLQnQf2JNnb5tf/8ZLmV8F20l+05rFwa+jSYrxX+wQORMpFIJb70VOgcTzkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870681; c=relaxed/simple;
	bh=WqeZOyl9WYcfDPVmtE1Pp8XotgNarrmoX9goyjRjBe0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R4d6A+asinO3mZPE2CN6be72HL+C5EiPqMxM2sHwm5Kv7jpDmvJnyBItRLBVjNjU7Y0FSw70drahgt1RuUNAOcbB2/zDL58tl5EdcTfMLb4s/kQsfQrlvIxI2cX8D0dg88TU555fCoUeBZcdd/xDkawbnBS1m3C3KXvTNmmfBUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZWRw98Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZWRw98Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD3E1F000FF;
	Thu,  1 Oct 2026 16:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790870679;
	bh=eRXHTzQFuxMpSqEsnQz/tMPtIw94RE1I1jU3SpB/T0E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kZWRw98ZDZUGRKXtg6e7zNKjtiVGZXbXLdbIwPS463cm3I7R48S5ZrH4lYmHVN5B0
	 9gM3GZWrUOlRxsAHUR7v6wksxAYZAmr9vji+aLvFSxH5ObPMu8X9JBg/hpiN5Ierpu
	 jMY6f5LblsvWmbLM4JB7FQVQpUPp8kM4ZuquQLmbtFlFNNhuxGelxIizs6uQnpy1ui
	 zriQyIOe6bN/2hk9u84K3HuNX5jOee8I/JrhB2xL4JFuzoDwwWYHoSGMgVGofZA02I
	 KT6ydLOO1akbFKX0ZYXQIWn4ZNtt/rUl3ptJ4//a7Lfo5g/xyFgHrAXaaEPu/xFakQ
	 Tx9S9js+ioRdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 3/3] Expose the CPU/Steering Tag mapping via debugfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Huang" <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261001155551.4182899-4-wei.huang2@amd.com>
References: <20261001155551.4182899-1-wei.huang2@amd.com>
 <20261001155551.4182899-4-wei.huang2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 16:04:38 +0000
Message-Id: <20261001160439.6DD3E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Steering Tags (ST) are opaque, platform specific values obtained from the
> ACPI ST _DSM, and are only visible to the driver that asks for them. That
> makes it hard to validate whether firmware reports a sane mapping at all.
>=20
> Expose the mapping read-only in the debugfs directory of each Root Port
> that has ST _DSM support:
>=20
>   # cat /sys/kernel/debug/pci/0000:00:01.1/tph_cpu_st
>   cpu  vm_st  vm_xst vm_ph_ignore pm_st  pm_xst pm_ph_ignore
>   0    0x03   0x0103 0            -      -      0
>   1    0x03   0x0103 0            -      -      0
>=20
> Each line holds the raw ST info the _DSM returns for one online CPU;
> invalid tags and failed queries are reported as "-".
>=20
> The interface is per Root Port because the _DSM is evaluated on the ACPI
> device of the host bridge above it. A system with multiple host bridges m=
ay
> return different tags for the same CPU, and the value that matters to a
> driver is the one for the Root Port its device sits below. Root Ports bel=
ow
> the same host bridge report identical contents.
>=20
> The file is created during enumeration and removed with the device's
> debugfs directory in pci_destroy_dev(), which returns only once no read is
> running, so the pci_dev the file refers to stays valid.
>=20
> Signed-off-by: Wei Huang <wei.huang2@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001155551.4182=
899-1-wei.huang2@amd.com?part=3D3

