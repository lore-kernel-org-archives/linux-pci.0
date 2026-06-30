Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B89C40DFA0;
	Tue, 30 Jun 2026 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823210; cv=none; b=FssmHIulQODa3eTOlJ4uAxZwV+kDRuv/Mj0T3dgxnHLNswnIWLpuHfqzIy2wqnDgaHhtPMvCDh1oKp9RiJ+3ZKIGgdyFiE009H0F7d7IF/FpVku1S9ZU22zyKLnPODllwYXBmYPTq35Z+SQT9lBFTQf0OAavYr0cEzIvYy2kDwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823210; c=relaxed/simple;
	bh=qbLIPEp1f0KioW0gXIhoeCj4r5zV7yz64AxIyvN8+H8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RtSfIHZQgfiI+nbpzP+aDqbeVpbstR1qweha+Wp1m2V6b8uTgyv39r8e6vJbcGMhbtb07DYOKbzm/b4RY79lXz47105LjrPS5OJpgsYycHDXx7lDduhzzcONqm4Prss9+ozx2W9M7TJaxaPPvpswKum7tgabRtrPIKPJ6LqeiwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hvfq7PnE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hvfq7PnE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689FA1F00A3A;
	Tue, 30 Jun 2026 12:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782823208;
	bh=qbLIPEp1f0KioW0gXIhoeCj4r5zV7yz64AxIyvN8+H8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hvfq7PnEa8IplybTjdAE9V/LzWqzUOqJ4lxd5h/39S/QohFhvuWoW4vTpizRIBLnS
	 2vGNtQeE0pJdFSCaFghjHZ9OKL+hBM/jJ7mucrIo4K2F99RSgnaSIn0gsRe8jj9bWb
	 mCGIyBoZ5QNnLFQsW5w9ffQC6PF5T38FU1gZbiyOz30InkzAnaJSKMOYU1u1EeD2wv
	 XKx5PwTIsUAeX6ezs8Yv6yhRlFW19LVfpXybXaSXT4SRyYcWKwKpOB6d7PnpeD+7d5
	 1QiF6trENVWXi+hZjyzR3QUSjLArJFEpvegf6LcchtLo2+/qPUuzCPt0HyVIePxsgN
	 +od1pPL7JXW+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/11] rust: driver: simplify
 `IdArray::new_without_index`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>, conor+dt@kernel.org, ojeda@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260629-id_info-v2-2-56fccbe9c5ef@garyguo.net>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <20260629-id_info-v2-2-56fccbe9c5ef@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 12:40:08 +0000
Message-Id: <20260630124008.689FA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> This method can very easily construct the `IdArray` on its own without
> delegating to `Self::build`. Doing so also simplifies the phy device table
> macro because it does not need to construct tuples anymore.
>=20
> This also allows simplification of `new` and `build` which removes the
> `unsafe`.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-id_info-v2=
-0-56fccbe9c5ef@garyguo.net?part=3D2

