Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187F5386C13;
	Wed,  2 Sep 2026 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334550; cv=none; b=JJXcYl3Md+S5GEaxDyb0t/uCp8Q3/exlJGIc7uexOrpMDnokQDrOqIrN/rJ28KUFJa1mkZ/88HeezHRL5rPg79z5au4rHKF6YGvJc7ghl/q/au5DfIJ/NIX2zWgTafqK1MTdNGDjfbFC/fZCM/KUHmC5ql5HR210sPWCN7NMn7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334550; c=relaxed/simple;
	bh=k191zkROtu1VxIPCBB8E2K7KYwxWn3CEFVjc3/ZKl64=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=soiYK2MqxifHMuBkUORqQBT59AP93Kgqz6XVQOMREwTDXibqMmNP2OxT2WHfhY3lgYpodvN+1PpSyCun5JQZDM0kyrSoMAZ6/XXGhtPEKeJ40X5orbAMX8kCaART8PRRzpc4nS33xUyv98ZW3o2LGaHaISXGDCffjHOlLJl7Fao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLSeKkSp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLSeKkSp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7131F000E9;
	Wed,  2 Sep 2026 07:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788334548;
	bh=k191zkROtu1VxIPCBB8E2K7KYwxWn3CEFVjc3/ZKl64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YLSeKkSpUgpoIi1/7T9CvD1pqMl7kjeCMHFelT5udKSdYsJsC9lwYOdAUHeBAShnH
	 Dhrh0gfqE/TilpHFZnoZfeWigikz9l7Wy9fJlEIUaUMLRpaDRhsoKzXbnaUbOu/W1R
	 /jDGV1C+oDQkGt10G9+lx1D3mbCiudM2ZM8eZO0cu0/m3CkdmIaq/UmqduZJh3D2BY
	 uKRPQPl8Sgyf58fmMVu5J6I9rUMlX7N6DN58qwcVwSBRJKu0rza3AbRoIMPduQ3tYB
	 UsMdLrtjquTFVhy6/wcHGQKS6Kv3IoSQzpg46knnBdqXiBbEbRWcltxA1Tjel1Us/K
	 ztMEQyUJmwERg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 06/12] cxl: Add CXL Device Reset helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260902072804.665639-7-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
 <20260902072804.665639-7-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 07:35:47 +0000
Message-Id: <20260902073548.5E7131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add an internal CXL Device Reset helper for Type 2 functions that adverti=
se
> CXL Reset in the CXL Device DVSEC. The helper disables CXL.cache, performs
> cache writeback when supported, initiates reset with Memory Clear disable=
d,
> waits for completion, and re-enables CXL.cache on exit.
>=20
> Leave the helper unregistered until range validation and reset-scope
> validation are in place.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902072804.6656=
39-1-smadhavan@nvidia.com?part=3D6

