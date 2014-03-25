Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:63276 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086AbaCYTTI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Mar 2014 15:19:08 -0400
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1403241316280.1197-100000@iolanthe.rowland.org>
References: <CAErSpo5yOEqHZmWZ3j8NQs_DapmkegDTm8uLJCS2uCKvTvtT6Q@mail.gmail.com>
 <Pine.LNX.4.44L0.1403241316280.1197-100000@iolanthe.rowland.org>
From: Andreas Noever <andreas.noever@gmail.com>
Date: Tue, 25 Mar 2014 20:18:47 +0100
Message-ID: <CAMxnaaUnm0Gez1UOtRP3raBEVbEg7gWXbwDUGOCcMnktKT8xFA@mail.gmail.com>
Subject: Re: how to trigger pcieport runtime suspend?
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 24, 2014 at 6:19 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 24 Mar 2014, Bjorn Helgaas wrote:
>
>> [+cc Rafael, Pavel, linux-pm]
>>
>> On Sun, Mar 23, 2014 at 12:16 PM, Andreas Noever
>> <andreas.noever@gmail.com> wrote:
>> > The pcieport driver defines runtime_suspend and runtime_resume methods
>> > (pcie_port_runtime_suspend/resume in portdrv_pci.c). I am trying to
>> > trigger that code. But I cannot get power/runtime_usage to drop to
>> > zero.
>> >
>> > Initially power/runtime_usage is set to 2. The 2 comes (imho) from:
>> > pci_pm_init -> pm_runtime_forbid
>> > local_pci_probe -> pm_runtime_get_sync
>> >
>> > The pm_runtime_forbid can be undone with echo auto > power/control,
>> > but the second one seems to never go away. local_pci_probe spots the
>> > following comment:
>> > "If the driver supports runtime PM, it should call
>> > pm_runtime_put_noidle() in its probe routine and
>> > pm_runtime_get_noresume() in its remove routine." I cannot find any
>> > such calls in the pcieport driver (or in the port service drivers).
>> >
>> > What am I missing?
>
> You're not missing anything, but apparently the people who added
> runtime PM support to the pcieport driver missed the comment you
> quoted.
>
> If you add those calls to the driver, does it do what you want?
If I add that call and remove the pme_poll check in
pcie_port_runtime_idle (pme_poll seems to be set for all devices) then
it seems to work. The bridge goes to D3 if no device is present or if
all devices below it are in D3. It even reacts to hotplug events while
in D3. I'm not sure that everything *really* works as I cannot see any
code that would call resume/suspend on the individual port service
drivers (as compared to the system suspend path). It probably just
works by accident.

Anyhow, the reason I was trying to do this is, is that I observed
different behavior from a device in runtime D3 as compared to system
suspend. I thought it might have something to do with the power status
of the parent bridge, but that turned out to be not the case... back
to square one.

Andreas
