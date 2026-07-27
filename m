Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19303373BE6
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785139494; cv=none; b=fXM7LH8/XlYXcXll+y3YI64M29xDShB4OJnWVbJc8WUqvTxbWkIbFWcdxSXUwjt61mESaPo1cdO4tNeIVLN3UiEOF3JKA0/uJgJTT9lmXymis1R/0BNrDGkAYjOhKC6RjKf7BEYIr356cn+oO3VegFVBBccZWAWGNgKGtZmeOtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785139494; c=relaxed/simple;
	bh=ZaSFnvnkae8lfOV5F9Yc4Wqti5K0KgqiPQypxUygWFk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RKCHH10QpsS3ysRUenO5QhKIEChzHxoqRyhCycGTsjBrgLItFj0tEUlhIl/32OByteiE+J3vbZickrgPQEMJhNlBhls2Np83O/KghS0R7LzT13IiVCYM0nZkYNzlYNd+fWIFfvb8pZLqCpqQDjrl01uRsStWCJKlY3sV1ljgYT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baPudbWC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baPudbWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF8E1F000E9;
	Mon, 27 Jul 2026 08:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785139493;
	bh=ZaSFnvnkae8lfOV5F9Yc4Wqti5K0KgqiPQypxUygWFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=baPudbWCZDX+FgcB3lwzIrtHRnsrGyzJ+cZXe9yRw65yRXpf2cwFvt3ueOrUWomnl
	 LFDdlFk6P+T1SXcG4tiXJdlKrI97w5EvcG6ckhCxED/vZFfBT8n84g5IMSon5uuOMi
	 VvTE8la+9MqnofoQaz+cxuLwp8pi9urY/89HH9p/wgUfkevT1HMkMFWXLIC8vpHDmR
	 JLwqb5DVcHG8D9lK3mDAkAm3qvU9sZPO4kynGU1+Isd8sKX/ovNltdmSDMn/l6nAcK
	 bkWV+EYMgTzHWNyIz6LU4OWlp+Im8NcY3LJs8fiuw4aBhra4RF6T6IIKUSb0LRJxjc
	 gYVea86Umt+RQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Fix unmasked value in pci_generic_config_write32()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamad Raizudeen" <raizudeen.kerneldev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260727075852.4688-1-raizudeen.kerneldev@gmail.com>
References: <20260727075852.4688-1-raizudeen.kerneldev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 08:04:52 +0000
Message-Id: <20260727080452.CEF8E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> When writing less than 4 bytes, pci_generic_config_write32() uses a
> read-modify-write sequence to protect adjacent bytes. The code comment
> states the goal is to "merge in the <size> bits we intend to write".
>=20
> However the code does not mask the incoming 'val' before shifting it.
> Since the function 'pci_generic_config_write32()' accepts a 'u32', a
> caller could pass a value with extra bits set outside the intended write
> size, those extra bits will shift into the adjacent bytes and corrupt the=
m.
>=20
> Fix this my masking 'val' before the shift so only the target bytes are
> written. This makes the code do what the comment says and matches the
> read function, pci_generic_config_read32().
>=20
> Fixes: 1f94a94f67e10 ("PCI: Add generic config accessors")
> Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727075852.4688=
-1-raizudeen.kerneldev@gmail.com?part=3D1

