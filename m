Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5E2370D49;
	Fri, 13 Mar 2026 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410156; cv=none; b=iMbOBB+LpXa5aRY4ipsyCAAsPwr9LmqMuoTXBD65Z2lzbOzbB2I3K2FC0qr6e2syEWklHbpP4uH6o8T9ZcAGwXwK1WqTL3M5T2cf2+FIsc2OBH6prghxUGR/4jL95bYioucSlOndQzbc1j6e3YTEfaBD4ngVMwEsdjGE4AvW1bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410156; c=relaxed/simple;
	bh=qCnei2hJ4tbYI/448XNR+gkx4fBz015KywP3+urQo8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzrCCobeG66DhYEqe2SFQ4fkSP+rCj0iV64G0Iam0vayM53F60uPR0f/68pGGB1lazr6ot00EOzyD0VYTKd2TZjhsmXg+tlC5T40/BzcBvVJ+H9C1foKM7g4uJhwXV9LeEr3W9Vlj0mWY0HRchEoIQopG8O+mF9JzkFnru38xqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifam778/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifam778/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396FBC19421;
	Fri, 13 Mar 2026 13:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773410155;
	bh=qCnei2hJ4tbYI/448XNR+gkx4fBz015KywP3+urQo8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifam778/BZrTiFlIY4B9luRsWK514ihjseG6gpfygZR3kFYwxmIFg04IxRFvK/ZQV
	 7vtybKmLJiEwhjQpjB09T/Wr945UmEpkc1OjeH2kLaUem0m9LR9FUGxVY1/8wiSAqx
	 PiiuqOy+wTzSiFcqWiLec/LqRMBRZlnnCMBBaTMj0jEYMz21Cukxm41loRpD/BlmDc
	 RfkTJ14I1RK6I/XW71UyHtbLui0Ek7LpRmgwGiz0/5/L/v/8pXuXeZFRDPOfhURxSC
	 NQ2ux3tM3eIdm91Csr1Wvsj0ho7mjKhe76NDkPKQ2pUYwoLFtm9xlFptjs9bH2llMI
	 caWXOmn8WuTYg==
Date: Fri, 13 Mar 2026 19:25:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: zhangsenchuan <zhangsenchuan@eswincomputing.com>
Cc: Min Lin <linmin@eswincomputing.com>, bhelgaas@google.com, 
	krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	christian.bruel@foss.st.com, shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com, 
	thippeswamy.havalige@amd.com, inochiama@gmail.com, Frank.li@nxp.com, ningyu@eswincomputing.com, 
	pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com
Subject: Re: [PATCH v11 2/2] PCI: eic7700: Add Eswin PCIe host controller
 driver
Message-ID: <veqgbspu5fmm6f4dvrtz5s6xtibbglf6ejb4b6zzmzhgefksny@rzuobvk6jkt7>
References: <20260227111536.1940-1-zhangsenchuan@eswincomputing.com>
 <20260227111808.1996-1-zhangsenchuan@eswincomputing.com>
 <jd4aszup2peetymesiltqghoptp2w4uuecrsdzkb2cl5vqqfot@m3vh6x4u5t6l>
 <57246067.3de3.19cbd03fc5f.Coremail.linmin@eswincomputing.com>
 <twvubrxemm7nx2i5p65byehj7y2g43c5esq3go72t6qbsz7yal@dxwvslzvgdc5>
 <597765c6.41f9.19cdc76ffa4.Coremail.zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <597765c6.41f9.19cdc76ffa4.Coremail.zhangsenchuan@eswincomputing.com>

On Wed, Mar 11, 2026 at 06:35:12PM +0800, zhangsenchuan wrote:
> > > > Subject: Re: [PATCH v11 2/2] PCI: eic7700: Add Eswin PCIe host controller driver
> > > > 
> > > > On Fri, Feb 27, 2026 at 07:18:08PM +0800, zhangsenchuan@eswincomputing.com wrote:
> > > > > From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> > > > > 
> > > > > Add driver for the Eswin EIC7700 PCIe host controller, which is based on
> > > > > the DesignWare PCIe core, IP revision 5.96a. The PCIe Gen.3 controller
> > > > > supports a data rate of 8 GT/s and 4 channels, support INTx and MSI
> > > > > interrupts.
> > > > > 
> > > > 
> > > > Is the driver going to work only for the PCIe RC IP in EIC7700 SoC or for the
> > > > upcoming Eswin SoCs as well? Just curious because, we don't name drivers based
> > > > on one SoC name, but by the vendor so that the driver (if compatible) can be
> > > > used across other SoCs from the vendor.
> > > > 
> > > > If it can work across other SoCs, then I can change 'eic7700' to 'eswin', where
> > > > applicable while applying.
> > > > 
> > > 
> > > This PCIe RC IP in EIC7700 will only be used for EIC7700 SoC. One thing for sure
> > > is our next SoC will use a higher IP revision of the DesignWare PCIe core.
> > > In the future, there is no doubt that the use of IP from other manufacturers may
> > > be considered.
> > > 
> > > Based on this, may I ask which name do you think is better, eic7700' or 'eswin'?
> > > 
> > 
> > I'd suggest going with just 'eswin'. If the future revisions come up with
> > non-dwc based IPs, we can name them appropriately.
> > 
> > > I found there is a commit on drivers/pci/controller/dwc/pcie-tegra194.c
> > > It added Tegra234 PCIe support in pcie-tegra194.c
> > > Is this naming approach no longer recommended?
> > > 
> > 
> > Yes, that predates my time with host controller drivers. I strongly suggest
> > naming the drivers based on vendors or family to avoid creating an impression
> > that the driver only supports one SoC version.
> > 
> > Since you agreed for renaming, I took the liberty to do the change myself and
> > applied the patches. I also added the maintainers entry. Please take a look at
> > the commits and confirm if everything is OK:
> > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/dwc-eswin
> 
> Hi Mani,
> 
> Thank you very much for helping me change 'eic7700' to 'eswin'.
> 
> I have verified that the code functions are intact. However, there are a few areas
> that require your assistance to incorporate and make necessary modifications. 
> After the modifications, I believe you can incorporate it.
> 

Done:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc-eswin&id=cbbe59fa04b5d9f8e11138df4591653f7d2f8351

I also removed PROBE_PREFER_ASYNCHRONOUS flag since there appears to be a
possibility of a race condition with some endpoint drivers. We will add it in
some other form later.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
