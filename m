Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nm7.bullet.mail.bf1.yahoo.com ([98.139.212.166]:40496 "EHLO
        nm7.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753474AbcKYROL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2016 12:14:11 -0500
Date: Fri, 25 Nov 2016 15:01:29 -0200
From: =?utf-8?Q?Rog=C3=A9rio?= Brito <rbrito@ime.usp.br>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: Multiple problems with the Linux kernel on an AMD desktop
Message-ID: <20161125170129.fq52k7nfukxd5efl@ime.usp.br>
References: <20161124233957.k2twr352kna6ukd2@ime.usp.br>
 <20161125070159.ner7xvizvo2upb6h@pd.tnic>
 <20161125160548.b4wxokxffhk5zt6r@ime.usp.br>
 <80eb4533-2233-6b75-eae9-99f6decebd88@ladisch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <80eb4533-2233-6b75-eae9-99f6decebd88@ladisch.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Clemens and others.

On Nov 25 2016, Clemens Ladisch wrote:
> Rogério Brito wrote:
> >     [  130.007219] evbug: Event. Dev: input6, Type: 0, Code: 0, Value: 0
> 
> The evbug module is intended for debugging; it dumps all input events
> into syslog.  If you do not want these messages, do not load this module.
> (If it is loaded automatically, you have an actual bug.)

It *was* loaded automatically, and I didn't specifically asked it to be
loaded, but I'm not sure if other parts of userspace forced it to be
loaded. I will disable it, then.

Here is the relevant part of the config file:

,----[ grep -i evbug /boot/config-4.9.0-040900rc6-generic ]
| CONFIG_INPUT_EVBUG=m
`----


Thanks,

-- 
Rogério Brito : rbrito@{ime.usp.br,gmail.com} : GPG key 4096R/BCFCAAAA
http://rb.doesntexist.org/blog : Projects : https://github.com/rbrito/
DebianQA: http://qa.debian.org/developer.php?login=rbrito%40ime.usp.br
