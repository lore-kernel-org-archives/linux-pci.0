Return-Path: <SRS0=bOp+=MB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD49ECE564
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 15:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232252150F
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 15:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232252150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732255AbeISV3H (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:29:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:56215 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbeISV3H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 17:29:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 08:50:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,394,1531810800"; 
   d="scan'208";a="74304755"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by orsmga007.jf.intel.com with ESMTP; 19 Sep 2018 08:50:34 -0700
Date:   Wed, 19 Sep 2018 09:52:28 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCHv3 05/10] PCI/ERR: Handle fatal error recovery
Message-ID: <20180919155227.GB26372@localhost.localdomain>
References: <20180918235702.26573-1-keith.busch@intel.com>
 <20180918235702.26573-6-keith.busch@intel.com>
 <20180919154651.GA243610@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919154651.GA243610@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180919155228.BQCmFWfbFCVMZu5Af7bML9tSP-Jddz27ixIn4hR5NlY@z>

On Wed, Sep 19, 2018 at 10:46:51AM -0500, Bjorn Helgaas wrote:
> On Tue, Sep 18, 2018 at 05:56:57PM -0600, Keith Busch wrote:
> > We don't need to be paranoid about the topology changing while handling an
> > error. If the device has changed in a hotplug capable slot, we can rely
> > on the presence detection handling to react to a changing topology. This
> > patch restores the fatal error handling behavior that existed before
> > merging DPC with AER with 7e9084b3674 ("PCI/AER: Handle ERR_FATAL with
> > removal and re-enumeration of devices").
> 
> 7e9084b3674 updated Documentation/PCI/pci-error-recovery.txt; doesn't
> this require another update to keep it matching the code?

Indeed, I will fix that.
