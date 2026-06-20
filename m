Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CAB2DC783
	for <linux-pci@vger.kernel.org>; Sat, 20 Jun 2026 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975393; cv=none; b=KzaZ2eHLV9hCcff46NJ5gBo1ecmXfNovh33Fwr1RqaOzKz/VF7vUaTXiJ60c2Axm4aJZv/y4WuW8nE/S8Yk4tKW24gMoymQYBdx0aqvHD0ZT6Bw74psfenavNSXNSd8D+42U8HhN9JlHvnmFbNAhUzrz0rDbZcr0jDpIECrrNqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975393; c=relaxed/simple;
	bh=mK/zRnd7wTUzz+iDqPHePEbllrQFLD02Zl8Al1Uj/K0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gcdFKNjI+US3ZszTKvk9riaVUfPfkEVFa7ZKPAKEnX5nFe07EK4rnMc7dmCgHz2pxK3NhbJVK25bvkqCQwYq5RiQMoIpKL6vDBhEswUXC7ng4GHGLTSvVP0lDZsDVQ1EQYXTnmPKIqBnaaeJd3fuUMl7W6c3oDSQc3Z+JWjmbWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkqkJGOQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkqkJGOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C4B1F00A3D;
	Sat, 20 Jun 2026 17:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781975392;
	bh=mK/zRnd7wTUzz+iDqPHePEbllrQFLD02Zl8Al1Uj/K0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BkqkJGOQ3rmveL5zM/zPhPzH4x/vuva3SHC1D7MioZDoBQe+w7BRw5WFsmykfrZSS
	 M5lbJYhpJ/4DYm7i/Mv/4ahxRqBPx3wnXVmLSscUMCSX6rvKy22aO+GvrhPQNDPMcL
	 RFMmYhNunxt889Mi90pU7vJZDGFfNzzNYV8FH7/TyKPUhLFwOl/h5Yqgh1iGVmqC+k
	 c4K8CSfXGkbbefE/oAyVefnmaRxtMTcEa7alp6PXU+ulAN6CyYmn9PZg82HGLI7qq4
	 Cft3RPVMd+ktABt7OJ8Cv/FH8fwL0LOLiVs4feORnYKIpc/HkZeqJQv8cZF/oWr9FW
	 DSE3GT+t4cg2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] PCI: endpoint: Add DMA auxiliary resource
 metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260620170438.3756593-3-den@valinux.co.jp>
References: <20260620170438.3756593-1-den@valinux.co.jp>
 <20260620170438.3756593-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 17:09:51 +0000
Message-Id: <20260620170952.08C4B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Extend EPC auxiliary resource metadata so endpoint functions can
> discover controller-owned DMA registers, logical DMA channels, and
> descriptor memory.
>=20
> The DMA metadata is intentionally generic at the EPC layer. A backend
> reports the register layout, channel counts, logical channel resources,
> and descriptor memory resources. Logical channels carry hardware channel
> numbers and refer to descriptor memory by ID; reserving or delegating
> those channels is handled by separate EPC operations so resource metadata
> stays independent of any backend-specific DMA provider. Descriptor memory
> is identified separately so one memory resource can be shared by multiple
> channels.
>=20
> For DesignWare controllers, reg_layout_data carries the eDMA/HDMA map
> format so a consumer can distinguish legacy, unroll, HDMA compatible,
> and HDMA native register layouts without making the EPC API itself
> DesignWare-specific.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620170438.3756=
593-1-den@valinux.co.jp?part=3D2

