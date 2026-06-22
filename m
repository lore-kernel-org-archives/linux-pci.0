Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5518939E6F8
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782121239; cv=none; b=bFLGhiW8E8URd7j4/CkQyvSlJGaKd/mtV82ZMaPkW6CQV0XjCak55sHQEiTsihu0vi8EDLxfwctWmNOv1CDviQYcpAoYWs/rztuX3ITc97dOnwik3X9fhrLG2+g5kZ22RPPaAV/WFzJtJY23SR+YhlPWU8lGjbUeldGWHQLAmnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782121239; c=relaxed/simple;
	bh=3fj2/WElhfX00tu4nzinXQ4bxQmPTjDsrxzB4qKU/hc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KLZSrIXJGfeH1/xCt6r1vz44+Gne5rTnIfxJEWVKXXISPfq1f+J4+AaneAre6NAXjvBt35KJRcZ7S62lUPJvmcQc7a67wuC4cwiWHHVotstGJcQMtvIkZNGpj4qdKM/EvSEqooiS2o5oAiDRPdzfMuFXJHenMDvVc0EbrH6l66U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/3kMLpj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/3kMLpj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D171F000E9;
	Mon, 22 Jun 2026 09:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782121236;
	bh=3fj2/WElhfX00tu4nzinXQ4bxQmPTjDsrxzB4qKU/hc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q/3kMLpjwynQ1nC4tKEbxnkv3TXMspF/BsL27LnHtwJA0RxtB3kVot+Tg+VNLzEru
	 QEUxRvgiFfVwwh/nzF5Qlq3jXN/IcI3iELwyfiyGM+kgi/cMjiBgVgybCvfroh4iN5
	 wPf/bQPHZuP+o6x7eZRXkCaWeuIJTseotnCveJRjhDIHWBnUEzvUGOu59KV6ei4Xm8
	 gNOKRLOVetFMaFEBa5CUL5j+RvJUfZDHszNr7DDBk+jMgoCQceuBDEOx+7x2V+pif8
	 LVb1k8Gy1r9kMCcz7ZThLw7enLOB4990qQV5/oqi2vFA0mfGfk8NN2aAlYRxXjj66G
	 z98BdsGTJYLEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/IOV: Drop device reference on sriov_init() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoxiang Li" <haoxiang_li2024@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260622093132.910859-1-haoxiang_li2024@163.com>
References: <20260622093132.910859-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 09:40:36 +0000
Message-Id: <20260622094036.84D171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> sriov_init() takes a reference to another PF device with pci_dev_get()
> when an existing PF is found on the bus. If compute_max_vf_buses() fails
> afterwards, the error path clears dev->sriov and frees the pci_sriov
> structure, but does not drop that reference.
>=20
> Release iov->dev before freeing iov on the error path, matching the
> cleanup done by sriov_release().
>=20
> Fixes: ea9a8854161d ("PCI: Set SR-IOV NumVFs to zero after enumeration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622093132.9108=
59-1-haoxiang_li2024@163.com?part=3D1

