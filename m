Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4F436D9F9;
	Sat, 27 Jun 2026 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782562794; cv=none; b=jSXYKuBXEZb/+f09VAosIhwRGCcxQB7YugL3BDIMg6cWLfdp8Wq+jKbOvL6El91qY3BR1XIyh/TVit/XZ1Ajas3di7PHcVtVnKiLHJJ2SehIzT/Pa64XXZ/Rp3glmmJtg8JCjKMYFaXAnyoZZkRF+i5Rjf1Z/IDvKX7SKPCnjwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782562794; c=relaxed/simple;
	bh=tZKH1Fmdi2MNzNqvKM+4MxxtQfZqJrKsvR/wo1OtL5I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QY/qMQWMV/9di7R0PYFIQWwTVcY8Z0wx+YhUGjVBT1vdbUZKBCyhEXNh3x8zflr/JB3lYfGm7VPXJch6oHE8SAIJiIKLtEg3GCCK17H1K0C7PSYYGQvmsEMp6K7TQzjcoweZX/uLzwQdNWal/c0sfHpeTQbhBw6JINeFPF8Ymdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glDP5sgz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glDP5sgz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6C21F000E9;
	Sat, 27 Jun 2026 12:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782562792;
	bh=tZKH1Fmdi2MNzNqvKM+4MxxtQfZqJrKsvR/wo1OtL5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=glDP5sgzrCXo/2THnlbiU5JaAqQWsXBUnoIRriqmjzUlZfMMnvTc3KF08QWTGDLWw
	 oQaBpng8k2C/rLtvw/8JPI0zAlh/kftsXt/97nhYap499FfZqueZYYxPGl8WGBOTAD
	 SdSdrYl/XD90rGmfg21CXKqNhaRardQcMnVw27hjVGG2xaK4ZI75qX6IWYYDQcLYuG
	 ryZq3vSsYiJNtg3x1yHzAtWrDJMZaurdon3h6HC5hT+BbQK+4brb7fzEy7LepTlI95
	 dRwObbHoh6oI0/mOrWHaewCFEvPXV16s/LFxCYoR9/fNSDyZ29B8P5je/ZAVwRFOGC
	 2O/IEnuT4oBYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: clock: airoha: Add additional reset
 for PCIe PERSTOUT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Marangi" <ansuelsmth@gmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260627121450.3529133-2-ansuelsmth@gmail.com>
References: <20260627121450.3529133-1-ansuelsmth@gmail.com>
 <20260627121450.3529133-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 12:19:51 +0000
Message-Id: <20260627121952.5D6C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add additional reset to control PCIe PERSTOUT reset line for each of the 3
> PCIe lines.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627121450.3529=
133-1-ansuelsmth@gmail.com?part=3D1

