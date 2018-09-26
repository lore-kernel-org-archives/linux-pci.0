Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31BDC43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 22:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBAB21564
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 22:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBAB21564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbeI0Ec3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:32:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:10505 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725722AbeI0Ec3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Sep 2018 00:32:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 15:17:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,307,1534834800"; 
   d="scan'208";a="86859593"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by orsmga003.jf.intel.com with ESMTP; 26 Sep 2018 15:17:16 -0700
Date:   Wed, 26 Sep 2018 16:19:25 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCHv4 08/12] PCI: ERR: Always use the first downstream port
Message-ID: <20180926221924.GA17934@localhost.localdomain>
References: <20180920162717.31066-1-keith.busch@intel.com>
 <20180920162717.31066-9-keith.busch@intel.com>
 <20180926220116.GJ28024@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926220116.GJ28024@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 26, 2018 at 05:01:16PM -0500, Bjorn Helgaas wrote:
> On Thu, Sep 20, 2018 at 10:27:13AM -0600, Keith Busch wrote:
> > The link reset always used the first bridge device, but AER broadcast
> > error handling may have reported an end device. This means the reset may
> > hit devices that were never notified of the impending error recovery.
> > 
> > This patch uses the first downstream port in the hierarchy considered
> > reliable. An error detected by a switch upstream port should mean it
> > occurred on its upstream link, so the patch selects the parent device
> > if the error is not a root or downstream port.
> 
> I'm not really clear on what "Always use the first downstream port"
> means.  Always use it for *what*?
> 
> I already applied this, but if we can improve the changelog, I'll
> gladly update it.

I'll see if I can better rephrase.

Error handling should notify all affected pci functions. If an end device
detects and emits ERR_FATAL, the old way would have only notified that
end-device driver, but other functions may be on or below the same bus.

Using the downstream port that connects to that bus where the error was
detectedas the anchor point to broadcast error handling progression,
we can notify all functions so they have a chance to prepare for the
link reset.
