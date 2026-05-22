Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AF93C5833
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779443810; cv=none; b=JYa4Ofu9d/j0PZ1dkFgeAVq6PNH4d3WjVtEn21vT5MNN59mw16QNM38PmPbOm3WP59wjjYkxenohFpix78C6b0oRb5IFMELM7scomxQjQGIMy8fnVfgczNMfVFuKyqya45S4TqLiXbypHz02iIg8pmZuB+6VcRPXP5dfiIXfDQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779443810; c=relaxed/simple;
	bh=mfVEVUxeE0xX/vqpAqMUT3T7pljXZBqZmgyaQpmAqiw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PxUTCnS8idBxwCUr4dYmdrLV7MEuip6Qr2ozLABaw1ct9xjF56eGT0nCd37bc9i6mmtrzRErNfPN08BKBBxRy09tKmJXJ+45GekXKLD9IFWLuNhuFRPo82DYOnd3qr8/V33S1tzf36qv9Vm2Z51ErFJoGz5ba9kdGna203fzNHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c522VD8A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c522VD8A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676831F000E9;
	Fri, 22 May 2026 09:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779443808;
	bh=N4eTqI3dF3Z6Kb77f4g2z5lHZgLJWQAdHiMGKnm2HHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c522VD8Ax2SDrQf/3sbtdunSDyBrSY9UkvS1t0cT2ld2Le+vfdSFRBfDj8pELzkyr
	 ejhaCqe/380LrKTDR9yeTeKuV0WF6bZoVuwp669Yx0UZ/II7b1miAJejYluh1xHZ8N
	 EMyyi1LJf1G1zP6l704xRpiMyTQPXwAEhu3hFNvQDNKMM68VVlXKCiO5hXyIKGJGxj
	 VFLympkaBnHdFfMtj9uiN1qBT4idJUjQz4VXaXWoo8kcNa6PtCrNBgaFEHq2ZFEWR9
	 vfnHw3h2puwBjeEeQynOeADnL8ChLKPWMT5vqPKwzdzK68pLg1+DHAaTDPQxoMrncI
	 CkmIGVuuJ3hVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: Avoid unnecessary cpu_hotplug_disable() for
 non-NUMA devices
Reply-To: sashiko-reviews@lists.linux.dev
To: weipengliang <weipengliang@xiaomi.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260522084844.1901-1-weipengliang@xiaomi.com>
References: <20260522084844.1901-1-weipengliang@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 09:56:47 +0000
Message-Id: <20260522095648.676831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Commit message discrepancy regarding the placement of cpu_hotplug_e=
nable().
--

commit 9acd77cab9fa6f681c21a1bfe522a33f79ec6605
Author: weipengliang <weipengliang@xiaomi.com>

PCI: Avoid unnecessary cpu_hotplug_disable() for non-NUMA devices

This commit limits cpu_hotplug_disable() and cpu_hotplug_enable() calls
to the NUMA-valid code path. This removes overhead for non-NUMA devices
where local_pci_probe() can be called directly.

> Move cpu_hotplug_disable() into the NUMA-valid else branch so non-NUMA
> devices skip it entirely. Place a single cpu_hotplug_enable() after
> destroy_work_on_stack() to keep hotplug disabled during flush_work()
> and local_pci_probe(), preventing CPU offline from migrating the probe
> work to an incorrect NUMA node.

> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
[ ... ]
> @@ -414,11 +414,11 @@ static int pci_call_probe(struct pci_driver *drv, s=
truct pci_dev *dev,
>  			error =3D local_pci_probe(&ddi);
>  		}
> =20
> +		cpu_hotplug_enable();
>  		destroy_work_on_stack(&arg.work);

[Severity: Low]
This isn't a bug, but does the commit message accurately describe the
code sequence here?

The commit message mentions placing cpu_hotplug_enable() after
destroy_work_on_stack(), but the code actually places it immediately
before.

Could the commit message be updated to match the code, or should the
code be adjusted to match the intent described in the commit message?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522084844.1901=
-1-weipengliang@xiaomi.com?part=3D1
