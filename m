Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from sender1.zohomail.com ([72.5.230.103]:33621 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbaGNGdg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jul 2014 02:33:36 -0400
Message-ID: <53C36D75.2060002@zoho.com>
Date: Mon, 14 Jul 2014 01:41:09 -0400
From: Kyle Auble <kyle.auble@zoho.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: Help understanding a possible timing issue in PCIe link training?
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello, I wanted to keep this email short, but my questions are all
interconnected. My GPU is an on-board Nvidia GeForce 8400M GT
(pci id [10de:0426]), and since at least kernel v3.2, the generic x86
kernel only loads the device 1 in 10 times. This is still true as of
v3.16-rc3. Honestly, it's probably something that the BIOS should
prevent, but I've checked and there are no relevant options or upgrades
for my BIOS (on a Sony Vaio VGN-FZ260E).

I've been tracking this problem at launchpad.net on-and-off for a
couple years now, but I don't think it's a common issue, and I have
some free time to try resolving it myself now. I'm new to system
programming though so I was wondering: Does the issue I'm seeing fit a
pattern of some kind? Can someone help me understand how the symptoms
fit together and where they come from? Or if I need to do more
analysis, what would probably be the best approach?

1.The key thing I discovered is that whenever the GPU does load, a ~6ms
gap appears in the dmesg logs during the GPU's pci initialization. When
the GPU fails to load though, this gap grows to 30ms. Also, I've
pinpointed the delay (with dev_info statements) to:
pcie_aspm_configure_common_clock in drivers/pci/pcie/aspm.c

After some googling, I came across powerpoints from the PCI-SIG
organization that mention 24ms as precisely the PCIe specified timeout
for some states of link training, and sure enough, this function tells
the bridge upstream of the GPU to retrain the link. However, even when
the GPU fails to load and 30ms is spent in the function, the dev_err
towards the end of the function doesn't print.

2.Now the first reason I'm pretty certain that this isn't strictly a
hardware issue beyond recovery is that there's a workaround. If I make
sure my computer is running off of the battery, without AC power, for
that first second of kernel initialization, the GPU always loads. I've
tried this dozens of times. I don't clearly understand why, but I've
read that the power-saving link states do correspond to distinct states
in the link-training state machine.

3.The next fact (that I have no explanation for) is that the situation
reverses almost exactly on the amd64 kernel. The 64-bit kernel boots
the GPU fine 9 times out of 10, but there is still the occasional
session where the 30ms gap appears and the GPU never loads.

4.To keep things simple, I also tried inserting dev_info statements
within the different branches of pcie_aspm_configure_common_clock, but
this made the problem disappear (and there was only a 6ms gap). I tried
once more with fewer statements to reduce overhead, which did increase
the time gap to 11ms but still allowed the GPU to load. The idea that
more overhead in the function affects timing makes sense to me, but
that it decreases time spent in the function is counter-intuitive.

5.Finally, before I started looking through the code, I tried some git
bisections because there was a brief time in summer of 2013 where the
problem went away. The commit that resolved it turned out to be:
d34883d4e35c0a994e91dd847a82b4c9e0c31d83 by Xiao Guangrong
After the problem returned, I tried another bisection, but wound up
doing a manual bisection instead of using git bisect (I honestly don't
remember why). The commit I found that reintroduced the problem was:
ee8209fd026b074bb8eb75bece516a338a281b1b by Andy Shevchenko

What stumps me is that neither of these commits appears directly
related to the pci subsystem. Because it wasn't a normal bisection that
returned Andy's commit and I didn't test that build as much, I still
wonder if it's a false positive. However, I've tested a kernel built at
Xiao's commit many times so I'm confident it resolved the issue, though
my hypothesis is that it's purely by a subtle side effect of how the
raw assembly is loaded into memory at startup.

Again, I apologize for the length, but I'd be grateful for any advice.
I'm not registered on the mailing list so I would appreciate being
CC'ed in any replies. I don't plan on becoming a regular kernel hacker
anytime soon, just want to do my tiny part to help.

Sincerely,
Kyle Auble

