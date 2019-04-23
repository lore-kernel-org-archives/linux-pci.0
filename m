Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	TVD_PH_BODY_ACCOUNTS_PRE autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADCFC10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 17:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A61217D9
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 17:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2lEgKVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfDWRxL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:53:11 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:37720 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWRxK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 13:53:10 -0400
Received: by mail-oi1-f182.google.com with SMTP id v84so12030251oif.4;
        Tue, 23 Apr 2019 10:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yfw1+MkKUQmoUtIdgPFcAMil9KhywATrKANiYe2fnz0=;
        b=M2lEgKVJYrZOOeamM4QDu4lxHoDLo1vBj4J+ZKL0uJRrcOuv3rhR9uSMdqksm+6gQq
         1sagvbRTTFroX2Q5T5o4OpfWumgQ/Vsy2tc/s3w12lNFV04BxsQcrfJCnKgFT6JeoSF2
         mOU3jy2BIPnJmEvwKM1yILE23cjF8XgnUVaZ2ii2plT3Nd9ecXLp6dbSTmj0iRPY45Da
         IqeO6Rr0SMxrcQIFNzz9669VGYZLb8erzydya4OV8lqwFYN1Scr8tSBDBB+e1QQaSZDP
         mVI+E7fZDQSlN25oal3NLVgwLHN49pHwesYnhcaR5dtYQA1fuM5OP7obWi1/BEnTCIqv
         iqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yfw1+MkKUQmoUtIdgPFcAMil9KhywATrKANiYe2fnz0=;
        b=a52AVpfLAdfXM1b2AN88DDdd4OdaX+7dQ9bX8I/HCnisxiHSQDDWzskdTqnKe6gLc/
         TWTBOEmhXTfzDuEqJ22IkB54WvQHF1awdw/VAdI2D2fo8kQzpqaGtYh1kOCuYFzDIo0A
         PIowThUiURjm+z0ZPZNOvxcEVGXc59z+FYjqZHCq5++bXHoMlpCNhUjZ2ufmP2uo0b8U
         Qc6xCKA1cHQSYaAFPwdTy0PnKFI50MLKdVuNArMiaeP4IJ3+n9P+6T9IPeT6h4gQHfj4
         5TrgFYz0DvtjdVuPUYXElWcnIy023CS0P1ZD6zM2C4iVjWCv3uEjl0H+eS6802wuyrp/
         28ng==
X-Gm-Message-State: APjAAAX41UaCU9r33zzfoqh/madvHA+Fi9NLzkQkutNtwQyVz0Vyfv+4
        +lJGf20sXCtjrtX4dkQRaOZQvN5og+Y=
X-Google-Smtp-Source: APXvYqzuUYu42SO0ENNhdufxFis5cqLoF9Oap5Du7PQzewNoYlQ37GJIpsut3mRMlkMBlifWyGXJJg==
X-Received: by 2002:aca:80d:: with SMTP id 13mr2632037oii.75.1556041989191;
        Tue, 23 Apr 2019 10:53:09 -0700 (PDT)
Received: from nukespec.gtech ([2601:2c1:8501:182d::6fe])
        by smtp.gmail.com with ESMTPSA id k25sm7422188otj.72.2019.04.23.10.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 10:53:08 -0700 (PDT)
Subject: Re: [PATCH] PCI/LINK: Account for BW notification in vector
 calculation
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, austin_bolen@dell.com,
        alex_gagniuc@dellteam.com, keith.busch@intel.com,
        Shyam_Iyer@Dell.com, lukas@wunner.de, okaya@kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
References: <155597243666.19387.1205950870601742062.stgit@gimli.home>
 <d1126250-14e0-192c-f219-f143f62c9cdd@gmail.com>
 <20190422183347.51ba522c@x1.home>
 <84300da7-9bbd-4f32-c7fa-23724db60b88@gmail.com>
 <20190423171050.GA37199@google.com>
From:   Alex G <mr.nuke.me@gmail.com>
Message-ID: <9802ef46-40d2-b83c-a0c6-8bd6ac25feaa@gmail.com>
Date:   Tue, 23 Apr 2019 12:53:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423171050.GA37199@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/23/19 12:10 PM, Bjorn Helgaas wrote:
> On Tue, Apr 23, 2019 at 09:33:53AM -0500, Alex G wrote:
>> On 4/22/19 7:33 PM, Alex Williamson wrote:
>>> There is nothing wrong happening here that needs to fill logs.  I
>>> thought maybe if I enabled notification of autonomous bandwidth
>>> changes that it might categorize these as something we could
>>> ignore, but it doesn't.  How can we identify only cases where this
>>> is an erroneous/noteworthy situation?  Thanks,
>>
>> You don't. Ethernet doesn't. USB doesn't. This logging behavior is
>> consistent with every other subsystem that deals with multi-speed links.
> 
> Can you point me to the logging in these other subsystems so I can
> learn more about how they deal with this?

I don't have any in-depth articles about the logging in these systems, 
but I can extract some logs from my machines.

Ethernet:

[Sun Apr 21 11:14:06 2019] e1000e: eno1 NIC Link is Down
[Sun Apr 21 11:14:17 2019] e1000e: eno1 NIC Link is Up 1000 Mbps Full 
Duplex, Flow Control: Rx/Tx
[Sun Apr 21 11:14:23 2019] e1000e: eno1 NIC Link is Up 1000 Mbps Full 
Duplex, Flow Control: Rx/Tx
[Sun Apr 21 23:33:31 2019] e1000e: eno1 NIC Link is Down
[Sun Apr 21 23:33:43 2019] e1000e: eno1 NIC Link is Up 1000 Mbps Full 
Duplex, Flow Control: Rx/Tx
[Sun Apr 21 23:33:48 2019] e1000e: eno1 NIC Link is Up 1000 Mbps Full 
Duplex, Flow Control: Rx/Tx

I used to have one of these "green" ethernet switches that went down to 
100mbps automatically. You can imagine how "clogged" the logs were with 
link up messages. Thank goodness that switch was killed in a thunderstorm.

USB will log every device insertion and removal, very verbosely (see 
appendix A).


> I agree that emitting log messages for normal and expected events will
> lead to user confusion and we need to do something.
> 
> e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth
> notification") was merged in v5.1-rc1, so we still have (a little)
> time to figure this out before v5.1.

I always viewed the system log as a system log, instead of a database of 
system errors. I may have extremist views, but going back to Alex's 
example, I prefer to see that the power saving mechanism is doing 
something to save power on my laptop (I'll just ignore it on a desktop).

If you think increasing code complexity because people don't want things 
logged into the system log, then I'm certain we can work out some sane 
solution. It's the same problem we see with GCC, where people want 
warning messages here, but don't want the same messages there.

Alex


P.S. The pedantic in me points out that one of the examples I gave is a 
terrible example. ASPM "allows hardware-autonomous, dynamic Link power 
reduction beyond what is achievable by software-only control" [1].

[1] PCI-Express 3.0 -- 5.4.1. Active State Power Management (ASPM)


Appendix A:

[1618067.987084] usb 1-3.5: new high-speed USB device number 79 using 
xhci_hcd
[1618068.179914] usb 1-3.5: New USB device found, idVendor=0bda, 
idProduct=4014, bcdDevice= 0.05
[1618068.179924] usb 1-3.5: New USB device strings: Mfr=3, Product=1, 
SerialNumber=2
[1618068.179930] usb 1-3.5: Product: USB Audio
[1618068.179936] usb 1-3.5: Manufacturer: Generic
[1618068.179941] usb 1-3.5: SerialNumber: 200901010001
[1618068.280100] usb 1-3.6: new low-speed USB device number 80 using 
xhci_hcd
[1618068.342541] Bluetooth: hci0: Waiting for firmware download to complete
[1618068.342795] Bluetooth: hci0: Firmware loaded in 1509081 usecs
[1618068.342887] Bluetooth: hci0: Waiting for device to boot
[1618068.354919] Bluetooth: hci0: Device booted in 11797 usecs
[1618068.356006] Bluetooth: hci0: Found Intel DDC parameters: 
intel/ibt-12-16.ddc
[1618068.358958] Bluetooth: hci0: Applying Intel DDC parameters completed
[1618068.378624] usb 1-3.6: New USB device found, idVendor=04d9, 
idProduct=1400, bcdDevice= 1.43
[1618068.378626] usb 1-3.6: New USB device strings: Mfr=0, Product=0, 
SerialNumber=0
[1618068.390686] input: HID 04d9:1400 as 
/devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.6/1-3.6:1.0/0003:04D9:1400.0139/input/input921
[1618068.444282] hid-generic 0003:04D9:1400.0139: input,hidraw1: USB HID 
v1.10 Keyboard [HID 04d9:1400] on usb-0000:00:14.0-3.6/input0
[1618068.456373] input: HID 04d9:1400 Mouse as 
/devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.6/1-3.6:1.1/0003:04D9:1400.013A/input/input922
[1618068.457929] input: HID 04d9:1400 Consumer Control as 
/devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.6/1-3.6:1.1/0003:04D9:1400.013A/input/input923
[1618068.509294] input: HID 04d9:1400 System Control as 
/devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.6/1-3.6:1.1/0003:04D9:1400.013A/input/input924
[1618068.509518] hid-generic 0003:04D9:1400.013A: input,hidraw2: USB HID 
v1.10 Mouse [HID 04d9:1400] on usb-0000:00:14.0-3.6/input1
[1618068.588078] usb 1-3.7: new full-speed USB device number 81 using 
xhci_hcd
[1618068.679132] usb 1-3.7: New USB device found, idVendor=046d, 
idProduct=c52b, bcdDevice=12.03
[1618068.679137] usb 1-3.7: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[1618068.679139] usb 1-3.7: Product: USB Receiver
[1618068.679142] usb 1-3.7: Manufacturer: Logitech
[1618068.692430] logitech-djreceiver 0003:046D:C52B.013D: 
hiddev96,hidraw3: USB HID v1.11 Device [Logitech USB Receiver] on 
usb-0000:00:14.0-3.7/input2
[1618068.817334] input: Logitech Performance MX as 
/devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.7/1-3.7:1.2/0003:046D:C52B.013D/0003:046D:101A.013E/input/input925
[1618068.820357] logitech-hidpp-device 0003:046D:101A.013E: 
input,hidraw4: USB HID v1.11 Mouse [Logitech Performance MX] on 
usb-0000:00:14.0-3.7:1


