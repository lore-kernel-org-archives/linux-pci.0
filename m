Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35235 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162136Ab3DEQ4w (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Apr 2013 12:56:52 -0400
Received: by mail-ob0-f174.google.com with SMTP id wm15so1297026obc.33
        for <linux-pci@vger.kernel.org>; Fri, 05 Apr 2013 09:56:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130405101227.2AC9511FB82@bugzilla.kernel.org>
References: <bug-53811-41252@https.bugzilla.kernel.org/> <20130405101227.2AC9511FB82@bugzilla.kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 5 Apr 2013 10:56:30 -0600
Message-ID: <CAErSpo5n3svysQ71vStCfAOikTZBo89gmwOwHOXLTB4KSXk0zw@mail.gmail.com>
Subject: Re: [Bug 53811] acpiphp broken on Lenovo X220 from 3.6 onwards
To: bugzilla-daemon@bugzilla.kernel.org
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> If the problem is with config space access, not with the SCI, why
>> can't you just put the root port back in D0 before scanning its
>> secondary bus?  That seems like a more direct fix.
>
> comment #4 patch does exactly like that.  ALLurGroceries tried that patch and
> it works for him in comment #7.  But in comment #14, ALLurGroceries reported
> that it does not work reliably enough.  So I write comment #26 patch to fix the
> issue in a more conservative way, and it works reliable for ALLurGroceries.

The comment #4 patch adds "pm_runtime_get_sync(&bridge->pci_dev->dev)"
before re-enumerating.  If that is supposed to keep the bridge in D0
but doesn't, we need to figure out why.  I don't know how PM works,
but maybe Rafael will chime in.

> If acpiphp cannot identify the slots, acpiphp cannot work regardless whether
> the bridge is put into low power state.  If acpiphp can identify the slots,
> with the help of comment #26 patch, acpiphp can work properly and the root port
> will not be put into low power state.  So I think the point is to make acpiphp
> identify all slots.  And comment #26 patch is a valid fix.

Please look at the bug #54981 DSDT and explain either (1) why we
should use pciehp rather than acpiphp on that machine, or (2) how we
can make acpiphp identify the ExpressCard slot.

My contention is that the "slot identification" model currently used
by acpiphp is fundamentally broken and that we should change acpiphp
so it doesn't depend on identifying slots.  I don't believe it is
possible to identify all possible slots by looking at the DSDT, and
therefore, I don't want to make changes like the comment #26 patch
that depend on identifying slots.
