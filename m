Return-Path: <SRS0=qbZn=NX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB15C43441
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 18:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D65822504
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 18:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D65822504
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeKMD4Z (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:56:25 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:36875 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727712AbeKMD4Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Nov 2018 22:56:25 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 4387D2800B74A;
        Mon, 12 Nov 2018 19:02:04 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id CFF7C1C9E0; Mon, 12 Nov 2018 19:02:03 +0100 (CET)
Date:   Mon, 12 Nov 2018 19:02:03 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Message-ID: <20181112180203.lx72gjfplb6xlur7@wunner.de>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-2-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112160628.86620-2-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 12, 2018 at 07:06:25PM +0300, Mika Westerberg wrote:
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1378,6 +1378,27 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>  	}
>  }
>  
> +static void set_pcie_external(struct pci_dev *dev)
> +{
> +	struct pci_dev *parent;
> +
> +	/*
> +	 * Walk up the device hierarchy and check for any upstream
> +	 * bridge that has is_external_facing set to true. This means
> +	 * the hierarchy is below PCIe port that is exposed externally
> +	 * (such as Thunderbolt).
> +	 */
> +	parent = pci_upstream_bridge(dev);
> +	while (parent) {
> +		if (parent->is_external) {
> +			dev->is_external = true;
> +			break;
> +		}
> +
> +		parent = pci_upstream_bridge(parent);
> +	}
> +}
> +

This looks pretty much like a duplication of the is_thunderbolt bit
in struct pci_dev and the pci_is_thunderbolt_attached() helper.

Why constrain the functionality to ports with the _DSD property
instead of making it available for *any* Thunderbolt port?

Thanks,

Lukas
