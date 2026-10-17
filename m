Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29522C08BB;
	Sat, 17 Oct 2026 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792225892; cv=none; b=Ev4lnbtlRMZrUPRnLD8NgDmxiNAEzaroEwR8H9CqYg9uUJ35RbarWEJrtKB6Ipg2NPYXBC4Y6ZoFbwRpTNJQGj7kLbFUAF6YVLdU46CmFlJ45vB/Xq3H9tZlKIhmHkBLyOxzqV7sKHdmGi1ZmITZ5hX5LRQGxEr+C9G3MXQcl1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792225892; c=relaxed/simple;
	bh=jeBxCl2P2JBq8fDTaLsKS8V4jwX3hMOh4W+CK6/Rqrs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C914bRnbOM+/c5a/zS54aOeyxveSv9A0qMb2+HEhVWn/mHs8HcdRFoQ3YJkQLHw+aTbyjfwSPf69egJW80NMwLmc2Ln6e0EpQJF0Tk2Pm5i33/VuWUPSxmcTrXEDOR8852S7Pu9IUeGkH8uk3XSF0U+KcBnXvUEFmbcypHRWw9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrAVBPGI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrAVBPGI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961891F000C4;
	Sat, 17 Oct 2026 08:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792225891;
	bh=m/qG+13/JAWFKrWg58cEv1zPZ2YQ/I0kh3SMj8RX9jk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=IrAVBPGIObh0ti9ko3T/Ip53yrUNcDef3GbjVBcvZ4VtTsd5HsnqMd3L4tVArdUEo
	 pje6RLnB2RdX3clTSB1grBDv1icIcHwVtZsWp/sh4aDssG4PzvpssNrF0A/BEhBncB
	 lnulZ6ih+jzVs8i+Ms6MbzZQXS1UNHk1ybRg7EmVNGtoNMLjtPToWjcqW1NURK3uC5
	 69/fXfZuUFKQrt4a+SW51pmrWImxGm4FmJJ42XN2Vuhk/FdGmB14CjvRzX1TN7wn1P
	 h3Phaws5XRZ4OySpIyJdJs7VWAa3yjk02xNAedjzf7eHfRlT7Zg85UgtmVoIWE59gv
	 NaIDnzjr0osXg==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, ntb@lists.linux.dev, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261015014402.2976188-1-den@valinux.co.jp>
References: <20261015014402.2976188-1-den@valinux.co.jp>
Subject: Re: [PATCH v5 0/2] PCI: endpoint: pci-epf-vntb: Honor MSI-X
 selection
Message-Id: <179222588612.13649.17398609900846308858.b4-ty@b4>
Date: Sat, 17 Oct 2026 14:01:26 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0


On Thu, 15 Oct 2026 10:44:00 +0900, Koichiro Den wrote:
> This small patch set fixes vNTB ignoring the host's MSI-X selection. On
> endpoint controllers that expose an MSI-X capability, such as RK3588,
> ntb_hw_epf can select MSI-X, but pci-epf-vntb still configures and
> raises MSI. When MSI-X is selected, doorbell interrupts are not
> delivered, and the host may report IOMMU faults if it's enabled.
> 
> The fix allocates space for the MSI-X Table and PBA in a BAR, using an
> EPF-owned layout. This brings vNTB in line with other EPF
> implementations, such as pci-epf-test and nvmet-pci-epf.
> 
> [...]

Applied, thanks!

[1/2] PCI: endpoint: pci-epf-vntb: Use a local epf pointer in interrupt setup
      commit: 17c4115cbe99da4d147aee778c308da1d4bb000d
[2/2] PCI: endpoint: pci-epf-vntb: Honor MSI-X selection
      commit: a5401ce3ab2356b7861f53d09205008b7a49d57e

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


