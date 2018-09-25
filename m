Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23992C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 15:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC39220C0A
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 15:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC39220C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbeIYVmN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:42:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:43492 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729306AbeIYVmM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 17:42:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 08:34:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,302,1534834800"; 
   d="scan'208";a="265595805"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by fmsmga005.fm.intel.com with ESMTP; 25 Sep 2018 08:33:07 -0700
Date:   Tue, 25 Sep 2018 09:35:13 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>,
        "poza@codeaurora.org" <poza@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCHv3 09/10] PCI: Unify device inaccessible
Message-ID: <20180925153512.GC11657@localhost.localdomain>
References: <20180918235702.26573-1-keith.busch@intel.com>
 <20180918235702.26573-10-keith.busch@intel.com>
 <e0606dfcf8780bf994432dc373581fdf0af18f8e.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0606dfcf8780bf994432dc373581fdf0af18f8e.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 24, 2018 at 06:10:01PM -0700, Benjamin Herrenschmidt wrote:
> On Tue, 2018-09-18 at 17:57 -0600, Keith Busch wrote:
> 
>  .../...
> 
> Any reason why you don't do cmpxchg as I originally suggested (sorry
> I've been away and may have missed some previous emails)

That was to block a device hot removal on error_detected and error_resume,
or vice versa.
 
> > -/* pci_dev priv_flags */
> > -#define PCI_DEV_DISCONNECTED 0
> > -#define PCI_DEV_ADDED 1
> > +/**
> > + * pci_dev_set_io_state - Set the new error state if possible.
> > + *
> > + * @dev - pci device to set new error_state
> > + * @new - the state we want dev to be in
> > + *
> > + * Must be called with device_lock held.
> 
> This won't work for PowerPC EEH. We will change the state from a
> readl() so at interrupt time or any other context.
> 
> We really need the cmpxchg variant.

These are private interfaces. EEH can't call them from any context.
