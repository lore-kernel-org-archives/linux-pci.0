Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6770B4D7D26
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652005; cv=none; b=FbLfzPhnRgZBGnRu3b4rM7xhO8acVFMJx8sJOTnZmIMKMCWwrBVg4W+LOBhEH3lotSer3yd7R2Y9kKiJuEWCABsTH4GzxiQeYBlCFlrfFDuW/IsH1Sl3HBdgdc1xa3heZd7Riutd5Ib6rKqlxx3iqoSrxs5b40OEamu8Spl9QFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652005; c=relaxed/simple;
	bh=iTShWwHT4kb5w2cqsxq7U4/RuS1/ZjNieaUcJOcS7b4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q1FNo7nQzcJT288Jwy3bPrcd3pqHPio1tJA/wkDYhvnxcuwtskO3n+NdyWLHXY5tyGMhGKWo11VQEWGczvJYNG/kIh74Zwp+bESOz7ptZrXKx+gDHedBNv0XrpYdXr6Y4JsCKFemrhptqtQxbuMz3uf6U7Rulz+AWiHmm+xXAX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nni9PtgX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nni9PtgX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24E11F000FF;
	Thu, 17 Sep 2026 13:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789652004;
	bh=HOSXvWgwzWfAX8cVdMtkrchBOqNakEGqQpDCTJSgONc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nni9PtgX+H6Hr/cr2RBWRXqgc2FEAMMPKeBSHysInFB4/nyhtq5PKjbDNLVSeeXHk
	 oajWftyNnvwnn7Pir/6L7Sg2I4mlcXqInsvSwfSVKWLyb0EATEX6ema5O2WUoRnLkw
	 2WyLCj102v0wNScrPTzB0kFydatOBA0OncZJ4bMhwNjE5bDIKkUzQAY/BQTt4RieP8
	 0MCmu84vR2z0G+9YD/1kWZ+IX2CloihiAHOUP848DlrwJY/71P3kvPGKrrhK4l/bc5
	 bpqSsjY57FO9F09BoEqB+v54TgMwtBNqUBDqQItJvEIPk6fBXyxkr+ZDMcruq4zkdB
	 Nh3KSWF8mxiIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/IOV: Fix peer device reference leak in sriov_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260917132745.2153341-1-vulab@iscas.ac.cn>
References: <20260917132745.2153341-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 13:33:23 +0000
Message-Id: <20260917133323.D24E11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> sriov_init() takes a reference to the SR-IOV physical function device
> with pci_dev_get() and stores it in iov->dev.  If the subsequent
> compute_max_vf_buses() call fails, the fail_max_buses path frees iov
> without dropping that reference, unlike sriov_release() which puts
> iov->dev on the normal teardown path.
>=20
> Drop the reference on the fail_max_buses path as well.
>=20
> Fixes: ea9a8854161d ("PCI: Set SR-IOV NumVFs to zero after enumeration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917132745.2153=
341-1-vulab@iscas.ac.cn?part=3D1

