Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793734783;
	b=nXCeMpBJXGokpVjfsn4NIh1vyJKfc3OF7RWvph50d3s/2yazpSKnJUGutfsCmNmklmLD
	 faN02gLXEPCr/qAspFWGS8ll3+Za4T2s8Mgr8/TdqIwfYR6wWH1ZtCENO88rj6Z1vxiqi
	 ld+XvtS9FNrXQ6FvMG1BtnkR24e57fJ1qRo77ztBoM3/AYYf6toHpmFHY6W8BCWPm+u/f
	 VxDmHHb2Us/F5h5gw8PEZk2yRNZXkwpzStmc1YDhmO/Ub4ec/HrK5tcHaa3W8q4/Qh0jg
	 bmrkUGWAqRdED3l/tlKEdjpm1YSkfpXudG/9OzyT9sVZwdMm8W21AEF7bdMK++E+HIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734783;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EKx/64x7MpEz2kZ75juRlT0NBym9HYUjgk0HxKA9GFE=;
	b=NKRUsRhxm/00U0/bbyLFF/V6GRzhVtGHR3/RCqnxP1nmFanltJMD2sIjbrBxAOFSNUjf
	 awKcxJDXO0AocVpPITp7StxIUQPIfZcc600nrwckQdjyKck/mWsfTRvMi/j6EYw6oF5t+
	 uW90Y4hSaqJfe9ipxRZf8BvjGTZ8OBI5rHYngohDU2ubJXIs9xCS+ZnEnQywaKYQh+HOG
	 4H6DGTq09hRhHxiz303O28VSPqQmD3An5Us8xarZqWFNTvxk/Yy68B1aOlmGp3nGXUDnW
	 LG81Dw8Km9GtOCx3i1thWy7CqbJ8PwnHXUjBM2nw99IaBXTUsbgDitjL1ttZDwgMAqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ow//4osx";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AA6606A31B
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ow//4osx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3321F000C1;
	Tue,  3 Nov 2026 19:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793734783;
	bh=EKx/64x7MpEz2kZ75juRlT0NBym9HYUjgk0HxKA9GFE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ow//4osx5+SXLdTSzOigg65WD1f2IN2NY3XjQ6VpqJBpDC7xbCWBdIRsoXni2RMj5
	 90W01Yst8qvqfMVDwsRXkze5OvPUhAf885J2NXNhaqZoe4dXbJeJz/4IYcPXXu6RrT
	 HTLoQMWFjvrZ0tzsnIfLPCrQNIKkMYq552VM4krY3k0oBYbKXP8ZkXIt3LO/Ihfolw
	 2eS4X2wqydr5r3/653d9qtVMiMHXeZ3JKfBZpoO1XRy7bsXEXTH2BQfVnbYiq7zT4Z
	 v7am+4/l818JrrrD42P24xhigK4wrMUAfJbw9w5FiNGw7wPqsJpESMKQRFSBUX/7tQ
	 7T93ir2xveqTw==
Message-ID: <sashiko-outbox-195930@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] PCI/PME: Resume Catlow Lake Root Ports on PME with
 PME Status clear
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103193136.2410148-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261103193136.2410148-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 19:39:42 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Intel Catlow Lake PCH Root Ports do not set PME Status in the Root
> Status register when they generate a PME for their own hotplug event.
> The PME interrupt itself is delivered.  PMEs from devices below the Root
> Port are reported correctly.
>=20
> PME and hotplug share the same interrupt.  When a hotplug Root Port
> runtime suspends to D3hot, pciehp disables hotplug interrupts and relies
> on PME to resume the Port.  On a hot-add the Port signals PME, but Root
> Status stays clear.  pcie_pme_irq() then returns IRQ_NONE.  pciehp_isr()
> also returns IRQ_NONE because hotplug interrupts are disabled.  The Port
> stays in D3hot and the new device is never enumerated.
>=20
> Mark the affected Root Ports with a new PCI_DEV_FLAGS_PME_UNRELIABLE
> flag.  If such a Port interrupts while not in D0 and PME Status is
> clear, pcie_pme_irq() resumes the Port.  pciehp re-enables hotplug
> interrupts on runtime resume, and pciehp_check_presence() finds the new
> device.  pciehp itself is unchanged.
>=20
> The workaround only applies to quirked Ports that are not in D0.  AER,
> DPC and bandwidth notification also share the interrupt and stay enabled
> in D3hot.  If one of them fires while a quirked Port is in D3hot, the
> Port is resumed without need and runtime suspends again later.
>=20
> This affects all steppings of the Catlow Lake PCH.  A public erratum is
> not available yet.
>=20
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Link: https://lore.kernel.org/linux-pci/ara-_IPXV_i90if1@wunner.de/
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103193136.2410=
148-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D1

