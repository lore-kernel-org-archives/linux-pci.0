Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E561FF7C8
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455951; cv=none; b=ZdnFwYFWFZR0ZCytW8qTDPh5J3Jitrfk3I0HPF+11dD9bV/EhgGk2FBsGJMPYp0w3zUsqiqyLJZv21zTwIq5gDlS4F36M+vSNzkMVRjbIDUUaK33DExhXk+g2aZ7UX6aEh3MBpmOkz+Qzb0M+bXRZYIHs/zuVlItJMY5HmB1gkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455951; c=relaxed/simple;
	bh=QHxVQTSv4bcEr0VSUiqCmdmDu9gDesUNAGGtXT6tdpw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y6Asb3QxRp7qBqvzb3/TibqvHVgsrwIuB0jeDW6ATPUZ6xO9YXMOxXrNrvdz5wTvwbBCA2biF06jskpO20O7M4nxt1/7uSEAIrynEGlr6C3yMsMVa2BFGJhN1tCn2VdKB2yweDqqx5+oXjrpvjBpkGu1DKzKi0MSO2gLRp9/NB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCGVdaRr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCGVdaRr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F061F000E9;
	Thu,  3 Sep 2026 17:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788455949;
	bh=nL+SX72WA1oBs/j59kUk9NFUID+ez4eEFxsL/H/fj2Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HCGVdaRr6aJd+y6ZY05k6EGVS3Pu8gsbwgR2c3BpwHCaCN6KD+b9KVT74Ht+MhkYR
	 xWX2ehIdclSKPHefVvbAbV2kCcdGeb26qT1EmCMhX23pyXs4E87hD3SSOKGGP2joXv
	 cpqodrvkfmzB1HgXroamd12di+dK/Sfz/PQ89rhRVjX4EsIZ/QEVWwtmhK4lrgZ0hY
	 jFa+VpzTNlBYaNiZnGmz0bjj9DrMI9CUXs/eT7JeKHuKPOf7iOtwv7zodhT3mR6xuH
	 yUHLAr7NEn2Nd2HmFK2DlCGSFqhEZ0diJ2uBudO2zcFjpNiUNqLAuxU+l1yzilsAVZ
	 VcsjLYLOp+TiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] ACPI: PM: Drop parent state update from
 acpi_device_get_power()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <5147279.31r3eYUQgx@rafael.j.wysocki>
References: <6044499.DvuYhMxLoT@rafael.j.wysocki>
 <5147279.31r3eYUQgx@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 17:19:09 +0000
Message-Id: <20260903171909.A7F061F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6044499.DvuYhMxLoT@=
rafael.j.wysocki?part=3D1

