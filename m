Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054A042CAEF;
	Thu, 13 Aug 2026 06:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603568; cv=none; b=FNbjL3q9+MJ7grJHEPXubiwbhejBZC6lhdR0LDVZYmm2Km+GYLRWqIB3Q0BTU/Qf+zChZronnbqrq8uqLFKTCVQL5Xztl4IDsH2Pf9gOFUw8XLVEO6TD/pNH9x35jxa3Cc0ur3XHkl1KU1cTg9du7Ul83wzyaAVN01htTALoVdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603568; c=relaxed/simple;
	bh=CBzNOFwDeyQCH9hZN2zxLpFQT8hWK5Dh0hqCjyMUrZQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lfY0Ip7IoxMylEFluftvYKcvkY5cLlebQVzHxK6c9EEEPNWs/LOgr11gpLYM3VyGIxLVyDkZooYKJVF19YdkPVBs2YeySnOOr1KZ68AmSzpz71sn7CeevWrQcGmhXGbCgVlY5W8QAh78yRSPCpSVUsBjThaNTWn8LsCfScLNswU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdc2LBdq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdc2LBdq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606E91F000E9;
	Thu, 13 Aug 2026 06:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786603566;
	bh=CBzNOFwDeyQCH9hZN2zxLpFQT8hWK5Dh0hqCjyMUrZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fdc2LBdqrP5a2WuW1oJaY1TSTMVkJ/CHvi9TEzMfAazHsNhrameRowBjEse2RqV14
	 luIpANvYCzok3HVxOCaJ7pY9tc2hIP4LCXJF+fA1wjBYra02/5VcY+Vv3n3qpPk/4Y
	 XrYkrqJNAqS1qWl+HYcyDbmtgDbDbsReMoIlubH6GjkniPobNJPZcRje8vsoMeH0V/
	 8247lbjyriGyFXTuNL7EFEfXjorc9PVsxfoaeM7XVxvx7OoWBCvzjRMJ5kvLHvlwBk
	 CFVhiWLntutXcMFbdQmNlWlIAjxQBGHQwwq/flvWYJvs5jI5AJzygYJ4CupiCq/bKZ
	 pklLz294+MgZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/10] Documentation: PCI: Add PCI DMA endpoint
 function documentation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260813063757.3131865-11-den@valinux.co.jp>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <20260813063757.3131865-11-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 06:46:06 +0000
Message-Id: <20260813064606.606E91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a function description and a user guide for pci-epf-dma. Describe
> the BAR-resident metadata consumed by dw-edma-pcie, the configfs
> attributes, endpoint controller requirements and the host-side DMAengine
> usage model.
>=20
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813063757.3131=
865-1-den@valinux.co.jp?part=3D10

