Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:35772 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbbHZFmH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Aug 2015 01:42:07 -0400
MIME-Version: 1.0
In-Reply-To: <20150826041716.GA14102@gmail.com>
References: <CAE9FiQXWXPexLM8xma8Cb9R9hpR2+tOwzGtmJxzH5uuyPraDpQ@mail.gmail.com>
	<20150821202707.GA920@agluck-desk.sc.intel.com>
	<CAE9FiQU-=oAzi_benuEm=x_Y_LUp48uND6cGnx9osbYyPWySdw@mail.gmail.com>
	<CA+8MBbL4nqTxi14Lz92PRFZeobHBLimSfcTH=9HaZBcEUpLVOg@mail.gmail.com>
	<CAE9FiQVJozeJ9R9GgMEVPfJaSJL+J+M3ULu2VXPjrdDqnYGwvw@mail.gmail.com>
	<CA+8MBb+yJ9ywFnmfCAEPF0ZBQfH1R9b8hzmwVpM8+rsyJkEW5Q@mail.gmail.com>
	<CAE9FiQUDb=uNKV9Bj34v3vvMT04MiuoRHqTq6=KTMd+DVrMVNg@mail.gmail.com>
	<CA+8MBbK6wu+7-M+fP8_GMmhUDSMZ4akOVRkW8xaP8x0pqJN0bQ@mail.gmail.com>
	<CAE9FiQUAAQZ4RF9rTxthBCJAJyDkw1g3dckfeJ870gqK9Dzg9A@mail.gmail.com>
	<CAE9FiQXH0SxTCaw-J=nEhYtbuZfBDU3R+v_XRZYF6ymeXnPsgg@mail.gmail.com>
	<20150826041716.GA14102@gmail.com>
Date: Tue, 25 Aug 2015 22:42:05 -0700
Message-ID: <CAE9FiQXFHWNR41yEDjj=tAteanbngXQNQcwZvvVVexRmAQTTeA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] Use 2GB memory block size on large-memory x86-64 systems
From: Yinghai Lu <yinghai@kernel.org>
To: Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tony Luck <tony.luck@gmail.com>,
	Daniel J Blueman <daniel@numascale.com>,
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

On Tue, Aug 25, 2015 at 9:17 PM, Ingo Molnar <mingo@kernel.org> wrote:
> NAK due to lack of cleanliness: the two loops look almost identical - this sure
> can be factored out...

Please check complete version at

https://patchwork.kernel.org/patch/7074341/

Andrew,
Ingo NAKed raw version of this patch, so you may need to remove it
from -mm tree.

Thanks

Yinghai
