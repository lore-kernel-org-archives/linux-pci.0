Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896044;
	b=YyAZPjOjW8MxoTDorXqBMf10EldLbReR2AV4JU+/SoLHEzhUAXZGG+sqPpyXVg6lAUt7
	 pI2JN5rDlFRNiMAMFwmpkIFw3qOppT9EsJxmrmw2CV6ljF1Cc9H3k2UtU1oPgelsQXu+1
	 rW1Wanum9VqS/zJkprmSlrsGsjkPvaHH/7H1Wii6XY1lVduSyZ/7upLE508On7QPK7/w7
	 zQ0ntgmgJaWfDz7efALuG1PD0vxf6Isvs41vm0/TGGEYspYmsjxJPD61viieihZFSxu0g
	 9at36EaVurMQWvA0sjGzC8TY4b3SlYfGwel1nYR0TmWT4BxZpnw/MU5RMf2Cz7L8b+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896044;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=f0va9JVk4oPY+hysk55o+4CNLfPS7TKrtHdSRRkGDk0=;
	b=x8kEH07qzipGRpq1VFkm7gN5x7C1UEvat9Q/Wv5OC9cSVLuRAkqgNkhv2D/I0PcoU7Jq
	 obBBuUWRIxi1dVBwcGsomjMhwhg0OuU6VYhpyyc5vytGHVBMC+1IdLCPuKIWKd7LfEIb6
	 RJ4vuHqV8ENC7pXXnSuyY8XdHZ/RDUX4k1NA2KPEtSqy7Tk+G0t02j02Jr7sg0dtxTE0X
	 3TJEye8IVl5eJliNdU7B/C0lx4IVHic4m/0QpbALkqbMtztmPJAVqoih1LatehiJPiIEl
	 5FHdjF+7sf7iwzemvt+7oxf+POjAYDPkL7nXcOWmYPqCVggChe4iGD5kXp+E/v1KvYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oUOiwoOF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0AF606D83B
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oUOiwoOF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE941F00A1C;
	Thu,  5 Nov 2026 16:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896043;
	bh=f0va9JVk4oPY+hysk55o+4CNLfPS7TKrtHdSRRkGDk0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oUOiwoOF2MzNSOUv6eCI3waQFsVHk9FIA8svrpky03fGREHMeYg1XstF9MlxfqFtg
	 K3MfccGiIjlO+XIUWXF5CqNfI8Rblw1+TaP3Wa3wEa/PcGCAnzzQaNP+ToivRqsB90
	 LPAEekAZtJGx+r1l0PtsdBSXcIoF+tUKIVxyG5LkyzQ9QhxoP8crPJPigO8kwbUho5
	 laSTVOBsBhYE7XQtlS27cIzcTJnE85C2VkrwCzlNYiOk729GEkEBlLyp9/K/kHFw5q
	 a1DStXrRRPKbUHzt/puNnbnqdM4dkT4d+TVhTI9wk7M0R+egkRqcnA2zcWzYU7FbQl
	 QFNmDE9/JJcpA==
Message-ID: <sashiko-outbox-199491@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 10/10] PCI: of: Avoid np->data usage for the node
 changeset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103155540.365294-11-herve.codina@bootlin.com>
References: <20261103155540.365294-1-herve.codina@bootlin.com>
 <20261103155540.365294-11-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:27:22 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> of_pci_remove_node() and of_pci_remove_host_bridge_node() check
> whether the node is dynamic but not whether it has valid private data.
>=20
> During the node creation, an OF changeset is used and this changeset is
> stored in np->data to be available for removal functions.
>=20
> If, for instance, a PCI host bridge is created using a device-tree
> overlay, the related node will have the dynamic flag set but np->data
> will be NULL. This leads to NULL pointer dereferences.
>=20
> Checking for a non-NULL np->data pointer to determine if the node has
> been created by the PCI node creation process is not enough. Indeed,
> on some platforms like PowerPC, the OF_RECONFIG_ATTACH_NODE notifier
> (e.g., in the pci_dn_reconfig_notifier() function) intercepts node
> additions and populates np->data with its own structure, such as a
> [ ... ]
>=20
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Fixes: 1f340724419e ("PCI: of: Create device tree PCI host bridge node")
> Cc: <stable+noautosel@kernel.org> # Issue not triggered but could be a pr=
oblem
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103155540.3652=
94-1-herve.codina@bootlin.com?part=3D10

