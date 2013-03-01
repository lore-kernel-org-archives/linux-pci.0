Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nm14.access.bullet.mail.mud.yahoo.com ([66.94.237.215]:46179
	"EHLO nm14.access.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750696Ab3CAPMN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Mar 2013 10:12:13 -0500
Message-ID: <5130BF39.60403@att.net>
Date: Fri, 01 Mar 2013 08:46:17 -0600
From: Pete Zievers <pjz@att.net>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: PCI rescan
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  Hi-

Right now I am using 64-bit Red Hat Fedora 16.  The kernel version is 
3.1.0-7.fc16.x86_64.

I'm interested in an API that will achieve from within C-language code 
compiled using gcc what can be accomplished from the shell with the 
following invocation:

echo 1 > /sys/bus/pci/devices/<device designator>/remove
echo 1 > /sys/bus/pci/rescan

I find that at the shell level the above works great for me but is 
slow.  I need it to work perhaps an order of magnitude faster for what 
I'm attempting.

Any help you could give me would be greatly appreciated.  If possible it 
would be great if you could give me a short code snippet and whichever 
libraries are involved with some indication as to where I'd need to get 
such libraries.  If I need to upgrade my Linux that's a perfectly okay 
thing to suggest.

regards
Pete Zievers
