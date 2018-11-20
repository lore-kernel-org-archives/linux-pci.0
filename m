Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946E5C5ACBA
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 21:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CFC2080F
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 21:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CFC2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbeKUIRN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:17:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:14530 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeKUIRN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Nov 2018 03:17:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 13:45:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,258,1539673200"; 
   d="scan'208";a="107936095"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 20 Nov 2018 13:45:57 -0800
Date:   Tue, 20 Nov 2018 14:42:43 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Alex_Gagniuc@Dellteam.com, mr.nuke.me@gmail.com,
        baicar.tyler@gmail.com, Austin.Bolen@dell.com, Shyam.Iyer@dell.com,
        lukas@wunner.de, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, ruscur@russell.cc, sbobroff@linux.ibm.com,
        oohall@gmail.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Message-ID: <20181120214243.GG26707@localhost.localdomain>
References: <20181119181051.GA26707@localhost.localdomain>
 <c0d6535f-324b-557a-3d0e-ccec070459a7@kernel.org>
 <3f923367-2cc1-c0d6-bca6-bf9a03d1b9ca@gmail.com>
 <ef6b19de-dd18-850f-4db9-8ab71b975e94@kernel.org>
 <bb575cfdcd0a4c50b489fb16eccfbff2@ausx13mps321.AMER.DELL.COM>
 <84013a8a-287d-d700-6710-91cc35f507c8@kernel.org>
 <9c9531c7efb846438f03f744b9afc466@ausx13mps321.AMER.DELL.COM>
 <3b18a9fa-7bdd-0fb4-285d-4efb454be50a@kernel.org>
 <e86f04ef8c054d61969862a6e7b72d0d@ausx13mps321.AMER.DELL.COM>
 <314e59da-48e1-545b-3ee9-6e5056b90fd9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <314e59da-48e1-545b-3ee9-6e5056b90fd9@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 20, 2018 at 04:02:21PM -0500, Sinan Kaya wrote:
> On 11/20/2018 3:44 PM, Alex_Gagniuc@Dellteam.com wrote:
> > I'd prefer "sure" instead of "think". "I think it breaks some system I'm
> > not telling you about" doesn't help much in figuring out how not to
> > break said system(s).:)
> 
> Sorry, I thought I mentioned why it would break but let me repeat.
> 
> The systems I have seen rely on the HEST table presence as an indicator
> to the OS that firmware first is enabled. If you go look at the _OSC bits
> on such systems, it still says OS owns the AER service.
> 
> The assumption here is that HEST table has precedence over the _OSC bits.
> That's what needs to be clarified in the UEFI forum.
> 
> If this code is to go in and ignore the HEST table presence, then firmware
> will think that it owns AER service and OS will think that it owns AER
> service too.

How does that work? If the OS takes control, it sets up MSIs that FW don't
react to, and disables system errors through PCIe Root Control. Aren't
those sys errs the mechanism FW knows it has something to do, which
means the OS can effectively fence it off?
