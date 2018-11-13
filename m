Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6162FC43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 22:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216852175B
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 22:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216852175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbeKNI4Z (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 14 Nov 2018 03:56:25 -0500
Received: from mga18.intel.com ([134.134.136.126]:31330 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbeKNI4Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Nov 2018 03:56:24 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 14:56:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,230,1539673200"; 
   d="scan'208";a="91817827"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga008.jf.intel.com with ESMTP; 13 Nov 2018 14:56:00 -0800
Date:   Tue, 13 Nov 2018 15:52:32 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Alex_Gagniuc@Dellteam.com
Cc:     helgaas@kernel.org, oohall@gmail.com, gregkh@linuxfoundation.org,
        mr.nuke.me@gmail.com, linux-pci@vger.kernel.org,
        Austin.Bolen@dell.com, Shyam.Iyer@dell.com,
        linux-kernel@vger.kernel.org, jonathan.derrick@intel.com,
        lukas@wunner.de, ruscur@russell.cc, sbobroff@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Message-ID: <20181113225232.GB10134@localhost.localdomain>
References: <20181108220117.GA11466@kroah.com>
 <20181108223258.GD2932@localhost.localdomain>
 <20181108224255.GA20619@kroah.com>
 <20d68e586fff4dcca5616d5056f6fc21@ausx13mps321.AMER.DELL.COM>
 <20181108225109.GA3023@kroah.com>
 <16bf9d14bc5f4a90b2b88dd2eb165186@ausx13mps321.AMER.DELL.COM>
 <5da8d8aa9f3818af649b1ac547bc4e6062626ddf.camel@gmail.com>
 <df85813c9860463d85f6c302dfe07b12@ausx13mps321.AMER.DELL.COM>
 <20181113050240.GA182139@google.com>
 <19136f44cd5c45e79bbef7e78a6bf332@ausx13mps321.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19136f44cd5c45e79bbef7e78a6bf332@ausx13mps321.AMER.DELL.COM>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 13, 2018 at 10:39:15PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> On 11/12/2018 11:02 PM, Bjorn Helgaas wrote:
> > The whole issue of firmware-first, the mechanism by which firmware
> > gets control, the System Error enables in Root Port Root Control
> > registers, etc., is very murky to me.  Jon has a sort of similar issue
> > with VMD where he needs to leave System Errors enabled instead of
> > disabling them as we currently do.
> 
> Well, OS gets control via _OSC method, and based on that it should 
> touch/not touch the AER bits. The bits that get set/cleared come from 
> _HPX method, and there's a more about the FFS described in ACPI spec. It 
> seems that if platform, wants to enable VMD, it should pass the correct 
> bits via _HPX. I'm curious to know in what new twisted way FFS doesn't 
> work as intended.

When VMD is enabled, the platform sees a VMD endpoint. It doesn't see
any of the root ports on that domain, so ACPI can't provide policies for
them nor AER registers for the platform to consider controlling.
