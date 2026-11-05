Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793897380;
	b=AJX+uMW7HQOyxKQ4YgDfigZTp6GpH+fcXNyDtuByvUR+DocuQsLZXGhRqUxDiKWDD0aj
	 jLnef9qCNr4875B4srgDJy923mtlJXV9mqYCk8oL059COf3btBWsG8UxzlQp1QHtVVBii
	 bh7iYzJBGgZGPTEj7AvF2lzb1ncDHIVD/DFqSjyzfOv0KXEH5FBnc07kRcDoYYlwNF5qC
	 vgVUb3Rv/RQKoEoz02b1uQFR1aImnyUsVDIqhP7v1Jsk22Tp7ayf6c3n19vIGultXGf7G
	 TjzDQwqoYUU6ionkFwMD//23mb0JcfNbTtMM8N85g/prB+Nd3EkmU23Lv3sE34Hw+VQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897380;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=D9aLkysQZLmj+lAXjomwRWCRBt29fKibeXLTi1ouD7Q=;
	b=uucS8DSyb5/ANAT0++rx9YMBJPrL1K9ID/9rTLNzmb1aBm2jDxmoJwZcU5OMlXd/wOSM
	 SuZ+zfac114JTFEwGxmjwLH8lei2pp0VC+s7nPk/M4h2jAh9fHjINuA5RX4BN3/ibwLKg
	 EfB9HtOMt3+qaROTuoeKCuWvijkxxj4BwsbGU6wJT0oCDKV2LdB6bSimPvBqyk/g7RR0q
	 VmeXtrKghstjc/ewLeuPo1T1bv0319TBpVJx0vSzRkDlGoiV4DdHNMTUXJEF/pYqRD8ez
	 eop1vyr9qEWxpVLVqrjI0lsVEUJhEACYq4Gfhh1X2l0UuXXWCSg3VvRYkc8OUquFFRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=m90HF4ac;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.11
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3DA606A32E;
	Thu,  5 Nov 2026 16:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B3DA606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=m90HF4ac
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwUayz9FkAuxBELQrxuycpkKk7vglSGzczCVmDMFsc+9qTYZt+5f3aRBROY3K3yPWsaYWLP4Yut8/78sLAXQYleeFKe35X6Y7pGHuMUIC6rGyauWKfuQ/2AExZdzqxgoWBK6T84um66ohIl9fXmlED92RvsxyKzqtUR0Y6Wp1ikYJs/OVDMoe+94B50RKMe4CqRuLyJNIuRLBRq9DlTfI4jhAgMXOZyyOm4XnBr53NMhELVsy5Ja+Qe4CFCDRcB8sgJmjtX3V9U2fo3MMnnw2/efqkgGcCdg+V1pFuc8B/raAiq11OPUJEqv4UHeN+ZFf6jgXLc5Owj0fyjqHuKiYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9aLkysQZLmj+lAXjomwRWCRBt29fKibeXLTi1ouD7Q=;
 b=G9MzmXD7w1FoXGX4UVYMknedJbuZ/CcFJaxNLKnd4HfLBFyX6KPpgWiFY7/+V96N4FterJ46iihabSpwATN9QRuQ3N9s3NpCD+ebInmiWUrSK6BGi1S3IijNPuIFxMSHPCqzlSTPEqsebgggYdd4cpM+iOJRLugg7qr6eV+Ske7ACgsyX7yCBLUAOBiDUZK5iQX4yAPIlqgJtldewoe+bEHzmCAlw2IDOalQNHw5DjN8ISKnHhH+VEVnIb6xc1bcwjA4BiA6mWJH178wFaR2fY3jJyJp3gWuHr1VVAOboWyjvT4pmYA6xRXsOX+t7Gdb5UBf1qlucWWZ2dk4Gib0aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9aLkysQZLmj+lAXjomwRWCRBt29fKibeXLTi1ouD7Q=;
 b=m90HF4acakKV0WfGbi58aGhXPNX2lX3xBsTx3TuHAhDHQaAQSQaHnJj7IB9V0zbh87zXCZR/LboRnzS2cPjUCLs10CdLE7DpdJfMrisic5E5i9dT/H/gSdjU8Z05g/7seiolV+8AYgmvDS3xgmvwl/4mD1tJ4mhg80baUVUW+9GQmU8wDH6KS0hLrju+y4519yhc5dQAuC2XPuK9Rnfx6wVwCuQubCUVNgtu/iX1I8rc7XXGp/vIvlZIZlw9QUYD8OIfpslRDCW/RAey1d3wA1Rf1yFBnH4O9hKQ5ASoKc+kXobHYAtL3eVmID5ltWbCx7OJD+VRpAXzE7mImUhbnQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by SJ2PR12MB7868.namprd12.prod.outlook.com
 (2603:10b6:a03:4cd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 16:49:32 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 16:49:32 +0000
Message-ID: <af090c6d-62e9-4daf-8e8c-2a1e6f7df722@nvidia.com>
Date: Thu, 5 Nov 2026 08:49:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 17/18] PCI/CXL: Restore CXL state after CXL bus reset
To: Richard Cheng <icheng@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Li Ming <ming.li@zohomail.com>, Alex Williamson
 <alex.williamson@redhat.com>, vsethi@nvidia.com, alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, linux-tegra@vger.kernel.org
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-18-smadhavan@nvidia.com>
 <auRhJa-nzR0CnKf3@MWDK4CY14F>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <auRhJa-nzR0CnKf3@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:303:b8::27) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 85678570-21cd-4a6e-1a47-08df3b5cc423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|261022105027099003|261026121527099003|261009223027099003|261026140227099003|261028144727099003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iZApINc/PXkUZdb3uTRK8QDZT/iPBlK2tcuNZ+D49XD7ZbBoc7I6waldML4SOkyHRqPp0akiz3JEysUxQzBLhvoYGg4xg3bF5cnkRzxjlspV7eJTmkyYEn4jiw1s8h5Gi22bSL+R6Php7cwRfP9I6NN6/1yIvjYSve9G8W/M8bzhvSYeMbxB45OrA6aB6aANFZLXsZ/TtozSyULClxzdmOJBMNjdHDGS4VslGBjHkKV40DH+Pgi8BdCekkyhSUWSs4osNT1P4HGgrI33al4lVm2kRFVZ/S41FgMBZby19sMCBBuE2QzYQCunfXxwLZc74ju4b9pezkEf6rfmutQFqK/OdWGYf05YCEG7YNVLmLaVOpHrlJkcsEeYIbcRogUSPJ7TRxTGEf9n60zLGeyAcA1IjA8v8nB90yjiZQR9HWad+vPiU/cY6O36AWSpSwU6Shn05ZaIzIXfhI0Dv6i/3LF/fIVB1rZKS3F1ur6cFhq8hb1xSs4CpHROLBO+rRbor8Kfl/IlZxwurdFlMn3IEuZ6MyvXi6Z6v59KFGic/Iju1YedryO4O2JdKt3zo6KPGtAf/83Z5YAaix50IEmKRzYYHn8voAH2EljoINpeAnaAXgWFPjIKMSc0CKcdZpPytteASUdLetvC/W7Ahgw78mPxK6DPavRTYh3FHXCWglo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(261022105027099003)(261026121527099003)(261009223027099003)(261026140227099003)(261028144727099003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVZnUzNjSzJ0NmxPU3ZqZHFxbWloeFNvOStWQ3RzU042UnphYkFJS1V6UWZT?=
 =?utf-8?B?MGZPd204bkg0TDBrZ3pydHd3aG4zdVk1Q2J3SitQenVIQXBaUmFRMlE1NUNL?=
 =?utf-8?B?cDYyYWZmYU9HNCtad1dsUWkvc05yaGdDWGoyMWFLZmNDMEFlTHBWcWZOMXNS?=
 =?utf-8?B?TVZlK2RteC8rc0NMVThXc2ZsWHFDM21mNVAxWVVBSXRQL1hDSjFSdXhrKytn?=
 =?utf-8?B?ajQ3dlJjRzNvUHNMUE5VMUd4bkxOVUlkeGZwellVMzdKQjY4Ky83THBwdXFm?=
 =?utf-8?B?eEFub1RZMzRCNGhCSG5CRU1JbVhhdG5qdlBKVlQzcURBY2duMFNzSVg3dW1t?=
 =?utf-8?B?U1Y4SDNKTk9YKzBLckx2Z3ZDVmhYZVI4WVlqM2t5VytuSGpNM0VLSUMwdWZu?=
 =?utf-8?B?eVA1ZWxSOTU5TVhEemhDaUxoSS9HVEhGcDE0bjFoclNzTUlZcSs5VEx1bjNJ?=
 =?utf-8?B?dldueDBvaDBoN3pTbWtMYzdURmxTa0trQ1hyRnAwUGpnM2QwNDdqRXNOZFVs?=
 =?utf-8?B?aHRDQXZrZURFMXlLTVA4S0M3VTVpVGxSaU56SVVBaXE2U1FoMXZQWmhIeUdU?=
 =?utf-8?B?M1pZak56QlFIQ0ZZQ1BhUHBHRis3T0NNQ2YraGJEV1BITFk1SHdsT0k5bCsr?=
 =?utf-8?B?VDYrQ2QwNVdMVjYwczFCSG9HcXR3bWJnVWQ3MmxULzF0NDZRZnVhQjY5RjRx?=
 =?utf-8?B?SGk3UnNiY1BDWmlScXMrNEJ6azUvSStrMFpzT0pZc2ozK3gweW90TFFSajJs?=
 =?utf-8?B?aENmT3k3S01YL0M0V3lUbi9oSVhRL1ZMTHBrVlRuTkFkMXdaNTRwb2RnS1pw?=
 =?utf-8?B?RzBvbmxOd1FtVEhzSlJTSzRuVGRnaEU4ZEFXT3o4UWYyYlF3eEk0ZlRyVVkx?=
 =?utf-8?B?Si9Rd2pZQ2paaTRjZW9naHBpR1VEV2dxc0Q5MFRWRitpOVNNTFdUVitvZ1FX?=
 =?utf-8?B?VnFTQWMxRkZhcElSditNb0wvYnUxV01oNWdBUjhkeTFrazBnenEwQkxnMjB1?=
 =?utf-8?B?c09xcmZzVkpDYzdpVGlRWkNwUzVzVlQ2emRJN085UFVrbjQ1ZmJZRmlqanNR?=
 =?utf-8?B?SS9WZHoxVlU4Q2tROW9KWWYwNTk1ZGVtOXZUZW96bE1WM0ZrcjVyNW5MVEJs?=
 =?utf-8?B?d2tnUlVaNlUzUnBnVUFoOWFCd1pPck1uQmhNSlFQR2hQdDVHWmpWeUpwY1Mw?=
 =?utf-8?B?S3Y5TzR1d3BWR3psY21nNi9jWGxDdUUrM0llNUlhUlV1Mm9DNUo5ZEVnZUpE?=
 =?utf-8?B?R2NxZTIwL292a2JrTGR2ZzNPOUVrR0xpUGtNR1R1UlRpQlIzZVdBeW4yWUdO?=
 =?utf-8?B?RGlyalNoaERtYmg4bmdaLzlYZW43TXJCZUo5anJ5ZzFEb3hFSnVmblE4TVhX?=
 =?utf-8?B?cklkQTdqU09DcE0zQUxBNDVOVVVyUnVhbEo4K3lKNGwrVWhPNEdKa2h4eS9z?=
 =?utf-8?B?UTNxc3QvUVpSajJwclhUeXh1ZDlwenBhcDVjSlNGZnQ1bTVnNE4zMVc3eXEr?=
 =?utf-8?B?NnJQUUxVd3ZCYUZKWm1GaEtnejNhN3Ird2RBU0VNTHdjYmVjMnVlZGZrYVZo?=
 =?utf-8?B?a0N5UW1UTHdXbm1QUERjUEtGbHBBR2RJUUFRR0lYQysrS21QMTViZXJrSXh6?=
 =?utf-8?B?WndOZmlOTzUwZFc2V3JSK0dIdkcwUDZCUnczLy8rd0RpSTNMUmVNb2NoTnhh?=
 =?utf-8?B?dUtGOWpGcy8rTnBBZUovcmlHU2dYZ2RTTEt5cDg0NnUwTlk4VGRTMkFhMXZu?=
 =?utf-8?B?THBUMmZ1SzJRQytxZUlHRGE1RFh2MjhGM1Nqd3ROUkllL3JhY0dyM1o5T29J?=
 =?utf-8?B?TW5ORFhVVkFNeXM1LzdGR3ZlSlRaT2xqRXEzMDZOcWhnWStkUUprRTl1ZzNR?=
 =?utf-8?B?VmIydDB3UnhoakFzeXVPVmlCMHFEazJXTkFqVExEWE94Y0lpVVh6MUZJamZr?=
 =?utf-8?B?UlRIb005NSt0RkU5dzdqRk5BQVlQK1BaU3RXMjhiNEZ6RnZRUEd2OUI5YllV?=
 =?utf-8?B?cm1reUQvL3A0Mm1RVTZtSG9Rc0Evd2FWUWszSkRDMGdWTTFEZG9NL3pkdnNi?=
 =?utf-8?B?VXd1bFNUdUFnWXJGVXJ6eisxZ2FVWnE2OGhRcUorQ1pWTzhMZmR3cyt3Nzhx?=
 =?utf-8?B?djBjbmdEZ0dZNjBrdWgzVktoU3RhcVhQZU9BM3RCNThZTUdSdEMwNXZGOVhF?=
 =?utf-8?B?VU9NWHF1eE92Yk1EMkIzNHBSekl1OGhoNkdybG5kVHMyMDFOQ2J3bWMxTS9y?=
 =?utf-8?B?ekpQNEF2U2I0eXBrMHNpaWJsY3hweTZrY3dJT21iUGF5UGlhcmZRamR0RjhV?=
 =?utf-8?B?NDA4ZHV2VW9LZ1JkT2V0aFhoQmJ4K1Nzc0FmbFBWbGZ1cW1BbFIyUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85678570-21cd-4a6e-1a47-08df3b5cc423
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:49:32.5122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwJFcmksNZfTrMDlZXyZ+fwbzAx2OUSHlAYXy3cPM78PZuSkLc9gxxhuRtC1XrKoAvVObMxm8JF6JTBjg+EHxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868

On 10/30/26 2:22 AM, Richard Cheng wrote:
>> +	rc = cxl_hdm_cache_copy_decoders(&pdev->hdm, snapshot);
>> +	if (!rc) {
>> +		rc = pci_cxl_restore_state(pdev, snapshot, &command);
>> +	}
> Hi Srirangan,
> 
> Looks like BME is going to be restored here?
> The caller haven't unblock IOMMU, if we enable BME first the requesst will hit the
> blocking domain.
> 
> I think we should enable BME after IOMMU restoration.

Thank you. Fixed this.
In v17 cxl_restore_state_after_pci_reset() leaves PCI_COMMAND
disabled and returns the saved value. cxl_reset_bus_function() calls the
new cxl_restore_command_after_pci_reset() after 
pci_dev_reset_iommu_done(), so bus mastering is enabled only once the
IOMMU translates again.

-- 
Regards,
Srirangan
