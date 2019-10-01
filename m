Return-Path: <SRS0=Tigv=X2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6469EECE58A
	for <linux-pci@archiver.kernel.org>; Tue,  1 Oct 2019 13:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1FF20842
	for <linux-pci@archiver.kernel.org>; Tue,  1 Oct 2019 13:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569936444;
	bh=hvuSU/zgSxL7X5McKtfL/85CgXAWQjA1PQjtADmotiw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=y8u4THtqSQPcai0+2I/WQgSwwZMJYNOhd3FBcpxH74bJGZaeTZyM1OrwNCLAMm5O7
	 W3iAgW0ekv7XSNmbE3XjjTuCGDEx4/3FtJqxYAgc8sB79zHy7nBi9ZODOQ5w065erR
	 PjxxDRA31g3Psjo/Kle7RY/FI9vd4QKwFRsLGVts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388365AbfJAN1X (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:27:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388261AbfJAN1X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Oct 2019 09:27:23 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74D8A205F4;
        Tue,  1 Oct 2019 13:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569936442;
        bh=hvuSU/zgSxL7X5McKtfL/85CgXAWQjA1PQjtADmotiw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PVl8ichgRH2Kry9emAcsBbZ3LVJ+BXT3BKBgqVD7LlciVOm0Yy/aHX7MX1Rjp1MC+
         txtKjbJ6YDnqZQPdw+SBr8J/Hw6rzAM1gCdbOzNkFgzG9wKOHKa064QGC0f4zR5Mq/
         gohadmur2spYz1z4zJEil6lV6/IG6t4VzozqcEAA=
Date:   Tue, 1 Oct 2019 08:27:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [RFC PATCH] pci: prevent putting pcie devices into lower device
 states on certain intel bridges
Message-ID: <20191001132721.GA46491@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACO55tuk4SA6-xUtJ-oRePy8MPXYAp2cfmSPxwW3J5nQuX3y2g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 30, 2019 at 06:36:12PM +0200, Karol Herbst wrote:
> On Mon, Sep 30, 2019 at 6:30 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Mon, Sep 30, 2019 at 06:05:14PM +0200, Karol Herbst wrote:
> > > still happens with your patch applied. The machine simply gets shut down.
> > >
> > > dmesg can be found here:
> > > https://gist.githubusercontent.com/karolherbst/40eb091c7b7b33ef993525de660f1a3b/raw/2380e31f566e93e5ba7c87ef545420965d4c492c/gistfile1.txt
> >
> > Looking your dmesg:
> >
> > Sep 30 17:24:27 kernel: nouveau 0000:01:00.0: DRM: DCB version 4.1
> > Sep 30 17:24:27 kernel: nouveau 0000:01:00.0: DRM: MM: using COPY for buffer copies
> > Sep 30 17:24:27 kernel: [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 on minor 1
> >
> > I would assume it runtime suspends here. Then it wakes up because of PCI
> > access from userspace:
> >
> > Sep 30 17:24:42 kernel: pci_raw_set_power_state: 56 callbacks suppressed
> >
> > and for some reason it does not get resumed properly. There are also few
> > warnings from ACPI that might be relevant:
> >
> > Sep 30 17:24:27 kernel: ACPI Warning: \_SB.PCI0.GFX0._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20190509/nsarguments-59)
> > Sep 30 17:24:27 kernel: ACPI Warning: \_SB.PCI0.PEG0.PEGP._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20190509/nsarguments-59)
> 
> afaik this is the case for essentially every laptop out there.

I think we should look into this a little bit.
acpi_ns_check_argument_types() checks the argument type and prints
this message, but AFAICT it doesn't actually fix anything or prevent
execution of the method, so I have no idea what happens when we
actually execute the _DSM.

If we execute this _DSM as part of power management, and the _DSM
doesn't work right, it would be no surprise that we have problems.

Maybe we could learn something by turning on ACPI_DB_PARSE output (see
Documentation/firmware-guide/acpi/debug.rst).

You must have an acpidump already from all your investigation.  Can
you put it somewhere, e.g., bugzilla.kernel.org, and include a URL?
