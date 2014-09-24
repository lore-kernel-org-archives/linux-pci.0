Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout1.freenet.de ([195.4.92.91]:46310 "EHLO mout1.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753001AbaIXRTk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Sep 2014 13:19:40 -0400
Message-ID: <5422FC84.9060101@maya.org>
Date: Wed, 24 Sep 2014 19:16:52 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
CC: linux-pci <linux-pci@vger.kernel.org>
Subject: Re: Hard and silent lock up since linux 3.14 with PCIe pass through
 (vfio)
References: <20140923210318.498dacbd@dualc.maya.org> <1411502866.24563.8.camel@ul30vt.home> <5422DB3B.9070502@maya.org>
In-Reply-To: <5422DB3B.9070502@maya.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Andreas Hartmann wrote:
> Alex Williamson wrote:
[...]
>> Are you able to setup a serial console on this system?  Enabling sysrq
>> and getting a dump of task states (t) via serial is often the best way
>> to determine the problem. 
> 
> I'll try it.

I did it now like this:

minicom on the client.

Magic SysKeyRequest via minicom:

Ctrl-A shift-f [Syskey, like m or t, ...]


On the sender:
As kerneloption: console=tty0 console=ttyS0,115200n8

Before, you have to enable syskeyrequest via
sysctl -w kernel.sysrq=1

After doing all of this, you can test w/ m or t. The output will appear
on tty9 (via Alt-F10 on openSUSE).


But what was the result after starting the VM? -> Machine is definitely
completely dead. It doesn't react on anything any more.


Remarkable:
After hard reset, the USB keyboard doesn't work any more in Linux (but
in Grub 2), because the driver gets a timeout accessing the USB 3 hw
(other USB chips are working fine). It is necessary to switch of the
machine completely and remove the mains. After ~ 30s, it can be
repowered and all is working fine again (after repairing the broken FS
the VM resides on the host).


Any more hints are welcome :-)


Thanks,
kind regards,
Andreas
