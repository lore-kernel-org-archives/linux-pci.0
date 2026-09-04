Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C225C36F434
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521301; cv=none; b=kQxHu/QeeHs/XktXQvvf7fJtMjT5fG9Px4GmEHywuJA747BaA1PkpPPkvNHHktOmbmTbaef2mL+5APtQ4PXZfnteqhMPsPSnYtzpYiX0ua7Mfv8qwpSqxSoiZELBqRLUbXf3/QYiG63ARGKVAs8lnkVffTdPkN6F+l6Keqd0HoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521301; c=relaxed/simple;
	bh=Q10VU3ijXTPZHDr3vv+aJyJ4grJAx+qbgU/QUmrcGf4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LRSJe6bE0K91qc3QHWUQY26kyB4jd+phDOmjIRsiCXx70u2i1j0bt7n1cHxZq+H19zJIxEYSDBpeM3CcrhX3VmPYYDbyrhEjevO+WMc///33Oe7F/6VWn17ZgdASVxDkqQgauEnsT/wYisrws0io17Eh12Immyuja+mItBpbSVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBydK4G1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBydK4G1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9061F00A3D;
	Fri,  4 Sep 2026 11:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788521299;
	bh=Q10VU3ijXTPZHDr3vv+aJyJ4grJAx+qbgU/QUmrcGf4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EBydK4G1b8LJqUbkWLYdUVM7ayXt33Of037H2RYAaH71A4F1MMKM4s4/UDZeN1cuK
	 wnCt5/duF3M+p2q8KNh2pln/O2rckVai0w6qFTSHG27maGAkLmFn+3Xa/JAdtu1V/B
	 8Sks6IOztcZ0jkHekzaYVi/8vMoR4MScrP/P34UXGybp5iMbyNJwT8ILqx/THeDKmX
	 215VyPcqgkZVF2O72agiobBoV47hnnYMAFdxLqm9UxYwKTw4PsrrLVs1GFa5tR+9y6
	 DkdH3xnQMUKXUABSKuI6OuIQO2aBnxUEMSxHhUF27wU0Qv4zvK9FYt+SOnKCKQ42ls
	 8GL79Wnph8YLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Stop waiting for link status after config read
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Murashka" <yurypm@arista.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260904111318.1063858-1-yurypm@arista.com>
References: <20260904111318.1063858-1-yurypm@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:28:18 +0000
Message-Id: <20260904112819.2B9061F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> With a nested PCIe topology with multiple layers of hotplug, a link can go
> down near the bottom of the topology shortly before a link above it goes
> down. In that case, pcie_wait_for_link_status() can wait for the full
> timeout while every read of the link status register fails because the
> device has disappeared.
>=20
> Return immediately when reading the link status fails so event processing
> can continue.
>=20
> Signed-off-by: Yury Murashka <yurypm@arista.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904111318.1063=
858-1-yurypm@arista.com?part=3D1

