Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53410 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755556Ab2APRNq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2012 12:13:46 -0500
Received: by ghbg16 with SMTP id g16so1882769ghb.19
        for <linux-pci@vger.kernel.org>; Mon, 16 Jan 2012 09:13:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120116102901.GA2377@ram-ThinkPad-T61>
References: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
	<1323247984-15281-3-git-send-email-yinghai@kernel.org>
	<20120113163922.GH7380@ram-ThinkPad-T61>
	<CAE9FiQWTVA=LDViVyfSXX6thgGv4TzOpqidVyG6FAdWQqAMWEg@mail.gmail.com>
	<20120115160558.GA2601@ram-ThinkPad-T61>
	<CAE9FiQX2wG9pEZHJE8LD7kL=eiCnFsaS6dRmyNf8F2Kgg=WcpQ@mail.gmail.com>
	<20120116032649.GC2601@ram-ThinkPad-T61>
	<CAE9FiQXk7mbThC5HxhZm0-h4b7QsYKszz48w0xQG=TLWL2nWVw@mail.gmail.com>
	<20120116102901.GA2377@ram-ThinkPad-T61>
Date: Mon, 16 Jan 2012 09:13:45 -0800
Message-ID: <CAE9FiQXQYfX3TAzo0=BOGkrV4vdaO+fXJgyGVSUF0DmVAzmzhA@mail.gmail.com>
Subject: Re: [PATCH 2/5] PCI: Try to assign required+option size at first
From: Yinghai Lu <yinghai@kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, peter.henriksson@gmail.com,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 16, 2012 at 2:29 AM, Ram Pai <linuxram@us.ibm.com> wrote:
>> > Its not just about 'not enough resources', it also about making the right
>> > choice of 'who should get the resource if there is contention'. Only the BIOS
>> > knows about it. But we trash the BIOS's allocation and don't use that
>> > knowledge when it comes to making those hard choices.
>>
>> in extreme case, will let the user to use "pci=norealloc" to disable
>> changing pci bridge resource set by BIOS.
>
> I know its a pathological case. But still this issue will be viewed as a
> regression.  I had to struggle to solve this regression in order to get your
> realloc patch re-accepted. Don't know if you can successfully make a case
> to by-pass the regression this time.

Yes, you had introduced the optional res concept, and that is very good.

but we still have some problems that my new patch set try to fix:
1. sometimes optional size is not passed to up bridge level correctly.
2. requested the expand optional does not go extra upper level.
3. requested and then expand does not work on two requested +
optional, only can make one happy. because request stuck in the
middle.

>
> One way to solve this problem is to allocate 'required' resources first, and
> later aggressively try to allocate 'required+optional' resources. However
> aggressively allocation of those 'required+optional' resource would require
> ensuring minimal internal fragmentation.

that will make case 2: do not go extra level.

or we can do:
We try to auto detect if we need to enable realloc.
(something like sriov is enabled, but some SRIOV registers are not assigned)
(or card bus are there etc)

and
pci=realloc become
pci=realloc=off and pci=realloc=on
so user can forcely turn it or off.

Thanks

Yinghai
