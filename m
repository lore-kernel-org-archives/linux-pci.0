Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:49202 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761561Ab3DDPWy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2013 11:22:54 -0400
Received: by mail-ob0-f179.google.com with SMTP id vb8so2678947obc.10
        for <linux-pci@vger.kernel.org>; Thu, 04 Apr 2013 08:22:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130404122130.E16CC11FB79@bugzilla.kernel.org>
References: <bug-53811-41252@https.bugzilla.kernel.org/> <20130404122130.E16CC11FB79@bugzilla.kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 4 Apr 2013 09:22:34 -0600
Message-ID: <CAErSpo7S4DYTcBLzcEpKhTsi-YiehG9yV5F+qjYDJgFFn5jQ8A@mail.gmail.com>
Subject: Re: [Bug 53811] acpiphp broken on Lenovo X220 from 3.6 onwards
To: bugzilla-daemon@bugzilla.kernel.org
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Huang Ying <ying.huang@intel.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> https://bugzilla.kernel.org/show_bug.cgi?id=53811

> It appears that the SCI is generated when hotplug event occurs even if the root
> port is in low power state.  But because the configuration space of subordinate
> devices is not accessible when the root port is in low power state, the
> hotplugged device is not detected.

If the problem is with config space access, not with the SCI, why
can't you just put the root port back in D0 before scanning its
secondary bus?  That seems like a more direct fix.

>> However, I don't think this is a complete solution because acpiphp does not
>> claim all root ports that can generate hotplug SCI events.  Bug #54981 is one
>> example.
>
> In #54981, if acpiphp is used, PCIe hotplug does not work regardless we put the
> root port into low power state or not.  If pciehp is used, the pciehp will
> register the hotplug slots, so that we will prevent putting the root port into
> low power state.  So I think the comment #26 patch is a practical solution.

My point here is not about power; only that acpiphp cannot reliably
identify all slots, so we can't rely on slot presence as a way to
decide what to do about power.  On the machine in bug #54981, we must
use acpiphp because the BIOS doesn't let us use pciehp.
