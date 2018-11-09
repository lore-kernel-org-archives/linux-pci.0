Return-Path: <SRS0=f7a+=NU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C66CC43441
	for <linux-pci@archiver.kernel.org>; Fri,  9 Nov 2018 07:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197DD20855
	for <linux-pci@archiver.kernel.org>; Fri,  9 Nov 2018 07:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197DD20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeKIRJN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:09:13 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:44703 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbeKIRJN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Nov 2018 12:09:13 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 77C1630000CD0;
        Fri,  9 Nov 2018 08:29:53 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 3F063AEAD; Fri,  9 Nov 2018 08:29:53 +0100 (CET)
Date:   Fri, 9 Nov 2018 08:29:53 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-pci@vger.kernel.org, keith.busch@intel.com,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, linux-kernel@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Message-ID: <20181109072953.ox7qfpnibb7drmf6@wunner.de>
References: <20180918221501.13112-1-mr.nuke.me@gmail.com>
 <20181107234257.GC41183@google.com>
 <20181108200855.GE41183@google.com>
 <20181108220117.GA11466@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108220117.GA11466@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 08, 2018 at 02:01:17PM -0800, Greg Kroah-Hartman wrote:
> On Thu, Nov 08, 2018 at 02:09:17PM -0600, Bjorn Helgaas wrote:
> > I'm having second thoughts about this.  One thing I'm uncomfortable
> > with is that sprinkling pci_dev_is_disconnected() around feels ad hoc
> 
> I think my stance always has been that this call is not good at all
> because once you call it you never really know if it is still true as
> the device could have been removed right afterward.
> 
> So almost any code that relies on it is broken, there is no locking and
> it can and will race and you will loose.

Hm, to be honest if that's your impression I think you must have missed a
large portion of the discussion we've been having over the past 2 years.

Please consider reading this LWN article, particularly the "Surprise
removal" section, to get up to speed:

https://lwn.net/Articles/767885/

You seem to be assuming that all we care about is the *return value* of
an mmio read.  However a transaction to a surprise removed device has
side effects beyond returning all ones, such as a Completion Timeout
which, with thousands of transactions in flight, added up to many seconds
to handle removal of an NVMe array and occasionally caused MCEs.

It is not an option to just blindly carry out device accesses even though
it is known the device is gone, Completion Timeouts be damned.

However there is more to it than just Completion Timeouts, this is all
detailed in the LWN article.

Thanks,

Lukas
