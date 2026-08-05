Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8EF3C4172
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948690; cv=none; b=Cg1Ay6Mn5vOVsFxg3Tq76vyGe6sTf22t5tWCMWIMQV8M6uh9/6kAtrPH2WDzHSFNlP3JgCe65A7LH2G1xLZLnU1aZyD3TlMik2Fdkv8QPMuNYYX0ArW7jLek8uOYTbn34a3Oa2rOd0wGpi2H523vcgQAT0Gieg+goTMf/EY1IUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948690; c=relaxed/simple;
	bh=fP8aIm5ucdJdsxoDwpH9JoffWb3YynVHVGPzpppRIsM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Eh+MR4f9/IjY8VljE+GDSMUc5y/yj3EqZeC3e8X02uVi42Hh3DxmRDCgFr2dNJLa48MZhO2Vkg2I/bwk8UYD17SiiLEFu47H3tK60Q91QZos3dJg/Xom5wL1FZbrkRd0SdI6xwyYwHeHqaVs3FxRsE3zgZld4ixpaLC1ooDg1QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQAHtMwj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQAHtMwj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F681F000E9;
	Wed,  5 Aug 2026 16:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948688;
	bh=fP8aIm5ucdJdsxoDwpH9JoffWb3YynVHVGPzpppRIsM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JQAHtMwjmfGrr/H9oR/QGrlcK0If186NTrIq7VO1K8O61el3L+6qeraeGG9IIKWkS
	 yQTXoa+fZaS6M2ZI535n53/6/uqKBM5h1akoSmzzAQBsyoYhhvi1Lp0QO9cLOylD9f
	 S/hE5kRXMjvm9T3VnskgmELxUYlTOS2A6kK4c3e7hP3ZYqMeUNmGWhzlhri9lTimcH
	 JAnXYnVhcp83qd+v9X5+rz32Z03kMO6n9nw7gj1d1yxh8SKAJzDr8e/XhqSLyCYTQN
	 G3Z+TO+LHkPIy7ylj5Oh6h8qfir9ZCPZYr02LrkGdmmVszK4XRyfyTQjIKdG7Ov+C3
	 r9R4DKgtGzHLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/16] rust: io: register: remove relative registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260805-typed_register-v2-14-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-14-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:51:28 +0000
Message-Id: <20260805165128.91F681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Relative registers can be better served by projection to subregion instead
> of ad-hoc handling in register macro. Projection composes better (e.g. it
> natively allows relative registers of relative registers without needing
> additional support).
>=20
> Remove relative register support, and update the documentation to
> demonstrate how projection and subregions can be used to achieve this
> instead.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D14

