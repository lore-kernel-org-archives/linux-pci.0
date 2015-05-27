Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:35102 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbbE0G2P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 02:28:15 -0400
Received: by wgme6 with SMTP id e6so292930wgm.2
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2015 23:28:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150527075329.6df43854@pluto.restena.lu>
References: <20150223215155.18444386@neptune.home>
	<20150303172753.GF83894@vmdeb7>
	<20150305232038.1873d380@neptune.home>
	<20150306174254.GB19001@vmdeb7>
	<20150307011546.0050279d@neptune.home>
	<20150309225238.0b9ced4e@neptune.home>
	<CAErSpo61r-_hy1hfUMm2ooXZVLTBhtjd-x5uXbyEg=WcG=itnQ@mail.gmail.com>
	<20150311223445.6af76f7c@neptune.home>
	<CAGr1u3tKVtQno=hUrKemLFYG12dtvPjFVR7oFwDG5cewJGCnJQ@mail.gmail.com>
	<20150527044749.GB21644@fury.dvhart.com>
	<20150527075329.6df43854@pluto.restena.lu>
Date: Tue, 26 May 2015 23:28:14 -0700
Message-ID: <CAGr1u3sBpENgVL9zF_LCFXtBv6S2FS5o1bRtFxwyn3P_kx=s-A@mail.gmail.com>
Subject: Re: [Patch v3] apple-gmux: lock iGP IO to protect from vgaarb changes
From: Michael Marineau <michael.marineau@coreos.com>
To: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Cc: Darren Hart <dvhart@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	platform-driver-x86@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Petri Hodju <petrihodju@yahoo.com>,
	Matthew Garrett <matthew.garrett@nebula.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 26, 2015 at 10:53 PM, Bruno Prémont
<bonbons@linux-vserver.org> wrote:
> Hi Michael,
>
> On Tue, 26 May 2015 21:47:49 -0700 Darren Hart wrote:
>> On Tue, May 26, 2015 at 12:10:48PM -0700, Michael Marineau wrote:
>> > FYI, this actually broke backlight controls on my MBP11,3 because the
>> > assumption the patch makes that gmux is always loaded before graphics
>> > drivers didn't hold true. At least for me dracut included the nouveau
>> > module in the initrd but not gmux, ensuring the ordering was wrong. No
>> > errors were reporting, and gmux still offered the backlight device, it
>> > just became inoperable. I worked around this for my kernel by building
>> > gmux into vmlinuz instead of as a module but that isn't going to in
>> > more general configs because there is an apple backlight driver which
>> > cannot be built at all in that configuration.
>>
>> Thank you for reporting this Michael,
>>
>> That is tough as nouveau doesn't have an explicit dependency on gmux, so we
>> could do something like a passive request_module(), but if it isn't in the
>> initrd image, it would still fail as you describe.
>>
>> > Is there a way to make the ordering between nouveau and gmux more
>> > explicit/reliable? Can gmux complain loudly if the ordering is ever
>> > wrong?
>>
>> It should print an error if the probe fails due to the IO already being in use
>> or if it can't be allocated. The disabled IO case is only info level though,
>> perhaps that should be higher priority. Printing something when failing to probe
>> seems like a reasonable thing to do.
>>
>> Michael, which message do you get if you boot with "debug" or "loglevel=6" when
>> apple-gmux is not built-in?
>
> A full kernel log up to including post-initrd loading of gmux would be
> useful.
>
> As far as I have seen nouveau should not be doing unneeded vgaarb
> operations by itself (though userspace might be) as opposed to closed
> nvidia driver.
>
> If your systems allows, try booting to init=/bin/bash, then check for
> backlight, load nouveau, check for backlight and finally load gmux and
> check backlight (putting i915 in the mix where initrd/userspace puts
> it would be nice).

Both before and after loading nouveau there is a working acpi_video
backlight control. Then after loading gmux it is the only backlight
control and it doesn't do anything.
