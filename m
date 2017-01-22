Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52198 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750889AbdAVBfc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 21 Jan 2017 20:35:32 -0500
Received: from [10.228.68.38] (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 67B6D60227
        for <linux-pci@vger.kernel.org>; Sun, 22 Jan 2017 01:35:31 +0000 (UTC)
To: Linux PCI <linux-pci@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
Subject: ASPM after Hotplug Question
Message-ID: <7fea039c-5921-0c12-c7b4-991b4c27778f@codeaurora.org>
Date: Sat, 21 Jan 2017 20:35:30 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When I boot the system, I see the ASPM is working fine. After hotplug removal
and insertion, I see that the ASPM is disabled.

I do not have any ASPM related kernel command line parameter and
the policy is default.

ASPM gets configured by the firmware before the OS boots by default
unless powersave policy is passed to the kernel command line. 

Is there a particular reason why we are not re-configuring ASPM after
hotplug insertion?

I think default policy applies to power-up values but not for
the hotplug case.

With similar reasoning, maximum payload size gets configured by
the firmware before boot. I see that the OS is re-configuring the
MPS settings following hotplug. 

I feel like ASPM should have followed a similar policy.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
