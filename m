Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C69C04EB8
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 19:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D672081F
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 19:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D672081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeLJTVG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:21:06 -0500
Received: from mga12.intel.com ([192.55.52.136]:54217 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbeLJTVG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Dec 2018 14:21:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 11:21:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,339,1539673200"; 
   d="scan'208";a="117211641"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga002.jf.intel.com with ESMTP; 10 Dec 2018 11:21:06 -0800
Message-ID: <59741ec56b5e89a8252dcd1e7df185a51ffbecf1.camel@linux.intel.com>
Subject: Re: [RFC] Proposed PCI ECR for description of Advanced Peer to Peer
 Capabilities
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        linux-pci@vger.kernel.org
Cc:     Logan Gunthorpe <logang@deltatee.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, Eric Wehage <Eric.Wehage@huawei.com>,
        linuxarm@huawei.com
Date:   Mon, 10 Dec 2018 11:21:05 -0800
In-Reply-To: <20181210115653.0000615a@huawei.com>
References: <20181210115653.0000615a@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2018-12-10 at 11:56 +0000, Jonathan Cameron wrote:
> Hi All,
> 
> This is perhaps a somewhat unusual RFC as it's to ask for feedback on an ECR
> that is currently under discussion in the PCI SIG.  That ECR, at least partly,
> came out of the issues highlighted during the discussion of P2PDMA.  In
> that patch set, p2pdma is only allowed if there is a switch between the
> devices involved ensuring the path does not pass through a root port.
> Put simply there is no way to know if a root complex will allow p2p or not.
> 
> So we are asking for feedback at a stage where modifications to the
> proposal can be made. Eric has agreed to this being shared with mailing list
> to hopefully get such feedback.  Note this is under active discussion within
> the SIG so inputs in that forum also welcome.
> 
> I would recommend reading the ECR and presentation for more details.
> Anyone who can't get to Google Drive, email me and I'll send a copy directly.
> 
> ECR: https://drive.google.com/open?id=1X08pfyjkNwSfpTVBuiut90ajxBZd7BXg
> Slides: https://drive.google.com/open?id=11d3egA8x91d99-QqfYGZ-MxLGrHpJHCK
> 
> My summary probably won't be great, but I'll give it a go to persuade people
> to look at the real docs!
> 
> Problem Statement:
> 
> Linux does not generally enable Peer to Peer because (amongst other reasons)
> it does not know which Root Complexes support Peer to Peer.
> 
> * Some Root Complexes do not support Peer to Peer
> * Some Root Complexes only support Posted Peer to Peer
> * Some Root Complexes only support Peer to Peer within one PCIe Segment
> * Some Root Complexes only support Address Decode Peer to Peer (no ID routing)
> * Some Root Complexes may not support Peer to Peer from Integrated End Points
> 
> Related other issue
> * MPS must be programmed the same across all devices supporting P2P
> * Hot plugged devices might require a smaller MPS than was programmed.
> 
> Solution:
> * New extended capability and control (though only one bit in the control)
> * Advertise what a Peer to Peer Root Port and Switch Down Stream ports can do.
> * Define packet splitting scheme for MPS mismatches.
> 	- Rules on how this must be done if supported.
> 
> All feedback welcome.  Let's make sure we get this right.
> 
> Thanks,
> 
> Jonathan Cameron
> Huawei

Looking this over some of this seems redundant with the ACS P2P Request
Redirect and Completion Redirect functionality.

I was curious if there was a reason why you couldn't use something like
that to at least get some early enabling going for peer-to-peer root
port pass through?

Also, I have not seen called out anywhere in your documents how this
might interact with something like Address Translation Services (ATS).
I'm assuming there would be scenarios where the translation agent would
need to be a part of the p2p topology.

Thanks.

- Alex

