Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8D4EA393
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791972817; cv=none; b=bj6j+kw95wUvPyLqo6tETshPivu+kFaEEoXUkkUy44N45XFGsGr+hk/TjygNG2kUn3T8eKek4BkoTCJJ+FF54u7pUYcp3piqoairdsYl2M4TQmJGCyd8xI48l66vPzOf0L43AmuDbAvHFJaeSvriaXShqM46Op8oeZE5P9XXHmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791972817; c=relaxed/simple;
	bh=LYGu52lLTLoXv57TuoQAGVJtHi7ElIVyHfJQgn7ZeSw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ilkGlGcVlQX37gzjvjOIANp48Ezb9ynEnGq3cpkVm7n85eyaqMszgctyju6IqK9KkhsGL2+OfMcUWFgN2Mx+P/zKA2sT7ahXKEmX6FHbILEuFv0xUbgVYpIIFKWYGSCS6nJRx3WSqf732LBVwXBnuUQTCeQXt15sA+NrCie18GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fk/xi1nQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fk/xi1nQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFB61F00893;
	Wed, 14 Oct 2026 10:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791972815;
	bh=LYGu52lLTLoXv57TuoQAGVJtHi7ElIVyHfJQgn7ZeSw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fk/xi1nQJqCuPc/0WAJOSvUCxnhebHgM4Qc5tXETgsizqrLsXmSkQ2CVx8zz2+UVD
	 ZWztYeuaUSV0pOCdTTFjDOQN2ZnyRAzqRGbpE2qOnCPSgakrVHmFn7e4h/jbhz8oe7
	 7SyHMjPhenmmfaSnHwycQnMoGrgpynWFiYjyWHhtlvPntctbO8gP7nFG6lhHrqHm+3
	 MGASuFk58ef2eVjXb/Z/Kksvky8iqYD9FKxmz7xuFvgTbzaUj+vJqkdywBCXFzmdUt
	 6dN3KQrEh4WEHM6mjQOIU3qqaxC+st1a0KQrWjVfOZ2Scqns0G6MOpdPFrulAH9eY6
	 GraGyLtkwlb3g==
Message-ID: <sashiko-outbox-171125@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: altera: Convert root port IRQ to a requested
 handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahesh Vaidya" <mahesh.vaidya@altera.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261014100723.1643089-1-mahesh.vaidya@altera.com>
References: <20261014100723.1643089-1-mahesh.vaidya@altera.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 10:13:35 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> altera_pcie_irq_teardown() removes the chained handler before removing
> the INTx domain. Removing the handler prevents new invocations, but does
> not wait for one already running on another CPU. Such a handler can
> therefore access pcie or pcie->irq_domain after they have been freed.
>=20
> Chained handlers bypass handle_irq_event(), so synchronize_irq() cannot
> rely on IRQD_IRQ_INPROGRESS and may return without waiting if the parent
> irqchip does not report IRQCHIP_STATE_ACTIVE.
>=20
> Convert the chained handler to a requested hard IRQ. Request it only
> after creating the INTx domain and call free_irq() before removing the
> domain. free_irq() then synchronizes against any in-flight handler.
>=20
> Use IRQF_NO_THREAD because generic_handle_domain_irq() requires hardirq
> context. Use IRQF_NO_SUSPEND to preserve the suspend behavior of the
> previous chained cascade. Request and free the IRQ explicitly because
> automatic devres cleanup happens after remove() returns.
>=20
> Fixes: ec15c4d0d5d2 ("PCI: altera: Allow building as module")
> Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://lore.kernel.org/linux-pci/20260430204330.3121003-3-mahesh.v=
aidya@altera.com/
> Suggested-by: Dinh Nguyen <dinguyen@kernel.org>
> Assisted-by: ChatGPT:GPT-5
> Signed-off-by: Mahesh Vaidya <mahesh.vaidya@altera.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014100723.1643=
089-1-mahesh.vaidya@altera.com?part=3D1

