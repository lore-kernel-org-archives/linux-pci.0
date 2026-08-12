Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186802C1586;
	Wed, 12 Aug 2026 02:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786502258; cv=none; b=h5oI3t+pnk6czHp1jF1LwiaF3Vl4MvSFPJz5cTtcStGn6iBum9sDHRI9H2kdAybmW1UT+jwWzVMpCgA1ntdr8njtA62ZTc/YcFG7rjrTZn8ANxoySAyprdi0yb+yGOS/v4ncFfYwzLShMcZrXIl5rA8VDfVtdxVJPbCbesS97sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786502258; c=relaxed/simple;
	bh=FRomwDdc7s2kzSrG8iN3YC3pm4Z9hy/V6bM3jWhbfDI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MaBraIMA8D4VX2h3HCQPlSjsuEm2a+Ws1agz+kAPtCISzK3L8OPc/iFBdhpn8lbcVDCHSR8GBjgitXk5YxW04cIbF2gvGZAJl//wr3V4uFw8OuimJrTFq2bV8+d1ykZYf/re5eHnSrUWxM6GK/SeTkgv34BsSG0CdG2f9qmkTNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsaaE9qQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsaaE9qQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7964E1F000E9;
	Wed, 12 Aug 2026 02:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786502256;
	bh=4ND4qwdfmF0i9GMVcwHjha5NUIYd6AJwq8TgdSbc0YI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=hsaaE9qQBJE+wc9RPBzONjyNxlqrFFgQRxx3freXyoDtPmEghJGtSsJVrTTMDkZtW
	 cSdBQNpftZ9AahZdohWrdtxYilBWSDXoHa93M0Vu20ie/HLAIgSdrNeNg9NFES3Rmu
	 YQhoECokKLp8qIlPJPDhP2Yn4f5X/r3Di87s6fGgfwZe6mp8Ls7GUGFh4p1j28mOrC
	 SUIXtdLzYnP4ItntCPWMDAAAwnE2lnwLkCnzZaPTtVLdWuHret/6/Wv4SP2Ftu2AXP
	 6xkqKCUsiZnuxsapRB60gZ6z20IXtlR78+QBgcwI2A14l9Lu0tMAouHKasWVnp27+V
	 4vO+S89bsWtsw==
Date: Tue, 11 Aug 2026 21:37:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mani@kernel.org
Subject: Re: [PATCH v6 0/3] PCI/ASPM: Mask ASPM states based on Devicetree
 properties
Message-ID: <20260812023735.GA846004@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-aspm-v6-0-2ebb3ee7ef71@oss.qualcomm.com>

On Mon, Jul 27, 2026 at 07:32:35PM +0530, Krishna Chaitanya Chundru wrote:
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Applied to pci/aspm for v7.3, thank you!

> ---
> Changes in v6:
> - Disable/enable each function L0s/L1. (sashiko)
> - Move from pcie_capability_write_word to
>   pcie_capability_clear_and_set_word (Sashiko)
> - Link to v5: https://patch.msgid.link/20260721-aspm-v5-1-58860c48d0c7@oss.qualcomm.com
> 
> Changes in v5:
> - update all the child devices when enabling the ASPM back (sashiko).
> - Link to v4: https://patch.msgid.link/20260707-aspm-v4-1-d66f85b728b0@oss.qualcomm.com
> 
> Changes in v4:
> - Clear link->aspm_enabled alongside aspm_support/aspm_default when an
>   ASPM state is masked, so it no longer goes stale relative to hardware (sashiko).
> - Mask the LNKCTL restore snapshot against the post-override
>   aspm_support so the restore step can no longer re-enable a state the
>   Devicetree override just disabled. (sashiko)
> - Link to v3: https://patch.msgid.link/20260704-aspm-v3-1-157217aff76f@oss.qualcomm.com
> 
> Changes in v3:
> - Move pcie_aspm_override_default_link_state() call in pcie_aspm_cap_init() to
>   before the "Restore L0s/L1" block. pcie_aspm_cap_init() disables L1 in
>   hardware prior to aspm_l1ss_init() and re-enables it only in the
>   restore block. Calling pcie_config_aspm_l1ss() while L1 is already
>   disabled satisfies its precondition ("Caller must disable L1 first"),
>   whereas the previous placement after the restore violated it (sashiko).
> - Link to v2: https://patch.msgid.link/20260624-aspm-v2-1-800a4151ba3a@oss.qualcomm.com
> 
> Changes in v2:
> - Disable L1ss when L1 is disabled as pointed by sashiko.
> - Disable L1ss if bootloader enables them but we are disabling via
>   devicetree pointed by sashiko.
> - Link to v1: https://patch.msgid.link/20260511-aspm-v1-1-b4a9fe955cf9@oss.qualcomm.com
> 
> ---
> Krishna Chaitanya Chundru (3):
>       PCI/ASPM: Use pcie_capability_clear_and_set_word() for ASPM disable/restore
>       PCI/ASPM: Disable/restore ASPM on every function for multi-function devices
>       PCI/ASPM: Mask ASPM states based on Devicetree properties
> 
>  drivers/pci/pcie/aspm.c | 149 +++++++++++++++++++++++++++++++++---------------
>  1 file changed, 102 insertions(+), 47 deletions(-)
> ---
> base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
> change-id: 20260429-aspm-da55a54279e4
> 
> Best regards,
> --  
> Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 
