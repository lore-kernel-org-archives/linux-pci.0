Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:48437 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab3HWO63 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 Aug 2013 10:58:29 -0400
Received: by mail-ie0-f174.google.com with SMTP id k14so968746iea.33
        for <linux-pci@vger.kernel.org>; Fri, 23 Aug 2013 07:58:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bug-57961-41252-X2PJk78p44@https.bugzilla.kernel.org/>
References: <bug-57961-41252@https.bugzilla.kernel.org/> <bug-57961-41252-X2PJk78p44@https.bugzilla.kernel.org/>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 23 Aug 2013 08:58:07 -0600
Message-ID: <CAErSpo4jFGdW-OXf2OrUQw-e8EdE5h6fPs-v9=QQh1xPjz-Nvg@mail.gmail.com>
Subject: Re: [Bug 57961] ExpressCard hot-remove and hot-add not recognized by acpiphp
To: leho@kraav.com
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci, linux-acpi, switch to email for now]

On Fri, Aug 23, 2013 at 7:34 AM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=57961
> ...
> I'm arriving here from googling "_handle_hotplug_event_root Bus check notify on
> \_SB_.PCI0".

Huh, interesting.  I didn't think the kernel bugzilla was visible to
search engines (I wish it were).  But maybe Google just found an email
that mentioned the URL?

> My Dell L421X is spitting this notification both when I close and open the
> laptop lid, one each. No ACPI LID event is emitted, which doesn't seem right.

Can you post a complete dmesg log including a lid close/event cycle?

> Running on 3.10.6. Is this bug related in any way?

Bug 57961 is for ExpressCard changes that we didn't handle correctly.
It doesn't sound like you're adding or removing an ExpressCard, so
you're likely seeing a different problem.

Is the problem that (1) you see "_handle_hotplug_event_root Bus check
notify on \_SB_.PCI0" messages that you don't expect, and (2) you do
not see LID events, which you do expect?

Is there anything that is not actually working correctly, or is it
just messages that don't seem right?

Bjorn
