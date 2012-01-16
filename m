Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35589 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232Ab2APEyq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Jan 2012 23:54:46 -0500
Received: by yhnn56 with SMTP id n56so997083yhn.19
        for <linux-pci@vger.kernel.org>; Sun, 15 Jan 2012 20:54:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120116032649.GC2601@ram-ThinkPad-T61>
References: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
	<1323247984-15281-3-git-send-email-yinghai@kernel.org>
	<20120113163922.GH7380@ram-ThinkPad-T61>
	<CAE9FiQWTVA=LDViVyfSXX6thgGv4TzOpqidVyG6FAdWQqAMWEg@mail.gmail.com>
	<20120115160558.GA2601@ram-ThinkPad-T61>
	<CAE9FiQX2wG9pEZHJE8LD7kL=eiCnFsaS6dRmyNf8F2Kgg=WcpQ@mail.gmail.com>
	<20120116032649.GC2601@ram-ThinkPad-T61>
Date: Sun, 15 Jan 2012 20:54:46 -0800
Message-ID: <CAE9FiQXk7mbThC5HxhZm0-h4b7QsYKszz48w0xQG=TLWL2nWVw@mail.gmail.com>
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

On Sun, Jan 15, 2012 at 7:26 PM, Ram Pai <linuxram@us.ibm.com> wrote:
>> Also I updated for-pci2 in my tree.
>>
>>       git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
>> for-pci2
>>
>> Peter Henriksson,
>> Can you try for-pci2 branch on your setup with Xonar DX?
>
> Peter should confirm it. But this patch will not fix the issue AFAICT.

Do you have similar setup to test that ?

> Its not just about 'not enough resources', it also about making the right
> choice of 'who should get the resource if there is contention'. Only the BIOS
> knows about it. But we trash the BIOS's allocation and don't use that
> knowledge when it comes to making those hard choices.

in extreme case, will let the user to use "pci=norealloc" to disable
changing pci bridge resource set by BIOS.

Yinghai
