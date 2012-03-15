Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39099 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032043Ab2CORku convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 15 Mar 2012 13:40:50 -0400
Received: by dajr28 with SMTP id r28so4826993daj.19
        for <linux-pci@vger.kernel.org>; Thu, 15 Mar 2012 10:40:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0bb101cd0276$7aa36ee0$6fea4ca0$@jp.fujitsu.com>
References: <1330570837-26638-1-git-send-email-yinghai@kernel.org>
	<0bb101cd0276$7aa36ee0$6fea4ca0$@jp.fujitsu.com>
Date: Thu, 15 Mar 2012 10:40:50 -0700
Message-ID: <CAE9FiQU=H1kUYELFjEnu9XuF62uoQ_NSP2jGB8HAOAUkP+-mEg@mail.gmail.com>
Subject: Re: [PATCH -v2 00/36] PCI: pci_host_bridge related cleanup and busn_alloc
From: Yinghai Lu <yinghai@kernel.org>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> The patches need to apply to pci/for-linus and pci/linux-next
>> because one patch that is needed only is only in pci/for-linus
>
>  I can't apply your patchset to pci/linux-next.
>  I reckon your patchset needs refresh, or did I do something wrong?

pci/linux-next missed one patch that is already in linus tree.

>
>  My impression is you should split your patchset between hostbridge part and
>  bus-allocation part.

After Jesse rebase pci/linux-next today or tomorrow.  Because he need
to update some patches from Bjorn.

I will split them and rebase them
1. hostbridge clean up
2. busn_res alloc.
3. root bus hotplug related
4. more hotplug clean up.

Thanks

Yinghai
