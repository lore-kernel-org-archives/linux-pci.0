Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1DFC43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 23:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743382089D
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 23:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743382089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbeKPJ5D (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Nov 2018 04:57:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:14780 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbeKPJ5D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Nov 2018 04:57:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2018 15:47:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,238,1539673200"; 
   d="scan'208";a="108532213"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga001.fm.intel.com with ESMTP; 15 Nov 2018 15:47:02 -0800
Date:   Thu, 15 Nov 2018 16:43:38 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     helgaas@google.com, austin_bolen@dell.com,
        alex_gagniuc@dellteam.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] PCI/AER: Determine AER ownership based on _OSC
 instead of HEST
Message-ID: <20181115234338.GE13334@localhost.localdomain>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
 <20181115231605.24352-3-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115231605.24352-3-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 15, 2018 at 05:16:03PM -0600, Alexandru Gagniuc wrote:
>  static void aer_set_firmware_first(struct pci_dev *pci_dev)
>  {
> -	int rc;
> -	struct aer_hest_parse_info info = {
> -		.pci_dev	= pci_dev,
> -		.firmware_first	= 0,
> -	};
> +	struct pci_host_bridge *host = pci_find_host_bridge(pci_dev->bus);
>  
> -	rc = apei_hest_parse(aer_hest_parse, &info);
> -
> -	if (rc)
> -		pci_dev->__aer_firmware_first = 0;
> -	else
> -		pci_dev->__aer_firmware_first = info.firmware_first;
> +	pci_dev->__aer_firmware_first = !host->native_aer;
>  	pci_dev->__aer_firmware_first_valid = 1;
>  }

I think we can clean this up even more by removing the setter and the
__aer_firmware_first fields, and have the pcie_aer_get_firmware_first()
go directly to the host bride->native_aer.
