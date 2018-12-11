Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52082C5CFFE
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 17:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238C32081B
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 17:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238C32081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeLKRPJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:15:09 -0500
Received: from verein.lst.de ([213.95.11.211]:56965 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbeLKRPG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Dec 2018 12:15:06 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9B3E068D8D; Tue, 11 Dec 2018 18:15:04 +0100 (CET)
Date:   Tue, 11 Dec 2018 18:15:04 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] avoid indirect calls for DMA direct mappings v2
Message-ID: <20181211171504.GA13624@lst.de>
References: <20181207190720.18517-1-hch@lst.de> <20181210215113.GA22180@agluck-desk> <20181211065112.GA13668@lst.de> <3908561D78D1C84285E8C5FCA982C28F7D4922D6@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D4922D6@ORSMSX110.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 11, 2018 at 05:13:30PM +0000, Luck, Tony wrote:
> > But that might not be your fault. My ancient system is getting flaky. A v4.19 build that
> > has booted before is also resetting :-(
> 
> After a power-cycle (and some time to let the machine cool off). System now boots
> with your patch series plus the __phys_to_pfn() #define
> 
> So if you can figure the right way to fix that, you are good to go.
> 
> Tested-by: Tony Luck <tony.luck@intel.com>

Thanks.  I'll just replace the __phys_to_pfn with PHYS_PFN for now,
and see if I can find time to get the whole kernel to agree to
one version of this macro eventually..
