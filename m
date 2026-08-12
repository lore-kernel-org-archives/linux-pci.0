Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5212C390CA9
	for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 19:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564529; cv=none; b=QA8KX11zjjJPpQjHfR/7owkzXv2a56eJkFNUz+TIz9NzjgK5NXSPwqF5dAAH2cicwsIHOq51nODn5IdzAvxspl9aJSnXVPByS9D5StwETsoyegwy4HOhxCTqJgNvt+bRTBujwBk0EhDIJjXpIpuo0ghaqYgGcrj0E+CqDtZ8X/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564529; c=relaxed/simple;
	bh=uR44IOaNYfw9AXNQqj5LYSku+h2vjnQWD6f4s1xbjMo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jCnqmZtPxsRYzibfdVWx/inAk3UEK0Uxuk8GpAlF9jBi4yq69vnlO4MhhmAIRwObhx7ftJxwl4ueBvh+XWvy6mr6GFTKRNwOz5YBcKjCrYFtC6p89p/i9cGQ8Na9SB1iStY7qaTumjig7AONhRt2cf3Tpar9b0gF1Sl2yDY7rAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5Jd0Yh7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5Jd0Yh7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025191F000E9;
	Wed, 12 Aug 2026 19:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786564527;
	bh=uR44IOaNYfw9AXNQqj5LYSku+h2vjnQWD6f4s1xbjMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W5Jd0Yh7DrjLgz+oRmNlXMUGX3YyIWFw8xhj2zjJUh5c7ogt7qfhwLPesH7O1jvcF
	 qoNigI6U7faMC7Av7tbqIPm98aj2pmjiOLwVtCOptOHqAF4FpnKTR9lxOVvQeDE7ps
	 2tp3u5iUC1dQROjY6YZkzTnWcV0mTC+cRHjGC1PZUtgmq8QAa4clBkSdfNihRbbASq
	 Fu7WgyyVZxPaDD4YQwy0hVg1D/1DapYyntAq2vFsFEDstu/eS58ED4YwYrks6nXP+M
	 XHQwt7ODyrgW3NKdo0Lt1watrQGwAC+JtTCRg5DZZ0YM1LQlWh7X6rVLlS6BqG+tBT
	 D3q6TSgqySZJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] samples: rust: remove the rust_driver_pci sample
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, ojeda@kernel.org
In-Reply-To: <20260812-b4-rust-pci-edu-driver-v3-1-5d0b5594e52b@mailbox.org>
References: <20260812-b4-rust-pci-edu-driver-v3-0-5d0b5594e52b@mailbox.org>
 <20260812-b4-rust-pci-edu-driver-v3-1-5d0b5594e52b@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 19:55:26 +0000
Message-Id: <20260812195527.025191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The EDU sample added later in this series covers everything
> rust_driver_pci demonstrates (device matching, BAR mapping, MMIO) and
> exercises interrupts and DMA on top, against a device every QEMU ships.
> Remove the old sample in favor of it, as requested by Danilo during
> review of the EDU series.
>=20
> Link: https://lore.kernel.org/rust-for-linux/DJEQ64V8HE19.2DMBHY4XRPMG6@k=
ernel.org
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-b4-rust-pc=
i-edu-driver-v3-0-5d0b5594e52b@mailbox.org?part=3D1

