Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C56050EBFF
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676769; cv=none; b=rvkjm3xyL1g1EsLFDQ48bvvvHfL7sstsGDBQISohRFOjeGbAN6BdVwOLOuCZOFMG4nBbZT4g4DklNEbPkFXxrp/d7sDDozdhYfxnS1lxrsM1yRaDkUKxSE7sH+/U8saJbfHZYIVpegvSlZ7duW+hN3B288LwmKqyC78ohyJHhu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676769; c=relaxed/simple;
	bh=Q3NBw6Qt3BCiVm5/t3/FI1ERLCPnosh4k4flIppGRz0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nTnxz9Djo2znSRZa1FEwxxy1v+7WgRycRyORkHM3mB1FB6yhqlKux3w8We71Xf0EMnkDlLnfbndXmfL4UNkODubfVyV7sdAbKnc8Po/ym5IH4FAsqEDqLWT9UvNeFU63216CN+9xG+aRYFAdFa7OXkJCPa0/z3UJZgzHV56xmHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZ7h0Vwn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZ7h0Vwn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4291F000FF;
	Tue, 29 Sep 2026 10:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790676755;
	bh=Q3NBw6Qt3BCiVm5/t3/FI1ERLCPnosh4k4flIppGRz0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VZ7h0Vwn4sh+lMtu8CeW+cGvxw94ad6XtI4kLxXsNn7aDH4Ocfzo1cL9RxtQ4z3Jh
	 YtzmGCrX4q0jLiNKqlysr7h23n28OD78tXZ4gxbgR2jf3DDOxMILchCfLb1z8fhQEI
	 FudKD2ZciQwio2Irp914i/Us8fqxpBjKFrSCDzZhneTRT18zST5rbTteWTEF80SLQp
	 Ip+Txsu2kDxxm+2c+ku1Gmz7w/rY7Oy/sbm7IxjCG+6zRlBkecbEeFzuW0wFup5y4M
	 MQn5lhzsOp45cQ2NsFLTo/XxHTl0DVbQHvWgNvgU/zCt7fSATQJJijA1WPw8HaUCKc
	 EExxqIRLO7H4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] PCI/pwrctrl: generic: Fix leaking array from
 of_regulator_bulk_get_all()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexey Charkov" <alchark@flipper.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260929-regulator-get-all-v1-4-e887c66a47f1@flipper.net>
References: <20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net>
 <20260929-regulator-get-all-v1-4-e887c66a47f1@flipper.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 10:12:34 +0000
Message-Id: <20260929101235.1A4291F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> of_regulator_bulk_get_all() allocates the consumers array and hands it to
> the caller, who is expected to free it at an appropriate time.
> PCI pwrctrl never did, leading to a memory leak.
>=20
> Add an explicit kfree() for the consumers array.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 75996c92f4de ("PCI/pwrctrl: Add pwrctrl driver for PCI slots")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-regulator-=
get-all-v1-0-e887c66a47f1@flipper.net?part=3D4

