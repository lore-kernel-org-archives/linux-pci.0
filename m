Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7AA1C8FBA;
	Tue, 27 Jan 2026 13:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769520885; cv=none; b=ZzkCxl8f6khxKnzRQJjgQJFQiLG4ImzZJJFZCpX2U/Sg+YXMcXNGxuX5oxnuPMEiVLxknu3rygFruRflslw7Y64DS/bbTFPBFIPUC29ilhe+q9CQMi3I04/Sw1e3VU0KSxPyinEL16K7WcrqE9Gy0us3rTROBS/KraGSXZcO4ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769520885; c=relaxed/simple;
	bh=zAxdFpot855JxNvT7odQY242F1IJJlsgHQIK4wOGhBI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aFtT5Maxh7EF26vw9gvBC5tq+FxA9YQAp9epMX5EiXbvU2/gDPk+k12BLoH+mLA+0EdWfGcZmccPMNFQb9/rfrc0JofPsVWi3657jJM7hjuCnbzZDWzi9vUrdU4c1FYSzoFjXGBNyG3qAQ240HEKqd2rYo28N3js6pBDUTd9TXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhmSXlQ2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhmSXlQ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3712C116D0;
	Tue, 27 Jan 2026 13:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769520884;
	bh=zAxdFpot855JxNvT7odQY242F1IJJlsgHQIK4wOGhBI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hhmSXlQ2McB2++5680pk1yYf08glMoDkCRa3DfteYYUGNq26VHXxOVD9TkDx90E1F
	 Oi8SYc84ltR/88jYYDcPcmr4gGLZsuWkSqEa1GUAZJDEawQ19k8QwvtXp+yLWq5NaO
	 wkM5s+aeVaxt2N3hiH0NyifavTaau38fPBL26N8HBrrVMsc+f3wtwDhRLTP8X846Wo
	 t92hCAK7wJBtjBSsVdJ+eiabo/aVDl0E88AE1tsA+91VQ7x87RYQtphX7xGH3FIOJ+
	 c8Y5pc1MDl+pDkySfdLWP3Gw2ECdr2QaXgaeuiwU5jwtwf/6jUTcPgSWMnb7NgFrML
	 2uBDEBeO6mdBw==
From: Thomas Gleixner <tglx@kernel.org>
To: Radu Rendec <rrendec@redhat.com>, Jon Hunter <jonathanh@nvidia.com>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: Daniel Tsai <danielsftsai@google.com>, Marek =?utf-8?Q?Beh=C3=BAn?=
 <kabel@kernel.org>,
 Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Brian
 Masney <bmasney@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 Alessandro Carminati <acarmina@redhat.com>, Jared Kangas
 <jkangas@redhat.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, "linux-tegra@vger.kernel.org"
 <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] PCI: dwc: Enable MSI affinity support
In-Reply-To: <87h5s7bb5s.ffs@tglx>
References: <20251128212055.1409093-1-rrendec@redhat.com>
 <20251128212055.1409093-4-rrendec@redhat.com>
 <4e5b349c-6599-4871-9e3b-e10352ae0ca0@nvidia.com>
 <a8d841e870d6dbbabef7eadb774f2a58a96c57c7.camel@redhat.com>
 <cfe44924-3419-4f31-8ab3-87b769d21a5b@nvidia.com>
 <96c9d483f67be02fa1dba736fea465216d0c3269.camel@redhat.com>
 <87sebsdcte.ffs@tglx> <255713ca-bf91-4f7e-8df2-33b7b614a1bb@nvidia.com>
 <221f6dadb6d8ce06f30a24baaa2777e90d75b130.camel@redhat.com>
 <87h5s7bb5s.ffs@tglx>
Date: Tue, 27 Jan 2026 14:34:40 +0100
Message-ID: <87ecnbb2mn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 27 2026 at 11:30, Thomas Gleixner wrote:
> The below untested hack should confirm that theory.

Actually looking at it deeper the solution is trivial because in this
case writing the MSI message to the device is not required when the
affinity changes because the message does not change. It is set once via
msi_domain_activate() and stays the same for the life time of the
interrupt.

So the below prevents the invocation of irq_chip_write_msi_msg() in
msi_domain_set_affinity(), but I would recommend to investigate the
actual underlying problem nevertheless:

It is going to roar its ugly head at some other place sooner than later
as there are tons of other places which guard against
pci_dev::current_state != PCI_D0.

Thanks,

        tglx
---
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
