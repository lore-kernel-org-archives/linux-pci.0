Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F400738B147
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341883; cv=none; b=UQRa4wLsebXsCULoUXn2ggWr/fZuIVfmM0RfftsmnFCTdfXiw5X/j2OoHewMZK4REGTcPALTUlmmuDjvz5TKJ4IrkwxeUYB2N+38pvEH6Umyv7rBO4LOtu16jTaUhpgQ/Apb4u7C9hIJyHlF8plA5bfba7GKLB0D1VtTPsExyfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341883; c=relaxed/simple;
	bh=xsHZ/JcmCyKr3LkRYGLn9pBRkkBN+p9YhgVrESbc5QA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W9i8iLaNklH+t8hYnoQG0e/k2lTKL+ctVqEjCnVJ7u9Bo5Hu6GoG3XCYmUcMt9VJ4CPf3yfl7SMtEapfc2sInj9KnVlS59EZC1WHInuRrgP/JbMNUw1/+pqQNhdfkGxCj8BNOpI/Umnx+FyLiCCpRSptsxFhrg+5BLhrkUlJLR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CY9C7sUh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CY9C7sUh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583A91F000E9;
	Fri, 21 Aug 2026 19:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341881;
	bh=xsHZ/JcmCyKr3LkRYGLn9pBRkkBN+p9YhgVrESbc5QA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CY9C7sUhny8/IzseLOEaC1PKsVSOVf4xNzzB8Kpky+Xg/9PDVwSEZv1XSOjhjmTeO
	 6SE5P4fGC1k0Y3QkzbCjIMakKYrJih57x9LN/uS3Np0tE6eIJUi05W6RSIbCfUPgpm
	 YFDm7pZeY5J1NHOb8ug0jxWozqcLmirnRB+BQSRDkZRu7oaYPZh31BzBFHFLcZhIoT
	 9ILAF6qbBI4bgF2TEwfACsbUtCD2S6qjPCuRvOvY/PHPWVdPQPAQvlLR+iLj+iC1JQ
	 yFO4bYmGS8xk4JzCOMXpd90plAOJmEQyJIDl2YTjnWWuF55jvsXo91kPzZjEzylir8
	 qqsLfq5DlhVPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/18] PCI: Account for ACS egress control in
 isolation checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-10-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-10-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 19:51:20 +0000
Message-Id: <20260821195121.583A91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> pci_acs_enabled() treats P2P Request Redirect as effective whenever its
> control bit is set. PCIe r7.0, sec 6.12.3, table 6-11 lets an enabled
> Egress Control Vector override it: a clear vector bit routes the request
> directly.
>=20
> IOMMU grouping uses this check to prove peer requests cannot bypass the
> IOMMU, but cannot know every applicable vector bit, so Request Redirect
> gives no such guarantee while Egress Control is enabled.
>=20
> Report Request Redirect as ineffective there, merging the devices into
> one IOMMU group, and report no isolation when the register cannot be
> read. Apply the same rule to the Intel SPT PCH quirk.
>=20
> Unlike Direct Translated P2P this holds for an Untranslated Request too,
> so it applies in both scopes. pci_enable_pasid() therefore fails on a
> path where a port has Egress Control enabled, because Request Redirect
> no longer shows that a Request carrying a PASID reaches the translation
> agent.
>=20
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Fixes: ad805758c0eb ("PCI: add ACS validation utility")
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-fix-p2p-ac=
s-v4-0-v4-0-94426b96de73@nvidia.com?part=3D10

