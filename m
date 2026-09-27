Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220972D5937
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790528637; cv=none; b=LlhTmMont/+5rXmYXgwQYn+Z56svsXrJs+/RRSwfrhICPNUMKmjkeqFZG3fFPmcz2THwXHb8g12q9P0hLsmFyLkaQGP0mWHyGpR/831+4i1EFNs6AOu+3ddfTJFfbvRAbt47p6u27rYECqQLcMcKHWsq66xxYBnuN/kPa07tRJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790528637; c=relaxed/simple;
	bh=PdmDkpfuDM8nnaA0qWE17K6XogtbwIL6gGrkjbONv9A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=km0MOGJW93keaixWKZnYaJ0PjdOAobSH5wArUquKmrTK6b34oSHxYeBTFradOWpg/GWZiUlHq0qDSI7yUCAn+FaSr7bitDKjRLaY06+Uu3c0e5ZUQ58ZL9XOLdy1ypB9Jd6CE/nDZE0MteYxdwWL0WhArO1DvF1U8uScalMcwCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlqPo/xV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlqPo/xV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759301F000FF;
	Sun, 27 Sep 2026 17:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790528635;
	bh=mh+jqrSoSSIAlOVpovpfQv/bv4y6lj3lbamfyyBGOq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DlqPo/xVy1XIdGt5C/mQhzJoJzgvjUiQRTn+FZFNUgrsrm4BeHDc0gbghtM7Chytd
	 bDJ7Ssi1qgTAeD/aqhJpG5yem2ubgwkU7wizcr2Hqr1EWXeF+E1Ye8WtaP1jp9/jZe
	 LrcoaQQHjg4alhE8YGYUqNmBpfP9tfo407ujNCFG4Ec2L3jjvzJH5SifulbiUINIMC
	 iKV4cXp/mLy6tTZl9OPR4XQ6B0Ia+89sYW3HrbmxfF5zP/RD2wulKPQ1OZIQGnmn7G
	 BTAYnyEJMCLxQwA1H1C8f9THw1I29qjB+k4usWex/+D7688PIzRQz+YB0cvmFT4vov
	 3BACMPyzv9Uug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 2/5] PCI: pciehp: Add pci_hp_wait_link_change()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhin Parekadan Jose" <abhinjoses@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260927165459.829900-3-abhinjoses@gmail.com>
References: <20260927165459.829900-1-abhinjoses@gmail.com>
 <20260927165459.829900-3-abhinjoses@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 17:03:55 +0000
Message-Id: <20260927170355.759301F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: missing acquire barrier in pci_hp_wait_link_change()
--

commit 4a9f36e746ab6c768961f1d34f724895b17c9def
Author: Abhin Parekadan Jose <abhinjoses@gmail.com>

PCI: pciehp: Add pci_hp_wait_link_change()

pci_hp_spurious_link_change() awaits the end of a code section causing
spurious link changes, such as a Secondary Bus Reset. This patch splits the
wait out into a new function pci_hp_wait_link_change() to allow hotplug
drivers to wait for the link to settle without clearing the changed state.

> diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug=
/pci_hotplug_core.c
> index fadcf98a8a660..c3e0ee8b36381 100644
> --- a/drivers/pci/hotplug/pci_hotplug_core.c
> +++ b/drivers/pci/hotplug/pci_hotplug_core.c

[ ... ]

> @@ -528,6 +528,24 @@ void pci_hp_unignore_link_change(struct pci_dev *pde=
v)
>  	wake_up_all(&pci_hp_link_change_wq);
>  }
> =20
> +/**
> + * pci_hp_wait_link_change - await end of code section causing spurious =
link changes
> + * @pdev: PCI hotplug bridge
> + *
> + * Await the end of a concurrently executing code section which is causi=
ng
> + * spurious link changes on the Secondary Bus of @pdev, if there is one.
> + *
> + * Unlike pci_hp_spurious_link_change(), leave the record that such a co=
de
> + * section has executed in place.  May be called by hotplug drivers whic=
h need
> + * the link to have settled, but not the cause of a link change, so that=
 they
> + * don't take the answer away from the caller of pci_hp_spurious_link_ch=
ange().
> + */
> +void pci_hp_wait_link_change(struct pci_dev *pdev)
> +{
> +	wait_event(pci_hp_link_change_wq,
> +		   !test_bit(PCI_LINK_CHANGING, &pdev->priv_flags));
> +}
> +

[Severity: High]
Does this wait_event() condition check need an explicit acquire barrier?

If !test_bit(PCI_LINK_CHANGING, ...) evaluates to true immediately,
wait_event() returns without executing any memory barriers.

On weakly ordered architectures like ARM64, could this allow the CPU or
compiler to reorder the caller's subsequent state reads before the test_bit=
()
load?

For instance, if thread A clears PCI_LINK_CHANGING and wakes waiters, and
thread B calls pci_hp_wait_link_change() and returns immediately without a
barrier, could thread B's subsequent PCIe config reads execute before obser=
ving
the link state change, even if inside an acquire lock like down_read_nested=
()?

Would using test_bit_acquire() or an explicit smp_mb() prevent stale reads
here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927165459.8299=
00-1-abhinjoses@gmail.com?part=3D2
