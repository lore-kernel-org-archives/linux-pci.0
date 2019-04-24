Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD515C282CE
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 21:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC29F21903
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 21:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556140206;
	bh=1HfAWhkUSRfDoIYYUAY8UYL0l5qRdg2MjFaWGR9ogmo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hQ5K5MXaVTXClnQk4nUwWO7UYEZhpVFBi7EHIaRkoPubVUNNkC805ZE3DJo6A8nDU
	 lxwKDpAbXFKAqYVSdmDGjfWJupViUVuCqu2ygbc+uwuRE2xgE2ufHnC4Id7XOlUb6C
	 xmcKRa3uWs0qdLMQMtAydHAnk8JBXK+l+IDZoIXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbfDXVKF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:10:05 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35034 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbfDXVKE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 17:10:04 -0400
Received: by mail-ot1-f65.google.com with SMTP id m10so17491695otp.2;
        Wed, 24 Apr 2019 14:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=arah7RRivOS0kCg7Wmlyz9/ttbkVAueiG8dKQQlbvpU=;
        b=GGS11Vjm7RCc9fUxy7hwblkAbiySNweRBiqBWzYpgYGJZOwFB4PyXwcf1xF+iAbRTu
         J8PvWvTZvA7aaqyxtijRShwoWUdhioAGYFYQSiLnpKBdaMMMEB01LBveblBqdxKjqev5
         jyVtUS3B8kGNg8omkMHickNU+v9nL4raJBkP0rQjpQ1NvoqREclXTUoEKFznvx1qLYc6
         2o5n8lMtDs6DN/eHN5QW/jgNgkf39cLqwcY4UX3C8cSTjsspod6gIJpY7ymfq+4kO0xt
         2JMhY1zfZcKbZLqHq1aK7MS2PJ2X5XO+dTYph+cHQxTjJ0YqbssyQR35Ijvw5P78xpIL
         nNAw==
X-Gm-Message-State: APjAAAVQOMM+N5lYN2cMN3To4H77soBLeNG5iezcGk3OTP/qvnmDj9bw
        e+cTUnHLeaC0HqUYrxYrJwj/fK0UVx4ocM89+0A=
X-Google-Smtp-Source: APXvYqyi63/b0iI+WZF0q8LbvggDqR+hib6TSKMHTXd26kCZj1BJZ/dmpU34zhrPcRjtARcQbhLlX9I8lYWh8+wUuak=
X-Received: by 2002:a9d:648f:: with SMTP id g15mr20316403otl.220.1556140203897;
 Wed, 24 Apr 2019 14:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190415135903.wiyw34faiezdnbbs@yadro.com> <20190415141554.GL126710@google.com>
 <20190423215340.GH14616@google.com> <20190424100102.iyxogbsa4l7dyusb@yadro.com>
 <20190424141148.GA244134@google.com> <20190424145819.GL2654@lahna.fi.intel.com>
 <20190424172151.GB244134@google.com>
In-Reply-To: <20190424172151.GB244134@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Apr 2019 23:09:52 +0200
Message-ID: <CAJZ5v0gZhgMy+oQMpEGM8bsU_57w7i3iCP1nb9PcOHxENfnwAw@mail.gmail.com>
Subject: Re: [PATCH RESEND] PCI: disable runtime PM for PLX switches
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Alexander Fomichev <fomichev.ru@gmail.com>,
        Linux PCI <linux-pci@vger.kernel.org>, linux@yadro.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 24, 2019 at 8:01 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Apr 24, 2019 at 05:58:19PM +0300, Mika Westerberg wrote:
> > On Wed, Apr 24, 2019 at 09:11:48AM -0500, Bjorn Helgaas wrote:
> > >   - Maybe the PCI sysfs accessors (pci_mmap_resource(), etc) should
> > >     turn off runtime PM?  If we allow mmap of a BAR and then put the
> > >     device in D3hot, that seems like a bug that could affect lots of
> > >     things.  But maybe that's already done magically elsewhere?
> >
> > IIRC there is no PM magic happening for MMIO userspace accesses.
> >
> > What you suggest above sounds like a good way to fix it. We already do
> > similar for config space access from userspace (if the device is in
> > D3cold) so definitely makes sense to do the same for MMIO. However, I
> > don't think we need to disable runtime PM - it should be enough to
> > increase the reference count (pm_runtime_get_sync() and friends) during
> > the time the MMIO resource is mmapped.
>
> OK, so if I understand correctly this would be basically adding
> pm_runtime_get_sync(dev) in pci_mmap_resource().  I don't know what
> the unmap path is, but there would have to be a matching
> pm_runtime_put() somewhere.

Right.

> And a similar change in the read/write path for /sys/.../resource<N>;
> I think this must be related to the sysfs_create_bin_file() call in
> pci_create_attr(), but I don't see the path where the actual
> read/write to the device is done.
>
> And probably something similar should be done in pci_resource_io(),
> pci_map_rom(), and pci_unmap_rom().

In general, every path in which there is a memory or IO address space
access requires pm_runtime_get_sync()/pm_runtime_put() around it as
these accesses are only guaranteed to work in D0.

Cheers,
Rafael
