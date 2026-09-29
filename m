Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC033DF01C;
	Tue, 29 Sep 2026 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703856; cv=none; b=dDQUIODwAMwEkkz70jQngluJk2nDCo2rSqkadYmTnJe73JYiekFfu7xbxuAvk7WeHV1R9ZIF74mWudxWhOuio616MSnMusjWycrHeteLcjw8sK/QrGjiT7ZfhKxgPrfm6uCbPTLlWyWGuX+yzs9fZQxKY8Ww/OlnlEmWZ9CFzzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703856; c=relaxed/simple;
	bh=RiNHUwq3fl3EJukGJ7PE2/FITel6+gks+bCaGs8/uTg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EMjhBeey8avcEIx64tEsDQpPHkzOXrSsc+xrT6+xszoultYDp3UDLb7zkBDi3/tgM9fCZ2xBT9zmjJhV14pJ/Co0odDQOSZr99R+rhcFKQryPwqHHHtLFeCYU+SxAeuqoFIoTgyroYKjS9eDLz9cEIeNtfb5YT3570HBYVRc/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwNnfAaX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwNnfAaX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D8A1F00893;
	Tue, 29 Sep 2026 17:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790703855;
	bh=RiNHUwq3fl3EJukGJ7PE2/FITel6+gks+bCaGs8/uTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kwNnfAaXRIHKmn9V91FkELXsrc2aNXk+nojFlyyMGoQPLhIGzty92DQukX1IraY7F
	 DNXaN5Kh0ClEQeJ1mDd+TNLzdFsM/CqV1U/Kujf4XpstAqI3u9RWTSdZBCrPjb3BzG
	 6JZoXDH/vmp8wuM1UxbVexWmYPC5gZZnF5fDDjgDchMlbeHQKppctEQcyQ/Nff+xoY
	 vYMuzoG+1JpYHgUeU2XAvdJ1FSX+0q33rDMYJX2J2uyqZH8svSlZnryeB9fNtJmo0k
	 EpvriOtqfbAYIQxeY+k32mzk6v9zHYD+QoX574yef0qo5ez3OMC0kkZXahrde2/D6C
	 y32Yl4KEBWbug==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 08/16] vfio/pci: Gate device information queries
 and DMA-BUF export
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260929173305.204856-9-skolothumtho@nvidia.com>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
 <20260929173305.204856-9-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 17:44:14 +0000
Message-Id: <20260929174414.E2D8A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> GET_INFO accesses PCI configuration to report AtomicOps support, and
> GET_REGION_INFO maps the ROM to validate its contents. Protect these
> hardware accesses with access_srcu.
>=20
> Hold SRCU through DMA-BUF creation and list insertion so recovery cannot
> finish revoking buffers before a concurrent export becomes visible.
>=20
> Assisted-by: LLM
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929173305.2048=
56-1-skolothumtho@nvidia.com?part=3D8

