Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:34796 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965935Ab2FAXHO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 1 Jun 2012 19:07:14 -0400
Received: by lahd3 with SMTP id d3so1916378lah.19
        for <linux-pci@vger.kernel.org>; Fri, 01 Jun 2012 16:07:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6iGaQA8DTKRK9Q+m2RqJk1R-Gfa9qk+YMrf=9Ww45MFw@mail.gmail.com>
References: <1333968563.5678.19.camel@infinity> <4F89CE43.7040200@snewbury.org.uk>
 <CAE9FiQVwDNM9MkqG_g139LDf6Ypjx0uygzVqosDe=fF=c_Y3gA@mail.gmail.com>
 <4F8AA0DC.6010902@snewbury.org.uk> <4F8AB312.7060606@snewbury.org.uk>
 <4F8B04A4.4070507@snewbury.org.uk> <4F8B0609.8010603@snewbury.org.uk>
 <CAE9FiQUsQjUNeW1sa_mQL6MEaDhxvoMhFaN9wLPAqOXzh+AXPQ@mail.gmail.com>
 <CAE9FiQVzC2YCkXtFDPkCMVMcMqt9c0t8hKVvpgFpwjRdBen0Uw@mail.gmail.com>
 <CAE9FiQX7iVYZSoEJVVHJTx1gUSKh6RP+iJRGJqMZmDgkFDnPQQ@mail.gmail.com>
 <CAE9FiQXrF+o9UW-J+UDSN3OR4SOWWAZwJbH=39k4xFf2m-Jd9A@mail.gmail.com>
 <4F96770D.2050606@snewbury.org.uk> <4FB227D3.7090002@snewbury.org.uk>
 <CAE9FiQX48eCS85eWMFxm6fCWgu2zwxvSywtQhsf-35WEvBfJVQ@mail.gmail.com>
 <4FB4EE99.10509@snewbury.org.uk> <4FB4F039.2040308@snewbury.org.uk>
 <CAE9FiQUpdVJeF06BtqOKo448n1oH+AMJyC03FpB13=fOdkwM+w@mail.gmail.com>
 <CAE9FiQWOoEX3H6V7+c+azm8DJieX8bpXRmsYuOE+ZUDJ-p3-yQ@mail.gmail.com>
 <CAE9FiQU1Bq3xpo0m_eNwBHoxF+oH=pXpg59hQguf_5GpWytyKg@mail.gmail.com>
 <4FBA7AEE.3090402@snewbury.org.uk> <CAErSpo6iGaQA8DTKRK9Q+m2RqJk1R-Gfa9qk+YMrf=9Ww45MFw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 1 Jun 2012 17:06:51 -0600
Message-ID: <CAErSpo7NF3bdF6hEx1_zF7f5oTv4wp4td4AaHzp=W=S-W_v07Q@mail.gmail.com>
Subject: Re: PCI resources above 4GB
To: Steven Newbury <steve@snewbury.org.uk>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
	DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 29, 2012 at 5:19 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, May 21, 2012 at 11:27 AM, Steven Newbury <steve@snewbury.org.uk> wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 18/05/12 10:08, Yinghai Lu wrote:
>>> On Fri, May 18, 2012 at 12:45 AM, Yinghai Lu <yinghai@kernel.org>
>>> wrote:
>>>> On Thu, May 17, 2012 at 9:36 AM, Yinghai Lu <yinghai@kernel.org>
>>>> wrote:
>>>>> On Thu, May 17, 2012 at 5:34 AM, Steven Newbury
>>>>> <steve@snewbury.org.uk> wrote:
>>>>>> -----BEGIN PGP SIGNED MESSAGE----- Strange, the busn branch
>>>>>> is merged with for-pci-res-alloc, but for some reason it
>>>>>> isn't working.  Only the bridge is detected, not the devices
>>>>>> behind it.
>>>>>
>>>>> Can you post the boot log ? maybe recently reordering patches
>>>>> applying sequence break it.
>>>>
>>>> Never mind, found the problem.
>>>
>>> updated for-pci-res-alloc branch. please check it.
>>>
>> Tested and working fine now.
>
> Can you attach dmesg logs without Yinghai's patches (where I assume it
> doesn't work) and with them (where it *does* work) to the bugzilla?  I
> assume https://bugzilla.kernel.org/show_bug.cgi?id=10461 is still the
> relevant report.
>
> I'm confused because I thought your _CRS showed no apertures above
> 4GB, and I'm trying to figure out how Yinghai's patches can help if
> that's the case.

Your _CRS *doesn't* show any apertures above 4GB, but you're booting
with "pci=nocrs", so we ignore them anyway.  Doing hotplug with
"pci=nocrs" is not a supportable proposition.

Patches that help in the "pci=nocrs" case might be acceptable, but
only if there is clearly no risk to the "pci=use_crs" case.
