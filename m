Return-Path: <SRS0=ph/K=S7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B289C43219
	for <linux-pci@archiver.kernel.org>; Mon, 29 Apr 2019 16:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3AA2087B
	for <linux-pci@archiver.kernel.org>; Mon, 29 Apr 2019 16:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfD2Q72 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 29 Apr 2019 12:59:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728695AbfD2Q72 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Apr 2019 12:59:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 214813091784;
        Mon, 29 Apr 2019 16:59:28 +0000 (UTC)
Received: from x1.home (ovpn-116-122.phx2.redhat.com [10.3.116.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4406B1001E63;
        Mon, 29 Apr 2019 16:59:27 +0000 (UTC)
Date:   Mon, 29 Apr 2019 10:59:26 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Sinan Kaya <Okaya@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, mr.nuke.me@gmail.com,
        linux-pci@vger.kernel.org, austin_bolen@dell.com,
        alex_gagniuc@dellteam.com, keith.busch@intel.com,
        Shyam_Iyer@Dell.com, lukas@wunner.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add link_change error handler and vfio-pci user
Message-ID: <20190429105926.209d17d3@x1.home>
In-Reply-To: <76169da9-36cd-6754-41e7-47c8ef668648@kernel.org>
References: <155605909349.3575.13433421148215616375.stgit@gimli.home>
        <20190424175758.GC244134@google.com>
        <20190429085104.728aee75@x1.home>
        <76169da9-36cd-6754-41e7-47c8ef668648@kernel.org>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 29 Apr 2019 16:59:28 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 29 Apr 2019 09:45:28 -0700
Sinan Kaya <Okaya@kernel.org> wrote:

> On 4/29/2019 10:51 AM, Alex Williamson wrote:
> > So where do we go from here?  I agree that dmesg is not necessarily a
> > great choice for these sorts of events and if they went somewhere else,
> > maybe I wouldn't have the same concerns about them generating user
> > confusion or contributing to DoS vectors from userspace drivers.  As it
> > is though, we have known cases where benign events generate confusing
> > logging messages, which seems like a regression.  Drivers didn't ask
> > for a link_change handler, but nor did they ask that the link state to
> > their device be monitored so closely.  Maybe this not only needs some
> > sort of change to the logging mechanism, but also an opt-in by the
> > driver if they don't expect runtime link changes.  Thanks,  
> 
> Is there anyway to detect autonomous hardware management support and
> not report link state changes in that situation?
> 
> I thought there were some capability bits for these.

Not that we can find, this doesn't trigger the separate autonomous
bandwidth notification interrupt.  Thanks,

Alex
