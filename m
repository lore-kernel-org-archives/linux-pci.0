Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CA+8MBbK6wu+7-M+fP8_GMmhUDSMZ4akOVRkW8xaP8x0pqJN0bQ@mail.gmail.com>
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
Date: Mon, 24 Aug 2015 16:41:07 -0700
Message-ID: <CAE9FiQUAAQZ4RF9rTxthBCJAJyDkw1g3dckfeJ870gqK9Dzg9A@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 24, 2015 at 3:39 PM, Tony Luck <tony.luck@gmail.com> wrote:
> On Mon, Aug 24, 2015 at 2:25 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>
>> Can you boot with "debug ignore_loglevel" so we can see following print out
>> for vmemmap?
>
> See attached. There are a few extra messages from my own debug printk()
> calls. It seems that we successfully deal with node 0 from topology_init()
> but die walking node 1. I see that the NODE_DATA limits for memory
> on node 1 were from 1d70000 to 3a00000. But when we get into
> register_mem_sect_under_node() we have rounded the start pfn down to
> 1d00000 ... and we panic processing that range (which is in a hole in e820).
>
> We seem to die here:
>
>         for (pfn = sect_start_pfn; pfn <= sect_end_pfn; pfn++) {
>                 int page_nid;
>
>                 page_nid = get_nid_for_pfn(pfn);

oh, no.
register_mem_sect_under_node() is assuming:
first section in the block is present and first page in that section is present.
