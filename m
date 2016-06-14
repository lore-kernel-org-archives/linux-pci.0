Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35197 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbcFNTXT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2016 15:23:19 -0400
Received: by mail-oi0-f65.google.com with SMTP id u201so2132oie.2
        for <linux-pci@vger.kernel.org>; Tue, 14 Jun 2016 12:23:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E607265CB020454880711A6F96C05A0384BBA010@hasmsx107.ger.corp.intel.com>
References: <1463993336-2750-1-git-send-email-amir.jer.levy@intel.com>
 <20160524105506.GB5396@wunner.de> <E607265CB020454880711A6F96C05A0377FBD337@hasmsx107.ger.corp.intel.com>
 <CAMxnaaUz8nhqVc8ubaOVhSjkcwMUUYZjn5NvJ=mTkGk_SvD8Qg@mail.gmail.com>
 <E607265CB020454880711A6F96C05A037CABE1C2@hasmsx107.ger.corp.intel.com>
 <CAMxnaaUdma9bq0HvdgK603j7HL36rBLwvmviVOaT0O6TZY524Q@mail.gmail.com> <E607265CB020454880711A6F96C05A0384BBA010@hasmsx107.ger.corp.intel.com>
From: Andreas Noever <andreas.noever@gmail.com>
Date: Tue, 14 Jun 2016 21:22:59 +0200
Message-ID: <CAMxnaaW6OucZur5JO4=SOj499jduht0mW72TUzveL3b6xzxD4w@mail.gmail.com>
Subject: Re: [PATCH 0/6] thunderbolt: Introducing Thunderbolt(TM) networking
To: "Levy, Amir (Jer)" <amir.jer.levy@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Jamet, Michael" <michael.jamet@intel.com>,
	"Alloun, Dan" <dan.alloun@intel.com>,
	"Westerberg, Mika" <mika.westerberg@intel.com>,
	"Svahn, Kai" <kai.svahn@intel.com>,
	"Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
	"Winkler, Tomas" <tomas.winkler@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 9, 2016 at 2:53 PM, Levy, Amir (Jer)
<amir.jer.levy@intel.com> wrote:
> On 2016-06-08 Andreas Noever wrote:
>> On Wed, Jun 1, 2016 at 2:22 PM, Levy, Amir (Jer) <amir.jer.levy@intel.com>
>> wrote:
>> >> -----Original Message-----
>> >> From: Andreas Noever [mailto:andreas.noever@gmail.com]
>> >> Sent: Wednesday, May 25, 2016 02:25
>> >> To: Levy, Amir (Jer) <amir.jer.levy@intel.com>
>> >> Cc: Lukas Wunner <lukas@wunner.de>; gregkh@linuxfoundation.org;
>> >> bhelgaas@google.com; linux-pci@vger.kernel.org; Jamet, Michael
>> >> <michael.jamet@intel.com>; Alloun, Dan <dan.alloun@intel.com>;
>> >> Westerberg, Mika <mika.westerberg@intel.com>; Svahn, Kai
>> >> <kai.svahn@intel.com>; Shevchenko, Andriy
>> >> <andriy.shevchenko@intel.com>; Winkler, Tomas
>> >> <tomas.winkler@intel.com>
>> >> Subject: Re: [PATCH 0/6] thunderbolt: Introducing Thunderbolt(TM)
>> >> networking
>> >>
>> >> On Tue, May 24, 2016 at 3:58 PM, Levy, Amir (Jer)
>> >> <amir.jer.levy@intel.com>
>> >> wrote:
>> >> >> -----Original Message-----
>> >> >> From: Lukas Wunner [mailto:lukas@wunner.de]
>> >> >> Sent: Tuesday, May 24, 2016 13:55
>> >> >> To: Levy, Amir (Jer) <amir.jer.levy@intel.com>
>> >> >> Cc: andreas.noever@gmail.com; gregkh@linuxfoundation.org;
>> >> >> bhelgaas@google.com; linux-pci@vger.kernel.org; Jamet, Michael
>> >> >> <michael.jamet@intel.com>; Alloun, Dan <dan.alloun@intel.com>;
>> >> >> Westerberg, Mika <mika.westerberg@intel.com>; Svahn, Kai
>> >> >> <kai.svahn@intel.com>; Shevchenko, Andriy
>> >> >> <andriy.shevchenko@intel.com>; Winkler, Tomas
>> >> >> <tomas.winkler@intel.com>
>> >> >> Subject: Re: [PATCH 0/6] thunderbolt: Introducing Thunderbolt(TM)
>> >> >> networking
>> >> >>
>> >> >> Hi Amir,
>> >> >>
>> >> >> On Mon, May 23, 2016 at 11:48:50AM +0300, Amir Levy wrote:
>> >> >> > Thunderbolt(TM) networking, introduced in these patches,
>> >> >> > provides the capability of connecting hosts together by
>> >> >> > emulating an Ethernet
>> >> adapter.
>> >> >>
>> >> >> Thank you for this contribution. I think it may take some time to
>> >> >> review everything, for now just some general observations:
>> >> >>
>> >> >> - Up until now this driver was Mac-only. IIUC the functionality you're
>> >> >>   adding will also be used on non-Macs. That's an important change that
>> >> >>   should probably be made more explicit in the commit messages. Did
>> you
>> >> >>   test your patches on a Mac to see that nothing regresses?
>> >> >
>> >> > Yes, we did some tests on MacBook Pro with Falcon Ridge.
>> >> > Note that (as written in the cover letter), the functionality that
>> >> > we are
>> >> adding is based on ICM (Intel Connection Manager, firmware).
>> >> > These patches will keep the current functionality on Mac and will
>> >> > add the
>> >> networking functionality on non-Macs.
>> >>
>> >> Hi Amir,
>> >>
>> >> First of all thanks for contributing this. It is certainly good to
>> >> see Intel help out with the driver.
>> >
>> > Hi Andreas,
>> > Thank you for the comments.
>> >
>> >>
>> >> I only did a cursory read, but already have a few questions
>> >> concerning the ICM and its relation to the rest of the driver:
>> >> - Is the ICM only responsible for networking or does it also handle
>> >> pci tunnels, DP, ...?
>> >
>> > ICM is responsible for PCI tunnels and DP as well.
>> >
>> >> - Your code only supports TB2,3. Afaik Apple supports IP over TB also on
>> TB 1.
>> >> What are the obstacles to support first generation chips?
>> >
>> > Intel decided to support Thunderbolt Networking from generation 2.
>> >
>> >> - Related to the above: if some of the registers are available only
>> >> for some chips then please document this in nhi_regs.h (and other
>> places).
>> >> - Is it possible to use the ICM on Apple hardware?
>> >
>> > We don't know if Apple supports it or plans to support it.
>> >
>> >>
>> >> Your patch essentially splits the driver into two. You add an if
>> >> statement to nhi_probe which either runs your code or the old one.
>> >> This is just silly (you might as well add a separate driver). At
>> >> least parts of the functionality are already implemented. For example
>> >> patch
>> >> 2 has large overlap with what is currently handled by nhi.c/ctl.c
>> >> (reading/writing the ring buffer and handling communication with the
>> >> PDF). I understand that the interface provided by ring_rx/ring_tx is
>> >> not a good match for high speed networking introduced in the later
>> >> patches. But then you should refactor it to provide what you need
>> >> instead of reimplementing all the functionality.
>> >
>> > We had a lot of discussions around the driver separation topic and we also
>> consulted some Linux contributors in Intel and got to the conclusion that one
>> driver will be better.
>> > If you recommend to do it in separate driver, I'll send new patches.
>> > Do you have preference how the separation should be?
>> > I thought about defining icm_nhi.c as a module_init and in contrast to the
>> original driver, if dmi_match(Apple) return error.
>> Well I would prefer it to be in a single driver, but without duplicated
>> functionality.
>>
>> There are two parts to your driver:
>>  1) The part that talks to the ICM to setup thunderbolt paths between two
>> controllers.
>>  2) The network driver.
>>
>> I have no experience with networking and we have analoge to 2) in the
>> current driver. So this is fine from my perspective. As far as I can tell the
>> network driver just needs to be given a thunderbolt path (which rx/tx ring to
>> use on the nhi) and is otherwise self contained.
>> This is interesting to me since I would like to try to implement networking on
>> Apple hardware.
>>
>> 1) communicates with the ICM by writing  SW_TO_FW/FW_TO_SW packages
>> to the control channel (or "raw mode", "PDF", ... not sure what the correct
>> terminology is). The code to drive the control channel is already present in
>> ctl.c (we just use raw config_read/write packages).
>> Why can't you reuse all the plumbing code from there (pushing packages
>> onto the ring, handling interrupts etc..). I think it should be possible to add
>> support for the two new package types to ctl.c and then work with them
>> from say thunderbolt_alloc_and_start (instead of scanning the root switch
>> just talk to the icm...).
>
> Intel handles Thunderbolt developments on non-MAC systems only (with ICM).
> Intel doesn’t maintain, develop and publish Thunderbolt SW code running on Apple HW for OS X and Linux.
You submitted a patch to a thunderbolt driver for Apple HW. I think
that it is reasonable for you to make some effort to integrate with it
and not duplicate functionality in two places.

> This is the reason there is minimal code in the probe function, that branches to 2 separate modules.
> I can remove this from probe and produce two separate drivers, as I suggested.
If you want to make your own driver then I won't fight you. At least
that is a more honest approach than a huge if statement in the probe
function...


>>
>> Btw, what is the sequence of ICM commands needed to establish get a
>> network path setup? Is that supposed to be done from userspace?
>
> The network path establishment is divided between user-space (Daemon) and driver.
> It starts in user-space and ends in driver.
> The hand over from Daemon to driver is in nhi_genl_approve_networking.
>
>>
>> >>
>> >> Lastly, why do you need a user mode component? What does it do?
>> >
>> > The general concept was to keep as minimum as possible in kernel and
>> move some of the logic to user space.
>> > This will give us the option to have minimal changes in kernel module in the
>> future, and to release features in a timely manner.
>> > Also it is a preparation to some of the features that will require user
>> interaction.
>> >
>> >>
>> >> Andreas
>
