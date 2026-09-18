Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7A93A0EB8
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752737; cv=none; b=jYKOKY8RhqeStebFCfAGYm+7RHx648+BjeRqmdaFHhrWUk+MQIFspoVP9BiKNlMjYRV0dx5EayQJnKZyef+SU2VIsX68gxL2AUiy7wLPWRaaZhxwXnS0+BxwGdAaqN8SsKo+dqUBdBLB4UIwzNcYz4NSq4B0dE4gsuBXn4GqFhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752737; c=relaxed/simple;
	bh=rrD441g46AUi3q8rw71xMHv+CR7t2Iki14BL5XlMSmQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ScmKUwzjR8eVC/QjJ7ww7zj195gN/iE3OBjB7QnNC2ZMhq90dA392zWiT2Bd9KSjy0UIFrwsP1ceiRFPtJuSfTIgE1SDNCLfv3gq3+lFw1r7rmxVtbH0qVobIIoZqtePbuhb8HGhJTyTs3pxBjTGtfzPOz/KhYc1Vy6oM3MqFFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnkXfeKc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnkXfeKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDF71F000FF;
	Fri, 18 Sep 2026 17:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789752724;
	bh=rrD441g46AUi3q8rw71xMHv+CR7t2Iki14BL5XlMSmQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XnkXfeKc0WnFHOdHFbPUMKKVaC+spklMjNMseCCKnoXGw0/tT+dpX2XbED0jy0rDG
	 XDw/2R/F3Le2XA2vzTd/Ds3WnqMv2OwVrSo4O7uPK0QVA567jgl9NW4nCLYpuCXR+B
	 lpshTbw+vbzx5r0svwqWud9ZOiQaPj6Lk4Ah0wcm84FlRsDkwrSOYAfy6cNVG+wvKr
	 S+GtTkuvbwYwBZmpBFt2vZu2uCigvlM1U7Qj3Fe+xC9Q2gpjFMDV0p+bIf5nPvZZSy
	 uxw1ua36l7+c8gyBYfpQGGHVit6JFtGXj3ltbZ4A9ZaXxoiqeTMz1DG3XYFkcqDxlT
	 wi1bOwIHAxlzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] PCI/AER: Fix memory leak in aer_recover_queue()
 on kfifo buffer overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260918-b4-fix-aer-memleaks-v4-1-f0a2c21ed1d1@google.com>
References: <20260918-b4-fix-aer-memleaks-v4-0-f0a2c21ed1d1@google.com>
 <20260918-b4-fix-aer-memleaks-v4-1-f0a2c21ed1d1@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 17:32:03 +0000
Message-Id: <20260918173204.1EDF71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> When ACPI APEI/GHES processes PCIe AER error records, it allocates memory
> for aer_capability_regs (aer_regs) from ghes_estatus_pool and passes it
> to aer_recover_queue() to be enqueued into aer_recover_ring.
>=20
> If kfifo_in_spinlocked() fails due to a buffer overflow,
> aer_recover_queue() logged an error message but returned without freeing
> aer_regs. Because the entry was rejected and never inserted into the
> queue, aer_recover_work_func() could never dequeue or free it, leaking
> the allocated ghes_estatus_pool memory.
>=20
> aer_recover_queue() returns void, so the caller ghes_handle_aer() cannot
> free the buffer itself: ownership is transferred to the AER code, which
> until now only released it on the success path.
>=20
> Free aer_regs via ghes_estatus_pool_region_free() when
> kfifo_in_spinlocked() fails on buffer overflow.
>=20
> Fixes: e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error stat=
us data has multiple sections")
> Cc: stable@vger.kernel.org
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-b4-fix-aer=
-memleaks-v4-0-f0a2c21ed1d1@google.com?part=3D1

