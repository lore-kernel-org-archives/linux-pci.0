Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF59C433F4
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 06:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0476D2146E
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 06:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0476D2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbeITLyc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 07:54:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:36983 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731260AbeITLyc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 07:54:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 23:12:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,397,1531810800"; 
   d="scan'208";a="75812619"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.128])
  by orsmga006.jf.intel.com with ESMTP; 19 Sep 2018 23:12:33 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: add support for Immediate Readiness
In-Reply-To: <20180907061651.6156-1-felipe.balbi@linux.intel.com>
References: <20180906141355.GC214747@bhelgaas-glaptop.roam.corp.google.com> <20180907061651.6156-1-felipe.balbi@linux.intel.com>
Date:   Thu, 20 Sep 2018 09:12:32 +0300
Message-ID: <87o9csr92n.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi,

Felipe Balbi <felipe.balbi@linux.intel.com> writes:

> PCIe GEN4 defines, on section 7.5.1.1.4, a new bit on Status Register
> which tells us that:
>
> "Immediate Readiness – This optional bit, when Set, indicates the
> Function is guaranteed to be ready to successfully complete valid
> configuration accesses at any time following any reset that the host
> is capable of issuing Configuration Requests to this Function.
>
> When this bit is Set, for accesses to this Function, software is
> exempt from all requirements to delay configuration accesses following
> any type of reset, including but not limited to the timing
> requirements defined in Section 6.6.  How this guarantee is
> established is beyond the scope of this document.
>
> It is permitted that system software/firmware provide mechanisms that
> supersede the indication provided by this bit, however such
> software/firmware mechanisms are outside the scope of this
> specification."
>
> This means that all delays after a Conventional or Function Reset can
> be skipped.
>
> This patch reads such bit and caches its value in a flag inside struct
> pci_dev to be checked later if we should delay or can skip delays
> after a reset. While at that, also move the explicit msleep(100) call
> from pcie_flr() and pci_af_flr() to pci_dev_wait().
>
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>

A gentle reminder here

-- 
balbi
