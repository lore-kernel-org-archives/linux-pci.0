Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B15451B19F
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 22:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931586; cv=none; b=Ev3iQrrEKpGXpeSLJV7sgKMtIMFrFYc2ygX14d7YzQSKajPo5m8QHjtcH+a9Lh/pP1wLJkVE8p1jQE1cro5rBiw/sZeAx2PS9U8YjRZjQZ1eGabv/555sq4a5ctQ8crOFDwGMLNMafG8UQkXBZdsomnt7lWfZot0rQ3iSAkmBok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931586; c=relaxed/simple;
	bh=KVvUOWGPaJf8jqd/2Kk5OJJ03RRY84zfvr1Nsb4SKCE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=g/6W8jQc0ebrM+PXOk+edPyL5FJa/cFFpdNeDC4wMdrEoyxKSMrMdn2/FG1JbMbZ3bETkNzn9CaciyCR2lD8HcJQ2mzOkCRpNfXXSn+Nr4Llv0cBQ7GhoMaRddr7ZiRAcoBuJRnggN/kNivNTVJK1cLFCpSQw4LWNg7dppaph+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVNgVzSZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVNgVzSZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13361F000FF;
	Tue, 13 Oct 2026 22:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791931583;
	bh=KVvUOWGPaJf8jqd/2Kk5OJJ03RRY84zfvr1Nsb4SKCE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RVNgVzSZRaEuNNuvAqsGQCCPTOAmetnF1WNd72CgfGGYRXWRS+1LCI0VlG+rr89sZ
	 /htG9BfB/tgiI5XUkGE5LyfM6xqDEDgamqkzP/IhPV8j5CZ3JKaIRuF/fZ/mB5zYuS
	 5kIPCkKXcVxyNKjNihZ2QC31fsTHcj3xmt1eyBjqMSLIa4vrJesSib6WJkj0Oa1dCM
	 uBnYbYyx1JuYo1EFuVxJMHpgHgjnGjEKSyYgNNENtalyDr0WGvnNYMc4OeB0vafPS8
	 w8lT94V2uUKUuzKgqze0H8kYPTadLls5XxkoDx/9sdKvTb+w9GXUUTUjaPYXOk6Qbc
	 Xi2/SAMlBhRkg==
Message-ID: <sashiko-outbox-170594@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/3] genirq: Add disable_irq_nowait()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Keith Busch" <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261013223543.395054-2-kbusch@meta.com>
References: <20261013223543.395054-1-kbusch@meta.com>
 <20261013223543.395054-2-kbusch@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:46:23 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Keith Busch <kbusch@kernel.org>
>=20
> Drivers that switch between interrupt and polled completions don't need
> to wait for the mask to reach the device; the disabled state already
> keeps their handler from running and a late interrupt is replayed on
> enable. Add an optional irq_chip irq_mask_nowait() callback, falling
> back to irq_mask(), and disable_irq_nowait() to mask through it right
> away rather than lazily.
>=20
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013223543.3950=
54-1-kbusch@meta.com?part=3D1

