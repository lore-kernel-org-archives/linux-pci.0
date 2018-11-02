Return-Path: <SRS0=VxNY=NN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153CEC32789
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 18:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF412081F
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 18:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zduL8Iy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF412081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbeKCDTI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:19:08 -0400
Received: from mail-eopbgr700043.outbound.protection.outlook.com ([40.107.70.43]:59721
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726700AbeKCDTI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Nov 2018 23:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RO5Dm8xcLNk10V49yZrthKvKWMzlStT6ahXUOTmaboQ=;
 b=zduL8Iy/2q0jD3uRKEZ2nuouo8gSdQq2zVWglqzOAXYkhNBsVdoDpNkrKp5/SOOccSwm3fWcw7Ejr0M9XzzhpGJQWbQFyE/X5iyFK+qgy5W6uIjlU6V/TCLSDFWQ4erjbhloXoia63znIUHiu3JAV9OnUmRfOF4tR+oT9ZaQ6pQ=
Received: from CY4PR12MB1768.namprd12.prod.outlook.com (10.175.63.10) by
 CY4PR12MB1206.namprd12.prod.outlook.com (10.168.166.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 2 Nov 2018 18:11:02 +0000
Received: from CY4PR12MB1768.namprd12.prod.outlook.com
 ([fe80::82f:4b8a:fd43:aab3]) by CY4PR12MB1768.namprd12.prod.outlook.com
 ([fe80::82f:4b8a:fd43:aab3%7]) with mapi id 15.20.1273.030; Fri, 2 Nov 2018
 18:11:02 +0000
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
Subject: [PATCH 0/4] Update DF/SMN access and k10temp for AMD F17h M30h
Thread-Topic: [PATCH 0/4] Update DF/SMN access and k10temp for AMD F17h M30h
Thread-Index: AQHUctdpvkHVmgjtuEeb1aRHysKu9w==
Date:   Fri, 2 Nov 2018 18:11:02 +0000
Message-ID: <20181102181055.130531-1-brian.woods@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0038.namprd04.prod.outlook.com
 (2603:10b6:803:2a::24) To CY4PR12MB1768.namprd12.prod.outlook.com
 (2603:10b6:903:122::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Woods@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1206;20:XLPsKBHJgNpW1oll0XmjQGKlkRwHcQ/JFFzvRnGvrROkrJBBtu3CEdjBPF37I0Loe/rWb77FV0nA5M7VvHLLYHKBxE3xRNejPFytZm81dVAOST169mfazxfZKndeYKQWSRRWd+R8pwVAb6lphzfSHhX+WWaNw9MwTo9CmsCLTNsLkPnch9b2Ypt3wru1wlJrKBAPLojwJl2rHDsUu7vg0IMHsTE6FRX98pL39f032qwRldO/ILktD8QQJbFKICza
x-ms-office365-filtering-correlation-id: d53f0288-da5c-46ba-21eb-08d640ee8c1a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1206;
x-ms-traffictypediagnostic: CY4PR12MB1206:
x-microsoft-antispam-prvs: <CY4PR12MB12060FEF5C525C16A1E28618E5CF0@CY4PR12MB1206.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CY4PR12MB1206;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1206;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(366004)(136003)(189003)(199004)(7736002)(2900100001)(478600001)(36756003)(6116002)(1076002)(316002)(3846002)(105586002)(106356001)(2906002)(25786009)(486006)(97736004)(71190400001)(6512007)(71200400001)(110136005)(256004)(6486002)(6436002)(99286004)(7416002)(386003)(53936002)(26005)(66066001)(6506007)(186003)(8936002)(5660300001)(86362001)(575784001)(72206003)(81166006)(81156014)(102836004)(305945005)(476003)(2616005)(68736007)(2501003)(15650500001)(14454004)(2201001)(8676002)(52116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1206;H:CY4PR12MB1768.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nCY/xy4zD0TcNhcIx85y7hlsUrtI6qyCBlFlpMHm7ya1pF72buz+uCBDGwU/Uj/DOm/j2wAHiwnXKys4Sxn4+ZKioLRYBXkYWdrMyoK/PwtezoeRNwBw+aWHiRmhjwPKK4BYBf8i/OufGxD/Ozpd4/4FShgcjC3sUnr0BXH+iL6akIQK7+Qdm/+H5mn5KbMrQD+sX/idTqRGvRLaNWOfsckdlPku35cSO2ZSPFZk+7UYXzXWcFmRGeQiNmM9rS0lO58sJ15UNtevjw9hhtTCKPyz6kMFIpR26U8TG1jgDvniCTjDW6elCSClM2YViELkIaL25cxowItf0qjGpzq8+Lqgnd6Zs/IoUnffXAc8bNA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53f0288-da5c-46ba-21eb-08d640ee8c1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 18:11:02.2670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1206
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Updates the data fabric/SMN code needed to get k10temp working for M30h.
Since there are now processors which have multiple roots per DF/SMN
interface, there needs to some logic which skips N-1 root complexes per
DF/SMN interface.  This is because the root complexes per interface are
redundant (as far as DF/SMN goes).  These changes shouldn't effect past
processors and, for F17h M0Xh, the mappings stay the same.

Brian Woods (4):
  k10temp: x86/amd_nb: consolidate shared device IDs
  x86/amd_nb: add support for newer PCI topologies
  x86/amd_nb: add PCI device IDs for F17h M30h
  hwmon: k10temp: add support for AMD F17h M30h CPUs

 arch/x86/kernel/amd_nb.c | 50 ++++++++++++++++++++++++++++++++++++++++----=
----
 drivers/hwmon/k10temp.c  | 10 ++--------
 include/linux/pci_ids.h  |  3 +++
 3 files changed, 47 insertions(+), 16 deletions(-)

--=20
2.11.0

