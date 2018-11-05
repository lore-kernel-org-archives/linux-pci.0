Return-Path: <SRS0=Hm5h=NQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C97C0044C
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 23:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF7D21486
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 23:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VyVpfzeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF7D21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbeKFIyc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:54:32 -0500
Received: from mail-sn1nam02on0051.outbound.protection.outlook.com ([104.47.36.51]:4416
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbeKFIyc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 03:54:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVkSo+0m0EPIksFQQkzJRxOce/UlTQyp/3+SfnRfjE0=;
 b=VyVpfzeB2U7Elmair5wnVXCmMyXNFgNSqbcG3TU0D2W3TRFpnBv8HdgiuE79TpeGXmz+gE+zgQcbUf9qQ5/acU2Z8zpSR1QE4RkradK2itGsGOU9lEchH4HqkB8TeZB14ytAGEJWgUzeI3U4qkYJ2FyQABnUpE8rWdkGk850258=
Received: from CY4PR12MB1768.namprd12.prod.outlook.com (10.175.63.10) by
 CY4PR12MB1397.namprd12.prod.outlook.com (10.168.169.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Mon, 5 Nov 2018 23:32:17 +0000
Received: from CY4PR12MB1768.namprd12.prod.outlook.com
 ([fe80::82f:4b8a:fd43:aab3]) by CY4PR12MB1768.namprd12.prod.outlook.com
 ([fe80::82f:4b8a:fd43:aab3%8]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 23:32:16 +0000
From:   "Woods, Brian" <Brian.Woods@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Woods, Brian" <Brian.Woods@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <bhelgaas@google.com>, Pu Wen <puwen@hygon.cn>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/4] x86/amd_nb: add support for newer PCI topologies
Thread-Topic: [PATCH 2/4] x86/amd_nb: add support for newer PCI topologies
Thread-Index: AQHUctdtTs18UoG4rUKlKIFT94W0kqVBmJ8A//+qvQCAAHfggIAAHqSA
Date:   Mon, 5 Nov 2018 23:32:16 +0000
Message-ID: <20181105233212.GC27399@amd.com>
References: <20181102181055.130531-1-brian.woods@amd.com>
 <20181102181055.130531-3-brian.woods@amd.com>
 <20181105193840.GA26868@zn.tnic> <20181105203330.GB27399@amd.com>
 <20181105214233.GF26868@zn.tnic>
In-Reply-To: <20181105214233.GF26868@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0137.namprd05.prod.outlook.com
 (2603:10b6:803:2c::15) To CY4PR12MB1768.namprd12.prod.outlook.com
 (2603:10b6:903:122::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Woods@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1397;20:QNEewuDtLdzYK5iPEKaBr9dnVOf3iVCZ43AC16XmNyHvMWW6Cgiu1AHckdvhDUy9+biNW8CiuaU4idYVdXDcnZFQuIKiGXA+bKLzNfTJigO7JCmouLrrLlEMuO4Bl3WJlJc8yEJBjxYx9wh9nr7CDT3UuVGwA+J77HhCY0tAZJnWJaxDeuvROSU2fM6zRwoQ/qJVzpLCwl5ulrU35irc5RqKQrCHyzzUKNLJGVdV4MSN63O+xUpg7WuVclxZnu/T
x-ms-office365-filtering-correlation-id: 5e437898-d064-431a-27da-08d64376ebfa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1397;
x-ms-traffictypediagnostic: CY4PR12MB1397:
x-microsoft-antispam-prvs: <CY4PR12MB1397F811DCFA1FBA35B98023E5CA0@CY4PR12MB1397.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:CY4PR12MB1397;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1397;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(14444005)(256004)(8676002)(93886005)(102836004)(186003)(446003)(2900100001)(476003)(86362001)(11346002)(2616005)(6506007)(66066001)(81166006)(8936002)(81156014)(26005)(486006)(305945005)(7416002)(54906003)(316002)(7736002)(106356001)(105586002)(76176011)(52116002)(386003)(14454004)(71200400001)(68736007)(2906002)(71190400001)(6916009)(72206003)(478600001)(99286004)(36756003)(97736004)(229853002)(6246003)(6116002)(3846002)(5660300001)(1076002)(25786009)(6512007)(33656002)(6436002)(53936002)(4326008)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1397;H:CY4PR12MB1768.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +lC0O3sbGekeZ21VJwxrKKhYwvUcwqGR87oa3d7HrlDSWRj6ZL23DpOpQt8zN62BNoRCBSK9oDy9LM99UushsDyyhOZ9VvCTXQc5JXjX11SlrVnmrZ057cPLXq3NVLj91/+NhqGgwq9MtJtswDB+JdJZSDlQSYmNIblonxiVA09PuwpqoGt49VlX5Xr2RXFnldNuz7MSYTzO0e6myaON4ch+AO8UR+zav6sZvQvbx0gSbjOQPvKQQn/CQEB79T20w7a6vsNMTpLVXLnb2Ba/f/dBaM+mZcUq7KwvO6/GH0ktLuIMQFIR6ZgYG7rue15SLBznT3BP1jZJ2gvs9QAuxA+MUR/IohD0OiBEPYpjJgY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7E504987A545264D9697EBF47F59C3D9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e437898-d064-431a-27da-08d64376ebfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 23:32:16.7328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1397
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 05, 2018 at 10:42:33PM +0100, Borislav Petkov wrote:
> Yes please. Because this is the usual kernel coding style of calling a
> function (or a loop which has some result in this case) and testing that
> result immediately after the function call.

Done.

> You say "correct" as there is a special one. But the text before it says
> they're "functionally the same" wrt DF/SMN access so it sounds to me
> like we wanna map the first one we find and ignore the others.
>=20
> I.e., we wanna say
>=20
> "... so the DF/SMN interfaces get mapped to the *first* PCI root and the
> others N-1 ignored."
>=20
> Or am I misreading this?
>=20
> Thx.
>=20
> --=20
> Regards/Gruss,
>     Boris.
>=20
> Good mailing practices for 400: avoid top-posting and trim the reply.

Your understanding is correct.  It's more so that the following DF/SMN
interface gets mapped correctly.
		/*
		 * If there are more PCI root devices than data fabric/
		 * system management network interfaces, then the (N)
		 * PCI roots per DF/SMN interface are functionally the
		 * same (for DF/SMN access) and N-1 are redundant.  N-1
		 * PCI roots should be skipped per DF/SMN interface so
		 * the following DF/SMN interfaces get mapped to
		 * correct PCI roots.
		 */
Does that read clearer?

--=20
Brian Woods
