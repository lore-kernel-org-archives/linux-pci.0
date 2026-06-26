Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4AF388E71
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485839; cv=none; b=rEJXFgPpwGKgIrcf9bfEptYgu2d2KgQCWnH6xk+JXdwJRjPxJSCwsNGSe+X+hxwntoWbO/5AfmY27vROyXxdLrQRJ2OgUa3HNbtzI0Zyms94ydrOIHnTqKdkspMEEO+Ynr6KPpZyz5vaTPnmfm2bu/7V7e2hLHOdGcetALE0CXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485839; c=relaxed/simple;
	bh=Drf5dNCTcFLdv+BRTeO4nFaAZ0ORjf3oaENDUs4oHWg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=erCDpMXRG+ouLcIJ068vkLONgE9Fu+vSh8BkttKgpCLE/FJfPYodVJFDhQoVBxytyZAv0O9DN0k27G9xpp/Gei3oQ2p8/vg7hlNzmwBntgEpj7RV2RHhRHYwg3j26O90QLx6IEGaGM/PQbXPpkIAnsAgHLcp9JSyoJ1WX7MQIZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9dLExtQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9dLExtQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36FE1F000E9;
	Fri, 26 Jun 2026 14:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782485837;
	bh=Drf5dNCTcFLdv+BRTeO4nFaAZ0ORjf3oaENDUs4oHWg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T9dLExtQVkxd3TdMkMcf4B9QUM3kUdzwQbLqDm1sEUS/Q/UzQHQZ3+mg4satDNlRM
	 NpTUn9JGmRuHTlminfwPD30wmoIhe5enSHEwsh4usA7GPbxEx02wRwAS9I4lLtgTp6
	 9DEETHMcEEX72iqmBArTFcE2JG+DpHHLcFdT26uMeIo3wD9fFXQXThUkoSuCaBPb9y
	 ebaikb05lLGW3qDT/kofahzvhuigp/Ls6zZ9FSQfZo5AcCPYF4YzPawqeMuG5Z9Gsn
	 zK3xedC1DZJLKBrdnbQu7lzzXjM8I2MmEhfScfeacbmwrjc4rD2k6aL89F4fajU8XV
	 B5mhm589znUkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/20] rust: io: implement `Io` on reference types
 instead
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260626-io_projection-v5-4-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-4-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 14:57:15 +0000
Message-Id: <20260626145716.C36FE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, `Io` is implemented on owned I/O objects (e.g. `Bar`). This is
> going to change with I/O projections, as then `Io` needs to work both for
> owned objects and views of them. Views are themselves reference-like
> (however they obviously cannot be references, because they belong to a
> different address space).
>=20
> To facilitate the change, change `Io` to be implemented on reference types
> for the owned I/O objects, and make methods take `self` instead of `&self=
`.
> When I/O views are implemented, we can then naturally implement `Io` for
> these objects.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D4

