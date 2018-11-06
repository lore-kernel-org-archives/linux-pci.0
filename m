Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AD5C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 20:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE1E2086A
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 20:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XXeA3tpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE1E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbeKGFf1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:35:27 -0500
Received: from mail-eopbgr710077.outbound.protection.outlook.com ([40.107.71.77]:4676
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727268AbeKGFf0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 00:35:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKhEFRC4kM8MFRJXwJ7vzkcXdGfcKkvKlTotzHENsVA=;
 b=XXeA3tpwd3bN2EcoPhUmQH6iVgLnIsEL50J1e7JlesyjX+Lw44dE7fdFJFOc05BHTnCozldCTF6H+s3ANYsVs9XnFQV5q0TFUR3RhuGA3tFgqCVr7eT6Zi6msmMLV2GSyDYk/NxNrVMxlA15COvh5o52ixk+sQSlgAuoT9YmC1c=
Received: from BN6PR12MB1764.namprd12.prod.outlook.com (10.175.101.137) by
 BN6PR12MB1540.namprd12.prod.outlook.com (10.172.18.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 6 Nov 2018 20:08:16 +0000
Received: from BN6PR12MB1764.namprd12.prod.outlook.com
 ([fe80::d455:a1d4:8ed9:7e13]) by BN6PR12MB1764.namprd12.prod.outlook.com
 ([fe80::d455:a1d4:8ed9:7e13%7]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 20:08:16 +0000
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
Subject: [PATCH v2 2/4] x86/amd_nb: add support for newer PCI topologies
Thread-Topic: [PATCH v2 2/4] x86/amd_nb: add support for newer PCI topologies
Thread-Index: AQHUdgx0TUSmFJI/Rke/J/yJg51ZOg==
Date:   Tue, 6 Nov 2018 20:08:16 +0000
Message-ID: <20181106200754.60722-3-brian.woods@amd.com>
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
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1540;20:m+kIdxkKzdVOzBqyQFXk3ZuMYRCIoza+fzuZgSkSCfxhwlY8JIrWJOmoHAlHKNOKqBCwLSv+kVnvPXhjcF22pYjN7u6HabXHqQ997ystPxrNu4KpnRsHxxvXw+BeITxB341HXy4fiQtsiBIadcqNxgkBAmLP8eSiRaI19nhyYDaWREe9jTgKTfoE36TcZKZIHJ9BsBVWXNBBX29lYx8G4VJaK8ARV9tQ3kcG4LqvCX0Ab6d/C2pSbnTLO/MDRTuT
x-ms-office365-filtering-correlation-id: 69ac422f-994e-4419-0f74-08d6442396d9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1540;
x-ms-traffictypediagnostic: BN6PR12MB1540:
x-microsoft-antispam-prvs: <BN6PR12MB154010A2382701777143C0DAE5CB0@BN6PR12MB1540.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1540;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1540;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(376002)(346002)(199004)(189003)(71190400001)(105586002)(106356001)(6506007)(36756003)(76176011)(186003)(52116002)(386003)(2616005)(486006)(11346002)(256004)(14444005)(446003)(7736002)(14454004)(478600001)(72206003)(26005)(305945005)(316002)(5660300001)(110136005)(8676002)(68736007)(2906002)(6486002)(53936002)(81166006)(81156014)(2501003)(476003)(8936002)(66066001)(6512007)(2201001)(99286004)(2900100001)(1076002)(97736004)(86362001)(25786009)(102836004)(6116002)(6436002)(7416002)(3846002)(71200400001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1540;H:BN6PR12MB1764.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1qRX1qlxIIVc/lXgBnHAulnewHpmZo0QKdIdZ1TxIZgBesvFa/fzBWthd/7H8BLSXEHwHBczWrOBk/ET/us92J3UDfFqMRiaMDrhrXFg5AXYOK0W7l2xt5KamAh48zLgc0M7qi0R1C1dVCWZ+CYLpJun0WO5lE1wyMeORKaK89kt2lBP1sdzwIb7xk8Lkc8c+DZBkYCEEkebBsx2gUgPZum8x6ZI2r3IfC/oi9bFP5YeJQ36bb77pf2bq7/jJekzwDfVcvvru0Y0VXv6Ikw0lAcz6D6jZfDlKKCSRIgb+0/j8KuFGHZBdVrAasdXfnc38pBYh67w+MNR9lxpD5UqBby0fx9VkBW9Ne87v+I41E0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ac422f-994e-4419-0f74-08d6442396d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 20:08:16.8288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1540
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for new processors which have multiple PCI root complexes
per data fabric/system management network interface.  If there are (N)
multiple PCI roots per DF/SMN interface, then the PCI roots are
redundant (as far as SMN/DF access goes).  For each DF/SMN interface:
map to the first available PCI root and skip the next N-1 PCI roots so
the following DF/SMN interface get mapped to a correct PCI root.

Ex:
DF/SMN 0 -> 60
	    40
	    20
	    00
DF/SMN 1 -> e0
	    c0
	    a0
	    80

Signed-off-by: Brian Woods <brian.woods@amd.com>
---
 arch/x86/kernel/amd_nb.c | 44 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 19d489ee2b1e..cc34266e3c62 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -213,7 +213,10 @@ int amd_cache_northbridges(void)
 	const struct pci_device_id *root_ids =3D amd_root_ids;
 	struct pci_dev *root, *misc, *link;
 	struct amd_northbridge *nb;
-	u16 i =3D 0;
+	u16 roots_per_misc =3D 0;
+	u16 misc_count =3D 0;
+	u16 root_count =3D 0;
+	u16 i, j;
=20
 	if (amd_northbridges.num)
 		return 0;
@@ -226,26 +229,55 @@ int amd_cache_northbridges(void)
=20
 	misc =3D NULL;
 	while ((misc =3D next_northbridge(misc, misc_ids)) !=3D NULL)
-		i++;
+		misc_count++;
=20
-	if (!i)
+	if (!misc_count)
 		return -ENODEV;
=20
-	nb =3D kcalloc(i, sizeof(struct amd_northbridge), GFP_KERNEL);
+	root =3D NULL;
+	while ((root =3D next_northbridge(root, root_ids)) !=3D NULL)
+		root_count++;
+
+	if (root_count) {
+		roots_per_misc =3D root_count / misc_count;
+
+		/*
+		 * There should be _exactly_ N roots for each DF/SMN
+		 * interface.
+		 */
+		if (!roots_per_misc || (root_count % roots_per_misc)) {
+			pr_info("Unsupported AMD DF/PCI configuration found\n");
+			return -ENODEV;
+		}
+	}
+
+	nb =3D kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL);
 	if (!nb)
 		return -ENOMEM;
=20
 	amd_northbridges.nb =3D nb;
-	amd_northbridges.num =3D i;
+	amd_northbridges.num =3D misc_count;
=20
 	link =3D misc =3D root =3D NULL;
-	for (i =3D 0; i !=3D amd_northbridges.num; i++) {
+	for (i =3D 0; i < amd_northbridges.num; i++) {
 		node_to_amd_nb(i)->root =3D root =3D
 			next_northbridge(root, root_ids);
 		node_to_amd_nb(i)->misc =3D misc =3D
 			next_northbridge(misc, misc_ids);
 		node_to_amd_nb(i)->link =3D link =3D
 			next_northbridge(link, link_ids);
+
+		/*
+		 * If there are more PCI root devices than data fabric/
+		 * system management network interfaces, then the (N)
+		 * PCI roots per DF/SMN interface are functionally the
+		 * same (for DF/SMN access) and N-1 are redundant.  N-1
+		 * PCI roots should be skipped per DF/SMN interface so
+		 * the following DF/SMN interfaces get mapped to
+		 * correct PCI roots.
+		 */
+		for (j =3D 1; j < roots_per_misc; j++)
+			root =3D next_northbridge(root, root_ids);
 	}
=20
 	if (amd_gart_present())
--=20
2.11.0

