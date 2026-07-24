Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE16322749
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909408; cv=none; b=iYLjoJ3moSdkPKXAInCfatOCzhRx65l20biCWllW7+5sptu7fhM+Idr/mwPg5Lu3kSXrZdzZGmoRxhCWC0Pd6GO237aUrdW3xV1RqAhYVArbzAzVOmJHDxw6nJhYRasF9baDCctLWJLzJwgQoIDWqSxz6CdnTGaGZk5v5oyouLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909408; c=relaxed/simple;
	bh=YiiOLLp2CnXXGm4HsGt0tCSCtEEPgptnSSOnGZErwyg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kgeYPHAaV76BFRvG6FtBA5VzVMPjUsQamuHGHWDae2otJezlE+uyVjuPaSUuWysT4CVZ8RLgESY3lJKdDAG0ULZ/79K5+seEI6td1OktdOc1ZyDmXthNQl53nGrI7A7exB4mJd/HSNw2InCJuKKZ5h1ICw9hi51suBn6zCclPIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbpnJh8A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbpnJh8A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F092C1F000E9;
	Fri, 24 Jul 2026 16:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784909407;
	bh=AexwZo26tmh2h/gS7r+OtpWUAkYwVT+bPiDqPKL/P+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GbpnJh8AhHGegVkFYipkYxE1M+AvmRmjJvTpedeRMb4FM+8GcWD09fCfeeBvhgsM1
	 RvGdbzA7NTD0kC8Ac4MjgznHVF5OXcU2rCKqct6Zenu4y1SfUx/W3/zfw7Ahiz/rs6
	 kf6dFJNhK2WbV8cI8YajY0eppXnrklnrJiD4j/PAtxIT3+RjvGtLJNr/+hbPfvGOMd
	 VjXDwYjVryAhY3o5cqmD61k0w5yH2gJ/UpgDHbD45oLLJ3NqVH2R8L2XIIitDLxjM+
	 DaflM4Z/CdoxB9LBw6dmbxmaRrtEaABVUXSKtVn0L6XHRdDJ3O6LYu5fls4ulL+1gq
	 rDHUH9O7n1TOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] PCI/AER: Deduplicate logging of Error Source
 Identification
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <3a5d1624d6912db1bc8c4e89e7a6a72ac510f4dc.1784905909.git.lukas@wunner.de>
References: <cover.1784905909.git.lukas@wunner.de>
 <3a5d1624d6912db1bc8c4e89e7a6a72ac510f4dc.1784905909.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 16:10:06 +0000
Message-Id: <20260724161006.F092C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> aer_print_source() already logs the Error Source Identification Register:
>=20
>   AER: Multiple Correctable error message received from 0000:b7:02.0
>=20
> However aer_print_error() subsequently identifies the Error Source once
> more by emitting an "Error of this Agent is reported first" message.
>=20
> The additional message was introduced by commit 0d465f23502e ("PCI: pcie,
> aer: fix report of multiple errors") because it deemed the message emitted
> by aer_print_source() confusing:  When the Multiple ERR_COR Received or
> Multiple ERR_FATAL/NONFATAL Received bit in the Root Error Status Register
> is set, it doesn't mean that all errors originated from the device in the
> Error Source Identification Register.  Rather, the errors may have come
> from multiple distinct devices.  The commit sought to make that clearer.
>=20
> Achieve the commit's objective by rephrasing the message emitted by
> aer_print_source() and drop the additional message logged by
> aer_print_error() to reduce dmesg noisiness and simplify the code.
>=20
> While modifying the log message anyway, fix minor grammatical issues:
> Append a plural "s" to "message", add a missing closing brace to "(no
> details found" and capitalize "Error" to match the spec.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784905909.gi=
t.lukas@wunner.de?part=3D3

