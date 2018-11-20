Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F564C43441
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 01:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D9820870
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 01:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="d+WDR6qd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D9820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeKTLsx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:48:53 -0500
Received: from mail-eopbgr680107.outbound.protection.outlook.com ([40.107.68.107]:44409
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbeKTLsx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 06:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpN5aQwrqilTF92XihrVi+hNtr+w0S+8Yt3MnFkWTYI=;
 b=d+WDR6qdpyOvnJLS/90v1OI82pdE/MJrbyPSeJ2OIdVRLXdTR34/U7RK0aHA+YrdLHYbycA7zOtZ7p1crrhCunDRP0BRzvYnZbVML0asldJ7RQ61PJNdLfV/cdnoWu8op/fpOxbNf0vQuzuWh8+rYrg5cGVD6UGAkx41x5PmLIo=
Received: from CY4PR0601MB3697.namprd06.prod.outlook.com (52.132.101.36) by
 CY4PR0601MB3682.namprd06.prod.outlook.com (52.132.101.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.20; Tue, 20 Nov 2018 01:22:19 +0000
Received: from CY4PR0601MB3697.namprd06.prod.outlook.com
 ([fe80::c090:3ad2:d81c:8407]) by CY4PR0601MB3697.namprd06.prod.outlook.com
 ([fe80::c090:3ad2:d81c:8407%5]) with mapi id 15.20.1294.048; Tue, 20 Nov 2018
 01:22:19 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "cphealy@gmail.com" <cphealy@gmail.com>,
        "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/3] PCI: imx: No-op imx6_pcie_reset_phy() on i.MX7D
Thread-Topic: [PATCH 2/3] PCI: imx: No-op imx6_pcie_reset_phy() on i.MX7D
Thread-Index: AQHUfqEnbGKGbEGphk6ccxbnMB+RXKVX4bIA
Date:   Tue, 20 Nov 2018 01:22:19 +0000
Message-ID: <1542676938.30311.581.camel@impinj.com>
References: <20181117181225.10737-1-andrew.smirnov@gmail.com>
         <20181117181225.10737-3-andrew.smirnov@gmail.com>
In-Reply-To: <20181117181225.10737-3-andrew.smirnov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR0601MB3682;6:BeSXApQeTfngsa5Sw7K6bRA/vTGVvw6KdL4QWXo04RBAeh6StQ6FpM3tKkcMO1g8XbgvCC2Wby62IMub4tsSoMf5w+oeCvFbtFVG6H/+H231+lTTil/U7xey6bNMjhoYf3VftRJ2syHSLi3h96OdBbUwPlHA7nv0Mw6bxMt/NrubxO0nId7o9wJZy+POFILECNlQNwFLPSGXQQvBPD9OUJS/q1IiI/4OLuoE9NBldf9qT4pkQ7DTpliTpYtVl/2rpYasvKoKYyqKoJq3uau3T1xL5OixCohlCLTYk7zSrAiGb/rB5v4945IDxj3p5XV7VG/rat4/bS5A5rDyArFuXG1rwrGGH22MC9UZCXrzTPmDYWa7oM40WTkGV5d8DjV8WWrAMAi62j07x5YQXVdfvzeaTdIHcQ0w5v9bACxvbg0uCppoEFUKIZkxjVuXh+mTRwh/BeWS7Uz0rvys7pafzQ==;5:l06iU85sRbnDwyJGnbzaBLx2oA1oUrkUjL7VdCr4OcB057zLXrSoYGcrenIhLu7i7/ZzdeL4zT3618OSiA7eIl5vL84dRTDkXcZzGKSH/DCr87CEAxwqMWj2ixf1bvy9UINTX1EMa4+egnEROJbK4k1qJPeddK+HKJIkVIYx3zI=;7:0VV96GjAh2yftgM0mvphoZFZt2u+/qK4LakVIrZjLpNohOxnPaDtVazg4c2qpEatlINqbt8Ef7nQVdN5pZ5wajEv00ylkcxiweSEdAQDtGYNstZs0hF9p3nxAx9ZQhSEgE8HNIlrIsMuEFGqXZ7w6w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ad00be53-6ed1-4518-2a40-08d64e869d7d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR0601MB3682;
x-ms-traffictypediagnostic: CY4PR0601MB3682:
x-microsoft-antispam-prvs: <CY4PR0601MB36820DAEAA4BF28E614E8A52D3D90@CY4PR0601MB3682.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231442)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CY4PR0601MB3682;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0601MB3682;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39850400004)(376002)(396003)(346002)(189003)(199004)(316002)(76176011)(6486002)(6506007)(5660300001)(106356001)(105586002)(256004)(110136005)(54906003)(7736002)(305945005)(103116003)(229853002)(4326008)(14454004)(7416002)(25786009)(68736007)(66066001)(478600001)(4001150100001)(97736004)(99286004)(2501003)(6512007)(53936002)(2900100001)(6436002)(81166006)(81156014)(8676002)(6246003)(102836004)(26005)(71190400001)(71200400001)(186003)(36756003)(6116002)(446003)(2906002)(3846002)(2616005)(8936002)(486006)(476003)(86362001)(39060400002)(14444005)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR0601MB3682;H:CY4PR0601MB3697.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uQw8/kH+0H2lb5QXUw7wBsKHq2S4Mai/D/uB3gfanEpQp7VDtOj1kDQQXIRzKx76wAiukN4DqVuRJnQ3aUKotvRf9VWG55Ddv3d60ibTSaT2ggot0+hNb6tf5PI5wdgOU0NpEGSxu4gXkgiFPAMn8QwZQ2VnJRPM/sBrJs+TAOP64khuoJNIY5HHCnc+MubFlb81r5xKt6kpt2SkrMJpbcX2PldKBLEThgxko4OzygXt92o0N8xV1clCkxgWLH65AhM1d2YeJMbJxx6xrdvd+pwbpRNnoGnm75L9yEzub8AvuG3FtERE6IAL/HiuynlOtQWl4JMaGcPC7Xd78ZMcbVtQiZ4c6qOXusX66p6jIS4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFB5478280669746AA80F1A8A43C8F78@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad00be53-6ed1-4518-2a40-08d64e869d7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 01:22:19.3063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0601MB3682
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gU2F0LCAyMDE4LTExLTE3IGF0IDEwOjEyIC0wODAwLCBBbmRyZXkgU21pcm5vdiB3cm90ZToN
Cj4gUENJRSBQSFkgSVAgYmxvY2sgb24gaS5NWDdEIGRpZmZlcnMgZnJvbSB0aGUgb25lIHVzZWQg
b24gaS5NWDYgZmFtaWx5LA0KPiBzbyBub25lIG9mIHRoZSBjb2RlIGluIGN1cnJlbnQgaW1wbGVt
ZW50YXRpb24gb2YgaW14Nl9wY2llX3Jlc2V0X3BoeSgpDQo+IGlzIGFwcGxpY2FibGUuDQoNClRl
c3RlZCBvbiBJTVg3ZCwgc3RpbGwgYXBwZWFycyB0byB3b3JrLg0KDQpOb3RlIHRoYXQgeW91ciBw
YXRjaGVzIHdpbGwgY29sbGlkZSB3aXRoIFN0ZWZhbiBBZ25lcidzIHBhdGNoLCAiUENJOg0KaW14
NjogbGltaXQgREJJIHJlZ2lzdGVyIGxlbmd0aCIsIHdoaWNoIHdhcyByZWNlbnRseSBwb3N0ZWQu
DQoNCkhlIGNoYW5nZWQgdGhlIHdheSB0aGUgdmFyaWFudHMgYXJlIGhhbmRsZWQuICBUaGF0IG1l
dGhvZCB3b3VsZCBhbGxvdw0Kc29tZSBvZiB0aGUgSU1YN0QgfHwgSU1YOE1RIGNoZWNrcyB0byBi
ZSByZS13cml0dGVuIGFzDQoNCiBpbXg2X3BjaWUtPmRydmRhdGEtPmJvb2xlYW5fYXR0cmlidXRl
DQoNCldoZXJlIHRoZSBhdHRyaWJ1dGUgY2FuIGJlIHNldCBpbiBhIHRhYmxlIGFuZCBiZSByZS11
c2VkIGluIGV2ZXJ5IHBsYWNlDQppdCBjb21lcyBpbnRvIHBsYXkgYW5kIHVwZGF0ZWQgZm9yIG5l
dyBkZXZpY2VzIGluIG9uZSBzcG90LCBpbnN0ZWFkIG9mDQprZWVwaW5nIHBpbGVzIG9mIHRoaXMg
dmVyc2lvbiBvciB0aGF0IHZlcnNpb24gb3IgdGhpcyBvdGhlciB2ZXJzaW9uDQpjaGVja3MgdXAg
dG8gZGF0ZS4NCg==
