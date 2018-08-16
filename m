Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10537 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbeHPW2r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Aug 2018 18:28:47 -0400
Date: Thu, 16 Aug 2018 22:28:05 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Add ACS quirk for Intel 300 series chipset
Message-ID: <20180816192805.GN2343@lahna.fi.intel.com>
References: <20180427104423.2203-1-mika.westerberg@linux.intel.com>
 <20180815152139.4e469fd4@t450s.home>
 <20180815164308.6ad5dd39@t450s.home>
 <20180816061015.GD2343@lahna.fi.intel.com>
 <20180816091303.69ce8e45@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180816091303.69ce8e45@t450s.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 16, 2018 at 09:13:03AM -0600, Alex Williamson wrote:
>  static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
>  {
>  	int pos;
> +	u16 std_ctrl;
>  	u32 cap, ctrl;
>  
>  	if (!pci_quirk_intel_spt_pch_acs_match(dev))
> @@ -4621,6 +4628,18 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
>  	if (!pos)
>  		return -ENOTTY;
>  
> +	/* If the std control word has bits set or is writable, do not quirk */
> +	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &std_ctrl);
> +	if (std_ctrl)
> +		return -ENOTTY;
> +
> +	pci_write_config_word(dev, pos + PCI_ACS_CTRL, 0xff);

I don't know ACS well but could the above have some unwanted
side-effects, even if we write back zeroes below?

> +	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &std_ctrl);
> +	if (std_ctrl) {
> +		pci_write_config_word(dev, pos + PCI_ACS_CTRL, 0);
> +		return -ENOTTY;
> +	}
> +
>  	pci_read_config_dword(dev, pos + PCI_ACS_CAP, &cap);
>  	pci_read_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, &ctrl);
>  
