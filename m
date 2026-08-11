Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B68F317163
	for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 23:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786492120; cv=none; b=Gpqz8TaXgqVABgb7SeFw+WLjVPwLgDHliqvRUg8upkCa1NtC1KjvaBEYJ63pWeoXPm6nWoDM44vVQ3un+/lC40uG2lSQjTjVlRJbmO+YhCBJ7LPfY9HOEhe9pNXGOOID6bntiPHTYGxmP6OGForojgsSHMts7XlfPCdkKBOc04w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786492120; c=relaxed/simple;
	bh=dyFmm9cZCP9A6zA5Q9f+XvgrQ3UaChv1IGfCYuOi1UI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O8C7ik9SRVs9XOmhsNIq0rPZWBcU7Z3A2uor9h74hbpE5pi2viUoaoR/TdHkr3/Gxg6mIcfo3c3rfD2KM7J7aivAhgZhm33UqyGJfq1n7nIavRvrdSyKkL7QY2sv3uMF2tq8c/p4x8NR4LUdmmvjYJCTLsAk2iZHlikTll3hXZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFnx6/OF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFnx6/OF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844461F000E9;
	Tue, 11 Aug 2026 23:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786492118;
	bh=dyFmm9cZCP9A6zA5Q9f+XvgrQ3UaChv1IGfCYuOi1UI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mFnx6/OF+kX7jwiMek3ZlAKYSbKvULpQHH+w6m/8/idN6Dc5k+4U8Y4SV4hVFGEV0
	 Rgfyb0V14BpE7lU7OduwpJq536p+p5wqN3ztIw358h5f/mXsFathfrCYwr7hduH19b
	 iJCaagKVonQnMgySl8uJZzT33lvSzK8cXUhpbjTr/Ed3PElKjvkByCbg9GpDk1aYze
	 U7VWm0YmDnNCwnk2nCobDRhlC1h5/Ungo38tzqBqLY/zXRPOOLL9gcJ7SYMJSglGiw
	 A8iUIn2yTjXUwva0r9v+Q3tr4VLSaqsmVbLSVf/tjC+PzG1CYq2pYOxeNhYQLoomME
	 qUpjtK9J6O5zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] rust: pci: resolve IRQ in vector() and embed
 IrqRequest in IrqVector
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260811233952.3000968-3-dakr@kernel.org>
References: <20260811233952.3000968-1-dakr@kernel.org>
 <20260811233952.3000968-3-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 23:48:38 +0000
Message-Id: <20260811234838.844461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move the pci_irq_vector() call from the TryInto<IrqRequest> impl into
> IrqVectorRegistration::vector(), so the IRQ number is resolved eagerly.
>=20
> IrqVector now embeds the resolved IrqRequest and the vector index. The
> conversion to IrqRequest is infallible (From instead of TryInto), which
> removes the need for pin_init_scope in request_irq/request_threaded_irq.
>=20
> Inspired-by: John Hubbard <jhubbard@nvidia.com>
> Link: https://lore.kernel.org/all/20260808031120.363869-3-jhubbard@nvidia=
.com/
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811233952.3000=
968-1-dakr@kernel.org?part=3D2

