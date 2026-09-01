Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA5439B481
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282149; cv=none; b=BsbGaSMbRGPQJU5OynXgsGTVqboFKibkEH9PgJI3n389xP/9UM2duhz1daGI3FnDH/CgnR0akIgdP1qutBVSnsWRvKBQUQfGYEG8qnImkSzO9OHmreJVp1OEa2u0w5PmoUUTn16thACEweJSD6xGhVuaWr2yTAp6iQNUrPxm5aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282149; c=relaxed/simple;
	bh=7OyxcXjNio9xfsFpxDUvQBwVaapGhBg6JSqt4WDNPLo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=REFHCYnCs9aRLdR3V2GE01RWVeMxUQAa40CRpmAJCtWe0+Sbu6SezkjGYDdAd7MXo4ktG1f8/pvf7FAwAzTkmhar/0pby8IDkY9UMjsteOrKax8xd4Jg3JtfDP7ilHPxnADjFZs9EaMu2dySZ43lbjpoiMDtwx1JgAYiAtVZL6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCYKiTRn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCYKiTRn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFEF1F00A3A;
	Tue,  1 Sep 2026 17:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282147;
	bh=7OyxcXjNio9xfsFpxDUvQBwVaapGhBg6JSqt4WDNPLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LCYKiTRnDxleectKjtpciXToeKNpvOvr7roBkvfndqnOcRrHo2sM4UlrFPuIy+2id
	 SD6SKcBC3Vr4IcglYP3zEjHdpDBNu7JUNrbdGlLSIp4jPHwIEioEOpfr/EkaNHlJhs
	 EempGxieab7uUWiU3P54l0Is49jtTs/mKLdvKSweHHVVeIZAxe/cA/CUDPRGoYSZne
	 vLFjAg2CGRx3+BJmYU0is+SxFx4iM8n6gcQ2heBndUgU+ZZKnX2gvAn6v8lZpowqY5
	 XgZbbayCaHTLphloE0pZj42u5Ub5YLCnOjO5G+O5M/qbsuPs5FDq1CwnEycP4wR1Au
	 tlOhbVmS1SqWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/16] rust: io: register: remove relative registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, ojeda@kernel.org
In-Reply-To: <20260901-typed_register-v4-14-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-14-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:02:27 +0000
Message-Id: <20260901170227.8FFEF1F00A3A@smtp.kernel.org>
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
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D14

