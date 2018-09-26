Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4C5C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 16:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466A92152E
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 16:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466A92152E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbeIZWgR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:36:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:24519 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728025AbeIZWgR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 18:36:17 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 09:22:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,306,1534834800"; 
   d="scan'208";a="93922814"
Received: from araj-mobl1.jf.intel.com ([10.7.201.19])
  by orsmga001.jf.intel.com with ESMTP; 26 Sep 2018 09:22:35 -0700
Date:   Wed, 26 Sep 2018 09:22:35 -0700
From:   "Raj, Ashok" <ashok.raj@linux.intel.com>
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        IOMMU Mailing List <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH V3] PCI: Enable PASID when End-to-End TLP is supported by
 all bridges
Message-ID: <20180926162235.GA30177@araj-mobl1.jf.intel.com>
References: <1530372264-20653-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530372264-20653-1-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sinan

+ IOMMU list.

On Sat, Jun 30, 2018 at 11:24:24AM -0400, Sinan Kaya wrote:
> A PCIe endpoint carries the process address space identifier (PASID) in
> the TLP prefix as part of the memory read/write transaction. The address
> information in the TLP is relevant only for a given PASID context.
> 
> An IOMMU takes PASID value and the address information from the
> TLP to look up the physical address in the system.
> 
> PASID is an End-End TLP Prefix (PCIe r4.0, sec 6.20).  Sec 2.2.10.2 says
> 
>   It is an error to receive a TLP with an End-End TLP Prefix by a
>   Receiver that does not support End-End TLP Prefixes. A TLP in
>   violation of this rule is handled as a Malformed TLP. This is a
>   reported error associated with the Receiving Port (see Section 6.2).
> 
> Prevent error condition by proactively requiring End-to-End TLP
> prefix to be supported on the entire data path between the endpoint and
> the root port before enabling PASID.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  
> +static void pci_configure_eetlp_prefix(struct pci_dev *dev)
> +{
> +#ifdef CONFIG_PCI_PASID
> +	struct pci_dev *bridge;
> +	u32 cap;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
> +	if (!(cap & PCI_EXP_DEVCAP2_E2ETLP))
> +		return;

Forgot to notice this.. I'm not sure if the same enforcement is 
required for devices that are RCIEP. The spec isn't clear about calling
any excemption. Although it should be simple for devices to expose
e2etlp support, but if they don't that should be ok, since there are
nothing between itself and the root port.

We are seeking help from our SIG reps, but thought I'll ask here as well
if there are other opinions.

> +
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> +		dev->eetlp_prefix_path = 1;
> +	else {
> +		bridge = pci_upstream_bridge(dev);
> +		if (bridge && bridge->eetlp_prefix_path)
> +			dev->eetlp_prefix_path = 1;
> +	}
> +#endif
> +}

Cheers,
Ashok
