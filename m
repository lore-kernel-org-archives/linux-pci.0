Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5BA4CCDC1
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198204; cv=none; b=IhAV/vOaT/TnC2wUByp0cHmGXX8hQE1VlYpxjOJtyCAtHdgCpewRv6jeGN5UGTqTnFz+ac6oyg+wox3BmGJcZVh/2g9nORfAACINJyM22Sob+9mYWvOd9INEjGJI4/657YP16LXbV29MtcAzN10QeH1fUQYCuXKKRmwi45COmhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198204; c=relaxed/simple;
	bh=ELE89wpE1pyQPCS/SzSYEQzP8RzHuyrtquI2RXDhhyA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s3lfvw/ljMaBggpU+i9+jjM2iCRxxFWtXcrWarLZf7Od+Z3FksC18NYw8/ApKCDwQJaoqKbS7pTTRJCrPhbjhnds7ttaDJxU9xhuhp4bdBX8gtzSKANKaZnIa7ghT+DTQVk9ZEFUO9Z7akH1aOAUynCm7MgTBDUrBHyHck59PSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeWu9uiE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeWu9uiE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2DE1F000E9;
	Mon, 31 Aug 2026 17:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788198202;
	bh=yaOp/AwluGFh69VATflIDYZxBgo0t/HBl5sjtEzMXBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YeWu9uiE4uL2i55m0IKKYc1e6lyEcB/0iTNdzePT28c18cM1HJVldzT9F/tyhN24K
	 R83nyvkyGZem0iIFnOJQaI6qRRAuhMOZWoTBEbyry7SIbjR37wUt078b5ik8y8ZqOm
	 TAkCR8Tpkt3tLyDSHJ4wdlg8txCCQ/Hsi95zsllu2pkUTBuRJr/DB2wNKXTXGsqiwT
	 cfumtQ11ILcFqsTUjL8+5aczBZW7kEnFdfT6FBI4xftW5339sAPiiuZBcU4ffwbMDO
	 o9K0cOlX80RQQFov7q3JR3OM/nqh7mkctJtBkIl0KQy6g6r94PDNMH/yXe1wpkn0Y8
	 4AQadpWqkOXVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] PCI: iproc: Protect root bus removal
 with rescan lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831133314.4125787-657-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-657-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 17:43:22 +0000
Message-Id: <20260831174322.8F2DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Hans Zhang <18255117159@163.com>
>=20
> [ Upstream commit a6a64e150f12ad5391e0a0d60f6a3d119b06ce50 ]
>=20
> Hold the pci_rescan_remove_lock lock while stopping and removing a root b=
us
> to avoid racing with concurrent rescan or hotplug operations triggered via
> sysfs.  Such races may lead to use-after-free issues or system crashes.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> [bhelgaas: commit log]
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://patch.msgid.link/20260521161822.132996-6-18255117159@163.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-657-sashal@kernel.org?part=3D1

