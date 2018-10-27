Return-Path: <SRS0=ddhW=NH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78C2ECDE44
	for <linux-pci@archiver.kernel.org>; Sat, 27 Oct 2018 00:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5176D2082C
	for <linux-pci@archiver.kernel.org>; Sat, 27 Oct 2018 00:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="elowdOc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5176D2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbeJ0Il0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 27 Oct 2018 04:41:26 -0400
Received: from mail-bl2nam02on0108.outbound.protection.outlook.com ([104.47.38.108]:35622
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727778AbeJ0Il0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 27 Oct 2018 04:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9ZxQX5/Qc6p72GmZzpkvG/KZXpgMyar5oGYt2wdQwk=;
 b=elowdOc3Oq8L3s825zVhfoeInpG50JKiAClHfG+EawLUDxcPAWcJFbjBP4EYDgR5rl0ymzFwgOQ3/l401TCj/VVRW/qlFuwiqVmuUCYV177EA/C9EBfxjJwltEEHYk7rLLCvtEp/YxhrAJycQtVeDpzuM2BmRsBaenXpj44Ipxg=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3689.namprd06.prod.outlook.com (10.167.236.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Sat, 27 Oct 2018 00:00:57 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1273.025; Sat, 27 Oct 2018
 00:00:57 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Trent Piepho <tpiepho@impinj.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
Thread-Topic: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
Thread-Index: AQHUbYgjUY6vVpEq1Ees3VO0f7sjeQ==
Date:   Sat, 27 Oct 2018 00:00:57 +0000
Message-ID: <20181027000028.21343-1-tpiepho@impinj.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1701CA0021.namprd17.prod.outlook.com
 (2603:10b6:301:14::31) To MWHPR0601MB3708.namprd06.prod.outlook.com
 (2603:10b6:301:7c::38)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3689;6:t44IT6XzoL147kb7aDabQFiqSaY20zidQKnEikZnoeT1wpfRPeXgtlqkHWOwXKMNLQ0T30AITMgjt8jbd/VSMmELGsgl4xjY5g557XdoRa1eYDKG1URokqY7jPSvk1YMQ0gFaHDAQSGu02FjCZ0qR1VKSxJLZOdZ+dfhHlqfhYDrVDIhzmukDnb7LLKnkxzXcNGenWzJIqw/i5ImDhN+e4FqhwaF5amXI/f3zs1EJ5oHim5KZvPdVUkdml8YLoG2qCOrIvxaCVJU7Hhe1H+Rwl+ajAfZ5tZkIiUYVETiY0WuQ0RV830lwEEEpiph4i7zIZRZMAaELNPepJEIbLb6HJbZJIn8DqTr7ej6+xX7fSM8c4vajZLDZ7lFJlKDLtoZo3JPEo0CluPQtCijf8b446YNOJwtGq28XOkh13zlKDOxZpYw4KolZbRGEXGSSlyw9aUQK5ZCyej+mBJZhULX7w==;5:keITai424iM4BkvP4IPOg/a0s6dkbQueBq0XM3E1Ef4DoLdkN6AFhpXoO5F4r+bMmLjqyCh8k4An5CpxUPR0Z+tStJ8xePY/LvblDd/1xQzRkHr4IK/8piKgly4lDaN2z2gc9+p8RRJ+suqm7f6drmdaV2zCc8wrXcxXuFiGZ+c=;7:urcLMXfat8TOComi14S3fM39kmqsgfCIVzFp/QXjkRPTlTMs15OPGmBFRKCjkzO05xYeV4+zJ5/HKOAb+6rfAeYYPnspglQcQhysnLRfvBOUl45T7AYgCw0Gfn9jxa1bjGut3KT9ndmN2ae1roAH5scp5EfyeHm8zzI/al1JD+QL8KMf/0jMXZmTGEQE5rr2+UBx2O4ok621NfYt1i1vfceQ6o3HYXhF96pw9CmlL40q3dfZMA/nHzd24xNUe7zA
x-ms-office365-filtering-correlation-id: febfe4c1-b16d-406f-bbfd-08d63b9f454b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3689;
x-ms-traffictypediagnostic: MWHPR0601MB3689:
x-microsoft-antispam-prvs: <MWHPR0601MB36896145879ABD6073DD68A1D3F10@MWHPR0601MB3689.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(31051911155226)(85827821059158)(180628864354917)(211936372134217)(153496737603132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3689;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3689;
x-forefront-prvs: 08381C729B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(376002)(396003)(39830400003)(199004)(189003)(305945005)(71190400001)(71200400001)(7736002)(316002)(5660300001)(99286004)(486006)(2351001)(476003)(54906003)(66066001)(2616005)(186003)(1857600001)(6916009)(52116002)(6506007)(386003)(86362001)(81156014)(2906002)(81166006)(2900100001)(102836004)(97736004)(6116002)(39060400002)(5250100002)(3846002)(1076002)(2501003)(53936002)(26005)(6306002)(68736007)(14444005)(256004)(966005)(105586002)(25786009)(5640700003)(106356001)(36756003)(478600001)(6436002)(14454004)(8676002)(6512007)(8936002)(4326008)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3689;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FxBh63kazrBxNi0oyPZ9x6IMZ55GJknxDYjM+V+YQxsIan2BjUuasE7JIXNdxxPwOkh03eJ+cVys0OGoJBOiBBPpSfBwiRHIXds/fl1DQ/3QRbgB34sKp3DLZEq5oa2C+AA/ujY4O0uqBnEDkYgvpyy9QfL0ilICsXJFS7fGz6vuckMIwqdyjD8DRm/HlFovP5nTtZeMytYjcQkOxSEkh35d5vX6kgkms0NexJCDC6B6UOiWSny90OdKk7J0sw5ivc+ooLJ7/rgUnpr4ofsq4AACGzcetLN89wJnVq1M9GMia3MgQ+AOjtpb6/TTr6AGOAhpHtEO9Hb7eABoe7vD3DhCj8ct7uq7VAAWOcaBxFs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: febfe4c1-b16d-406f-bbfd-08d63b9f454b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2018 00:00:57.5789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3689
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit 8c934095fa2f ("PCI: dwc: Clear MSI interrupt status
after it is handled, not before").

This is a very real race that we observed quickly after switching from
4.13 to 4.16.  Using a custom PCI-e endpoint and driver, I was able to
track it to the precise race and verify the fixed behavior, as will be
described below.

This bug was originally fixed in 2013, in commit ca1658921b63 ("PCI:
designware: Fix missing MSI IRQs") The discussion of that commit,
archived in patchwork [1], is informative and worth reading.

The bug was re-added in the '8c934 commit this is reverting, which
appeared in the 4.14 kernel.

Unfortunately, Synopsys appears to consider the operation of this PCI-e
controller secret.  They provide no publicly available docs for it nor
allow the references manuals of SoCs using the controller to publish any
documentation of it.

So I can not say certain this code is correctly using the controller's
features.  However, extensive testing gives me high confidence in the
accuracy of what is described below.

If an MSI is received by the PCI-e controller while the status register
bit for that MSI is set, the PCI-e controller will NOT generate another
interrupt.  In addition, it will NOT queue or otherwise mark the
interrupt as "pending", which means it will NOT generate an interrupt
when the status bit is unmasked.

This gives the following race scenario:

1.  An MSI is received by, and the status bit for the MSI is set in, the
DWC PCI-e controller.
2.  dw_handle_msi_irq() calls a driver's registered interrupt handler
for the MSI received.
3.  At some point, the interrupt handler must decide, correctly, that
there is no more work to do and return.
4.  The hardware generates a new MSI.  As the MSI's status bit is still
set, this new MSI is ignored.
6.  dw_handle_msi_irq() unsets the MSI status bit.

The MSI received at point 4 will never be acted upon.  It occurred after
the driver had finished checking the hardware status for interrupt
conditions to act on.  Since the MSI status was masked, it does not
generated a new IRQ, neither when it was received nor when the MSI is
unmasked.

It seems clear there is an unsolvable race here.

After this patch, the sequence becomes as follows:

1.  An MSI is received and the status bit for the MSI is set in the
DWC PCI-e controller.
2.  dw_handle_msi_irq() clears this MSI status bit.
3.  dw_handle_msi_irq() calls a driver's registered interrupt handler
for the MSI received.
3.  At some point, the interrupt handler must decide, correctly, that
there is no more work to do and return.
4.  The hardware generates a new MSI.  This sets the MSI status bit and
triggers another interrupt in the interrupt controller(s) above the DWC
PCI-e controller.  As the the dwc-pcie handler is not re-entrant, it is
not run again at this time.
6.  dw_handle_msi_irq() finishes.  The MSI status bit remains set.
7.  The IRQ is re-raised and dw_handle_msi_irq() runs again.
8.  dw_handle_msi_irq() invokes the MSI's registered interrupt handler
again as the status bit was still set.

The observant will notice that point 4 present the opportunity for the
SoC's interrupt controller to lose the interrupt in the same manner as
the bug in this driver.  The driver for that interrupt controller will
be written to properly deal with this.  In some cases the hardware
supports an EOI concept, where the 2nd IRQ is masked and internally
queued in the hardware, to be re-raised at EOI in step 7.  In other
cases the IRQ will be unmasked and re-raised at step 4, but the kernel
will see the handler is INPROGRESS and not re-invoke it, and instead set
a PENDING flag, which causes the handler to re-run at step 7.

[1] https://patchwork.kernel.org/patch/3333681/

Fixes: 8c934095fa2f ("PCI: dwc: Clear MSI interrupt status after it is hand=
led, not before")
Cc: stable@vger.kernel.org
Cc: Vignesh R <vigneshr@ti.com>
Cc: Faiz Abbas <faiz_abbas@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Trent Piepho <tpiepho@impinj.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index 29a05759a294..9a3960c95ad3 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -98,10 +98,10 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 			irq =3D irq_find_mapping(pp->irq_domain,
 					       (i * MAX_MSI_IRQS_PER_CTRL) +
 					       pos);
-			generic_handle_irq(irq);
 			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS +
 						(i * MSI_REG_CTRL_BLOCK_SIZE),
 					    4, 1 << pos);
+			generic_handle_irq(irq);
 			pos++;
 		}
 	}
--=20
2.14.4

