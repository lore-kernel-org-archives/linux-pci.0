Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6B748EBFA
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788784144; cv=none; b=eX21k1R+SrdaFgn3dEEZmnoUNqEQyl8sjWn5Y9Cbo0/QZSCBPVxT43kYGKAWGXi6LKMa33ZwfIRv1wImYkWg1vpudPKkXBZosUL+UxEe8aMKdiA5u8ReohikhDMq53JiZCqmYCYsHkBA9G1Ex7vvmG+8ZLPmPAyXrHMehMD7/uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788784144; c=relaxed/simple;
	bh=F/7HsINp+TzLGd0n04TwNz5/E2m8/HhDQuZXxO9IJd8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sgkw0rwnPMriBRHX+6CNF+YEwxckY1IQJvdgLMah5+jy4kh3fd8UxfRPMDiJqs5mhmhAKLUPXQovurukXmyf6McFjCrj4TUkZPV4aelXIoAfiU9I4f1fY9TiscvHCYmhg4RldgqAHAcvW35CliyjcUIZvYbySAFNItjJbI/yA/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtscFC+Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtscFC+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054B31F00A3E;
	Mon,  7 Sep 2026 12:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788784143;
	bh=F/7HsINp+TzLGd0n04TwNz5/E2m8/HhDQuZXxO9IJd8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FtscFC+YlC6kAk3d9kQKi0WuttNGroQKf2rwfLK2sD0kLMTE0gO7ktCJmDEHGQaf+
	 cwToNPtMjO8O5IwO6SbNcDAdmHa6b1xrdo17VbdrSDnWljae9f5AKoNdXQ5Clqjbxf
	 p4dJ/Df8/wr1B4N8SjeJ8n8EpkdFN3gapYK1PN+CwM/A7JIuqw/0NWqUFCOpy+91Ls
	 sYeoekpL6nusEcIfL8XAjV7P1QsJaJjBtnROnq8lCQM1qh6HJsbuvN6z4NmfcqXb7b
	 yFjBqR7W63dP4HM/Y62pJXwJ3ZGEDE7OoO5LkKGyPangFkPS87wZZ7KKyZHubM6OY4
	 gHOTNfU1AtmAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] power: sequencing: pwrseq-pcie-m2: Support PCIe switch
 topologies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Deng" <wei.deng@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260907122129.1577279-1-wei.deng@oss.qualcomm.com>
References: <20260907122129.1577279-1-wei.deng@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 12:29:02 +0000
Message-Id: <20260907122903.054B31F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The PCI parent OF node check in pwrseq_pcie_m2_notify() and
> pwrseq_pcie_m2_create_serdev() only looks at the immediate parent of the
> PCI endpoint device. This fails when a PCIe switch inserts one or more
> intermediate bridges between the root port and the endpoint.
>=20
> For example, on lemans-evk with IFP Mezzanine board, the Toshiba TC9562
> PCIe switch creates two bridge devices (upstream and downstream ports)
> without OF nodes, so the WCN6855 BT device appears at depth 3 and its
> immediate parent has of_node=3DNULL.
>=20
> Add a helper pwrseq_pcie_m2_pci_parent_matches() that walks the PCI
> parent chain upward until it finds a device whose OF node matches the
> expected connector port node, or reaches a non-PCI device. Replace both
> single-level checks with this helper to handle arbitrary PCIe switch
> depths.
>=20
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907122129.1577=
279-1-wei.deng@oss.qualcomm.com?part=3D1

