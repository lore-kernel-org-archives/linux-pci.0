Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE9C3FC5D3
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136227; cv=none; b=CvIsPrHK6V/K/at9R6WBM8un6svQX/7rHQrbNXtvR9q4rgrW0/NQrY93EoCDtQqEVsLbrQ3vAy+SwAHLWAxydo7Th/MrlJsOuuKkp5AZDjjrNq7Qukkc5udL37/XSYkbYH9JgGlEOr2ooN8L5pDSiqx38PKdJC2oyaLGNlElbKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136227; c=relaxed/simple;
	bh=O6ye0ySHms71bhx/VK5DxavLc+b1EsaRv6Lxc62X/WU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GivNneFElvwb96ZNDQLl1U3pzjMymaYTvFAhxW+mLWDQwb4+Oseb8Tu2dw0ZSpL2JLkyh1dGkuLHU5DkuOOfjEui7vyuBHwljLA3yVbecVDID3qgX10izC0VEAMFTPWX1eN+hHHtvGaQuvqbRMYk9j8xTqFwZk6Wu4PCdqkTMZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsAdFAnT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsAdFAnT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26A41F000E9;
	Wed, 19 Aug 2026 10:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787136225;
	bh=O6ye0ySHms71bhx/VK5DxavLc+b1EsaRv6Lxc62X/WU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TsAdFAnT6hxh0AU3FD3McPwQjBgIVjnwrj6qnpa7TBElS6P7i4EZ9408OVmQT+Z6m
	 uwl88Luo3JI9YkqJ5/gC/L4dEq22p4S4UH79DY18tD9kPSF4LNVNfIVHYllqp9rr1N
	 f/3UslPm/r/9iL/plTxbvonVXbXvRJiaJN5rva20dLiHAJ7TgkESujHMC3B58yY1hH
	 RK7m+fBQf1RiNSmsq+BGHpvvsZaOA74p0VwzVtqYOXUA0UZg5RRv/gZQPgABCwZrIP
	 rF/Sei/lHZVQXtxWbhuxnGJCllLp9sG6Kyw8vzNqK4Y9Gzug73uXOTr6tQbr+E0HOP
	 47zlcyGjEdcTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: vmd: Add VMD Device ID Support for Intel Nova
 Lake (NVL) and Dunlow (DNL)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260819130523.398493-1-szymon.durawa@linux.intel.com>
References: <20260819130523.398493-1-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:43:45 +0000
Message-Id: <20260819104345.A26A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add VMD Device ID Support for Intel NVL/DNL processors.
>=20
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Dan Williams <djbw@kernel.org>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
> Cc: Jonathan Derrick <jonathan.derrick@linux.dev>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Krzysztof Wilczy=C5=84ski" <kwilczynski@kernel.org>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819130523.3984=
93-1-szymon.durawa@linux.intel.com?part=3D1

