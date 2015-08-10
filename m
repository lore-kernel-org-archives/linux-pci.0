Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58871 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752498AbbHJTzF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 10 Aug 2015 15:55:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1ZOt9y-00030Y-OW
	for linux-pci@vger.kernel.org; Mon, 10 Aug 2015 21:55:03 +0200
Received: from jfdmzpr05-ext.jf.intel.com ([134.134.137.74])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2015 21:55:02 +0200
Received: from john.ronciak by jfdmzpr05-ext.jf.intel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2015 21:55:02 +0200
To: linux-pci@vger.kernel.org
From: John Ronciak <john.ronciak@gmail.com>
Subject: Re: [PATCH] PCI: Add ACS quirks for Intel I219-LM/V
Date: Mon, 10 Aug 2015 19:52:42 +0000 (UTC)
Message-ID: <loom.20150810T214947-571@post.gmane.org>
References: <20150810183055.5714.12998.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Alex Williamson <alex.williamson <at> redhat.com> writes:


> +	/* I219 */
> +	{ PCI_VENDOR_ID_INTEL, 0x15b7, pci_quirk_mf_endpoint_acs },
> +	{ PCI_VENDOR_ID_INTEL, 0x15b8, pci_quirk_mf_endpoint_acs },

Acked-by: John Ronciak <john.ronciak@gmail.com>



