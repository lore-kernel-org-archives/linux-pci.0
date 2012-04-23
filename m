Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:49701 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591Ab2DWUNm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Apr 2012 16:13:42 -0400
MIME-Version: 1.0
In-Reply-To: <20120422155202.GA13540@richard>
References: <20120410090306.GA7056@richard>
	<20120422155202.GA13540@richard>
Date: Mon, 23 Apr 2012 13:13:41 -0700
Message-ID: <CAE9FiQXoUcUw5kOcBmsbBu_hJ+GbKk--qFt+WyUHbjJPwY+8Pw@mail.gmail.com>
Subject: Re: One problem in reassign pci bus number?
From: Yinghai Lu <yinghai@kernel.org>
To: Richard Yang <weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Apr 22, 2012 at 8:52 AM, Richard Yang
<weiyang@linux.vnet.ibm.com> wrote:
> All,
>
> I am reading the pci_scan_bridge() and not sure what will happen in
> following situation.
>
> Suppose the kernel is not passed the pci=assign-busses.
>
> Below is a picture about the pci system.
>
>                   +-------+
>                   |       | root bridge(0,255)
>                   +---+---+
>                       |          Bus 0
>      -----+-----------+------------------------------+--
>           |                                          |
>           |                                          |
>           |                                          |
>      +----+----+                               +-----+-----+
>      |         |  B1(1,15)                     |           |B2(16,28)
>      +----+----+                               +-----+-----+
>           |  Bus 1                                   |    Bus 16
>      -----+-----------------------         ----------+----------------
>                            |
>                       +----+----+
>                       |         | B3
>                       +---------+
>
> Suppose B1 and B2 works fine with the BIOS, which get the right bus
> number and range.
>
> B3 does not works fine with the BIOS, which doesn't get the bus number.
>
> So in pci_scan_bridge(), B3 will be met in the second pass and get bus
> number 16?
> Would this be a conflict?

busn_alloc patchset should address your concern.

git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
for-pci-busn-alloc

Yinghai
