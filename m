Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C16A286D4D;
	Tue,  1 Sep 2026 06:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245102; cv=none; b=KU7sfpNneCYPuX6YtId/nVw8BJcS5P8ei2wwnFFkiRJKXp83J/6BC8dfetMW6PVuPKBGa3rzcRZyonZUDsSO6o5KiFKXpQuUc0/Q5i3tNNATPFPfYu38E0m1uhEg360LeBzpwI0augLIKoy44LTwaQjYIGwWUh2jlr5ElhkPYcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245102; c=relaxed/simple;
	bh=iB/XAr+w57ax0EvWUYg7G/oztqVHbhn52fXnQnkrkXc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CQLVZQerP/ZfJqi9f3zJckRvd4NqJXCEPDUfh+TBsJb3SPikMNghpO4gHcZBxUvjar6vlMVKWwRPUPFvMQOHjr4GhNXilNaP30+M6E20QZwMSbQyvusmqdLvK6K3OV2h/qyzb5kNT19Nj7R/bpYGnmaS6Zc92ET0SIzccbOrvXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOy/ixD9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOy/ixD9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030941F000E9;
	Tue,  1 Sep 2026 06:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788245101;
	bh=iB/XAr+w57ax0EvWUYg7G/oztqVHbhn52fXnQnkrkXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NOy/ixD9yOpB8KFc4C1fzrjqp0XaRA2pJfiy3EZFqDnFgDorGtSXtn+tfZTedosew
	 LrtY/eNfw7sDTaBIBzodQFK52Aqk3kc8XtTseI1uUFAZoaFNSS46p72g4Y9j08mpBM
	 Dgp5sBga6H8BaB6b1cpv42fxTXaiVnJVZZM9YzVIwJMjwXArfjcGgjwZhp+NCZEuRx
	 2ZmeC9kOLCAdVrPiLjPoDeZQRaLFKi+h/yaj7BXcM8d4//IrK+x3BguWetuQMhmt42
	 7T3TtEUhOx9gLtfRbGeXffKBsv786BpKbWhYjjoryVx6NfRkLip8bqxEIGVH2riFs5
	 Hh33gVlyWpbRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] PCI: endpoint: pci-epf-vntb: Manage virtual NTB
 and PCI bus lifetime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20260901063238.631166-3-den@valinux.co.jp>
References: <20260901063238.631166-1-den@valinux.co.jp>
 <20260901063238.631166-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 06:45:00 +0000
Message-Id: <20260901064501.030941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The virtual PCI driver registers an ntb_dev but has no remove callback.
> Unbinding the endpoint function can therefore free BARs while the NTB
> device and its client still use them. It also leaves the virtual PCI
> devices and root bus allocated.
>=20
> Allocate an ntb_dev for each virtual PCI probe and unregister it from the
> matching remove callback. Start command processing only after registratio=
n.
> Publish the device for doorbell IRQs at the same point. During remove, st=
op
> the command work and drain IRQ handlers before unregistering the device.
>=20
> Retain the root bus returned by pci_scan_bus() so it can be removed on
> unbind. Unregister the virtual PCI driver before releasing endpoint
> resources. Stop and remove the root bus under the PCI rescan/remove lock,
> then release its host bridge.
>=20
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and =
EP")
> Cc: stable@vger.kernel.org # 6.0+
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901063238.6311=
66-1-den@valinux.co.jp?part=3D2

