Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:40636 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756948AbaGQQdZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jul 2014 12:33:25 -0400
Received: by mail-ie0-f175.google.com with SMTP id x19so3285701ier.20
        for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2014 09:33:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKAYmMJOWtn268Kipwm6JVamrsrfxCG=Ju8E56-ZCXctBn+12A@mail.gmail.com>
References: <CAKAYmMLfxkmaVxaPDd6z=B0ESQ3mR=dUG4OFFgEoy0295qLYgg@mail.gmail.com>
	<CAKAYmMLhPhukBbR8NhPk3EigmvwiX+DEGj-Mod7zpHMnZKRsLw@mail.gmail.com>
	<CAErSpo7vooChRfSF6oY8GcqVYZruv-7_D0zm3a4M_KDVMbWNiA@mail.gmail.com>
	<CAE9FiQWomktcpSHeFwxWBLXmAsbdXEHv6sOrNXodobkBw=mRKA@mail.gmail.com>
	<CAE9FiQW+GbprQZNvHC-ek1cSydP3KWcjgAU0ii5_jECC1+tXrg@mail.gmail.com>
	<CAKAYmMJf=TdpdyALZQOoAmdgPjpzFu-OP7rMLzyaFRno-36F6Q@mail.gmail.com>
	<CAE9FiQUn4QByiaPqKnk=CCmCXsnaqVfNCjynoyNM3FucrKGhew@mail.gmail.com>
	<CAKAYmMJOWtn268Kipwm6JVamrsrfxCG=Ju8E56-ZCXctBn+12A@mail.gmail.com>
Date: Thu, 17 Jul 2014 09:33:24 -0700
Message-ID: <CAE9FiQUWnW0uSBN2Pmt6t2EADQysf3=RGqj0c1Bjopgf1qbMuw@mail.gmail.com>
Subject: Re: Error assigning BAR 0 to hotplugged device
From: Yinghai Lu <yinghai@kernel.org>
To: Chuck Tuffli <ctuffli@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 17, 2014 at 8:08 AM, Chuck Tuffli <ctuffli@gmail.com> wrote:
> On Wed, Jul 16, 2014 at 7:15 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> If the BIOS doesn't allocate enough memory mapped IO resources for
>>> devices, it sounds like the kernel can't really fix this problem,
>>> right?
>>
>> Yes. You need to fix BIOS at first.
>>
>> So it will be final products or just development prototype?
>
> This is a prototype development system I'm using to develop software.
> Since a BIOS fix isn't likely to happen, are there existing features I
> can use to work around this problem?

You need have a scripts with kexec to reload kernel.
1. make sure that card is the slot 9b:15.0
2. boot system with kernel.
3. unload or unbind the drivers for devices under 80:03.0
4. use setpci to clear bridge io, mmio, mmio pref bars with 80:03.0
5. kexec load kernel and start kernel again.
