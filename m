Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FB548383F
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948158; cv=none; b=BzwPIPuf02y0SZ8TbXEMnEU4Gy+ef2FM3vsCjtgJmzN4QgwzyGoqTT07GUOg33skTnM45cAIgrgsb/UZTiuaBbb9I5WMi4OHbrALx1AD+wSlbVI29va5XPD7vv9Rh+8B6cYUuA0QXlvsvGrkPwaiA64UK98IOI9prNRZEtyyB+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948158; c=relaxed/simple;
	bh=TIoB2BgUaZdimMEqxoehkcJbvD31AsnjBFEWX3HglBo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pJzZX7VU13BIHggocyNqKVkFfrYFyddCknOU+cg21B0sVIopCdy+IwhpiX6zG8uwuXVOpuGPiBwo6GC6p+cfGIOxjH3vHd1goCaAGjWyL+tOi1lbq7rHI7Xx9u7PG6vO2Kxd2dWMe5STl7Dc96DDDCDiwfX2wq/gSCN92y65vi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvFIte3V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvFIte3V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399321F00A3A;
	Wed,  5 Aug 2026 16:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948156;
	bh=TIoB2BgUaZdimMEqxoehkcJbvD31AsnjBFEWX3HglBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AvFIte3VHaAOoWBbX/fN5JGSYuon/NnODMHUmHMUuAaN1NRd+3pI0CytFCU1Jo2p1
	 QkCxPGtcCxdq1gyq8e1VZVzpmKcFgGSOXLf8ab/GE5irA5mFsOBNAdBAIMV4BZtWYr
	 oN8gPqSZJkSBs/y+Ix5I1LSaFZTFc9NQI+e+h8vNGWMdVOIjjLszRSkDgqIjGYfGoP
	 PO2XYSY4Oe7aLBxnbONOT66D5/IRz+RxcYqaIXizCht6pQsAzlQrb/tGtD1CMaBfgR
	 fjeLfWl/Yc+6ZuNFA5ADYCl5pUOYZcqwoMHYgySj1HwLfrtemgBuKyB/j7HFdDwvs6
	 3RyBabkyYCMbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/16] gpu: nova-core: specify base type for
 registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260805-typed_register-v2-7-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-7-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:42:35 +0000
Message-Id: <20260805164236.399321F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> All registers use the same base type, which is `<Bar0 as IO>::Target`. Th=
us
> add the base parameter to `register!` invocation.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D7

