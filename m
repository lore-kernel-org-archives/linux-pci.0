Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7C02EEE90;
	Wed, 23 Sep 2026 01:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790128432; cv=none; b=X0GlL5c0CUzcoH6ZwX5l19QZdFYJe5/17X9spduxOz6MJuitZHTNkiiv1vWE9bBELi37VXtQZc2f7YlTl0rYc0t1NDqjiFg6QyaTL4bFJjLZASnE5gKBjw8MpDUFZmFhqIwFQVElVY1Ry22v1t49dWWWG4/0m3ohQtgJaVH4tGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790128432; c=relaxed/simple;
	bh=RSi2yN+vPjmlo49Rd0hl13und+eb58Y0qGAB1LCek3c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CmqzCISxmYG6814Iw0CKYAGQJCbsElD/fHtsGKCockUdwIWocZ/RW5/z9cdXRatSSOa3QvaL+ONWRcbOZKYWY1ZtaHy1lxdBy1lwxc2WdmqL6wOCmPGMv9twTGgGVrzjWLpxkS/h9hoqvid2UwyMj+3TRetFZvmFibRgjCerCq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3tn9hBg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3tn9hBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EE11F000FF;
	Wed, 23 Sep 2026 01:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790128431;
	bh=RSi2yN+vPjmlo49Rd0hl13und+eb58Y0qGAB1LCek3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N3tn9hBg5T3psUxE5PlhUi3xlwlYp89SsiZlr8w1N0dR/NndZxrl2E7Dvyshz6ZZP
	 jlAsgRtqRXOYoYOf9soK8ombfQGS56nlCwN1BsPCbqmGDzjajQ943gELu0hqXihs5V
	 4USywrYbLHA0oIncjbWT7CtWafJizQ4mGeErha0n7xF7gmgJFwTWPjj0IRgpCJIb6W
	 IMzuQn9fSKNDZtKmR5lZwqbrjcxdXsDtObUwoMskiBIsRmlmYqb6Xhe5kpuzjd4PH4
	 oev+nU1f4PaPAd8gwU+4qskhLf60WIhphkUn2OkM5/YJfp6X8cqI+boKPzPHW241xR
	 m8UcRmS2HovtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/6] PCI: spacemit-k1: Add device id update helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260923015016.64069-4-inochiama@gmail.com>
References: <20260923015016.64069-1-inochiama@gmail.com>
 <20260923015016.64069-4-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 01:53:50 +0000
Message-Id: <20260923015351.07EE11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Both K1 and K3 need to set vendor id and device id, add a helper function
> to simplify this.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923015016.6406=
9-1-inochiama@gmail.com?part=3D3

