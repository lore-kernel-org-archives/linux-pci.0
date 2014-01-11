Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33616 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbaAKBFw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jan 2014 20:05:52 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl1so763599igb.5
        for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2014 17:05:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140106084716.068edc9f@jbarnes-desktop>
References: <20131227132530.5c02d9d8@nehalam.linuxnetplumber.net>
 <20131227132710.7190647c@nehalam.linuxnetplumber.net> <CAErSpo49y7q_E4kHtFsZ-hOkbeWaAgEAt38YdP1TJ6Dk0XwOWw@mail.gmail.com>
 <20140106084716.068edc9f@jbarnes-desktop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 10 Jan 2014 18:05:31 -0700
Message-ID: <CAErSpo5HQ2y8jhkMKu0u1TsRBZco6QjmZysvmqOgdZqnO3Rv+Q@mail.gmail.com>
Subject: Re: [PATCH pci-next 2/2] pci: remove dead code
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Myron Stowe <myron.stowe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 6, 2014 at 9:47 AM, Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
> On Thu, 2 Jan 2014 16:12:52 -0700
> Bjorn Helgaas <bhelgaas@google.com> wrote:
>
>> [+cc Jesse, Myron]
>>
>> On Fri, Dec 27, 2013 at 2:27 PM, Stephen Hemminger
>> <stephen@networkplumber.org> wrote:
>> >
>> > My philosophy is unused code is dead code.
>> > And dead code is subject to bit rot and is likely source of bugs.
>> > Use it or lose it.
>> >
>> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
>>
>> This removes pci_enable_ido(), pci_enable_obff(), pci_enable_ltr(),
>> etc., which I think you added, Jesse.  In principle I like the idea of
>> removing code that isn't being used.  Of course, these might be used
>> by out-of-tree drivers, but I don't think we should go *too* far out
>> of our way to support them.
>>
>> Anybody have any objections to removing them?  Obviously they'll still
>> be in the git history, so it would be trivial to resurrect them.
>
> No objections.  If driver folks haven't yet found a use for them (and/or
> hw is scarce) there's no reason to keep these.

I split this up into separate patches because some of the code removed
is PCIe 3.0 support that people might have isses with, and so we can
CC: interested people and they can make sense out of it.  I'll post
the series as a v2 in a minute.

Bjorn
