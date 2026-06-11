Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C03236A34F
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200855; cv=none; b=dVmwq6CPnmJPOgPXbWhekG/mFZjPNFw4HpjZpsi62BhRK0UNn3heXdhz6iwJ5i90z+lwJBrwXf9R+QCzHNhezlENVHmSt9cfujl5YPJG4tcFNUjv6SAS/K7ODjqhvrMJi7OqKUVy8W5bui/8ch4jXCv2+A4gS/Qa8Dzb47ReoR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200855; c=relaxed/simple;
	bh=ycquyeVXr6bgIZr16uD8WlkI/eKF+zRgsiLiiWFk/vA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OvZS0ptdLpkr3r48tPeBC1XpmAdl4WZ8Uyr7RIWOBHjB91j1rtSw8wVuc+d7GMC/37H9UGBv737jatXgl5TOZ7G4feTmhbzly7DoyA8yZkz/D5a3exM+FULkQcQK4eBh+M6ETfH7LbA/X98jnOLCRuuqixJ092jB4C+EDHGTxy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLECK6Qa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLECK6Qa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960851F00893;
	Thu, 11 Jun 2026 18:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200850;
	bh=ycquyeVXr6bgIZr16uD8WlkI/eKF+zRgsiLiiWFk/vA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KLECK6QaPOWRjSm/O61FxDmvTmKYKbOH69a2wgHU96DcOtE29sWYvBtCbJ2U6CYJs
	 HoxQqPXdFz3fIRHx4oLq6dzygkMhvBfvyVLTphVrMjTOubZPJNRHL4SU8S3Rr8Rk7d
	 zAsxf0hhPWrezKKHXd3W9mMIHiVuoasjUAcCVt8pmEGCpu9UDUxO8T3yY+ZcC3WKz3
	 Hd6yByFG0c2nQbloaD3xtXLvvo3e7JGhFrkhhDjwklmCEt+ihdHUJH5VdYnFsRshKx
	 aTj5drYvKdvx4gwfDQqUbq6RNlHP2IzZMoJDD79HZsHnhTrNo7gF3nZLhv58dGS4Mn
	 NSmwEYB72qQPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/20] rust: io: move `Io` methods to extension trait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260611-io_projection-v4-11-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-11-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 18:00:50 +0000
Message-Id: <20260611180050.960851F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> `Io` trait now has a single required methods with many more provided
> methods. Provided methods may want to rely on their implementations to not
> be arbitrarily overridden by implementers for correctness or soundness.
>=20
> Thus, extract these methods to a new trait and provide a blanket
> implementation. This pattern is used extensively in userspace Rust
> libraries e.g. `tokio` where `AsyncRead` has minimum methods and
> `AsyncReadExt` is what users mostly interact with.
>=20
> To avoid changing all user imports, the base trait is renamed to `IoBase`
> and the newly added trait takes the existing `Io` name.
>=20
> A `size` method is added as an example of methods that users should not
> override.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D11

