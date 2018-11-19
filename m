Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E887FC43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 18:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FC9206BA
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 18:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FC9206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbeKTEir (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:38:47 -0500
Received: from mga07.intel.com ([134.134.136.100]:60223 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729975AbeKTEir (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Nov 2018 23:38:47 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 10:14:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,253,1539673200"; 
   d="scan'208";a="87643713"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 19 Nov 2018 10:14:06 -0800
Date:   Mon, 19 Nov 2018 11:10:51 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Tyler Baicar <baicar.tyler@gmail.com>, mr.nuke.me@gmail.com,
        austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        Shyam_Iyer@dell.com, lukas@wunner.de, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, ruscur@russell.cc,
        sbobroff@linux.ibm.com, oohall@gmail.com,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Message-ID: <20181119181051.GA26707@localhost.localdomain>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
 <b9a739c8-80bd-e04c-ac19-97bc54f20eff@kernel.org>
 <CABo9ajD5GJY7MrMjQc3hE=4tpPKpeceMtVEHwCwgjrvJUYjLvg@mail.gmail.com>
 <20181119165318.GB26595@localhost.localdomain>
 <74f2c527-0890-5e14-5e2d-48934a42dae6@kernel.org>
 <ab2427f1-c1f0-68fe-5335-1494caafdcbb@kernel.org>
 <20181119174127.GE26595@localhost.localdomain>
 <ef0a24e4-906e-f6df-c646-1fe47ea0dcc0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef0a24e4-906e-f6df-c646-1fe47ea0dcc0@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 19, 2018 at 12:56:56PM -0500, Sinan Kaya wrote:
> On 11/19/2018 12:41 PM, Keith Busch wrote:
> > > Still, breaking existing systems that rely on HEST table is not cool.
> > > I'd rather have users specify "pcie_ports=native" to skip FF rather than
> > > having broken systems by default to be honest.
> > The pcie_ports=native work-around ignores FF to potentially unknown
> > results, though.
> > 
> 
> How about being able to enable/disable FF in BIOS?
>
> We can't really turn off firmware first in the kernel without asking help
> from the firmware.

The _OSC method this patch utilizes is the ACPI spec defined way for
the kernel to wrest control from firmware. BIOS specific menu settings
shouldn't be our only recourse when we have a spec authority defining
generic OS interfaces to accomplish the same thing.

Unless there is a disagreement on the _OSC interpreation, we'd have to
accept that platforms breaking from this patch are non-compliant.

> Like you said, it causes unpredictable results.
>
> There will be two competing software trying to touch the same registers.
