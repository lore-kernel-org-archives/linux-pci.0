Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF763909A3
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187810; cv=none; b=hkrLkKf7beUbf9g/g8chQ09M5uH64igA3AfGqAysLgp+l31qE04Wg3z5NJtmPQf/zJFnrKfYQgAeI/HvfAPgdaZ4+ruVTYoGiXZ9+mtQC6SP3gOHdOczidQ76ReQurHPB4rDdPQzQQtlwgcZVR9Jnfpx1oMDq9EXVgTtexKQYkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187810; c=relaxed/simple;
	bh=osySeEKmQA/GbtK+0VPhnkLbxZwvOxHNvt1exs5qJPU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eBdNa5JAU5lnK8ret9yYzjU1paa5RymSCCXV84u7JzyhzUJoaCeTTGb3xuazC4MWpMCYVSVXlbGyddn03E7hcYx0F4H0QoKxMPhNiixxcTJt6QsNUOKKW2XSmJ2VqAHR/xEKO9KfYFW+oFAaOnVJA/x5TVZB0HlNfqT63eOu2ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrgLEWro; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrgLEWro"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD2E1F000E9;
	Mon, 31 Aug 2026 14:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788187809;
	bh=osySeEKmQA/GbtK+0VPhnkLbxZwvOxHNvt1exs5qJPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TrgLEWrojqSBOoBvmiBYAGuPpa+5L0mjGRYjP8KYVu47vpREubI3+Rka75++oVeZK
	 w5i+iibsV8vhuPhIr3UwTTQPyNhpX49diQaPo4O/eF+8Kj3UXkFfijkaqy8Ga0ZAzq
	 gM0tLjFuLhRfDvvPHz5TPuLoZBEvxQpChB8mFrRhJLBDvaWLc5/ZKxjBPT97PPH1/+
	 2Hv7wSlx93xRqqEn7lcqMA3mUyTgNIYbFmReyYVxlkQhb/4WtbWC7hssVydyEBWpWd
	 ul60vyNmSiIlx+I3k4At5J56T5ZR/4aMF72RyA0JNy5wYLmI0Nbuxa66Ry4LVa1sxh
	 SuIufTU1e4SYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] PCI: Avoid SBR for Qualcomm
 WCN6855/WCN7850 WiFi, SDX62/SDX65 modems
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831133314.4125787-201-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-201-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 14:50:08 +0000
Message-Id: <20260831145009.0DD2E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
>=20
> [ Upstream commit 6a4f64c3a3ada43e71ef1e06da89beb36bdaeefa ]
>=20
> Some Qualcomm PCIe devices (WCN6855/WCN7850 WiFi cards, SDX62/SDX65 modem=
s)
> do not properly support Secondary Bus Reset (SBR).
>=20
> Testing confirms this is device-specific, not deployment-specific:
> MediaTek MT7925e successfully uses bus reset through the same passive
> M.2-to-PCIe adapters where Qualcomm devices fail, proving PERST# is
> properly wired through the adapters.
>=20
> Prevent use of Secondary Bus Reset for these devices.
>=20
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://lore.kernel.org/all/20260609163649.319755-4-jtornosm@redhat=
.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-201-sashal@kernel.org?part=3D1

