Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5B839023D
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 08:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788598624; cv=none; b=T57wACb90uydbhF7Wwx/NgzelpMisYQJjzT6ZR2O1UTlN7LxzRanWz8JDfj0VjwQxSvogAiyhYa/Zb/Q7q34Q0FVsPCDUwARWnQJiIn6JBgew/XiDkVXkSHL3VCojTE6vqJtyEu2WvuC9Pz6jGrSCn9Q2Rhzgk1t0u8ScvQiIck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788598624; c=relaxed/simple;
	bh=xawi+MOiXrwhZanTqMDyJxnteFr7H2434XIPPFm4oqg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bmE9lZ+Z5RKG0n4myfZ4OmFu6b7NztaeTEg+pqQs8/9Gvjptys3sN/SijYV0U8tsPyiPc/t+EIOKio+jpBfxiAozcasDP5L3MjrB7J4rVQ/vtcZldvVxON4cShA00T5ICVEw9aC0Zlk7sT1xtOiN9ASFsrul81pl5FgfueOH4V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbRRa/fL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbRRa/fL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C219F1F00A3D;
	Sat,  5 Sep 2026 08:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788598621;
	bh=xawi+MOiXrwhZanTqMDyJxnteFr7H2434XIPPFm4oqg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MbRRa/fLHNfrpoSRlWVFvsTRXR6LE7Kg2ZXTeIdCOunObcGqjQ95bYP/nmjxuwsg8
	 kkTMiE1pRSkePbz3PlAuEQnIhRgTYNsWPJm7EGWaV0sfj5/kKmVmsCkfK6VmZRt26g
	 8Yg53p442bPmxkpMtdUy6X+Y/XRlbW0AdmY5uFn6kVTmCK2FDF5g2U/8vP6aj6owkr
	 IvDZGEY2VDQWgqzPczFkjfeVIZNBdKReUrQufYbsPxGpjGDHUsbcJqEsOTVuAiD2wh
	 SNMrUoZXMa+pl2WhH8ohklBaQ/nagjQlZ9xDlPYPNY8tSZcXZaZtuYovUvGvvhnqaw
	 CsFRAUGHIvVyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Documentation: PCI: Point the pci_device_id kernel-doc
 at device-id/pci.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260905084916.40196-1-kmehltretter@gmail.com>
References: <20260905084916.40196-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 08:57:00 +0000
Message-Id: <20260905085700.C219F1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci.rst pulls the description of struct pci_device_id from
> include/linux/mod_devicetable.h. Commit ad428f5811bd
> ("mod_devicetable.h: Split into per subsystem headers") moved the
> structure and its kernel-doc comment to include/linux/device-id/pci.h.
> Since then the directive finds nothing and the rendered page no longer
> shows the structure.
>=20
> Point the directive at the new header.
>=20
> Fixes: ad428f5811bd ("mod_devicetable.h: Split into per subsystem headers=
")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905084916.4019=
6-1-kmehltretter@gmail.com?part=3D1

