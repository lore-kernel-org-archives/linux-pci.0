Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A08AC32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 17:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF2B20869
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 17:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF2B20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbeKGCyb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:54:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:4134 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730688AbeKGCya (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 21:54:30 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 09:28:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,472,1534834800"; 
   d="scan'208";a="106373797"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga002.jf.intel.com with ESMTP; 06 Nov 2018 09:28:15 -0800
Date:   Tue, 6 Nov 2018 10:26:08 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] error handling and pciehp maintenance
Message-ID: <20181106172608.GB6217@localhost.localdomain>
References: <20180918235848.26694-1-keith.busch@intel.com>
 <20181004214015.GK120535@bhelgaas-glaptop.roam.corp.google.com>
 <20181004221137.GB21834@localhost.localdomain>
 <20181005173145.GL120535@bhelgaas-glaptop.roam.corp.google.com>
 <20181008161847.GA30971@localhost.localdomain>
 <20181106163400.GA21193@e107981-ln.cambridge.arm.com>
 <20181106164751.GA6217@localhost.localdomain>
 <20181106172100.GA22063@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106172100.GA22063@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 06, 2018 at 05:21:00PM +0000, Lorenzo Pieralisi wrote:
> If you have a simple reproducer for the bugs I am happy to help you test
> it (I can also apply arm64 DYNAMIC_FTRACE_WITH_REGS patches and test that
> new code path if that's the final direction we are taking).

The easiest way to reproduce is load the aer_inject module, inject an
error into a bridge, then remove the bridge and rescan.
