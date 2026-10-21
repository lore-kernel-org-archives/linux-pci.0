Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590932;
	b=2VhWOPf4OYjihe94hvUlXLF+ZzuiC+F4KXdjuUDW7q8mbP+dviVTuSLr4kCIZt/38sKq
	 oztWrzpcsZv2SruYBDEvDv9qsFMt1ekMfXObY9psK29bKGTFU2stPJ/0iJJOzYJ+WKuTo
	 z0RqZVevFozd656EAgTdftIHVd0K+i6wR8mkQMlXe8S14ehVAUh7HNUWSx+UyDrKYCseD
	 NBXjU8hisDCt2Tr0scHbrhH1ZMYbXpdJU0xHThg0qYmmU/0GVRmYcfEJn+KlIrYgVCCC0
	 oJT36SrsZEv6ccYZ5L07fOmoMWcSAq5TSXr8tkYvAVsV7TezeRukEa16yieXBv22SFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590932;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A/uoN88f2DnSMPqeDxwW/QLltKh4rV9lJjjwzLkfR2I=;
	b=TLWL+6iD0hO7BhYJ8TDU0b1RSg8pzQFhHhrAcRq+G57yN/7AsQIaEviGpjdOKcj4+gAY
	 9JRg5v/tKwHZnSmwFVrJwmRKYloXf9wdIwFDSD/fFSx6ZdAHwKOLWQiMwJ2udLX9Hna9x
	 v+4W9HYE5phsgXZan9imVHcFdMKFWsXBs8QnzNnm6T/sEthlL6b7TYxReAcUL9o90nmLH
	 9YFPP8NKTSHTfqvedQDPKs4a7zLipPsoKiMSEQBu3+oowIKhUsMST5HyikFHRIdEimHgN
	 0oW5NPNwiDpznQhWi582qRPZH2dN1ZMyT1seLtbdnpc1iABTFv0HwC9JNMyggE6iV7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQIdgdSC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B01D606A31D
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQIdgdSC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8FE1F000C4;
	Wed, 21 Oct 2026 13:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792590932;
	bh=A/uoN88f2DnSMPqeDxwW/QLltKh4rV9lJjjwzLkfR2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bQIdgdSCx2ShKBaCPZzNxRBkMCG/iBoQ21EFF/SaDD4bi6k8Y/Vr8BRKTEj0nzUME
	 ChvFBF1rw8zn7O2oWWjDokHBPzy8jwVwg3NMMRwRwDHAlX/pf9pbR76WqpGkpk9/VB
	 Ssbas476E+6Zoo3ozuyETuLfmtQ9SXOcK3AwsjB4qX/KOwgQUTmIko8ZzpPzpapK27
	 lbxLHJNSe2iUQAriYcN/k99tKOciRtGwkehCnwYa51ydnAUPs+Jy2tcxR4wFPVpHD7
	 KrMRJy3gRVVsVOb7QLfuu44NfLTG1SVPjhVaiMndMT81rbU+Azrmeqeuee6m7GvPHO
	 rQ+oDk14BdbWg==
Message-ID: <sashiko-outbox-180333@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: connector: Add PCIe M.2 Mechanical Key
 B connector
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261021-pcie6_fix-v1-1-ad37134c35a3@oss.qualcomm.com>
References: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com>
 <20261021-pcie6_fix-v1-1-ad37134c35a3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 13:55:31 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add the devicetree binding for PCIe M.2 Mechanical Key B connector
> defined in the PCI Express M.2 Specification, r4.2, sec 3.2.19.1. This
> connector is used to attach WWAN Adapters to the host machine over
> interfaces such as PCIe, USB3.1 Gen1, SSIC, or USB 2.0, selected by the
> Adapter's configuration pins.
>=20
> The connector provides a primary power supply of 3.3V/VBAT, along with
> optional GPIO signals for WWAN-specific power/radio control:
> FULL_CARD_POWER_OFF#, RESET#, W_DISABLE1#/2#, WAKE_ON_WWAN#, and DPR.
>=20
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-pcie6_fix-=
v1-0-ad37134c35a3@oss.qualcomm.com?part=3D1

