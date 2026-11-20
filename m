Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795134846;
	b=fGS2VXedybo6bENcYYm1XZL1z+Wls7lqTezENgTeFrylEBR9kCUvo2fse8lmD3ey0jJm
	 SSgnlQPASHQ6Z8RJhtbIFrTwxWXRgieVYdTc2ZchoVGUE3qRrRyHYyFa3EOjrBVVXJA2e
	 DEX6nkzGlG0XHZgAau69EdaSZKCSd+iXpMAKCgzd51GZvf+jIKwl+BKJTENXnx87koKG6
	 iM8jT4JcTLNqhJImSItP+sTDPIuPvXJJm7AUzcePNR8jMAPgX4B/FGW7eXVPg7Ugplpjo
	 7JwNIRlLYHC7dkJVGPxyVaRoKcaa00XpDmuUZ7tUoeFI4inrunt10zQ8xUgrNsXdB9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795134846;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G/dfhM5jLfS4heb7FPLr44mtrSRB0rjpe+Ob5ZDfhag=;
	b=xqgjXR+65xsVdOpO+cIskVaB/gRIPjy5ZY3dTjOtOD9k8MUypgzjNsv5Hq060mg0/hDD
	 5SNhI8wXNhz12AP8o36CQndKNy7mr4YPUO1CVUfUJs4bZjCEdV+ovepP5ncHWgUdJKXRq
	 RvdzgqkM3PYaoCDLpr5WVbDPAvLlFaW8P2Tn0nn0+gqs/30DPvHSsNpqVjMFp3aCaJkHj
	 2zuM7OSud4wsmH1AVmpt4tNDdhTMwwZKZeblUnxL5quEhLDXrz5UEIIah22LaFCgDRbjR
	 ZqZSBA//Rc31di/jjO4ceWUspTt6PTyV+E/59VoPUcg+GQjTb/0T0G2+/BoPAMRp4rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ProWPoUp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E114606A320
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 00:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ProWPoUp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A431F000C4;
	Fri, 20 Nov 2026 00:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795134845;
	bh=G/dfhM5jLfS4heb7FPLr44mtrSRB0rjpe+Ob5ZDfhag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ProWPoUpSn7tv9I+sg8sAlDZEERYsSbkn7UelIcYmI2rFBZRWXZmN3gwhew1x8x/t
	 8aQurMM+C9JSBI3VddOfIRRPHkTD8SX9RSNBHnxhK0KKKBp0JlvtlbGikWPPtVsI4w
	 pIg+bKwsR7/tYLHNj3y584ZRauyhWwwjtUCZwqz7W3fr7URmxaUVwr9tuhTmzGSHOE
	 frVTpgtPU9VJqjpc1ujEdh4ALDJ79IGr/hmL0x5pJz+4E9bVxaKgruqFG0Jjtcb20u
	 B2bURJjZA363TuH/10Ex71bWfAUe/B1cnu7Pcd7fPB8w2zYHSdbIxXFJsUQfklBnMc
	 wZmUXEy6n9A0A==
Message-ID: <sashiko-outbox-224269@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] PCI/ATS: Disable ATS when ACS TB is set upstream
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danny Gonzalez" <digonzal@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261120002311.394649-3-digonzal@google.com>
References: <20261120002311.394649-1-digonzal@google.com>
 <20261120002311.394649-3-digonzal@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 00:34:05 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Enabling ATS allows an endpoint to cache translations and initiate DMA
> requests with Translated addresses, which an upstream bridge with ACS
> Translation Blocking (PCI_ACS_TB) set will block as ACS Violations.
> Because pci_enable_acs() preserves existing PCI_ACS_CTRL bits (e.g., from
> firmware, a kexec kernel, or "pci=3Dconfig_acs=3D") without relaxing them,
> PCI_ACS_TB may remain set on upstream bridges.
>=20
> Update pci_ats_supported() to walk upstream bridges and return false if
> any bridge has PCI_ACS_TB set, leaving the endpoint to use Untranslated
> addresses. Ignore bridges whose config read fails or returns an error
> response (PCI_POSSIBLE_ERROR()) so inaccessible bridges are not treated
> as having PCI_ACS_TB set.
>=20
> Tested by booting a machine with an endpoint advertising the ATS Capabili=
ty
> behind a Root Port with PCI_ACS_TB set; verified ATS is disabled and the
> system boots cleanly.
>=20
> Signed-off-by: Danny Gonzalez <digonzal@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120002311.3946=
49-1-digonzal@google.com?part=3D2

