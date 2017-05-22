Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43492 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758295AbdEVRue (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 May 2017 13:50:34 -0400
Received: from [10.228.68.174] (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C6C3B60D5D
        for <linux-pci@vger.kernel.org>; Mon, 22 May 2017 17:50:32 +0000 (UTC)
To: Linux PCI <linux-pci@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
Subject: IO Space Allocation Question on ARM64
Message-ID: <31f48cf6-fd97-98fe-ac7c-ad80870df68b@codeaurora.org>
Date: Mon, 22 May 2017 13:50:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We are seeing IO space allocation failure on QDF2400 with multiple switch hierarchy
below. This card has 20 PCI bridges with endpoints attached to each one to increase
the number of endpoints supported.

QDF2400 supports a maximum of 64k IO space aka 16 bit IO on the root port.

-+-[0003:00]---00.0-[01-16]----00.0-[02-16]--+-00.0-[03]----00.0
 |                                           +-01.0-[04]----00.0
 |                                           +-02.0-[05]----00.0
 |                                           +-03.0-[06]----00.0
 |                                           +-04.0-[07]----00.0
 |                                           +-05.0-[08]----00.0
 |                                           +-06.0-[09]----00.0
 |                                           +-07.0-[0a]----00.0
 |                                           +-08.0-[0b]--
 |                                           +-09.0-[0c]--
 |                                           +-0a.0-[0d]--
 |                                           +-0b.0-[0e]--
 |                                           +-0c.0-[0f]--
 |                                           +-0d.0-[10]--
 |                                           +-0e.0-[11]--
 |                                           +-0f.0-[12]--
 |                                           +-10.0-[13]--
 |                                           +-11.0-[14]--
 |                                           +-12.0-[15]--
 |                                           \-13.0-[16]--

What we so far is that Linux is assigning an IO resource for every single bridge
that it finds even though there is nothing connected behind on some of the bridges.
Do we know the reason for this behavior?

[    4.288269] pci 0003:00:00.0: BAR 13: failed to assign [io  size 0x15000]
[    4.317175] pci 0003:01:00.0: BAR 13: failed to assign [io  size 0x14000]
[    4.644518] pci 0003:02:00.0: BAR 13: failed to assign [io  size 0x1000]
[    4.657539] pci 0003:02:01.0: BAR 13: failed to assign [io  size 0x1000]
[    4.670560] pci 0003:02:02.0: BAR 13: failed to assign [io  size 0x1000]
[    4.683581] pci 0003:02:03.0: BAR 13: failed to assign [io  size 0x1000]
[    4.696602] pci 0003:02:04.0: BAR 13: failed to assign [io  size 0x1000]
[    4.709623] pci 0003:02:05.0: BAR 13: failed to assign [io  size 0x1000]
[    4.722644] pci 0003:02:06.0: BAR 13: failed to assign [io  size 0x1000]
[    4.735664] pci 0003:02:07.0: BAR 13: failed to assign [io  size 0x1000]
[    4.748685] pci 0003:02:08.0: BAR 13: failed to assign [io  size 0x1000]
[    4.761706] pci 0003:02:09.0: BAR 13: failed to assign [io  size 0x1000]
[    4.774727] pci 0003:02:0a.0: BAR 13: failed to assign [io  size 0x1000]
[    4.787748] pci 0003:02:0b.0: BAR 13: failed to assign [io  size 0x1000]
[    4.800768] pci 0003:02:0c.0: BAR 13: failed to assign [io  size 0x1000]
[    4.813789] pci 0003:02:0d.0: BAR 13: failed to assign [io  size 0x1000]
[    4.826810] pci 0003:02:0e.0: BAR 13: failed to assign [io  size 0x1000]
[    4.839831] pci 0003:02:0f.0: BAR 13: failed to assign [io  size 0x1000]
[    4.852852] pci 0003:02:10.0: BAR 13: failed to assign [io  size 0x1000]
[    4.865873] pci 0003:02:11.0: BAR 13: failed to assign [io  size 0x1000]
[    4.878893] pci 0003:02:12.0: BAR 13: failed to assign [io  size 0x1000]
[    4.891914] pci 0003:02:13.0: BAR 13: failed to assign [io  size 0x1000]

UEFI seems to be assigning an IO resource to bridge only if finds an endpoint
behind it with an actual IO BAR space.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
