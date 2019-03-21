Return-Path: <SRS0=33lb=RY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88519C43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 23:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB50218D3
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 23:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553210594;
	bh=6NHF+LBYMUEWWh8l4e7S4BOyNLjduudNq+et3aJp1Rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xxbV8KJ10hmpwAwO4XOz2uJMSojzTaKmw6xXZnkMP/qv4r0OA4XUFrqH0W290vpTS
	 XYtCFz9XUH3VxKiw4GYRG4ol+y6KPlbGnD1hKGnEMomv3LuWYJkLZI1iZfSoXvdckP
	 Lle5gE14+/GMh+1ij2WCnY6WLZMsFkJZ/BMESZgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfCUXXN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:23:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfCUXXN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Mar 2019 19:23:13 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1743E21874;
        Thu, 21 Mar 2019 23:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553210592;
        bh=6NHF+LBYMUEWWh8l4e7S4BOyNLjduudNq+et3aJp1Rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K8UINJe5hQavzhBgazIvZJ2J/clgnHPHYUDQQ5EOFM/tDxLyNWyiCPRB+Idn19ykk
         H3bgiV8yNQgwG8xKoT9EFqVlBzQ0fUDyoCSprL/+PZOuV3Q94EWFGKmdnV08dB7ptE
         6sEir2nGo2vR7+Kp7j40hTUyQqWnPqBgVpUcIIuY=
Date:   Thu, 21 Mar 2019 18:23:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jesse Hathaway <jesse@mbuki-mvuki.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: Regression causes a hang on boot with a Comtrol PCI card
Message-ID: <20190321232310.GL251185@google.com>
References: <CANSNSoWiKd98Dt1N2sSjP9Af8zk1NPV-=3P4VLtFs_cSQG4RUg@mail.gmail.com>
 <20190313232112.GC210027@google.com>
 <CANSNSoXPFDu9RQAUA6dUCUrSCAj68q-Nj2W7ECz3fKpFtSNU+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANSNSoXPFDu9RQAUA6dUCUrSCAj68q-Nj2W7ECz3fKpFtSNU+Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 14, 2019 at 03:57:07PM -0500, Jesse Hathaway wrote:
> > > 1302fcf0d03e (refs/bisect/bad) PCI: Configure *all* devices, not just
> > > hot-added ones
> > > 1c3c5eab1715 sched/core: Enable might_sleep() and smp_processor_id()
> > > checks early
> >
> > How did you narrow it down to *two* commits, and do you have to revert
> > both of them to avoid the hang?  Usually a bisection identifies a
> > single commit, and the two you mention aren't related.
> 
> Sorry I should have been more verbose in what the bisection process was, I
> found the problem after attempting to upgrade from linux v3.16 to v4.9. When
> v4.9 hung I tried the latest kernel, v5.0, which also hanged. I began a git
> bisect, but found there was more than one bad commit. Here is my current
> understanding:
> 
> - [x] v3.18 vanilla, 1302fcf0d03e committed, hangs
> - [x] v3.18 with revert of 1302fcf0d03e, works
> .
> .
> .
> - [x] v4.12 vanilla, hangs
> - [x] v4.12 with revert of 1302fcf0d03e, works
> 
> - [x] v4.13 vanilla, 1c3c5eab1715 committed, hangs
> - [x] v4.13 with revert of 1302fcf0d03e, hangs
> - [x] v4.13 with revert of 1c3c5eab1715, hangs
> - [x] v4.13 with revert of 1302fcf0d03e & 1c3c5eab1715, works
> 
> - [x] v5.0 vanilla, hangs
> - [x] v5.0 with revert of 1302fcf0d03e & 1c3c5eab1715, works

Thanks!  I doubt either of those commits is the real problem, but
they're both related to system_state, so it's conceivable they're both
involved in exposing the problem.

> > Can you collect a complete dmesg log (with a working kernel) and
> > output of "sudo lspci -vvxxx"?  You can open a bug report at
> > https://bugzilla.kernel.org, attach the logs there, and respond here
> > with the URL.
> 
> Bug submitted along with the requested logs,
> https://bugzilla.kernel.org/show_bug.cgi?id=202927

Thanks for that.

> > Where does the hang happen?  Is it when we configure the Comtrol card?
> 
> Hang occurs after PCI is initialized, snippet below, I have included the full
> output in the bug report:
> 
> [   10.561971] pci 0000:81:00.0:   bridge window [mem 0xc8000000-0xc80fffff]
> [   10.569661] pci 0000:80:01.0: PCI bridge to [bus 81-82]
> [   10.575594] pci 0000:80:01.0:   bridge window [mem 0xc8000000-0xc80fffff]
> [   10.583278] pci 0000:80:03.0: PCI bridge to [bus 83]
> [   10.589008] NET: Registered protocol family 2
> [   10.594254] tcp_listen_portaddr_hash hash table entries: 65536
> (order: 8, 1048576 bytes)
> [   10.603671] TCP established hash table entries: 524288 (order: 10,
> 4194304 bytes)
> [   10.612729] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
> [   10.620446] TCP: Hash tables configured (established 524288 bind 65536)
> [   10.628124] UDP hash table entries: 65536 (order: 9, 2097152 bytes)
> [   10.635541] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes)
> [   10.643669] NET: Registered protocol family 1

The successful boot continues on with this:

  [   10.675996] pci 0000:00:1a.0: quirk_usb_early_handoff+0x0/0x6a0 took 22519 usecs
  [   10.684519] pci 0000:03:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD for)
  [   10.696404] pci 0000:03:00.0: quirk_blacklist_vpd+0x0/0x30 took 11605 usecs
  [   10.704515] pci 0000:0b:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]

So apparently the hang happens while we're running the "final" PCI
fixups.  This happens after all the rest of PCI is initialized.

Can you boot v5.0 vanilla with "initcall_debug"?  Maybe we can narrow
it down to a specific quirk.

Bjorn
