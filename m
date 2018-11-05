Return-Path: <SRS0=Hm5h=NQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCC3C0044C
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 20:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530392084F
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 20:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S++tA/tz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530392084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbeKFFzG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:55:06 -0500
Received: from mail-dm3nam03on0078.outbound.protection.outlook.com ([104.47.41.78]:63616
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726902AbeKFFzG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 00:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjNvy3WMd0/zUxOREukA+YJrx1Xyqf8sjy7JmGZGAS8=;
 b=S++tA/tz4wa5tHmwp6HfynLuZiL4XaZPEUVBHkYXhSsmn1VaoTwjoQt6p/kk1lzwJJXF5ckNtAwChtuFGbgvU6hwyrOGVhhKu6NF4fsFiv6rb7k/qk98dzsJ7DorEwPZQfkONLnxRDASx3dEibeswN6BZuERZ37u+Uol3SCDKZo=
Received: from CY4PR12MB1768.namprd12.prod.outlook.com (10.175.63.10) by
 CY4PR12MB1911.namprd12.prod.outlook.com (10.175.82.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Mon, 5 Nov 2018 20:33:34 +0000
Received: from CY4PR12MB1768.namprd12.prod.outlook.com
 ([fe80::82f:4b8a:fd43:aab3]) by CY4PR12MB1768.namprd12.prod.outlook.com
 ([fe80::82f:4b8a:fd43:aab3%8]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 20:33:34 +0000
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
Thread-Index: AQHUctdtTs18UoG4rUKlKIFT94W0kqVBmJ8AgAAPUgA=
Date:   Mon, 5 Nov 2018 20:33:34 +0000
Message-ID: <20181105203330.GB27399@amd.com>
References: <20181102181055.130531-1-brian.woods@amd.com>
 <20181102181055.130531-3-brian.woods@amd.com>
 <20181105193840.GA26868@zn.tnic>
In-Reply-To: <20181105193840.GA26868@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0070.namprd02.prod.outlook.com
 (2603:10b6:803:20::32) To CY4PR12MB1768.namprd12.prod.outlook.com
 (2603:10b6:903:122::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Woods@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1911;20:ktTRKRIUUo3IXPM3rb+MH/iGPI76KYu/v3p7/p0G+V0fgiOeO2xfcBnbsdetxvQG4tCy3mHKiM8jo375s7hjWgpwotdHBL12/1V9iTAw3tTXz0cJkcmZiheZDW+fv8WQLZLD5wYDyzuYCAxkTN9K+cMamI18LuKBXuvtXcMHIcGU/JK9KOl9IJvv1KBLiYwXoXmfkSItu3oEpKs26Z4u/eHWaYpemlIyUXwymW2MgOeVUyoJSxQPmmrXgmOuYowX
x-ms-office365-filtering-correlation-id: 6ac1be64-e84d-4b9d-c513-08d6435df513
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1911;
x-ms-traffictypediagnostic: CY4PR12MB1911:
x-microsoft-antispam-prvs: <CY4PR12MB19112C55E9FF71A7F65614CEE5CA0@CY4PR12MB1911.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:CY4PR12MB1911;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1911;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(366004)(199004)(189003)(6916009)(8676002)(81156014)(1076002)(86362001)(575784001)(14454004)(6116002)(97736004)(3846002)(54906003)(7416002)(7736002)(305945005)(316002)(106356001)(36756003)(105586002)(8936002)(446003)(68736007)(5660300001)(478600001)(72206003)(11346002)(229853002)(81166006)(25786009)(6246003)(26005)(186003)(53936002)(71200400001)(52116002)(71190400001)(4326008)(6512007)(76176011)(14444005)(256004)(486006)(33656002)(66066001)(2900100001)(386003)(6506007)(6486002)(2906002)(476003)(2616005)(99286004)(6436002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1911;H:CY4PR12MB1768.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: We6Agdw3+xspaAOIAZhlbam4yCyAXXMsab1b4+QnzQJWSYhXVi1M/0fT59Qyr7NgJ3LJq+pMlomQFclR4ZtTT0tpoCG54ulH13bNN7fCLIj7UBxgC6QC1LbkTEUXka0/pMxCoxted2sz+D8HDKJfRWDp3hvYR7bo8hxNiB+7Vcgi/dLJZLUzzmykB+PBeLABRvntUKivhPDx6CW3a9CMESOX2DqY3F691rViCuF4P+f3liHUWl0NMWNglq8iDW/BHpnTAN1BhaeEZ/JAwbhMQshhN4qNNQj3nYKr1tddRyDQD7SGld1Mn0hhoSaalkQkaeTFA4xfDwrWJYkKry/ogfO0PFQ3AlzOCw3bQPipgwI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3DC06219AAEE0E44B03F5EBADAC5E325@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac1be64-e84d-4b9d-c513-08d6435df513
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 20:33:34.7251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1911
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 05, 2018 at 08:38:40PM +0100, Borislav Petkov wrote:
> On Fri, Nov 02, 2018 at 06:11:07PM +0000, Woods, Brian wrote:
> > Add support for new processors which have multiple PCI root complexes
> > per data fabric/SMN interface.
>=20
> Please write out abbreviations. I believe it is only you and I who know
> what SMN means. :)

Will do.

> > The interfaces per root complex are redundant and should be skipped.
>=20
> And I believe it is only you who understands that sentence. :)
>=20
> Please elaborate why interfaces need to be skipped, *which* interfaces
> need to be skipped and which is the correct interface to access DF/SMN
> through?

See last comment.

> > This makes sure the DF/SMN interfaces get accessed via the correct
> > root complex.
> >
> > Ex:
> > DF/SMN 0 -> 60
> > 	    40
> > 	    20
> > 	    00
> > DF/SMN 1 -> e0
> > 	    c0
> > 	    a0
> > 	    80
> >=20
> > Signed-off-by: Brian Woods <brian.woods@amd.com>
> > ---
> >  arch/x86/kernel/amd_nb.c | 41 +++++++++++++++++++++++++++++++++++-----=
-
> >  1 file changed, 35 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> > index 19d489ee2b1e..c0bf26aeb7c3 100644
> > --- a/arch/x86/kernel/amd_nb.c
> > +++ b/arch/x86/kernel/amd_nb.c
> > @@ -213,7 +213,10 @@ int amd_cache_northbridges(void)
> >  	const struct pci_device_id *root_ids =3D amd_root_ids;
> >  	struct pci_dev *root, *misc, *link;
> >  	struct amd_northbridge *nb;
> > -	u16 i =3D 0;
> > +	u16 roots_per_misc =3D 0;
> > +	u16 misc_count =3D 0;
> > +	u16 root_count =3D 0;
> > +	u16 i, j;
> > =20
> >  	if (amd_northbridges.num)
> >  		return 0;
> > @@ -226,26 +229,52 @@ int amd_cache_northbridges(void)
> > =20
> >  	misc =3D NULL;
> >  	while ((misc =3D next_northbridge(misc, misc_ids)) !=3D NULL)
> > -		i++;
> > +		misc_count++;
> > =20
> > -	if (!i)
> > +	root =3D NULL;
> > +	while ((root =3D next_northbridge(root, root_ids)) !=3D NULL)
> > +		root_count++;
> > +
> > +	if (!misc_count)
> >  		return -ENODEV;
>=20
> So you're doing the root_count above but returning in the !misc_count
> case. So that root_count iteration was unnecessary work. IOW, you should
> keep the misc_count check after its loop.

I think having them togeter is cleaner. If you aren't finding any
misc IDs, I highly doubt you'll find any root IDs.  There shouldn't
be much of a difference in how fast the function exits, either way.
If you want it the other way though, I don't mind changing it.

> > =20
> > -	nb =3D kcalloc(i, sizeof(struct amd_northbridge), GFP_KERNEL);
> > +	if (root_count) {
> > +		roots_per_misc =3D root_count / misc_count;
> > +
> > +		/*
> > +		 * There should be _exactly_ N roots for each DF/SMN
> > +		 * interface.
> > +		 */
> > +		if (!roots_per_misc || (root_count % roots_per_misc)) {
> > +			pr_info("Unsupported AMD DF/PCI configuration found\n");
> > +			return -ENODEV;
> > +		}
> > +	}
> > +
> > +	nb =3D kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL=
);
> >  	if (!nb)
> >  		return -ENOMEM;
> > =20
> >  	amd_northbridges.nb =3D nb;
> > -	amd_northbridges.num =3D i;
> > +	amd_northbridges.num =3D misc_count;
> > =20
> >  	link =3D misc =3D root =3D NULL;
> > -	for (i =3D 0; i !=3D amd_northbridges.num; i++) {
> > +	for (i =3D 0; i < amd_northbridges.num; i++) {
> >  		node_to_amd_nb(i)->root =3D root =3D
> >  			next_northbridge(root, root_ids);
> >  		node_to_amd_nb(i)->misc =3D misc =3D
> >  			next_northbridge(misc, misc_ids);
> >  		node_to_amd_nb(i)->link =3D link =3D
> >  			next_northbridge(link, link_ids);
> > +
> > +		/*
> > +		 * If there are more root devices than data fabric/SMN,
> > +		 * interfaces, then the root devices per DF/SMN
> > +		 * interface are redundant and N-1 should be skipped so
> > +		 * they aren't mapped incorrectly.
> > +		 */
>=20
> This text is trying to explain it a bit better but you still still need
> to specify which are the redundant ones. All N-1 or is there a special
> root device through which the DF/SMN gets accessed or?
>=20
> Thx.
Would

		/*
		 * If there are more PCI root devices than data fabric/
		 * system management network interfaces, then the (N)
		 * PCI roots per DF/SMN interface are functionally the
		 * same (for DF/SMN access) and N-1 are redundant.  The
		 * N-1 PCI roots should be skipped per DF/SMN interface
		 * so the DF/SMN interfaces get mapped to the correct
		 * PCI root.
		 */

be better?  I would update the commit msg also.

> --=20
> Regards/Gruss,
>     Boris.
>=20
> Good mailing practices for 400: avoid top-posting and trim the reply.

--=20
Brian Woods
