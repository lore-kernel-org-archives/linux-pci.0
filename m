Return-Path: <SRS0=ZPBx=RJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689B0C43381
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 07:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2412064A
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 07:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfCFHDp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:03:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:42461 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfCFHDp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Mar 2019 02:03:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 23:03:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,446,1544515200"; 
   d="scan'208";a="324637314"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 05 Mar 2019 23:03:42 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h1Qab-00043e-1x; Wed, 06 Mar 2019 09:03:41 +0200
Date:   Wed, 6 Mar 2019 09:03:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stefan =?iso-8859-1?Q?M=E4tje?= <stefan.maetje@esd.eu>
Cc:     bhelgaas@google.com, rafael.j.wysocki@intel.com,
        ptalbert@redhat.com, lukas@wunner.de, fred@fredlawl.com,
        bhull@redhat.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 1/1] PCI/ASPM: Work around link retrain errata of
 Pericom PCIe-to-PCI bridges
Message-ID: <20190306070341.GY9224@smile.fi.intel.com>
References: <20190305173122.11875-1-stefan.maetje@esd.eu>
 <20190305173122.11875-2-stefan.maetje@esd.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190305173122.11875-2-stefan.maetje@esd.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 05, 2019 at 06:31:22PM +0100, Stefan Mätje wrote:
> Due to an erratum in some Pericom PCIe-to-PCI bridges in reverse mode the
> retrain link bit needs to be cleared again manually to allow the link
> training to complete successfully.
> 
> If it is not cleared manually the link training is continuously restarted
> and all devices below the PCI-to-PCIe bridge can't be accessed any more.
> That means drivers for devices below the bridge will be loaded but won't
> work or even crash because the driver is only reading 0xffff.
> 
> See the Pericom Errata Sheet PI7C9X111SLB_errata_rev1.2_102711.pdf for
> details.
> 
> Devices known as affected so far are: PI7C9X110, PI7C9X111SL, PI7C9X130
> 
> The patch introduces a new flag clear_retrain_link in the struct pci_dev. This
> flag is set in quirk_enable_clear_retrain_link() for the affected devices in
> the pci_fixup_header in quirks.c
> 
> The link retraining code is moved to pcie_retrain_link(). This function now
> applies the work around to clear the PCI_EXP_LNKCTL_RL bit again if
> clear_retrain_link bit is set in the pci_dev structure of the link parent
> device.


> +	/* Wait for link training end. Break out after waiting for timeout */
> +	start_jiffies = jiffies;
> +	for (;;) {
> +		pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
> +		if (!(reg16 & PCI_EXP_LNKSTA_LT))
> +			break;
> +		if (time_after(jiffies, start_jiffies + LINK_RETRAIN_TIMEOUT))
> +			break;
> +		msleep(1);
> +	}

I see this is existing code, though two comments (perhaps for future clean up):
	- msleep(1) is not guaranteed to be 1 ms at all (in some cases it might be less)
	- better to use do {} while (time_before()) loop

> +static void quirk_enable_clear_retrain_link(struct pci_dev *dev)
> +{
> +	dev->clear_retrain_link = 1;

> +	pci_info(dev, "Enable Pericom link retrain quirk\n");

If some other device would appear with same issue, but from another vendor this
becomes misleading.

I would recommend to refer to an issue the quirk is about, and not the vendor.

> +}

-- 
With Best Regards,
Andy Shevchenko


