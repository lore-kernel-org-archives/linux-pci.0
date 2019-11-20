Return-Path: <SRS0=MVLW=ZM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6717BC432C0
	for <linux-pci@archiver.kernel.org>; Wed, 20 Nov 2019 12:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399D2224EA
	for <linux-pci@archiver.kernel.org>; Wed, 20 Nov 2019 12:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574252105;
	bh=4QJHgQHDvaoWeAyvjizKeoiE+mIxdxqSM3J97N1o3N0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WBdQ+RbqGRX7QNGyoMz1D0KG9jSA74qhLPog5VNV3wqtEvbm3fQSPkKhxdm0x/e++
	 FrDsJC+Qw1vsITCC3tpu3lxT9t7zJ0NNEFbibYJHNcfpuic8F7ln4XRtiB6svLbAW0
	 urb0q7KlVUI741gknV2vGXO7X83Uvmgzb82Qa+Zk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfKTMPE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:15:04 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43537 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbfKTMPE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Nov 2019 07:15:04 -0500
Received: by mail-oi1-f194.google.com with SMTP id l20so22253045oie.10;
        Wed, 20 Nov 2019 04:15:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=esEo2BOJu3uyThpaIy1S5JuOd1hwwX4sFEOY2HfR0sY=;
        b=BNz1llbE9omfbgmbPx7tSN42wVtd2RA8WeNPt2O/mCkIlocvjU1agInHeZTSdr8md0
         G5iAo3JdjtYd3aSgKffbTaLaljWCMNzHXQ+LZaXEtQyTDX6ehRHQTlsgHXt/Gco94uHs
         KjtPGJ9am0HvWcgMy18WTWp+km8NdPFV6Clska6KPsmv2kLjbaHAYZCIbdiTPq1j6NeG
         jv3+017q7i0PEa6gUjJKmuDcLnLn5TcuLWY9qpYafgQjHz+on1R9V8oawJyEoiKS+Pwk
         E+v/f6iHHge046FsYRZmzeF2bMyEZ7jXBEo3NLoVXa2gRYJO8irdYt0EOVMennd86+hj
         hsbw==
X-Gm-Message-State: APjAAAWlSMF5/62BrCucYo/10fYQOqmeJv5/4+BG30D0lEYR5V37+90B
        pInW2CqLkwbuUVoPTkDQSO9l4QDQresXIJV9YKk=
X-Google-Smtp-Source: APXvYqzm1rGGZ89lrgIDdkz3K9d/ltWTXiE3VIQlWxc9OTBjh+eklJP/fHtUrR92Ig1jPf966ZhegrG39d2NMig/rp0=
X-Received: by 2002:aca:530c:: with SMTP id h12mr2615449oib.110.1574252103376;
 Wed, 20 Nov 2019 04:15:03 -0800 (PST)
MIME-Version: 1.0
References: <20191017121901.13699-1-kherbst@redhat.com> <20191119214955.GA223696@google.com>
 <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
 <20191120101816.GX11621@lahna.fi.intel.com> <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
 <20191120112212.GA11621@lahna.fi.intel.com> <CAJZ5v0in4VSULsfLshHxhNLf+NZxVQM0xx=hzdNa2X3FW=V7DA@mail.gmail.com>
 <CACO55tsjj+xkDjubz1J=fsPecW4H_J8AaBTeaMm+NYjp8Kiq8g@mail.gmail.com>
 <CAJZ5v0ithxMPK2YxfTUx_Ygpze2FMDJ6LwKwJb2vx89dfgHX_A@mail.gmail.com> <CACO55tupFbq0T1DcR+C+YxtPR=csPBQhwVXz_SHWT5F8bRK8JA@mail.gmail.com>
In-Reply-To: <CACO55tupFbq0T1DcR+C+YxtPR=csPBQhwVXz_SHWT5F8bRK8JA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Nov 2019 13:14:51 +0100
Message-ID: <CAJZ5v0h_ymqsoOVm9s2h5X0ejYdM4x03H7xPQ38uiO009OVgpQ@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Karol Herbst <kherbst@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 20, 2019 at 1:10 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> On Wed, Nov 20, 2019 at 1:06 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Nov 20, 2019 at 12:51 PM Karol Herbst <kherbst@redhat.com> wrote:
> > >
> > > On Wed, Nov 20, 2019 at 12:48 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Wed, Nov 20, 2019 at 12:22 PM Mika Westerberg
> > > > <mika.westerberg@intel.com> wrote:
> > > > >
> > > > > On Wed, Nov 20, 2019 at 11:52:22AM +0100, Rafael J. Wysocki wrote:
> > > > > > On Wed, Nov 20, 2019 at 11:18 AM Mika Westerberg
> > > > > > <mika.westerberg@intel.com> wrote:
> > > > > > >
> >
> > [cut]
> >
> > > > > >
> > > > > > Oh, so does it look like we are trying to work around AML that tried
> > > > > > to work around some problematic behavior in Linux at one point?
> > > > >
> > > > > Yes, it looks like so if I read the ASL right.
> > > >
> > > > OK, so that would call for a DMI-based quirk as the real cause for the
> > > > issue seems to be the AML in question, which means a firmware problem.
> > > >
> > >
> > > And I disagree as this is a linux specific workaround and windows goes
> > > that path and succeeds. This firmware based workaround was added,
> > > because it broke on Linux.
> >
> > Apparently so at the time it was added, but would it still break after
> > the kernel changes made since then?
> >
> > Moreover, has it not become harmful now?  IOW, wouldn't it work after
> > removing the "Linux workaround" from the AML?
> >
> > The only way to verify that I can see would be to run the system with
> > custom ACPI tables without the "Linux workaround" in the AML in
> > question.
> >
>
> the workaround is not enabled by default, because it has to be
> explicitly enabled by the user.

I'm not sure what you are talking about.

I'm taking specifically about the ((OSYS == 0x07DF) && (_REV == 0x05))
check mentioned by Mika which doesn't seem to depend on user input in
any way.
