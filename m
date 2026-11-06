Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984519;
	b=bMoWayPbG2+Mafy+Q79PIwxjTofpQlwS7cMjLlG1pstrgAyMsUtNxTr0MKw4DBDP1XXT
	 57+qteONlPovvRMtahIzqKwbqRjMbZqy8DeF50hOXV9RVN6yeL3LoWvgW+wYnmYMadAm7
	 tc519G+o93wFB++V+A5qkPwTEs9nrw0qV1QUIpb2UmZfkgdMh/g2ivPaCs0n6guw9gR7M
	 niCjFi2A5N8+MMRAOkJrIN3v+3Uzj0Y6WftFs18FqLfAMe2/8mwqSbEXoYHl8eVp0xngb
	 SlbmDWrYEDyHp3gbZoP6QVZ3b0Uj2CR1ng2qGda1gAp4gEZH8gC62P9Olp57PUsZfxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984519;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v/xOB2hePFnloUB7LYh16FpBW2pM0Coy8IuywP+U/4w=;
	b=FDHf5OMRX5qU0jpLRbI0g1r85CM6r6VvcNoa0vuZOz8zM8mZ2aHtx2q6CZxmdgalg8h3
	 oSUSdyYbqohB98d0l/Z3AgSFGtXIdNAi1m8PMWH85u1lDBsknIGcRxFqfdvdHkGZmAyfB
	 c0lOvZJ9l/E+GAQLrLmpUDO794MWxOdDBFj6mRg5zImEewtALVGt2qJVIVloBCgcf/XkD
	 Dl2RgLnqZzistVwrhqbB+QpVnrhZapyBznJ3ITWvHEItp6LmNitJXjAbhpxrGFGt74hNK
	 ZHSvNR53IvsHr1dSMIIPH8bcI/NtR/TTz1b8BZXA3sUogkvGBbTSgxccY9O2KhPhRMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ih2vYOAl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3727606A32C
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ih2vYOAl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C371F0089F;
	Fri,  6 Nov 2026 17:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793984518;
	bh=v/xOB2hePFnloUB7LYh16FpBW2pM0Coy8IuywP+U/4w=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ih2vYOAlG1ypwVmV7WhHTl85NR0nUlrpzinR3Eu0+zjcQwmOIYOYl03qPvLKFOBql
	 2apu2gOss8PBPh8af9lGvgRzdApAwC2T0Su76AQ8MRir7Ze8Vju0HhN+EGyV/50BIY
	 QLLEs3iDlNxiMkV/ECN6ZTLgDxiYHYn476uzecdiNxPniAOmKn9lTM6oBT6/XSEC0p
	 Wpjp4EdaH9vVhDZXxDq57Y5zl9bHrY9tnAxg7di/MtqfOhMdzuN9ggJAE9rDWYrnfC
	 ZrFphl+nqDBoos4X9ohaNMPAxiF+JictBKvgF5wC6vL07G2k4lwpGHMSKIfrAji/fS
	 6zTgsjoZRagJA==
Message-ID: <sashiko-outbox-201888@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI/AER: Avoid NULL pointer deref on search for
 Error Source
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>, linux-pci@vger.kernel.org
In-Reply-To: <7fb629b44a64b5b7ce0359346a61dc7d32359ca4.1793982724.git.lukas@wunner.de>
References: <cover.1793982724.git.lukas@wunner.de>
 <7fb629b44a64b5b7ce0359346a61dc7d32359ca4.1793982724.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:01:57 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> A Root Port's subordinate bus may be NULL if the PCI core runs out of bus
> numbers on enumeration.  Yet when the AER driver searches for the source
> of an Error Message, it dereferences the subordinate pointer without
> checking for NULL.  Fix it.
>=20
> Fixes: 28eb27cf0839 ("PCI AER: support invalid error source IDs")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793982724.gi=
t.lukas@wunner.de?part=3D1

