Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F89349CEF
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 05:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969096; cv=none; b=T8iBUbmQeztWxCuLF1wkWldDaEI4Wc/4Rz3uQe14phSNqD8bMZ14vqOo3nSTiOKPHukyNXJ8MdMb2Q2yoR0chyk/gVuTalo63tzBqGlDh+Uc+l1uaQcR1mmZDP6dq0SPsKbZLcSVuYnUYhNE66QqrmplF29WXdmNg/w2hqvdgCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969096; c=relaxed/simple;
	bh=J/kv9R1dXHI77qHEYaeG8021mvtTD2zku5zZRfvp1X4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iiE0ABFcrYvsGjs+7VpWBcV7Ra1nK+ra61OAKgR0DoKc6vqDFrI6IBfok8OEC4dv9M1lBisXbPTSVoYa4mSvTgdnvSa9pdsnI3FNXZtXSFe+Zz6EkzWUELBhZF+9gwKAdaYsa6zmH6qdzZVteXiS2axqvAyjJ87IKLgBpM0tSSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pki7/jNs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pki7/jNs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362581F000FF;
	Mon, 21 Sep 2026 05:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969094;
	bh=J/kv9R1dXHI77qHEYaeG8021mvtTD2zku5zZRfvp1X4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pki7/jNsyBT9m6ycYnTCbzYj3Pt2CkzXzjhdVVE2DA0OkmLaRdwdLE/kVdwHE0wtY
	 CxPcmuOgLa7infc2u1NzU47RwA4cLWd9sxd2+D/tq5wRKjL4lM78cdYbNtw4cubWgY
	 6WFUrY6cgoqApXLVlHMZX0EfgZkD4OnZmjWi1tzXdsrERr0cBWONmpG31KQhBw/DY/
	 i5c9qzfoTXeULc+aEaDK8lWNZXrfVqcouDKuKePUo75SjRymKnjKSLBAT58slsnZ5s
	 eXFjtjbaWMw5wFkqmyEPhuPR7MjZzC9+mIrF/W0iUYqbh+mC9VPl4d0+PKZ5qf7dqg
	 19ShClLXug3HA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] PCI/VGA: invalidate open user references in
 vga_arbiter_del_pci_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Peng" <benquike@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260921052702.1725696-2-benquike@gmail.com>
References: <20260919222629.3798073-1-benquike@gmail.com>
 <20260921052702.1725696-1-benquike@gmail.com>
 <20260921052702.1725696-2-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:38:13 +0000
Message-Id: <20260921053814.362581F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> When a PCI VGA device is removed while /dev/vga_arbiter is open,
> vga_arbiter_del_pci_device() removes and frees the vgadev entry, but any
> open struct vga_arb_private on vga_user_list retains dangling pointers to
> the removed pdev in priv->target and priv->cards[i].pdev. Subsequent writ=
es
> to /dev/vga_arbiter or closing the file descriptor in vga_arb_release()
> dereference the removed pdev.
>=20
> Mark matching priv->target and priv->cards[i].pdev entries as
> PCI_INVALID_CARD under vga_user_lock in vga_arbiter_del_pci_device(), and
> treat PCI_INVALID_CARD like NULL in vga_arb_write() and vga_arb_release().
>=20
> Tested in QEMU against Linux 7.3.0-rc3 by opening /dev/vga_arbiter,
> selecting PCI:0000:00:02.0, hot-removing the PCI VGA device via
> /sys/bus/pci/devices/0000:00:02.0/remove, and writing "unlock io+mem".
> On the unfixed kernel, priv->target retains a dangling pointer to the
> removed pci_dev so write("unlock io+mem") proceeds past the NULL check
> and returns -EINVAL (-22); with this patch applied, priv->target is set
> to PCI_INVALID_CARD on removal and write("unlock io+mem") immediately
> returns -ENODEV (-19).
>=20
> Fixes: deb2d2ecd43d ("PCI/GPU: implement VGA arbitration on Linux")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921052702.1725=
696-1-benquike@gmail.com?part=3D2

