Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB9D4BF94C
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826952; cv=none; b=Bv8x/aL0LZUqM43OhmSryxMM0FfohvA1bnFWAehHkkNFWH2IZAT6rleYvjVbUheWFqcS9oHh2vScWGl3Xw/YwytM91kulgZ3mDQS2EKUpDbmbb1M0ONgjl96V6+BzpfuqOHsmHQIirOEgiQhTN1b7ypaWVbzEmafb8+XNRrA5g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826952; c=relaxed/simple;
	bh=9gQggwGhQI4zVdpLC41UbDgrPqegUx5Fn1QgUFstBBk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QMEMRX/p8IM5ci1ymJo4J6Oc4vpqPYF/+1ocm/9ormE2pkINPXbW/2Bv7MGB1KR6vhEwc04H2GzeunEpqFy+H926EhC2O6jEg3bKjv9f6oj0DKKhJ5TiFmVOVNZLZTtqhfYlpr67cTJPeoSLD5a5eBqBzRoDzfhjBg3f0VGYUho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mU4WQSgK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mU4WQSgK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB081F0089B;
	Mon, 12 Oct 2026 17:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791826951;
	bh=9gQggwGhQI4zVdpLC41UbDgrPqegUx5Fn1QgUFstBBk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mU4WQSgKypODXh/jEDasFcePbdxzrwMLCIxFpyxrtzbWm2JWumA8p/cOeBM0lZ1dn
	 mAf6CwFvCzRWC2gdypZGoCTeC6MS3a85XkQ9ynzj4/Xub8WfnDM53s4oYNEemUJ8o0
	 31eAD5Q5n5jOka18QCjgUlYNc1YG7NHHGrPEmEKkEake41aM32kteAuQiRya8QgXtR
	 /XhXgekhmPvVVcVuX+fro02SVbnd86xxWY9EunXRKH0nzAEzmcIVZIXL4SAu0rR3yB
	 Jrh7i3MefvahqzJqjK2wR6f9mi93fogOYxhbWr2GRAqAM51/PxN4oGQT7D2WNoqZCa
	 SxqgnJwEBVZ3Q==
Message-ID: <sashiko-outbox-168480@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/2] selftests/pcie_lmr: Add tests for the Lane
 Margining debugfs interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261012-pcie-link-endpoints-v7-2-36aba9c91f10@google.com>
References: <20261012-pcie-link-endpoints-v7-0-36aba9c91f10@google.com>
 <20261012-pcie-link-endpoints-v7-2-36aba9c91f10@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 17:42:30 +0000
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
> checks the receiver and step bounds the receiver reports, discovers and
> tests any retimer receivers on the link when run on a Downstream Port,
> and checks that Link Control and Link Control 2 of both ends are the
> same after the session as before it.
>=20
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-pcie-link-=
endpoints-v7-0-36aba9c91f10@google.com?part=3D2

