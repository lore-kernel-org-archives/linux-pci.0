Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FD631E834
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859775; cv=none; b=Z+d2unPbKFTGgKCu3TYibBidwdpnLphmrYZwNf02YQCexgJADxk2Um5h0B/HrtV3hicCZKzpa/+QkgkFjQTJgy/LxprAy82TNa4htqRXv5Nhsz3jeLWDFjCT8nFpBr7BO0jZuIsD4fJ1iOl6C7YaDkG1gde2ZLVvc32kSn67s1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859775; c=relaxed/simple;
	bh=3K5Fs30AtIIqeIHOFC3UudKcB8YGIDb1zPlWrVRAgmQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TkG89l5TyTkWrZQ3a3d5ksJwXGxIszcNiUtpge1RoRcLA7Sm3JMr8Jw/l4TRJ0RPLsV4t0tmUFsPw1EkROo9HTHrNc8rQ2xT41hsbjlcKFeupAr7bjF93oGAXA4yDEjs1LpO2qApY7ZaJj8JsJv7+GuE/PAnmtZs0uNZP7xcroQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLUzfvYR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLUzfvYR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421B11F000E9;
	Fri, 19 Jun 2026 09:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859774;
	bh=siekSJfEia8p++UumwNV+SM6Rjwy6CxCLEyhX96/jQ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fLUzfvYRrJ44pxepq3JBXa7EzdEM7h7dimTGGcl1sisOfYN8nVHJUGwA/AHszOLQ3
	 a1nm+vCbYjTmh6m+soMDbbAYhp3Zt2IfS60jlQTaHcu5SETdZZTQOdcgOUGmYrFIHk
	 Lw77L9P1tqyNLDq1n4deUc7wQmtyEhQC+pdGRFFke/GwCkNP5rI6nbMqJHdbr4oUqC
	 VWvCPUEt4mojJ8kr2uQUtDzpDrKNScp1oV28vAam+9QSVRTuawsTgnMshtqrEumqmY
	 jyKXLRp55QasEzcC8HzhRdyXu0xuRzaIc5VIuUR2OLecwawuyqp1r03JnxqH6fp8Z7
	 iPoe1sOsiIdEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 12/25] alpha/PCI: Use BAR index in sysfs
 attr->private instead of resource pointer
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-13-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-13-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:02:53 +0000
Message-Id: <20260619090254.421B11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, Alpha's pci_create_one_attr() stores a resource pointer in
> attr->private, and pci_mmap_resource() loops through all BARs to find
> the matching index.
>=20
> Thus, store the BAR index directly in attr->private and retrieve the
> resource via pci_resource_n().  This eliminates the loop and aligns
> with the convention used by the generic PCI sysfs code.
>=20
> The PCI core change was first added in the commit dca40b186b75 ("PCI:
> Use BAR index in sysfs attr->private instead of resource pointer").
>=20
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Acked-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D12

