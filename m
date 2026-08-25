Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E5B332604
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 04:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787633130; cv=none; b=gHKKW9pzoQFbAstWtT2dpEqOLaoFgG1P3agN5gnZZrhZkUIyKplE4gknnPd0doI2jI1xUEmzs87uZm9FHxTxzaa8O6yfJn0BWnUkq9bjSiApCLfwR95HsQyy3jQ4DPXrC23Om2MLO89EmpqdYtwlF9gBpNvGK1xGSBfh7mXKNL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787633130; c=relaxed/simple;
	bh=5UcaM+CymM6kJX62zVpfLKZo26au4+wISDHhwale1KM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iZEQEiYZO8sSf0x3bpKGtqT2HLd6Qu+1ezj4gIQOgW8ZONDm6UmnGONxeKdf3QOdHsmho9lnvF2lCxGBQufwM9LfJrfjLHIm0D/eFt91S5vr5iaozKZMlpfgw3IiwfopcLMqgiaS18+TTEAjoWg2TJPrz7kg1NwXDLphzGvznNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUI15piT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUI15piT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E581F000E9;
	Tue, 25 Aug 2026 04:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787633129;
	bh=CehflG/27Z1IeTxlvuu5/qXfsRHITV0K/8aRTaaZKDc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NUI15piT/EaPiZQ6IX6hkPbXgqA0wxj7+8SJzR7wV/MfNTluuKBUo1hJy/vJwgrDV
	 jGZQKqZ4lCVc7Ux4cq8bN0OI0mkrJXKascLG2fSQfadCYGuyT1jjxM70GL848mHCgd
	 KQYWIElrmXDez7UYcySGWzX5OWxk87B+BfA+jThxyGzT7/kweKAkchFjieVsaxYpAN
	 //S0ImNwqPUI8lEjt3SoOe979G6Bw2siVl/JNAZrj9befMzvwxAJy4sbrHtzGVKWSR
	 DAoh16a9z0nFuEhO3xRc9W9WV30h8F0pP3PLFisTj7WyjlnNeOQ6EM5Gm2nV+1OvJZ
	 GX4i9ll6+Nn1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: vmd: Flush initiator posted writes before demuxing
 interrupts on Meteor Lake
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rickey Bartlett" <subtexel@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260825043220.9047-1-subtexel@gmail.com>
References: <20260825043220.9047-1-subtexel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 04:45:28 +0000
Message-Id: <20260825044529.25E581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] SRCU structures are destroyed before the IRQ handlers are freed du=
ring device teardown, creating a use-after-free window if an interrupt fire=
s.
--

--- Patch [1]: [PATCH] PCI: vmd: Flush initiator posted writes before demux=
ing interrupts on Meteor Lake ---
commit ee34aa5044fcd3846f8909a9ac941afcd7c5a7d8
Author: Rickey Bartlett <subtexel@gmail.com>

PCI: vmd: Flush initiator posted writes before demuxing interrupts on Meteo=
r Lake

This commit mitigates erratum MTL016 on Meteor Lake VMD devices by issuing
a dummy config read to the child device before handling interrupts. This
read ensures earlier posted writes (like NVMe completions) land in memory
before the demuxed handler executes. This prevents the storage stack from
stalling due to missed completions.

Link: https://lore.kernel.org/all/20240909082657.19660-1-kai.heng.feng@cano=
nical.com/
Link: https://lkml.iu.edu/hypermail/linux/kernel/2409.1/08047.html

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 241023ecf6774..e45ef8cb16e47 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c

[ ... ]

> @@ -756,8 +791,20 @@ static irqreturn_t vmd_irq(int irq, void *data)
>  	int idx;
> =20
>  	idx =3D srcu_read_lock(&irqs->srcu);

[Severity: High]
This is a pre-existing issue, but can this lead to a use-after-free
during device teardown?

The VMD driver allocates IRQs using the managed devm_request_irq(), which
means the IRQ handlers are unregistered by devres after the driver's remove
callback (vmd_remove) returns.

However, vmd_remove() explicitly calls vmd_cleanup_srcu(), which destroys
the per-CPU SRCU structures immediately. If an interrupt fires during the
window between vmd_cleanup_srcu() completing and the devres cleanup,
wouldn't vmd_irq() execute and call srcu_read_lock() on the freed
SRCU structure?

> -	list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node)
> +	list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node) {
> +		/*
> +		 * MTL016: the MSI may have outrun the initiating device's
> +		 * posted writes (e.g. its NVMe completion entry).  A read

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825043220.9047=
-1-subtexel@gmail.com?part=3D1
