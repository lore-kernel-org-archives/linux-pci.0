Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8CC3806A9;
	Wed, 21 Jan 2026 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987637; cv=none; b=bVJzijbCNq0nRDe0UD1Rtgq0FSOK5mwyfmngTp9VHr+PGsQnybX5DJlT9Z8Sw7QXg0jEhvsGNZ6MrHCHV3lIMcYjoXxiXEoHsBDx5gQ66wQms5K78TApUTC5Uh+GRx7E/nUYWjErnlWdBrOdE2ZQiSL2azn6JRnqnHZTbS963Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987637; c=relaxed/simple;
	bh=dcVTujjScY6q9S/PLU2WuZf5mfkBME+L/r/kOqnFwPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIvKlDDXg6i0ECIutG1IP2Nuz0KBPSCF78Y7WfYeChODNUF5tZZhVTAINgzu9B9h3ArDnlMzCG5Nc+bwAoTOO/F+rJSqt27z7N9jTN0NjtqwFTp4y9JKApxPaTBrCE9g+LKxeS8f1vWccirY3JHofvXQGqlqLrNOhjoHKmHQJ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0jWFA+X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0jWFA+X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAD8C116D0;
	Wed, 21 Jan 2026 09:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768987637;
	bh=dcVTujjScY6q9S/PLU2WuZf5mfkBME+L/r/kOqnFwPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C0jWFA+XIbPTMqJCjOJIJEIB1TSVrF+J35vaeXaqidtYaxLXR/LnjGzhcN6Je7sYn
	 qliUPPU87L9T95bRZfEda4catebuIq3LZdLF0hi0eGKD6/neUKK/Bi9LaECSYRaukd
	 fxYJK6CE0a0J5ws/kBEyp+xODVztCXu3a/++wPLclWdG2WVKApBxM4OK/nx5Cbl7ao
	 fztCmCE+TJYyFsRG+Hi9HlJqQZBDlIjMiNWUAP2shmv6Es5ZYm/foUvmdQDDX2FXdU
	 wZhfZKS2GU1Mb7CXjdM6SiZ0rQqDtovzr9d5dj0Obx0iUTahGB32Y9srG9DsYmqXRR
	 In/0l48QgVZ/Q==
Date: Wed, 21 Jan 2026 10:27:12 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, linux-kernel@vger.kernel.org,
	s-vadapalli@ti.com, danishanwar@ti.com
Subject: Re: [PATCH 0/2] PCI: dwc: ep: Enhance multi-function endpoint support
Message-ID: <aXCb8MFYKs43XVPH@ryzen>
References: <20260121054214.274429-1-a-garg7@ti.com>
 <aXCTbb-0BWAWc2DB@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXCTbb-0BWAWc2DB@ryzen>

On Wed, Jan 21, 2026 at 09:50:58AM +0100, Niklas Cassel wrote:
> On Wed, Jan 21, 2026 at 11:12:12AM +0530, Aksh Garg wrote:
> > This series addresses multi-function endpoint configuration issues in
> > the DWC PCIe controller driver. The changes enable proper operations
> > for physical functions and enhance the multi-function endpoint support.
> 
> 
> Considering that the DWC driver design has always been broken with regards
> to multiple physical functions, as you explain yourself, the iATU to BAR
> mapping has always been per controller, not per PF.
> 
> Thus, it would be nice if you explained how you have actually tested this.
> 
> Does the controller you are using have both Resizable and Programmable BARs?

If your PCIe controller supports multiple PFs, as you might know,
while:

const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
                                                       u8 func_no, u8 vfunc_no);

takes both a PF and a VF...

dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
ignores both of these parameters and simply call:
ep->ops->get_features(ep);


For each PF in your controller, do all BARs have the exact same definition?

e.g. all BARs for each PF would need to have the same type, e.g. if BAR0
is FIXED, BAR1 is programmable, and BAR2 is resizable, with the current
design of dw_pcie_ep_get_features() that would need to be the case for all
PFs.


Kind regards,
Niklas
