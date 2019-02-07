Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08952C282C2
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 20:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0C621721
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 20:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Pyv7ejxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfBGUgo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:36:44 -0500
Received: from mail-eopbgr1310132.outbound.protection.outlook.com ([40.107.131.132]:59421
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726614AbfBGUgn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Feb 2019 15:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Dea/znRj25lk77x3IDOnqOp4CP0ee/G8KMmlQAjMLQ=;
 b=Pyv7ejxjM7fkkuN3nMJSG/0OxXvK0Z4jbtqDDk/JyUjwDQGkZNjgX+8aaO0OnYUYaGmsl56FeGqgaWmM9ITFgmyM8NvhTeDxE+QzdXgRnhfya2iMXFml5+sPrwGGRvJBI1VVl4mqUDfjfLSkoC4Pl1Dd1GxXKgyJIKG/WvDKzbY=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0139.APCP153.PROD.OUTLOOK.COM (10.170.188.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.11; Thu, 7 Feb 2019 20:36:33 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f%9]) with mapi id 15.20.1622.006; Thu, 7 Feb 2019
 20:36:33 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH] PCI: hv: Add hv_pci_remove_slots() when we unload the driver
Thread-Topic: [PATCH] PCI: hv: Add hv_pci_remove_slots() when we unload the
 driver
Thread-Index: AdS/JKy4gHBOTZqYQrqpJy5ySOaIgg==
Date:   Thu, 7 Feb 2019 20:36:32 +0000
Message-ID: <PU1P153MB0169F06340FC519C2802C5CFBF680@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-07T20:36:30.7777326Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e8b27f75-fbdf-46ef-8be2-764296e7f981;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:cc28:4ccf:559c:eb32]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0139;6:gzEXZ2GV03GEHAyFCjpwbOlcdcCYd2PusHb0PjHLDeraEwU7PxKxiY2YQXvALtNmNFd0Zk8OjQu+ucPm/Ikwc4N/SJvDhv7QsXnQpB7U3PfoNHzsgO7/R1rPTir7gLGr3qIlVMRshk0BYjPq424h4/FI9yT/VsPn8ReSf71A+c5ZapITVE6DGDsxpwQAbcTqiSwWGmY439eN5LEmIgQGVdoNsB8kaeyfCm7sAEQCJcdOeyLeaOXrJDtGaNzqEcgqAiQBNmacHATsY/Ox2t0RoAmyFcBX53e32hIjLIESNAlGayeBQkdjyvx+c2WCssfpa8FECcGDgmJfYvA/u8DbxKBbRzPIJmsDI26fajkHduJQ+JRweitTKwgxnXH2qiqaHsy3R8hQ/RV7Fsgz1gbx8JHTHVfzpUknaqKstnO1P6QJV7Qf67yTRVceLslMZsGTj+8JlyfrNbtURN2/RKkezw==;5:D7g3v+Hdmxov711vs24cqbSLwdU2Dj1qRjTbrb96ddGhKVaWJIPM0EAuFmM05/+bNA8MnO4iuiO4tse8TaJGrs8psTC9nb5Y/11GwPen0btfbz8TuOqg98Ko8Oof26xQz4ZZ99LtAsviyseJ8vUQomEy5jY4D2qhj14hbMiiLJnA+gdOmwm0CsBYqeCyQByPw7oUygkGgaKiH5pZPCnIXQ==;7:dJWpO0/WxMmEOgxnf7VSw2nIaMOTm9+UYkOjvrqyLKaUdRECQZI5h9BSFTXu+BC2zCLJg++G73nxMUiH8Ymq0rfM8aBYo0PVPjMAzR+MGmY/Uy8utReH1/Lw6db6i6Oh0jrZWB23qMksmap9nv2QQw==
x-ms-office365-filtering-correlation-id: 2bd21b04-7683-4141-4b9d-08d68d3bf2b8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0139;
x-ms-traffictypediagnostic: PU1P153MB0139:
x-microsoft-antispam-prvs: <PU1P153MB013982D8C7DD0064B0A79B27BF680@PU1P153MB0139.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(396003)(346002)(136003)(189003)(199004)(40224003)(86612001)(6436002)(256004)(14444005)(86362001)(25786009)(68736007)(1511001)(10090500001)(10290500003)(14454004)(6636002)(478600001)(8936002)(107886003)(186003)(102836004)(55016002)(4326008)(9686003)(53936002)(46003)(316002)(74316002)(6116002)(81166006)(6506007)(8676002)(81156014)(486006)(7696005)(106356001)(54906003)(110136005)(8990500004)(305945005)(7736002)(105586002)(22452003)(97736004)(2501003)(2906002)(476003)(99286004)(71190400001)(33656002)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0139;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xBLaWEERWWhBsoD1046fjmx6XD1Lb10bK9HJ1j88HJ+bV0599l5xqu0WrsYJKFyTFyNut4htslxp7ePrBrYxXz9aoXH8I8yXy0ONfLs7Foa6N+RftKfR/nvoEQhJbqADpI2kImazvh3/ea63AxYXvCabw2HR6tRnrgG9XF8/9VUt3mteBEZBWKuldD/Mm8qNesdIcn4FPDpCfbDBOLKYfUm7bt32U5W03gvjQoYYJKPBy+/KfC6aM+X0MhFOPgNewOZIS6wxPSCvRwhF2RuAZt7gIYX5Wu09t943OqGjk0UhirwQf2wi5/g28y4zM9GnJnXkIP5yfs+9JGFGhkQXErvmzlI13fI13lqmHfFS2q0yZfHYGhxuxbOdx8v22TgHulQzPzv4CrrGsIELuRsKdCI5eEOYgSV6SERU71JCjw8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd21b04-7683-4141-4b9d-08d68d3bf2b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 20:36:32.9327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0139
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


When we unload pci-hyperv, the host doesn't send us a PCI_EJECT message.
In this case we also need to make sure the sysfs pci slot directory
is removed, otherwise "cat /sys/bus/pci/slots/2/address" will trigger
"BUG: unable to handle kernel paging request". And, if we unload/reload
the driver several times, we'll have multiple pci slot directories in
/sys/bus/pci/slots/ like this:

root@localhost:~# ls -rtl  /sys/bus/pci/slots/
total 0
drwxr-xr-x 2 root root 0 Feb  7 10:49 2
drwxr-xr-x 2 root root 0 Feb  7 10:49 2-1
drwxr-xr-x 2 root root 0 Feb  7 10:51 2-2

The patch adds the missing code, and in hv_eject_device_work() it also
moves pci_destroy_slot() to an earlier place where we hold the pci lock.

Fixes: a15f2c08c708 ("PCI: hv: support reporting serial number as slot info=
rmation")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index 9ba4d12c179c..6b4773727525 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1491,6 +1491,21 @@ static void hv_pci_assign_slots(struct hv_pcibus_dev=
ice *hbus)
 	}
 }
=20
+/*
+ * Remove entries in sysfs pci slot directory.
+ */
+static void hv_pci_remove_slots(struct hv_pcibus_device *hbus)
+{
+	struct hv_pci_dev *hpdev;
+
+	list_for_each_entry(hpdev, &hbus->children, list_entry) {
+		if (!hpdev->pci_slot)
+			continue;
+		pci_destroy_slot(hpdev->pci_slot);
+		hpdev->pci_slot =3D NULL;
+	}
+}
+
 /**
  * create_root_hv_pci_bus() - Expose a new root PCI bus
  * @hbus:	Root PCI bus, as understood by this driver
@@ -1887,6 +1902,10 @@ static void hv_eject_device_work(struct work_struct =
*work)
 		pci_lock_rescan_remove();
 		pci_stop_and_remove_bus_device(pdev);
 		pci_dev_put(pdev);
+		if (hpdev->pci_slot) {
+			pci_destroy_slot(hpdev->pci_slot);
+			hpdev->pci_slot =3D NULL;
+		}
 		pci_unlock_rescan_remove();
 	}
=20
@@ -1894,9 +1913,6 @@ static void hv_eject_device_work(struct work_struct *=
work)
 	list_del(&hpdev->list_entry);
 	spin_unlock_irqrestore(&hpdev->hbus->device_list_lock, flags);
=20
-	if (hpdev->pci_slot)
-		pci_destroy_slot(hpdev->pci_slot);
-
 	memset(&ctxt, 0, sizeof(ctxt));
 	ejct_pkt =3D (struct pci_eject_response *)&ctxt.pkt.message;
 	ejct_pkt->message_type.type =3D PCI_EJECTION_COMPLETE;
@@ -2682,6 +2698,7 @@ static int hv_pci_remove(struct hv_device *hdev)
 		pci_lock_rescan_remove();
 		pci_stop_root_bus(hbus->pci_bus);
 		pci_remove_root_bus(hbus->pci_bus);
+		hv_pci_remove_slots(hbus);
 		pci_unlock_rescan_remove();
 		hbus->state =3D hv_pcibus_removed;
 	}
--=20
2.19.1

