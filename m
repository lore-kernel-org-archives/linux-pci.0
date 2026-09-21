Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB44C3C0A15
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000837; cv=none; b=JzurDf+yjWFHttWKOWPbgkc2i3E2dKlqpDHRc0rtxbTxNSe2vo0nubKcPx9hTzCth64nkkE5Y7dPNVfBDqMaLqoYRjA0iOkPvP3qdwhe7nXhHmJDVtr5JpB0XksBqDIWL14JjP99mYSOmpqHrG/U2WpBYxrI6ceSUhozHJcilaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000837; c=relaxed/simple;
	bh=0IFLQXzIIH87uxdttIEoDR8hXp7TDU4YXnDOWeaydtQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ADx+N47BsH05wY+9gcfW+LEIuSJNSFnThnMhPC7DzI8ROzv079C/0ZPFv1tTyPTbsYhbMHd8tcCA4WrCTIiHio+N8KryHHALn1VCHY5a5lt/zDHZbl8adoI0ls1wqI98krBYCKZ1IMG8buO6UioAvgWCGUqUs1aWrO2fiE8HWqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTkyz8mc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTkyz8mc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566E81F000FF;
	Mon, 21 Sep 2026 14:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000835;
	bh=0IFLQXzIIH87uxdttIEoDR8hXp7TDU4YXnDOWeaydtQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cTkyz8mcu3hVVhWS7sfRnKPLCw/hdHYZ/KxRpV8TWHzyroIii4Z0H0Ngu5cXEXktQ
	 zw5rKK2fjnRE4dKhfO4ScaMkrmmh//u50AGbCyQpE7F1nS5MoGtx1GMtgjoSlNT75u
	 ajfWMfdALI52tIDal/aMfAUEVUSsBkS8LxUUuoDFrIJA3WkvQyiupemuI/t+UKDVQl
	 nrK3D7msUvN/Mc4Jv07YKhgdycvjMhR9CIlkXvX4lLlsm30lU4jvyF959zcELjbMg6
	 NgUImz471lPQ1tdDLxbROxjBCAerwVpfpv21m8NblnGuUuNZmp9v6tpxS0orB6b7xk
	 Un+Z7KCUyFPQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/8] PCI: vmd: Add vmd_create_bus()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260921164316.3860312-5-szymon.durawa@linux.intel.com>
References: <20260921164316.3860312-1-szymon.durawa@linux.intel.com>
 <20260921164316.3860312-5-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 14:27:14 +0000
Message-Id: <20260921142715.566E81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move the VMD bus initialization code to a new helper vmd_create_bus().
> No functional changes.
>=20
> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921164316.3860=
312-1-szymon.durawa@linux.intel.com?part=3D4

