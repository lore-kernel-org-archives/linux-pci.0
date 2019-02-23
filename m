Return-Path: <SRS0=oPQn=Q6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EC1C43381
	for <linux-pci@archiver.kernel.org>; Sat, 23 Feb 2019 06:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4FC2084F
	for <linux-pci@archiver.kernel.org>; Sat, 23 Feb 2019 06:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbfBWGt3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 23 Feb 2019 01:49:29 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:59047 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfBWGt3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Feb 2019 01:49:29 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 9A38B100D942B;
        Sat, 23 Feb 2019 07:49:26 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 268591D8E5; Sat, 23 Feb 2019 07:49:26 +0100 (CET)
Date:   Sat, 23 Feb 2019 07:49:26 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alex_Gagniuc@Dellteam.com
Cc:     mr.nuke.me@gmail.com, bhelgaas@google.com, Austin.Bolen@dell.com,
        keith.busch@intel.com, Shyam.Iyer@dell.com, okaya@kernel.org,
        linux-pci@vger.kernel.org, gustavo@embeddedor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/4] PCI: pciehp: Do not turn off slot if presence
 comes up after link
Message-ID: <20190223064926.mh24zzlj4xykwcjf@wunner.de>
References: <20190220012031.10741-1-mr.nuke.me@gmail.com>
 <20190220012031.10741-3-mr.nuke.me@gmail.com>
 <20190221073634.snvazxlzgvjhilaz@wunner.de>
 <dfeadc6798984cce965e2202e90fe0b0@ausx13mps321.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfeadc6798984cce965e2202e90fe0b0@ausx13mps321.AMER.DELL.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 22, 2019 at 07:56:28PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> On 2/21/19 1:36 AM, Lukas Wunner wrote:
> > On Tue, Feb 19, 2019 at 07:20:28PM -0600, Alexandru Gagniuc wrote:
> >>   	mutex_lock(&ctrl->state_lock);
> >> +	present = pciehp_card_present(ctrl);
> >> +	link_active = pciehp_check_link_active(ctrl);
> >>   	switch (ctrl->state) {
> > 
> > These two assignments appear to be superfluous as you're also performing
> > them in pciehp_check_link_active().
> 
> Not sure. Between the first check, and this check, you can have several 
> seconds elapse depending on whether the driver's .probe()/remove() is 
> invoked. Whatever you got at the beginning would be stale. If you had a 
> picture dictionary and looked up 'bad idea', it would have a picture of 
> the above code with the second check removed.

I don't quite follow.  You're no longer using the "present" and
"link_active" variables in pciehp_handle_presence_or_link_change(),
the variables are set again further down in the function and you're
*also* reading PDS and DLLLA in is_delayed_presence_up_event().
So the above-quoted assignments are superfluous.  Am I missing something?

(Sorry, I had copy-pasted the wrong function name, I meant
is_delayed_presence_up_event() above, not pciehp_check_link_active().


> I've got all the other review comments addressed in my local branch. I'm 
> waiting on Lord Helgass' decision on which solution is better.
             ^^^^^^^^^^^^

Can we keep this discussion in a neutral tone please?

Thanks,

Lukas
