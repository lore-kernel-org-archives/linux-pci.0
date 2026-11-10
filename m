Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794299524;
	b=MFM2HuJrf6xaPUbB7HkvMuJdQqJ5uXrLY/M1Beo8ZQxm5skcp/h5hhFUDGjUntDvz5PG
	 oE6LbsjWw7fdkSu/MH4z/GAPbPr3nA9wbadEXvwtIgsh5Wzj05RcLCaMQIawzoUKDmxgP
	 eagI1ww3/7vTYkKfJpB4/KmXdeDsSq0SJ4EF+fo/33mWX/KIkNfnqfYtUnLTJx/3TqFAN
	 n1b85z5QiCLO/TzRunpQlSyITdCCqEUF2/41exPsbmSbrpoCH0M6Bo+jVMdn1YuefSRqY
	 RK4pGuVWoEvZuALWrNbfm2WIq4mM/OhDGtyttxL+fV8vML2FMtO+xDqKYyMe83iw/aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299524;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=I4hSM8cab+ZQlmS3pQcDAQIKxeZm3E7PyxCwg8cQ2LA=;
	b=gX+N9tWQL4Hh1ry/6gxCeR0bA6ieylVChZMrCnUUU9k3gQRjos/L9u+LvvXXPGYPAepg
	 51IUfWLUHR5fuZLZteKvDfAfRFV8jc07+K2/JmQaX13xkdV+oltozMps2lpaZAd/1n7jD
	 ONi7MNnZfcE1dLn3RNakCkayMrwTT80aig68rFya82btfLo+prKphf/aAVcZvlH1gRYGa
	 uG0Xk7+xXtKZFsluhDW7SxyvG9VsctE/waCegzomDQahXNkKh506lisldk8liSqvqYe3R
	 qznYTfbNX3yu1Aqh41JZupyVYckekOj4JdD73GthnBKi0YjhquhaFkVnao8A/NgAFYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZFUSVg/J";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785C4606A334
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZFUSVg/J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00FE1F0089F;
	Tue, 10 Nov 2026 08:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794299524;
	bh=I4hSM8cab+ZQlmS3pQcDAQIKxeZm3E7PyxCwg8cQ2LA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZFUSVg/Jn1Wmg5i4bCI2ZbI0+HGmEHClJwO2LAVNqN8edAXGY7Jn8Bga+RGYi4XsS
	 7xHr8Ow36IU0caB2ZXS1/ArO5TeEWgLvJ+lBOqjz8Ln3Y+xJEjmQNx4kL3qnSvRTV0
	 FDX9Zv4ugj93TUpsh42Kzvsrap8ANXHl3EtxFKv4RRxrCiRY4mGhML7DkUNaPBcRgR
	 cG2Crmx8Q89trzvTS8obKnVZflm2JqGDTYlBEfXHUPRqeGuU1s1S83Id9WRWvoOUuo
	 SwMc476LxCRUJ71xOl5sFoxHkckZrBOlYWdh6Uu0z2Tbo7DlRkzkY5AY+BrvE7Ceu4
	 QJCfZB4+6Jt1Q==
Message-ID: <sashiko-outbox-206628@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 01/10] PCI: endpoint: Add DMA auxiliary resource
 metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261110082459.1798763-2-den@valinux.co.jp>
References: <20261110082459.1798763-1-den@valinux.co.jp>
 <20261110082459.1798763-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 08:32:03 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Endpoint functions that export controller-local DMA channels need the
> controller register and descriptor-memory layout.
>=20
> Add DMA control and descriptor-memory resource types. The control
> resource carries the register layout and channel counts. Each descriptor
> region is associated with the static channel ID assigned by the local
> DMA driver.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110082459.1798=
763-1-den@valinux.co.jp?part=3D1

