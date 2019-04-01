Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C1AC43381
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 21:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4F92133D
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 21:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554153237;
	bh=Lgdt0twy1g6qL1tYqpgMpCFN6e0QKzGNoBPyYjZknQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sHjrd+QnAYaKHKwNb7Z4b6l7v0hwVwet0bRZcfuHuTq6I9TgOmrW5vDWAx0+cOIBR
	 aBng3aiwNc+ac5rX2c2VDFUFYFAFYIJAvBRz0xIH2HoJVja0W69QqC742eNHb3yNEd
	 HO8Tdet4K+D60jhg/OHPK5mYVY27xmCs1NxwZNHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfDAVN4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:13:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbfDAVN4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Apr 2019 17:13:56 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 566CA20880;
        Mon,  1 Apr 2019 21:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554153235;
        bh=Lgdt0twy1g6qL1tYqpgMpCFN6e0QKzGNoBPyYjZknQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NWrCTEmnN/wgWiDVSzXoWa0p0mBy43IyCJFbjJSgEfGhRsSLtrUmDnqkuuFqmUZw8
         +GcNScO5mB51EukXQ4X9cXeEH5zeoVtelLtMIFhKJn7vvpPnzT1xQjq2Y2jrEApKwj
         XAPhWQXGdwtp3pRrHkgYh/7DVdlb6F/vYFIAHMy4=
Date:   Mon, 1 Apr 2019 16:13:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jesse Hathaway <jesse@mbuki-mvuki.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org
Subject: Re: Regression causes a hang on boot with a Comtrol PCI card
Message-ID: <20190401211353.GA7263@google.com>
References: <CANSNSoWiKd98Dt1N2sSjP9Af8zk1NPV-=3P4VLtFs_cSQG4RUg@mail.gmail.com>
 <20190313232112.GC210027@google.com>
 <CANSNSoXPFDu9RQAUA6dUCUrSCAj68q-Nj2W7ECz3fKpFtSNU+Q@mail.gmail.com>
 <20190321232310.GL251185@google.com>
 <CANSNSoXhiYP4Ad3hO1v03aMOX1VtUao2yCLgj_J0z9fCNwWo5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANSNSoXhiYP4Ad3hO1v03aMOX1VtUao2yCLgj_J0z9fCNwWo5w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Mathias, Greg, Alan, linux-usb]

Beginning of thread: https://lore.kernel.org/linux-pci/CANSNSoWiKd98Dt1N2sSjP9Af8zk1NPV-=3P4VLtFs_cSQG4RUg@mail.gmail.com

Synopsis: v5.0 hangs at boot unless the following commits are reverted:

  1302fcf0d03e ("PCI: Configure *all* devices, not just hot-added ones")
  1c3c5eab1715 ("sched/core: Enable might_sleep() and smp_processor_id() checks early")

The hang appears to be in quirk_usb_early_handoff().  With
"initcall_debug", we see the call but not the completion:

On Fri, Mar 22, 2019 at 03:02:11PM -0500, Jesse Hathaway wrote:
> > So apparently the hang happens while we're running the "final" PCI
> > fixups.  This happens after all the rest of PCI is initialized.
> >
> > Can you boot v5.0 vanilla with "initcall_debug"?  Maybe we can narrow
> > it down to a specific quirk.
> 
> yup, added the "initcall_debug" output to the ticket:
> https://bugzilla.kernel.org/show_bug.cgi?id=202927, here is the tail end
> 
> [   14.896337] NET: Registered protocol family 1
> [   14.901314] initcall af_unix_init+0x0/0x4e returned 0 after 4866 usecs
> [   14.908694] calling  ipv6_offload_init+0x0/0x7f @ 1
> [   14.914238] initcall ipv6_offload_init+0x0/0x7f returned 0 after 1 usecs
> [   14.921821] calling  vlan_offload_init+0x0/0x20 @ 1
> [   14.927365] initcall vlan_offload_init+0x0/0x20 returned 0 after 0 usecs
> [   14.934948] calling  pci_apply_final_quirks+0x0/0x126 @ 1
> [   14.941106] pci 0000:00:1a.0: calling  quirk_usb_early_handoff+0x0/0x6a0 @ 1
> 
> thanks, Jesse Hathaway
