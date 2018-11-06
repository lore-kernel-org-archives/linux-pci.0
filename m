Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFA1C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 20:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D344E2086A
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 20:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0TJPIAoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D344E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbeKGFfa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:35:30 -0500
Received: from mail-eopbgr710077.outbound.protection.outlook.com ([40.107.71.77]:4676
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388008AbeKGFf3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 00:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzeZijEqcDMnLLUzfLePaKvd8sXb2sKRkX9Spx93mq0=;
 b=0TJPIAohfgt5NaNg8Cz9Y/NM8b8u+KIYSIrs83mjdpLat1QNgS3+D6XLqwjztH3aKADT7AMl+lvshfqg/E10erj73R12jCCQ0SdRw3S+uuVnn9MOTEd3ttA4I0GbDzs9JTTFKQLZnopl3nax2SXNra3REsQnSBteh9npwUjyE7s=
Received: from BN6PR12MB1764.namprd12.prod.outlook.com (10.175.101.137) by
 BN6PR12MB1540.namprd12.prod.outlook.com (10.172.18.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 6 Nov 2018 20:08:21 +0000
Received: from BN6PR12MB1764.namprd12.prod.outlook.com
 ([fe80::d455:a1d4:8ed9:7e13]) by BN6PR12MB1764.namprd12.prod.outlook.com
 ([fe80::d455:a1d4:8ed9:7e13%7]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 20:08:21 +0000
From:   "Woods, Brian" <Brian.Woods@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Woods, Brian" <Brian.Woods@amd.com>, Pu Wen <puwen@hygon.cn>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [PATCH v2 4/4] hwmon: k10temp: add support for AMD F17h M30h CPUs
Thread-Topic: [PATCH v2 4/4] hwmon: k10temp: add support for AMD F17h M30h
 CPUs
Thread-Index: AQHUdgx3bRGgsFF0E0ykUXx1+gT99A==
Date:   Tue, 6 Nov 2018 20:08:21 +0000
Message-ID: <20181106200754.60722-5-brian.woods@amd.com>
References: <20181106200754.60722-1-brian.woods@amd.com>
In-Reply-To: <20181106200754.60722-1-brian.woods@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0002.namprd02.prod.outlook.com
 (2603:10b6:803:2b::12) To BN6PR12MB1764.namprd12.prod.outlook.com
 (2603:10b6:404:107::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Woods@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1540;20:mH+ks2SGH4zeY2WoQm4uZGlqD5xvXNwx+InY8lwi7rxBaV4S52B2uwfXMEqpJ7L+X22iSFQ0RDrWIdp3YOXRNOdsX56/qb9LgG4rszInD1Z+Y+1jCnhslPqsvWUBc8BpYKhxb6DOgCwFzTnmRpeslhnUYJUWXPiUfrZKwLd5B0lmthzNF/8YkYm+sQ3j5P3LdEAy+X5HsEnM8tBpeieZqcHbX7ZS/tjNKg0AR/AVXg7K8loRL6ov4/AEO7hP3PSU
x-ms-office365-filtering-correlation-id: 2f1ba599-19c1-4e70-786d-08d6442399ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1540;
x-ms-traffictypediagnostic: BN6PR12MB1540:
x-microsoft-antispam-prvs: <BN6PR12MB1540E04D41242917EC15F82CE5CB0@BN6PR12MB1540.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1540;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1540;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(376002)(346002)(199004)(189003)(71190400001)(105586002)(106356001)(6506007)(36756003)(76176011)(186003)(52116002)(386003)(2616005)(486006)(11346002)(256004)(446003)(7736002)(14454004)(478600001)(72206003)(26005)(305945005)(316002)(5660300001)(110136005)(8676002)(68736007)(2906002)(6486002)(53936002)(81166006)(81156014)(2501003)(476003)(8936002)(66066001)(6512007)(2201001)(99286004)(2900100001)(1076002)(97736004)(86362001)(25786009)(102836004)(6116002)(6436002)(7416002)(3846002)(71200400001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1540;H:BN6PR12MB1764.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FIhVh1ygWXr7/iAxkEphjyWpLfuD8+xe+ImQpwy5FYkU09A/lCM766do+EQPaj5FTyOUtwr8a6z16c8HZ/+gG+FtdBcvemJ0zduY/uIN5EEnk/hoABmE/Nd3fmdtvbiP3v3PwwWAgAwOgj7eMROxXaNAhDW6lZM2IkXLhnrDCKDt5efjCXJmcfco+Ehb2cdfGPSyElaK7NgxLbU2xieg3LwS3eQl+0pOWGGLWbzC/z750Wk1nCgKCoDW1wkajuplh/1FupZ61N1momTHNbIrOS6cL9/zRe6oKmmNrOCwooYt7gkIoC7fKC0JuVSxBjLfXOrgcU04PPnKIvNDmA0a0gL6OdejpnsBbO8l5+3L3dE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1ba599-19c1-4e70-786d-08d6442399ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 20:08:21.5787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1540
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for AMD family 17h model 30h processors for k10temp.  Model
30h is functionally the same as model 01h processors (as far as k10temp
is concerned), just the PCI device IDs need to be updated.

Signed-off-by: Brian Woods <brian.woods@amd.com>
---
 drivers/hwmon/k10temp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index bc6871c8dd4e..9790f1f5eb98 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -360,6 +360,7 @@ static const struct pci_device_id k10temp_id_table[] =
=3D {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, k10temp_id_table);
--=20
2.11.0

