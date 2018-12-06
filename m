Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B3FC04EB8
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 12:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1528208E7
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 12:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="P48f+HEH";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="fPq9Z7d+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1528208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbeLFMBP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:01:15 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:36444 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728144AbeLFMBO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Dec 2018 07:01:14 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB6Bvdl1003816;
        Thu, 6 Dec 2018 04:00:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=KYEbDip+LbBP/poKXNCZwsAw5u8KLKsB3Snqmwpqtgk=;
 b=P48f+HEHK4nT0czKUINNSG4AE/RU+NF323VoJ+15ugn0bstOP43mz4rLr0Q2S67t7Znp
 X9EfB33VPbZQXzEpvURDOYlzUZSD5QUSODvfs4wzCw7G2xtPs4AvN5SbGSxfYKnY0Z6p
 XGvDvE3rRkftIK3eSOXib31zg7axxHoi4/fHq5spnT6AM4NSiFTQj6eKCfdhxiUdZWnY
 hy7igdNwhGUHT12XczsBt270LcUDYJ7fE84QApEsGR7ysbLC2ch3JXY3sOM7xKEmKS9G
 3b0bmrlg0vdzyu+Dxat3qG5m2nkmXDnAZdDadJ2hmrftbD97zB/Coj0aS0Os7zOF4eAS HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2p737u81cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Dec 2018 04:00:54 -0800
Received: from m0042385.ppops.net (m0042385.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id wB6BwVDx005009;
        Thu, 6 Dec 2018 04:00:53 -0800
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2059.outbound.protection.outlook.com [104.47.42.59])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2p737u81cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 06 Dec 2018 04:00:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYEbDip+LbBP/poKXNCZwsAw5u8KLKsB3Snqmwpqtgk=;
 b=fPq9Z7d++SSIm32SCVo2IE7XNlyuAyvLd0whbSqql/VXP7JX/LdInk6xEXLUmHaDya/Ov38fWyDRN4ryfQorhG+88r6o26OgmASEpDwLNeX0xiNSe49go61+Ke7ca2uhr8dGXP90mlkPbY0vetivAheAZ1D0ShXHRLsTygWB+jc=
Received: from MWHPR07MB3502.namprd07.prod.outlook.com (10.164.192.29) by
 MWHPR07MB2782.namprd07.prod.outlook.com (10.169.237.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Thu, 6 Dec 2018 12:00:50 +0000
Received: from MWHPR07MB3502.namprd07.prod.outlook.com
 ([fe80::70e2:ccd9:2baf:68f9]) by MWHPR07MB3502.namprd07.prod.outlook.com
 ([fe80::70e2:ccd9:2baf:68f9%5]) with mapi id 15.20.1382.024; Thu, 6 Dec 2018
 12:00:50 +0000
From:   Alan Douglas <adouglas@cadence.com>
To:     Wen Yang <wen.yang99@zte.com.cn>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhong.weidong@zte.com.cn" <zhong.weidong@zte.com.cn>,
        Bob Copeland <me@bobcopeland.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: RE: [PATCH] PCI: endpoint: functions: Use kmemdup instead of
 duplicating its function
Thread-Topic: [PATCH] PCI: endpoint: functions: Use kmemdup instead of
 duplicating its function
Thread-Index: AQHUjU2PiCR+5hvyDU6PPfEeCbv436Vxm41w
Date:   Thu, 6 Dec 2018 12:00:50 +0000
Message-ID: <MWHPR07MB350216ECF82E2730CF87A7D2D8A90@MWHPR07MB3502.namprd07.prod.outlook.com>
References: <20181206102105.53098-1-wen.yang99@zte.com.cn>
In-Reply-To: <20181206102105.53098-1-wen.yang99@zte.com.cn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWRvdWdsYXNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy05Mjc3MzM4Zi1mOTRlLTExZTgtYWI4Zi1hNDRjYzg0ZTk5NTlcYW1lLXRlc3RcOTI3NzMzOTEtZjk0ZS0xMWU4LWFiOGYtYTQ0Y2M4NGU5OTU5Ym9keS50eHQiIHN6PSIxODI4IiB0PSIxMzE4ODU3MTI1MDUwMDcyMDQiIGg9InBtaDdxMkwrSFdjaVRKa3ZtcE5iYXMzcTJhZz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR07MB2782;20:RhHPsn/DS2416yh7FMlz3/AqNTdsAgn307QkJCHUsGRFmEEvQnyPRCP8B6qrEHbE8pbb/iSxO+cug/4dl6SJGtqYhM2Oct9122A9ldGII0n8E/XizbTJA0mn+A2fDs8TFllU4Q0PnOMtgC+LYOL05l/gxPbTQFOUCpRlXNFHCwJiLUBOzYyQb30bPLFciqDO5H04LpWTZziLpK9cKPvw5fzP1q7isOM/cJ46YD4O9ut4ZFqab+/7LBOcTTOe/VBa
x-ms-office365-filtering-correlation-id: ec573c95-ba8a-4106-7319-08d65b72774d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR07MB2782;
x-ms-traffictypediagnostic: MWHPR07MB2782:
x-microsoft-antispam-prvs: <MWHPR07MB2782A9F86C109635C0540186D8A90@MWHPR07MB2782.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:MWHPR07MB2782;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB2782;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39860400002)(376002)(366004)(189003)(199004)(36092001)(478600001)(97736004)(55016002)(305945005)(7736002)(74316002)(6116002)(3846002)(5660300001)(9686003)(7416002)(86362001)(105586002)(6436002)(106356001)(68736007)(54906003)(110136005)(316002)(99286004)(26005)(76176011)(186003)(102836004)(53546011)(4326008)(6246003)(2906002)(6506007)(53936002)(33656002)(7696005)(14454004)(81156014)(81166006)(256004)(8936002)(476003)(486006)(8676002)(25786009)(66066001)(229853002)(71200400001)(11346002)(446003)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB2782;H:MWHPR07MB3502.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XPmXlimpEm85lV7MH87d+YKX6NU0ix5iMnDdg2735n2AjNtA3CQ0NfUf1JscuTR3T8b8W7qLbuXHwMHRhgJijvS6J4qimlJMsFgq+0UEnjak9zxrHHV9Hq7sA/39NBGqHxPP5B/ZyPnm53dJu8mWuZjAk9fNODGC7kuyEI11La8GlLvzczwXe4nZJyh9lwnV0ekqFZpS8Yva7Ruanllmv3g4RJMCEg5Fx2AYNAcZC6+MGQ0hnoOr1B5g9sH292LS8lD+oYQnop9O2MlpFq0KkJT+pzL5/BJNC3bktsKWKuoh+pnBg1FpUpiX/2dJjzNLnKJZBpJ+VfuBjr5m7KbTm3o9KJeuyKrcyQ/rr9Zn/2M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec573c95-ba8a-4106-7319-08d65b72774d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 12:00:50.3996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB2782
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812060107
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksDQoNCk9uIDA2IERlY2VtYmVyIDIwMTggMTA6MjEsIFdlbiBZYW5nIHdyb3RlOg0KPiBrbWVt
ZHVwIGhhcyBpbXBsZW1lbnRlZCB0aGUgZnVuY3Rpb24gdGhhdCBrbWFsbG9jKCkgKyBtZW1jcHko
KS4NCj4gV2UgcHJlZmVyIHRvIGttZW1kdXAgcmF0aGVyIHRoYW4gY29kZSBvcGVuZWQgaW1wbGVt
ZW50YXRpb24uDQo+IA0KPiBUaGlzIGlzc3VlIHdhcyBkZXRlY3RlZCB3aXRoIHRoZSBoZWxwIG9m
IGNvY2NpbmVsbGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBXZW4gWWFuZyA8d2VuLnlhbmc5OUB6
dGUuY29tLmNuPg0KPiBDQzogQm9iIENvcGVsYW5kIDxtZUBib2Jjb3BlbGFuZC5jb20+DQo+IA0K
PiBDQzogS2lzaG9uIFZpamF5IEFicmFoYW0gSSA8a2lzaG9uQHRpLmNvbT4NCj4gQ0M6IExvcmVu
em8gUGllcmFsaXNpIDxsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tPg0KPiBDQzogQmpvcm4gSGVs
Z2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4gQ0M6IEd1c3Rhdm8gUGltZW50ZWwgPGd1c3Rh
dm8ucGltZW50ZWxAc3lub3BzeXMuY29tPg0KPiBDQzogTmlrbGFzIENhc3NlbCA8bmlrbGFzLmNh
c3NlbEBheGlzLmNvbT4NCj4gQ0M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91
bmRhdGlvbi5vcmc+DQo+IENDOiBDeXJpbGxlIFBpdGNoZW4gPGN5cmlsbGUucGl0Y2hlbkBmcmVl
LWVsZWN0cm9ucy5jb20+DQo+IENDOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIChvcGVuIGxp
c3Q6UENJIEVORFBPSU5UIFNVQlNZU1RFTSkNCj4gQ0M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcgKG9wZW4gbGlzdCkNCj4gLS0tDQo+ICBkcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlv
bnMvcGNpLWVwZi10ZXN0LmMgfCA0ICstLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9lbmRw
b2ludC9mdW5jdGlvbnMvcGNpLWVwZi10ZXN0LmMgYi9kcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5j
dGlvbnMvcGNpLWVwZi10ZXN0LmMNCj4gaW5kZXggM2U4NmZhM2M3ZGEzLi42ZTQyZGFhMmE2NTEg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXRl
c3QuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi10ZXN0
LmMNCj4gQEAgLTE2OSwxNCArMTY5LDEyIEBAIHN0YXRpYyBpbnQgcGNpX2VwZl90ZXN0X3JlYWQo
c3RydWN0IHBjaV9lcGZfdGVzdCAqZXBmX3Rlc3QpDQo+ICAJCWdvdG8gZXJyX2FkZHI7DQo+ICAJ
fQ0KPiANCj4gLQlidWYgPSBremFsbG9jKHJlZy0+c2l6ZSwgR0ZQX0tFUk5FTCk7DQo+ICsJYnVm
ID0ga3phbGxvYyhzcmNfYWRkciwgcmVnLT5zaXplLCBHRlBfS0VSTkVMKTsNCkxvb2tzIGxpa2Ug
YSB0eXBvIC0ga21lbWR1cCBpbnN0ZWFkIG9mIGt6YWxsb2M/DQoNCj4gIAlpZiAoIWJ1Zikgew0K
PiAgCQlyZXQgPSAtRU5PTUVNOw0KPiAgCQlnb3RvIGVycl9tYXBfYWRkcjsNCj4gIAl9DQo+IA0K
PiAtCW1lbWNweShidWYsIHNyY19hZGRyLCByZWctPnNpemUpOw0KPiAtDQo+ICAJY3JjMzIgPSBj
cmMzMl9sZSh+MCwgYnVmLCByZWctPnNpemUpOw0KPiAgCWlmIChjcmMzMiAhPSByZWctPmNoZWNr
c3VtKQ0KPiAgCQlyZXQgPSAtRUlPOw0KPiAtLQ0KPiAyLjE5LjENCg0KUmVnYXJkcywNCkFsYW4N
Cg0K
