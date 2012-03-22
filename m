Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46641 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715Ab2CVAIe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Mar 2012 20:08:34 -0400
Received: by vcqp1 with SMTP id p1so1558039vcq.19
        for <linux-pci@vger.kernel.org>; Wed, 21 Mar 2012 17:08:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F6A5A53.305@fold.natur.cuni.cz>
References: <4F6A483D.50702@fold.natur.cuni.cz>
	<CAE9FiQVnErU-cska4gpinyj-LOup-U+3vsEG2z_-7h6kyREYtw@mail.gmail.com>
	<4F6A5A53.305@fold.natur.cuni.cz>
Date: Wed, 21 Mar 2012 17:08:34 -0700
Message-ID: <CAE9FiQXP7fO9OGN557jdofFFiFj96wL--ZA8X3UPEJ6o9JLvBw@mail.gmail.com>
Subject: Re: 3.2.11: PCI Express card cannot be re-detected withing cca 60sec timeframe
From: Yinghai Lu <yinghai@kernel.org>
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 21, 2012 at 3:46 PM, Martin Mokrejs
<mmokrejs@fold.natur.cuni.cz> wrote:
> Hi Yinghai,
>  please find attached current dmesg output (not showing the bootup of the
> system anymore). at the end of the file you will see what happened when I
> inserted the card. I removed the card after some 10secs so that you can all.
> Sorry for the heavy USB debug messages. ;)
>  In another file a record of the previous boot (new.dmesg2.txt).
>
>  So shall I try the patch you sent me? ;-)

that may only help on some case like just booting up.

You may need to check.

git://git.kernel.org/pub/scm/linux/kernel/git/jbarnes/pci.git linux-next

there is one patch there that is going to power down the link.
http://git.kernel.org/?p=linux/kernel/git/jbarnes/pci.git;a=patch;h=2debd9289997fc5d1c0043b41201a8b40d5e11d0

Thanks

Yinghai
