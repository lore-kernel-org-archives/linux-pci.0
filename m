Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441255;
	b=temS3aTFEMlMbVjMmfiwqOSpmh/9DVxC6w3Imsvzr9ZGrT0qocH+ttlGG8HYrHrlhdTU
	 X36zRnwIwVWD0hdtxvEHJGWtX6mwkEg2UfR42b3/Os9YY3i+8K+pbj0owfLT0qoiJj7tK
	 FJazQLFgCEKVHXlkzBrB3K1QHwRr6aTWwkXhAf5Vr10mF4/Umqz9PFkr7BVpz8xBDAvPC
	 5xsN1GU69FZKumDP3QwrkFpGbH+QwKhqPP71OaYZ0WUE8m3dcUddnN1dLcm54fSML5fok
	 tteWuXqLucrHFIDMQKKfcNc0iub/P1pBVSQxVRfEw+ZE+rwM6K88BfwWmo+MWfnruwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441255;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iBPhDR6Y8Be8mPDXD9AgIHQvai37xavofSMRlHS4JnM=;
	b=GVdpL0f23Toc1BS/T8tIrzmHwttaMb5+xxZy+qyLe6iy7q3Cs6GWUgovzScEByPFuBzN
	 QlDIErdyDUMo3sNa5coLJwAMm9scLpzyulMq08BajZvaDYbRIUpD6Slbj2+tDjxjASAb2
	 RFNKl/i76SdhM5cP9HMh4QlIwe64RO+TXgUL5q1aN50q7fVVamxs+44NiQWVJogOS4msO
	 CEZ0enG8Y5Hgo6ws6scqvT8+nGvubJwt8GqtS09LSgw7SKCAJwkfVgoQU1k6rSeGPVDU2
	 W+9RczpZRwzEZZlTD08oF+iFGqiGRnKCzlfZigP3AlTy8KLOn2Mw+9ZI+CWSyy8MrBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NC5wduFv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86CC606A31C
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 23:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NC5wduFv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388551F00A08;
	Wed, 11 Nov 2026 23:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794441255;
	bh=iBPhDR6Y8Be8mPDXD9AgIHQvai37xavofSMRlHS4JnM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=NC5wduFv9PEkhaV2mmSqWpqL7aJ/nDbzH4VIhF/aMG1TQl8CR/tuoCgOvKvzslu2y
	 g/6+xCpeVin0C/srUsBSJHs0UrE+FI8eZ6iK0Q1JP+OO3XwkHUC18qiXL2LUD6ASWk
	 YvCHeMhCO9DWralZ6V+vR0ewb2qG2Gfk6G93mroldayzwOB+TVlhsQ9S0SZlpXQPUF
	 7TkVdqWbA1x3irYHkirZLN+S94DKxIYa1A3QiCPiIIHHOyPALq4PQfFVUeFnSW5smu
	 hPhQ+1VFqMWC6iwL8mDH2lu8QOUFz5HUHfEeWTRtWfWH0BoiXtS0EEWc0EOU5R+qxB
	 qAJJaSA4Y2X8A==
Message-ID: <sashiko-outbox-209866@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/11] rust: pci: add vtable attribute to pci::Driver
 trait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Song" <xinmengs@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261111223337.508989-3-xinmengs@nvidia.com>
References: <20261111223337.508989-1-xinmengs@nvidia.com>
 <20261111223337.508989-3-xinmengs@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 23:54:14 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Peter Colberg <peter@colberg.org>
>=20
> Add the #[vtable] attribute to pci::Driver and its implementations to
> support the optional sriov_enable() and sriov_disable() callbacks
> introduced later in this series.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Peter Colberg <peter@colberg.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111223337.5089=
89-1-xinmengs@nvidia.com?part=3D2

