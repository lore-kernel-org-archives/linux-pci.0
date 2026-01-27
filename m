Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375FE22129B;
	Tue, 27 Jan 2026 21:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769549420; cv=none; b=BdBfkeBK4veDbdJghOIoC2kP3gOyuWzFsI70m9ocHeyiQn23gsxwqXA11B9ydpeXgEFmZcEZUDZIpHUXxLACXIv1jd6ntm2zKVpBYaumEBRnp1J6vgrkIWd2pC+Su05L7S1kZa/OXzi5h/wcd/XheNWarRNW6ypjmeVkJUF9jp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769549420; c=relaxed/simple;
	bh=X/DyL3htn4ICmaXSKDEv8M3FS9tX32N0mfBoLLW/kkM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RM5G0AukL1IXF7vxwPVgFPTSVP9d6Q1D0yDO2lNybDQfx51MMAwvSrRPlJ9jPa/ieRI3hvw0Ola4wVQMH+l9rOfDCRoYuETyaXKj+OUsGgDsQdM89I7+Z2ZNXg3ijLKYIUujutX5KmwPvJnre9sCCkB9E709vXexW+J9HbAQqUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WijDDMwr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WijDDMwr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C832C116C6;
	Tue, 27 Jan 2026 21:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769549419;
	bh=X/DyL3htn4ICmaXSKDEv8M3FS9tX32N0mfBoLLW/kkM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WijDDMwrDlC0yAJeSE7e/a7UUpJVMqW00N65/Izb6qD72C7Bn8jKEz78nFOhZvU+g
	 QUYm88brO3yU+ppBtnO1DSIgXD0W2eLdtLMtlPQV3nz27CL2AWsG+1M+hAeGEaxliS
	 2fYs8HXjPVThkYlmFrc3l6A9U4up+iQHxlHcmd4wcu2A6yTo4ZO3rXaabQdhJBJsUo
	 kiTUmKAhMoCNgo8zCSKM/gVvWrXD2PP+f7kggd7I/I6mscaN3B8LqrfFps2YWYwjwo
	 UBU0AEm5KpUOWcbTbzWXAc8whnj9A4ihpuGoPGS7nTMOdLiMXhSBRr8DCjOLve2Ae0
	 iEXLI51H5bQgQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>, Radu Rendec <rrendec@redhat.com>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: Daniel Tsai <danielsftsai@google.com>, Marek =?utf-8?Q?Beh=C3=BAn?=
 <kabel@kernel.org>,
 Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Brian Masney <bmasney@redhat.com>, Eric
 Chanudet <echanude@redhat.com>, Alessandro Carminati
 <acarmina@redhat.com>, Jared Kangas <jkangas@redhat.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: [PATCH] genirq/redirect: Prevent writing MSI message on affinity
 change
In-Reply-To: <b5e33957-1b8d-436b-888e-2b6f13d30782@nvidia.com>
References: <20251128212055.1409093-1-rrendec@redhat.com>
 <20251128212055.1409093-4-rrendec@redhat.com>
 <4e5b349c-6599-4871-9e3b-e10352ae0ca0@nvidia.com>
 <a8d841e870d6dbbabef7eadb774f2a58a96c57c7.camel@redhat.com>
 <cfe44924-3419-4f31-8ab3-87b769d21a5b@nvidia.com>
 <96c9d483f67be02fa1dba736fea465216d0c3269.camel@redhat.com>
 <87sebsdcte.ffs@tglx> <255713ca-bf91-4f7e-8df2-33b7b614a1bb@nvidia.com>
 <221f6dadb6d8ce06f30a24baaa2777e90d75b130.camel@redhat.com>
 <87h5s7bb5s.ffs@tglx> <87ecnbb2mn.ffs@tglx>
 <b5e33957-1b8d-436b-888e-2b6f13d30782@nvidia.com>
Date: Tue, 27 Jan 2026 22:30:16 +0100
Message-ID: <87tsw6aglz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The interrupts which are handled by the redirection infrastructure provide
a irq_set_affinity() callback, which solely determines the target CPU for
redirection via irq_work and und updates the effective affinity mask.

Contrary to regular MSI interrupts this affinity setting does not change
the underlying interrupt message as the message is only created at setup
time to deliver to the demultiplexing interrupt.

Therefore the message write in msi_domain_set_affinity() is a pointless
exercise. In principle the write is harmless, but a Tegra system exposes a
full system hang during suspend due to that write.

It's unclear why the check for the PCI device state PCI_D0 in
pci_msi_domain_write_msg(), which prevents the actual hardware access if
a device is powered down state, fails on this particular system, but
that's a different problem which needs to be investigated by the Tegra
experts.

The irq_set_affinity() callback can advise msi_domain_set_affinity() not to
write the MSI message by returning IRQ_SET_MASK_OK_DONE instead of
IRQ_SET_MASK_OK. Do exactly that.

Just to make it clear again:

This is not a correctness issue of the redirection code as returning
IRQ_SET_MASK_OK in that context is completely correct. From the core
code point of view this is solely a optimization to avoid an redundant
hardware write.

As a byproduct it papers over the underlying problem on the Tegra platform,
which fails to put the PCIe device[s] out of PCI_D0 despite the fact that
the devices and busses have been shut down. The redirect infrastructure
just unearthed the underlying issue, which is prone to happen in quite some
other code paths which use the PCI_D0 check to prevent hardware access to
powered down devices.

This therefore has neither a 'Fixes:' nor a 'Closes:' tag associated as the
underlying problem, which is outside the scope of the interrupt code, is
still unresolved.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/all/4e5b349c-6599-4871-9e3b-e10352ae0ca0@nvidia.com
---
 kernel/irq/chip.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1495,7 +1495,7 @@ int irq_chip_redirect_set_affinity(struc
 	WRITE_ONCE(redir->target_cpu, cpumask_first(dest));
 	irq_data_update_effective_affinity(data, dest);
 
-	return IRQ_SET_MASK_OK;
+	return IRQ_SET_MASK_OK_DONE;
 }
 EXPORT_SYMBOL_GPL(irq_chip_redirect_set_affinity);
 #endif
