Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975893;
	b=48+4Wh+L5zSuvn7ymHtZDWitZN0ZIYOKgSIAxnXxJN4HP8+esCxBjU5lcucLxg5MA7lk
	 6LD6VXU6kub5UoPg5+K/oArUYiziAQkLDTOoj2ZqU0aZzawLvrT3sO2hUKt02mZ9Nc2rD
	 +Q7jqcEShG8BBth4DgC33UzCvltsEZBl60MG+VoMQTiG/cKs/g08PknmKfdm68nXvs9SX
	 ExcFJs1axSpAvC5MeBjvt79pNue6RzGLERkvuyuS9BOWbRc4B7ra/VgYvpf4ZLGo327bM
	 5s8yOl0YkgV/0LQWdlUEJ+Zg8lCu4zRtgh1/RicXhbkI9PITsAE/SbnuWH8b1RrB4yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975893;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A3hrGht8D6QLqVwc+ivkXW0+2Y+aABjxpRI3tRJUg+I=;
	b=4kMJ9nZw27IOGvILqsSfaQmEpAkiOPQoVaj/99oqd+9/1+vMaPDZkU99K+kwq8a5eZZS
	 DKHtywDAp2/ihEmH7gD18jFW/IB8sTGPAj5RS4tN8O5e9AtFRVcPIq8FKMvxBhC7VPA78
	 h2D9qODeifmA4ZrSHg5QSwaFKJQKgdeB2lr1nQYM+TmiBZIGqssfmDioX58+6i+ieQIgJ
	 +gYRsdSVmB0w5JRsZBvw4JPZYGJQlWOQ12uSSGsEwKb/HKzymDdAugLmU3//JoNqV07c9
	 4+bQLolk1+5RRkQBdWboHESc18sOq1+ZbxH1cogY+UtoHVyaHSJ9L6o/jukjrM8o0SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f0VeRwaV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7FD606A32D
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f0VeRwaV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAA11F0089F;
	Fri,  6 Nov 2026 14:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793975893;
	bh=A3hrGht8D6QLqVwc+ivkXW0+2Y+aABjxpRI3tRJUg+I=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=f0VeRwaVE6FP+xjsgXxH4S8p+JwARAq5gaInbeJBTC8Fk68kM7BiY+rZCB01tnaWU
	 kZrbF/7DCZX/b4l8PEDde0cbt/0cLNPHbQmdSsQYn53CcxnIYcbl+tCH/OOtM5SkMS
	 H9JK+hz2aRWrW+/GzQZ3xNpuyHuP/+4YJgbKdoDKla5sWBpKBljXCveyfesbFoJKnq
	 klYy2xDai2DrWkI4Y2ZyY1WD4bBwT17wHYgcKji7siuyocLLeSN/o3EUvmLVjgl1A7
	 f/Iql8qry4Ws8VbbENYCT6qUxe1buehoWTeNIM6FfWu/QW0/RNVbwoVEsOBpP15UdU
	 5uQZ2Kpi625Xg==
Message-ID: <sashiko-outbox-201595@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/14] PCI: Honor alignment overrides
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261106134341.39493-9-ilpo.jarvinen@linux.intel.com>
References: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
 <20261106134341.39493-9-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:38:12 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pci=3Dresource_alignment argument can override the default alignment for
> the resource. The remainder code introduced in the commit 9036bd0efcb6
> ("PCI: Align head space better") can move remainder space (non-aligning
> part of the size) before the aligning left edge which results in
> violating the requested alignment.
>=20
> Introduce struct pci_resreq_data to hold device and user-given alignment
> to be able to honor it in pci_align_resource(). When user-given alignment
> is found, any remainder movement is skipped.
>=20
> PowerNV will not be able to use the current remainder logic after this
> change because on it pcibios_default_alignment() always results in
> setting min_align but this code is in a transient state and the problem
> will be fixed by an upcoming change that rewrites the resource
> placement algorithm with a more generic approach.
>=20
> Fixes: 9036bd0efcb6 ("PCI: Align head space better")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/linux-pci/20260923133202.07DF61F000FF@smtp.=
kernel.org/
> Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106134341.3949=
3-1-ilpo.jarvinen@linux.intel.com?part=3D8

