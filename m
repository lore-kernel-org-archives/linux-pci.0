Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24762D97A6
	for <linux-pci@vger.kernel.org>; Sat, 19 Sep 2026 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789835589; cv=none; b=Y2jJmhu/ZQ+INwfdSGQaRMg95sk8iYuS1i3I7kvktWSffqOyifgRqDCNd3ftB4cN5y89onxQmCGmm6jR4zspLusnyLguNV28VzEjPndZRCu6vgMI8X2GbbzV9F/wH1I3grkT1dXqFYv34Prh+fZscpUcvnofC6hyP61J5WyUZwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789835589; c=relaxed/simple;
	bh=pY8c2OLXag5CDf9mYmxWYPQrBQPOQ54wozYE2P6mCm0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eIoVjjKG0krczIKQpFRBZJgyBOPU1XTyHRRvlOD0lepHqR/fMOygpgf15U3pJyadqqPnkcpUTiXhYR4M4pUcDg0jROU+YxHlh4y/K+4514vbuN4p4bBieJ7/QkvBlzd/xBVcK+dJkNJQoONhG9Iiizbj0rR/sNux8l6Xp4aLlS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mR5Hk+fO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mR5Hk+fO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8551F000FF;
	Sat, 19 Sep 2026 16:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789835588;
	bh=pY8c2OLXag5CDf9mYmxWYPQrBQPOQ54wozYE2P6mCm0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mR5Hk+fOAoQBX+0lpcmdilMAGl4gdKOoCcPpGPyTxqNWwmmjKQOyihJZw8mMWrlOD
	 p+2/JV+zzARexL6IsX6pA9moW4LxNfKxpCKMFjjodMlVBn1ptSr5aGOqlPq+0AVC1o
	 ae9M+smdixRgD0DfSOxEcyawUDPVXijN2YrQBO39kIkezV4p9h5n1FbB31jTVK0nBn
	 AjNbKH5gfsYrjQaeb62vUZVaqTYcRN+E4+te0NyTaUCG/yaTgh0OEiqUUIFLafcuCq
	 fDkFQosPKqDGXEKNYRLhkHHXudAKir2G7tDT8NS5Q4ffqpLI9i0WQ5Cvt+FKHNRNIC
	 rX3ab+n64IgCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 2/5] PCI: Assume control of portdrv-related features
 only when portdrv enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260919162655.3499010-3-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20260919162655.3499010-3-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 16:33:07 +0000
Message-Id: <20260919163308.4E8551F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Native control of PME, AER, DPC, and PCIe hotplug depends on the portdrv,
> so default to native handling of them only when CONFIG_PCIEPORTBUS is
> enabled.
>=20
> Native control of LTR and SHPC hotplug does not depend on portdrv, so keep
> defaulting those to native regardless.
>=20
> [bhelgaas: commit log]
> Link: https://lore.kernel.org/r/fcbe8a624166a1101a755edfef44a185d32ff493.=
1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919162655.3499=
010-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D2

