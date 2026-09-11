Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A71477990
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130727; cv=none; b=MkcoJAPUimDDpNztwAIVgBmA8XnRooPLnXk0j0Ap5irRYbOzMgCfCY6udrkr30drBwcUEmAuWwL4wz+DlEk6OMpIbofQGzgIOcK9l4rv+FjIT0xmTsiL3yPOf6ouiXkRJaD+qNrfAgQkKvslqOPbAz3dvPF0x2Q3knaRnO9YpCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130727; c=relaxed/simple;
	bh=LtpRJ6n51gG+dsb+SzEhjaye6hSI5T8QgI8kw1+PF0M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H/ncTX9vHe3A4/I2S1aDms213cz6s/yScCLdCCJCIfA6cirXrTentu/R169gPrs74gVyakMhvF/WL7YuE0ximpjMnxG+896mpycq9Sypl8ZyjiJ1xdB4gS0+4qGgWzqKDx71bYQqehhU3F6qsksuwS/DRfp/3rivd+ns5O4FDmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjL7M/EC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjL7M/EC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2D91F000FF;
	Fri, 11 Sep 2026 12:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789130725;
	bh=LtpRJ6n51gG+dsb+SzEhjaye6hSI5T8QgI8kw1+PF0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DjL7M/EC7LK7Og7iL6VNzvUmalmrDm4kRfaq2lg82yqsRQwTL0rkbND96i4V/RGWG
	 iUK+qKoYzCPBrH9DwXgvKNQc9DhgdpBf2I8r5oykJGlCepUkLc7q9FOj+O3n6AN1vX
	 RmO3OdKhMeL3HrEeASjv8/BKKFstrjWrn3wl/+NNt5TZ5p4c6JUf6ihRlDG8+FQXDB
	 wmQ+QYh0G5zCkjWdD3/V3nxgdaMrV03PYgxYpMgdqnHsn+wXRiwF6gbXtfRXyhgPKh
	 1UTP7Qk+ClyrfBMCQkJBand5TWBd0gugP84rxKA2cSVokE1meiR9JWH8oy8/uyt5RZ
	 A2Op4aPidcqVA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/8] PCI/IOV: Split virtfn bus handling out of
 pci_iov_add_virtfn()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavol Sakac" <sakacpav@amazon.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911122804.80063-1-sakacpav@amazon.de>
References: <20260911-vfopt-s1-v1-0-693271dc0226@amazon.de>
 <20260911122804.80063-1-sakacpav@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:45:24 +0000
Message-Id: <20260911124525.5A2D91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_iov_add_virtfn() creates the virtfn bus, scans and registers the VF,
> and removes the bus again on failure. A later commit creates all virtfn
> buses up front, so separate the bus-lifetime concern from the VF-add
> concern: move the VF add into a new __pci_iov_add_virtfn() taking the bus
> as an argument, and keep bus creation and on-failure bus removal in the
> public wrapper.
>=20
> No functional change intended.
>=20
> Assisted-by: LLM
> Signed-off-by: Pavol Sakac <sakacpav@amazon.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-vfopt-s1-v=
1-0-693271dc0226@amazon.de?part=3D1

