Return-Path: <SRS0=XHdA=MO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCE5C64EBD
	for <linux-pci@archiver.kernel.org>; Tue,  2 Oct 2018 21:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2DB208AE
	for <linux-pci@archiver.kernel.org>; Tue,  2 Oct 2018 21:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nv8r5jq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2DB208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbeJCEO6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:14:58 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37654 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeJCEO6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Oct 2018 00:14:58 -0400
Received: by mail-yw1-f66.google.com with SMTP id y14-v6so1421234ywa.4
        for <linux-pci@vger.kernel.org>; Tue, 02 Oct 2018 14:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZkBuCV6IRX2im3KafCiD5nNr5a7+sSWP0uylXQwgrxE=;
        b=nv8r5jq5oyrFIttRnnEGL39CMnqaWINrTYlcTT/wOfvvvaI1QSDELSaP4RpEk0YleO
         l0zEUi0dHpCLwYLwkHmrDJEyi4YgMAz3cUnj12GQQh/RAY4GHEwi8JoivKSrUCkNc/uU
         9AfOvhMvY5LHj8kwWuVKLm1d456Qvr1G7gwxZXih5c8KEb0x5bkY91iN+pqzF/NFXC96
         2jaQZ/+UwFVKpX+Q+i/0j0RdbSXpiN3bNzk9n7yTQxF0sEuMGTadsd2FxF20eowML8ge
         WmbxI+D67vrL7IbDUAT83dQoldjIZTcpwYOBYAorBRqB55KAHmo91djDxPF9wMUKkcAn
         aeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZkBuCV6IRX2im3KafCiD5nNr5a7+sSWP0uylXQwgrxE=;
        b=KfBlOKTlUErY6a3YYeat5DCUadistMOYFzHD1Xcfxp/Mk3KHOLiqDzB3ChkozgYJu6
         UtC9qVjbb1NgaprF6C1oQ9ZR3DPD5FiVRQg2yJisGU5lWQXtnK5WUa5EHaLrtfQPxd39
         1oyiMr7UZPmEm8mfYI8eKY0H/RxEitBiMq4JCvVfbaG9eLjbIE0LAO5RglKGWS70ZLUy
         eHtjlkGkTwvzlpYAqBcN7m2bHsP/gyk0FMvuaGpO0O+PHmI+G0PXftaCqGnYqluVx+hp
         8egUVFXYmfRZU288zCGRsGx/e+N0OSMv+YTlt6GYTO1rhwLt4LtNcFwxslrR44hOJ9Cm
         dGJA==
X-Gm-Message-State: ABuFfoghMGsYzwMAAOwmI+wEg7YuAii7eZDn0w2bHJNh3eDSV+WySH8Y
        oJq2lzCOpgKLwMQpVmtT1MG8KlHZqd5roEYKqXkE
X-Google-Smtp-Source: ACcGV61+DhFXm+I9I8zUps1F0vDv7WsZoXJjveEN9OiuYRw5+jfZeUid5DNQsIUNkzQyCl73bz4X3mfeoDuzsZqqmXs=
X-Received: by 2002:a81:6e06:: with SMTP id j6-v6mr9189204ywc.374.1538515776115;
 Tue, 02 Oct 2018 14:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180913033745.11178-1-drake@endlessm.com> <20180918213244.GE13616@bhelgaas-glaptop.roam.corp.google.com>
 <20180927205247.GA18434@bhelgaas-glaptop.roam.corp.google.com>
 <3f8efcd6-7cd2-b41a-d984-28c9e1740d6c@rockbox.org> <CAD8Lp47uL3DQTBiVTduO1+Cg8px4CDpv26qVJsgT+RJ4WZx9oA@mail.gmail.com>
 <7b0a5388-5b3a-a6e0-347f-94f87fc2e540@rockbox.org> <20181002200350.GC120535@bhelgaas-glaptop.roam.corp.google.com>
 <0b3bc158-b836-7b44-ef09-7c124f479c58@rockbox.org>
In-Reply-To: <0b3bc158-b836-7b44-ef09-7c124f479c58@rockbox.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 2 Oct 2018 16:29:23 -0500
Message-ID: <CAErSpo7nZCJv9+nvkWkWKUh5WetT7cp+v9QxV0pX4oqjLTZp2w@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: Reprogram bridge prefetch registers on resume
To:     kugel@rockbox.org
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Daniel Drake <drake@endlessm.com>, linux-pci@vger.kernel.org,
        linux@endlessm.com, nouveau@lists.freedesktop.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        Peter Wu <peter@lekensteyn.nl>, kherbst@redhat.com,
        andy.shevchenko@linux.intel.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        David Miller <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        rchang@marvell.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 2, 2018 at 4:27 PM Thomas Martitz <kugel@rockbox.org> wrote:
>
> Am 02.10.18 um 22:03 schrieb Bjorn Helgaas:
> > Hi Thomas,
> >
> > On Mon, Oct 01, 2018 at 04:25:06PM +0200, Thomas Martitz wrote:
> >> Am 01.10.18 um 06:57 schrieb Daniel Drake:
> >>> On Sun, Sep 30, 2018 at 5:07 AM Thomas Martitz <kugel@rockbox.org> wrote:
> >>>> The latest iteration does not work on my HP system. The GPU fails to
> >>>> power up just like the unpatched kernel.
> >>>
> >>> That's weird, I would not expect a behaviour change in the latest
> >>> patch. pci_restore_config_dword() has some debug messages, could you
> >>> please make them visible and show logs again?
> >>> Also remind us of the PCI device address of the parent bridge (lspci -vt)
> >>
> >> I'll follow up with more the requested information on bugzilla
> >> (Link: https://bugzilla.kernel.org/show_bug.cgi?id=201069).
> >>
> >> On a quick re-check, it seems to depend on if I used the eGPU before
> >> the initial suspend. If I run glxgears (with DRI_PRIME=1) before suspend it
> >> seems fine.
> >
> > Does the patch ([1]) make things *worse* compared to v4.19-rc5?
> >
>
> No, certainly not. It does look like a different issue since resuming now
> works at least if I used the eGPU in some way before suspend
> (DRI_PRIME=1 glxgears seems to be enough, I assume glxinfo would work as
> well).
>
> Without the patch resuming the eGPU does not work whatsoever.
>
> Please ship the patch. I'll hopefully sort this other issue out.

Great, thanks!  That's what I thought, but just wanted to double check.
