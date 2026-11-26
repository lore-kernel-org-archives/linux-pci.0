Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795718558;
	b=1VDcTPFzjEFDgcdQGztD8qnSNfNBXI58i8qCw7GSuKGOkt2IBba5aq1Xj8b9f/mv00G9
	 yQ7yB8yCMUoCAUJKnHgx9gkesFO7AlVUMy/JSAgXwQpY/qTvCp68U2LZAEyP2NaALVlaZ
	 nRA8tHsFHIv9nAO1PeMNPlu+0XJ9mAciYUfSkNBojAaCa24mJIKjvTRqcewOB/VS1jDiK
	 QgCniqWXup1PFz3T8GYV3IEsigK2q+3RDEXy9QuTz0aitaP6DEN45F4cVQwzuDfy7ja9A
	 GddhNhYHbophBnQQG1cuZz8+TE2o6Ae3MRywXas0Y7HZwTt9IlxSUpU0DGS7lyDRWAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795718558;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YPdlr+kBcmJbKA7MDuZ1f3O91RY5uvGdw0lLhmy90CI=;
	b=EhfP7QTBnzIBMqid5cvBZyQwL8pb2E7IEWCVH40xdHTyuJWoqz3y5rm20YKmNMRnEm2+
	 Ly4+k7uhn4w1OBwNzMiEAv9GB9eiJvoLA/WcSkQFRFNufmgIgCtsXhFR44iAtO0GCnCJi
	 SrhYOVGv3IPMAWFySMwKZFMXhiyr3USNVbv98rbUEMhj+Uz2HpBSkwzynttDzC24soGgw
	 XW7KavLRLNacrhnhi8Rx2smt2xui7epofFLe5AeNBr2odOc6W0T/8sW6tZyo29xtPXWkB
	 SkmnI1RiuheCzinov2LomV6TSsN+A7Z2ZamP142xnuhDCsHC3TT/y7DprO1251/FILQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lI+yKkpA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D80606A31C
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lI+yKkpA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE83F1F000C4;
	Thu, 26 Nov 2026 18:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795718557;
	bh=YPdlr+kBcmJbKA7MDuZ1f3O91RY5uvGdw0lLhmy90CI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=lI+yKkpAPQQdrYQWSo1FPSpRvErcXuuf2DxY0enfVmZi3VcVfIC7V0eqaVTu0y3lq
	 tXqjwiWxi0VVkxPsXycV6hS0TuGxCnH16YHK0tf2xJhhma4rx14yf5EB+cu7/cL/DG
	 x4tG8yCbGWu6nNBgoq0Dvaa96vqgmGJfTVVs67MWmD7NH0jLUCaJFxS+njXeaFmFdO
	 ejLp8R2xd1Hx6G5Bc2yPTpo3QpeaFDofmb5FzibmY+SgE4PyCUrx6xQtcumtL1mZhz
	 gtnvO/166KhoAbgyjvQdp3ZPMdk5h1ogqWE6NV3nYLMt8Z9dBWkTcLgglQ264kmSRR
	 PwCx8s6RgbRYw==
Message-ID: <sashiko-outbox-236032@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/AER: Check error status registers if Error Source
 ID is zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>, linux-pci@vger.kernel.org
In-Reply-To: <1ddc35c51b5317988bbf235c467a9534218c6ea4.1795717157.git.lukas@wunner.de>
References: <1ddc35c51b5317988bbf235c467a9534218c6ea4.1795717157.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 18:42:37 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Since commit 6d69eeae8966 ("PCI/AER: Check validity of Error Source ID
> register"), the AER driver checks whether the Error Source ID register
> contains either the ID of the Root Port (or RCEC) itself, or of a device
> subordinate to the Root Port (or associated with the RCEC).
>=20
> If this check succeeds, the Error Source ID register is assumed to contain
> a valid value and is not double-checked by reading error status registers.
>=20
> However per PCIe r7.1 sec 2.2.9.1, devices may send Completions with a
> zero Completer ID "prior to the initial device Configuration Write
> Request".  Similarly, CXL r4.0 sec 8.1.5.1 states that a Component may
> generate a CREDIT_RTN IP2PM message with a zero bus number after reset,
> which can fail ACS Source Validation and trigger an ACS Violation Error.
>=20
> On ARM platforms, there is often a Root Port at address 0000:00:00.0,
> which makes it impossible to discern whether a zero Error Source ID refers
> to the Root Port or to an uninitialized device downstream.
>=20
> For this reason, always double-check error status registers if the Error
> Source ID is zero.
>=20
> Fixes: 6d69eeae8966 ("PCI/AER: Check validity of Error Source ID register=
")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1ddc35c51b5317988bb=
f235c467a9534218c6ea4.1795717157.git.lukas@wunner.de?part=3D1
