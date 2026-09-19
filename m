Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E931E831
	for <linux-pci@vger.kernel.org>; Sat, 19 Sep 2026 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789835438; cv=none; b=CxfUD5fn9Ew9nlneUQkQNCKi/7nn3rpZwgWHdB8gTs+Qwfr6CXxNGrRucnzs+/IgLRKcji0TWMNv05+lHZQ5yEI/Bfx5KxfY5HqDrK+uiAwX+laDL4ydRPcuFhPQovLCvSTA4RQHq3Ml0FQqYW9UnP1SBCq+nVJxwO0w+i0s0OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789835438; c=relaxed/simple;
	bh=biVqFdCEgVyHu6m5t1ISLnSw+qLw8WJ4gI1xycsY6/c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BHf2KNjoDIbcJMMxZt1nyON30g9L2QzaYWCzPcp4sQRZzWBOcZRyqGS8TmIe4x/u86APyW6HNjpw8/3U76gpAMjbFgS7OQnpnIc6F5n7iHbNYFk7I5m65VExysPC8XdZcvT2ED1pC1SZ8egWJTco5GqOXQ+F6k54h2ttkHLWoo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIrMnLd5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIrMnLd5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDAE1F000FF;
	Sat, 19 Sep 2026 16:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789835437;
	bh=qaYebp0/brRN+4L8Nr0fsUSl2kilccBpCpBdPAv2O7A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XIrMnLd5T99KZopZpZSrzZsd/9j8fQOh2GyFzXe30APmbElSi5SYIjLvJDL8qxlqD
	 Z6VHkWN9y69J+5JYsa/Iil/CwhbPuBfZxDBr7kKjMy2su6RGNgn+n5/VnFlvKNXY+g
	 gmg20v2aGNlnHK6REG52f0zNKxp6CInzK54qmadXrPh9zQc79VWd+C4ZViwVARlHma
	 ZTrVIJMdDSFSRPaClg2TMsI7mHFthpZwJJcZE/bN32rB1qfuy4uJryy15V3GOGiE3k
	 GMc1lc4CNzs4b8A42ENAwPdmNYNEiTTZ3lpaS9d8PxlJG+5AoF7MEWLs4WuIyCVT73
	 ba4cTR/0tR4vA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 3/5] PCI/ACPI: Tidy _OSC control bit checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260919162655.3499010-4-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20260919162655.3499010-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 16:30:36 +0000
Message-Id: <20260919163036.ECDAE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add OSC_OWNER() helper to prettify checking the _OSC control bits to learn
> whether the platform has granted us control of PCI features.  No function=
al
> change intended.
>=20
> [bhelgaas: split to separate patch, commit log]
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919162655.3499=
010-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D3

