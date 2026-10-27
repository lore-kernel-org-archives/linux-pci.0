Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104384;
	b=KGckYcloZRqDM0jbyk5up9ffHGpADcC5+fzyVrp1IlNEiIkIvrlXeZ0dKEqM2j9YNnAW
	 2alLNJT+wqzrtXCj/9bY9Jc9ZCXwR158LiRZQ9PMVQOglI+SS8pr6djwUbpIozYsyhquz
	 dhHexRoR2Bemw1RAdNrWRlfng8j3JDGz2MOgCUkqnvSplmO/3Ns5Orh7O3LtXxZRaoeNp
	 TxwRcDWDzNqChslgquT4K74xHIvRpVWrEgScB1KL160LFRWcw3iEuljxIIbWMCK/m4MZx
	 XdOm9GSWfE16PMQYJeFR+mMeZ35PZElskyJjA2PgD6onp9zi/nM/g3nl1pEzrSQXBUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104384;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cktLCCvGV2ePPb0t2WEacBKLCZKc+3CdwxumUaFWyak=;
	b=QLYw9Z+m3zL3cI/Vg3jr3lsiu1H6XSTCdb9v+crXNDrmE1zN7/LjsQ09Tis1mtPKiAix
	 eDlSrySp1yl/WV14dfiw+H5M8ukdwrpPe1PcBNtFHJYfvhcFQphsgd+zmhBaWyEMHE5xc
	 +nkDRZkjfvgoFUlleTVrwWO2ov/VCXf2vecKzcFV7tzAzDT6lzEx0UXHu7V/T37F8tLcS
	 dbfSnaI83gCGv6F474px03He5baFGVY3bXlr7s64x/fCehbNXzccPZu+I422Eok2LSjql
	 n21U7OIFq/QkVDmAdbf+Vlmjl6uhOG1qoTdbr6gt+mFwD2WKYo/+qw0BRciu2Dwef4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JwqAn2UG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE9B606A324
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JwqAn2UG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591B71F01825;
	Tue, 27 Oct 2026 12:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793104383;
	bh=cktLCCvGV2ePPb0t2WEacBKLCZKc+3CdwxumUaFWyak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JwqAn2UGQSqMSIUMDgI4V0LA22jdkqh40J0zjrZCUXpkHPAUy9I702vMy3DTDa8Xm
	 E9D7SwQzlr2HdzjAyVN2UsFk52NJkI9eHgofpnlRRrsx49W2H9fsz9yUSpFNQVoCQ2
	 EkODeRTGXag+4nJI+q30Pnue23YjZpMgDGCgTDVzx3hCeDVaenRapc58v5NiObfOvX
	 VfB3ltE1pZHppqcUPn3HWsmjrg0G2xJVteX86k/E3cmbyiQ78wKJBHKRd4qnTisrx/
	 zsGQR3drqgOEz/zO1xqp2s0Iu/dz2Yr3FYs7zNPbxpc1kUlP6/RryC6VVcumgdhDG0
	 jlNSnlT9/x11Q==
Message-ID: <sashiko-outbox-186558@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/16] PCI: dwc: spear13xx: Use cached PCIe
 capability offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261027122827.2725643-15-18255117159@163.com>
References: <20261027122827.2725643-1-18255117159@163.com>
 <20261027122827.2725643-15-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:33:02 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> spear13xx_pcie_host_init() runs from the .init callback with the
> controller already enabled. Replace the capability search with
> dw_pcie_get_pcie_cap() and store the offset in a u8.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027122827.2725=
643-1-18255117159@163.com?part=3D14

