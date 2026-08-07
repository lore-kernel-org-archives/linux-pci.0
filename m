Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4534B04B7
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 02:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786069501; cv=none; b=m7ZeSVH6TRLHthGJBzXNNUUJSnEcp+DkKEXircmbXw0YgoSXKOVXt6ZeTyC/OhgaAZ62TdNrKE9wbmZ+JOKqaPTwFPeRjpKU3U7+rFr3IwdMWyqlPAFrG4Dl19mgfQnx99enqqM4THzUHn9Nvj0LqokxwNYN0o+njMhgSpRGcIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786069501; c=relaxed/simple;
	bh=oNnzBWFNJ0rQ7B8XjnqAmMVKmY2y96UFV5t/KcJMLPc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eYiyW0PNhUNgVF78qD1aEuLZ6+rHckjB2+BTdxa8uGQyDeKwgNzFCss+LppVPNkmh9bTtLouxtfTxuzdmEvxl9JSTOvG+smlbJnyY9Fo+js4XxXYW6ofoCE2lco4tq9hQNVeWi2+cLP3BFtJmmlw1iwtsHF/VjYwwlBOiOajISM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGckUYJk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGckUYJk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35251F000E9;
	Fri,  7 Aug 2026 02:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786069500;
	bh=oNnzBWFNJ0rQ7B8XjnqAmMVKmY2y96UFV5t/KcJMLPc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mGckUYJkEWr1EwZhaNGpNrLxNUjCUr1gm9B1IKAu3Xz5Sl9Hk9xXLTx0Un0rXW7Uu
	 IWrrL2voYF6fYanrhM5jf/EhGIOsJ6IkvV+0XbZU1/gN+ROBGxuh7kIIshPj27V45W
	 L8yFBMf94T8IVriIQEsiQgAogVS4qtcAc/ITRh6gnb/YSgHk1q06Kyx/B4wgQPrCtj
	 q8+5GLOc4Y/ORRTE0gQXTl1HJzKAi4xXft8gc9ugo7gzg0Q+UQhUwtMPpktjM+beDz
	 2UIbz/m6xVQtRg7RYh6ZcN176rrxMJdOkQnnFVYKkYRxDF7Rz/b4FPiLuTRuAo5vHo
	 fuYAbAFVcQaXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] PCI: Release SR-IOV device reference on init failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <dbgh9129@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260807022025.921764-1-dbgh9129@gmail.com>
References: <20260807022025.921764-1-dbgh9129@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 02:24:59 +0000
Message-Id: <20260807022459.C35251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> sriov_init() takes a reference on the sibling physical function stored in
> pci_sriov->dev before computing the maximum VF bus usage. If
> compute_max_vf_buses() fails, the failure path clears the SR-IOV state and
> frees pci_sriov without releasing that reference. Since is_physfn is
> cleared, pci_iov_release() cannot clean it up later.
>=20
> Release the reference on the failure path when pci_sriov->dev is different
> from the device being initialized, matching the cleanup in sriov_release(=
).
>=20
> Fixes: ea9a8854161d ("PCI: Set SR-IOV NumVFs to zero after enumeration")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807022025.9217=
64-1-dbgh9129@gmail.com?part=3D1

