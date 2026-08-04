Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB8C473C8A
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852328; cv=none; b=ZbBeO0mc5xua02jY8lvG4ZOB0SP0uq8j1GFmuPLFrSmny7MBesnzLu5diLyoTiAm77hYsY7Z8N3SJljIZLnoYGJlIRsAUevBO+R1pqseZ3Baws82MPGGcmKeXndPg2xHEocdRmyRpnzOTMibU+qbgRKa0HeLFWStxKP+9/G2jFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852328; c=relaxed/simple;
	bh=KlHimyIqNW9qpPisieURF9kCwUKpm2byBfsHhwqj0pQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I8fRa1KTFTB1TMdq++ZjvZdR6cRC8/KBH5McZjx6XYZJevAQxqAHUJV9BkyD38nBBE29ggxancj0jEgCdV6aWtXacmbQAanyn9LIyyXd+lTQDKU67Mhjs2mZPtdvpVU6i54FWLjJ+t/8sBEESjZUWeaKmj6CRMLEab5rQbh8LGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcPvO/+3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcPvO/+3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1121F000E9;
	Tue,  4 Aug 2026 14:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785852326;
	bh=KlHimyIqNW9qpPisieURF9kCwUKpm2byBfsHhwqj0pQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bcPvO/+3GC7NH2/ck+mxw/xTRnDTfU/Vcw5ze5H2qtRk8DRStl0ZcubeOAuKnjIyz
	 ITHRDUlKpKi4Eb9ubbM1otSqwVLLgPYziyBrED0GVp8ylrzdsft6ZNa8zVVzJjCTNQ
	 lWnmFS1G26mhVLqbvRRvDivC3cbxrx+4McxmQHqOKCLD/GXCIl/XZdsWqFUbxucYXW
	 och+ldl4WjjMZ4hLjQ+YpOROkWEDUOn8cVfZXm9ou60AQyeJzJrsd52xsnMgvdSnN/
	 YCZbiOdP7nlYDyz8Mfux5QpLPZUfssTyQ2vrJwC3JQ1kjdO6mCxSCsgdCzJroUGaK8
	 WgBW3xysxGXDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 08/14] i3c: master: Support IBI-based wakeup
 capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-i3c@lists.infradead.org, linux-pci@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, Frank.Li@kernel.org
In-Reply-To: <20260804133810.184905-9-adrian.hunter@intel.com>
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-9-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 14:05:25 +0000
Message-Id: <20260804140525.ED1121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> An I3C controller acts as a bus controller for one or more I3C devices.
> If the controller can wake the system in response to an In-Band
> Interrupt (IBI), then any device on that bus that is capable of
> generating IBIs can potentially be used as a wakeup source.
>=20
> Add an ibi_wakeup flag to struct i3c_master_controller so controller
> drivers can advertise support for IBI-based wakeup.
>=20
> If set, mark IBI-capable I3C devices as wakeup capable when they are
> registered, allowing wakeup management through the standard device
> wakeup framework.
>=20
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804133810.1849=
05-1-adrian.hunter@intel.com?part=3D8

