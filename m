Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795150384;
	b=mRp1d3xHBGUvP/hMguldDr1K+e8yXtSUd/1DBhjrllKpY4LfhsnMEV9teLcGuxBoKdQC
	 ZDu+RpwTIBdjSwZ3I0cXqG7K0eanMbDSI5zmE7SYCHmjYYWUyGKwV++zW+5yRVXOTieWP
	 1MdD/+wlcwlb0YzGn939yVWhK80FTRi53GtgT7K59UHl+oBdlkyzxrC0I5d/y2LkNO2Qr
	 ZUNCLxoIh1InPlkJjoJ60cTrpuBJ6aJ/9Jt5VL1p5oNjw7UNjPK47ze9z0Q+VeKr6pyA3
	 CogWCtj3OwgQKOAhk+RVHEabphv6y1b71IyyIHZjgOY1E0shAc7KEpYcMFlKI2uUGQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150384;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FJhVkycKM6LDD5PYxUxkxy6jYxzz+qoutgwI2qrpL+o=;
	b=1/4aLXPPd6xfc8MULzrIKRro3Hi65fPc3WoEdK+fa9UZdyBRGgab9qDNcOf4EXjHduxP
	 4gqZFgU8ij21uBPXPtJHX//ulCvQxowSuoxrmQFi22kmjbj/MS7vM8wN0YyBfgAW4uzzQ
	 7ps/jsMur9XDL4PV/YrmGooO2wtA7i4qCK8/HISHJ1Ps+D+wwQDvnJeWrzFRKv55UN9kH
	 DHh4shX1QD0OfYEn0kH7/7EHjqRfnPq2uRZtGaUZOATHTOYXN2JzloKt2n3vmskqMy9h2
	 yx20hI8rYlLHnNtql3RQ38CEnLrHvwZYsOPUU9RhiVTxG99toi4qQnEsz0yE14F88kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hl1yO2GM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702F7606A33F
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 04:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hl1yO2GM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51041F000C4;
	Fri, 20 Nov 2026 04:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795150384;
	bh=FJhVkycKM6LDD5PYxUxkxy6jYxzz+qoutgwI2qrpL+o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hl1yO2GM+hpwTt5/4+NLFKX7uNfXhBTvbGtinS2/j3Na6w2WGxCH+DaN8bQWimCu/
	 j+YGZx7Czdw3fEIdhoyIMkrvYYmAzYku/DJOVkoEuIhJg1S0zNy1+mvFxDBOqctT6S
	 Z+FE9BQtHbZa6BtHPMIaHUvvtuwZUKbO1+rwbqAiGrMZe5Z+iShzm3zgS/o+/c9KmD
	 JEaJMZ9aBc8MoIp/KvSpuYjNdhI1oY6UJbsNDW6nG8AYSDtbyd67u9xYvY3IAJGdPu
	 PCTycSupj636flHukZkUhnJ/wUmoBd+uq1WlFcS5az9FHle2NzZ/cqvjgf41C91R4Z
	 u1+vYkPmSIDtQ==
Message-ID: <sashiko-outbox-224479@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/9] gpu: nova-core: gsp: add the r000 load-and-execute
 HS binary handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Hubbard" <jhubbard@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261120044704.165223-8-jhubbard@nvidia.com>
References: <20261120044704.165223-1-jhubbard@nvidia.com>
 <20261120044704.165223-8-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 04:53:03 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The GSP falcon is a microcontroller with two cores, a falcon core and a
> RISC-V core, and only one of the two is active at a time. GSP-RM runs on
> the RISC-V core.
>=20
> On GA102 and later, the r000 GSP-RM requires a Heavy-Secured (HS) binary
> to run on the falcon core during boot. GSP-RM is suspended while the
> binary runs.
>=20
> The driver runs the binary on behalf of GSP-RM, in the following steps:
>=20
> 1. GSP-RM places the binary in the framebuffer.
> 2. GSP-RM raises a load-and-execute event.
> 3. GSP-RM suspends the RISC-V core.
> 4. The driver waits until the RISC-V core is suspended.
> 5. The driver resets the GSP falcon, which selects the falcon core.
> 6. The driver loads the binary from the framebuffer into the GSP falcon.
> 7. The driver starts the binary and waits for the falcon core to halt.
> 8. The driver resumes GSP-RM on the RISC-V core.
>=20
> Nova-core has no handler for the load-and-execute event.
>=20
> Add the handler, which performs steps 4 through 8.
>=20
> Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120044704.1652=
23-1-jhubbard@nvidia.com?part=3D7

