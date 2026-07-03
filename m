Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086411A704B;
	Fri,  3 Jul 2026 02:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783044794; cv=none; b=JWrTg+CWXLlRdlDKNR2WaGXSl2bVzIhVrnudFL98ppwkHXd7QMxoHdjOBEoPUSup+GJHNErWWGg6NM0aqTD3UOyCl5TiR0Ec2FVEZd7543z6zXHMPfMbWWGd5HlzbhTO7NAHwCJzruzjTzAo1gEqPEArqurDROea2n+BpyuXQns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783044794; c=relaxed/simple;
	bh=lXJKRwaIreHX7iqJY+Kswc621+NZ1YBTrsZP5kFwW7g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=io94aO9z8nD+aqnuQvQMS+HYBaIYpvcgWjhWNsPFa0mUYS/v/ExuC6fdFzf7yt2GOh1ns+oivdiANkx53oRosuil26Csn70YRZqzvOOKFZCUYh3JwPhTxxhMNUaihmYkHgpzb7P2c1aBFzZXeeDVtMUDFNKYuzQ+heifw4dEqF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6qWYtAD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6qWYtAD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494D21F000E9;
	Fri,  3 Jul 2026 02:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783044793;
	bh=lXJKRwaIreHX7iqJY+Kswc621+NZ1YBTrsZP5kFwW7g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V6qWYtAD5ktq1b/Fl2yrcWKcOVtVZieVzzICg4qz+tL4W5Cyt9SGouFC3GB7Ol/gF
	 jRg+Zo0GGLmJ5MTtjCsDRM+hqfjM+eBt0QUTKQfcle8nC3ky8LPOiTYLmiAGKk4l5n
	 eItIy5VXtzRL7pesxxzm9BZHgoZMFU7EoT5wzVpibtwHSJaIocTYDWf4Igj8Zm39PG
	 zIYudisWTIqG2RU6FspSkCI8qb+dU4zYaWAYcb/66KImsnXmEFdstOyiFVQ9T+y+AO
	 mU6PdIhQkYKmAyYLsYj3Jud+oPwhtFoIeQ5idfRXiv+5SQsfuBbj4iBLwz3Xruvimw
	 6hrCkRKFWd9oA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/6] dt-bindings: PCI: snps,dw-pcie: Add msi-parent
 for MSI handle check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260703020003.485436-5-inochiama@gmail.com>
References: <20260703020003.485436-1-inochiama@gmail.com>
 <20260703020003.485436-5-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 02:13:12 +0000
Message-Id: <20260703021313.494D21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The IMSIC device on RISC-V based system does not require ID
> remapping for MSI. So this device only needs "msi-parent"
> property for IMSIC-based SoC, and the "msi-map" is not a
> necessary property.
>=20
> Add new condition for MSI handling on IMSIC based SoC.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703020003.4854=
36-1-inochiama@gmail.com?part=3D4

