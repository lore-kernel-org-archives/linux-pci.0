Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDB540F742
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277586; cv=none; b=OEbOZRK6KEI6qlJWCIkZkH2/6UuK4bxIpX0BAVso+/brbylqEnfZCDNJXRH18dtn2xZKeh3vDaxW84YhSsRgzPK25eGk+9Pah6oz1grGnAT2Ca0INecs14FGtL50Xmog8hO9PgPFpPkL4VPtzs1i+9jOGpieKji70tN9JoD1x5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277586; c=relaxed/simple;
	bh=V54nqQH76Qs17BbwTC5ivYpTOKvOCd0ANYBE9sND2Xg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BoFkPLixP6jAAvc2h1Df9S013WPuBJfZcgF5/WWqoyheDee11zxMfi2xpCgyxzpSJKXvi8n+tdodSfVxZ00wbSQGmLuWnTYhRstromwg8LTaGJyyTNFKPMqqftGi8Ua/vwBcNbtukjmFQLNh4DwuMWuTHxf6LEAiNnlpxKpCm54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mN4Y9auX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mN4Y9auX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F78B1F00893;
	Thu, 24 Sep 2026 19:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790277582;
	bh=V54nqQH76Qs17BbwTC5ivYpTOKvOCd0ANYBE9sND2Xg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mN4Y9auXBdPOX0IymCx2xZ4RmXH1wwBM9MHu2LAq/eq9IdrJFKyYYHjvDr0futgHh
	 sStylSS8Ias2yUij+nclQCaO9nUkaLTLZnN2ofXjmIkIGCKHp8AXnBOUmZ0BQUC0zc
	 5nlkF50A8pJWO+mgYqXsmbFHy1RP8APOtQZSAL3SVkO1FdwGYqBU9C9LJ/YMqtGTik
	 y9CwrsfmVZeCk2+OdO4nSek7RMwC6crbWDu/JrLcMXoh8wZNGsnGkqNP6MQ6fpYjNT
	 TP7LhVvKcczpezQtneTwCEnKwLvD14wnWGVS+NHzdYwG+CYsJwK4+qfiQV6q8RT2fw
	 O+OQ7ZnH4u+1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/8] rust: pci: add bus callback sriov_configure(),
 to control SR-IOV from sysfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org, gary@garyguo.net
In-Reply-To: <20260924190556.1620886-7-zhiw@nvidia.com>
References: <20260924190556.1620886-1-zhiw@nvidia.com>
 <20260924190556.1620886-7-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 19:19:41 +0000
Message-Id: <20260924191942.1F78B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Peter Colberg <pcolberg@redhat.com>
>=20
> Add an optional bus callback sriov_configure() to pci::Driver trait,
> using the vtable attribute to query if the driver implements the
> callback. The callback is invoked when a user-space application
> writes the number of VFs to the sysfs file `sriov_numvfs` to
> enable SR-IOV, or zero to disable SR-IOV for a PCI device.
>=20
> Invoke the callback with zero before PF unbind so drivers can release
> their SR-IOV resources, including runtime-PM references. Disable any
> remaining VFs before releasing the PF driver data.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Peter Colberg <pcolberg@redhat.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924190556.1620=
886-1-zhiw@nvidia.com?part=3D6

