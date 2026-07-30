Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C73370AF3
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 03:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381394; cv=none; b=ma2/YXPx7ciFo6rulMUuQ1X9oyyYXRrBLIvCwkjxHybSxZGTzRSSp1I7jpnpOg6si5FrVCWJz3zxOuFx6qv8EU8GJbeA7ZkiwbbT/hrm+J890DuUw1dmtROftrqIbVHT+MmTZp8Mt4A2pe6grgeMRKcGEQlB7hF1COtTmOhLDSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381394; c=relaxed/simple;
	bh=XdH8QMhUlyp7Qms+0SRh+d+4p9d4C0ZnBIHKTyonqFs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jNAcSHeNqREdjl7gb3yfC207WGUre9Y/PPk832PEKx5XJ9v/HJxXDMNQodVFK9han8qBmrTZ8uEebyOf7/wTfuIS9TGPmnGodHPsMqoyV8W1HWnxUeYGS/DtGgVqeW55NGXC1y6QlrqvDHekSRfkFChF/08lSmoZSmioLvS1Heg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNMznApO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNMznApO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03311F00A3A;
	Thu, 30 Jul 2026 03:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785381393;
	bh=XdH8QMhUlyp7Qms+0SRh+d+4p9d4C0ZnBIHKTyonqFs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QNMznApOwkikL/iMuy6fovsxwIf6F0fzZTNPgTVXHhBxl9C5kGLKdeQYbcVnysCZa
	 bZMx7Z4+LvLGNAgUUcZPGQihkxmzGAcKayNNS4yhaZMlIeln2bAJtI+SHCWG/mtaXa
	 4DK8ghIYkUY1PC8Bi30dp4YqcKPv3kl4jsw3884fN7blvVkNNM1W5WDNrxd8hsSPA1
	 /bYmCvJRVnCm0VJVwR0RqT520tn5aHARMZHHenniwAF6SIQ1ybcnRlq6z4IVpNgdOY
	 isRbEF0Hh8zTjP+q+10mZtET/h+oJFoV88npTckYKLIzxCmjSOwv6JjE5lTPypoENK
	 WyEYSa6fl5HzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] PCI: Prevent overflow in
 proc_bus_pci_{read,write}()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ziming Du" <duziming2@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260730032438.1643450-2-duziming2@huawei.com>
References: <20260730032438.1643450-1-duziming2@huawei.com>
 <20260730032438.1643450-2-duziming2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 03:16:33 +0000
Message-Id: <20260730031633.A03311F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> proc_bus_pci_read() and proc_bus_pci_write() receive the file position
> as a 64-bit loff_t, but store it in 32-bit variables before validating
> the configuration-space bounds.
>=20
> In proc_bus_pci_read(), pos is an unsigned int, so an offset such as
> 0x100000000 is truncated to zero. The truncated value passes the bounds
> check and causes the function to read from the beginning of PCI
> configuration space instead of returning EOF.
>=20
> In proc_bus_pci_write(), pos is an int, so an offset greater than
> INT_MAX may become negative. The negative value bypasses the
> pos >=3D size check and is then mixed with the unsigned nbytes value.
> The bounds adjustment may consequently expand a small request into a
> very large transfer, causing the write loop to use invalid negative
> configuration offsets and run for an excessive amount of time.
>=20
> Fix this by changing the type of pos to loff_t.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> Signed-off-by: Ziming Du <duziming2@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730032438.1643=
450-1-duziming2@huawei.com?part=3D1

