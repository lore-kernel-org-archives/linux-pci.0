Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CC3C67839
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 08:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B4A20849
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 08:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B4A20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbeLLIdN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:33:13 -0500
Received: from mx01.hxt-semitech.com ([223.203.96.7]:34847 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726440AbeLLIdN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Dec 2018 03:33:13 -0500
X-ASG-Debug-ID: 1544603579-093b7e7c6213d20001-0c9NHn
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda.hxt-semitech.com with ESMTP id TY3YVHshbiopl8sf (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 12 Dec 2018 16:32:59 +0800 (CST)
X-Barracuda-Envelope-From: yanjiang.jin@hxt-semitech.com
Received: from controller.hxtcorp.net (10.5.21.105) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Dec 2018 16:32:07 +0800
From:   Yanjiang Jin <yanjiang.jin@hxt-semitech.com>
To:     <bhelgaas@google.com>, <keith.busch@intel.com>
CC:     <yu.zheng@hxt-semitech.com>, <ruscur@russell.cc>,
        <sbobroff@linux.ibm.com>, <oohall@gmail.com>,
        <jinyanjiang@gmail.com>, <yanjiang.jin@hxt-semitech.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] Cover letter for (PCI/AER: only insert one element into kfifo)
Date:   Wed, 12 Dec 2018 16:32:29 +0800
X-ASG-Orig-Subj: [PATCH] Cover letter for (PCI/AER: only insert one element into kfifo)
Message-ID: <1544603550-14208-1-git-send-email-yanjiang.jin@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.105]
X-ClientProxiedBy: HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) To
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15)
Content-Transfer-Encoding: 8BIT
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1544603579
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5004 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.63648
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Without this patch, if we have multi PCIe devices, and one of them has
AER error, aer_recover_work_func() -> kfifo_get() will traverse the whole
kfifo which has wrong element number(16).
If one null element's uninitialized memory matches another
PCIe device(0000:01:00.0), we may get the below call trace.
It is unusual, but indeed happened on my board: QDF2400.

# lspci
0000:00:00.0 PCI bridge:
0000:01:00.0 Ethernet controller:
0004:00:00.0 PCI bridge:
0004:01:00.0 Ethernet controller:
0005:00:00.0 PCI bridge:
0005:01:00.0 Ethernet controller:

Call trace:

[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 5
[Hardware Error]: It has been corrected by h/w and requires no further action
[Hardware Error]: event severity: corrected
[Hardware Error]:  precise tstamp: 2018-11-29 09:23:16
[Hardware Error]:  Error 0, type: corrected
[Hardware Error]:   section_type: PCIe error
[Hardware Error]:   port_type: 4, root port
[Hardware Error]:   version: 3.0
[Hardware Error]:   command: 0x0407, status: 0x0010
[Hardware Error]:   device_id: 0004:00:00.0
[Hardware Error]:   slot: 0
[Hardware Error]:   secondary_bus: 0x01
[Hardware Error]:   vendor_id: 0x17cb, device_id: 0x0401
[Hardware Error]:   class_code: 000406
[Hardware Error]:   bridge: secondary_status: 0x0000, control: 0x0000
AER recover: find pci_dev for 0004:00:00:0
pcieport 0004:00:00.0: aer_status: 0x00000001, aer_mask: 0x0000e000
pcieport 0004:00:00.0:    [ 0] RxErr                  (First)
pcieport 0004:00:00.0: aer_layer=Physical Layer, aer_agent=Receiver ID
AER recover: Can not find pci_dev for a38f:00:18:2
AER recover: Can not find pci_dev for 0857:1c:03:5
AER recover: Can not find pci_dev for 62d2:80:19:6
AER recover: Can not find pci_dev for 0857:f8:03:4
AER recover: Can not find pci_dev for 0907:78:07:1
AER recover: Can not find pci_dev for 0000:00:00:1
AER recover: Can not find pci_dev for 0907:00:00:0
AER recover: Can not find pci_dev for 0000:00:00:1
AER recover: find pci_dev for 0000:01:00:0
Unable to handle kernel paging request at virtual address 0000000000813004
Mem abort info:
  ESR = 0x96000007
  Exception class = DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000007
  CM = 0, WnR = 0
user pgtable: 64k pages, 48-bit VAs, pgdp = 000000000dce9024
[0000000000813004] pgd=0000001727260003, pud=0000001727260003
pmd=0000001727290003, pte=0000000000000000
Internal error: Oops: 96000007 [#1] SMP
Workqueue: events aer_recover_work_func
pstate: 20400005 (nzCv daif +PAN -UAO)
pc : cper_print_aer+0x4c/0x290
lr : aer_recover_work_func+0x110/0x150
sp : ffff8017ca59fca0
x29: ffff8017ca59fca0 x28: ffff8017ca841000
x27: ffff8017ca841000 x26: 0000000000000001
x25: 0000000000813000 x24: 0000000000000040
x23: 0000000000000040 x22: ffff000008d5f830
x21: ffff0000090f1f10 x20: ffff0000090f1e98
x19: 0000000000000000 x18: ffffffffffffffff
x17: 0000000000000001 x16: 0000000000000007
x15: ffff000009073708 x14: ffff0000891e8faf
x13: ffff0000091e8fbd x12: 2c726579614c206c
x11: ffff00000909b000 x10: 0000000005f5e0ff
x9 : ffff8017ca59fa10 x8 : ffff000009073978
x7 : ffff0000091e8a40 x6 : 0000000000000518
x5 : 0000000000000001 x4 : ffff8017ff9710b8
x3 : ffff8017ff9710b8 x2 : 0000000000813000
x1 : 0000000000000000 x0 : ffff000009073708
Process kworker/11:1 (pid: 232, stack limit = 0x00000000060ad7e1)
Call trace:
 cper_print_aer+0x4c/0x290
 aer_recover_work_func+0x110/0x150
 process_one_work+0x1ac/0x3f0
 worker_thread+0x54/0x430
 kthread+0x104/0x130
 ret_from_fork+0x10/0x18
Code: f9400001 f90057a1 d2800001 54000f40 (2940e334)
SMP: stopping secondary CPUs
Starting crashdump kernel...
Bye!



This email is intended only for the named addressee. It may contain information that is confidential/private, legally privileged, or copyright-protected, and you should handle it accordingly. If you are not the intended recipient, you do not have legal rights to retain, copy, or distribute this email or its contents, and should promptly delete the email and all electronic copies in your system; do not retain copies in any media. If you have received this email in error, please notify the sender promptly. Thank you.


