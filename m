Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F9D393DCD
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791320855; cv=none; b=damBf6qio55F0lHniOjctRBRHgtjEt5aj0YYe0Y1xE2wED+ZoC7NLVkvZvuIyzQWb4CGjg0wvj4FxEx5w2fiJY8hhzTKESAIc2uC+k5FKkOl6AZw6lkjIaOVEKhuqi7HBHipI9JKITNBcPyU406AAoAiY9wHxPvE8sm2epApbtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791320855; c=relaxed/simple;
	bh=9bDTHKLFdTlDKieSq3caYV+S3IZX2gGF9qRudKy+0bE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=O4522cFhfOAEbCPf45AJujxba0ShprvVECfOiAUyntcK6MQ3BHCQ35G/BuV0+Mx4JAGHaFw5RzcA7IX8JY8+z/up6zGBZr4Tug5rTnS5ZGml9qSxr3mUUXkFjXskgAWCwb9snbFZGUKUXOuQs6hncWs4N9Laaupc+sbmzEn1aSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaWbRvHi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaWbRvHi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA201F0089B;
	Tue,  6 Oct 2026 21:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791320853;
	bh=9bDTHKLFdTlDKieSq3caYV+S3IZX2gGF9qRudKy+0bE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AaWbRvHi76T1iv9Nnx4DDKtT6uMflrx3q0canW1QZk70u8oLpiFAtOr3wOlmH9H9M
	 ZK4ipIfmNaAnS+OJg5GVWEa5E0uqb46GCbRvLeFxYe1coBidvQ7nCNoRU6UIoQ90u9
	 aV0+CprC0uTYb/RkgSL/gsCo/6+FSgCZtjFTrT8BfnD1wXSw/Ae66w7HlVkDoBod+e
	 Um0YVkslTUQGfLxHQCI1yZ//kf5ju6EYCkL2itcwSOnPjcDqbtZ/YhNmF0FV47Lpe3
	 9xNaLV5RPyO3VAToAfc6qHdK8hBKWSyBCG0EHVv1OAaJqtIQD0y9f2g+FF+FOamgNJ
	 wBSonJJVl1IYw==
Message-ID: <sashiko-outbox-162448@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] selftests/pcie_lmr: Add tests for the Lane
 Margining debugfs interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261006-pcie-link-endpoints-v6-2-154d71657d32@google.com>
References: <20261006-pcie-link-endpoints-v6-0-154d71657d32@google.com>
 <20261006-pcie-link-endpoints-v6-2-154d71657d32@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 21:07:33 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a KTAP test for the Lane Margining at the Receiver debugfs
> interface.
>=20
> By default it only runs checks that do not start a margining session,
> on every pcie_lmr_* directory: the files exist, malformed input is
> rejected, and commands fail with ENOTCONN without a session.
>=20
> If PCIE_LMR_DEV names a port, it also starts a session on that link,
> checks the receiver and step bounds the receiver reports, and checks
> that Link Control and Link Control 2 of both ends are the same after
> the session as before it.
>=20
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-pcie-link-=
endpoints-v6-0-154d71657d32@google.com?part=3D2

