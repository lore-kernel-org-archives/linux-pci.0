Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C3736F8F7
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617601; cv=none; b=qsUhhJBG44CyZhjB9vC1IETINlsC05PVv9Nde14t5q5rxGQyWDOO4tu7EdBZZTQyibakX4tiO0+jeN/Md0Y4NECK6CFMR390rr6RkR6hgtSq1IKOhIwk725qpi/yOdjjOqgxnQQzyLrAcl0P9p9WExzS8G7L95fgJt4ppblU78E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617601; c=relaxed/simple;
	bh=qC+KWLbnnBqjUjEdVHrJ5RgaQSBLVXo8La3RikNZ1dg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FCPeOP1q8svZJHvscKu7fBPs3+xFE5zbQ3+hy/AU4aqb24SDvQQNzycE3BAIzFyxAH0sINSziAq1lZ3OGokjzi9lBN20aZufafSFB7N1tBD209fDxGWuNSQ0zbyqzQ1JKrFU4FvwgaW+uFkfFc/kYb0yzsePq0LdEHHbdIY2074=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgQE8c/r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgQE8c/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E9A1F000FF;
	Mon, 28 Sep 2026 17:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790617600;
	bh=qC+KWLbnnBqjUjEdVHrJ5RgaQSBLVXo8La3RikNZ1dg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mgQE8c/ravUr/fetk46+4JM+Of9FKjSuQlEp8Jn3Mfw3TgwCWnfs3pL+6chbyaBdm
	 VTdWc7W9yv2zUottvXmXEHp7dtOs0FIVw+xJgfsWYClqgvCd0QKgcsjl6u7KWdFgKJ
	 gk5FdPG1Zif6GVWbdwkP616CymWueAcrMaMletZAMpqhXB7hMXhW2bE82Rmm0xZcLw
	 wh6Zlcg8S4OO4ugG0Yidw4R+RZz0G3FJU2Xh25N1bRRDL6pDAuD3S+3/as5DI23seg
	 cW556+/6Kk9mBdrJZZmmimyuDQ4a8DexZy8tHm+3f1UyUT+NBBppmgP87ZDxi+uVgb
	 KHFgnZkRD0u2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] PCI/AER: Fix memory leak in aer_recover_queue()
 on kfifo buffer overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260928-b4-fix-aer-memleaks-v5-1-ba6b94c9c9a6@google.com>
References: <20260928-b4-fix-aer-memleaks-v5-0-ba6b94c9c9a6@google.com>
 <20260928-b4-fix-aer-memleaks-v5-1-ba6b94c9c9a6@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:46:39 +0000
Message-Id: <20260928174640.39E9A1F000FF@smtp.kernel.org>
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
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux=
.intel.com>
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-b4-fix-aer=
-memleaks-v5-0-ba6b94c9c9a6@google.com?part=3D1

