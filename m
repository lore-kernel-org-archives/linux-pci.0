Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:51523 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144Ab2IDAfC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Sep 2012 20:35:02 -0400
Received: by lbbgj3 with SMTP id gj3so2774549lbb.19
        for <linux-pci@vger.kernel.org>; Mon, 03 Sep 2012 17:35:01 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 4 Sep 2012 08:35:00 +0800
Message-ID: <CAE7L+6DJZMk7arka0bszNeiafMTcjPA3byT0gN0cDtK-rWz2AA@mail.gmail.com>
Subject: Will direct Hot Reset impact system?
From: MENG Xin <zinces@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, all,


My card is a Gen2 x8 device, plugged on DELL R710 (Intel 5520 IOH
platform with Xeon X5560). There is a PLX 8624 Switch populated on
card, 4 identical Endpoint devices are connected with the Switch,
hierarchy is shown as below. OS is Suse10 (sp3), kernel version
2.6.16.60-0.54.5-smp.

-[0000:00]-+-00.0
           +-07.0-[0000:06-0c]----00.0-[0000:07-0c]--+-04.0-[0000:08]--
           |                                         +-05.0-[0000:09]----00.0
           |                                         +-06.0-[0000:0a]----00.0
           |                                         +-08.0-[0000:0b]----00.0
           |                                         \-09.0-[0000:0c]----00.0


I’m investigating a software recover mechanism based on Hot Reset.
When fatal error is detected and reported from the card, I use Hot
Reset to recover the card. To test the recover flow, I also use Hot
Reset to break normal operation. Here is the sequence:
1. Turn off AER reporting in Root Complex by clearing “Root Error
Command Register (0x2C)
2. Mask all Non-correctable Error in Root Port’s AER.
3. Turn off conventional PCI error reporting by clearing “SERR#
Enable” in both “Command Register (0x04)” and “Bridge Control Register
(0x3E)”.
4. Issue Hot Reset by writing “Secondary Bus Reset” bit in Root Port’s
“Bridge Control Register”
5. Card driver detects transaction problem
6. Driver clears “Bus Master Enable” and polling “Transaction Pending
bit” in both Root Port and Switch’s upstream port to wait existing
transaction done.
7. Driver issues Hot Reset by writing “Secondary Bus Reset” bit in Root Port.
8. Driver performs post initialization after link up.

Such iteration can go several rounds and link down will occur between
Root Port and Switch’s Upstream port. I tried to modify the flow,
before step 4, I added code to clear “Bus Master Enable” and
“Transaction Pending bit” polling. But link down still occurs. I see
there is “graceful” Hot Reset flow supported in kernel by calling some
system functions. But it could be a big effort for the card driver to
cooperate with that framework. So I took the shortcut. My question is:
will such direct Hot Reset impact overall system functionality? Or is
there any chance for IOH to disable link training after exiting from
Hot Reset? Can IOH detects such Hot Reset even if I masked all
Non-correctable Error in Root’s AER?

Thank you very much!


Best regards,
Xin Meng
