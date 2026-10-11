Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB30315D49
	for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791745762; cv=none; b=i1IKDNnWLPf1F2aK0jeY+iCRFlegY3qTorzH09qjLennbNUGWp9wcPK3kxB8+YZx7sNrWMHQsODJVq46KfuBIiGiONdkHWy2yaLl7xsUQvnEBgMRREBLstI7/2G8a7yR7MS0uLPTllXRj/DSY57W/6uxgJ1wbvxHYqzVXN03Dag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791745762; c=relaxed/simple;
	bh=4oYvIfDTMDzm4v45aMUR0RmTWBwKFzWa9zblTlWDQeM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gWhm+FHL/Q8Yu1tggW6GvLHmwYjz68nn8uRl6eLe/DUV7uSW2iSbvlJNIZ/K7Izb7VBEAhCMCSJ9Yw4+kJOpEdIl0fU2r1oXrtVQtcQmlnPzS2Y4SdypUZn6eFNm7Y37sZam9woy8NQsmAK46j2PRdT9qwWEJTkbxz5ZnxnQFUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NL5sBT03; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NL5sBT03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628581F0089B;
	Sun, 11 Oct 2026 19:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791745761;
	bh=mh4d6sZcI5bfKSy4j5GLBJLMwGkXFoGLTiVCg7tu9Vg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NL5sBT03vBrSuVLtOFHfEMHKdV58SQN/S9BgDDJmWaB/qJ0g3dC5tumhcmhvz70So
	 2Rcw6vv/wpYR9a5Rvi3QdxM+sE40sUds9bGcNBWitAe6PesN6GO92abHu7wrhbLuM+
	 UdpzjWZpWHqPR2HtWvZW+IcE3K4EIzlhGoZ7vXISLMdFvGtwKtvdC9xjGS9D8yN536
	 b9RkBCD0TJMqt7GeI0Oboay4E9EZ2o9zqoxexQk0uSINa4q5YNhXMPrKAksTNGmGm5
	 fi9aWbVw6/XBE5DVbj+4zZef9VK/cG/o92E6/KBHaTxC0wrEcuqM1oQKwIz+h5qrS3
	 llwUVyWE07l8Q==
Message-ID: <sashiko-outbox-167395@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] PCI: Don't treat ~0 as ready in pci_dev_wait()
 with RRS SV
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gruhlke" <gruhlke@mailbox.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261011190145.23621-3-gruhlke@mailbox.org>
References: <20261011190145.23621-1-gruhlke@mailbox.org>
 <20261011190145.23621-3-gruhlke@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 19:09:20 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> With RRS Software Visibility, pci_dev_wait() considers a device ready as
> soon as reading the Vendor ID doesn't return the RRS value.  Devices
> aren't required to respond with RRS while they aren't ready, so the read
> may return ~0 and pci_dev_wait() stops waiting too early.  This was seen
> with Intel [8086:0a54] and Samsung [144d:a80c] NVMe SSDs.
>=20
> Also wait while the Vendor ID reads ~0.  A VF's Vendor ID always reads
> ~0, so check its Command register instead, as is done without RRS SV.
>=20
> Fixes: d591f6804e7e ("PCI: Wait for device readiness with Configuration R=
RS")
> Link: https://lore.kernel.org/r/20250611101442.387378-1-hui.wang@canonica=
l.com
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Alexander Gruhlke <gruhlke@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011190145.2362=
1-1-gruhlke@mailbox.org?part=3D2

