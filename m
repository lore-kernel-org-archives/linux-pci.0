Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAC52D12ED
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116633; cv=none; b=AmKtsnlAmywIchw482PUe2eMUpljocH27vN+QtVomhmqnkbM/sQo9cUukgijzZOoqkSWxunbcb8ZcgYxqLWQB/+sX/ElZngWKknpgMywER7MDcU2o84Rc/h8Gqi6bk2rCbTV70/vBjk0A4lCug9KyxjefCf/lzxS5kiUQ14yamU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116633; c=relaxed/simple;
	bh=MiyOrdbfG51/NVuRhXSqYAZoMEpFihXGDHVcJ9LKbqU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qgKGotbTpkObMtTF2/A2qs17Sm4D0WozjrZlpxAxXq7P44dly9vY3TK66CffyxK5XuEe2RGgezjY3flpqjO2AXLXi3k3YHsi8MjhxelSkIL72GjQXQJhUiZtlnrCbV8jjwyB/yzMZF67LvN7iwHkLmn5a/zvlZuZVpLPjFYg5VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaefTTue; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaefTTue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815A41F00A3A;
	Fri,  7 Aug 2026 15:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786116631;
	bh=MiyOrdbfG51/NVuRhXSqYAZoMEpFihXGDHVcJ9LKbqU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KaefTTuelvmlQ20RUxPpz2NOUpReb0aKL0UJyBtisA+3CquZcsak/A9ShoFg+NTif
	 PKXjwToFTURYQAC+7BOcmHRN8GpASPdNZ0+CXVvnRMt3J1vKfKzyL63V9vDqHE/JpM
	 xuDeoOndx54YOdDUzCP5vgMWhY70uuXzbz/DmQH3ga0uF89DI0c3NebO40iMagNSLN
	 c7OLZCJN6rxgdGjc0ImIdlLnYBQN5rTvZX/iIZsJ8zbfvH8nSmOcXSEVnqAkfk0PrE
	 N93wpaGyRMa2VR97pIeiDruIM8dtbdLEMdOYIRII3IhgzaFgnzCT0ZIbhJ6LlalR1G
	 ni+rhRjlCQjJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 14/14] i3c: mipi-i3c-hci: Advertise IBI wakeup
 capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: Frank.Li@kernel.org, linux-pci@vger.kernel.org, linux-i3c@lists.infradead.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260807145638.168865-15-adrian.hunter@intel.com>
References: <20260807145638.168865-1-adrian.hunter@intel.com>
 <20260807145638.168865-15-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:30:31 +0000
Message-Id: <20260807153031.815A41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Set master->ibi_wakeup during probe when the associated system device
> advertises wakeup capability, allowing the I3C core to mark IBI-capable
> I3C devices as wakeup capable.
>=20
> Tweak the comment for i3c_hci_sysdev() to mention the new usage.
>=20
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807145638.1688=
65-1-adrian.hunter@intel.com?part=3D14

