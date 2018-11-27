Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25E2C43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 22:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9534420659
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 22:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9534420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbeK1JlZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:41:25 -0500
Received: from mga04.intel.com ([192.55.52.120]:13435 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbeK1JlZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Nov 2018 04:41:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 14:42:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,288,1539673200"; 
   d="scan'208";a="115934627"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga001.fm.intel.com with ESMTP; 27 Nov 2018 14:41:59 -0800
Date:   Tue, 27 Nov 2018 15:39:02 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Roy Shterman <roys@lightbitslabs.com>,
        Ofer Hayut <ofer@lightbitslabs.com>,
        Yinghai Lu <yinghai@kernel.org>
Subject: Re: Questions about pci_bridge_check_ranges()
Message-ID: <20181127223901.GD6401@localhost.localdomain>
References: <34458c2d-0faf-e9c1-55fd-7ade553a2b45@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34458c2d-0faf-e9c1-55fd-7ade553a2b45@grimberg.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 27, 2018 at 02:22:48PM -0800, Sagi Grimberg wrote:
> Hi,
> 
> During a rescan process, pci bridge regions capabilities are
> re-verified. In particular, prefetchable regions are checked for 64-bit
> addressing support. This check is done by reading the base-address
> register 4 LSBs.
> 
> Then, we "double check" that the bridge support 64-bit prefetchable
> addresses. This double-check is done by writing ones to the base-address
> buffer (high 32-bit), and check if we read zeros [1].
> 
> Questions:
> 1. Why do we need to "double-check"?
> 2. What is expected to happen if a memory transaction arrive to this
>    port during this process, while its base-address is miss-configured?
>    (say, a read-transaction issued by a peer device)

I think has something to do with how pbus_size_mem() assumes a
64-bit window will not have a 32-bit resource. If a bridge has a
prefetchable window, but happens to contain an address < 4GB, we clear
the IORESOURCE_MEM_64 flag so that it can get a resource.
