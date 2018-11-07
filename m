Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43A9C46464
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 19:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9426320862
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 19:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Snw9eUhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9426320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbeKHFVz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:21:55 -0500
Received: from mail-dm3nam03on0070.outbound.protection.outlook.com ([104.47.41.70]:33301
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726362AbeKHFVz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Nov 2018 00:21:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBLgHP8Qg23wPrkT92c+y+QQN3nVUImta2nNQDclVNM=;
 b=Snw9eUhABwxS3Yth4PUCbb+Bk0+DRSI9qdp0lWi+eAQ/88D5Nh3BGMz+ib0KbXE7HhJ+JzHYS515YzG8qFnsrk1+cxyKtsbUEPkXlIid6KyLs71b4Ju3iZ1iL5MQoiy/bIRdwstZq3q28FC5CM81Y6qiHwpD+3mFOcooemK0IA4=
Received: from CY4PR12MB1768.namprd12.prod.outlook.com (10.175.63.10) by
 CY4PR12MB1703.namprd12.prod.outlook.com (10.175.62.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 7 Nov 2018 19:50:01 +0000
Received: from CY4PR12MB1768.namprd12.prod.outlook.com
 ([fe80::82f:4b8a:fd43:aab3]) by CY4PR12MB1768.namprd12.prod.outlook.com
 ([fe80::82f:4b8a:fd43:aab3%8]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 19:50:01 +0000
From:   "Woods, Brian" <Brian.Woods@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        "Woods, Brian" <Brian.Woods@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, Pu Wen <puwen@hygon.cn>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        Takashi Iwai <tiwai@suse.de>,
        Andy Whitcroft <apw@canonical.com>,
        Colin Ian King <colin.king@canonical.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/4] x86/amd_nb: add support for newer PCI topologies
Thread-Topic: [PATCH 2/4] x86/amd_nb: add support for newer PCI topologies
Thread-Index: AQHUctdtTs18UoG4rUKlKIFT94W0kqU9IkqagASZzYCAAAMiAIABjnMAgAAFC4CAABZFgIAApxAAgAByOsGAAD4qgA==
Date:   Wed, 7 Nov 2018 19:50:01 +0000
Message-ID: <20181107194955.GA19346@amd.com>
References: <20181102195925.GB160487@google.com>
 <20181102232948.GC26770@zn.tnic> <20181105214537.GA19420@google.com>
 <20181105215650.GG26868@zn.tnic> <20181106214256.GA65443@google.com>
 <20181106220059.GA4139@zn.tnic> <20181106232040.GA85755@google.com>
 <20181107091838.GA10835@zn.tnic> <20181107133856.GA238955@google.com>
 <20181107160707.GA14169@zn.tnic>
In-Reply-To: <20181107160707.GA14169@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0056.namprd12.prod.outlook.com
 (2603:10b6:802:20::27) To CY4PR12MB1768.namprd12.prod.outlook.com
 (2603:10b6:903:122::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Woods@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1703;20:1UZOaMsVTrOo01BXBYOnOPZDbVad/sgqwKBKBRvONdBHgNwiJhq31itj6gwDYBm2X586RPo94MTntgw1mQ8FU1z9FyrKH3CLjgYyMc+OGcWefCTxhp9QyEtBlMkn50pYO2wf6n8zeb6+vkVc0KB1W+uYuxrCP8YooeBjifaGLJa6FP2h766KM27PD4L8GDWwW+bwZJvZou5wDeWTDf1w3tE+r2JH2ft3EwgjQzc/qLhx9FyJyE8pGB0migZp//r5
x-ms-office365-filtering-correlation-id: 293c924a-2d00-45cd-823b-08d644ea344b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1703;
x-ms-traffictypediagnostic: CY4PR12MB1703:
x-microsoft-antispam-prvs: <CY4PR12MB17030A4789F7A3FAC0BFF522E5C40@CY4PR12MB1703.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:CY4PR12MB1703;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1703;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(376002)(366004)(39860400002)(136003)(396003)(199004)(189003)(52314003)(8676002)(71200400001)(81166006)(81156014)(6486002)(6512007)(14454004)(52116002)(7736002)(76176011)(71190400001)(8936002)(186003)(1076002)(2906002)(229853002)(256004)(72206003)(102836004)(25786009)(386003)(6506007)(3846002)(6436002)(53936002)(2616005)(93886005)(6116002)(11346002)(305945005)(6246003)(7416002)(54906003)(316002)(33656002)(446003)(2900100001)(6916009)(26005)(97736004)(478600001)(4326008)(486006)(105586002)(66066001)(106356001)(476003)(5660300001)(86362001)(36756003)(68736007)(99286004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1703;H:CY4PR12MB1768.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MUwJAPDK9womBLhVaYDopKUaxnH9qh0LZzi3RF/kgr5Y2afO1+LFIelg0s1qQNlpL5vEDAVvQH+omE7dwa+pNIpmMVJ0hTRFzC69DkbDBbJSUVhc+ua4jGgbJK3ARCw2WudCHyStD6FbVV2Dz+wgUCN9jbBWXXx5AXcUEK4UKk87nlwLGp1bqZA16LWa3WyEBT/JNcqjKlx8hdJaX5eq/LW/7Hx39aLvd1EmJUQpN2JsvJda5G0HKO7Ux8KpMavQdwHJYe/4bm42mLLfrLGhEjcLI0kXjvRNr9nVJu0Ota8tp8STIpLxn6K7Sr+A6xVYiL8up6I0+dkuevRew3E9Yxq8J+1mSP07thKX1D3Rltk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7998EECAD1E2BA468FA787687FFC6F70@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 293c924a-2d00-45cd-823b-08d644ea344b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 19:50:01.4267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1703
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 07, 2018 at 05:07:07PM +0100, Borislav Petkov wrote:
> Thanks for explaining.
>=20
> So I don't know about temp sensors - I'm talking about amd_nb which is
> something... well, I explained already what it is in my previous mail so
> I won't repeat myself.
>=20
> Anyway, if there is such a PNP ID device - and I believe I have stumbled
> upon some blurb about it in the BKDGs - which says "this device
> represents the PCI device IDs of a CPU" and if that can be used to
> register amd_nb through it, then sure, I don't see why not.
>=20
> This way, when new CPU comes out and the same PNP ID device is present,
> amd_nb would load, sure.
>=20
> Maybe Brian knows more on the subject...
>=20
> --=20
> Regards/Gruss,
>     Boris.
>=20
> Good mailing practices for 400: avoid top-posting and trim the reply.

More on exactly what?

If it's the PNP ID device, if you can let me know where in the BKDG you
found it before so I can look for keywords etc?  Because I'd need to
find those for k8 onwards so.

--=20
Brian Woods
