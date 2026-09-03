Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D32A2110E
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 04:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788408596; cv=none; b=duDvy7g/L1GB8lY9suK5PacrMf3HrACFGvC0Kc0b+SODVHTTNKhgml21VN2VNRSHo620gQX7W/ZkWZcvikYGS7sWCL/5TkDBZLYrHrxqlo4S3uecgZ7IHAsh3MPl92+5l0IGza1ZwyX+Yk/b+CSbZu5dO4kWldjcKb2nV34zdko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788408596; c=relaxed/simple;
	bh=THICjPyYglhEkcZ8O+UDOId7K9JKg5j1uGrIEj5qHzA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nJPG/Blq0D06edG6tbfVwY4GmJo1++ldZI3orhBqOOxr5JP2f2OujEO3iCzCya4da62ElXooD/NoDxyPoV1udF4/8uhA4d332UUncBqQTwRCYDVQcNox/Za5GUc1CNn/YT1D08rsQJ1H3owZtUOwD6hX4mYi5ke50ynRKobWSZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyLebAba; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyLebAba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53AB1F000E9;
	Thu,  3 Sep 2026 04:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788408595;
	bh=THICjPyYglhEkcZ8O+UDOId7K9JKg5j1uGrIEj5qHzA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WyLebAba0valmJ3jvS6aHOvmJjrskHP69CuIh/k9RgDA7E10i/jQ5Mu6mDc38pWhY
	 b0QubHw+8B6s0D23AB7OQCQ+933teaiXU+O7zvLGsq18XuVZhwapLBhY7MJta8WmWL
	 U3W64Nupo2jNnxTiYTeMUBEFuGydBImicneD1M7b1VDLWgfvTgjzDhiDwKAQWs4u3l
	 TARLBR/ww6iaVnavnDJrKbROmn9DpXChucp5yKMOP/CnMShKOPbIBk7HZLb955bASp
	 5yWxGz7GE/fG7gFP9ZtEEQ9fEMpI/iUqx8b/JQEO82G41p6+M0S65VeXKlWv2KBQ8Q
	 GG+Bu5mAyNhag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: quirks: Fix out-of-bounds MMIO read in
 nvme_disable_and_flr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamad Raizudeen" <raizudeen.kerneldev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260903040049.5460-1-raizudeen.kerneldev@gmail.com>
References: <20260903040049.5460-1-raizudeen.kerneldev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 04:09:54 +0000
Message-Id: <20260903040954.E53AB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> In nvme_disable_and_flr(), the PCI bar is mapped using
> NVME_REG_CC + sizeof(cfg) which is (0x14 + 4 =3D 0x18 bytes)
>=20
> However, the function later reads the controller status from
> NVME_REG_CSTS - offset 0x1C, which is outside the mapped 0x18 byte
> boundary. Reading past the mapped MMIO region is undefined behavior and
> can return invalid data.
>=20
> Fix this by increasing the mapping size to include NVME_REG_CSTS.
>=20
> Fixes: ffb0863426eb9 ("PCI: Disable Samsung SM961/PM961 NVMe before FLR")
> Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903040049.5460=
-1-raizudeen.kerneldev@gmail.com?part=3D1

