Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36791 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515AbbBHDLu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 7 Feb 2015 22:11:50 -0500
Received: by ierx19 with SMTP id x19so3300446ier.3
        for <linux-pci@vger.kernel.org>; Sat, 07 Feb 2015 19:11:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54D6C6CB.6060904@nwtrail.com>
References: <54C81B4E.7060900@nwtrail.com>
	<CAErSpo6P-gm1xFjLrbKBU+P3zUHY-RGMkhaVpWsK7vDz_wK=YQ@mail.gmail.com>
	<54CBB062.4040801@nwtrail.com>
	<CAE9FiQUxD8g4KG9CYe1znb5Lw5skkq=9QSOgkmGUDbhsaDq2Qw@mail.gmail.com>
	<54CFBC0E.4080102@nwtrail.com>
	<CAE9FiQUT5j1PDw5c0X-k_E+0TbwCdrX1nbqk8rKzxAKxRLqvEg@mail.gmail.com>
	<54D160B5.70006@nwtrail.com>
	<CAE9FiQVjiCSj21eqevBOYz42o=aiPPMLM_g+65v8CJWgcdq=pg@mail.gmail.com>
	<54D6C6CB.6060904@nwtrail.com>
Date: Sat, 7 Feb 2015 19:11:49 -0800
Message-ID: <CAE9FiQW+z0GtUXCTnr42N7pQ-3xVTe_3EsmkAhWk7ehkZDq_Qw@mail.gmail.com>
Subject: Re: [problem] mpt2sas load fails with LSISAS2008
From: Yinghai Lu <yinghai@kernel.org>
To: pjay@nwtrail.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 7, 2015 at 6:15 PM, Paul Johnson <pjay@nwtrail.com> wrote:
> On 02/07/2015 03:34 PM, Yinghai Lu wrote:
>>
>> On Tue, Feb 3, 2015 at 3:58 PM, Paul Johnson <pjay@nwtrail.com> wrote:
>>>
>>> On 02/02/2015 02:30 PM, Yinghai Lu wrote:
>>>>
>>>>
>>> This patch worked. In case you have a need, the dmesg is attached.
>>
>>
>> Please check two patches instead. You need to apply those two at the same
>> time
>> on current linus tree.
>>
>> Thanks
>>
>> Yinghai
>>
> The patches did not work. dmesg attached.
>
> Interesting discussion about LSI cards. I have wondered what other people
> are running into with this card/chip. It has been around awhile.
>

first patch there is

+    if (!release_child_resources(r));
+        return;

can you remote the extra ";" to you will have
+    if (!release_child_resources(r))
+        return;
