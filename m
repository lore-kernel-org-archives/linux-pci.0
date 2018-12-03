Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0E1C04EB9
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 23:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CEA22087F
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 23:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjjdX3bS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CEA22087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbeLCXgb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:36:31 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:36917 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbeLCXg2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Dec 2018 18:36:28 -0500
Received: by mail-io1-f47.google.com with SMTP id f14so6607077iol.4;
        Mon, 03 Dec 2018 15:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=rJWB4aDRvDfTUs1WLaDWGJvOfUa95hWFd3tz9QddCSE=;
        b=BjjdX3bSSfN19muRejN2Gp0vLhIuMpR2xZ51S+jcHeC/gC9duDwWjXhBnGpeNC8KrD
         gvv7836Cn8+sFLrE7PCm+r09ER3OdSCSLtEglabTvIq93IS917jIax9aaKYt2etbqVKx
         0nu5a9emmP7X561+QvucxBy8aBO6DFR1fFC3sADAJARbszlttWcCGwN960XiXB2K96VK
         ySCg9g4O+SwukAc/PHv3i0mXO1HZEHYJl+i/ZQbc8resH+px0Il/Uqy9MBuauo8g9bc/
         JeaCwWI76NffkRtBtaYRZjACxxTQTau13sqbQw6iqSqec1hC7xr1s7KAzSOScnLP6YMa
         +KTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=rJWB4aDRvDfTUs1WLaDWGJvOfUa95hWFd3tz9QddCSE=;
        b=SxCkoJK3MsEyyCXNjEzeVrvhWRDZ+sXlFhsLFxIcD2vyQL51nOB2taHsezZMu3zB+s
         r4UiP8fX++5yalfNiCJSl5LOhttj55abxxUf+GQ3d+hNCJCdaDv1RK10CkgL+sbcWlVd
         Hl/pLGA7v9S4IgvPN/ZVTxx3JNGXskC9twtHe01og9IS5rzxwrhwas2I7zF72az6fqWY
         31Z9QILsZGc38HBB/dVshEXA6E952EhMv3KgztShnR1IF+x+670H3tp2NvhO/Kt8kpmL
         gsyHoQktPDYwRjrn375oHuIuYktsVc0LnkXDP3kdYT+cNr0484osoHCA7/sfCDGoWYDT
         Povw==
X-Gm-Message-State: AA+aEWbPR6CjRLHb+8elifkAt1AaHERt1KTAqtFd2JWHphLqOxo3WHq4
        iM0Vhp2NVezKDfzvZ7hInhmuJppws1WpruLEkQCrfgzX
X-Google-Smtp-Source: AFSGD/U9WPEuzHMQkkMeOTQg9DoQ+NnyftqvedZiw44ZkBeQM6nWY7WMKLsutZxGh3H24dCKtOfeCnx9PtwD315fjYo=
X-Received: by 2002:a5d:8197:: with SMTP id u23mr3292615ion.113.1543880187460;
 Mon, 03 Dec 2018 15:36:27 -0800 (PST)
MIME-Version: 1.0
References: <bug-201517-193951@https.bugzilla.kernel.org/>
In-Reply-To: <bug-201517-193951@https.bugzilla.kernel.org/>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Mon, 3 Dec 2018 17:36:15 -0600
Message-ID: <CABhMZUVhM3PU5BUu=k-KfR5injzFM4VoABKtN8HxXW2HiPStQQ@mail.gmail.com>
Subject: Fwd: [Bug 201517] New: pcieport 0000:00:03.1: AER: Corrected error
 received: 0000:00:00.0
To:     Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>
Cc:     linux-pci@vger.kernel.org, mikhail.v.gavrilov@gmail.com,
        emteeelp@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Forwarding this to linux-pci since nobody really monitors the bugzilla]

Possibly the same issue reported here:

  https://bugzilla.kernel.org/show_bug.cgi?id=109691
  https://bugzilla.kernel.org/show_bug.cgi?id=111601
  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1588428/
  https://lore.kernel.org/linux-pci/20160215171423.GA12641@localhost/

I had a theory about the problem (see the lore.kernel link above), but
that was before a lot of AER rework, and I haven't checked the code
since then.

---------- Forwarded message ---------
From: <bugzilla-daemon@bugzilla.kernel.org>
Date: Thu, Oct 25, 2018 at 12:45 AM
Subject: [Bug 201517] New: pcieport 0000:00:03.1: AER: Corrected error
received: 0000:00:00.0
To: <bugzilla.pci@gmail.com>


https://bugzilla.kernel.org/show_bug.cgi?id=201517

            Bug ID: 201517
           Summary: pcieport 0000:00:03.1: AER: Corrected error received:
                    0000:00:00.0
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.19
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: mikhail.v.gavrilov@gmail.com
        Regression: No

Created attachment 279149
  --> https://bugzilla.kernel.org/attachment.cgi?id=279149&action=edit
dmesg

I often get a strange error in the kernel log:

[ 8885.590311] pcieport 0000:00:03.1: AER: Corrected error received:
0000:00:00.0
[ 8885.590320] pcieport 0000:00:03.1: PCIe Bus Error: severity=Corrected,
type=Data Link Layer, (Transmitter ID)
[ 8885.590324] pcieport 0000:00:03.1:   device [1022:1453] error
status/mask=00001000/00006000
[ 8885.590328] pcieport 0000:00:03.1:    [12] Timeout

But not always, it means that if this message starts to appear after a reboot,
then it will appear again and again, and if it does not appear, it does not
appear at all.

# lspci -nn
00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Root Complex [1022:1450]
00:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models
00h-0fh) I/O Memory Management Unit [1022:1451]
00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
00:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) PCIe GPP Bridge [1022:1453]
00:01.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) PCIe GPP Bridge [1022:1453]
00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
00:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) PCIe GPP Bridge [1022:1453]
00:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
00:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
00:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B [1022:1454]
00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B [1022:1454]
00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller
[1022:790b] (rev 59)
00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge
[1022:790e] (rev 51)
00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Data Fabric: Device 18h; Function 0 [1022:1460]
00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Data Fabric: Device 18h; Function 1 [1022:1461]
00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Data Fabric: Device 18h; Function 2 [1022:1462]
00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Data Fabric: Device 18h; Function 3 [1022:1463]
00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Data Fabric: Device 18h; Function 4 [1022:1464]
00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Data Fabric: Device 18h; Function 5 [1022:1465]
00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Data Fabric: Device 18h; Function 6 [1022:1466]
00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Data Fabric: Device 18h; Function 7 [1022:1467]
01:00.0 Non-Volatile memory controller [0108]: Intel Corporation Optane SSD
900P Series [8086:2700]
02:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device
[1022:43d0] (rev 01)
02:00.1 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] Device
[1022:43c8] (rev 01)

# uname -r
4.19.0-0.rc8.git4.1.fc30.x86_64

--
You are receiving this mail because:
You are watching the assignee of the bug.
