Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from blu0-omc4-s4.blu0.hotmail.com ([65.55.111.143]:5297 "EHLO
	blu0-omc4-s4.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751677Ab2FDLAP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jun 2012 07:00:15 -0400
Message-ID: <BLU0-SMTP435F81F04D60963F0755BA9B70F0@phx.gbl>
Date: Mon, 4 Jun 2012 12:00:10 +0100
From: Rob Allen <ra-kernel@hotmail.co.uk>
MIME-Version: 1.0
To: Ram Pai <linuxram@us.ibm.com>
CC: Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Clemens Ladisch <clemens@ladisch.de>,
	Yinghai Lu <yinghai@kernel.org>,
	linux1394-devel@lists.sourceforge.net, linux-pci@vger.kernel.org
Subject: Re: [Bug 43244] New: firewire_ohci prevents boot
References: <bug-43244-4803@https.bugzilla.kernel.org/> <20120513221357.7574ae79@stein> <4FB0A6F6.9050504@ladisch.de> <CAE9FiQXA4C8hACXChokL4CZVBDhdh17Qs7tngn5q-pS0U5=bPQ@mail.gmail.com> <BLU0-SMTP12B809D527F768CCC42B18B7180@phx.gbl> <4FB3B159.2090401@ladisch.de> <BLU0-SMTP47479D78AA811CB0B224ADFB71D0@phx.gbl> <4FBAA3A5.4070200@ladisch.de> <20120524202610.5c561d99@stein> <4FBE8146.1030803@hotmail.co.uk>
In-Reply-To: <4FBE8146.1030803@hotmail.co.uk>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Ram Pai,

I've found the change that introduced the failure I'm seeing, and it 
seems you are the author. Please can you offer some help?

commit 0a2daa1cf35004f5adbf4138555cc5669abf3a3e
Author: Ram Pai <linuxram@us.ibm.com>
Date:   Mon Jul 25 13:08:41 2011 -0700

     PCI: make cardbus-bridge resources optional

     Allocate resources to cardbus bridge only after all other genuine
     resources requests are satisfied. Dont retry if resource allocation
     for cardbus-bridges fail.

     Signed-off-by: Ram Pai <linuxram@us.ibm.com>
     Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>

Thanks,
Rob

