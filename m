Return-Path: <SRS0=J54v=4T=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3F1C3F2D7
	for <linux-pci@archiver.kernel.org>; Mon,  2 Mar 2020 17:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09673222C4
	for <linux-pci@archiver.kernel.org>; Mon,  2 Mar 2020 17:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgCBRh3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:37:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:10521 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbgCBRh3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Mar 2020 12:37:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 09:37:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="228535252"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by orsmga007.jf.intel.com with ESMTP; 02 Mar 2020 09:37:28 -0800
Date:   Mon, 2 Mar 2020 09:37:28 -0800
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Spassov, Stanislav" <stanspas@amazon.de>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Wang, Wei" <wawei@amazon.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Schoenherr, Jan H." <jschoenh@amazon.de>,
        "rajatja@google.com" <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 1/3] PCI: Make PCIE_RESET_READY_POLL_MS configurable
Message-ID: <20200302173728.GA77115@otc-nc-03>
References: <20200227214534.GA143139@google.com>
 <e162efcd-70fd-3390-2452-4915af1c9171@kernel.org>
 <20200228021855.GA57330@otc-nc-03>
 <51d5948e-8d53-432e-8ec2-46704c3e8d41@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51d5948e-8d53-432e-8ec2-46704c3e8d41@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 02, 2020 at 11:39:39AM -0500, Sinan Kaya wrote:
> On 2/27/2020 9:18 PM, Raj, Ashok wrote:
> >> If I remember right, there was no time mention about how long to
> >> wait. Spec says device should send CRS as long as it is not ready.
> > Not exactly.. there are some requirements to follow for rules after
> > a conventional reset. 
> 
> Yes, but CRS happens after functional reset, D3hot etc. too not just
> conventional reset.
> 
> 1 second is too aggressive. We already have proof that several PCIe
> cards take their time during FLR especially FPGA cards in the orders
> of 10 seconds.

Aren't the rules specified in 7.9.17 Rediness Time Reporting Extended Capability
sufficient to cover this?

If a device doesn't have them we could let the driver supply this value
as a device specific value to override the default.

> 
> Current code is waiting up to 60 seconds. If card shows up before that
> we happily return.
> 

But in 7.9.17.2 Readiness Time Reporting 1 Register, says devices
can defer reporting by not setting the valid bit, but if it remains
clear after 60s system software can assume no valid values will be reported.

Maybe keep the system default to something more reasonable (after some
testing in the community), and do this insane 60s for devices that 
support the optional reporting capability?

Cheers,
Ashok
