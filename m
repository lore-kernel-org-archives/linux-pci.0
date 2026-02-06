Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB1823183F
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770416642; cv=none; b=h+MqGtqqjZTLPTG3JlcNXnxnpU8nNZSL1pjvB5zyecdoG79hE9A5f+UUT5Y9+UWdkyJN2AqKFJVCr2hm8buiP6nkRs3+MP2ANMBEYTSwKdQQzFo0gfVfkV9f8ON6JFpc421TOdFRS5IU2vf0TBpxKqDOIEIvmsx5x1bJYZwUsXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770416642; c=relaxed/simple;
	bh=/gcXJR6AGzVHtK/vHkRsCaXAoRL9J1/Jv1DLWpmo6Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TTHc7ArD6ty/rG5+6+OnnnOxY43/+z35SDqHSZH8S+sVb1ly93SFjZVnCLfmmaV207Oo0r3fF8ISuGs4G9Szlt7HryWDe/SAcIBz3kJB6Y7REeDbF17eLGVAN/iVqIGoLHyQU2CnyFF4dBo3JDBM9OTdf1JUkeTY6q0KY1YStR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyEp62e5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyEp62e5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0B3C16AAE;
	Fri,  6 Feb 2026 22:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770416641;
	bh=/gcXJR6AGzVHtK/vHkRsCaXAoRL9J1/Jv1DLWpmo6Zk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cyEp62e5q0g0Raus/8z18xP8eTHaoq2UEaQesBdrKTQBUxBDo+W3CZqJzrxvbrLao
	 C+MQFng7GvYzae42lr21tU0pIij01SYZSiJxbWCQVC7/ETfQgjcsvsxq9YILZADDLx
	 e7nqkrlfScVdBlKyb8iBetaUDeKLZoEFhLTpzRtcMCD/8k2LLAPu8bms4bizJr7ELw
	 PLZa1khrY8KadxmvrpFAgcqSWpVv9ketLLCMBo7egfDSOJs5owIVqPYPYYZbplLF2h
	 +5lfArFAMr7yA8yd+O1v9IGihIj94/VHAap8srxpb4JVvUErJXkxlu9LHPIqlVoStz
	 cn02/W89SkP+A==
Date: Fri, 6 Feb 2026 16:24:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Terry Bowman <terry.bowman@amd.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-pci@vger.kernel.org, Shuai Xue <xueshuai@linux.alibaba.com>,
	tianruidong@linux.alibaba.com, Keith Busch <kbusch@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PCI/AER: Clear stale errors on reporting agents upon
 probe
Message-ID: <20260206222400.GA98495@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3011c2ed30c11f858e35e29939add754adea7478.1769332702.git.lukas@wunner.de>

On Sun, Jan 25, 2026 at 10:25:51AM +0100, Lukas Wunner wrote:
> Correctable and Uncorrectable Error Status Registers on reporting agents
> are cleared upon PCI device enumeration in pci_aer_init() to flush past
> events.  They're cleared again when an error is handled by the AER driver.
> 
> If an agent reports a new error after pci_aer_init() and before the AER
> driver has probed on the corresponding Root Port or Root Complex Event
> Collector, that error is not handled by the AER driver:  It clears the
> Root Error Status Register on probe, but neglects to re-clear the
> Correctable and Uncorrectable Error Status Registers on reporting agents.
> 
> The error will eventually be reported when another error occurs.  Which
> is irritating because to an end user it appears as if the earlier error
> has just happened.
> 
> Amend the AER driver to clear stale errors on reporting agents upon probe.
> 
> Skip reporting agents which have not invoked pci_aer_init() yet to avoid
> using an uninitialized pdev->aer_cap.  They're recognizable by the error
> bits in the Device Control register still being clear.
> 
> Reporting agents may execute pci_aer_init() after the AER driver has
> probed, particularly when devices are hotplugged or removed/rescanned via
> sysfs.  For this reason, it continues to be necessary that pci_aer_init()
> clears Correctable and Uncorrectable Error Status Registers.
> 
> Reported-by: Lucas Van <lucas.van@intel.com> # off-list
> Tested-by: Lucas Van <lucas.van@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Applied to pci/aer for v6.20, thanks!

> ---
>  drivers/pci/pcie/aer.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e0bcaa8..4299c55 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1608,6 +1608,20 @@ static void aer_disable_irq(struct pci_dev *pdev)
>  	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
>  }
>  
> +static int clear_status_iter(struct pci_dev *dev, void *data)
> +{
> +	u16 devctl;
> +
> +	/* Skip if pci_enable_pcie_error_reporting() hasn't been called yet */
> +	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &devctl);
> +	if (!(devctl & PCI_EXP_AER_FLAGS))
> +		return 0;
> +
> +	pci_aer_clear_status(dev);
> +	pcie_clear_device_status(dev);
> +	return 0;
> +}
> +
>  /**
>   * aer_enable_rootport - enable Root Port's interrupts when receiving messages
>   * @rpc: pointer to a Root Port data structure
> @@ -1629,9 +1643,19 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
>  	pcie_capability_clear_word(pdev, PCI_EXP_RTCTL,
>  				   SYSTEM_ERROR_INTR_ON_MESG_MASK);
>  
> -	/* Clear error status */
> +	/* Clear error status of this Root Port or RCEC */
>  	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, &reg32);
>  	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, reg32);
> +
> +	/* Clear error status of agents reporting to this Root Port or RCEC */
> +	if (reg32 & AER_ERR_STATUS_MASK) {
> +		if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_EC)
> +			pcie_walk_rcec(pdev, clear_status_iter, NULL);
> +		else if (pdev->subordinate)
> +			pci_walk_bus(pdev->subordinate, clear_status_iter,
> +				     NULL);
> +	}
> +
>  	pci_read_config_dword(pdev, aer + PCI_ERR_COR_STATUS, &reg32);
>  	pci_write_config_dword(pdev, aer + PCI_ERR_COR_STATUS, reg32);
>  	pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, &reg32);
> -- 
> 2.51.0
> 
