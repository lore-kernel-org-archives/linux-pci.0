Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from resqmta-po-10v.sys.comcast.net ([96.114.154.169]:48499 "EHLO
	resqmta-po-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751834AbbBSXkn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Feb 2015 18:40:43 -0500
Message-ID: <54E67479.3020906@nwtrail.com>
Date: Thu, 19 Feb 2015 15:40:41 -0800
From: Paul Johnson <pjay@nwtrail.com>
Reply-To: pjay@nwtrail.com
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Yinghai Lu <yinghai@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [problem] mpt2sas load fails with LSISAS2008
References: <54C81B4E.7060900@nwtrail.com> <CAErSpo6P-gm1xFjLrbKBU+P3zUHY-RGMkhaVpWsK7vDz_wK=YQ@mail.gmail.com> <54CBB062.4040801@nwtrail.com> <CAE9FiQUxD8g4KG9CYe1znb5Lw5skkq=9QSOgkmGUDbhsaDq2Qw@mail.gmail.com> <54CFBC0E.4080102@nwtrail.com> <CAE9FiQUT5j1PDw5c0X-k_E+0TbwCdrX1nbqk8rKzxAKxRLqvEg@mail.gmail.com> <54D160B5.70006@nwtrail.com> <CAE9FiQVjiCSj21eqevBOYz42o=aiPPMLM_g+65v8CJWgcdq=pg@mail.gmail.com> <54D6C6CB.6060904@nwtrail.com> <CAE9FiQW+z0GtUXCTnr42N7pQ-3xVTe_3EsmkAhWk7ehkZDq_Qw@mail.gmail.com> <54D7AE67.1090007@nwtrail.com> <CAErSpo4ZYfs9EhdZMXGdjbDY4WUfTNFz+CPBq-Gx3eQ563Fogw@mail.gmail.com> <54DB7F39.8030306@nwtrail.com> <CAErSpo6z1GmTkLQJDhBZxRU2wjCZiYsFBETi18vsYVNzOBi6VA@mail.gmail.com>
In-Reply-To: <CAErSpo6z1GmTkLQJDhBZxRU2wjCZiYsFBETi18vsYVNzOBi6VA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a resend of mail sent 2/11 except the dmesg attachment is not on 
the bug report.

On 02/11/2015 08:57 AM, Bjorn Helgaas wrote:
> On Wed, Feb 11, 2015 at 10:11 AM, Paul Johnson <pjay@nwtrail.com> wrote:
>> On 02/10/2015 08:49 AM, Bjorn Helgaas wrote:
>>>
>>> We need to work out what's going wrong here before we rush into a
>>> band-aid.
>>>
>>> What changed between v3.4 and v3.4.1 that exposed this problem?  "git
>>> log --oneline v3.4..v3.4.1" doesn't show any likely culprits.  Paul,
>>> are those the versions you tested?  Your dmesg logs at
>>> https://bugzilla.kernel.org/show_bug.cgi?id=92351 show
>>> "3.4.0-030400-generic" and "3.4.1-030401-generic" but I don't know
>>> whether those are precisely v3.4 and v3.4.1.
>>>
>>> I assume this system works fine with Windows, and I doubt Windows has
>>> a hack like "never move LSI devices."  So it would be useful to know
>>> if we're doing something stupid in Linux that makes us trip over this.
>>> Paul, if you happen to have Windows on this machine as well, a
>>> complete AIDA64 report (free trial version at http://www.aida64.com)
>>> would show what Windows did.
>>>
>>> The resource allocation we're doing is related SR-IOV, and
>>> unfortunately we don't print enough information in dmesg to figure
>>> everything out.  Paul, can you attach the complete "lspci -vv" output
>>> to the bugzilla?
>>>
>>> Bjorn
>>>
>> The system I have had this problem on is in production, though it should be
>> replaced by a real server. Because it is in use, I have used a separate boot
>> disk to test kernels. I also have limited access to take the machine down.
>> The system runs ubuntu server, though I have used an ubuntu desktop to test
>> kernels. There is not a windows system on the machine, though, just
>> guessing, LSI likely provides the windows driver and that driver may well
>> have dealt with a problem that is looking to be specific to a firmware/bios
>> version on this card.
>
> That might be possible.  The issue seems to be related to changing BAR
> addresses, and I expect that would be outside the scope of what the
> driver can influence.  So I don't know whether Windows has a mechanism
> for that or not.
>
>> Someone found another of these cards here, so I tried it last night in an
>> unused machine. It worked on the ubuntu 3.13 kernel without realloc. The
>> card that has been the problem has these versions of firmware:
>> [    9.004647] mpt2sas0: LSISAS2008: FWVersion(17.00.01.00),
>> ChipRevision(0x03), BiosVersion(07.33.00.00)
>>
>> and the card that works has a newer version:
>> [   15.725011] mpt2sas0: LSISAS2008: FWVersion(18.00.00.00),
>> ChipRevision(0x03), BiosVersion(07.35.00.00)
>
> Without seeing the dmesg log, I can't tell whether this card works
> because (1) the LSI firmware is fixed or (2) the kernel didn't try to
> change the BARs.
>
> And I still don't have any clue about what changed between v3.4 and
> v3.4.1 and triggered the problem.
>
> Applying a fix without figuring out the real root cause of the problem
> is voodoo programming, and I don't like to do that.
>
>> Now, the cards are in very different machines so the difference could be due
>> to the machines and not the firmware, but I would tend to go with the
>> firmware difference. LSI firmware is now beyond both these firmware
>> versions, but if I can find a copy of the older firmware, I'll try it on the
>> card with the newer firmware.
>
> We could tell from the dmesg log whether Linux changed the BARs.  I
> wouldn't bother trying different LSI firmware versions until you
> confirm that we changed the BARs.
>
> Bjorn
>
The 3.4.0 and 3.4.1 kernels I used came from here:
http://kernel.ubuntu.com/~kernel-ppa/mainline/?C=N;O=D

A dmesg with the newer firmware and 3.19 from the same url is attached 
to the bug report https://bugzilla.kernel.org/show_bug.cgi?id=92351 as 
attachment: dmesg with 3.19 and LSI FW 18

Paul

