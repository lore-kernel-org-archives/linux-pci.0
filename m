Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D27483809
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764246; cv=none; b=hacl4JS3NGUQ+6iFuNFuxCzbvktdUGDjK+EjijqxdXR0WBY6OvFfB1v8VZGt3Z4T5nxEZhfWfxtqMLdmnNN9dnrJTCncRqRsWub/yXySfMPFsItwTEy+zUvRpDPlfd4zku6kNoe15ZnbeUhTZuWXtFm+v08+Gs4CjTuQH7tKM+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764246; c=relaxed/simple;
	bh=zxkzDL9CO9R0jF5VjzsVbzgedG9lpa0nQIRINBxZ/Lc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AgZCxwMYCrzKn1C1+mg7pMhY0jirux43WErbJ7AW1Z/bD7M9bTFUbQaRd+5fiYVd64W/njItj0nG4bLRCRdMwrozCiRBA5+C2rQB2aIyZHW9vQhyRCB8jTFO2lJY9RFETG39wEOyoRiem0U3NH35KaBLDSuG1b/si5btmTF5XRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKlwFQ2v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKlwFQ2v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1CD1F00893;
	Wed, 30 Sep 2026 10:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790764245;
	bh=zxkzDL9CO9R0jF5VjzsVbzgedG9lpa0nQIRINBxZ/Lc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aKlwFQ2vltkvCfhnZFnvysmqfVfOD7HPfjj98PpVlgCjE3cz6o9Qsod0UAzcYm/pZ
	 QP2A+cDYXuRvZBYWm9mz3RJmz11HuyhtZTp+9du42PEkfbikeIHo1ki8R8sSikgbmC
	 9XUBoZA1FnSgREztxRpCeV/RvHY7wz0x2iqV73MdjM5L7GS56yW4HkFppuD/nVYdn5
	 QzKpQhkP90l3y1pIfO+ChhMwsICPruuDsJe3kJTnUbCHu29JUGVirNVwWw6wn+DCKr
	 NHV3/HP7XZQXmQQCOX7JzAJsZY9wexnU6WjVANY9A+CtbD29CYRrHx86rSck2+bNF4
	 5CooWHhiMpVsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/10] rust: pci: add is_physfn(), to check for PFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: gary@garyguo.net, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <d40371fcc6467b38bb5727e7292dc34f54bdc7fe.1790759932.git.zhiw@nvidia.com>
References: <cover.1790705494.git.zhiw@nvidia.com>
 <d40371fcc6467b38bb5727e7292dc34f54bdc7fe.1790759932.git.zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 10:30:44 +0000
Message-Id: <20260930103044.CD1CD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Peter Colberg <peter@colberg.org>
>=20
> Add an internal method to check if a PCI device is a Physical Function
> (PF). The SR-IOV implementation uses this role check to validate
> configuration requests.
>=20
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Peter Colberg <peter@colberg.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790705494.gi=
t.zhiw@nvidia.com?part=3D4

