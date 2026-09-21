Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F5F2D8DA8
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 05:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969003; cv=none; b=j9+ZDoowZPG1FVHKg3/YUc4Bj5jzzChHcwN7qop5LA447b2nR13rEMMI6BTQFsO9SEC/QBfmeWdqri7Dq3JVKBT57UAjiGR13DulYFaMBzVtirKiKlWHNS3WLFqelQEHWtnrPUlZAApLnAYfYf9bP8hmId7qyHCJ1j9A5Ky5zWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969003; c=relaxed/simple;
	bh=IUN14+i0HHSdGUdCSA+90Q+spzqOvybcdy3d1mj/SV0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iBpPphtoMOxycknsRnGVoKuqyWSTV/iYcZpm1QOSAa6/LtOM6M3UOT9eWx6DKI4GeIbHyf7YHJhnu0oyZTlgvsx62RSghU3nzQxA4txATrBjy7FH+Ah6JgOsk3iNZzMX4EhErUdnz662uW2pB/a59Y4BX1ewauDhRb6IOjt6CTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAUPy+zL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAUPy+zL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106671F00893;
	Mon, 21 Sep 2026 05:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969002;
	bh=yjN5lWE/wLzA3uTenQXL4qrTnHv0jUE3cCqLODhB5V4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nAUPy+zLrpKD1ONHaTScBEFZKkPCJpKD00kWhxkpxpO5fOLmmy+NGq2FsaxsDDH/K
	 YMMpCPH57upGQZ0AwClv589SraS5SzeGm/3QALl4DPNp1Ni3/cxKWMMfeKJZtBLeq3
	 wvs8ZUbOEa8KhCNmSUSQLH5Xcs1kO+agWt/O8Eb9PhkEvKV6cVkO/kIiBLUuOjkzSL
	 ZaM8vPvckC3Sbm7TanLzG25B3KhTKxwF0Y1FYYdiZ1uSg+pWWOyfnUVtDNMoL3BGnv
	 On51ZXZmJ9WwwiAe0+AXM2XfL3JoDdtGaXP1J+C87JxiO3y4nhjJrKLRgKnwbnOwdJ
	 wkxks+RQlmBdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI/VGA: fix inverted vga_tryget() return check
 in vga_arb_write()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Peng" <benquike@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260921052702.1725696-1-benquike@gmail.com>
References: <20260919222629.3798073-1-benquike@gmail.com>
 <20260921052702.1725696-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:36:41 +0000
Message-Id: <20260921053642.106671F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> In vga_arb_write(), the "trylock" command handler calls
> vga_tryget(pdev, io_state) and checks:
>=20
>   if (vga_tryget(pdev, io_state)) {
>       /* Update the client's locks lists... */
>=20
> However, vga_tryget() returns 0 on success and a negative errno (-EBUSY)
> when the VGA resources are already locked. Because the check tests for a
> non-zero return value, a successful vga_tryget() skips incrementing
> priv->cards[i].io_cnt / mem_cnt and skips reporting success, leaking the
> acquired VGA lock, whereas a failed vga_tryget() (-EBUSY) erroneously
> records the lock in priv->cards[i] so a subsequent "unlock" or file
> release decrements the lock count without holding the lock.
>=20
> Check if (vga_tryget(pdev, io_state) =3D=3D 0) in vga_arb_write().
>=20
> Tested in QEMU against Linux 7.3.0-rc3 by opening /dev/vga_arbiter and
> writing "trylock io+mem" followed by closing the file descriptor. On the
> unfixed kernel, write("trylock io+mem") acquires the VGA lock
> (locks=3Dio+mem(1:1)) but takes the error branch and returns -EBUSY (-16)
> without recording the lock in priv->cards[], permanently leaking the
> lock on close(); with this patch applied, write("trylock io+mem")
> succeeds (ret =3D 14) and close() cleanly releases the lock
> (locks=3Dnone(0:0)).
>=20
> Fixes: deb2d2ecd43d ("PCI/GPU: implement VGA arbitration on Linux")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921052702.1725=
696-1-benquike@gmail.com?part=3D1

