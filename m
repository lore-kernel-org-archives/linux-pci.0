Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34528 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbbHUXyN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2015 19:54:13 -0400
MIME-Version: 1.0
In-Reply-To: <CAE9FiQU-=oAzi_benuEm=x_Y_LUp48uND6cGnx9osbYyPWySdw@mail.gmail.com>
References: <1415089784-28779-1-git-send-email-daniel@numascale.com>
	<1415089784-28779-4-git-send-email-daniel@numascale.com>
	<20150821181910.GA31378@agluck-desk.sc.intel.com>
	<CAE9FiQXWXPexLM8xma8Cb9R9hpR2+tOwzGtmJxzH5uuyPraDpQ@mail.gmail.com>
	<20150821202707.GA920@agluck-desk.sc.intel.com>
	<CAE9FiQU-=oAzi_benuEm=x_Y_LUp48uND6cGnx9osbYyPWySdw@mail.gmail.com>
Date: Fri, 21 Aug 2015 16:54:12 -0700
Message-ID: <CA+8MBbL4nqTxi14Lz92PRFZeobHBLimSfcTH=9HaZBcEUpLVOg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] Use 2GB memory block size on large-memory x86-64 systems
From: Tony Luck <tony.luck@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Daniel J Blueman <daniel@numascale.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"the arch/x86 maintainers" <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Steffen Persvold <sp@numascale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 21, 2015 at 1:50 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> It seems that many systems with large amounts of memory
>> will have a nicely aligned max_pfn ... so they will get
>> the 2GB block size.  If they don't have a well aligned
>> max_pfn, then they need to use a smaller size to avoid
>> the crash I saw.
>
> Good to me.

Still stuff going on that I don't understand here. I increased the amount of
mirrored memory in this machine which moved max_pfn to 0x7560000
and probe_memory_block_size() picked 512MB as the memory_block_size,
which seemed plausible.

But my kernel still crashed during boot with this value. :-(
Forcing the block size to 128M made the system boot.

Maybe all the holes in the e820 map matter too (specifically the
alignment of the holes)?

-Tony
