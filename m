Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A04D415B85
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531746; cv=none; b=Tx6rSjerwMyjmTRFRurJ7MzDGEnh6r9XgWQprsuBcoviKSVsFPRd1CE+RUrq26hbsc3D2AnjPhYWCeKbPVcgYwRfCZuWUH56ZF/uON+KpY+DR134oTI++zqM8HVIR7fY0OJ3Ox1BFeALDVV3B7C5tzy3VvUgxoaZnA68Ks0d/2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531746; c=relaxed/simple;
	bh=AXSCoPAlinGx9e5PKZ4VpU6JiNznnrHk8+Wrclr2yQg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mn7a0WyGgaIzGg2fSRQXfPyADnR0Y2fktaE1IGPtpqLLn3LIJQSVW0nBRsRexoyygvHfmm+rTm5taew0M6ndKVgM8qFFq9+1EWVc2O3eqDbgbKNV4bQ3FrswGBbhCgx+1zFcq1oxbweNF0ih0yUQ6LuuNZgmc0IAWVPx5z2wQB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvDRTLCe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvDRTLCe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14B01F000FF;
	Sun, 27 Sep 2026 17:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790531745;
	bh=uNsM7xAtnQfxBoAUfN54VJCikCXA+wUM7iYhXW4u4b0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CvDRTLCehfCiEfDZB73GdLgDg6Nm6xtGlsKV3wWX0ZtzlWrDW3BRHgt/EeURyWhy0
	 po+1hJBfvjlIJacVqjKr8aCQ2jEpaCb9z17f0rD7d/OfxjJLS2EPDRzpZX1BMBQ8XR
	 GWwK/iM2826ht41V72c/Fz4I0iqLKY4mvh62L97ti/zuRRHtBCyPSqr1uIRHibpC4c
	 XjnRtT6+F6mLgHUt9/KnUjdOiXpRhtyIDpk2HCOTlbYSNkCDficXp4I/ZlZE14vJZm
	 d9Y0vqVEKi9HvVA2LEgB4HPXbsxndUKHFLIIayxn6cDreS6Ilyy0r/+C+C1S7Z8OeP
	 0Ky52mcqbuDyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 3/5] PCI/DPC: Add pci_dpc_wait_recovery()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhin Parekadan Jose" <abhinjoses@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260927175203.928270-4-abhinjoses@gmail.com>
References: <20260927175203.928270-1-abhinjoses@gmail.com>
 <20260927175203.928270-4-abhinjoses@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 17:55:44 +0000
Message-Id: <20260927175544.D14B01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_dpc_recovered() awaits completion of DPC recovery and then tells
> whether DPC recovered successfully, using test_and_clear_bit() on
> PCI_DPC_RECOVERED. The answer is one-shot: only the first caller sees
> true.
>=20
> Split pci_dpc_recovered() into:
>=20
>  - pci_dpc_hp_sync_supported(), the check whether hotplug can
>    synchronize with DPC at all.
>  - dpc_wait_completed(), the wait for recovery with its 4 second
>    timeout;
>  - the final test_and_clear_bit().
>=20
> Add pci_dpc_wait_recovery(), which does the check and the wait but
> leaves PCI_DPC_RECOVERED alone. No functional change intended.
>=20
> Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927175203.9282=
70-1-abhinjoses@gmail.com?part=3D3

