Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66B81CAA6C
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 19:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781811271; cv=none; b=qXXaPncsAhkUCR9v3z6L4xNqL5NfQ9TIcLwjTr4B2p4t8HAYnsmdEfri5Xb9YuWjdJD4KDtOYHdPXzVoJdfmEk9bV2vzDZjX7YP3rrf8sNtsAs5WND0atq3YnRH4TVxHebzf6T0cStnIsSy6NFZMOiV+r4tfjsaC4uFcsX3LuPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781811271; c=relaxed/simple;
	bh=VkQvQujsCUt0kYTdL9G7/wN4i7cQ/6NN33sfCyoUw0I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l79eL5hn+Orjhi9gXoajpyfjIMp2vcljXnR0gv5LNY0E/eQgQpW/srE73EuwKxSAEFoHPUcW4oa5lZN1IvThK9IYmxV8FqYIGiDbcX523DQYkNb+KeSUmOxWNNxtEk4+TZDj+V++j0SuC0BB9n6JGwPY9Zx1YEXE+KfFHDueHVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfOf35Xl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfOf35Xl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6A51F000E9;
	Thu, 18 Jun 2026 19:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781811270;
	bh=VkQvQujsCUt0kYTdL9G7/wN4i7cQ/6NN33sfCyoUw0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hfOf35XlLFvdXC6M7+AyxmU2/E+I4A8EbPwIc/BUnq6I5HQ/dn9Apw9PTDA+LNN3I
	 oQy7ZCCjwN5TzrkLQJw5CvIoURKowCgiHk3CUvtEwAJQ37Cpx4Ze2dVU+f0rl6NWNJ
	 lfvcl3hfbL24w+mBwfkIlHGPhqrCztIgcjnUVt2/DhlWn0qeykD5GUR1z68sussQdl
	 BqfVq43Pp8i2Bp1KHAwColVkJtau9yxELkYtpHWZP/xsVZgcGn70PPGbr3mFQ3ovn6
	 zQPX6dV4rqfNLxIBgb2u6hvbU+4rGe2CjeeoFamQNaXiBJ8bjsPodwCEWEW0rS2UBF
	 w1ULUo8B8yJBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Add ACS quirk for Pericom PI7C9X2G304 switches
 [12d8:b304]
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans de Goede" <johannes.goede@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260618193030.69528-1-johannes.goede@oss.qualcomm.com>
References: <20260618193030.69528-1-johannes.goede@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 19:34:29 +0000
Message-Id: <20260618193429.DD6A51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> According to the existing quirk the Pericom E5 errata for ACS P2P applies
> to PI7C9X2G404, PI7C9X2G304 and PI7C9X2G303 models.
>=20
> The Arduino Ventuno Q board has a PI7C9X2G304 switch (verified from chip
> markings) with a product-id of 0xb304. Add 12d8:b304 to the existing
> list of quirks for this erratum.
>=20
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618193030.6952=
8-1-johannes.goede@oss.qualcomm.com?part=3D1

