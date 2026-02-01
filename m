Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E1925D208;
	Sun,  1 Feb 2026 21:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769981828; cv=none; b=SgWu8w3WfvzxdRSGL+1XRyuA7WV0KUNtkKNjKx9P9M74zXGCGQnqk8QKySol+AW9jsIKBT5wXZ3z5ulzrpNKFfxt1lfQ2oANfrVjSu2ufvk6Rcll3RFEt/oTuo0gJ0QnlSDEJQoZyg8aSQuQAt4FnYYcSyWt82sx5TRLqyXaom4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769981828; c=relaxed/simple;
	bh=RaKifv2Ybw3l59lFCL8pABkWEWoRnwbJe6wnLIcawM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+VXbZjTwglkV8rmnROTosmeeQGzL+byo5rmEkACb6N9gXleQs01fr63xEutFeNKmaOlusyEqyPzBrWT1ewgIIZeZhhYVWiiOFi7lcIwK7aJrx9eORkZZXCEXYZGRx25t9nd3Wa7pvyutRrUUNM6CRFiR9sp6AUgsSFoZ2KdpZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnEaNuKv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnEaNuKv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CA7C4CEF7;
	Sun,  1 Feb 2026 21:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769981827;
	bh=RaKifv2Ybw3l59lFCL8pABkWEWoRnwbJe6wnLIcawM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GnEaNuKvRwitQZMuVpwpu6sXmui4TXjkhdnK9Q69DCegR6lH8UKrOt1YQPvi3J8SK
	 c6ICNnbR3IuDwlIm+pzDfvawdbrmfyRdyWmXAMM3FxwOHPH+3V29gqAxXb/XuzD64a
	 3+B0JSRUYNe4f61vCgTLXcixQ4/thvjpjco15UAAqol9hiE+B3Pi+ujMKKUNgC2Wd4
	 vJxFv1/sh3qj6tEwlzFKsbY+9QGonSfPsbSc86xfdLFeaetfAvlmg8mQdjxfoaPPFG
	 kTSvnAH1LsuQDLpNdJ/A6TBKhLMuscbMIXsLti5PJRtHVZIutPuSCBmVUYSIVVnoH9
	 fSqVvkp34X4Zw==
Date: Sun, 1 Feb 2026 22:37:02 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, jingoohan1@gmail.com,
	lpieralisi@kernel.org, robh@kernel.org, Frank.Li@nxp.com,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: endpoint: Document pci_epc_set_bar() caller
 ownership and lifetime rules
Message-ID: <aX_HfpBoQX4j7mag@ryzen>
References: <20260131133655.218018-1-den@valinux.co.jp>
 <20260131133655.218018-4-den@valinux.co.jp>
 <aX4y3txKcYmb-kE3@fedora>
 <4erlj426nvmilwfdq5e63ojiqecomcpj35nvmiyw2p5mvifwlt@yspmfxrzmxei>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4erlj426nvmilwfdq5e63ojiqecomcpj35nvmiyw2p5mvifwlt@yspmfxrzmxei>

On Mon, Feb 02, 2026 at 12:45:52AM +0900, Koichiro Den wrote:
> For example, epf-vntb initializes BARs via pci_epc_set_bar() with phys_addr
> = 0 [1], and later updates the same ntb->epf->bar[barno] fields in-place
> and calls pci_epc_set_bar() again [2] via the .mw_set_trans callback:
> 
>   [1] https://github.com/torvalds/linux/blob/v6.19-rc7/drivers/pci/endpoint/functions/pci-epf-vntb.c#L710
>   [2] https://github.com/torvalds/linux/blob/v6.19-rc7/drivers/pci/endpoint/functions/pci-epf-vntb.c#L1288
> 
> So, if [PATCH 3/3] is the contract we can agree on, then I think epf-vntb
> would likely need an adjustment to follow that contract (i.e. avoid
> mutating the descriptor that might still be referenced by the EPC, and
> instead switch to a different instance when updating). In that sense, the
> code alone seems not always to speak for itself at the moment, and having
> the agreement documented would still be valuable for future EPF
> implementations.

You are absolutely right!


The pci-epf-test code that uses a difference instance was made by:

commit eff0c286aa916221a69126a43eee7c218d6f4011
Author: Frank Li <Frank.Li@nxp.com>
Date:   Thu Jul 10 15:13:52 2025 -0400

    PCI: endpoint: pci-epf-test: Add doorbell test support


The pci-epf-vntb code that uses the same instance was made by:

commit e35f56bb03304abc92c928b641af41ca372966bb
Author: Frank Li <Frank.Li@nxp.com>
Date:   Tue Feb 22 10:23:54 2022 -0600

    PCI: endpoint: Support NTB transfer between RC and EP



The dynamically update inbound address support in the DWC driver itself
was made by:

commit 4284c88fff0efc4e418abb53d78e02dc4f099d6c
Author: Frank Li <Frank.Li@nxp.com>
Date:   Tue Feb 22 10:23:52 2022 -0600

    PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address



I don't know why Frank chose to use the same API in two different ways.
Perhaps because in pci-epf-test.c he needed to be able to restore the
BAR to the original state when calling DISABLE_DOORBELL, but in vntb
there was no need to "restore" to the original state.


So, perhaps we should allow in place updates after all...
Frank, thoughts?


Considering that struct pci_epf_bar lives in struct pci_epf, I think my
previous idea of doing a kmemdup, seems wrong...

I think you are right that in place updates do make sense in one way...
even if it can mean that the current safe guards can by bypassed..

However, if you modify the struct pci_epf_bar in an incompatible way,
before calling set_bar() or clear_bar(), it is your own fault...


Considering that pci-epf-vntb does in place updates... we probably should
allow in place updates as well... As you suggested a few days ago:
https://lore.kernel.org/linux-pci/q5e7ydmf4ra6x2mbxwifovgr6p6x5dfnz3hz5psq5ypyabtsvx@oq5ovi4o26yf/

I'm sorry for changing my mind. I did not know that there were any
EPF driver that already did in place updates...

I did look at how pci-epf-vntb handled doorbells, but it called either:
epf_ntb_db_bar_init_msi_doorbell() or uses polling, but in either case
it never seemed to call set_bar() twice (at least not to set the doorbell),
so as far as saw, it did not do in place updates.

Considering that we probably want to support in place updates after all...

I guess we probably only need patch 1/3 in this series, plus another
patch that makes sure that we call dw_pcie_ep_clear_ib_maps() unconditionally?

I still don't like that dw_pcie_ep_clear_ib_maps() will be called
unconditionally, but I don't see any other way to support in place updates...

I'm sorry for making you waste time. I did miss that even though pci-epf-vntb
does not do in place updates of doorbell BAR, it does so for the other BARs.


Kind regards,
Niklas
