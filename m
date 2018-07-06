Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:33666 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932751AbeGFTNC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Jul 2018 15:13:02 -0400
Date: Fri, 6 Jul 2018 22:12:59 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: HH DL585 warm boot fail (old)
Message-ID: <alpine.LRH.2.21.1807051515260.21817@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I have a first gen HP Proliant DL585 ("G1" but the name was not used 
back then) that boots up fine from poweron but usually fails bootup from 
warm reboot, somewhere in PCI detection (will try to photographs the 
screen some time).

I just stumbled upon an old OpenSolaris thead about the same DL585 and 
same symptoms: 
http://opensolaris-discuss.opensolaris.narkive.com/T0UTXYGZ/solaris-10-06-06-x86-hp-dl585-boot-hang-aftrer-reboot-help

Their conclusion was the wfollowing and they seem to have found a fix 
(although I have not tested any version of Solaris on this DL585 
myself):

"The hang is caused when, during PCI enumeration, a PCI-PCI bridge is 
partially disabled when the PCI command register bits which enable IO 
and memory windows are cleared."

Is this information useful in some way for debugging it?

What else besides screenshot of the can be useful in debugging?

-- 
Meelis Roos (mroos@linux.ee)
