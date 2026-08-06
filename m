Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D1D2771B
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023090; cv=none; b=oHF4NlrZPE5HOq0My6Folu0HablPt9sIW7Z2Jbnt3NJ1v842/4G6tlPgGzLV0mOyxpfEHqfZcIFXixRA0sEPATXUzv7Os8brXRyveGn72CkZaUQDYbVRo8LoiUeFh03erjup7YCbZbN+I+YiJwB7JAzM4MlFyLrJGuRQ/0MXhfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023090; c=relaxed/simple;
	bh=F2bGzsTwxXraXgdiLuNA6h08iZhfdksrdlgiZdvZfJg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PE6SzC7rnJ5bagL++urHYl0JqFGieESacWoBk8LtU/e/pT+UDtVMClKr8Qnxe6C5fWh0zOjNwdqVGzK+7H/0UuRgg66GU3MBqoscnlxpPmxxtqCsK2kwxrt0vU1P5J/cQCw55S7CHZ54wQsYc6G2ruWhKJtvpjCw+wwCXegWbsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1Qx6a/t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1Qx6a/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458541F000E9;
	Thu,  6 Aug 2026 13:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786023088;
	bh=F2bGzsTwxXraXgdiLuNA6h08iZhfdksrdlgiZdvZfJg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m1Qx6a/txv4wXTrNCTkc+eftwWDpTHUN4adAuzihpKgV44ouz289P5VNPUP3w26FM
	 Fuv6emMhf3aJfVDLHP9jZD4JJkMRPLXouNEwDazC/Oq2UcFcjFDcIOwFo5bvy5bMV5
	 7OIlduRUu2WIXXDaC0B7QlZ5hKaioP79Jxhs8iMdptlZFrBi3KJPeBfnWH5Xey0N82
	 qjggImB9vVwb7Hdl6oOoD7nYDuaIs/5uowB6PwUas/wFdR29+SDFKgoNNRf2IZrZLD
	 5SwZkoowd35oL5tnS3f+Ne5VJDs2QulVpJlRBVf6CmQPoHo5u3C0wB6ESNFy9vf8mF
	 0jAjFMs96SDvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 08/14] i3c: master: Support IBI-based wakeup
 capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-i3c@lists.infradead.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260806131857.119830-9-adrian.hunter@intel.com>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-9-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:31:27 +0000
Message-Id: <20260806133128.458541F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806131857.1198=
30-1-adrian.hunter@intel.com?part=3D8

