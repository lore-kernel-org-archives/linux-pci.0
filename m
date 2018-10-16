Return-Path: <SRS0=JYfi=M4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A92C04EBD
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 14:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DE320881
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 14:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PIqsLb+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DE320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeJPW3D (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:29:03 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51064 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeJPW3B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Oct 2018 18:29:01 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181016143815euoutp01e676ecbc8c00336cca6e65b9b3a9ad1e~eHaAIkaLq2766127661euoutp01P
        for <linux-pci@vger.kernel.org>; Tue, 16 Oct 2018 14:38:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181016143815euoutp01e676ecbc8c00336cca6e65b9b3a9ad1e~eHaAIkaLq2766127661euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539700695;
        bh=2ViFVH4amCKDmOOJW9zJ6/iiILC/aBPrUAOPsop9aFk=;
        h=To:Cc:From:Subject:Date:References:From;
        b=PIqsLb+E/l+uZCfHpzCTIhbGtXz+ifk3QS/E9Fiq+5aN4sTaAhayKF6rQMHszgesY
         e/BQPa8RQsPKwiiCk9IRp+6iLctM/389S/dPRpTaJ8Q5gir2xM6gZOM2mGMharDXiM
         Ql1Aq0oyo4/5o1y8fwZOlTXeiKjd6R+gMk5v0Xbc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181016143815eucas1p22540847777ccde5effbf56bbdfff7ad3~eHZ-qEmcO2851928519eucas1p2K;
        Tue, 16 Oct 2018 14:38:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3A.BE.04806.6D7F5CB5; Tue, 16
        Oct 2018 15:38:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181016143814eucas1p21b1f3099131fc3f4263947932195299e~eHZ_4THEH2088320883eucas1p2s;
        Tue, 16 Oct 2018 14:38:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181016143814eusmtrp20f2e4fccc57f96e45f859662bd674819~eHZ_qLZNV2636126361eusmtrp2d;
        Tue, 16 Oct 2018 14:38:14 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-f2-5bc5f7d6880a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E3.87.04284.6D7F5CB5; Tue, 16
        Oct 2018 15:38:14 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181016143813eusmtip23d3451797de6ad066b805e40ca5a0e30~eHZ_c6CXs2376723767eusmtip2M;
        Tue, 16 Oct 2018 14:38:13 +0000 (GMT)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] PCI: pcie: remove redundant 'default n' from Kconfig
Date:   Tue, 16 Oct 2018 16:38:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsWy7djPc7rXvh+NNrh+1sJiSVOGxeVdc9gs
        zs47zubA7LFgU6nH501yAUxRXDYpqTmZZalF+nYJXBkH1kcVHBas2HL7DksD42beLkZODgkB
        E4k5t36zdjFycQgJrGCUOPNiApTzhVFi6pZnTBDOZ0aJbVM2sMO0LD+8lw0isZxR4vSZZ4wQ
        zntGiSVbFrCCVIkIqEssPPqeCcRmFrCWeNTWDGazCVhJTGxfxQhiCwu4Sly49IQNxGYRUJVo
        bd4K1MvBISoQIdF/Rh0kzCsgKHFy5hMWiDHyEtvfzmEG2SUhcJlN4vTz8+wQRWUS7Ue2skJc
        5yLxq+E5lC0s8er4FqirZST+75zPBNE8nVHiza+lLBDOekaJNWeOMUFUWUscPn4R7ApmAU2J
        9bv0IcKOEsd+bmUDCUsI8EnceCsIcRCfxKRt05khwrwSHW1CENVqEhuWbWCDWdu1cyUzhO0h
        cfP5LbC4kECsxIP9L5gmMCrMQvLmLCRvzkK4YQEj8ypG8dTS4tz01GLjvNRyveLE3OLSvHS9
        5PzcTYzABHH63/GvOxj3/Uk6xCjAwajEw/vj+pFoIdbEsuLK3EOMEhzMSiK86ZeORgvxpiRW
        VqUW5ccXleakFh9ilOZgURLnXTZvY7SQQHpiSWp2ampBahFMlomDU6qBceV01j+Lbk6VskzW
        FXVMnB4p0hX+2vX7e3NfpeTTFxWf5C28l+62bsq6mr4+BeGkC4/lFj0Mv3PkYrWOqMKkqbPb
        FkSu7BHew/Dp5az0iCeLex9ODYmsbRT4v4MziuPCDR2fiOs9XCuc8y7qt+VER6g2zdaZIfAm
        P2HW3V1S0RyesQ2aohPtlViKMxINtZiLihMB8/2eRwwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsVy+t/xe7rXvh+NNuj6wmGxpCnD4vKuOWwW
        Z+cdZ3Ng9liwqdTj8ya5AKYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYwD66MKDgtWbLl9h6WBcTNvFyMnh4SAicTyw3vZuhi5OIQEljJKdEzZ
        xdrFyAGUkJE4vr4MokZY4s+1Lqiat4wSEx9uYQRJiAioSyw8+p4JxGYWsJZ41NYMZrMJWElM
        bF8FViMs4Cpx4dITNhCbV8BO4t7cz2BxFgFVidbmrawgtqhAhMSthx0sEDWCEidnPmGBmKku
        8WfeJWYIW15i+9s5zBMY+WchKZuFpGwWkrIFjMyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcx
        AsN427Gfm3cwXtoYfIhRgINRiYf3x/Uj0UKsiWXFlbmHGCU4mJVEeNMvHY0W4k1JrKxKLcqP
        LyrNSS0+xGgKdPhEZinR5HxgjOWVxBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5NLUgt
        gulj4uCUamC0Eg4NrllwR391ufDzXQteneHR25OyK5phsqGw0w27cxG1k8usf5RsDjSa4mG6
        7lvoqp6Le0PKDeYfWHJGafPZKR/jZ6RFpE5PWHHqXjHvZsug+i1HAk7sP5H1t+78cttN1cov
        1y1rV10tM2X267Xhv44dC0r6IyVm1r2QtyRzz5ZDOuGLgvx2KbEUZyQaajEXFScCAP5IkQl5
        AgAA
Message-Id: <20181016143814eucas1p21b1f3099131fc3f4263947932195299e~eHZ_4THEH2088320883eucas1p2s@eucas1p2.samsung.com>
X-CMS-MailID: 20181016143814eucas1p21b1f3099131fc3f4263947932195299e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016143814eucas1p21b1f3099131fc3f4263947932195299e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016143814eucas1p21b1f3099131fc3f4263947932195299e
References: <CGME20181016143814eucas1p21b1f3099131fc3f4263947932195299e@eucas1p2.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

'default n' is the default value for any bool or tristate Kconfig
setting so there is no need to write it explicitly.

Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
is not set' for visible symbols") the Kconfig behavior is the same
regardless of 'default n' being present or not:

    ...
    One side effect of (and the main motivation for) this change is making
    the following two definitions behave exactly the same:
    
        config FOO
                bool
    
        config FOO
                bool
                default n
    
    With this change, neither of these will generate a
    '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
    That might make it clearer to people that a bare 'default n' is
    redundant.
    ...

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/pci/pcie/Kconfig |    4 ----
 1 file changed, 4 deletions(-)

Index: b/drivers/pci/pcie/Kconfig
===================================================================
--- a/drivers/pci/pcie/Kconfig	2018-10-09 15:58:49.831123212 +0200
+++ b/drivers/pci/pcie/Kconfig	2018-10-16 16:36:32.419732670 +0200
@@ -36,7 +36,6 @@ config PCIEAER
 config PCIEAER_INJECT
 	tristate "PCI Express error injection support"
 	depends on PCIEAER && DYNAMIC_FTRACE_WITH_REGS
-	default n
 	help
 	  This enables PCI Express Root Port Advanced Error Reporting
 	  (AER) software error injector.
@@ -84,7 +83,6 @@ config PCIEASPM
 config PCIEASPM_DEBUG
 	bool "Debug PCI Express ASPM"
 	depends on PCIEASPM
-	default n
 	help
 	  This enables PCI Express ASPM debug support. It will add per-device
 	  interface to control ASPM.
@@ -129,7 +127,6 @@ config PCIE_PME
 config PCIE_DPC
 	bool "PCI Express Downstream Port Containment support"
 	depends on PCIEPORTBUS && PCIEAER
-	default n
 	help
 	  This enables PCI Express Downstream Port Containment (DPC)
 	  driver support.  DPC events from Root and Downstream ports
@@ -139,7 +136,6 @@ config PCIE_DPC
 
 config PCIE_PTM
 	bool "PCI Express Precision Time Measurement support"
-	default n
 	depends on PCIEPORTBUS
 	help
 	  This enables PCI Express Precision Time Measurement (PTM)
