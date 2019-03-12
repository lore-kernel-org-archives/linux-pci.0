Return-Path: <SRS0=lIFx=RP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9ECC43381
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 04:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52F9214AF
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 04:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cqVNwX2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbfCLEm0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Mar 2019 00:42:26 -0400
Received: from mail-eopbgr140054.outbound.protection.outlook.com ([40.107.14.54]:15220
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbfCLEm0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Mar 2019 00:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgPZQRYYgq1tUDCJ0ITOpoSuoCFvtlzNBuIhiY4cz0s=;
 b=cqVNwX2vxY2/z/YHXE3LFfNq7v+dibMCe3Y6cV7ibfPaTRiRMCMtk1nkf3nbxIitvZZaBvpkWlmpjHEMNCvN/kCh2etbBZovnAuqYVniuQKuYVdIjZvZ77IZhOS7TBcpGqZJJ2LsyGk4US+5kCWtAUgdfCShvwt4T9I2VJECOGc=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4997.eurprd04.prod.outlook.com (20.177.33.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.20; Tue, 12 Mar 2019 04:42:19 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 04:42:19 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>
Subject: RE: [PATCHv4 10/28] PCI: mobiveil: fix the INTx process error
Thread-Topic: [PATCHv4 10/28] PCI: mobiveil: fix the INTx process error
Thread-Index: AQHU1+0si14PzdOFlUat22euDKg75aYGd9SAgADz9gA=
Date:   Tue, 12 Mar 2019 04:42:19 +0000
Message-ID: <AM6PR04MB57814BDE85B6A51ABF4FD80384490@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
 <20190311093130.7209-11-Zhiqiang.Hou@nxp.com>
 <20190311140803.GF214730@google.com>
In-Reply-To: <20190311140803.GF214730@google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [192.88.170.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b45fbd52-bf29-4dbd-0e76-08d6a6a51c77
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4997;
x-ms-traffictypediagnostic: AM6PR04MB4997:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtBTTZQUjA0TUI0OTk3OzIzOktKcG1vTHYyUDVjVVJiRnF1ZDl6QTFCTDdk?=
 =?gb2312?B?VDdETnRWWkxGLzM4dGZHQUdjVmUwOWk5M3h6QmxTVWc4Uy9wWjNkdnVnWXk5?=
 =?gb2312?B?UjFmbmJJTTNEaUltRzNRM24vZGxjYVNxaDY0Z1Z6KzZmMUJtbS92RnpDaXlU?=
 =?gb2312?B?YjltVHIyMStmU2R3Yzg4ak5lT1dTak45MTBHdE5zbmphVC83bFloWVViNExV?=
 =?gb2312?B?YnAzYTMxMUZBWGYwc014ZmQzaDNWSnU5N0xSaTQwV2FDVDZVcnY0L01LMXZl?=
 =?gb2312?B?cVMvVStJSjA3LzQ5K0NCN0RXTzZaalFLQmxiUUdyME5ENVc5aCs4WnR3d3pY?=
 =?gb2312?B?d1pxSnFsdnlLQld1ZTFieFVobkw3M3BvbVVIRExxeFhrU2U2cUllckxhMlBQ?=
 =?gb2312?B?UG1vT2dvL0U1WGQ1OXo3TWRPVUcycWtMZjZqNGN1TTBJSGdQT3FBbG51MUJB?=
 =?gb2312?B?ZUVxNXdTaUdrbC92eW9INm9KVUtYL0tqeWZyb3lpZGJSeVovSU1RZ0x4MlFI?=
 =?gb2312?B?Z2VDbUNwZktzMnJsWWxJT3hpY1hmeldWbUhobjNodENWRWxhYW1ncEJBbi9x?=
 =?gb2312?B?Q1VMU0dYQ3BlY0VzZEllSXVVdTJHNGkrUlVnbTFnMGZGenVsK0Jqc3hQNjVm?=
 =?gb2312?B?SVlQMjJZVi8yV2RQdEYrcDF4ZlZPYjFGSzN1MHR3dC9FK3BpeXZTUmwrWWZ4?=
 =?gb2312?B?V3BJa0JNL1ZJR29WUDRPYjVlQlpkZzUwSlE2aEdtdEhheEd6clBmVDArZll0?=
 =?gb2312?B?Sytpb09GN0M3akUzYzRsWjBib0ZtQUduSXI2L1ZVdEY2OUNKZ2JPSEgxbFEx?=
 =?gb2312?B?MnlVRTgrODFNODZtMVZuY3ZZOEhVVjZEcG5BcFhpZVRSSytsejVDWXpvR09B?=
 =?gb2312?B?MlA4bHg0bDYydDNwRE4zRkorS2YrODc0WGZJcWtEdmN3Qkw2eUFUQitaOFVv?=
 =?gb2312?B?U2N6S1UxSFFWMi9KZUhGQkVDaVk4ZUZrUmdSTlhHMFZOYzJwMXFHNzQ4ZTI4?=
 =?gb2312?B?TjBIcmtNVytJTHMrOHdQcUMyMHhYNlVZc3dUYUJkczdLYzVJNU5hTk45Zk51?=
 =?gb2312?B?WU50ZTlSS1kzd1ZuSml6cG5mNlozbm4zdlg3akdhM1JZbVgyWXdRMTExSEg5?=
 =?gb2312?B?U293cUlYRWl1OVpmdHJHdzBBVnhMYTk5cVZ5c0w2M2ZlNFhmYVV2aDF4d21H?=
 =?gb2312?B?c3JONEl1QW9pMnFkbGV5bEJMZ0RCb0ZJdTlEZHI3a1NDNU1Pbk4zbm9XdFMv?=
 =?gb2312?B?cHhGQmVGQ3pGekwvQU9Tb3lBVUlmZW4wVnpyYWRuQ3A2NWVKZjU4eDIyTWcr?=
 =?gb2312?B?cTljUncwRUxMUFpqM2EzSm9UUGcrNy9FSytsbjh0cVNNMldzVExKMDRzaENF?=
 =?gb2312?B?MWdhN1VlZzhwMlorYmUxUDY0ak1QSGRQcXQwWnMxb3dWRkpOZ2xFL21nSHJu?=
 =?gb2312?B?RFRKbloyaG82Z2RrclZaTEQrY200N0lpVld3WkZBbENzeCtrOU5lQmp5cFBo?=
 =?gb2312?B?UHlYL2k0elhnYXZWU01VSCswM1pFRXhUa0pzS1RMcHhEVHN6NU0vVEJRU3FW?=
 =?gb2312?B?Y0tsSFBpUW9RQ3lOWXBPdXpUZkJ4RFBZWERkcjdrZzBWcnVsVmdVQmdzR3lk?=
 =?gb2312?B?N2RNV2crdko0M2FzS2E2dk5OY2tZQWgra2tISU1jaFB0RVpsN0ZMTTVma3VZ?=
 =?gb2312?Q?wxi7UJA+KYA9Dk0Z92IARq++gq9WRU8PEUMCZbi?=
x-microsoft-antispam-prvs: <AM6PR04MB4997033D60172E36BED0AAD484490@AM6PR04MB4997.eurprd04.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(396003)(39860400002)(346002)(13464003)(189003)(199004)(5660300002)(6506007)(52536013)(53546011)(186003)(229853002)(6436002)(6116002)(102836004)(68736007)(81156014)(3846002)(81166006)(71190400001)(66066001)(86362001)(71200400001)(99286004)(9686003)(256004)(105586002)(106356001)(8676002)(316002)(55016002)(54906003)(26005)(486006)(53936002)(76176011)(14454004)(8936002)(33656002)(478600001)(2906002)(74316002)(6246003)(7736002)(7696005)(446003)(97736004)(305945005)(11346002)(4326008)(25786009)(7416002)(476003)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4997;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: D16n7ag3mN0OFLdj3u8Ggsb9oWUAtIScSVyK9U+1adbIwKazJnpzEptuOnBW+Jp+p+MMJZbPJQxCfEaKOa9QEBiguD2dqhJIGgGER6PKIRwT/cvFSuz87QZTZx72yImYK7G2Q9gxvggGZ5HvkRko/UmgydfLfnTvpZhxLlLKKz0AJ50FFvO4iLShoUEWS8PQ5h5L10AgCToY+6GCrB70CPgRrWqC8ush3dAhzz9r6W7+u48Y6b2nZ4N6gcSYac+3PA7lfq59a4Gp4d+D8RR2SHFAzE+zrQT/krfAogCdZHagoK0GyCEwANjrnoxO+JDYkjSStXGcE71JhRCX3I1KPzmH+s6Qx2lVj+IFo+IuIK7dji/g2C2Ad+kDzWO2MriWsr7d/3nhT+Qp08rpCr+5c7c1J7lLYHSz+QnPpfCsmgk=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45fbd52-bf29-4dbd-0e76-08d6a6a51c77
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 04:42:19.6522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4997
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cyENCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIFttYWlsdG86aGVsZ2Fh
c0BrZXJuZWwub3JnXQ0KPiBTZW50OiAyMDE5xOoz1MIxMcjVIDIyOjA4DQo+IFRvOiBaLnEuIEhv
dSA8emhpcWlhbmcuaG91QG54cC5jb20+DQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiByb2JoK2R0QGtl
cm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBsLnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNv
LmluOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47
DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0K
PiB3aWxsLmRlYWNvbkBhcm0uY29tOyBNLmguIExpYW4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47
IFhpYW93ZWkgQmFvDQo+IDx4aWFvd2VpLmJhb0BueHAuY29tPjsgTWluZ2thaSBIdSA8bWluZ2th
aS5odUBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjQgMTAvMjhdIFBDSTogbW9iaXZl
aWw6IGZpeCB0aGUgSU5UeCBwcm9jZXNzIGVycm9yDQo+IA0KPiBPbiBNb24sIE1hciAxMSwgMjAx
OSBhdCAwOTozMToxNkFNICswMDAwLCBaLnEuIEhvdSB3cm90ZToNCj4gPiBGcm9tOiBIb3UgWmhp
cWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+DQo+ID4gSW4gdGhlIGxvb3AgYmxvY2ss
IHRoZXJlIGlzIG5vdCBjb2RlIGNoYW5nZSB0aGUgbG9vcCBrZXksIHRoaXMgcGF0Y2gNCj4gPiB1
cGRhdGVkIHRoZSBsb29wIGtleSBieSByZS1yZWFkIHRoZSBJTlR4IHN0YXR1cyByZWdpc3Rlci4N
Cj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWxzbyBjaGFuZ2UgdG8gY2xlYXIgdGhlIGhhbmRsZWQgSU5U
eCBzdGF0dXMuDQo+ID4NCj4gPiBOb3RlOiBOZWVkIE1WIHRvIHRlc3QgdGhpcyBmaXguDQo+ID4N
Cj4gPiBGaXhlczogOWFmNmJjYjExZTEyICgiUENJOiBtb2JpdmVpbDogQWRkIE1vYml2ZWlsIFBD
SWUgSG9zdCBCcmlkZ2UgSVANCj4gPiBkcml2ZXIiKQ0KPiANCj4gVGhlICJGaXhlczoiIGxpbmUg
c2hvdWxkIGJlIGFsbCBvbiBvbmUgbGluZSwgd2l0aG91dCBhIG5ld2xpbmUgaW4gdGhlIG1pZGRs
ZSwNCj4gZXZlbiBpZiBpdCBleGNlZWRzIDgwIGNvbHVtbnMuICBUaGF0J3MganVzdCB0byBtYWtl
IGl0IGVhc2llciBmb3IgcHJvZ3JhbXMgdG8NCj4gcGFyc2UgdGhlIGxvZ3MuDQoNCldpbGwgZml4
IGluIHY1Lg0KDQpUaGFua3MsDQpaaGlxaWFuZw0K
