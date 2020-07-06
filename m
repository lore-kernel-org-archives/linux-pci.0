Return-Path: <SRS0=T4wV=AR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56204C433DF
	for <linux-pci@archiver.kernel.org>; Mon,  6 Jul 2020 15:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD0B20771
	for <linux-pci@archiver.kernel.org>; Mon,  6 Jul 2020 15:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594051099;
	bh=ZQn1vCbZnPD1V6Qxc3hTuBsfI7f6CYU9OMt+sq266xs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=PVcAbo3QIWSsGKZPVgBaHbzfAJSs71VkdzC95ncaeHnnwwhIPjDNVazpGCwBF0ZGP
	 ERM1IX83CeKXsVHL8feOw/aPPWJkgX5idUPl83zqlj8sh9Nq7janyJp+CpDc9hVTOH
	 q7qTFBP4zOKM67qnlzwx/dqbmYrSIB8siJ9FiSeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgGFP6S (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:58:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729321AbgGFP6S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jul 2020 11:58:18 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF7CA20715;
        Mon,  6 Jul 2020 15:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594051097;
        bh=ZQn1vCbZnPD1V6Qxc3hTuBsfI7f6CYU9OMt+sq266xs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qLIW21h3rjqd2fHfnfQ0qUPPd8NKpa8sR75xE1w1XCw075Ghf/qQm+aWF38BXWraK
         S0FdgLURulHGi/105HaUAEDo2gXySV+i7R4Cfa9ag2rMLTNHpO60E1xiEDlhFy9b4C
         aPHjyEZrQ4KCy28dZ+gme5FyQ2OjSEcI9el4Qsho=
Date:   Mon, 6 Jul 2020 10:58:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        oohall@gmail.com, Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 1/7] PCI: Keep the ACS capability offset in device
Message-ID: <20200706155815.GA119406@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630044943.3425049-2-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 29, 2020 at 09:49:37PM -0700, Rajat Jain wrote:
> Currently this is being looked up at a number of places. Read and store it
> once at bootup so that it can be used by all later.

Write the commit log so it is complete even without the subject.
Right now, you have to read the subject to know what "this" refers to.

The subject is like the title; the log is like the body of an article.
The title isn't *part* of the article, so the article has to make
sense all by itself.

> +static void pci_enable_acs(struct pci_dev *dev);

I don't think we need this forward declaration, do we?

> @@ -4653,7 +4653,7 @@ static int pci_quirk_intel_spt_pch_acs(struct pci_dev *dev, u16 acs_flags)
>  	if (!pci_quirk_intel_spt_pch_acs_match(dev))
>  		return -ENOTTY;
>  
> -	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> +	pos = dev->acs_cap;

I assume you verified that all these quirks are FINAL quirks, since
pci_init_capabilities() is called after HEADER quirks.  I'll
double-check before applying this.

Bjorn
