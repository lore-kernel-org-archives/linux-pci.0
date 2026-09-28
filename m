Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2285E4E80CA;
	Mon, 28 Sep 2026 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614600; cv=none; b=mll7J53yeuJ3nfvssSeXdVwHdLYeBFj8YjatBiiHSw+Tm5NYQbiZ4fEXJQypQm3y+jwnTfKVQf8ezCeywJ2uXnatNUfxwYOD0aLk6eA6XXxJNtkalvG1MbEfn77im9Na0zMNLnNlgtL1LBlT/XCJMeWMCZh2oLnE4VcYyBhjy6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614600; c=relaxed/simple;
	bh=sO/32zlrMq1VLScKMY7zA17ekU3wHVNZXYEt68swSEc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Grz3imvmEVMDZkY8nui9uAhKld7vnS+gOs5ys2qZkcVo3fG2bp+tvQM6YXv10uaX30bekdYQC5Rqx2qUl2fjqyPlCGFn75nfJCuX8e3Sfz8tnLbAJDcodyLKuZt7sMTzxB+i1UQE+mlefow7wohaCE/DoHDUxqDyeuxC0HYkmUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EP8xfQcx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EP8xfQcx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617181F000FF;
	Mon, 28 Sep 2026 16:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790614598;
	bh=sO/32zlrMq1VLScKMY7zA17ekU3wHVNZXYEt68swSEc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EP8xfQcxhoyEebvhRgpZl2pUG5m9nsmONeX4nGcryk8sE0prMxx7+91fJIKlR+hTk
	 C/XSeIs0YGYDfLBxfD/Io8xGkHrod1b9Lt5xvxuTfCJjKZBkO6Zn4MdoX3NQdCxkaO
	 G5hNg3T9OiHTaTDXcXI87yJlJQekzUxL8V7q009I0W6EnqrAw92WCPr83UxmhKe35p
	 Brfy3JpM0E1G3FOGmk6fiqsxsPai5pcYDw83NUV+rfkX+R2PyoxVuJfiidu6PvCson
	 od9yZnjzrprt3inCODjHU0nE/uWRePqRoFF1pzIZVA2nr7Aw94BMRk4UHPiCtySf+A
	 1V8iAHhAKKf4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/15] PCI: dwc: Add Renesas to the RAS DES VSEC list
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260928165230.3397664-2-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:56:38 +0000
Message-Id: <20260928165638.617181F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The Root Port on R-Car Gen4 (DWC 5.20a) carries the RAS DES capability
> with the stock DesignWare VSEC ID (0x02, rev 4), but vendor ID 0x1912 is
> not in dwc_pcie_rasdes_vsec_ids[]. Add Renesas to the list.
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928165230.3397=
664-1-den@valinux.co.jp?part=3D1

