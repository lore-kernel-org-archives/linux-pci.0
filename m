Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E762C3757
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 01:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790212203; cv=none; b=l+ehdPYXq1YXF7mOxrDT3qizN34yFe7G4Z8mhsThHB2oJJl0b4jHZzrliIhdBczQflki0125CnTflMSkSTgz4ac9EgXId8zI2bxUp1tpTWZ+onNMeIDlCLf0MtAm2eXvn8BaKRxXZZF+M8Hu/BKEt7VcCwh0VuQepXIuKik/O/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790212203; c=relaxed/simple;
	bh=fEMda7rMaDsGEC+FQrxlufVYxS9VzClV95VZGqjE2G0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CBWJWXMG1LrPaGGmZRuz8rtkXBoIW5CQz+Efb/TFmu7edGgCkpAmX4UjFxmqYJ7pPWLT+GaxCucYgGMAhv0zPmYdrAodI5C5LZkxcl8aeDWi7gRlKDJMbjIQmwm7s/SALkBA+IZJoFA+aMPmINhhn3eNm0Nd3dC23vqISsN9dLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ttk63GtP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ttk63GtP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35561F000FF;
	Thu, 24 Sep 2026 01:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790212202;
	bh=fEMda7rMaDsGEC+FQrxlufVYxS9VzClV95VZGqjE2G0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ttk63GtP1Ud9sPuFWfQExDawacN7oV9QOuxnOFx9tHYfStnKfLDzYifCq6rcfRYEZ
	 o/fIZ70zKxdBT/fUXW5JZU0q9kq8sEGT3llEQUcNxQmakFE7Kmuf9hIEHrJyCrLTX9
	 6Hh9IcbFJovRAR1ehMf1BomJcbORg5SM06IMVk1HCjpJAZKVgITCQ7kRYd0tnBNJvH
	 DHs1MaVRQrUwFTICTapWUxwbyoq32kJL3SW5fzPHIOkxSEj2Q5qvW2O9iKBJPtFrZC
	 C8pYFl4O2hHoFcohzjWjnY3eXzX/B6UZxkWoNUW0bAs1ScD9dCXyLGql7dxi4YqEJy
	 clvVSUCV4cTCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: rcar: Release temporary device tree node
 reference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260924010418.726980-1-oss.patchbox@gmail.com>
References: <20260924010418.726980-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 01:10:01 +0000
Message-Id: <20260924011001.D35561F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> of_find_matching_node() returns a referenced node even when it is used
> only as a boolean test. Drop the reference right after the match check.
>=20
> Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort ho=
ok")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924010418.7269=
80-1-oss.patchbox@gmail.com?part=3D1

