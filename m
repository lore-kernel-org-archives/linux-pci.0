Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446382;
	b=RpZaZrZEmsLt/mAYfyxA8hNOsXrHtDxPg/TNZpZ6ag5+jZ1XTIsrPVrucjchxmxZcJYh
	 6AnXV/Tmo1feUxUSBz7tUJu0lM/QRQoxwT9H8IlJnjxVGW1yV3Az1DukhAhlGnTRDv1XS
	 Y0CXZjT29WRs3Aygg/c3lwsFCtOtX3nRcivE5jo+5I0MuqxqyR3CfgLNkJG5QkhFJzyBI
	 AmNaNACFcls50oUamOpHXC3kG8LWwq6QQVXe3bX32V/ZZg/OCyOa+0+uQh449jwDBEEyj
	 ciKYO4kffWYrqD40zGY/gz56jCWY/Q7QzYTSC/5p5xwhVIeH65XEqkYtVOUM2M/frKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446382;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SiyTbnpqoRjXQ6J6q/wCm3gGG+RcuaR3UtI1Vj5XwnQ=;
	b=PFxmZjKonNS/B3SPk+nMwwHL2r0SoHeLfqOIlXLZlPySQX+U/AeAie9ChcpBsvkzY1wi
	 OwOkfdQ1HammLNYo/YIAnwGFqMeBSY/7jzux96G8pQZafNLzFntK4Ww0XwOc/WzMyU/Jn
	 Lck2p2qXYUye5Uw4L7bXowhkgGHLUgEHwnopKvinPughv0SErSpscZHL5UVUJlNm8pM7b
	 aGLrimB+rPIJr5psF81uZmf8q5/8bC50HBAlLbkX58a+GlZHMZ0T1K9Id86LLyJP8ycUN
	 iFRspMj2fc+Ih5AxCTFsgVk426DeLTeh8imdNOQ9vzA74gF3Rirnn6P3FaB+YF7m+qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A1vK5alV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9BD606A31C;
	Thu, 12 Nov 2026 01:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A1vK5alV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08561F00A06;
	Thu, 12 Nov 2026 01:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446382;
	bh=SiyTbnpqoRjXQ6J6q/wCm3gGG+RcuaR3UtI1Vj5XwnQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A1vK5alVqOYPxUykXdJA9Hv2GY3Fo9Gx/66zq+NXeE/is9rDp901UMPRX77D6He+H
	 kirXdBsr237fOiGEaae0AtC4l7rKeDmDFnAyvXtfGBUq3j57KgsfoEj+kaIej1QStx
	 NGRxWWsD5G10DRYJKmq57/uMITsEpWc4xb0/Hxw/gx5VanET07wsRxxRSCn2KxVBGw
	 MjbJ+Eq22pqNROXoHuj7O0Y82PgpRVFe9O7NUTs6wqmEyDnRlXYJYimvEJIEYP1oNF
	 gaPks/1wBYMnt8kJVAxRelcU6/50dvxrv3ej80zkPDMudTLDKCj/lAWo/UhhcIQ9TC
	 D7xfuB3oN+kmg==
Message-ID: <sashiko-outbox-210062@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] rust: pci: remove the unbind() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <20261112005455.1224352-2-dakr@kernel.org>
References: <20261112005455.1224352-1-dakr@kernel.org>
 <20261112005455.1224352-2-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:19:41 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The driver model uses native Rust lifetimes to let driver data retain
> device resources and a Device<Bound> reference for the duration of the
> binding. Both remain accessible from the destructor, so a separate
> unbind() callback is no longer needed.
>=20
> Remove pci::Driver::unbind() and the adapter's remove callback and
> document that device teardown belongs in Drop or PinnedDrop.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112005455.1224=
352-1-dakr@kernel.org?part=3D1

