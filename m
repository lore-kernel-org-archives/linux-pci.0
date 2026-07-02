Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAB0480DE7;
	Thu,  2 Jul 2026 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996617; cv=none; b=S7sJuoI+yZfFWXvskGtI24o1ZGYvzyd+qEuYKckY+09DHUdH6GJFRvxLuPfan75b7LamRp145lhDvIvwIDdIArONgi2c6EMBWDqdgjC2JjBuodg/XHIpJduytof4YbCFQsYmtv9vfRWnyjXw9bxSW2HSTq/mYF9tKQ6O56z2dkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996617; c=relaxed/simple;
	bh=vUxXxLWzTiG+MELKgbzM2UUm95xkLfoQmbcAk9q0Mu8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A9DE4eiJ6h+HpCuMH+OVo8j4OayE2BvEbc1YRTYJXNHbl+T+wP5qQgws3DfRUb/olIYC4P/5ALHTeoVqTYFjYiIx7JdKprfDvpylXKLUH+8lRyhg5LB39tq4VH/F4qbmF/xDDGknLJhGmkZm8Tbb3a9Djs9b59cqIKcSDyW0/x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWIxgvds; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWIxgvds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A9E1F000E9;
	Thu,  2 Jul 2026 12:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782996616;
	bh=MbEoLwLLo3Rkyv9T724mojIYopJsMNuzFQNlRkbUvMM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QWIxgvdsOZ9qPW7OTWdU4LcjBq5jWCJhBQWgphrDgm1Q9zbVyrwZQasPj/eBl3pex
	 MPArGOiWGvzHxqIAYAWMBq4zfSChqMGZnqHh+ETI8f1c5CqDUK/XmTrK5c1CHL2tmP
	 eksc0oQBEE2JTSp+AoGQ2QPiwIF04Ou3lwxtUJg65SvGp+/8C2Psflac21CKuMP88V
	 AsmvWckwx/1AbvbcuUd95MCf0uzMlWJJfjqv+NEnQoKB5450m1Mg1yreNq3HIVuXkC
	 bV63/NRNVhrfKTVrSM1I8vVllLJMZjXmOuNU3CoOpWi+B4aW6N2Pxvb419t7P3UnOk
	 2C1CcAP1yOu0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 04/18] PCI/TPH: Refactor pcie_enable_tph & add
 explicit requester variant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260702124224.57168-5-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-5-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 12:50:16 +0000
Message-Id: <20260702125016.85A9E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Refactor pcie_enable_tph implementation: extract core logic into static
> internal enable_tph() helper accepting explicit requester type.
>=20
> - Preserve original pcie_enable_tph() unchanged as auto wrapper; it
>   auto-selects EXT/standard TPH requester per device capability, existing
>   bnxt/mlx5 callers require zero modification.
> - Add exported pcie_enable_tph_explicit() with bool 'extended' parameter
>   for explicit STD/EXT selection, used by upcoming VFIO TPH support.
>=20
> Input validation for EXT_TPH availability is retained inside helper to
> reject invalid explicit EXT request if hardware does not support extended
> requester.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702124224.5716=
8-1-fengchengwen@huawei.com?part=3D4

