Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8284C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 15:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A923217D9
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 15:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfDWPtX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:49:23 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:45915 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbfDWPtX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 11:49:23 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id EDAC12800B3C2;
        Tue, 23 Apr 2019 17:49:20 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9123F5B529; Tue, 23 Apr 2019 17:49:20 +0200 (CEST)
Date:   Tue, 23 Apr 2019 17:49:20 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Alex G <mr.nuke.me@gmail.com>, bhelgaas@google.com,
        helgaas@kernel.org, linux-pci@vger.kernel.org,
        austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, okaya@kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/LINK: Account for BW notification in vector
 calculation
Message-ID: <20190423154920.uytvswrxx7plv3dh@wunner.de>
References: <155597243666.19387.1205950870601742062.stgit@gimli.home>
 <d1126250-14e0-192c-f219-f143f62c9cdd@gmail.com>
 <20190422183347.51ba522c@x1.home>
 <84300da7-9bbd-4f32-c7fa-23724db60b88@gmail.com>
 <20190423093408.16b07efc@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423093408.16b07efc@x1.home>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 23, 2019 at 09:34:08AM -0600, Alex Williamson wrote:
> On Tue, 23 Apr 2019 09:33:53 -0500 Alex G <mr.nuke.me@gmail.com> wrote:
> > 0.5W savings on a 100+W GPU? I agree it's meaningless.
> 
> Evidence?  Regardless, I don't have control of the driver that's making
> these changes, but the claim seems unfounded and irrelevant.

On laptops, 0.5 W can result in noticeably longer battery life.

> I can see why we might want to
> be notified of degraded links due to signal issues, but what I'm
> reporting is that there are also entirely normal and benign reasons
> that a link might be reduced, we can't seem to tell the difference
> between a fault and this normal dynamic scaling, and the assumption of
> a fault is spamming dmesg.  So, I don't think what we have here is well
> cooked.  Do drivers have a mechanism to opt-out of this error
> reporting?

Is dmesg spammed even if no driver is bound to a GPU?  If so, that would
suggest a solution that's not dependent on drivers.  E.g., the
bw_notification port service could avoid reports for devices matching
PCI_BASE_CLASS_DISPLAY.  (It could also avoid binding to ports whose
children include such a device, but the child may be hot-pluggable
and thus appear only after the port is bound.)  Then we'd still get
a notification on boot about degraded link speed, but not continuous
messages.

Thanks,

Lukas
