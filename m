Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E939EC43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 21:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A952F218A5
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 21:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhKxDWPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbfC2Vhf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:37:35 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36829 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbfC2Vhe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Mar 2019 17:37:34 -0400
Received: by mail-oi1-f195.google.com with SMTP id l203so2186288oia.3;
        Fri, 29 Mar 2019 14:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=xUrxUBRZpSI/fNVDCiVjC4ND6is1O8GVWjXtdzQrejM=;
        b=fhKxDWPYGPz9wuhgqrq9WvM7n6s1DJ1U9yJXBfomzGMI4U+eq3kmWM+xT1KL/NSXVg
         1EI+NHwMkQTSrZMC3ONYiTOs+CWGqN3SAT1E3Y6y4AtGCqUbw4t1yEs2HWK4OYuLHX22
         YRlS810Bc+to88mjdAug+CP8Qknlszdstu3Baqgs0Ci+9L9jGoelcoz1xeExNxR7Hc6I
         lbm7h5PxsYHUezNke9zTj/GfyXY0MrbMDLi0v8nc6dLkB7KP4UKsW5t1ss4Wavu++rr5
         XP3ihK4EyZOV+dCoB6ga6kVF5RQuSxw523OBZ8N60mTTao3HxJfkf/J0CY6HkzyR7cGm
         YJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=xUrxUBRZpSI/fNVDCiVjC4ND6is1O8GVWjXtdzQrejM=;
        b=an0xVIJVXfIkKyW/LpOHneeE5jDZYTinuUgjRn9rZXZVIivpGPk/0MasO35VpukLso
         7VW/D7pezW3PYVq4fQgq+AnDg8Dz8FytJy5B7yOc+/bnBI7mdbRNbJ9d3vmJ3nB24C0/
         ztijZ8jLkSmXhuP9K2lSuJLwxWWzFPoFbQA8/DBNIAN2xtdx6wBhqDvY29JJ/S2ks1It
         vxCOHrRQ3ecOCvfKO5OEq7Zc2JPnncrtKXH1tRA4LKd/U2ybDpyTViP35dNqMVP7Y1ZK
         R5Q14UEEELuViTi3KgRCpIoGK7SOIjhBK1HSyb3PC4iCrqDT7wBGYbF2xWHlANDRV1cD
         Nekg==
X-Gm-Message-State: APjAAAVAYt55USEneKOHHe7sYuNcdtHJ2GbVq7heu2Uo05F2eZJD4Vgy
        RBxxyw2qp77AZ0xP+GtLZSU=
X-Google-Smtp-Source: APXvYqxmwyn8f1qjKoiDSq0lRyE+k2YrfWG4D/pG6hWqeGKE5X87G1YNEcp5JwrdKmCHt8+BqWK+bg==
X-Received: by 2002:aca:72c6:: with SMTP id p189mr2921384oic.107.1553895453359;
        Fri, 29 Mar 2019 14:37:33 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id l63sm1241167oia.47.2019.03.29.14.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 14:37:32 -0700 (PDT)
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>, bp@alien8.de,
        "Bolen, Austin" <austin_bolen@dell.com>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Robert Moore <robert.moore@intel.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Subject: Fixing the GHES driver vs not causing issues in the first place
Message-ID: <9acf86ac-a065-e093-347c-e35ac4069e08@gmail.com>
Date:   Fri, 29 Mar 2019 16:37:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The issue of dying inside the GHES driver has popped up a few times before.
I've looked into fixing this before, but we didn't quite come to agreement
because the verbiage in the ACPI spec is vague:
     " When a fatal uncorrected error occurs, the system is
       restarted to prevent propagation of the error. "

This popped up again a couple of times recently [1]. Linus suggested that
fixing the GHES driver might pay higher dividends. I considered reviving 
an old
fix, but put it aside after hearing concerns about the unintended 
consequences,
which I'll get to soon.

A few days back, I lost an entire MD RAID1. It was during hot-removal 
testing
that I do on an irregular basis, and a kernel panic from the GHES driver had
caused the system to go down. I have seen some occasional filesystem 
corruption
in other crashes, but nothing fsck couldn't fix. The interesting part is 
that
the array that was lost was not part of the device set that was being
hot-removed. The state of things doesn't seem very joyful.

The machine in question is a Dell r740xd. It uses firmware-first (FFS)
handling for PCIe errors, and is generally good at identifying a hot-removal
and not bothering the OS about it. The events that I am testing for are
situations where, due to slow operator, tilted drive, worn connectors, 
errors
make it past FFS to the OS -- with "fatal" severity.
     In that case, the GHES driver sees a fatal hardware error and panics.
On this machine, FFS reported it as fatal in an attempt to cause the 
system to
reboot, and prevent propagation of the error.

     The "prevent propagation of the error" flow was designed around OSes
that can't do recovery. Firmware assumes an instantaneous reboot, so it does
not set itself up to report future errors. The EFI reference code does not
re-arm errors, so we suspect most OEM's firmware will work this way. Despite
the apparently enormous stupidity of crashing an otherwise perfectly good
system, there are good and well thought out reasons behind it.
     An example is reading a block of data from an NVMe drive, and
encountering a CRC error on the PCIe bus. If we didn't  do an "instantaneous
reboot" after a previous fatal error, we will not get the CRC error 
reported.
Thus, we risk silent data corruption.

     On the Linux side, we can ignore the "fatal" nature of the error, and
even recover the PCIe devices behind the error. However, this is ill 
advised for
the reason listed above.

     The counter argument is that a panic() is more likely to cause
filesystem corruption. In over one year of testing, I have not seen a single
incident of data corruption, yet I have seen the boot ask me to run fsck on
multiple occasions. And this seems to me like a tradeoff problem rather than
anything else.

     In the case of this Dell machine, there are ways to hot-swap PCIe
devices them without needing to take either of the risks above:
     1. Turn off the downstream port manually.
     2. Insert/replace drive
     3. Turn on the downstream port manually.

     What bothers me is the firmware's assumption that a fatal error must
crash the machine. I've looked at the the verbiage in the spec, and I don't
fully agree that either side respects the contract.
Our _OSC contract with the firmware says that firmware will report 
errors to us,
while we are not allowed to touch certain parts of the device. Following the
verbiage in the spec, we do need to reboot on a fatal error, but that 
reboot is
not guaranteed to be instantaneous. Firmware still has to honor the contract
and report errors to us. This may seem like a spec non-compliance issue.

     It would be great if FFS would mark the errors as recoverable, but the
level of validation required makes this unrealistic on existing 
machines. New
machines will likely move to the Containment Error Recovery model, which is
essentially FFS for DPC (PCIe Downstream Port Containment). This leaves the
current generation of servers in limbo -- I'm led to believe other 
server OEMs
have very similar issues.

     Given the dilemma above, I'm really not sure what the right 
solution is.
How do we produce a fix that addresses complaints from both sides. When 
firmware
gives us a false positive, should we panic? Should we instead print a 
message
informing the user/admin that a reboot of the machine is required. Should we
initiate a reboot automatically?

     From Linux' ability to recover, PCIe fatal errors are false positives
-- every time, all the time. However, their fatality is not there 
without any
reason. I do want to avoid opinions that FFS wants us to crash, gives us the
finger, and we should give the finger back.

     Another option that was discussed before, but was very controversial is
the fix that involves not causing the problem in the first place [1] 
[2]. On the
machines that I have access to, FFS is handled in SMM, which means that 
all CPU
cores are held up until the processing of the error is complete. On one
particular machine (dual 40-core CPU) SMM will talk to the BMC over I/O 
ports,
which takes roughly 300 milliseconds. We're losing roughly 24 
core-seconds to
a check that might have taken us a couple of clock cycles.

I'm hoping that I was able to give out a good overview of the problems 
we are
facing on FFS systems, and I hope that we can find some formula to deal with
them in a way that is both pleasant and robust. Oh, FFS!

Alex

P.S. If there's interest, I can look for system logs that show the 300+ 
ms gap
caused by the SMM handler.


[1] 
https://lore.kernel.org/lkml/20190222010502.2434-1-jonathan.derrick@intel.com/T/#u
[2] 
https://lore.kernel.org/lkml/20190222194808.15962-1-mr.nuke.me@gmail.com/

