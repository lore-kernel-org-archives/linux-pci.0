Return-Path: <SRS0=yvM8=O5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93E4C43387
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 10:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876D52177E
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 10:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545301402;
	bh=XWma2XPJuznOK89TRHvBTNLV0c15pSPzAfGlgu1x8Yw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zxAvtJSo8CaS+KUm+eOpcC6mDV/wwiPVWMnmVL5nkLsTRehPciUy3n0hQGRtPMKve
	 UEptDywOwOwT21X/KXx0Z/zNb53B0qHq27WGAHMyW6qNmWnzNCUYkqGbEY6IESaOB4
	 qe5Y7Meh+TtnIhmF2TQcbpRuLPqTboGR/6aSFQ+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbeLTKXV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Dec 2018 05:23:21 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45112 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730916AbeLTKXU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Dec 2018 05:23:20 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so1053586ota.12;
        Thu, 20 Dec 2018 02:23:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cYG26Qg9SApPpigCS+YSWy6vUPWrpRNw8QqkCPrAgjE=;
        b=nJNIB91gmcLh/Q6XI0aJoTzbjghjO1DGcNDA3CVvHPyey1/B4nWR9c5KWjuHuK3/Ye
         rJcCpfweGVsdfFsGitshajc8Tymb+/ZkoEUcFi91mL/9vBgDzjBgOSzIjPu1kXEfNWDT
         zOXCKoyYlWcU/unHC8TBQHFowMIQegwotO51FjJq2LCBWLkJW9rzlnwZilJVLrEu076S
         SnuG5NVfsM51szst3WwCGcYlWcIG24Uw7ieYqn6ZJ5D+DoDHNx/bcpyGmYsa6RFNcwiw
         ezKzWOvMj/cJuc7FB8h1aw9e6ztUpnkM22AK65sDqO4hfnHZLhCJmeLoImqgxRxagkvw
         1bhg==
X-Gm-Message-State: AA+aEWaxx4Fq2TS3VUFTCjTxLz81geSXLNv4zGd19T9t/rZZc5TZ49VQ
        UiHgwjZVrc3Tv00mjbFyHiJHcxzFK8O6WDjz5aY=
X-Google-Smtp-Source: AFSGD/Vudwv5MaEbOMiEI42993icnsuG+vA47y30LH98dClFPEe7uHby1ksrQ3qp05u0cKj4Jldt0ZsyPjsOciu5bWQ=
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr16175607otf.124.1545301399008;
 Thu, 20 Dec 2018 02:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20181204112048.35378-1-mika.westerberg@linux.intel.com>
 <20181217202827.GC28981@google.com> <20181218085518.GI2469@lahna.fi.intel.com>
 <20181218205850.GA12763@google.com> <20181219132324.GS2469@lahna.fi.intel.com>
 <20181219144518.GC12763@google.com> <20181219151558.GU2469@lahna.fi.intel.com>
 <20181219170915.3bojdcf7h7kiesyu@wunner.de> <20181220100642.GY2469@lahna.fi.intel.com>
In-Reply-To: <20181220100642.GY2469@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Dec 2018 11:23:07 +0100
Message-ID: <CAJZ5v0hZFY=TyGcP26dOGfGw4NAOaHkE4wjLTjsKUOFg7iCd2Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: Blacklist power management of Gigabyte X299
 DESIGNARE EX PCIe ports
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kedar.a.dongre@intel.com,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 20, 2018 at 11:06 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Wed, Dec 19, 2018 at 06:09:15PM +0100, Lukas Wunner wrote:
> > > I think better example where this fails is normal Thunderbolt device
> > > (not host) which includes PCIe switch and there is an PCIe endpoint, say
> > > network interface connected to one of the downstream ports. That
> > > downstream port has "Slot implemented" set but is not hotplug capable.
> > >
> > > So the device would work correctly but if you take the recent "Runtime
> > > D3, RTD3" system such as Lenovo Carbon X1 6th gen it keeps the whole
> > > PCIe hierarchy from entering D3cold. I would rather not to break that ;-)
> >
> > Yeah but as you say, those are Downstream Ports.  What if you constrain
> > it to Root Ports?
>
> Yes, that could work. I did not test it yet, though. Thinking this bit
> further maybe we can contstrain it to ports that have slot implemented
> set and have an ACPI companion instead of just root ports? Point being
> that ports without ACPI companion could not possibly get ACPI Notify()
> either.

I like this idea.  We can basically assume, at least to begin with,
that ACPI companions of PCIe ports are there for a reason.  That
reason very well may be to provide a way to handle notifications.
