Return-Path: <SRS0=XjPq=NT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B54ECDE4B
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 21:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3012020840
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 21:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3012020840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbeKIHaH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:30:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:1865 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbeKIHaG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Nov 2018 02:30:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 13:52:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,480,1534834800"; 
   d="scan'208";a="90590978"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga008.jf.intel.com with ESMTP; 08 Nov 2018 13:52:39 -0800
Date:   Thu, 8 Nov 2018 14:49:00 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-pci@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        linux-kernel@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Message-ID: <20181108214900.GB2932@localhost.localdomain>
References: <20180918221501.13112-1-mr.nuke.me@gmail.com>
 <20181107234257.GC41183@google.com>
 <20181108200855.GE41183@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108200855.GE41183@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 08, 2018 at 02:09:17PM -0600, Bjorn Helgaas wrote:
> 
> I'm having second thoughts about this.  One thing I'm uncomfortable
> with is that sprinkling pci_dev_is_disconnected() around feels ad hoc
> instead of systematic, in the sense that I don't know how we convince
> ourselves that this (and only this) is the correct place to put it.

You know how the kernel provides ZERO_PAGE, wouldn't it be cool if we
also had a ONES_PAGE and could remap all virtual addresses from a memory
mapped device to that page on an ungraceful disconnect? I do not know
how to accomplish that, so might just be crazy talk... But if it is
possible, that would be a pretty nifty way to solve this problem.
