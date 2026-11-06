Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974963;
	b=xK337pu6Dcgs9/UMokAw312jDE2nbzpiWoeXgzpHJHVMN2e1VLBYHdOO1GWhHr/Szpeg
	 LvMzsNFCpcqDxDbEt5pEkdOmFiNPa4OgLba4WrQYe54Z5RWo8CDYztm0714fnr1N0ai8x
	 CIHgwdsvf2jV8QPAsAALpuRCTqnBKeplhg4BwaMoHlNDYyAmVz/xALrWp7NhncUDREG5e
	 qHQtOSodvvprh3DIHPlVphS3zfMVBU2NfXljuQnzfPl/ax6G+4cJB+ds29R1QNMI8TeGL
	 Y8nGsR4RGYibxQqoTV3HWSBdP0oOPWpp8sT11ttd5URm1h2LaIFxr8HE3eLIC0I8/zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974963;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Mhey8pg0FPN89G8EoC/Z/F2FrTY9WdezEaVC59gPMQ0=;
	b=3hOkTLElUWPAM1pH7238wLgmyFuJ0Tn7GmqbF/O0dW5Xy0IixOVn+OrJB899O7beCMGf
	 j2oWN9ONbOTcbztjeVWQ2BqqfPJiEyzHnScDLDq6eclIsmj5M5tsLvR9mtfIFjvSL2ZW6
	 /AK1SSoKBRgChm+XcQ/n8qEuBEG6nxm5XuhaAx+54lBxDRvi6AnWjt8TPGwTVanNW9Qcb
	 w2TkDg3/TAnNaFt5Wo9PnxppOuLQMy+Cu9Imq4r9ERa5UDoVrCqWZ/1VAnjcbrkPe/f05
	 qbeSKGLi9pcvSoVpNKzp3NnJCp/rm9qPRYXlwiO4EvJZgtZGPr+kxNkUCQDaUg1w3kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hL9n4Cvn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78048606A326
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hL9n4Cvn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECA71F008A2;
	Fri,  6 Nov 2026 14:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974963;
	bh=Mhey8pg0FPN89G8EoC/Z/F2FrTY9WdezEaVC59gPMQ0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=hL9n4CvnLoKlLA/VIYd/cf43+PtyknJeKtueqDmb1AMhMBb7z9X4PNJVKbxilE0dY
	 fYYyz5Whcr4KCdAAf+JfxtZF6jpepKZ1Lq2Hbi6oaZAfpT3etZ/1kPO5YWPFMfQgQP
	 EsfciNJCnLMtSJNLmT9vLhSJ8y/6JpNpAoeWggVDfGTWUn4ha2Reybnja/8zm+qUGe
	 8lUqWyAe3wBGCxfcig2egQo0YHegGrm4hmczwMnHz5cID+QAEyQpMfeOiIIhbSlJEC
	 qeoxT2XJAGo6r6Cu55fDykVq6v/wJu3DuBNZzIEUKFNFjeP0lE75iaAhaua8S62lb/
	 c1HD3Cva9XD8A==
Message-ID: <sashiko-outbox-201571@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/14] PCI: Derive aligns[] array size in a define
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261106134341.39493-8-ilpo.jarvinen@linux.intel.com>
References: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
 <20261106134341.39493-8-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:22:42 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The aligns[] array in pbus_size_mem() is sized with a literal with a
> comment explaining the number. Add a define PCI_RES_ALIGN_RANGE that
> derives the value from those sizes.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106134341.3949=
3-1-ilpo.jarvinen@linux.intel.com?part=3D7

