Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36370 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbbHYTBt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Aug 2015 15:01:49 -0400
MIME-Version: 1.0
In-Reply-To: <CA+8MBbKur4SLh-7EKhU16_ra7gbvnOARg-ZWScJWH9q1hKufZQ@mail.gmail.com>
References: <1415089784-28779-1-git-send-email-daniel@numascale.com>
	<1415089784-28779-4-git-send-email-daniel@numascale.com>
	<20150821181910.GA31378@agluck-desk.sc.intel.com>
	<CAE9FiQXWXPexLM8xma8Cb9R9hpR2+tOwzGtmJxzH5uuyPraDpQ@mail.gmail.com>
	<20150821202707.GA920@agluck-desk.sc.intel.com>
	<CAE9FiQU-=oAzi_benuEm=x_Y_LUp48uND6cGnx9osbYyPWySdw@mail.gmail.com>
	<CA+8MBbL4nqTxi14Lz92PRFZeobHBLimSfcTH=9HaZBcEUpLVOg@mail.gmail.com>
	<CAE9FiQVJozeJ9R9GgMEVPfJaSJL+J+M3ULu2VXPjrdDqnYGwvw@mail.gmail.com>
	<CA+8MBb+yJ9ywFnmfCAEPF0ZBQfH1R9b8hzmwVpM8+rsyJkEW5Q@mail.gmail.com>
	<CAE9FiQUDb=uNKV9Bj34v3vvMT04MiuoRHqTq6=KTMd+DVrMVNg@mail.gmail.com>
	<CA+8MBbK6wu+7-M+fP8_GMmhUDSMZ4akOVRkW8xaP8x0pqJN0bQ@mail.gmail.com>
	<CAE9FiQUAAQZ4RF9rTxthBCJAJyDkw1g3dckfeJ870gqK9Dzg9A@mail.gmail.com>
	<CAE9FiQXH0SxTCaw-J=nEhYtbuZfBDU3R+v_XRZYF6ymeXnPsgg@mail.gmail.com>
	<CA+8MBbKur4SLh-7EKhU16_ra7gbvnOARg-ZWScJWH9q1hKufZQ@mail.gmail.com>
Date: Tue, 25 Aug 2015 12:01:48 -0700
Message-ID: <CAE9FiQXp2DuD2=O5neDkHXCSy4M+7aX5c4Ev1Towz_hJGY0hNA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] Use 2GB memory block size on large-memory x86-64 systems
From: Yinghai Lu <yinghai@kernel.org>
To: Tony Luck <tony.luck@gmail.com>
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

On Tue, Aug 25, 2015 at 10:03 AM, Tony Luck <tony.luck@gmail.com> wrote:
> On Mon, Aug 24, 2015 at 4:59 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> attached should fix the problem:
>
> It does ... but this (attached) is simpler.  Your patch and mine both
> allow the system to boot ...

The version that fix with section_nr present checking may save couple thousands
calling to get_nid_for_pfn(). section size / page_size = 128M/4k = 32k

> but it is not happy. See all the chatter from systemd in the attached dmesg.

because of you have "debug ignore_loglevel" ?

>
> x86 doesn't allow me to set CONFIG_HOLES_IN_ZONE ... but now I'm
> worried about all the other places use pfn_valid_within()
>
> Still trying to get an answer from the BIOS folks on whether these
> holes are normal when setting up mirrored areas of memory.

The problem only happens when memory block size is 512M and section
size is 128M.
when you have them both at 128M, the system works. so current kernel
should only has
problem with hole size  > 128M to leave some section not present.

Thanks

Yinghai
