Return-Path: <roland.singer@desertbit.com>
Return-Path: <roland.singer@desertbit.com>
Subject: Re: Kernel Freeze with American Megatrends BIOS
To: Peter Wu <peter@lekensteyn.nl>
References: <004c7dbe-2014-c691-29d1-7a45f3b73dfa@desertbit.com>
 <20160829160210.GA24451@localhost> <20160830195337.GA18805@al>
 <e7318236-9737-518e-c360-398c66220961@desertbit.com>
 <20160831114639.GD19420@al>
 <1b91b281-3c71-f02f-ff27-51957af92275@desertbit.com>
 <20160831123444.GE19420@al>
 <e19456cb-3076-c8f1-c9ec-fbfbd9bb6112@desertbit.com>
 <310ac56e-94bf-35de-79c7-29b0b4b6e2a8@desertbit.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, emil.l.velikov@gmail.com,
 "imirkin@alum.mit.edu >> Ilia Mirkin" <imirkin@alum.mit.edu>
From: Roland Singer <roland.singer@desertbit.com>
Message-ID: <e50b350c-c6d1-22ef-527e-3590425dede2@desertbit.com>
Date: Wed, 31 Aug 2016 22:16:25 +0200
MIME-Version: 1.0
In-Reply-To: <310ac56e-94bf-35de-79c7-29b0b4b6e2a8@desertbit.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 08/31/16 22:06, Roland Singer wrote:
> Here is Peter Wu's reply, which was not send to the mailing list, because
> I had to resend my e-mail to him due to a failure...
> 
> 
> -------- Forwarded Message --------
> Subject: Re: Fwd: Re: Kernel Freeze with American Megatrends BIOS
> Date: Wed, 31 Aug 2016 18:08:53 +0200
> From: Peter Wu <peter@lekensteyn.nl>
> To: Roland Singer <roland.singer@desertbit.com>
> 
> On Wed, Aug 31, 2016 at 05:56:18PM +0200, Roland Singer wrote:
> 
>>> If you look at my notes.txt, you will see that _OFF always executes the
>>> same code. PGON differs. When the problem occurs, "Q0L0" somehow always
>>> reads back as non-zero and LNKS < 7.
>>>
>>
>> Oh you're Lekensteyn ^^
> 
> Yes, that's me :) I wrote bbswitch, did the Optimus and PR3 ACPI support
> in nouveau so I am fairly certain what happens behind the scenes.
> 

Awesome! Thanks for all your efforts! Great work :)


>> I don't have LNKS and no while loop after calling LKEN ?!
> 
> Yes that is what I said in
> https://www.spinics.net/lists/linux-pci/msg53694.html:
> 
> "Other affected devices have similar code, differences are small:
> No check for LNKS (avoids the infinite loop, but device is still off)"
>

Ah ok, missed that.


>> It might be, that lspci does not only power the GPU on, but triggers
>> another pci action which causes the race condition.
>> Does this have something to do with your quote about the retrain bit?
> 
> That is an interesting hypothesis. Even if you invoke `lspci -s01:00.0`
> for example, it will always probe for all devices. So maybe interaction
> with its parent device (PCI root port 00:02.0) causes issues.
> 
> However I also tested without lspci before, and the problem still
> exists. You can trigger runtime resume via (as root):
> 
>     echo > /sys/bus/pci/0000:01:00.0/power/control on
> 
> Set it to "auto" to make it sleep again.
> 

Just tried it over and over again. I don't have any problems switching the GPU power state
with bbswitch. So, switching the GPU on is just fine. There must be something else, which
does not cooperate well while switching it on (lspci)...

I can confirm,, that `lspci -s01:00.0` also freezes the system.

Trying to trigger runtime resume with `/sys/bus/pci/0000:01:00.0/power/control`
did not work for me. The GPU just stayed off.
Any hints how to get some more information?
