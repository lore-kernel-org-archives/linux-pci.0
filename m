Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795780259;
	b=n1oVLPqmOZLR2hm9jmZlYT9Xrha1+SvjY4X5iAO322aiZtMLhd0wiNcwRgFe5thE1iSd
	 Mytkdt7aterlXBWW5reWc74u02T6G3SPFKtr7jM1ikM+hDFJg9JlIYGmVqpiy3T9VsWCy
	 KO2Ukl5kZuvD+x0zXF0dRwGTpQtL0NxQQ1W04Jbs36J7t1VXYrLZNCnNIbDJPW0Ppka+R
	 Osngka09KvlUXfvuMGTsFJ95Ekzstd09pf32H/UD8DwgIV0jzqPmCec0DkItfUQ/tInhy
	 +rF72T8IUQnAHx5PMGVaS9CHd6VIc/t8IBaQlENwvJ40arDVxEejTVG0k4Q6KZmZzSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780259;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CaMyxtBRkePEvUWkRkLuo5HZZVrmAPC0j1GrQFmPwy8=;
	b=w1AKbUCaSmSzP1IKsPt21/ndbAMC84OP1epEWix5l3CFpKTnC6p4yyQYpkacftXxnB73
	 H6GMgwUbu4zjOBaBeRW/FkJyTICscxbUfchZ8WPeIv8u83RboIOdBkBeHMOMMICLWdSNp
	 NnKYPkakvfib/2RZvmdTgtKGhGWjGHvvyMvj3n5uLqQdRFEl5NGS+ejgdhMpeTrDJUZme
	 TSDDTfGBRJZArmv2qHby+Z04bN6XiRz9a918zVJo2FOJCWUpSS1+Lr1q94KNURvhnoPjU
	 do9S63eINkwrcwL91Hea+/WyFMdJjAuXXddubIUYGuInjnqdLByHyiVwDROJP2yZRIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QEcSkwoD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89105606A31C
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 11:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QEcSkwoD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9901F000C1;
	Fri, 27 Nov 2026 11:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795780259;
	bh=CaMyxtBRkePEvUWkRkLuo5HZZVrmAPC0j1GrQFmPwy8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QEcSkwoD3PCPQCn9lUk88Y0gag4pm3n5NewGBZ+itf/De+M66FgjyJslNNx8L/f+/
	 aR3Jvi50YU0LhUnXj1SmJ09eIBYuHe23IB+siox8mKI225Aee+uZe6kz/o1WVitklI
	 pUORq1o4JjH6FdD4cCPnokqGbaqrhUNb1bb6jmUpKc+du4OZxabbCrcNS/OGFWW2XV
	 VrBAhYp67uPhO5gPVlmUHhFhGtWd/xQbbf0o3jn5Yho4UiW2Y6LT5znFqKEq1/oWLR
	 a+L/JUUb8IBQgpNt5qlfeXEjbIoEe84OeCLDK1v4Y9Z5lvcne2D/NTh5Gz30ECtJ9A
	 f73sWWtSPGC2Q==
Message-ID: <sashiko-outbox-237296@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 0/3] gpu: nova-core: gsp: fix the PCI location sent to
 GSP-RM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261127-nova-gsp-dbd-v1-0-0fb5f7c2ce63@nvidia.com>
References: <20261127-nova-gsp-dbd-v1-0-0fb5f7c2ce63@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 11:50:58 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 3-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-nova-gsp-d=
bd-v1-0-0fb5f7c2ce63@nvidia.com
