Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E912E22B5
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531797; cv=none; b=FBPZKFtLIyewwlVZJfuegNRmDo+Qusx+SnLCdb4TEc9dBLd331CdMzMqzP2wzO0HBW7QNfXy4O2cslCEoOGgAMCX+D2I+Bpy0reOjAMh0uRGgiMyE/DjJFxeOzJu3k1hif9HELsztX39CgOya+sQW3mV5pNRY6K2ooRlRRyON8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531797; c=relaxed/simple;
	bh=xdaQxB2LnHuuakDck61yuERLgyBaorju8ofymhsU+Rk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NFhAjR/eDYVTSbFhLRHs79U6BRCQRWWZ+p63HPXG+IwIQhaSUn2KVOTIxfVoeG9ltkYTRPx5SQnmiSdLszs/O/2us1M+SmIt3dGXlDYgabVI8dRXIUoHO02Kv/ssPvH4HIBNbDJUg3gDIZamuC3AubS9yTTo6OOuzahYdsncGJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIZoTLiz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIZoTLiz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883351F000FF;
	Sun, 27 Sep 2026 17:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790531795;
	bh=xdaQxB2LnHuuakDck61yuERLgyBaorju8ofymhsU+Rk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DIZoTLizAIvUHJ/8+v/+dFVHabuSne16PQAEkw9Y9E+lez5noE47ggW1ktb9bfm+v
	 ByBimKakaCp+/Iw1GIu8GxPMb0izWTqvtZfgegbNUfjnnfsyb684S0ijQt+TAt9Xgs
	 0vwXux1r/VAHL0lH/yPtRNShI6OOA4ISOrc5NHTXmUJjBB+AA/NUhcRAzKj9u9qxc7
	 TMvDCOTsU8FKJCAGDuTXt/vYU/ONHgWmUSmrkEKxwzi4cjUwAUnEpYwMeHajsGtb5F
	 hcvIxzQd6Tku/nQgQBZaZ07BjXOW48H0aUHc9U+pQ3a5cxGXdHQPDVeqVytpy17geC
	 hBuB0A4001YOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 2/5] PCI: pciehp: Add pci_hp_wait_link_change()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhin Parekadan Jose" <abhinjoses@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260927175203.928270-3-abhinjoses@gmail.com>
References: <20260927175203.928270-1-abhinjoses@gmail.com>
 <20260927175203.928270-3-abhinjoses@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 17:56:35 +0000
Message-Id: <20260927175635.883351F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_hp_spurious_link_change() awaits the end of a code section causing
> spurious link changes, such as a Secondary Bus Reset, and then tells
> whether such a section has executed, using test_and_clear_bit() on
> PCI_LINK_CHANGED. The answer is one-shot: only the first caller sees
> true.
>=20
> Split the wait out into pci_hp_wait_link_change(), which leaves
> PCI_LINK_CHANGED alone, and implement pci_hp_spurious_link_change() on
> top of it. Test PCI_LINK_CHANGING with test_bit_acquire(), so that the
> caller's subsequent accesses are ordered after the end of the code
> section even if wait_event() returns without sleeping. No functional
> change intended.
>=20
> Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927175203.9282=
70-1-abhinjoses@gmail.com?part=3D2

