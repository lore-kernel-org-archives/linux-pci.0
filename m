Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5329C331ED5
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909574; cv=none; b=c0Bx6VgSD7pACb6pq9GfwGjg7VP1bMYqnqex5hnxUKuC/0cq+bTfFUIdKDkiD4OE6OArFPq0A5P7oE0qaJxNo2yFFq44uO0vOjEmKmyAjPTGa0hzajNBDVmRVkwYUh3/gIbMHBTpRwwFWnp7eViAZRVxvygU/UQlNQP+xOxRvz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909574; c=relaxed/simple;
	bh=IbLEQ3pTQO6olIagvDX2O1ozuvmpIEpfw1ufO1P7meY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AtgxXlCkXh1ZSOSLEq1q8sR2TZEzHLPcWNxUDXZp9KXGxQWwpJ93dpSoBnaNfnttUZ205RVucvTCJ/m41CLaxIbaINNh2CpqMihkdsikZ1JOToDbKypETHlumbUbCaL5oDKGb4pvkZDh4gqvm3TPsgyDpNLVE/YbsCUzjPsZWYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyqwES2N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyqwES2N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36461F000E9;
	Fri, 24 Jul 2026 16:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784909569;
	bh=88ovy2m3ATYYiYwO9EW7Q8p5Aij2fS9EX2wN4mSblkc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CyqwES2N6924eAfNbfQ8xbh0MvrthNajYgUM4iamW93Ic6D5VJGry3sgSy8P9rCI0
	 uRi7z8SKmlGHifTOHmLdnGD8I9QDJ/Ts0HPlvR/rT2Dr6XmOebpme5EVbKZ56pVjjQ
	 +6I46yGsiP5Rf6YUXNyoI4ldQxRo2V2qBpc1Mea7EQtkCR0MQdN0vEIcWdVodxvKtN
	 KptKMJvHcurR1LB75BxRGarDbx7sYC/H1co2gvWYqyUBdq+NZ1vRN6NladxX/8c0u4
	 ZbjOE1jgeARsYiTQXQxFY5PawFQayzVxfTQdRFinnL5QAGVon7qCbUF2+KzpzH+VKY
	 EAOHkNDI3BkXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] PCI/AER: Fix mapping of errors to agent & layer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <aec4820a75e949b332585a08cb1808fda7f40ea4.1784905909.git.lukas@wunner.de>
References: <cover.1784905909.git.lukas@wunner.de>
 <aec4820a75e949b332585a08cb1808fda7f40ea4.1784905909.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 16:12:48 +0000
Message-Id: <20260724161248.D36461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> PCIe r7.0 sec 6.2.7 documents the agent and layer of each Correctable and
> Uncorrectable Error.  Based on this spec section, the AER driver maps
> detected errors to an agent and layer using a set of macros and logs them.
>=20
> Most errors listed in sec 6.2.7 map to the "Receiver" agent and
> "Transaction Layer", so the macros use these as defaults unless an error
> maps to something else.
>=20
> However the macros have not been amended since their introduction in 2006
> with commit 6c2b374d7485 ("PCI-Express AER implemetation: AER core and
> aerdriver").  They are still based on PCIe r1.0 sec 7.2.5 (renumbered to
> 6.2.7 in PCIe r1.1 and newer).
>=20
> Amend the macros to map errors introduced since then to the appropriate
> agent and layer.
> [ ... ]
> also a layout erratum in the REPLAY_NUM Rollover row wherein columns are
> shifted to the left, but that's already corrected in the PCIe r7.1 draft
> as of 2026-04-07.)
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784905909.gi=
t.lukas@wunner.de?part=3D1

