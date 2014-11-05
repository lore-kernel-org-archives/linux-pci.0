Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:57475 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbaKERak (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Nov 2014 12:30:40 -0500
Received: by mail-qg0-f45.google.com with SMTP id z107so12522464qgd.32
        for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2014 09:30:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bug-87781-41252@https.bugzilla.kernel.org/>
References: <bug-87781-41252@https.bugzilla.kernel.org/>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 5 Nov 2014 10:30:16 -0700
Message-ID: <CAErSpo69s6i52CD=hxewo2tZNs1w5_zKNJsV7N+-88Dzw9mbqQ@mail.gmail.com>
Subject: Re: [Bug 87781] New: ExpressCards can not be hotplugged (recognized
 by colboot only)
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Yinghai Lu <yinghai@kernel.org>, Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

FYI.

On Wed, Nov 5, 2014 at 6:49 AM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=87781
>
>             Bug ID: 87781
>            Summary: ExpressCards can not be hotplugged (recognized by
>                     colboot only)
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 3.2.0-4-amd64
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: estellnb@elstel.org
>         Regression: No
>
> My USB3.0 ExpressCard is only recognized per coldboot.
> Once I remove the ExpressCard all device nodes stay intact (i.e. of USB sticks
> plugged into the card) but can no more be mounted on re-plugging the
> ExpressCard.
>   Additionally s2ram will no more work as soon as I boot into Linux with an
> ExpressCard plugged in.
>
> --
> You are receiving this mail because:
> You are watching the assignee of the bug.
