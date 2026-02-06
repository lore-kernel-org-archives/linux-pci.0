Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15763101DC;
	Fri,  6 Feb 2026 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770403852; cv=none; b=NPsewNB6IKHZyME1+Nr+maKiy60B2a1N7OpvHNbhgdTOuUJVwExyNKAEurhKjA5Yb/Zuh74xMpEFio2GCdhmMdWNahC6iiwuGdHx6fXtAYDj7lcyou5tJPsKtXduP+XUhw8HlmAYL4dX083pnMdHCtnpCze1Lu5K+vSivC/xi5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770403852; c=relaxed/simple;
	bh=b7gJhLGTQ+HWX3NqvexmNOefuii7am5PdYARZew9KYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sj9lWG/6yiPHqVcMpN6ZFzfe9SPjZbiTMmYX6abTFSPCNVS2QOLkkZ2qzc3Cf3qvt+pSgi8uAVgMrXtmO3wlOPrtGZRVDZ0xfbVKARHihKsBErRqFKwmecLHFRt2sn8RK9PWnVlWDO3/20OQFlcz+6evlEd3XLmA03+rPxptgSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxyFKwXv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxyFKwXv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65AEC116C6;
	Fri,  6 Feb 2026 18:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770403852;
	bh=b7gJhLGTQ+HWX3NqvexmNOefuii7am5PdYARZew9KYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pxyFKwXv3EXlR14/QVX/sB5KZArfRSp/u+NjNOKonYduh9rZYZjVW/wM4vwGUGD3/
	 BBb/ShMIsOjQJA1l028syRDH/+h9oHvuWmVOw81TYTp1Kr4NPAbbwT1P4YMf4MOCXf
	 xe7BtcDR5LDNN1l5TScoP/Lu5bfZLrckjXP06E1okP1MplqETJKchVMy+b/t7H/lZg
	 mmCMgSB5p6vMOM8+WD24lMbVZyQQFx7k1tS75R7oqwYMmlMVqPyxA7t6wLqeMBtShF
	 BsZH8BvQRB3B/G4HWFXRteldoZb4z7rljLPM/VdefSYDLweEvvfTpieDqqHkE/JO4q
	 CFLsaWxkbxWMQ==
Date: Fri, 6 Feb 2026 11:50:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, dcostantino@meta.com, rneu@meta.com,
	kernel-team@meta.com
Subject: Re: [PATCH] PCI/AER: Add option to panic on unrecoverable errors
Message-ID: <aYY4CSsUVrUtrLoH@kbusch-mbp>
References: <20260206-pci-v1-1-85160f02d956@debian.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206-pci-v1-1-85160f02d956@debian.org>

On Fri, Feb 06, 2026 at 10:23:11AM -0800, Breno Leitao wrote:
> When a device lacks an error_detected callback, AER recovery fails and
> the device is left in a disconnected state. This can mask serious
> hardware issues during development and testing.
> 
> Add a module parameter 'aer_unrecoverable_fatal' that panics the kernel
> instead, making such failures immediately visible. The parameter
> defaults to false to preserve existing behavior.

Sounds like a good idea. There used to be a code comment suggesting
there are probably conditions where you want this panic behavior but it
was removed with commit:

  b06d125e6280603a34d9064cd9c12748ca2edb04

Which I'm not sure was an accurate thing to do as it assumes the system
can remain operational without recoverying, and that's just not always
the case.

> @@ -73,6 +73,9 @@ static int report_error_detected(struct pci_dev *dev,
>  		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
>  			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
>  			pci_info(dev, "can't recover (no error_detected callback)\n");
> +			if (aer_unrecoverable_fatal)
> +				panic("AER: %s: no error_detected callback\n",
> +				      pci_name(dev));

Is this the only condition that the panic behavior should apply? I feel
like we may want to defer the panic to the recovery failed case and even
include the "disconnect" condition. Maybe something like this?

---
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index bebe4bc111d75..c5a631e2b565b 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -295,5 +295,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	pci_info(bridge, "device recovery failed\n");
 
+	if (aer_unrecoverable_fatal &&
+	    (status == PCI_ERS_RESULT_DISCONNECT ||
+	     status == PCI_ERS_RESULT_NO_AER_DRIVER))
+		panic("AER: can not continue, status:%d\n", pci_name(dev), status);
+
 	return status;
 }
--
