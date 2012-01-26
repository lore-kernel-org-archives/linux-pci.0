Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <m2mx9ev85j.fsf@bob.laptop.org>
References: <201201151255.41252.roucaries.bastien@gmail.com>
	<CAE2SPAb3Ozk7LHrqE_asazZ7kEogXEH=2S8D5PUprqXZK2o9Ow@mail.gmail.com>
	<m2mx9ev85j.fsf@bob.laptop.org>
Date: Thu, 26 Jan 2012 10:54:50 +0100
Message-ID: <CAE2SPAbpeHiz_JByYGrMJ6s1_yCM3SaQ8xjx4heuT2_i2Gyxcw@mail.gmail.com>
Subject: Re: Need pci rescan in order to get my mmc reader
From: Bastien ROUCARIES <roucaries.bastien@gmail.com>
To: Chris Ball <cjb@laptop.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 23, 2012 at 2:51 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Mon, Jan 23 2012, Bastien ROUCARIES wrote:
>> On Sun, Jan 15, 2012 at 12:55 PM, bastien ROUCARIES
>> <roucaries.bastien@gmail.com> wrote:
>>> I am hit by the same bug than here
>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/703180
>>>
>>> I order to get my mmc reader functionnal I need to put a mmc card
>>> and do a pci rescan manualy.
>>>
>>> What could be done  ?
>>>
>>> What do you need in order to help ?
>>>
>>> Thanks
>
> I'm not sure there's anything I (at the MMC layer) can do to help;
> having a visible PCI device is a prerequisite for working MMC.
>
> Have you tried a recent upstream kernel, and looked for any available
> BIOS updates for your laptop?

BIOS is lasted and kernel is 3.1.

I know that  PCI device is a prerequisite  but I believe it is
possible to run some quirk on this laptop, in order to get the mmc
reader up earlier.

See also https://bugzilla.kernel.org/show_bug.cgi?id=40802

perhap loading by default pci hotplug and do a rescan every second ?

Bastien
>
> Thanks,
>
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
