Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9187C282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 20:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97AE6217D7
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 20:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfAXUVU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:21:20 -0500
Received: from mga03.intel.com ([134.134.136.65]:7421 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfAXUVT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jan 2019 15:21:19 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 12:21:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,518,1539673200"; 
   d="scan'208";a="119235250"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jan 2019 12:21:18 -0800
Date:   Thu, 24 Jan 2019 13:20:20 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Austin.Bolen@dell.com
Cc:     Alex_Gagniuc@Dellteam.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, lukas@wunner.de
Subject: Re: PCI: hotplug: Erroneous removal of hotplug PCI devices
Message-ID: <20190124202020.GB9600@localhost.localdomain>
References: <356432a0556d4da59f8ba5cf1d750019@ausx13mps317.AMER.DELL.COM>
 <20190123184453.GB6629@localhost.localdomain>
 <b32e6ca62ae2494f98450df81ca1ee14@AUSX13MPC131.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b32e6ca62ae2494f98450df81ca1ee14@AUSX13MPC131.AMER.DELL.COM>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[in plain text for the mailing lists]

On Thu, Jan 24, 2019 at 08:10:47PM +0000, Austin.Bolen@dell.com wrote:
> On 1/23/2019 12:46 PM, Keith Busch wrote:
> 
> On Wed, Jan 23, 2019 at 06:20:57PM +0000, Alex_Gagniuc@Dellteam.com<mailto:Alex_Gagniuc@Dellteam.com> wrote:
> 
> 
> <snip>
> 
> Solution 1 is to say it's a spec violation, so ignore it. They'll change
> the "logical OR" thing in the next PCIe spec, so we still will have to
> worry about this.
> 
> 
> 
> When's that changing? 5.0 is the next spec, and it still says:
> 
>   Presence Detect State - This bit indicates the presence of an adapter
>   in the slot, reflected by the logical "OR" of the Physical Layer
>   in-band presence detect mechanism and, if present, any out-of-band
>   presence detect mechanism defined for the slot's corresponding
>   form factor.
> 
> 
> The ECN that changes this behavior (Async Hot-Plug Updates ECN) is
> ratified and published to the PCI-SIG website.  It modifies PCIe Base
> Spec 4.0 and will be incorporated into PCIe Base Spec 5.0.  Check out
> the ECN section titled "In-band Presence Detect Mechanism Deprecated
> for Async Hot-Plug".

My copy of the 5.0-0.9 spec missed out on this ECN. The new changes look
like it more clearly defines expected software and hardware behavior,
so I'm looking forward to seeing the hardware implementations. Thanks
for driving that.
