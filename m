Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2D53B19D6;
	Fri, 19 Jun 2026 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781888703; cv=none; b=eYF+/rt8PB1S9nyxXpQ06OMSr8kke/PLGFa19OlP8s+SgijZunT6JcRPdlhIQjD7j9aS/vdo8stX2xpTlE1e78cVmBl5w5ABlVdwExxz5Kew/AYqWuUR7Yyy3N5Xx+Sq9bY8HWYVwZ5p8nhRn5KnXkxDDqyYISKmETu4stkeV8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781888703; c=relaxed/simple;
	bh=xsNYdaSZ7DOl66yYxVx9vRbOxtf+w6s+PFyeaUD/br0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f6mfOIGy5qxsSK4qIpSfiX4pf7dQFGPqtxQVHHo4ySPRV+Z3lnRhHmeE7P1mX4YMqly5v+Zqc3cHuVhZKKEbVL3Arv2PaiQ6fvDRXpoRzcBbdxpokbHenmLhaJ49G5p/+UdNaT5+lVwTEzLGvDByJdGpNMkXKRf27SGVphJXwkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkUu1iIr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkUu1iIr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FA31F00A3A;
	Fri, 19 Jun 2026 17:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781888701;
	bh=xsNYdaSZ7DOl66yYxVx9vRbOxtf+w6s+PFyeaUD/br0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EkUu1iIreY9s6sc7gUBEwlvGBmosHp/wpg4lMzlW2sMwN/lSTkHu7YAzl5STe5x0A
	 v+/3DORnBl5jFKZy83T0uAuk3fc3fsbrJp8rhoAXL3c8GtT5FzAwQ7UwcNQNbAOS08
	 6vJ6Vum8E46rkg9qg8MZHJOb5A1FoC2b61PCrOfhszaeurzWfGRhGDYzQhbGW1kgjq
	 DpiYyGo3Sa9DXYCQdLHAVEzj6I1OI4piLF/7cB2j9lR1QPZGI/9jLO3uZLl3NF74lN
	 oYGB+XEy7G61EH5LlBzXKbK7/7ogkDBkgf277upVmIgW9+KoZzS3zLCOE8kTZdLctI
	 MAxBT+OODvBqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/10] rust: driver: simplify
 `IdArray::new_without_index`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, robh@kernel.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, conor+dt@kernel.org
In-Reply-To: <20260618-id_info-v1-2-96af1e559ef9@garyguo.net>
References: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
 <20260618-id_info-v1-2-96af1e559ef9@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 17:05:00 +0000
Message-Id: <20260619170501.67FA31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> This method can very easily construct the `IdArray` on its own without
> delegating to `Self::build`. Doing so also simplifies the phy device table
> macro because it does not need to construct tuples anymore.
>=20
> This also allows simplification of `new` and `build` which removes the
> `unsafe`.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-id_info-v1=
-0-96af1e559ef9@garyguo.net?part=3D2

