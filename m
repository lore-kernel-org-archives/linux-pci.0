Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B813E44F6
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 18:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274391; cv=none; b=PdztqZBR4MxLEfwhxnq2g4DLyOH2yX6s66MGF3iB3XwRggAHbulRM6yVsWl+AaOkpiCGaM+1UXaT59UMqku7/osXFG73ttWYZakCZgVwVU2QkD6AYDW+/+FV4L2O1Gs8X9+gWoC2Xvt6RI1a4z5+nGxZghGG7QJf4P40qZhTcBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274391; c=relaxed/simple;
	bh=VqJ99kE/pDS0yZ/zWLN69yuMsbNLoNnf6oLBVkqwFhI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LKQd8fm5AQ0NO4CLQIc34iQQuNQfSN2kLSu624OxCyNinfUB7SsR3/XK9U+IakPYcXDUpgQhRYxVzOLHetNZ1K4rsK2SLPCdUNCobphl8Y9Nks++5McObdsYwoLD1yl60KCY3mbadYgYS6pVUuepYkXH0njzdDZ/CIJIl2UpRjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoDvsOUL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoDvsOUL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFAC1F000FF;
	Thu, 24 Sep 2026 18:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790274389;
	bh=VqJ99kE/pDS0yZ/zWLN69yuMsbNLoNnf6oLBVkqwFhI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WoDvsOUL2xoZdE+hJk01yw0GIWXyPLJrsFVP4cobxn9exRd0wYc6wOMHkcPQH2Ge5
	 HtHlWEu3EX4NKSueeZnplgzIZvmgpQDdxu1nTcYTWr95G9kVa57sKbzUqkCXegpajg
	 a81yMJPyzL4L7A6no6V9fi6DEdtxBQTBcy+9c714jrWo7tnmUJW1BduQA2GEREms6S
	 eIVAdDsMZhoTVOKQ4boyg6kh5EocJsecle+Z/OtSDl8kqVZUVuO5tE/hbpzxvS8cM0
	 yWaBPsEIAjv0+njMY1rospf+iSLqhDslW5y/UU43ORW8xA05QHT6UxXtcfOa8wStTW
	 4jL5Rl+Pel8UQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/15] PCI/AER: Save AER state in the saved capability
 store
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260924173501.856380-9-dmatlack@google.com>
References: <20260924173501.856380-1-dmatlack@google.com>
 <20260924173501.856380-9-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 18:26:28 +0000
Message-Id: <20260924182629.4EFAC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Save and restore the AER mask, severity, capability and root command
> registers through the per-device saved capability store instead of a
> private pci_cap_saved_state buffer.
>=20
> Describe the registers in aer_saved_regs[] and drive the reservation, sav=
e,
> and restore loops from it. Previously the three had to be kept in the same
> order by hand, and pci_aer_init() encoded the register count as a bare 4 =
or
> 5.
>=20
> Report a reservation failure. pci_aer_init() ignored the return value of
> pci_add_ext_cap_save_buffer() entirely, so a failed allocation was only
> noticed later as silently missing AER state.
>=20
> No functional change intended.
>=20
> Assisted-by: LLM
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924173501.8563=
80-1-dmatlack@google.com?part=3D8

