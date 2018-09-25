Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9897C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 20:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D62320896
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 20:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gh7vMl7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D62320896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbeIZCzK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbeIZCzK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 22:55:10 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C3EA20833;
        Tue, 25 Sep 2018 20:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537908347;
        bh=eCH7KPPiHYLI08aKKuiqZ10H0IFkrljEgbyjcogFOoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gh7vMl7DxO+iehn/UcdqytYIW7UB9MA3l49zV3bWfqca3HeFi8DrnC0WXzaZmtWdd
         BXys7q9DqUXJGKUzkTyoiwMQRQ1Rr7fR8F+g7lEFuzFHxVTXLKHEejfgSgH9s0kGNa
         /NazAV/YJZBUfiOwYeHwZEcPHyGPdYPow8JIWACs=
Date:   Tue, 25 Sep 2018 15:45:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-pci@vger.kernel.org, alex.williamson@redhat.com,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH v4 1/6] PCI: Expose reset_type to users of
 __pci_reset_function_locked()
Message-ID: <20180925204546.GB80129@bhelgaas-glaptop.roam.corp.google.com>
References: <20180919163037.13497-1-okaya@kernel.org>
 <20180919163037.13497-2-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919163037.13497-2-okaya@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 19, 2018 at 04:30:32PM +0000, Sinan Kaya wrote:
> We need a contract between the reset API users and the PCI core about the
> types of reset that a user needs vs. what PCI core can do internally.
> If a platform supports hotplug, we need to do hotplug reset as an example.
> 
> Expose the reset types to the drivers and try different reset types based
> on the new reset_type parameter.
> 
> Most users are expected to use PCI_RESET_ANY, PCI_RESET_FUNC or
> PCI_RESET_LINK parameters.

I understand the words above, but I don't really understand the
motivation behind this.  Can you help flesh that out a bit?

I guess there's a problem being solved by these patches, and it would
help a lot to have some details about what it is.

It would be ideal if we could offer some guidance, probably as code
comments, to help driver writers choose the correct reset type.

> +	if (reset_type & PCI_RESET_FLR) {
> +		if (pcie_has_flr(dev)) {
> +			rc = pcie_flr(dev);
> +			if (rc != -ENOTTY)
> +				return rc;
> +		}
> +		rc = pci_af_flr(dev, 0);

This is a tangent and not material for the current series, so just
file it away so as not to delay this series, but is there any way we
can get rid of the "probe" arguments?  Maybe do all the probes at
enumeration-time and remember the results?

I know there are one or two cases where you need to look at more than
one device, e.g., a secondary bus reset might be possible if there's
only one device and not otherwise, but it seems like in most cases
this is a property of the individual device.

Bjorn
