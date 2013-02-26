Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay0057.b.hostedemail.com ([64.98.42.57]:53153 "EHLO
	smtprelay.b.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932631Ab3BZTOu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Feb 2013 14:14:50 -0500
Date: Tue, 26 Feb 2013 19:14:48 +0000 (UTC)
From: "Artem S. Tashkinov" <t.artem@lycos.com>
To: bhelgaas@google.com
Cc: stern@rowland.harvard.edu, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	rjw@sisk.pl
Message-ID: <569718148.80620.1361906088301.JavaMail.mail@webmail13>
References: <CAErSpo7qj2SNR7BfuBsfF-saZXvgcqqLtgoP5Hyb5u99qR4Ncg@mail.gmail.com>
 <Pine.LNX.4.44L0.1302191119270.2215-100000@iolanthe.rowland.org>
 <CAErSpo7NZoOQZyW76HEoOTVgdqL2CgbVScAeF6HGLAVaNCq0=w@mail.gmail.com>
 <337833384.57445.1361860509194.JavaMail.mail@webmail08><CAErSpo6CbO5KYXiErv6J_Dnm1u694C5fQPP2_cZL8VKDEnZa9A@mail.gmail.com>
Subject: Re: Abysmal HDD/USB write speed after sleep on a UEFI system
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Feb 27, 2013 12:47:01 AM, Bjorn Helgaas wrote:
On Mon, Feb 25, 2013 at 11:35 PM, Artem S. Tashkinov wrote:
>> Feb 26, 2013 03:57:52 AM, Bjorn Helgaas wrote:
>>>
>>>Where are we at with this, Artem?  I assume it's still a problem.
>>>
>>
>> Yes, it is, Bjorn.
>>
>> In order to eliminate this problem I switched back to MBR yesterday, because
>> so far I haven't received any instructions or guidance as to how I can debug
>> it further. I'm absolutely sure USB write speed is just another manifestation of
>> it so I decided not to debug USB specifically (it just doesn't make too much
>> sense).
>>
>> What I see is that something terribly wrong is going on but if Linus has no ideas
>> I, as an average Joe, don't have a slightest clue as to what I can do.
>>
>> The bug report with necessary, but seemingly useless information, can be
>> found here: https://bugzilla.kernel.org/show_bug.cgi?id=53551
>>
>> If anyone comes up with new ideas I can quickly try UEFI again now that I
>> have two HDDs at my disposal (the old one is formatted as GPT, the new one is
>> MBR).
>
>The ideas I saw are:
>
>1) Figure out whether it ever worked.  If an older kernel worked
>correctly and a newer one is broken, bisection is at least a
>possibility.  You mentioned that it did work before (Feb 12), but in
>the past you never suspended twice in one boot session, whereas maybe
>you did when seeing the problem?

This is difficult to say since the first kernel I tried to run in EUFI mode was
3.7.x, so I've no idea if any previous ones ever worked.

>
>2) Try the "setpci" to set the MSI address back to the original value
>to see if it makes a difference (see my Feb 12 message).

I will try it soon and report back to you.

>
>3) Collect "lspci -vvv -xxxx" output to investigate the XHCI
>Unsupported Request errors.
>
>4) Use usbmon to collect traces before and after the suspend.

Likewise. Still I don't quite understand why you are persistent in your
desire to investigate USB controllers specifically - my problem affects
all storage devices that I have.

>
>I googled around a bit looking for similar reports.  I found lots of
>suspend issues, mostly with Windows, but no leads yet.  It looks like
>the board has been around for a while, so you would think we'd have
>some other reports of a problem this bad.  But maybe it really is
>related to UEFI and nobody really uses that yet?

99% of people around me don't use UEFI, and the ones who use it do
it because they want to run Hacintosh (it's quite complicated to run
a EUFI OS from a non UEFI BIOS).

That's the main reason you don't see similar reports. EUFI so far hasn't
proven its supremacy and efficiency over BIOS. When 3TB and larger
HDD's become more widespread people will have to use UEFI. They will
simply have no choice (unless of course you have two HDDs, where one
is BIOS formatted to boot your system, and another one is GPT
partitioned in order to support > 2,2TB space).

Best regards,

Artem
