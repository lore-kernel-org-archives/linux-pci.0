Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEDB37A496;
	Mon,  9 Feb 2026 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647337; cv=none; b=ltT7bne4tOTnt2/C5CXdmaAdyKcQkWSXAJuHN0GhyjnSlEcJOLQ3TbmbuFCQlhMK6pRXNsKDrshREoZGitwX0+g4k+zq4pOV4kEyrBMghpNOB7bl4BMmQkWvb9ZZJQGuocMVs4On7SaD3ZhPwszkxhIfj6wAoJXhLnKHvfz31Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647337; c=relaxed/simple;
	bh=Cw2W2XFQZ7L4Wfc0lHy31V0hm10GGFMTax8KYg/YI+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/CBFH//4rKFy1Hy5KyCsiY5nGN0e/CB820yK66eKwL+LJZO+bzxwVAAFh9KA1+9+aC7n5o0VIKR1a0SxwBrRwdgOy5+ZEhn+tZdPq1GKA35JMF6HOSSmfEGGTpEp3rYbavHdji/VE6abPqTgrYt2GevPGJHTNdAXkeNMMfTbVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=CgDKPToJ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="CgDKPToJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ADcr7MHeE4Wfa+rW+wWhUw4Yt3swRnjusQVf8Yvintg=; b=CgDKPToJEwvMWABCeYQbO42oJ7
	D91kxQf19eLqrPivJsLPizip9ylwh2/MUNvPRMw5zC8jvYgSPGnn7IL9MRuVxShAXo9k8SnjEYF0b
	m7TFQn0cL6iRuX0KEQ1XPEp1N//LZ3dtX0sgrVZ7foF4LG9xHtIqeqnozjcBccwHPxEhQTTPymKdF
	n8LnJN2CSfPjskbV5vhITfH8jO/Rm3IytlexAaXkrlVre0NO7cOakWYbCbWglcLpHIAw2Ui/bTxT8
	BxSpIQDDX/FM7DXo8Rtp7D3DtZvWM+GkiwvlLOE5czLyV2LbXQo+onRnyYdyD/gUG/xa8a3tJ9f8j
	+Bl/gZ3Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vpSFp-009Xzj-Rf; Mon, 09 Feb 2026 14:28:46 +0000
Date: Mon, 9 Feb 2026 06:28:40 -0800
From: Breno Leitao <leitao@debian.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, kbusch@kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	dcostantino@meta.com, rneu@meta.com, kernel-team@meta.com
Subject: Re: [PATCH] PCI/AER: Add option to panic on unrecoverable errors
Message-ID: <aYnour-Z8rm8pW2D@gmail.com>
References: <20260206-pci-v1-1-85160f02d956@debian.org>
 <20260206185232.GA70936@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206185232.GA70936@bhelgaas>
X-Debian-User: leitao

Hello Bjorn,

On Fri, Feb 06, 2026 at 12:52:32PM -0600, Bjorn Helgaas wrote:
> On Fri, Feb 06, 2026 at 10:23:11AM -0800, Breno Leitao wrote:
> Is there anything we could do to improve the logging to make the issue
> more recognizable?  I assume you already look for KERN_CRIT, KERN_ERR,
> etc., but it looks like the current message is just KERN_INFO.  I
> think we could make a good case for at least KERN_WARNING.
>
> But I guess you probably want something that's just impossible to
> ignore.
>
> Are there any other similar flags you already use that we could
> piggy-back on?  E.g., if we raised the level to KERN_WARNING, maybe
> the existing "panic_on_warn" would be enough?

Let me provide context on what we observe in production environments.

We manage a fleet of machines that regularly encounter AER errors. The
typical failure pattern we see involves:

1) AER errors on devices (sometimes with proprietary drivers):

	{2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 302
	 	0009:01:00.0:    [22] UncorrIntErr

2) The device enters an unrecoverable state where any subsequent access
   triggers additional failures.

3) The driver continues attempting hardware access, which generates
   cascading errors. On arm64, we observe sequences like:

	arm-smmu-v3 arm-smmu-v3.13.auto: unexpected global error reported (0x00000001), this could be serious
	arm-smmu-v3 arm-smmu-v3.13.auto: CMDQ error (cons 0x030120f3): ATC invalidate timeout
	..
	watchdog: CPU75: Watchdog detected hard LOCKUP on cpu 76

4) For NIC uncorrectable errors, we see:

	pcieport 0007:00:00.0: DPC: containment event, status:0x2009: unmasked uncorrectable error detected
	mlx5_core 0017:01:00.0 eth1: ERR CQE on SQ: 0x128b
	mlx5_core 0017:01:00.0 eth1: hw csum failure
	mlx5_core 0007:01:00.0 eth0: mlx5e_ethtool_get_link_ksettings: query port ptys failed: -67
	WARNING: CPU: 32 PID: 0 at drivers/iommu/dma-iommu.c:1237 iommu_dma_unmap_phys+0xd0/0xe0 (in a loop)


Keith and I discussed several approaches (all untested except the last
one -- this patch):

a) Mark the device as disconnected when recovery fails:

	diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
	index 6b697654d654..405aac6085a1 100644
	--- a/drivers/pci/pcie/err.c
	+++ b/drivers/pci/pcie/err.c
	@@ -271,6 +271,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
	     return status;

	 failed:
	+    pci_walk_bridge(bridge, pci_dev_set_disconnected, NULL);
	     pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);

	     pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);

b) Remove the device from the bus entirely:

	diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
	index 6b697654d6546..33559a0022318 100644
	--- a/drivers/pci/pcie/err.c
	+++ b/drivers/pci/pcie/err.c

		cb(bridge, userdata);
	}

	+static void pci_err_detach_subordinate(struct pci_dev *bridge)
	+{
	+    struct pci_dev *dev, *tmp;
	+    int ret;
	+
	+    pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
	+
	+    ret = pci_trylock_rescan_remove(bridge);
	+    if (!ret)
	+        return;
	+
	+    list_for_each_entry_safe_reverse(dev, tmp, &bridge->devices, bus_list) {
	+        pci_dev_get(dev);
	+        pci_stop_and_remove_bus_device(dev);
	+        pci_dev_put(dev);
	+    }
	+    pci_unlock_rescan_remove();
	+}
	+
	pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
		pci_channel_state_t state,
		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev))
	@@ -271,6 +290,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
	return status;

	failed:
	+    pci_err_detach_subordinate(bridge);
	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);

	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);

c) Panic the system (this patch).

The key issue is that simply raising the log level to KERN_WARNING
wouldn't address the fundamental problem. Once recovery fails, the system
becomes unstable and eventually crashes with varied symptoms (soft lockup,
hard lockup, BUG). These different crash signatures make correlation
difficult and prevent effective tracking of the root cause.

As Keith suggested, panicking immediately when a device is unrecoverable
appears to be the most appropriate approach for our use case. While the
other options may have merit in different scenarios, they don't adequately
address our stability requirements.

Thanks for the review and suggestions,
--breno
