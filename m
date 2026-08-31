Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C999038AC72;
	Mon, 31 Aug 2026 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788208560; cv=none; b=XJuTQnzQjPbHnjArjAcmbW9n/4SHizOMohmJC22POgRsRBxQWNpQcXgDZn1k9TaUONLU87Vc/jlnZAz92fNDVrU1m3di7GDYvPqwVSSwnQlVRQf/c9DZ9P8o7+PgMzogvd7Uk0fvYoUkgF/B7K3FKBkFcMV9RIiUgYktXnNWpkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788208560; c=relaxed/simple;
	bh=2wSukGzH3txT+xHILH0mgXwkLueWrbum7K6uSb7Lxno=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M7sVWx0lR2N2IyQ6rM+8A0cCLEf7zWZjSFJ0xxWGTyd0MkVx8oWYIiuTp/Qk2IAQSqCYXG0n4y9tTF58vX034WRnbqm7hM8Lp02ZD5UgJ+FmzU+7KnbodAHgG3UQUARHTOLU9OU7huKSrcD5lVIwJ+hOlXLDwrIvpjYzgR5x3IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1cY+laN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1cY+laN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B481F000E9;
	Mon, 31 Aug 2026 20:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788208559;
	bh=2wSukGzH3txT+xHILH0mgXwkLueWrbum7K6uSb7Lxno=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i1cY+laNF5s2BsJ6X5l26q3A3IjVHwUCuey5mejmE30Mfp5K0LMclCirmjhAIaIMq
	 TWLtvZMUUBWYhK52jSD6HcOVkDrEoyPaqfT7QLJAKSQsaHX3u0RcO4FMSCaz7ij3Mk
	 6sO9xJj0Qol40k62jnXJnvaMQqc7kyrosnS7KBC82DuDgthPIhlVSAe53GqUt5sTG5
	 dQ8cBfvhvsWZ/CdG7iDPXTBNZ0Xz+DNPYq07pevgB8+X1iuCuF0DGscg/M9kkL1Y7g
	 vuLBNrw2MW999lWPp4v/TsANA4R8gYEdSyPDawbOsWlkptMTYEd9FpGkBNqrMsWgN8
	 jWm9wi9mJGmiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/7] PCI: endpoint: pci-epf-vntb: Move
 epf_ntb_is_bar_used() up
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260831182657.329614-4-den@valinux.co.jp>
References: <20260831182657.329614-1-den@valinux.co.jp>
 <20260831182657.329614-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 20:35:58 +0000
Message-Id: <20260831203559.29B481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move epf_ntb_is_bar_used() up so later BAR selection code can call it
> without a forward declaration. No functional change.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831182657.3296=
14-1-den@valinux.co.jp?part=3D3

