Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B95C282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444FD217D9
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfDWQhU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:37:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728906AbfDWQhS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Apr 2019 12:37:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7C223D970;
        Tue, 23 Apr 2019 16:37:18 +0000 (UTC)
Received: from x1.home (ovpn-116-122.phx2.redhat.com [10.3.116.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C702E1001E71;
        Tue, 23 Apr 2019 16:37:15 +0000 (UTC)
Date:   Tue, 23 Apr 2019 10:37:15 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Alex G <mr.nuke.me@gmail.com>
Cc:     bhelgaas@google.com, helgaas@kernel.org, linux-pci@vger.kernel.org,
        austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/LINK: Account for BW notification in vector
 calculation
Message-ID: <20190423103715.044aab13@x1.home>
In-Reply-To: <e992aad4-a80d-53e1-deb7-8e4523b5027c@gmail.com>
References: <155597243666.19387.1205950870601742062.stgit@gimli.home>
        <d1126250-14e0-192c-f219-f143f62c9cdd@gmail.com>
        <20190422183347.51ba522c@x1.home>
        <84300da7-9bbd-4f32-c7fa-23724db60b88@gmail.com>
        <20190423093408.16b07efc@x1.home>
        <88bd2962-bce4-8259-c38f-1a7e9fdde300@gmail.com>
        <20190423102253.4fd9a019@x1.home>
        <e992aad4-a80d-53e1-deb7-8e4523b5027c@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 23 Apr 2019 16:37:18 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 23 Apr 2019 11:27:39 -0500
Alex G <mr.nuke.me@gmail.com> wrote:

> On 4/23/19 11:22 AM, Alex Williamson wrote:
> > Nor should pci-core decide what link speed changes are intended or
> > errors.  Minimally we should be enabling drivers to receive this
> > feedback.  Thanks,  
> 
> Not errors. pci core reports that a link speed change event has occured. 
> Period.

And it shows up in dmesg, and what do users (and developers) think when
things are repeatedly reported in dmesg?  Whether this is "information"
or "error", it's spamming dmesg, irrelevant, and confusing.  Thanks,

Alex
