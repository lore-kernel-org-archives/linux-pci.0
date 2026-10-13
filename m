Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F69524AE2
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897574; cv=none; b=qXpeaKztyZQjg2WYoOAmq3Pn4zOSp7i+kDfk8KsrjQRKdLLb0yWOV5FDceFRvHyKXcsxmhhKHIfN9yNN0dm7wxKxLfY99p1qtxsGZZ3KqTDfdcLAXWeLG0vP9bLVIF5sCHBZO58/Kk75QiBVAykbCcu9SooiPoKjLN5PUbRLlMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897574; c=relaxed/simple;
	bh=qYY9mmHeOxBKQLzcWpyJ5AFyN/XBM3FeDHQePzQR/tM=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=sTGR2HfqR02bJhgQl2TqlAD9WnHzHC9yH4NxUwAf+FWVo0VQPPXJGRwCZ1sNsUevguWVUgX902u8KhLephdKcY2NnxLLk3opZkEakqHiXSr8ROKe0bNCHnWdnJRgxe1pI1MyyajU8tdusMmjC2S/im8FrJBJCv21aAF4jjYVCyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQMTgEQL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQMTgEQL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF591F00893;
	Tue, 13 Oct 2026 13:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897573;
	bh=qYY9mmHeOxBKQLzcWpyJ5AFyN/XBM3FeDHQePzQR/tM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=AQMTgEQL38V/H6WbZyrH/oS6Nl6BEcOANGIjBPoZoK4aGtCsoQMK2DHcNAHDS5V6Y
	 nBYuy1hZVp6Kq/jij98z4GWnoGFrM05uI3nntTWo4XwTeZPFmsKeTHzCpLlEJpYo0J
	 TyYOgW/ZDiyko8+l2n7y7ewFEAjvK+n15gGU0nSyZljc1+DoAKCh20PFM7FNU2BQOK
	 i6SmwhuHmAttkH6z1VYuhIPpovLHW0bDjwy3CXe2EYm/9rxRsSiu6HESTAuqkPWBp7
	 3VR4mnBLSlQo36YvlDEvWnzSTk3yVxPyuy+xvmdU+DGMNP5EomItcklNm4KA7+Bd9W
	 z/fHh1OfbggXA==
Message-ID: <sashiko-outbox-169792@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/8] PCI/parisc: Clean up resource debug print & use
 dynamic debug
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261013130948.6231-3-ilpo.jarvinen@linux.intel.com>
References: <20261013130948.6231-1-ilpo.jarvinen@linux.intel.com>
 <20261013130948.6231-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:19:32 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Remove adhoc RES_DBG() and use pci_dbg() instead.
>=20
> Remove printing parent resource as the passed is a temporary resource
> not within the resource tree so accessing ->parent does not make sense.
>=20
> Reformat the message to the typical format used by PCI core. Print the
> resource using %pR.
>=20
> Correct format specifiers and remove non-sensical res->flags int cast.
>=20
> Dynamic debug prints can be enabled by providing dyndbg command line
> parameter or through /sys/kernel/debug/dynamic_debug/control so this
> is more versatile way to debug things than the previous compile time
> decision which could only be enable by changing the source code.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013130948.6231=
-1-ilpo.jarvinen@linux.intel.com?part=3D2

