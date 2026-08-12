Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF365353A69;
	Wed, 12 Aug 2026 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555790; cv=none; b=JG+WJMJhvxKADP61878pra4HRCcLBCgKCsaSyGEg10cmnGZo041Y3nOrM6Z809Lmo82t7W6cV2LqtW1u/kYN+z5/SihMcRaFr7aXVEzs0hktLHusrZXAFpW58r/1v2V5bu02hRc1tCRO2GAGAW9GOThXeoFTSIyg6mPzjSSzsqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555790; c=relaxed/simple;
	bh=npmudHOxSbyvFsasf+i6Dhw+HnYt78ipLdb2To3i/fk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PCifDL0ljzeAZyEULb2PXTaJud6AsuloR/WqMcpbbin8nn6HTTiyE0PjFE4d4dGsqyg1Tbx6lXmG4/og5AcIXO2SCbJhRuFqmkDCZTYu6vl7S8vMXwFZ3mZABm0T1A9XJaIsaiKm++ZhGPU85v5X+01ITZR28ipqpSuRts9I4Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un6XaFM6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un6XaFM6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199821F000E9;
	Wed, 12 Aug 2026 17:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786555789;
	bh=npmudHOxSbyvFsasf+i6Dhw+HnYt78ipLdb2To3i/fk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Un6XaFM6H7d8KOCrSShLsFY8ncSG5/j9LHce4nXogVhrED8sTWMcodZApB4Kf555K
	 NXgQP7C3Gsg9mC3sS4kcBP7yseQvDh0UOve8uk4dykCqSs5LxAAwjtKH26RXj7Aws8
	 XHvH/AvxqgNpfE+IVFCcR/LxQWOZQ0lAhv8F6snq2QeTmoMq72jJ+KeDB9dr9BzFjR
	 r9Qus6O0EL4C/4fDDzoiuk/SNtajlnqMRQ+oAT27yLJpKMpdh/gbLgjfZPL0jbCJRT
	 tv79CCJoD4uXs7EvHyQMVFGJwSZ8FW7J4qphbNr/aMZvfVbYa1xX982iqkX1cPvGyW
	 atHJkokXNmniA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] PCI: of: make a flags argument optional
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260812172247.276554-4-elder@riscstar.com>
References: <20260812172247.276554-1-elder@riscstar.com>
 <20260812172247.276554-4-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:29:48 +0000
Message-Id: <20260812172949.199821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The address of a u32 object is passed to of_pci_get_addr_flags() so
> it can be filled with the computed flags value.
>=20
> Allow a null pointer to be passed, so that the validity of the
> resource's flags can be checked without filling in the flags value.
>=20
> Signed-off-by: Alex Elder <elder@riscstar.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812172247.2765=
54-1-elder@riscstar.com?part=3D3

