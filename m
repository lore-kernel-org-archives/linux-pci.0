Return-Path: <SRS0=AiiY=S3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40FFC10F03
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 06:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67AA217D7
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 06:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X6NNWrL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfDYG6E (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:58:04 -0400
Received: from mail-eopbgr790050.outbound.protection.outlook.com ([40.107.79.50]:40475
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725970AbfDYG6D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Apr 2019 02:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0qV9vlD4xm4ZshGXZucDsmzsZQ8oSpjxNyeHtIW7rg=;
 b=X6NNWrL99HmyA8qo0JGDDypcW4xNhSsIFlXYU/+FdTj+6IV8jOHlergG+lkKWMEicyIu2V3KL0OAwvuhwd3Zdow0siIx5ll/py1VlfxGXUCaPwv3zfaBdOwSjGD39m/maCXEfBcaAEVi72Cq2YZHG/54yAK5liAQWyM1sp2zQEo=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB2440.namprd12.prod.outlook.com (52.132.141.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Thu, 25 Apr 2019 06:57:58 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::70fc:f26c:1e22:73ba]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::70fc:f26c:1e22:73ba%10]) with mapi id 15.20.1835.010; Thu, 25 Apr
 2019 06:57:58 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Paul Mackerras <paulus@samba.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        "open list:AMD KFD" <dri-devel@lists.freedesktop.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        "open list:8169 10/100/1000 GIGABIT ETHERNET DRIVER" 
        <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 5/9] drm/amdkfd: use helper pci_dev_id
Thread-Topic: [PATCH v2 5/9] drm/amdkfd: use helper pci_dev_id
Thread-Index: AQHU+tJqN6rnfclWa0ObxfBB+As4QqZMcr0A
Date:   Thu, 25 Apr 2019 06:57:58 +0000
Message-ID: <60b20405-8876-5e9d-0a81-b3df4ee6a87a@amd.com>
References: <2e1f9a57-6d08-d017-24da-3e6b97fa2449@gmail.com>
 <50613002-d5a2-2522-b183-4ab156686fce@gmail.com>
In-Reply-To: <50613002-d5a2-2522-b183-4ab156686fce@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM0PR02CA0014.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::27) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0581616-36bc-4275-de80-08d6c94b597e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB2440;
x-ms-traffictypediagnostic: DM5PR12MB2440:
x-microsoft-antispam-prvs: <DM5PR12MB24407CFE6229E31C17130222833D0@DM5PR12MB2440.namprd12.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(136003)(39860400002)(199004)(189003)(81166006)(5660300002)(102836004)(186003)(6116002)(6486002)(64756008)(65806001)(256004)(66476007)(66556008)(65956001)(64126003)(6246003)(478600001)(4326008)(2906002)(53936002)(229853002)(36756003)(68736007)(31686004)(66446008)(6512007)(72206003)(76176011)(81156014)(14454004)(66946007)(6506007)(71200400001)(71190400001)(65826007)(52116002)(8676002)(11346002)(99286004)(46003)(7416002)(86362001)(386003)(446003)(486006)(97736004)(2616005)(7736002)(31696002)(4744005)(110136005)(58126008)(6436002)(54906003)(305945005)(316002)(476003)(73956011)(25786009)(8936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2440;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W9iukjP/SAPyj2DlF/0jrxbYj0A+u+nJYbZICWfg4/dyLk6mw7KvCA+ZBxiyY++GLDut6OHDxFWf1LfIHi4YcL4Ef4EVwn91B639g3Ri42BpNQ/pVXJSmBOL89d3Tsn62x9umHdoLS53wSqp1aqETlG+c9Mtzfh2sJOSZLYJ0SMchuOStbrFyGGDrtflorV1IkjQzchWoyyPeWZTAf2hbZiVA6z61RJ6NriVzVYuKhMDF50cA8bMto/3Gp9N6O/jI0EMeB+zgRtbGwpJSPuw1udX/gYgkqdSx5dC6Y+5RUiGWutRJbBt4q9uSFYfWPhuKTwYFfV+CwV3xdHKorKMPFp9RqvPUk2/NFeBVzVywc0uBGhkyU+Hi4/XQcETG7G+eq9C6wT6NoU6UVfiDgIm4r2kaHjbMNcX3Ks5SXObuW4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F36A8201B3B6F94F8F611443161D8B87@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0581616-36bc-4275-de80-08d6c94b597e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 06:57:58.9287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QW0gMjQuMDQuMTkgdW0gMjE6MTQgc2NocmllYiBIZWluZXIgS2FsbHdlaXQ6DQo+IFVzZSBuZXcg
aGVscGVyIHBjaV9kZXZfaWQoKSB0byBzaW1wbGlmeSB0aGUgY29kZS4NCj4NCj4gU2lnbmVkLW9m
Zi1ieTogSGVpbmVyIEthbGx3ZWl0IDxoa2FsbHdlaXQxQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6
IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCg0KPiAtLS0NCj4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYyB8IDMgKy0tDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYw0KPiBpbmRleCAyY2IwOWUwODgu
Ljc2OWRiYzdiZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3RvcG9sb2d5LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9s
b2d5LmMNCj4gQEAgLTEyNzIsOCArMTI3Miw3IEBAIGludCBrZmRfdG9wb2xvZ3lfYWRkX2Rldmlj
ZShzdHJ1Y3Qga2ZkX2RldiAqZ3B1KQ0KPiAgIA0KPiAgIAlkZXYtPm5vZGVfcHJvcHMudmVuZG9y
X2lkID0gZ3B1LT5wZGV2LT52ZW5kb3I7DQo+ICAgCWRldi0+bm9kZV9wcm9wcy5kZXZpY2VfaWQg
PSBncHUtPnBkZXYtPmRldmljZTsNCj4gLQlkZXYtPm5vZGVfcHJvcHMubG9jYXRpb25faWQgPSBQ
Q0lfREVWSUQoZ3B1LT5wZGV2LT5idXMtPm51bWJlciwNCj4gLQkJZ3B1LT5wZGV2LT5kZXZmbik7
DQo+ICsJZGV2LT5ub2RlX3Byb3BzLmxvY2F0aW9uX2lkID0gcGNpX2Rldl9pZChncHUtPnBkZXYp
Ow0KPiAgIAlkZXYtPm5vZGVfcHJvcHMubWF4X2VuZ2luZV9jbGtfZmNvbXB1dGUgPQ0KPiAgIAkJ
YW1kZ3B1X2FtZGtmZF9nZXRfbWF4X2VuZ2luZV9jbG9ja19pbl9taHooZGV2LT5ncHUtPmtnZCk7
DQo+ICAgCWRldi0+bm9kZV9wcm9wcy5tYXhfZW5naW5lX2Nsa19jY29tcHV0ZSA9DQoNCg==
