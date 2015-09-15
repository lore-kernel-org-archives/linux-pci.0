Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:35818 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbbIOVMI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 17:12:08 -0400
Received: by vkao3 with SMTP id o3so76539953vka.2
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2015 14:12:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55F88885.9070707@roeck-us.net>
References: <20150904164412.GD22997@red-moon>
	<CAE9FiQVB0swnTao3eS1kOLvwU-hm0aEpOTXP7wDKFGqtLQta5g@mail.gmail.com>
	<20150907091230.GB29293@red-moon>
	<20150914100929.GB18886@red-moon>
	<CAE9FiQV-eG42xzqVcO2Q+xT3jx-Oa7uC7fEuowvopx4Fp9F7hQ@mail.gmail.com>
	<20150914162834.GA11199@red-moon>
	<CAE9FiQWJfbMD1Akq6XD-Yedc+tNNF8o0obPGHt8f_WnWX0pLbA@mail.gmail.com>
	<CAE9FiQU6NTEdKJi58bNZU4u=+-rzB3mddp6vKGc4JjbZWoa9zQ@mail.gmail.com>
	<20150915094610.GD11199@red-moon>
	<CAErSpo5KaV7ERYcyZBzfvCEh40zSPJmymwXUCbAZkK=hb4DPSw@mail.gmail.com>
	<20150915163000.GA16240@red-moon>
	<55F84CAA.8060901@roeck-us.net>
	<CAE9FiQXrr2w5=QRpP9kL=xE4djwCz80wTPn1SA93Wg_u=6Tp3Q@mail.gmail.com>
	<55F88885.9070707@roeck-us.net>
Date: Tue, 15 Sep 2015 14:12:07 -0700
Message-ID: <CAE9FiQV_F32E+fsYaC2EX-PQhZ3FdjYsg4b0v-50LeAV2S8B=Q@mail.gmail.com>
Subject: Re: trouble with PCI: Call pci_read_bridge_bases() from core instead
 of arch code
From: Yinghai Lu <yinghai@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"oe5hpm@gmail.com" <oe5hpm@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Richard Henderson <rth@twiddle.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Howells <dhowells@redhat.com>,
	Russell King <linux@arm.linux.org.uk>,
	Tony Luck <tony.luck@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ingo Molnar <mingo@redhat.com>,
	Michal Simek <monstr@monstr.eu>,
	Chris Zankel <chris@zankel.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 15, 2015 at 2:07 PM, Guenter Roeck <linux@roeck-us.net> wrote:

>>
>> https://git.kernel.org/cgit/linux/kernel/git/yinghai/linux-yinghai.git/patch/?id=cdf4bfbc1ce12d826abd49a8987eb3ca7e129332
>>
>> and will sent that later if needed.
>>
>>> From cdf4bfbc1ce12d826abd49a8987eb3ca7e129332 Mon Sep 17 00:00:00 2001
>
> that isn't really my patch, so you should not send it under my name.
>

ok, I will drop that patch.
