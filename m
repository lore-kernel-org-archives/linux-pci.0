Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6ED2E5B21
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 07:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785309977; cv=none; b=qLfwxHcPX986+oL3IyVgobPpjNlmWOTFT7OzoAg0z9w9dSnwgUjvl4fGEugZA9F78uwYskmUo3jw6zfq7VfMOVoKERMENeekkLqktiGe9Puc7B1ExdLPbQP7SqecgMhcHzGsTUgLfz6DshRAO6utOD5z9BzTPhW74AnBP6gnQVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785309977; c=relaxed/simple;
	bh=KDhjtNHobK3tPJooj8SwDgxxNwRkNAiSVOlLxVnVNXU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ch77bkGN5ArHC/QBmgL0TiKCoCphBF8T/XaWNIUOluigSjA/oXi4aisNji3pN9pJIK3oBArlays/D182B+uMXAOGASKAelQcRYKd3GQLxKRF0x1B5v9nLHvbem7i0XAvx79kGGqsM2s6XNSWLs2+/RHkrvkBycRNEl61vVOUmBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7JUokVE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7JUokVE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BF01F000E9;
	Wed, 29 Jul 2026 07:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785309967;
	bh=KDhjtNHobK3tPJooj8SwDgxxNwRkNAiSVOlLxVnVNXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K7JUokVEnIPycya98fPI8VvP1YcUeYJnOoDxUVsw6xR3k9Kt+Dr1NzuTfnlx4YURW
	 Xk5Z5r3KY3KdMFZCV5/sA+Uifi7OxYGhh/rAoF3P+UikYy81u/fz+fOiwrcsmDfyOg
	 4isfB0UzCKfPC3pNeyrfAY/15mJVubcEdZL5ye2ygzgiFtIhOnwvU598LSm0FThtU/
	 ME/64y4n14AtYmkcIcqYXEUljRc59rR7fW2meij6m4dQubx4PxNYlQqhmQ9SDk8WaN
	 YL7RfEExh2jDbPh2rNPNQUp6GMPSNkWP0QrO3mHabYpkfoy8aGq32Toxb1FIqnSq2J
	 LNBwpI0qkWykA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Allow D3 for native Hotplug capable Root Ports on
 DT platforms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260729071514.859778-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260729071514.859778-1-manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 07:26:06 +0000
Message-Id: <20260729072606.D4BF01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Commit eb3b5bf1a88d ("PCI: Whitelist native hotplug ports for runtime D3"=
),
> prevented native Hotplug capable Root Ports from entering D3 citing issues
> on old Intel SkyLake Xeon-SP platform.
>=20
> But there is no reason to restrict D3 for native Hotplug capable Root
> Ports on DT platforms. We recently enabled D3 on non-Hotplug capable
> Root Ports on non-x86 platforms (specifically for DT platforms) in commit
> a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all non-x86"). So
> do the same for native Hotplug capable Root Ports as well.
>=20
> To honor the above platform_pci_bridge_d3() check, allow passing this che=
ck
> only for DT platforms, unlike a5fb3ff63287, which used !CONFIG_X86 check.
>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729071514.8597=
78-1-manivannan.sadhasivam@oss.qualcomm.com?part=3D1

