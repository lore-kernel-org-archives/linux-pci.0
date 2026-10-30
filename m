Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356212;
	b=hqvw6dOXGPyT1a4BdhqAvb6s7EviBdNK+r8pmjRVfPbIzEl3ZaEJVnmaMX3q2zhkY/3j
	 pX9cGQRJ399fSGZEGXaeOlvKGS3LvOvVAk7xPF5P6XbXc5Cv98Zma2yi49hYrJHUWhbQa
	 eQNqQ5oUZO6+c0/5n/PFChm4sQW12XdnxbTGNQXir6BTEnL7ORjQCR8EgCmerQlbxDWiB
	 9MDwGpZQ9YGO0I+0csh0RxuIDianwJbKW35i/yT+k+prjpqFLp13G6fJlYofbHTvw5tKg
	 Qr5Q2KhlRheRtkCZy/wCfIbAmoBcsTCQ70vNS0T0FgAvU7IIXggj/NOFNY+nzwIR6qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356212;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=3fqnYaEbIgdfSP54xBXP5ElKx2MmI5fRYIIKmYlYSIo=;
	b=phXo9kMG9e6L04BAad+7B1VI+0d2IOr1GlSniqCCbd3t7Z3u8vHHC9wg/jW809wPGix3
	 g8VTcDj4ycYThKCjVglt1QV4BUBTQktBnYmwAv5czWj0bhYSr0c8IaCJvDdwV7isayLoa
	 qjVmYQ8T/u7DCxJPxeRIk/59EoaRZJXqUO2KQvqOlmeh+zhfD9bjnd+AbPRA2cu2Ga5QI
	 yXqMdzNuO95MVGLb7EfBNdxuq6dnZmyc+JU5S1FGKD9yD1P1i6RcplmnrI4VqZaGMIBMh
	 q4j5N4JNOpx2PKP/kug9Q7eQmwlN6Jp0GSxCSNsnDg62MdmT1O7KQmVnK3YbJZTOgcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e2QV4jF3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C232606A330;
	Fri, 30 Oct 2026 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e2QV4jF3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B661F0093A;
	Fri, 30 Oct 2026 10:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793356212;
	bh=3fqnYaEbIgdfSP54xBXP5ElKx2MmI5fRYIIKmYlYSIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e2QV4jF3barcO0lZS1tbyQ1khPVcnTcl2rLOCfpGPGJ1R1sAniZooDlhazq1Cfcda
	 Yzrfik5CNQ0ORuxCjfSjB3qJKW1Qq846YjHKgVk/0bIOzJAZYUWoPG5hi0gRMcT9tJ
	 rADcsutQlje6H/VwFY3AOZmOGjN/oXpnLU5ea4tBWvPLQ8O5pqilhnNieuc+13HfCl
	 wGkL3bIVqVq1RO5tKWfLIhXbBrGmo7a8UaKIxGeLADcXkglNPbf0UqThg2kMJfWipK
	 55Qx+vM465ZI2pXzoISldQEGIhAylVWyFYKLuPFE894UGLXTHCCL6rRlD7Ur2Nkn/u
	 ikr3HEgZFqiOA==
Date: Fri, 30 Oct 2026 11:29:53 +0100
From: Manivannan Sadhasivam <mani@kernel.org>
To: Franz Schnyder <fra.schnyder@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com, 
	Shawn Lin <shawn.lin@rock-chips.com>, Richard Zhu <hongxing.zhu@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v4 0/6] PCI: dwc: Rework the error handling of
 dw_pcie_wait_for_link() API
Message-ID: <wbjfuucq3na6ld6l64cbvs4ee7kthyqrxxln73bgr53r6b6uyt@wv5lwgb3hawd>
References: <20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com>
 <wsrntkojtitvhprw7q5sabqcvih24mpfwiwiq5e4fg6d2tkixs@6q2vtdfo4shr>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <wsrntkojtitvhprw7q5sabqcvih24mpfwiwiq5e4fg6d2tkixs@6q2vtdfo4shr>

On Tue, Oct 13, 2026 at 11:15:28AM +0200, Franz Schnyder wrote:
> On Wed, Jan 07, 2026 at 01:41:53PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > Hi,
> > 
> > This series reworks the dw_pcie_wait_for_link() API to allow the callers to
> > detect the absence of the device on the bus and skip the failure.
> > 
> > Compared to v2, I've reworked the patch 2 to improve the API further and
> > dropped the patch 1 that got applied (hence changed the subject). I've also
> > modified the error code based on the feedback in v2 to return -ENODEV if device
> > is not detected on the bus and -ETIMEDOUT otherwise. This allows the callers to
> > skip the failure if device is not detected and handle error for other failure.
> > 
> > Testing
> > =======
> > 
> > Tested this series on Rb3Gen2 board without powering on the PCIe switch. Now the
> > dw_pcie_wait_for_link() API prints:
> > 
> > 	qcom-pcie 1c08000.pcie: Device not found
> > 
> > Instead of the previous log:
> > 
> > 	qcom-pcie 1c08000.pcie: Phy link never came up
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> > Changes in v4:
> > - Skipped returning failure during resume as well if no device is found
> > - Link to v3: https://lore.kernel.org/r/20251230-pci-dwc-suspend-rework-v3-0-40cd485714f5@oss.qualcomm.com
> > 
> > Changes in v3:
> > - Dropped patch 1 that got appplied
> > - Reworked the error handling of dw_pcie_wait_for_link() API further
> > - Link to v2: https://lore.kernel.org/r/20251218-pci-dwc-suspend-rework-v2-0-5a7778c6094a@oss.qualcomm.com
> > 
> > Changes in v2:
> > - Changed the logic to check for Detect.Quiet/Active states
> > - Collected tags and rebased on top of v6.19-rc1
> > - Link to v1: https://lore.kernel.org/r/20251119-pci-dwc-suspend-rework-v1-0-aad104828562@oss.qualcomm.com
> > 
> > ---
> > Manivannan Sadhasivam (6):
> >       PCI: dwc: Return -ENODEV from dw_pcie_wait_for_link() if device is not found
> >       PCI: dwc: Rename and move ltssm_status_string() to pcie-designware.c
> >       PCI: dwc: Rework the error print of dw_pcie_wait_for_link()
> >       PCI: dwc: Only skip the dw_pcie_wait_for_link() failure if it returns -ENODEV
> >       PCI: host-common: Add an API to check for any device under the Root Ports
> >       PCI: dwc: Skip failure during dw_pcie_resume_noirq() if no device is available
> > 
> >  .../pci/controller/dwc/pcie-designware-debugfs.c   | 54 +---------------
> >  drivers/pci/controller/dwc/pcie-designware-host.c  | 23 +++++--
> >  drivers/pci/controller/dwc/pcie-designware.c       | 75 +++++++++++++++++++++-
> >  drivers/pci/controller/dwc/pcie-designware.h       |  2 +
> >  drivers/pci/controller/pci-host-common.c           | 21 ++++++
> >  drivers/pci/controller/pci-host-common.h           |  2 +
> >  6 files changed, 115 insertions(+), 62 deletions(-)
> > ---
> > base-commit: 68ac85fb42cfeb081cf029acdd8aace55ed375a2
> > change-id: 20251119-pci-dwc-suspend-rework-8b0515a38679
> > 
> > Best regards,
> > -- 
> > Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> 
> Hi Mani,
> 
> Is there any reason patches 5 and 6 were never applied?
> 

Bjorn had concerns about patch 6 as it didn't handle the case where a device can
get attached during suspend. So I dropped patches 5 and 6. Too bad that I didn't
mention this reasoning in LKML, sorry about that.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
