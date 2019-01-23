Return-Path: <SRS0=s0ql=P7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58819C282C0
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 18:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0FA21855
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 18:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfAWSpy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:45:54 -0500
Received: from mga18.intel.com ([134.134.136.126]:30055 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbfAWSpy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jan 2019 13:45:54 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2019 10:45:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,512,1539673200"; 
   d="scan'208";a="109201763"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 23 Jan 2019 10:45:53 -0800
Date:   Wed, 23 Jan 2019 11:44:53 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Alex_Gagniuc@Dellteam.com
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com, lukas@wunner.de,
        Austin.Bolen@dell.com
Subject: Re: PCI: hotplug: Erroneous removal of hotplug PCI devices
Message-ID: <20190123184453.GB6629@localhost.localdomain>
References: <356432a0556d4da59f8ba5cf1d750019@ausx13mps317.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <356432a0556d4da59f8ba5cf1d750019@ausx13mps317.AMER.DELL.COM>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 23, 2019 at 06:20:57PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> Hi all,
> 
> This may be a mind-twisting explanation, so pleas bear with me.
> 
> In PCIe, the presence detect bit (PD) in the slot status register should 
> be a logical OR of in-band and out-of band presence. In-band presence is 
> the data link layer status. So one would expect that a link up event, 
> would be accompanied by a PD changed event with PD set. Not everyone 
> follows that.
>
> I have a system here with the following order of events:
>   *   0 ms : Link up
>   * 400 ms : Presence detect up
> On the first event, the device is probed as expected, and on the second 
> event, the device is removed as a SURPRISE!!!_REMOVAL. This is a bug.
> 
> The logic is that on every change of presence detect:
> /* Even if [the slot]'s occupied again, we cannot assume the card is the 
> same. */
> Reasonable, but the resulting behavior is a bug.
> 
> Solution 1 is to say it's a spec violation, so ignore it. They'll change 
> the "logical OR" thing in the next PCIe spec, so we still will have to 
> worry about this.

When's that changing? 5.0 is the next spec, and it still says:

  Presence Detect State - This bit indicates the presence of an adapter
  in the slot, reflected by the logical “OR” of the Physical Layer
  in-band presence detect mechanism and, if present, any out-of-band
  presence detect mechanism defined for the slot’s corresponding
  form factor.

> It's obvious that just relying on presence detect state is prone to race 
> conditions. However, if a device is replaced, we'd expect the data link 
> layer state to change as well. So I think the best way to proceed is to 
> skip the SURPRISE!!!_REMOVAL if the following are true:
>   * presence detect is set
>   * DLL changed is not set
>   * presence detect was not previously set
> 
> Thoughts?

What is the value of PDS on the Link up event? If it's still "Slot
Empty", could we just ignore the Link event instead and wait for the PDC
event?
