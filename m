Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793994022;
	b=iqdb8zk7Ntq8lLmkbplqYfhll1t8Ri4yC9p9ApWDU79E7hdMJqMsN1+eaLO9LAE4BxUg
	 FEU92snpKpz2M+2pSTHCAmLP7HMeG8P4TOgv2EYjbdOcgRHyKIMmuXt+qGaEq3HG7W+ej
	 aDNp9RD2RvPh66kTipYEFWaaxF6Kxf74ZpK3IMbLahEsV6vJPWFtmGyMtkqA83oIHh6vz
	 PNfyqJX9OwI6HcEAWOLeAlQnGI0n/VKovA0NOd/Naha5FrY7oekIxMLeqPBh4lGsuQOLG
	 Px5RBjyk8N7vtz94qA/jmE16DBsx61BDgJlXnXkWVi1d+40gQSfavY6VOTcP0DpSTUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994022;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=MOpDpeNgb/GGPkym8lq255jwdO03Yv3VcEF5RByy9tE=;
	b=UQVls6hY7PDXdsJQO8A7eb4DxLuvIPyoJJ+YYpo7aicThMzcW7Gd80bpM3tg+pBC4FyL
	 hFQ2Is0GenaK0ayT/qmE+YBRfI/27SvhMrv+9EO+DTJPAPLfWIBYNxJ5D6hYEyyKRtTMq
	 6gI5JeXxLH+zctPg3SqyItNpg9lxgRbj62WrkANPen7OrOqxJKOPyB4CUMpwbuSJwG87H
	 5NVKa5oSXlrPIfS1cLQNghxe3vxA1u8AfYSLaGDhNiiGgXWoerKV6smzx5MBVXgKtjYGZ
	 1RmelSdbx0HAL7aDiDQ+Sjv3N1awmI1eKe5bEgep7AUB4EMGOApJeI+O+UJYClcbmdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773B2606A326;
	Fri,  6 Nov 2026 19:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B8D1F0089F;
	Fri,  6 Nov 2026 19:40:21 +0000 (UTC)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 01/16] PCI: dwc: Add pcie_cap field and caching
 helper
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Hans Zhang <18255117159@163.com>
Cc: sashiko-reviews@lists.linux.dev, imx@lists.linux.dev, 
 linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org, 
 Frank.Li@kernel.org, neil.armstrong@linaro.org
In-Reply-To: <3773fc58-a6ab-4f8d-a9a1-c865217afe84@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
 <20261028030652.2917756-2-18255117159@163.com>
 <sashiko-outbox-187403@kernel.org>
 <3773fc58-a6ab-4f8d-a9a1-c865217afe84@163.com>
Date: Sat, 07 Nov 2026 01:10:16 +0530
Message-Id: <179399401605.55876.3520713514569261990.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3038;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=1tMG3qbjDNeqUpxfEBEvQAkk2kZSTgYVoHa4KZ6UwNk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq7i0gBLa0hX8gTIugn2MLgSu3YqcqnGaKfSliE
 khZL5oFTgSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCau4tIAAKCRBVnxHm/pHO
 9QLzB/98XUV9FjvnZTWHvlQLojLVfWOzHoACcUgVHDiCq/7ZVYkJoCtPGTWAeY87dvCUBo8RYxk
 GUtJUQAxM6Kdbfc6bvVhkdbMJYgzw1ARlnHSM6rFe5ZNxhO2wJRzRu1dylIg15lRDsjgsHOUdyE
 n2GGcV/wmgckVB9+3Hlyhd8KlTcrWPkrsSAJzS7C6H5CM1gDz3iKCkE8iCv1BjaUaTWDnbZwxYe
 Da2RS37T9+o5tqMzFNLfUDIl9bPiJUQiv5rzK0BkpGvdZ4r7mzK50bFeFJXVeDVl27SvwL2gsj8
 WHO1wGfB+Zd5qVajvJelHygoWeU2HgRGKSpzR93/kohcOiXL
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-28 11:18 +0800, Hans Zhang wrote:
> 
> 
> On 10/28/26 11:15, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] PCI: dwc: unconfirmed offset returned in dw_pcie_get_pcie_cap()
> > --
> > 
> > commit c6fcd840cdb57dd351ea1787cae915ad3164fb13
> > Author: Hans Zhang <18255117159@163.com>
> > 
> > PCI: dwc: Add pcie_cap field and caching helper
> > 
> > This commit adds a pcie_cap field to struct dw_pcie and introduces a
> > dw_pcie_get_pcie_cap() helper that lazily looks up and caches the PCI
> > Express Capability offset on first use once confirmed via a DBI read-back.
> > 
> >> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> >> index 6d788aa000117..dede6b3966585 100644
> >> --- a/drivers/pci/controller/dwc/pcie-designware.h
> >> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > [ ... ]
> >> @@ -832,6 +834,42 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
> >>   	dw_pcie_writel_dbi(pci, reg, val);
> >>   }
> >>   
> >> +/**
> >> + * dw_pcie_get_pcie_cap() - Return the PCIe Capability offset
> >> + * @pci: DWC instance
> >> + *
> > [ ... ]
> >> + * Return: the offset of the PCIe Capability, or 0 if it could not be
> >> + * found or has not been confirmed yet.
> >> + */
> >> +static inline u8 dw_pcie_get_pcie_cap(struct dw_pcie *pci)
> >> +{
> >> +	u8 cap = READ_ONCE(pci->pcie_cap);
> >> +
> >> +	if (!cap) {
> >> +		cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> >> +		if (cap && dw_pcie_readb_dbi(pci, cap) == PCI_CAP_ID_EXP)
> >> +			WRITE_ONCE(pci->pcie_cap, cap);
> >> +	}
> >> +
> >> +	return cap;
> >> +}
> > 
> > [Severity: Medium]
> > In drivers/pci/controller/dwc/pcie-designware.h, the kernel-doc for
> > dw_pcie_get_pcie_cap() states that it returns 0 if the capability could not
> > be found or has not been confirmed yet.
> > 
> > However, when pci->pcie_cap is 0 and transient DBI data causes
> > dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to return a non-zero offset cap
> > while the confirmation check dw_pcie_readb_dbi(pci, cap) == PCI_CAP_ID_EXP
> > evaluates to false, pci->pcie_cap is left as 0, but the unconfirmed non-zero
> > cap is still returned to the caller.
> > 
> > Callers that guard DBI writes on a non-zero return (such as
> > rockchip_pcie_enable_l0s()) or cache a non-zero return in driver state (such
> > as tegra_pcie_dw_host_init() setting pcie->pcie_cap_base when
> > !pcie->pcie_cap_base) will then consume or permanently store the unconfirmed
> > offset.
> > 
> > Should dw_pcie_get_pcie_cap() return 0 when the confirmation read-back fails,
> > or should the kernel-doc comment be updated to match the implementation?
> > 
> 
> Hi,
> 
> We have already replied to Bjorn before. According to the specification, 
> the value of pcie_cap is not equal to 0.
> 

Then please update the stale the kernel doc.

- Mani


