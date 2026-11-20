Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795134784;
	b=yNwF7j6iVSf58bwgfeQEfBFTFp3zB+uG4qlEfTNCycoH4z41HIBVwMYpIa0ojMUEUPRp
	 2B3qWytyE7I4RphqsRxZJ3zCddOGjoG1OSCYtooBBGU/BHT9fKjq7OYD0YmvaRx1hatDM
	 X+NB3ShNrTpI/LYaSHDFKqAXagBPzKCQSVzG4gm742Z6lvlGifsrap4jPDffjyGX9Pmdf
	 JpXiqagIRfYlJSovcQv0M6jbsK6t6f0xhNBc1ve7TsuwnHuaabArIbad6GXSGxUbq1MHc
	 qfS9pkKD6e4feJoQFzYk2MnszZmN/ud9yd7/dAIddQLqb3fJePwiqWBYns6owmDcuyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795134784;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i+//5fDqW6QSGTsBYM9qSRUey958BtQeeiheOzcQg80=;
	b=a9KSCoVNRYkC+Qlqr3YQzzlOUCOLe9Ws3Lj3UKs4XrU3mNLGxdS+uUAS/SLwfC9WvjYu
	 jP7doxgOeJeOp+bSOY7BSFFwbUwLsYU0WWA7WeljaOrSvspRXqx/v+OAE++mKztXndDA/
	 wYCWKOpXCGrwz+FKWdKCcz/zCqc/zEx4FmzcFSkz+H3eL4NiECq2ZejEBPqZxrbvKUbb3
	 mGM81qTalTM8DQ1LRQ8R03Sp8prHRmwxEfXC3pMcJOAkZHixzGaHtoLRWbwUtJ7AljYDD
	 wfc5cXrb9xajld/K6NKV85RTbN12uY707SEaNFpS+GkeKWSsBdbXR+ibon6TzBqhPIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BjoFYhC+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A28C606A339
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 00:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BjoFYhC+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6571F000C4;
	Fri, 20 Nov 2026 00:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795134783;
	bh=i+//5fDqW6QSGTsBYM9qSRUey958BtQeeiheOzcQg80=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BjoFYhC+TjysRe+5aKiy4/MIAu+Jl//U4TMnukg4DjLgzIdF9zExmxWsYdOB0WfnS
	 q8I+2bfEBvMNSnNjfX8+6EhDhLRNbo+xTdkYaNpwsmohRDZfDcpF8f3cqYE+yPSMnB
	 7e+mJzVD/IcFGfyZGKtpVtDmWKEWmegW3ueQGun9JFFJ4emTgk4S6bR50SpRkMuzAb
	 P/9jcD+uclL65mTVikuXjjxxAJQ6XAtD0L7Ng2Kxj6QcontQsrSJbVYDrVY2Nwd4JR
	 zRizN0VTX/gOEMs5qik3xKpRHmxHRv2V0z+0jdCBPL2Vc/pTMWXonINptI3nFJTGWm
	 bvDt2VmrxTgng==
Message-ID: <sashiko-outbox-224268@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] iommu: Track whether pci_dev_reset_iommu_done()
 needs to restore state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danny Gonzalez" <digonzal@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261120002311.394649-2-digonzal@google.com>
References: <20261120002311.394649-1-digonzal@google.com>
 <20261120002311.394649-2-digonzal@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 00:33:02 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Currently, pci_dev_reset_iommu_done() relies on the assumption that
> pci_ats_supported() and dev_has_iommu() always return the same values
> they returned in pci_dev_reset_iommu_prepare(). While that may be true
> today, relying on both calls evaluating identically is fragile: if they
> ever return different values, gdev->reset_depth, group->recovery_cnt,
> group->domain, and gdev->blocked will get out of sync.
>=20
> Have pci_dev_reset_iommu_prepare() track whether
> pci_dev_reset_iommu_done() needs to restore IOMMU state via a @restore
> output flag, and pass @restore to pci_dev_reset_iommu_done() instead of
> re-evaluating pci_ats_supported() and dev_has_iommu().
>=20
> Signed-off-by: Danny Gonzalez <digonzal@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120002311.3946=
49-1-digonzal@google.com?part=3D1

