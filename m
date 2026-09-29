Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D7E391E43
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 06:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664500; cv=none; b=HdZPcuNLaL3MJat28g2wuhhh3tWx4mUZLwfthRfdqKTje4NU1WWUxwZkDTFWbRhtmW2cmxS+Z4Rmt3YrSYVSUVo1/VTgeTSDvsmvbCfTqWqPAqZKlS8D91lnyAeKRrkxlwdnH56IkwscIUz+asQZ8aI3ww+dhHEljhXCQALZ9sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664500; c=relaxed/simple;
	bh=3/4vWNlx4CoBGDjbWmnqceFTI6BrUE23epqwAtocnz4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aeTNzkhipk2ZIIBE8wUGhRh6p8vLGwS5WaWDnoHEGBy8nG/fGFX+rqHcGlClTPrwZ/YYtplO2bnenxnlxZA+4cZMBktDbc21TMxTbRLvy/qTLoXtRYNbNXvC7sYjr0LblG0ejAakaRM7bgS6y0osPckCw3bTLrfCigZfPuUYjf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cpe0yLav; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cpe0yLav"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F96C1F000FF;
	Tue, 29 Sep 2026 06:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790664499;
	bh=3/4vWNlx4CoBGDjbWmnqceFTI6BrUE23epqwAtocnz4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cpe0yLavkEK7eQu34FB+6tbLH2fogwtB7qNgULSPgBmOwtF0p6mXlnmTcpwUGjY77
	 1r8/f3OFRrJRSz8DFEQOqDMOJIdp+0Pyo3pSobCDaTnnnaIS0ycV5WlBdECgK9rM/5
	 EOBJQpd0Qn4TQyMbqDeRD0ChkLaHOk97C0A76mTkv0b8sB1DRCW2r7EwZB69/RE3j+
	 Fm28ctHUIEuMYN80JhHC8HH3hgrpAmVTvg1u27TT2jA2qO4xFuoV5w6/55GAnpo9oo
	 USF/NDKzWEYjUnnOsreCXrUjNdU+j5nwXpdgNwiyGCNoC3f66sReWEh9ydXSNqs31H
	 nL9TCizgudfxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 16/16] iommu/arm-smmu-v3: Add KUnit unit tests for
 Runtime PM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260929034510.2023173-17-praan@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-17-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:48:19 +0000
Message-Id: <20260929064819.5F96C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Introduce kunit selftests to verify the Runtime PM elision gating,
> post-suspend elisions and progress on resumption under active
> invalidation load. Simulate concurrent HW suspension using a timer.
> Mock all HW registers and CMDQ buffers by allocating them on RAM.
> Make the mock CMDQ self-consuming to avoid hitting queue_full scenarios.
>=20
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929034510.2023=
173-1-praan@google.com?part=3D16

