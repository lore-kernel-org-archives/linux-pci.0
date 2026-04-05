Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250AC340DB8;
	Sun,  5 Apr 2026 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775376176; cv=none; b=LyDFq7A086LNaFtFDOXLzhZ8R6gA1vhcG4kwexq9dZSNAsl1SHs8kd0EHutDL6GodBz+KsE7hSGXBv96rPRs6vW0WK4j/BndINHg6Y199X0w2fjLJCYOzgw/Ykaj4uyDT64DBjLhjJB+NKscxLmvo3Q5Uc9zWpv6f3wfIqlsoCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775376176; c=relaxed/simple;
	bh=qHkqTHtiiUhYv5EJ13SgSzGtKIR7zctCY+vWkvIRuoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llgGcr8FcsYBd+zBBPX1JkDfyeLgj2qCsD7JF7f75Sco/ZE3sE9OS3RoWISk/Mz7X+uTHfhZnXPX9l9He66O+fhs4MCDZKB4M3STZGxlV9YJZQ653KGBCxFAqGqbl5ied7iAlowM3qSmh1si2+sGedbf5Zn2WMFIZCR+q+fqSbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 636CC10606;
	Sun, 05 Apr 2026 10:02:46 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 5A388602D63A; Sun,  5 Apr 2026 10:02:46 +0200 (CEST)
Date: Sun, 5 Apr 2026 10:02:46 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	manivannan.sadhasivam@oss.qualcomm.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Fix NULL pointer access in
 pci_store_saved_state()
Message-ID: <adIXJvrV1VRunFOu@wunner.de>
References: <20260404-fix_pci_access-v1-0-416f32c6f7ec@oss.qualcomm.com>
 <20260404-fix_pci_access-v1-2-416f32c6f7ec@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404-fix_pci_access-v1-2-416f32c6f7ec@oss.qualcomm.com>

On Sat, Apr 04, 2026 at 02:23:00PM +0530, Krishna Chaitanya Chundru wrote:
> If the PCIe link goes down while pci_save_state() is in progress, reads
> from the device configuration space may return invalid values(all 0xF's).

That should be harmless.  If the link goes down, the device should
subsequently be de-enumerated by the hotplug driver.  If we save
some bogus data before de-enumerating it, so be it.

If the port above is not hotplug-capable, manual intervention is
required for remove/rescan, but that's orthogonal to this problem.

> One example is, while saving VC extended capability save path
> (pci_save_vc_state() / pci_vc_do_save_buffer()) then interprets all-1s
> capability fields as valid and ends up writing far beyond the allocated
> pci_cap_saved_state buffer, corrupting the pci_dev->saved_cap_space list.

I'm not familiar with drivers/pci/vc.c, but it seems it takes a size
read from config space and uses it to write to a particular memory
area?  That feels totally wrong, at the very least there should be
a check for PCI_POSSIBLE_ERROR().

> The link state check here is racy since the link may transition at any
> time. This is a best-effort attempt to avoid saving PCI state when the
> link is already down.

No, please validate values read from config space with
PCI_POSSIBLE_ERROR() before using them to access memory at
a location that may be out-of-bounds.  Or cache the size on
enumeration and avoid re-reading it upon pci_save_state().

> +	/*
> +	 * The link state check here is racy since the link may transition at
> +	 * any time. This is a best-effort attempt to avoid saving PCI state
> +	 * when the link is already down.
> +	 */
> +	if (!pcie_link_is_active(dev)) {
> +		dev->state_saved = false;
> +		return NULL;
> +	}

The state_saved flag is only used by PM code to determine whether
the driver called pci_save_state().  If it didn't, the PCI core
will make up for it by calling pci_save_state().

The state_saved flag is *not* an indication whether the saved state
is usable and code outside power management has no business changing
the flag's value.

Thanks,

Lukas
