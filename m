Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC652BE7A7
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486052; cv=none; b=igzmxVPSjetrnP1L34B8iQ14iNkXeX6ELPS2/IeslAg4mpSYKt6uGVtRLfeyOcpBRCvttAfP9RFO4URS/bQDtxKxinekkFHQEjdbMZIGPF0rjljNfgAWVc/BT80Y0WLJDJGpLVjmhscZqP0x3Rtpki9/7Z6lmGofM8rjRpgfn+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486052; c=relaxed/simple;
	bh=bmxsOB9f9njIDVopkZnvPuzQA1EedkdM1yk6u/sSckM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RE5vqhIrIPxWintDSGCHEd3ANHPCl6TOJvZLVBg7v9ol69I9SF1HOLW6UPtkumqB7F+QFgaz0LVXM4Amwj8bCe7bWWdE4kowXGqH+oVnBBQSvn3mpNdciigq2pYjYmuiZKXXIjnJQ34WFQXo1CW21xltyQFxBI6JR5HtrpB2g7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNKHu4Lj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNKHu4Lj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE091F000E9;
	Fri, 26 Jun 2026 15:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782486050;
	bh=bmxsOB9f9njIDVopkZnvPuzQA1EedkdM1yk6u/sSckM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YNKHu4LjQAqkP4tLwej/p2GSvLnS2eE1eF6cHL31YbfEc89u+XDjh5sp3vpjAyoyf
	 gpsQq3HJbObPdk+Yi2WfQPMh3pIrA/nHEaSZKgFlaCxPO3OoFHBr9TCtkiVcZYLu88
	 h5+CtdNkgILZHIRHF4SWhWH/OudsdMY85vhgCEZ1zfHwqxbGcFSu9UpIP192Uq7QG/
	 6SUuqZilppy2z2YpUamT0bD0MGj9WeHxoQHbQrUp0sgiYdd++HuoiQKZrvXtpqAcnY
	 t+t7k9g96IIxHbuxbhKM4UGyekV31q8KKbOTsi/FYe0hOzNyODeUDWVpEjtRvMQiox
	 9ecOQl9JOCrHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/20] rust: io: add projection macro and methods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo
 Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260626-io_projection-v5-13-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-13-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 15:00:48 +0000
Message-Id: <20260626150048.EFE091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add an `io_project!()` macro allows projection from `Io` to a subview of
> it, using the pointer projection mechanism to perform compile-time checks.
>=20
> For cases where type-casting is required, the `try_cast()` function may be
> used where the size and alignment checks are performed at runtime.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D13

