Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:33702 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138AbbHXVZq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Aug 2015 17:25:46 -0400
MIME-Version: 1.0
In-Reply-To: <CA+8MBb+yJ9ywFnmfCAEPF0ZBQfH1R9b8hzmwVpM8+rsyJkEW5Q@mail.gmail.com>
References: <1415089784-28779-1-git-send-email-daniel@numascale.com>
	<1415089784-28779-4-git-send-email-daniel@numascale.com>
	<20150821181910.GA31378@agluck-desk.sc.intel.com>
	<CAE9FiQXWXPexLM8xma8Cb9R9hpR2+tOwzGtmJxzH5uuyPraDpQ@mail.gmail.com>
	<20150821202707.GA920@agluck-desk.sc.intel.com>
	<CAE9FiQU-=oAzi_benuEm=x_Y_LUp48uND6cGnx9osbYyPWySdw@mail.gmail.com>
	<CA+8MBbL4nqTxi14Lz92PRFZeobHBLimSfcTH=9HaZBcEUpLVOg@mail.gmail.com>
	<CAE9FiQVJozeJ9R9GgMEVPfJaSJL+J+M3ULu2VXPjrdDqnYGwvw@mail.gmail.com>
	<CA+8MBb+yJ9ywFnmfCAEPF0ZBQfH1R9b8hzmwVpM8+rsyJkEW5Q@mail.gmail.com>
Date: Mon, 24 Aug 2015 14:25:45 -0700
Message-ID: <CAE9FiQUDb=uNKV9Bj34v3vvMT04MiuoRHqTq6=KTMd+DVrMVNg@mail.gmail.com>
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

On Mon, Aug 24, 2015 at 1:41 PM, Tony Luck <tony.luck@gmail.com> wrote:
> On Mon, Aug 24, 2015 at 10:46 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>> Then, what does the E820 look like?
>
> See attached serial console log of the latest crash

Can you boot with "debug ignore_loglevel" so we can see following print out
for vmemmap?

[    0.352486]  [ffffea0000000000-ffffea0001ffffff] PMD ->
[ffff88007de00000-ffff88007fdfffff] on node 0
[    0.358758]  [ffffea0004000000-ffffea0005ffffff] PMD ->
[ffff88017d600000-ffff88017f5fffff] on node 1
