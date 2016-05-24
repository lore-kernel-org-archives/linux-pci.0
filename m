Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36313 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbcEXXZE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 May 2016 19:25:04 -0400
Received: by mail-oi0-f65.google.com with SMTP id x130so7514598oia.3
        for <linux-pci@vger.kernel.org>; Tue, 24 May 2016 16:25:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E607265CB020454880711A6F96C05A0377FBD337@hasmsx107.ger.corp.intel.com>
References: <1463993336-2750-1-git-send-email-amir.jer.levy@intel.com>
 <20160524105506.GB5396@wunner.de> <E607265CB020454880711A6F96C05A0377FBD337@hasmsx107.ger.corp.intel.com>
From: Andreas Noever <andreas.noever@gmail.com>
Date: Wed, 25 May 2016 01:24:43 +0200
Message-ID: <CAMxnaaUz8nhqVc8ubaOVhSjkcwMUUYZjn5NvJ=mTkGk_SvD8Qg@mail.gmail.com>
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

On Tue, May 24, 2016 at 3:58 PM, Levy, Amir (Jer)
<amir.jer.levy@intel.com> wrote:
>> -----Original Message-----
>> From: Lukas Wunner [mailto:lukas@wunner.de]
>> Sent: Tuesday, May 24, 2016 13:55
>> To: Levy, Amir (Jer) <amir.jer.levy@intel.com>
>> Cc: andreas.noever@gmail.com; gregkh@linuxfoundation.org;
>> bhelgaas@google.com; linux-pci@vger.kernel.org; Jamet, Michael
>> <michael.jamet@intel.com>; Alloun, Dan <dan.alloun@intel.com>;
>> Westerberg, Mika <mika.westerberg@intel.com>; Svahn, Kai
>> <kai.svahn@intel.com>; Shevchenko, Andriy
>> <andriy.shevchenko@intel.com>; Winkler, Tomas
>> <tomas.winkler@intel.com>
>> Subject: Re: [PATCH 0/6] thunderbolt: Introducing Thunderbolt(TM)
>> networking
>>
>> Hi Amir,
>>
>> On Mon, May 23, 2016 at 11:48:50AM +0300, Amir Levy wrote:
>> > Thunderbolt(TM) networking, introduced in these patches, provides the
>> > capability of connecting hosts together by emulating an Ethernet adapter.
>>
>> Thank you for this contribution. I think it may take some time to review
>> everything, for now just some general observations:
>>
>> - Up until now this driver was Mac-only. IIUC the functionality you're
>>   adding will also be used on non-Macs. That's an important change that
>>   should probably be made more explicit in the commit messages. Did you
>>   test your patches on a Mac to see that nothing regresses?
>
> Yes, we did some tests on MacBook Pro with Falcon Ridge.
> Note that (as written in the cover letter), the functionality that we are adding is based on ICM (Intel Connection Manager, firmware).
> These patches will keep the current functionality on Mac and will add the networking functionality on non-Macs.

Hi Amir,

First of all thanks for contributing this. It is certainly good to see
Intel help out with the driver.

I only did a cursory read, but already have a few questions concerning
the ICM and its relation to the rest of the driver:
- Is the ICM only responsible for networking or does it also handle
pci tunnels, DP, ...?
- Your code only supports TB2,3. Afaik Apple supports IP over TB also
on TB 1. What are the obstacles to support first generation chips?
- Related to the above: if some of the registers are available only
for some chips then please document this in nhi_regs.h (and other
places).
- Is it possible to use the ICM on Apple hardware?

Your patch essentially splits the driver into two. You add an if
statement to nhi_probe which either runs your code or the old one.
This is just silly (you might as well add a separate driver). At least
parts of the functionality are already implemented. For example patch
2 has large overlap with what is currently handled by nhi.c/ctl.c
(reading/writing the ring buffer and handling communication with the
PDF). I understand that the interface provided by ring_rx/ring_tx is
not a good match for high speed networking introduced in the later
patches. But then you should refactor it to provide what you need
instead of reimplementing all the functionality.

Lastly, why do you need a user mode component? What does it do?

Andreas
