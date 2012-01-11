Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:32932 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756976Ab2AKSBP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2012 13:01:15 -0500
Received: by yenm10 with SMTP id m10so456746yen.19
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2012 10:01:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CA+55aFz7OpwZuqu+f4AMpWjyjM7B-V2iAzpgROdg289RW8AE1w@mail.gmail.com>
References: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
	<1323247984-15281-3-git-send-email-yinghai@kernel.org>
	<20120106134915.705f5b47@jbarnes-desktop>
	<CA+55aFwDSm=0qf3VmcocZa_jtkopxLpKxwtmXeNp4NJ3dyEQjA@mail.gmail.com>
	<CAE9FiQVf1x1PggJpWundVJP6mchy5Gv4_MntRe_8c2RThd=zsQ@mail.gmail.com>
	<CA+55aFz7OpwZuqu+f4AMpWjyjM7B-V2iAzpgROdg289RW8AE1w@mail.gmail.com>
Date: Wed, 11 Jan 2012 10:01:14 -0800
Message-ID: <CAE9FiQUEgtFidaHNSYnz61AoKFWVmjP4ryen9DgT8=cu+nM+SA@mail.gmail.com>
Subject: Re: [PATCH 2/5] PCI: Try to assign required+option size at first
From: Yinghai Lu <yinghai@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Ram Pai <linuxram@us.ibm.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 10, 2012 at 10:20 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sun, Jan 8, 2012 at 10:01 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>
>> Spent some time today, try to produce some patches according to your direction.
>>
>> Please check them to see if it is with your thoughts.
>
> Get rid of "insert_list_before()". That's a particularly bad
> implementation of "list_add_tail()", which we already have. And
> list_add_tail() generates better code, and supports the proper full
> list debugging.
>
> (Think about it: adding something "before" an entry in a doubly-linked
> circular list is the same as adding it at the tail of the list - it's
> circular!)

Indeed.  could just use list_add_tail instead.

>
> The other patches look reasonable, but I only gave them a quick look.


> Although why is "free_list()" a #define rather than a real function
> (apart from the obvious reason that it used to be that before too..)
>
> Oh, and I just noticed that you fixed that in the "merge struct"
> patch, which is good, except I think it would be much better to aim to
> do *one* thing per patch, instead of mixing them up like that.

ok, will separate to another patch about free_list changes.

>
> .. and when you merged the "_x" resource struct, you still left the
> variables with the "_x" names.. Do you really need dev_res and
> dev_res_x variables?

sure,  will drop _x.

Thanks

Yinghai
