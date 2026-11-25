Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795564898;
	b=vyRyzdt2vi2OvktFP84aO1xgy0Gfb3JDagRhzWiHEeRP+oAG9sJjW1gfQ7x4z22av/61
	 YmTzh2b8/q2VApGcPj6VLJrqkN1t/x5f0TyjXPlQUt2QlKniUwvMWefNLfUG0gQ/72gX2
	 uKkWMxpVOi9NnXCW+lepWxSGN4r+PVM6nFKwSknmRHx/V5MjEbn3/tr6t6qIytg60BPq4
	 nmv5nYhWdQH6n1cQKUP8pOQH7DyK1YWWYWVsaRppjDpeYZI5D7eWsr9Y+0DK26ncx3CRS
	 T/IGDMVZ4Dzz2VdiBkqQxG7Pe4hKMwJxmbPFz6/5o86zIYRQ/hM7QPfuDagIZE23eGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795564898;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=t0o4zYuR5JjkPQPydcYj5itA0swFE+//OOXlRttRo+U=;
	b=mVK2Ag5x+6GwGcX+QT5kjpBs2YF6e8r/ey8+T5/AFQMirvtKI1yMYfGk7Bm48vGuHFrP
	 JWhZP7QKeQ3u4pGali3fzqurdelrFCLr1gKCtV1V/RO5XT0JlhKRcy4t31m3p7lKqueKK
	 5gvjh8HTrgl0rs++qZLNHD65EiMhHwBnLXhvWK3QhcyvT6Izng0j6ELyes0RJ7x1FGnRE
	 7Aayieb8Eq80REl4TzQtacSYpn8/g4iZsC4o+QNKmsyhJYLKONnOtGq5hyXNDtsxYZVfd
	 WgcoZLrJG1q3EKyOwI14vcNry/7MqfFFgHmlGi/cQCWamE9sD41N5Ees/fJekrp9Z5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HLy9KbFN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE8B606A31E;
	Wed, 25 Nov 2026 00:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HLy9KbFN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBC81F000C0;
	Wed, 25 Nov 2026 00:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795564897;
	bh=t0o4zYuR5JjkPQPydcYj5itA0swFE+//OOXlRttRo+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=HLy9KbFNBD7FHa5dm66XLgrEGjrOfKDP/pOs2V/mrgXGeZ6s9BqU03EVpKBggHwZ4
	 IL4LqA8lz5RfIDUAtnijQS9+A55OZJMKy5qf4Dbz99s6L2U8k4DXlDqv5VheNP+ulR
	 DTTQgQbH04AWci0mC7NbpgxQ0R8n/olyNoz4dVUForHoYcZx4TY4xMbiNyDOgz65Eg
	 hVY1prhYEnIx3GYzvnDcXOZv1or0IBmRxcvkvY70YKsp/aPPU6SnYvGjsmhgBxT7Ns
	 mV8/wCNi7z+z3h+9bCb7tfMUzBTNqSz8BIutVqedlGSKorVZ5YrxsQTeUhKB16bsbk
	 dUeIwPWVGMlqg==
Date: Tue, 24 Nov 2026 18:01:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gokulkrishna Sekar <gokulkrishnasr@gmail.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	mika.westerberg@linux.intel.com, linux-kernel@vger.kernel.org,
	Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: Re: [PATCH] PCI: Correct PCIe port type field encoding
Message-ID: <20261125000136.GA1191322@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124084828.15318-1-Gokulkrishna.Sekar@harman.com>

On Tue, Nov 24, 2026 at 08:48:28AM +0000, Gokulkrishna Sekar wrote:
> set_pcie_port_type() validates PCIe port topology and corrects
> invalid upstream/downstream port type information in the cached
> pcie_flags_reg value.
> 
> When performing these corrections, the code updates
> PCI_EXP_FLAGS_TYPE using PCI_EXP_TYPE_UPSTREAM or
> PCI_EXP_TYPE_DOWNSTREAM directly. The PCI_EXP_TYPE_* values are
> decoded port type numbers, not values encoded for the
> PCI_EXP_FLAGS_TYPE bitfield, so the corrected type is stored in the
> wrong bit position.
> 
> As a result, a device whose type has been corrected may subsequently
> be reported as PCI_EXP_TYPE_ENDPOINT instead of the intended
> upstream or downstream port type.
> 
> Use FIELD_MODIFY() to update PCI_EXP_FLAGS_TYPE so the corrected
> port type is encoded consistently with the format used in the PCI
> Express Capabilities Register.
> 
> Fixes: ca78410403dd ("PCI: Get rid of dev->has_secondary_link flag")
> Reported-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> Link: https://lore.kernel.org/all/20241213070241.3334854-1-gthiagarajan@marvell.com/
> Signed-off-by: Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>

Applied to pci/enumeration for v7.5, thank you!

> ---
>  drivers/pci/probe.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 9a178e0e5f7f..4c7e0ad1aa1a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1673,8 +1673,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  		 */
>  		if (pcie_downstream_port(parent)) {
>  			pci_info(pdev, "claims to be downstream port but is acting as upstream port, correcting type\n");
> -			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
> -			pdev->pcie_flags_reg |= PCI_EXP_TYPE_UPSTREAM;
> +			FIELD_MODIFY(PCI_EXP_FLAGS_TYPE, &pdev->pcie_flags_reg,
> +				     PCI_EXP_TYPE_UPSTREAM);
>  		}
>  	} else if (type == PCI_EXP_TYPE_UPSTREAM) {
>  		/*
> @@ -1684,8 +1684,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  		 */
>  		if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
>  			pci_info(pdev, "claims to be upstream port but is acting as downstream port, correcting type\n");
> -			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
> -			pdev->pcie_flags_reg |= PCI_EXP_TYPE_DOWNSTREAM;
> +			FIELD_MODIFY(PCI_EXP_FLAGS_TYPE, &pdev->pcie_flags_reg,
> +				     PCI_EXP_TYPE_DOWNSTREAM);
>  		}
>  	}
>  }
> -- 
> 2.54.0
> 
