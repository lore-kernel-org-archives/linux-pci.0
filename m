Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7065C211A14;
	Tue, 16 Jun 2026 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607341; cv=none; b=RFzs6QhK5GMQ39z3A64vpRC/dPT0Hpru76BIM/EALQQng3OV3ERb5sVvWgoWCkd6xFJKZw+qGMz7J2pIzrFVHhBiq+dn+rTmFo7JA6YgreZG5BI2oDvnxM1fLygz9nNxKXPeoEWQtSWS0kUTW8BxQuHBo7MtsFM2ofmBF+uD4m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607341; c=relaxed/simple;
	bh=8/LdhdY0+rPehZ5/dPjG5jKkSg/TiiZXZkwFFAa8A/w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JgsF12UklEsZ9LyFOe2MDfg8AYmhnm8ap3tA7ktSgNjlBLwktw8XYpovDpVvwgvjXtGC8Wih6BQQx9Esh6I7UtmPQG6DVVaCqphyf6EUQvTCfOuU7H7Ix4PdEW2rBrn7iGKtHkQSqzH2YDGKGgh0TsEnRpRPGsMJeuRzuSkcGWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5pw8L/J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5pw8L/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B451F000E9;
	Tue, 16 Jun 2026 10:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781607340;
	bh=8/LdhdY0+rPehZ5/dPjG5jKkSg/TiiZXZkwFFAa8A/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i5pw8L/J9ZtZUR1EMjBWBxLSE6/N9JjBJKAZoUgY7IpD1JSHnBJf7VeVDbPCFAnj9
	 9yWjIcOsZoa4xB3id+GyidBPQsKGoEBKouXcr/rf9wXQdjykvobOvSse7KKk+Qn7Ru
	 pyhhJzHDtuqGOOMGjBLyOoLQtl/k4JTzMJy4BcH+RIGBeGZtHeAhSSG0Ia8xXuIWkb
	 ReRvYA8ka4NmIB3wllgn4kSrzoVN5xJ3k9KkaHDei7DdvX9T4vUaTJt8J/VCKyo+z1
	 6KLrw3tvx77HB/3XYqu1PrnSMzLwMI2qrGF4QZlDBOYk/dEcK1Uzt2+HH2OVRKW8Cf
	 tehZFU3+6XXMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 10/12] vfio/pci: Add TPH_ENABLE feature skeleton and
 unsafe module parameter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260616104621.41915-11-fengchengwen@huawei.com>
References: <20260616104621.41915-11-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 10:55:39 +0000
Message-Id: <20260616105539.D8B451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Introduce module param enable_unsafe_tph to gate all TPH related features,
> and add VFIO_DEVICE_FEATURE_TPH_ENABLE uapi together with per-device
> tph_permit flag.
>=20
> This is a preparatory implementation: only feature framework is added
> for now, actual TPH_CTRL register permission control and steering tag
> features (TPH_CPU_ST / TPH_ST_CONFIG) will be attached in subsequent
> TPH capability virtualization commits.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616104621.4191=
5-1-fengchengwen@huawei.com?part=3D10

