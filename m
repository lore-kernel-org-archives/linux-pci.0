Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F935318ED2;
	Sat,  5 Sep 2026 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788611822; cv=none; b=XQO4++agJs27cbhckXD1RZU0Hk6O+aiVTiFW16geVJx1p7E4nrM7WuQdiXNA/QwhH04Q+mqsFYiGg3nynN+kMeYFxWGhzbIR48Ha8eEFCmJarM+6PX+DGCZE/bzddOh9dtc6BY6hY1qziwLCpXrdwrx94lsiPiIa3XPY66oL4XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788611822; c=relaxed/simple;
	bh=p/9VBIuR+uVbCar2Jaj6F7dzPXJ9Jwsg9JwwpBiLWwg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rM4uuipWTXb9rf1HCxR0R/JizbcBuZflQU6P3MoZdoYdiQXlaDeo5T0t51+6dFiiG/KJLt977j5MT9IAwNVu3vmM6nKTEddfj7KQoZ2uOQ32dAwNBt/IuhxmolVtDGXek9xRKwFOgNhsELQO4TSd8kx0ULJ5ghtnWWCwlxTOKXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVsHj7ki; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVsHj7ki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7260D1F00A3D;
	Sat,  5 Sep 2026 12:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788611820;
	bh=p/9VBIuR+uVbCar2Jaj6F7dzPXJ9Jwsg9JwwpBiLWwg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lVsHj7kiRz/QUWgK88AmKA4+Wq1SP62sGctPTQevZ8EAjTGjEJgDN+mgnN7rwWIru
	 udSOErc/QCTK/ttoEEWVYmufFQAX89FO8CHzcC+liNeMY3jAMIOJt9OaJfQZXSErE8
	 KMLL0wFU3RJ6iEKtZHJOJ5FLNgtKYoNSVkz5+tExbuvvhSMr/OYCaLsrb/xCSCAzvg
	 rfyUNHdBJp6J7mUchE+TViov42hN2uh/LXZIxYjPV1b65St+CpHuDyTnDnS3MjUQCZ
	 KwAIwHKjJc908V9zI4eD7B08R9IPIbbAfY44rPyWxMQfzSCyfq+JqAYZHaYOtV2vre
	 WVnnwiY1LEo8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/4] interconnect: mediatek: fix Makefile typo for
 mt8196
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-clk@vger.kernel.org, linux-input@vger.kernel.org, media-ci@linuxtv.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260905123450.5620-1-breno3011alves@gmail.com>
References: <20260905123450.5620-1-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 12:37:00 +0000
Message-Id: <20260905123700.7260D1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Correct a copy-paste typo in the MediaTek interconnect Makefile that
> mapped mt8196.o to CONFIG_INTERCONNECT_MTK_MT8195 instead of MT8196.
>=20
> Assisted-by: OpenCode AI
> Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905123450.5620=
-1-breno3011alves@gmail.com?part=3D1

