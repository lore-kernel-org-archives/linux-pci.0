Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D52A38F927;
	Thu,  1 Oct 2026 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865596; cv=none; b=sQQ/0+U8+eAMP0l5IDMw4pLv0eVdCDN3NHNjoC8qyryvQUahBvwItZR4bc72EGDehpMNX5O7YbSaggvF/JgS+4zDyy9bzl6rIwXaW0tn8MMLnVUV9qhZsSyhXDPGi0MXKWdbjjWLJoXvA/RIv1giCcPi473mxXSdiIHdIY1Wwzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865596; c=relaxed/simple;
	bh=pshUiJUSKlMwqudHTUXdFEKcbaPqdGCRtKcGhBVn1Fs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BHZfbsZyoKU9RN4SMRYLcTOQwwuYHfwq3viV98tNigRWBRahZe+dOaHhG9uOTYeAZ4ZGPt1Nfyl6BTRFk4fvcicujMAJ0MUdviX6pOafIjCG6wj/iGmRt2FypGOjACedO5/b7PfPBWhhHzP3cKR0pFLf10Zd9BU2rf+RiESFDqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c10rtrZf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c10rtrZf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313D81F00898;
	Thu,  1 Oct 2026 14:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790865589;
	bh=pshUiJUSKlMwqudHTUXdFEKcbaPqdGCRtKcGhBVn1Fs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c10rtrZf654L7sABQm5vyj19Az5tYWUZdN7JtBMc3qWSgGJUrjJqCUo4lB1NgO44J
	 khza3QyZaPKGz6ZRkEfDLaBU8A/A6war7LradhRumZ1iEAB0mTUuNQs4wGGjXOG4Wt
	 3coZ37SFnyPzMeCVzRyIvTcJaBcxF44o6diOQXR6VRQ4m3ho3MSjfOBP8JFXmmtulI
	 edccLm3QvRMRsGl02N+I/7eS9xY8hj0MEKIMiMX4Th32/pbQwWfpTm/dYlsQNx7NpR
	 +1Q/ECJvWt4bJP+b4XUQvKbYSLq78udMLjLS/iDp1wTzMUvDOCx+U1YFsdC4aGkHKB
	 LNmiEEZNVmDcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 10/10] PCI: of: Avoid np->data usage for the node
 changeset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261001142815.277550-11-herve.codina@bootlin.com>
References: <20261001142815.277550-1-herve.codina@bootlin.com>
 <20261001142815.277550-11-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 14:39:48 +0000
Message-Id: <20261001143949.313D81F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

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

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001142815.2775=
50-1-herve.codina@bootlin.com?part=3D10

