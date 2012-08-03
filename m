Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:41325 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042Ab2HCQcl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Aug 2012 12:32:41 -0400
Received: by vcbfk26 with SMTP id fk26so867704vcb.19
        for <linux-pci@vger.kernel.org>; Fri, 03 Aug 2012 09:32:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOp+P+r+GDsV1y71+tS1WJxYVtymA-gH-JT6XRtEn4wScP6+Hg@mail.gmail.com>
References: <CAOp+P+o5frkFRkrG9=2-3OL1AgDy+zVCbLgRqRVkm0yW_MaFVw@mail.gmail.com>
	<CAE9FiQUZvMyXjydOdsiBG7YJGA696ihdFkuKj6NMu589NTELCA@mail.gmail.com>
	<CAOp+P+rsAW2pBZNNSW2ehEDVQB=zSFkweVRDmPcePCiEd5_8DA@mail.gmail.com>
	<CAE9FiQW7PR9L=4QtcOvFxN7jRbVSx9MpAnsBzXiJ50D+FATVEw@mail.gmail.com>
	<CAOp+P+rrjd=g6A_knEsHmO44WHUYuud++5qY8WQrsOX-z4kL9g@mail.gmail.com>
	<CAE9FiQXuZ6rfgjJaJL752Ph+cDLv7XgxBOqzsWRZQDqqUUVrxw@mail.gmail.com>
	<CAOp+P+r+GDsV1y71+tS1WJxYVtymA-gH-JT6XRtEn4wScP6+Hg@mail.gmail.com>
Date: Fri, 3 Aug 2012 09:32:41 -0700
Message-ID: <CAE9FiQXeNvndA2NfoQ-cgJo+s128bY6QFiugb2ocZdk=GGyd6g@mail.gmail.com>
Subject: Re: PCI express switch
From: Yinghai Lu <yinghai@kernel.org>
To: =?ISO-8859-1?Q?Miguel_=C1ngel_=C1lvarez?=
	<caronteycerbero@gmail.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 3, 2012 at 2:20 AM, Miguel Ángel Álvarez
<caronteycerbero@gmail.com> wrote:
> Sorry,
>
> I found no sense in sending the bootlog because there were no
> differences with the previously ones.
>
> But if you think I should send them, please tell me.

please send out the whole boot log with PCI_DEBUG.

need to check if the bus range setting is not right or not.

also you could try my busn-alloc branch to see if it would help.

   git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
for-pci-busn-alloc

Thanks

Yinghai
