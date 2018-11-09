Return-Path: <SRS0=f7a+=NU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA274C43441
	for <linux-pci@archiver.kernel.org>; Fri,  9 Nov 2018 07:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E97120840
	for <linux-pci@archiver.kernel.org>; Fri,  9 Nov 2018 07:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E97120840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeKIQu5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:50:57 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:59375 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeKIQu5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Nov 2018 11:50:57 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 45CCA2800B4A4;
        Fri,  9 Nov 2018 08:11:40 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E738313125; Fri,  9 Nov 2018 08:11:39 +0100 (CET)
Date:   Fri, 9 Nov 2018 08:11:39 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-pci@vger.kernel.org, keith.busch@intel.com,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, linux-kernel@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Message-ID: <20181109071139.uxa6gu7jwsvr7ve6@wunner.de>
References: <20180918221501.13112-1-mr.nuke.me@gmail.com>
 <20181107234257.GC41183@google.com>
 <20181108200855.GE41183@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108200855.GE41183@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 08, 2018 at 02:09:17PM -0600, Bjorn Helgaas wrote:
> +	/*
> +	 * If an MMIO read from the device returns ~0 data, that data may
> +	 * be valid, or it may indicate a bus error.  If config space is
> +	 * readable, assume it's valid data; otherwise, assume a bus error.
> +	 */
> +	if (val == ~0) {
> +		pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
> +		if (id == ~0)
> +			pci_dev_set_disconnected(dev, NULL);
> +	}

This isn't safe unfortunately because "all ones" may occur for other
reasons besides disconnectedness.  E.g. on an Uncorrectable Error,
the device may likewise respond with all ones, but revert to valid
responses if the error can be recovered through a Secondary Bus Reset.
In such a case, marking the device disconnected would be inappropriate.

Accessing a device in D3cold would be another example where all ones
is returned both from mmio and config space despite the device still
being present and future accesses having a chance to succeed.

In fact, in v2 of Keith's patches adding pci_dev_set_disconnected()
he attempted the same as what you're doing here and caused issues
for me with devices in D3cold:

https://spinics.net/lists/linux-pci/msg54337.html


> One thing I'm uncomfortable with is that [...].  Another is that the
> only place we call pci_dev_set_disconnected() is in pciehp and acpiphp,
> so the only "disconnected" case we catch is if hotplug happens to be
> involved.

Yes, that's because the hotplug drivers are the only ones who can
identify removal authoritatively and unambiguously.  They *know*
when the device is gone and don't have to resort to heuristics
such as all ones.  (ISTR that dpc also marks devices disconnected.)


> sprinkling pci_dev_is_disconnected() around feels ad hoc
> instead of systematic, in the sense that I don't know how we convince
> ourselves that this (and only this) is the correct place to put it.

We need to add documentation for driver authors how to deal with
surprise removal.  Briefly:

* If (pdev->error_state == pci_channel_io_perm_failure), the device
  is definitely gone and any further device access can be skipped.
  Otherwise presence of the device is likely, but not guaranteed.

* If a device access can significantly delay device removal due to
  Completion Timeouts, or can cause an infinite loop, MCE or crash,
  do check pdev->error_state before carrying out the device access.

* Always be prepared that a device access may fail due to surprise
  removal, do not blindly trust mmio or config space reads or
  assume success of writes.

I'm sure this can be extended quite a bit.  There's more information
in this LWN article in the "Surprise removal" section:

https://lwn.net/Articles/767885/

Thanks,

Lukas
