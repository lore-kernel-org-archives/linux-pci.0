Return-Path: <SRS0=VxNY=NN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A7AC0044C
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 00:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886F620820
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 00:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="cv8p8xQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886F620820
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbeKBJ20 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Nov 2018 05:28:26 -0400
Received: from mail-eopbgr710117.outbound.protection.outlook.com ([40.107.71.117]:53640
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728147AbeKBJ20 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Nov 2018 05:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbQKVVtWxMcpAmaJA1qewoPnEqwZgPgfzdktRuStPrI=;
 b=cv8p8xQVGK1KkQhcLOGEYRYnHYcA0yEp1ywXFSdh8chkGWTE1ENb5DwqyOPdFzQP8oME2sHs5UNG8aOcLPWy0DSrUapLkEPn/nCGyyu44xSFjUN6sY3Ighwf+i1n9Kttt8FqoCrinqNthj7dGbD/SPqRHanQep5aaf0cW2aMvHM=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3707.namprd06.prod.outlook.com (10.167.236.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.25; Fri, 2 Nov 2018 00:23:12 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.024; Fri, 2 Nov 2018
 00:23:12 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI: imx6: Check for link training status in link up
 check
Thread-Topic: [PATCH v2] PCI: imx6: Check for link training status in link up
 check
Thread-Index: AQHUcVLn2SF+98WimEGV8p2vodBEpqU68nMAgACvYIA=
Date:   Fri, 2 Nov 2018 00:23:12 +0000
Message-ID: <1541118191.30311.206.camel@impinj.com>
References: <20181031194944.19233-1-tpiepho@impinj.com>
         <20181101135530.GA8020@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181101135530.GA8020@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3707;6:GJrpu9VFsVp6OjiG6CxSmYjiI4ucSI0+h+baeCLNZzNKisxzo/SI1RPyGNgEnHIibEaEj4lceg99d9phZbqxXBshaCHFZiRPXUoY/0Gww1a27bLJj7UQm1yX7vhXnePQkkCNdDBS1yep4oMxZTAuLcPhDhYvAvDsNE8hTtjVBmJWBGiT+l8RSjHQ/pzqcqeJeAFO8hvi/c081SvXI5V5Xb++ndU2OF3ORFa8p7C00/uHW96UClWJxn9pOA5VW8i1Fs1awCNUmqKsHlBxu1Een+KZzR5iQfPAgL9k1bmLyJ3mOdK5Rj49QKkswzbLEkE5G4t2TlP5G4F3UTYw8nxq3/wmDcQ4nvVBZXAoLdSLs7np3Po3ggRYIYdH3h7YV3E8xOftWew2oFVLb9pQ0+3qJlI4jCNX9Cc0yqwNE17MBg/k7jyAM8n+ofmhRW+EzuQE5uR2N3+arq36wQtXRcab0A==;5:3r9hCHnwaUnWj1ecS7JOdWkeqNL9PJhK8OYUcaKKtTXeeiHlLF+kr8Q7kmmDyJ9YgEQW29hym2fAqmWxj4v7i1DAvqQaVdp19NEHtRx3tgsxS5uU1wLlKZXSo/A103SBZJ8Qh3MaF69MEAs6gIIMdi9eVr959yUSXOv7eqbIpwM=;7:xxsTX5fpdIZPp1gKegiJ0WCdHGVQJd/+azVueZUpfwiIryWnL5KA9RZmyLMHYUxEA28s2DNciAemnOq0aNJdSXgYFNCVEUURYGpTD3YDvAPbaZblisQsoBJxF23SQ30iXToTUULvNL/phMNlj7UvZg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: dd8fe3e0-9b63-4413-cabb-08d640595fd5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3707;
x-ms-traffictypediagnostic: MWHPR0601MB3707:
x-microsoft-antispam-prvs: <MWHPR0601MB370702E3D9FBA9773DAE1E64D3CF0@MWHPR0601MB3707.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(190756311086443);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231382)(944501410)(52105095)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3707;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3707;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39840400004)(366004)(346002)(396003)(376002)(189003)(199004)(2351001)(8936002)(25786009)(6916009)(3846002)(68736007)(103116003)(6512007)(6116002)(6506007)(8676002)(102836004)(54906003)(316002)(26005)(229853002)(81166006)(5640700003)(53936002)(81156014)(2906002)(4326008)(6486002)(6246003)(66066001)(71200400001)(71190400001)(86362001)(5660300001)(6436002)(99286004)(14454004)(2616005)(476003)(97736004)(11346002)(446003)(305945005)(7736002)(2900100001)(106356001)(256004)(76176011)(186003)(36756003)(105586002)(486006)(2501003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3707;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0uT16XcmkbP4h3ASsLgrpyL0dDoe7mG1RUDYVpcuNI8veOKxLKITDchPqVaf7A79E4PLqgEkwDzzbN8osRgczHy+yQ8/gpQsIQ3HJymG5+TVvJDfUZgAAm9NH71WFtVpZkNLFYXqX4s4LlXruT2BUF6qEEJDC7DEY2vJRjfmGCny4rSCbNI+TbuiMZeOD1iaR1rsJwxPyvpxcn47Rip+6JndKboBI1AkNWS3zUONh02qi8PhDmMANjCxZw7pq9VU4YtYB68reYOTj/qERGVbRzyGApnTQ0dEUN0u29a2TT8qtN/RWwOOfNAZ+MqzDQ3nZjgQ8Bdob+5XUrjkZWD5Pmvj8lO4pMqSQP9ZYmICWaE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <16C5BE82BBED2B4590FC408962E35E02@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8fe3e0-9b63-4413-cabb-08d640595fd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 00:23:12.1525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3707
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE4LTExLTAxIGF0IDEzOjU1ICswMDAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gV2VkLCBPY3QgMzEsIDIwMTggYXQgMDc6NDk6NTlQTSArMDAwMCwgVHJlbnQgUGll
cGhvIHdyb3RlOg0KPiA+IFRoaXMgZml4ZXMgYSByZWdyZXNzaW9uIGludHJvZHVjZWQgaW4gbWVy
Z2UgNTYyZGY1Yzg1MjFlLg0KPiANCj4gQSBtZXJnZSBiZWluZyBhIGNvbW1pdHMgY29sbGVjdGlv
biwgdGhlIHJlZ3Jlc3Npb24gd2FzIGNlcnRhaW5seQ0KPiBpbnRyb2R1Y2VkIGJ5IGEgc3BlY2lm
aWMgY29tbWl0IGluIGl0LCBub3QgdGhlIG1lcmdlIGl0c2VsZi4NCg0KSW4gdGhpcyBjYXNlIGl0
IHJlYWxseSBpcyBtZXJnZSBjb21taXQuDQoNCldoaWxlIHRoZSBwcm9ibGVtIGFuZCBmaXggYXJl
IHJlbGF0aXZlbHkgb2J2aW91cywgZmluZGluZyBob3cgaXQgY2FtZQ0KdG8gYmUgYnJva2VuIHdh
cyBhIGNoYWxsZW5nZS4gIE1vc3Qgb2YgdGhlIGNvbW1pdCBtZXNzYWdlIGlzIG15IHByb29mDQp0
aGF0IHRoaXMgaXMgYSBidWcgYW5kIG5vdCBzb21ldGhpbmcgZG9uZSBpbnRlbnRpb25hbGx5LCBi
eSB0cmFja2luZw0KYmFjayB0aGUgY29tcGxpY2F0ZWQgcm91dGUgdGhhdCBjYXVzZWQgdGhlIGNv
ZGUgdG8gYmUgaW4gaXRzIGN1cnJlbnQNCnN0YXRlLg0KDQpCYXNpY2FsbHkgdGhlcmUgYXJlIHR3
byBjb21taXRzLCBvbiBib3RoIGJyYW5jaGVzIG9mIHRoZSBtZXJnZSwgbmVpdGhlcg0Kb2Ygd2hp
Y2ggY2F1c2VkIGEgcHJvYmxlbSBub3Igd2VyZSB0aGV5IGluY29ycmVjdCBpbiBhbnkgd2F5IGF0
IHRoZQ0KdGltZSB0aGV5IHdlcmUgY29tbWl0dGVkLiAgV2hlbiB0aGF0IG1lcmdlIGNvbWJpbmVk
IHRoaXMgY29sbGVjdGlvbiBvZg0KbXVsdGlwbGUgY29tbWl0cywgaXQgZGlkIG5vdCBkbyBzbyBj
b3JyZWN0bHkgYW5kIHRoYXQgaXMgdGhlIHBvaW50IGENCmJ1ZyBhcHBlYXJlZC4NCg0KT3IgcHV0
IGFub3RoZXIgd2F5LCB0aGlzIHByb2JsZW0gd2FzIGFscmVhZHkgZml4ZWQgc29tZSB0aW1lIGFn
bywgYnV0DQppbiB0aGUgbWVyZ2UgY29tbWl0IHRoZSBmaXggd2FzIGRyb3BwZWQuDQoNCkl0IHNl
ZW1zIGxpa2UgdGhlIHByb3BlciB3YXkgdG8gYXR0cmlidXRlIG15IGZpeCBpcyB0byB0aGUgbWVy
Z2UsIGFzDQp0aGF0IGlzIHdoYXQgY2F1c2VkIHRoZSByZWdyZXNzaW9uLiAgVGhlcmUgaXMgbm8g
cHJpb3IgY29tbWl0IHdoZXJlIG9uZQ0KY2FuIG9ic2VydmUgdGhlIHJlZ3Jlc3Npb24uDQoNCj4g
QWxzbyBmb3IgdGhlIEZpeGVzOiB0YWcgYW5kIGFsbCByZWZlcmVuY2VzLg0KDQpXb3VsZCBpdCBi
ZSBvayB0byByZWZlciB0byB0aGUgY29tbWl0IHRoaXMgd2F5IHRoZSBmaXJzdCB0aW1lLCB0aGVu
IHVzZQ0KYSBzaG9ydGVuZWQgbWV0aG9kIGZvciBzdWJzZXF1ZW50IHVzYWdlcz8gIE90aGVyd2lz
ZSB0YWxraW5nIGFib3V0IHR3bw0KY29tbWl0cyBiZWNvbWVzIHZlcnkgbG9uZy4gIFRoaXMgaXQg
d2hhdCBJIGhhdmUgbW9zdGx5IGRvbmUsIG90aGVyIHRoYW4NCnRoZSAiRml4ZXMiIGxpbmUuICBJ
J20gc3VycHJpc2VkIGNoZWNrcGF0Y2ggZGlkbid0IGNhdGNoIHRoYXQuDQo=
