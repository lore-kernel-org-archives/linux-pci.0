Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:45558 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbaEYKmg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 25 May 2014 06:42:36 -0400
Received: by mail-we0-f177.google.com with SMTP id x48so6792407wes.36
        for <linux-pci@vger.kernel.org>; Sun, 25 May 2014 03:42:35 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 25 May 2014 16:12:35 +0530
Message-ID: <CALWEwrp0DejpH=rVgeaCaC4Bi=7HLKY3RKEq7mXg0jOVtBHdng@mail.gmail.com>
Subject: Regarding ARI capability
From: kumar git <kumar.git@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

My device connect like below
\-[0000:00]-+-00.0
              .
             +-03.2-[04]--+-00.0
             |            +-00.1
             |            +-00.2
             |            +-00.3
             |            +-00.4
             |            +-00.5
             |            +-00.6
             |            \-00.7

Host bridge (00:00.0 Host bridge: Intel Corporation Haswell-E DMI2 (rev 01))
ARIFwd-  is not enabled. Seems like AMI BIOS is disabled ARI on host bridge.
                DevCap2: Completion Timeout: Range BCD, TimeoutDis+,
LTR-, OBFF Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
But ARIFwd+ is enabled on root port where my device is connected.
00:03.2 PCI bridge: Intel Corporation Haswell-E PCI Express Root Port 3
                DevCap2: Completion Timeout: Range BCD, TimeoutDis+,
LTR-, OBFF Not Supported ARIFwd+
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled ARIFwd+

>From lspci out I am able to see next-function – 8 from ARI capability
structure of 7th function (since device firmware is exposing all 0 –
15 functions).

Below are my query's
1) Is it mandatory to enable ARIFwd on Host Bridge?

   If yes, please let me know how can i enable through OS or host bridge driver.

2) SR-IOV capability structure has the ARIHierarchy field. What is the
main use of this field?

   Is there any relation between ARI and SR-IOV?


Many Thanks.

Best Regards,
ravikumar.
