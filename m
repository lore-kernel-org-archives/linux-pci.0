Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F8F4A2E3F;
	Tue,  4 Aug 2026 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785872730; cv=none; b=amlswmD6zmiDbeNmr31AaW14rxQDXPeJIIJfJ475Lj9y80hYMUc4SvaUkEMafHoSJZQPegqRCc/NQlh4g5vP0U1lotyNKOw97VCbzm+LNIqi173i5aqAL3MkXIqDAJdORm0wpDw3BGS7j1BmgVk6wb3pLzi86Jl8yVYZkwe0XOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785872730; c=relaxed/simple;
	bh=bxBL4ckPq9eQnPsSXoz3nYAhm9DMwzfrv1zrmbfeApg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uorcYNYxdu3zGIqCs3rfpi8Bp+iz7UArfDA3zmDczJ+q0owHn89CHuIofk4V4Hrcs/dBT3v3T6UEff1pM4iiYu/YdsBt/MGZJ000tFTtl3EnZQ0zzhGV5szt99wTB5ivm5PhUM1S37zeZplFNzHnqf664Wr6RlZsF46M/q3RBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKSuhfGx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKSuhfGx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38BD1F000E9;
	Tue,  4 Aug 2026 19:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785872729;
	bh=bxBL4ckPq9eQnPsSXoz3nYAhm9DMwzfrv1zrmbfeApg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PKSuhfGxbqZdESXxx9r4qNR3GA8/nTmz9/Qg1oboU3wUdxYEIWxYFyv+Aa9BwVC75
	 2ddZte5IteENHV8BTng8w7xbg7r/s4PBNRJrYNAWmAXKYliNnrf7SFIFe8/pgB22qK
	 AHeKeNsyGfoB8tta2Dp9K4nEwYNuMmbYZx4QZYdDd8WauzrNIxG6WhKYR+FHoNL3i4
	 OtEEfPYtnRQ9AXb/komz/78/lMS5IuRy2T6GIIJRHFjbKBNl+hxhp0JAZ0HBkL5wUU
	 Vwdx+TybOLA7/46UjRnbIPAKovDs7kWqhok+bbKNvPeAKzIafGAc+iteqePb/9MYs7
	 jgTEwu5GTIaUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 03/12] cxl: Share HDM decoder decode logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260804192958.1823952-4-smadhavan@nvidia.com>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-4-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 19:45:28 +0000
Message-Id: <20260804194528.C38BD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a helper to resolve a CXL port upstream PCI device for paths
> that need to associate CXL core state with the parent PCI function.
>=20
> Move HDM decoder register decoding into a helper shared by normal CXL
> core enumeration and early PCI HDM cache setup. This keeps validation of
> base, size, interleave, target type, and enable state in one place before
> adding another HDM parser.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804192958.1823=
952-1-smadhavan@nvidia.com?part=3D3

