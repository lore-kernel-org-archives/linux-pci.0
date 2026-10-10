Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011027.outbound.protection.outlook.com [52.103.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E82388891;
	Sat, 10 Oct 2026 02:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599179; cv=fail; b=uAmd39TU575tr8CYQmrO7cpy+gTEc0HnEMnIbgbhdZB3mVZ/g53RHjvH9uTPX6sZIG35z34/MSawbBhv0uzL8oBcPFtq6zEKVD5tJpdbrzZPVhqIgHq2UowPQmjTqvKJwuWR4aM3djCnPlV9ZgP5CTb1BsYUvXhePH7bKlQ6pPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599179; c=relaxed/simple;
	bh=jtreTLx7qrHyjuWQO+LYRjLmKTdVcE58KWXmpKwvQU8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JUBG3EQTNpbqwL/WycCV+O88c3K6zzjXBPJZUyXrxlkyggEH5lVpzdLYVMnv44rElLLR51M0j7/sUVrw4u81RrLYfTr2VhavQ+xJhI0SlLPJpgx4XoI6pSbbPsM/2SMewmy7jwax1tfhUOWlt4UCAzNI2yT2TIi8TkGRp272U6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AoKL439Q; arc=fail smtp.client-ip=52.103.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AoKL439Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghg9/BJx782vGeFdlOtHzhIoO1zk3yaCgsAss/Kge6nnWqfIs+oKhxlI5SpiEw0nrjr+PkSx9entdF2M0kuaqH1fpY2Bz4bOVWG9v7xRUXZw0vh2I/P4fqQ557JV9z6oTcTu+zH5DeoiTUfGqGVCjK73ltuNnC9l2XeGh9r1xnXQRFTUwDlhxtwBiaPf13c/ztiokv/G2Mq933l1N65Q+EXqXsbDUYhe2FSihaj2hjjeAZI4drZNs0fRZ4bRsC/tFYIO4tS3WEr5a39u6VsKbgfwWmRR+1IQW1jO2C9qI5QLX0rXQGA3T9K10UlD0U5Y/rtTdpo/t2niGwP9WmebQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3elgSafLXPCvkWJSUDwyqB12Akx3md92SspqwFckFPU=;
 b=yF+CbzIfZLvsVsmC52cg3pJ5FKeZP5yRgAgVj5/bsdNlQQLV15cUfE5JgicLCjWc9z5YfE+keufVTectxx66p7Az5C3JDY45rlYxbDTM1dM10wVku8fnjK9qD1No2NiX0nrtaWjRf7Ud87yAXyWlHBlz6wGjBaou71PT0ts+hpSAuSXM9MetsUsWCsFECoNCwv9nkh7x67COqb/yocsXdAhQl3yH2aBNVn9+eYKdoEZCkXWcSi7KZtB4Wai/ig2DfoGwGfYxuWlYFCSzurLS83JF4qRTDKyR3Zpn14Z7jdWiU3NXYn23be90a3xpbBSa+D4NAHgfPxPp2cwHzq0s6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3elgSafLXPCvkWJSUDwyqB12Akx3md92SspqwFckFPU=;
 b=AoKL439QwfqaAKRlTJcB+gCRU4gCgdiMqb+tydeL3TV2KoKWGj3CUMzMWYEPm3XVgs9hwGH3Mk5TzzoM7F9pSZFNb2pPCUXM+23EK6OpBi0OKxD+RmmcUCoNGHiV8A81jGir/c6A6omc85d1LMi+LT4yTo+HSKmu9sJtT0Y5VpYFGHL8/Bxmolh79cVhC7VyoCJqQTD6FH2PEFVWtnkbeSm/H6aJu8ziGfkOyxueebGZeqLN35jDgHBpsPVSfTNnZLxfCotgp8yrz/jUk4ozsjjilSgBU85f6kqAxzLQK4EPN3AfpeyACpgoU7wJwFMNu+dsK39RZ+IMRmoIvFrjwA==
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 (2603:1096:400:3aa::13) by TY7PR01MB16042.jpnprd01.prod.outlook.com
 (2603:1096:405:2aa::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.18; Sat, 10 Oct
 2026 02:26:09 +0000
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7]) by TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7%4]) with mapi id 15.21.0496.017; Sat, 10 Oct 2026
 02:26:09 +0000
From: Freeman Z <SHD-ISAC@outlook.com>
To: "Kovacs, Alexander" <Alexander.Kovacs@amd.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "westeri@kernel.org"
	<westeri@kernel.org>, "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
	"YehezkelShB@gmail.com" <yehezkelshb@gmail.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"S, Sanath" <Sanath.S@amd.com>, "Natikar, Basavaraj"
	<Basavaraj.Natikar@amd.com>, "Martinez, Juan" <Juan.Martinez@amd.com>,
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Thread-Topic: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Thread-Index:
 AQHdSDNPea4qqw1tcEOkT/edQjHT9rbYfQ8AgACtPACAAaXMFIAAN8+AgAABpQCAAPzaBYAAjxGAgAC1UD2AAYHugIAAQ8E/gAAe2FyAAAh6gIAAJxUAgAAPH8SAAAVwgIAABbk/gAlgAYCAADo/D4AGCcGAgAAQnVOAABhFgIAAAdCwgAFnD4CAAAEXgIAAGv3dgAAQU4CAABZsJ4AADMmAgAAJ34CAAA64ZoAEMSwAgAADgPeAAAroAIAAEzAWgABfH4CAAGDMhQ==
Date: Sat, 10 Oct 2026 02:26:09 +0000
Message-ID:
 <TYCPR01MB109277E30BB08C87B1E3021CB96912@TYCPR01MB10927.jpnprd01.prod.outlook.com>
References: <f8b929da-b4ae-48ae-9667-3eb93aa0a4bd@amd.com>
 <20260925115041.GX106095@black.igk.intel.com>
 <5d065dcb-a4b9-4e9d-aeee-8a9bd1d875d7@amd.com>
 <TYCPR01MB10927F1B586DACDC97FFB606A96802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <7822cb02-f32b-4f02-ba65-4b90ebc42ce8@amd.com>
 <TYCPR01MB109279CDE9AAF47B40FD1770996802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550D1A8CB397E8C7FF0C7D69C8A2@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB109276162440B6A8CC34DEC73968A2@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <BL4PR12MB953383C9C73C9715FB9C5A339C962@BL4PR12MB9533.namprd12.prod.outlook.com>
 <TYCPR01MB1092779F2FA9CE76D5A76E4C396962@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <BL4PR12MB9533056AD6DE8C89370D6F6E9C962@BL4PR12MB9533.namprd12.prod.outlook.com>
 <TYCPR01MB10927C563CDDD5216CDFCD4D696962@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550E85CCAED9C8C0D19DCA79C952@DS7PR12MB9550.namprd12.prod.outlook.com>
 <051b667e-eaa9-4ad8-86ce-1a326a612284@amd.com>
 <TYCPR01MB109273BCB71161ABE3AD85A8696952@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB95503B5244149768A62590099C952@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB109272C6ADB253EBABEEB30AC96952@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550496ABBB70227D5B2B0679C952@DS7PR12MB9550.namprd12.prod.outlook.com>
 <DS7PR12MB955053FCD5A303347E165D429C952@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB1092781DD2EE8EC1EEAD4A52C96952@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB95504FE60773F44B1950FEF49C922@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB10927E84328D5CB5D9278D98096922@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB95500DA47DA5616DA06DF67D9C922@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB109272AB9BEA4B0DC82DB90C496922@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550BB636770CB3984E5DA999C922@DS7PR12MB9550.namprd12.prod.outlook.com>
In-Reply-To:
 <DS7PR12MB9550BB636770CB3984E5DA999C922@DS7PR12MB9550.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-06T16:59:54.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10927:EE_|TY7PR01MB16042:EE_
x-ms-office365-filtering-correlation-id: 17544092-6ba7-47aa-3aca-08df2675d865
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|31061999003|15080799012|6092099016|15030799006|51005399006|260826193500599007|41001999006|8062599012|8060799015|12121999013|19110799012|25010399006|13031999006|440099028|3412199025|26104999009|102099032|40105399003|18061999006|2607281247196008;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ekrYEf6Q8I7zBhdBTPkoVLWGbzxAcWF5IXj48XQWt/Qcwq2RHUM685/WU/?=
 =?iso-8859-1?Q?edYbzaZ34iO1unkcIym95C7JH9yvbJCHs/YJztMyqVYQu4N3GHloN+H3DV?=
 =?iso-8859-1?Q?U7OgIqgcx8caoIUMA1Jcwr5ssgnCntArhI0KaldRdo1j8IEy9l7PCpSZO3?=
 =?iso-8859-1?Q?QIYxZEEKKSYFL+rwmn6KJ36ol6n+0K/UgGeEp8h7ZbdTtZ941o5RjwDUTT?=
 =?iso-8859-1?Q?JCMGMa8hjlwVBwD1d8O4nzidLqQhDlIEQwEGtOVcTEToup8O3sqiLjeqLc?=
 =?iso-8859-1?Q?84ZE4L3DDFvt39J/mP+i0K/GAW5rDPsj+G+78kRmA1ocDydv5UzNA3//qB?=
 =?iso-8859-1?Q?4+tKULMuBLN+8626Fr04vbwVIt4SMFBn6iFf395+HWZftUAVoZzKCBcpzM?=
 =?iso-8859-1?Q?ZotOfGcytrZpzR2R8S8ufY8XvW6boiXptpu+8sBGR1cttVQ5OBVXhVbOMr?=
 =?iso-8859-1?Q?X2ajMUGRm0bm+jTjvlpVtb2cUhNzMuGhPgZKnM+GJ0g8nyoRUrkEApl2cE?=
 =?iso-8859-1?Q?HRPREYbhMQ0hkTXdw0wRjVUVOwS69KBqPuvM5mFCCfF9uDCNrFqfdGuG0Q?=
 =?iso-8859-1?Q?eIEDoW+O0Dx6W1XI+dBoxrWo9Dh1Lzl0APR24/Qjkks+YJDETw6WZL/qGU?=
 =?iso-8859-1?Q?/N99bgvUK11eRVuTJABcfNaR9aFs3MHZQo/SXSoamVUZsGapihBPxDLqw+?=
 =?iso-8859-1?Q?3WkLYcNcx5gZq/ktXfvDk8kMWUMYW8jvB5kChGbs5ZghzfVTQAJ+fZtqL8?=
 =?iso-8859-1?Q?i1+EdrfDJKqcXzoU8wlu2xtqCwqXSPXPuDfHKYCXUhRqxyAMGRXHFyte/q?=
 =?iso-8859-1?Q?x+4vsY870HPnjklgFB+B7CEczneeFLyR4d/2MCEQ01f7fjfm59RQmB/l1E?=
 =?iso-8859-1?Q?SANjGGH7ahz34oVaL60IydVnYFpm/XRyG8AqDI2abiPiF9vR/09gGwn1Mq?=
 =?iso-8859-1?Q?5BslBRdVgax1swtS5BoZXjlAxaiIJyKEHxUpGpLaliUT96uMEsmh+hqAa5?=
 =?iso-8859-1?Q?ioU6ORwsypqZx9URtgRDE2rRHpEm/Xl43G0OzXGLoui1gTO6AT1bKKcBvY?=
 =?iso-8859-1?Q?9XraH2LFuNL34sv59rg6aH0qylPvqS5pPdDJ5uGkCU8p1da6SR8rWP8X14?=
 =?iso-8859-1?Q?UKwC1SivR5vaD65j4dnOd8EIw/CRUGPd2OtId282csXtdW1GOE?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?tRwhhWITlIt4ctkWXaL/9P4MdZ+4YwYwmO3/PnqNfKYBLLH9dMrmFvNhOH?=
 =?iso-8859-1?Q?ZnuLnrp9Jq98JeVV84vjmd9ajdatGeUA5VHKyzFXf0LoWL7pcMFKzJ1yYt?=
 =?iso-8859-1?Q?YmTC8tSsmiKv5JSfDKso+WI0wpkxVBYL89jPR2seCSWXbKTzfWiRhyZr4v?=
 =?iso-8859-1?Q?RN7n5krco6MNVfQtayVQv11f39jYprMfdA3Iq1t+LS/t4pzWUphw/q20H3?=
 =?iso-8859-1?Q?7imgZyrPMDakk439ZLj40Aw+sJfvwtmf0T45rMDoaPhhL+Atn0ci91zkBc?=
 =?iso-8859-1?Q?p1PAJa6zoDihCKInkf7vjHwOePFL0HMyVfm2rsLbOCjKUIT7TAwS4LaVTo?=
 =?iso-8859-1?Q?CTV+3UCi9Tkwn7W+1NluEIlZmybOXVlPVAhkzSNJ7AvbI7XRhkeNmkJhfh?=
 =?iso-8859-1?Q?D5zSNcZDIn3m+aNyKGh258P2GWXVmT1qEiqsIvRTIpxDzD5jmtx2ziE4ae?=
 =?iso-8859-1?Q?fxapE+b2GOhOiuqR1zyt+K9kwIKRyeqvFvaxMp5fjhQATbdvXGxnYHaWVl?=
 =?iso-8859-1?Q?ehpBwt8P7zYzEQn7yruDlWLRJ7S7N7Js6r7A2BgpstVv1XRjzInL/TpSwD?=
 =?iso-8859-1?Q?WL5GPP6Ai5vbjqGs8Oq7AK6eweBiNCvgX3zYOeBpjfn+beoQafBjVssZ2U?=
 =?iso-8859-1?Q?yLtd2Wsu/HBrIUt6e9mFD2e62r9hUJM9GKgi2vvJCiNqqExhi9OugMmPeE?=
 =?iso-8859-1?Q?FYxAEwbVR3VNX+XkEvRDwGJWWDhY8/lIpg3tWzR5MgxLoX0LKYcBSPdKK0?=
 =?iso-8859-1?Q?FrFNsHMKROW50QrgkIeklXbzLeH2lMDyo8jcOKPmkTv5xWO/809AuvSHlr?=
 =?iso-8859-1?Q?C67hLBTbI4t4epCqPXWKInSZMfDhvSRNQadVUhgVvl+Lr9mayQvdC7DueF?=
 =?iso-8859-1?Q?LD/nZO1za2hj4RgitCh/zJZZ6Vh06D8GT/eUFA9R+mWLkPG8o1B9lPQ/8b?=
 =?iso-8859-1?Q?KJmoEAMlIhlYXKM+C6PK6wgWmTHkCw4afQsOiAo1mH80ZV90XljY+CEFSX?=
 =?iso-8859-1?Q?8IOBbevwjS3yh5GGy/Yc/U3VKmf8adVL6/MQMFyvHYPbOwKQgYRvfB6aIX?=
 =?iso-8859-1?Q?bdxuDTOqTtmRSr0n7F6ufE1T5GwI+SS2xDeeOgC0RM2rG9VRoUuNGChjWJ?=
 =?iso-8859-1?Q?tPAkIPE13PPaDOTp1Y8l9xVG2yjIes5OW16gcVHPqlIyqnQpG7QtRGbUer?=
 =?iso-8859-1?Q?7miG066CWhHH66V5tnqAXOH+cqOEEr1Yy2APVLgKNWrjl3ZZydaDIdKrSf?=
 =?iso-8859-1?Q?oC0icYnPzpWwaS/XC2AdM6GMFhgN6I+83hZYI7DL9RplX2+zhx0IFkm+oA?=
 =?iso-8859-1?Q?iKUL5t+z7dqCs99W6JNJyYMut39J+Qole6kigthu1Ogp7xgCH8H2qP9G1L?=
 =?iso-8859-1?Q?lnEi+I9s0vIxrBHrOCAkDurUJLggxXn2cX0bqn61XXn5YF4jnHpMjv71WP?=
 =?iso-8859-1?Q?iQqpSP2pwLdeWkexkt/pSaJBSGPMX5O41bvn1gB0+RIeLprXE6hJhtWVHL?=
 =?iso-8859-1?Q?A=3D?=
Content-Type: multipart/mixed;
	boundary="_003_TYCPR01MB109277E30BB08C87B1E3021CB96912TYCPR01MB10927jp_"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10927.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 17544092-6ba7-47aa-3aca-08df2675d865
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2026 02:26:09.2941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB16042

--_003_TYCPR01MB109277E30BB08C87B1E3021CB96912TYCPR01MB10927jp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Alex,=0A=
=0A=
Here are the logs from the rerun tests.=0A=
=0A=
Best regards,=0A=
Freeman=0A=
=0A=
________________________________________=0A=
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>=0A=
Sent: Saturday, October 10, 2026 4:28=0A=
To: Freeman Z <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciello=
@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.=
Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (Ace=
Lan) <acelan.kao@canonical.com>=0A=
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=A0=0A=
AMD General=0A=
=0A=
Freeman,=0A=
=0A=
I have attached a v3 of your original script. Could you please rerun both 0=
 & 1 test cases.=0A=
=0A=
Thank you...=0A=
=0A=
Replied or Forwarded By:=0A=
Alex Kovacs=0A=
845-625-4422=0A=
akovacs@amd.com=0A=
=0A=
-----Original Message-----=0A=
From: Freeman Z <SHD-ISAC@outlook.com>=0A=
Sent: Friday, October 9, 2026 9:55 AM=0A=
To: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Limonciello, Mario <Mario=
.Limonciello@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>=0A=
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.=0A=
=0A=
=0A=
Hi Alex,=0A=
=0A=
I reran both tests using the new v2 script, I've attached new captures.=0A=
=0A=
Best regards,=0A=
Freeman=0A=
=0A=
________________________________________=0A=
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>=0A=
Sent: Friday, October 9, 2026 21:39=0A=
To: Freeman Z <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciello=
@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.=
Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (Ace=
Lan) <acelan.kao@canonical.com>=0A=
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
AMD General=0A=
=0A=
Freeman,=0A=
=0A=
I have attached a modified version of your capture script, please return th=
e 0 & 1 logs of the attempted plug actions.=0A=
=0A=
Replied or Forwarded By:=0A=
Alex Kovacs=0A=
845-625-4422=0A=
akovacs@amd.com=0A=
=0A=
-----Original Message-----=0A=
From: Freeman Z <SHD-ISAC@outlook.com>=0A=
Sent: Friday, October 9, 2026 8:03 AM=0A=
To: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Limonciello, Mario <Mario=
.Limonciello@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>=0A=
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.=0A=
=0A=
=0A=
Hi Alex,=0A=
=0A=
Yes, both tests were performed on CachyOS.=0A=
=0A=
Best regards,=0A=
Freeman=0A=
=0A=
________________________________________=0A=
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>=0A=
Sent: Friday, October 9, 2026 20:47=0A=
To: Freeman Z <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciello=
@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.=
Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (Ace=
Lan) <acelan.kao@canonical.com>=0A=
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
AMD General=0A=
=0A=
Freeman,=0A=
=0A=
For clarity, the D3Cold Allowed set to 0 and 1 tests were on the Catchy OS =
?=0A=
=0A=
Replied or Forwarded By:=0A=
Alex Kovacs=0A=
845-625-4422=0A=
akovacs@amd.com=0A=
=0A=
-----Original Message-----=0A=
From: Freeman Z <SHD-ISAC@outlook.com>=0A=
Sent: Tuesday, October 6, 2026 4:04 PM=0A=
To: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Limonciello, Mario <Mario=
.Limonciello@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>=0A=
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.=0A=
=0A=
=0A=
Hi Alex,=0A=
=0A=
Yes, with d3cold_allowed=3D0 the dock enumerates without lspci.=0A=
Logs for both cases are attached. Each was taken in its own cold boot with =
the dock unplugged at boot and the workaround disabled.=0A=
=0A=
=A0 d3cold_allowed=3D0:=0A=
=A0=A0=A0 before hot-plug:=0A=
=A0=A0=A0=A0=A0 00:04.1 =3D suspended/D3hot=0A=
=A0=A0=A0=A0=A0 NHI=A0=A0=A0=A0=A0 =3D suspended/D3cold=0A=
=A0=A0=A0=A0=A0 09:00.0=A0 =3D absent=0A=
=0A=
=A0=A0=A0 result:=0A=
=A0=A0=A0=A0=A0 PASS - 09:00.0 enumerated naturally=0A=
=0A=
=A0 d3cold_allowed=3D1:=0A=
=A0=A0=A0 before hot-plug:=0A=
=A0=A0=A0=A0=A0 00:04.1 =3D suspended/D3cold=0A=
=A0=A0=A0=A0=A0 NHI=A0=A0=A0=A0=A0 =3D suspended/D3cold=0A=
=A0=A0=A0=A0=A0 09:00.0=A0 =3D absent=0A=
=0A=
=A0=A0=A0 result:=0A=
=A0=A0=A0=A0=A0 FAIL - 00:04.1 remained suspended/D3cold and=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 09:00.0 never appeared=0A=
=0A=
With d3cold_allowed=3D0:=0A=
=0A=
=A0 gpe10: 27 -> 29 -> 31=0A=
=A0 gpe1A: remained 0=0A=
=0A=
With d3cold_allowed=3D1:=0A=
=0A=
=A0 gpe10: 23 -> 25 -> 27=0A=
=A0 gpe1A: remained 0=0A=
=0A=
GPE10 incremented by four in both cases.=0A=
=0A=
In the d3cold_allowed=3D0 run, the trace shows 00:04.1 receiving an runtime=
-resume request shortly afterwards. It reaches D0, pciehp immediately repor=
ts Card present / Link Up, and 09:00.0 then enumerates.=0A=
=0A=
In the d3cold_allowed=3D1 run, GPE10 also increments, but there is no runti=
me-resume event for 00:04.1 after the hot-plug. It remains in D3cold for th=
e rest of the capture and 09:00.0 remains absent.=0A=
=0A=
IRQ 35 for 00:04.1 remained at zero in /proc/interrupts in both runs.=0A=
=0A=
SHA256:=0A=
=0A=
=A0 d3cold-allowed-0-20261007-041520.tar.gz=0A=
=A0 5e0af29245592916fb1682cc0bd3bedfcd75a1863d2d1bab0c2ab72bb14bc292=0A=
=0A=
=A0 d3cold-allowed-1-20261007-041802.tar.gz=0A=
=A0 3f6e00600e65faf5fb5fd43f6d753c3900e6247500fe5f3297b6d23e25a0a8c4=0A=
=0A=
Best regards,=0A=
Freeman=0A=
=0A=
________________________________________=0A=
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>=0A=
Sent: Wednesday, October 7, 2026 3:53=0A=
To: Freeman Z <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciello=
@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.=
Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (Ace=
Lan) <acelan.kao@canonical.com>=0A=
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
AMD General=0A=
=0A=
Freeman,=0A=
=0A=
Thanks for the update. BTW can you try:=0A=
=0A=
BEFORE plugging the dock=0A=
=0A=
echo 0 > /sys/bus/pci/devices/0000:00:04.1/d3cold_allowed=0A=
=0A=
to see if the devices enumerate properly without the lspci. If they do can =
I get a log of the fail with echo 1 > /sys/bus/pci/devices/0000:00:04.1/d3c=
old_allowed=0A=
and the pass with echo 0 > /sys/bus/pci/devices/0000:00:04.1/d3cold_allowed=
=A0=A0 ?=0A=
=0A=
thanks!=0A=
=0A=
Replied or Forwarded By:=0A=
Alex Kovacs=0A=
845-625-4422=0A=
akovacs@amd.com=0A=
=0A=
-----Original Message-----=0A=
From: Kovacs, Alexander=0A=
Sent: Tuesday, October 6, 2026 2:18 PM=0A=
To: 'Freeman Z' <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciel=
lo@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>=0A=
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
Freeman,=0A=
=0A=
I'm confused, did /sys/firmware/acpi/interrupts/gpe10 increment on plug ?=
=0A=
=0A=
Replied or Forwarded By:=0A=
Alex Kovacs=0A=
845-625-4422=0A=
akovacs@amd.com=0A=
=0A=
-----Original Message-----=0A=
From: Freeman Z <SHD-ISAC@outlook.com>=0A=
Sent: Tuesday, October 6, 2026 1:46 PM=0A=
To: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Limonciello, Mario <Mario=
.Limonciello@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>=0A=
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.=0A=
=0A=
=0A=
Hi Alex,=0A=
=0A=
I reran the test with both 00:04.1 and the NHI in D3cold, polling the ACPI =
counters and device states every ~200 ms.=0A=
=0A=
I pressed Enter late, so the manual "DOCK PLUGGED" marker should be ignored=
 for timing. The first observable hot-plug effect was:=0A=
=0A=
=A0 01:54:51.116=0A=
=A0=A0=A0 NHI:=A0=A0=A0=A0=A0 D3cold -> D0=0A=
=A0=A0=A0 sci_not:=A0 8 -> 9=0A=
=A0=A0=A0 gpe10:=A0=A0=A0 unchanged at 27=0A=
=0A=
Then:=0A=
=0A=
=A0 01:54:54.083=A0 gpe10/gpe_all/sci: 27 -> 29=0A=
=A0 01:54:55.152=A0 gpe10/gpe_all/sci: 29 -> 31=0A=
=0A=
Despite those GPE10 events, 00:04.1 remained suspended/D3cold and=0A=
09:00.0 remained absent through the end of the capture. IRQ 35 for=0A=
00:04.1 also remained at zero.=0A=
=0A=
I went back through the ACPI tables and noticed that GPE 0x1A and GPE 0x10 =
appear to be two distinct wake paths for GP12.=0A=
=0A=
In SSDT17, GP12._PRW returns:=0A=
=0A=
=A0 { 0x1A, 0x04 }=0A=
=0A=
and _GPE._L1A sends Device Wake notifications to GP12 and GP12.SWUS (as wel=
l as the associated GP19/NHI devices) without checking PCIe Root Status.=0A=
=0A=
GPE 0x10 is different. In SSDT16, _GPE._E10 is the GPP PME dispatcher.=0A=
For GP12 it does:=0A=
=0A=
=A0 If (\_GPE.ET12 !=3D 0xFF)=0A=
=A0 {=0A=
=A0=A0=A0=A0=A0 \_GPE.ET12 =3D=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 (M017 (Zero, 0x04, One, 0x78, Zero, 0x18) >> 0x=
10)=0A=
=0A=
=A0=A0=A0=A0=A0 if ET12 is 1 or 3:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Notify (\_SB.PCI0.GP12, 0x02)=0A=
=A0 }=0A=
=0A=
For 00:04.1, offset 0x78 is the PCIe Root Status register (PCIe capability =
at 0x58 + 0x20).=0A=
=0A=
A GPE10 increment only shows that _E10 ran; it does not by itself show that=
 the GP12 branch saw PME Status set or that GP12 received the Device Wake n=
otification.=0A=
=0A=
In the earlier full capture, GPE 0x1A remained at zero in all three=0A=
snapshots: before the plug, after the failed hot-plug, and after the target=
ed config-space read. 00:04.1 remained in D3cold until that targeted read, =
which immediately caused GP12 to transition to D0 and the downstream hierar=
chy to enumerate.=0A=
=0A=
GP12's _DSD also has HotPlugSupportInD3 =3D 1 and associates the port with =
GP19.NHI1 / USB4 port 2.=0A=
=0A=
Best regards,=0A=
Freeman=0A=
=0A=
________________________________________=0A=
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>=0A=
Sent: Wednesday, October 7, 2026 1:12=0A=
To: Freeman Z <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciello=
@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.=
Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (Ace=
Lan) <acelan.kao@canonical.com>=0A=
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
AMD General=0A=
=0A=
Freeman,=0A=
=0A=
Great, thanks for the confirmation...=0A=
=0A=
Can you try:=0A=
=0A=
get the 00:04.1 into a suspended state=0A=
Run:=0A=
sudo watch -n1 cat /sys/firmware/acpi/interrupts/gpe10=0A=
Perform hotplug of dock=0A=
=A0 If gpe10 does not increment when the dock is plugged into the suspended=
 port, that's proof the wake never fired - and it's likely the GPE-0x10 _E1=
0 path. If it does tick but nothing enumerates, the miss is likely downstre=
am (native/pciehp=0A=
=A0 side).=0A=
=0A=
Replied or Forwarded By:=0A=
Alex Kovacs=0A=
845-625-4422=0A=
akovacs@amd.com=0A=
=0A=
-----Original Message-----=0A=
From: Freeman Z <SHD-ISAC@outlook.com>=0A=
Sent: Tuesday, October 6, 2026 11:33 AM=0A=
To: Limonciello, Mario <Mario.Limonciello@amd.com>; Kovacs, Alexander <Alex=
ander.Kovacs@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>=0A=
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.=0A=
=0A=
=0A=
Hi Alex,=0A=
=0A=
Thanks for checking the tables, and Mario, thanks for the explanation of th=
e _DSD -> XDSD rename.=0A=
=0A=
That is consistent with the suggestion that the XDSD rename may be an inten=
tional way to keep an unused reference-code path disabled. This GV302XV exp=
oses only the 00:04.1 / NHI1 USB4 path, so the NHI0 XDSD issue appears like=
ly to be separate from the enumeration failure.=0A=
=0A=
Since you haven't been able to reproduce the failure, these are the conditi=
ons that seem to matter on my system:=0A=
=0A=
=A0 1. Cold boot with the dock disconnected.=0A=
=0A=
=A0 2. 00:04.1 power/control =3D auto, with both 00:04.1 and the NHI=0A=
=A0=A0=A0=A0 (6b:00.6) runtime-suspended in D3cold before the dock is plugg=
ed in.=0A=
=0A=
=A0 3. No PCI config-space access to the root port before the hot-plug.=0A=
=A0=A0=A0=A0 A config-space access wakes 00:04.1; both the targeted 4-byte =
config=0A=
=A0=A0=A0=A0 read in this capture and plain lspci in earlier tests caused=
=0A=
=A0=A0=A0=A0 enumeration to proceed normally.=0A=
=0A=
I captured a failing hot-plug under these conditions using:=0A=
=0A=
=A0 kernel: 7.2.9-1-cachyos=0A=
=A0 BIOS:=A0=A0 319=0A=
=0A=
The capture includes runtime-PM and PCI hotplug/link tracepoints, pciehp / =
ACPI device-PM / Thunderbolt dynamic debug, and ACPI GPE and /proc/interrup=
ts snapshots before the plug, after the plug, and after recovery.=0A=
=0A=
A redacted archive is attached.=0A=
=0A=
SHA256:=0A=
=A0 4d4d7f64aeb4a2bbd8e68cf221de2002ad427d3456fc8354c06f3d3760dad065=0A=
=0A=
The relevant timeline from kernel.log is:=0A=
=0A=
=A0 98.774=0A=
=A0=A0=A0 First observable hot-plug effect. The NHI begins resuming from=0A=
=A0=A0=A0 D3cold. IRQ 38 (00:08.3, PCIe PME / bwctrl) increased by one=0A=
=A0=A0=A0 between the snapshots, which is consistent with a PME wake throug=
h=0A=
=A0=A0=A0 the bridge hosting the NHI.=0A=
=0A=
=A0 101.015 - 101.017=0A=
=A0=A0=A0 Thunderbolt PCIe Down and Up tunnel paths are activated.=0A=
=0A=
=A0 101.017 - 135.664=0A=
=A0=A0=A0 00:04.1 remains suspended / D3cold.=0A=
=A0=A0=A0 The NHI remains active / D0.=0A=
=A0=A0=A0 09:00.0 remains absent.=0A=
=0A=
=A0=A0=A0 No runtime-PM activity is recorded for 00:04.1.=0A=
=A0=A0=A0 IRQ 35 (00:04.1 PME/AER/pciehp) remains at zero.=0A=
=A0=A0=A0 None of the counted ACPI GPEs change.=0A=
=0A=
=A0 135.664=0A=
=A0=A0=A0 The script performs only a 4-byte read from:=0A=
=0A=
=A0=A0=A0=A0=A0 /sys/bus/pci/devices/0000:00:04.1/config=0A=
=0A=
=A0 135.668=0A=
=A0=A0=A0 GP12 transitions from D3cold to D0.=0A=
=0A=
=A0 135.681=0A=
=A0=A0=A0 pciehp reports:=0A=
=0A=
=A0=A0=A0=A0=A0 Card present=0A=
=A0=A0=A0=A0=A0 Link Up=0A=
=0A=
=A0=A0=A0 Its first link check after resume reports:=0A=
=0A=
=A0=A0=A0=A0=A0 lnk_status =3D 0x3011=0A=
=0A=
=A0=A0=A0 This has DLL Link Active set and no Link Training bit set.=0A=
=0A=
=A0 135.808=0A=
=A0=A0=A0 09:00.0 [8086:5786] begins enumerating.=0A=
=0A=
A full lspci scan was not needed.=0A=
=0A=
So the PCIe tunnel is established while 00:04.1 remains in D3cold, and a ta=
rgeted config-space read of 00:04.1 alone resumes the port. pciehp then imm=
ediately finds an active link and enumerates the downstream hierarchy.=0A=
=0A=
No wake of 00:04.1 was observed during the hot-plug window.=0A=
=0A=
The kernel also logs:=0A=
=0A=
=A0 Wakeup disabled by ACPI=0A=
=0A=
for 00:04.1 on resume, so GP12 is ACPI wake-capable via _PRW.=0A=
=0A=
There are two observations I cannot explain yet:=0A=
=0A=
=A0 1. sci_not increased from 6 to 7 while gpe10, gpe_all, and sci=0A=
=A0=A0=A0=A0 remained unchanged. The snapshots do not timestamp that increm=
ent,=0A=
=A0=A0=A0=A0 so it cannot yet be tied to the dock insertion.=0A=
=0A=
=A0 2. The final Root Status of 00:04.1, read after recovery, shows:=0A=
=0A=
=A0=A0=A0=A0=A0=A0 PME ReqID 0021, PMEStatus+ PMEPending+=0A=
=0A=
=A0=A0=A0=A0 0021 decodes to 00:04.1.=0A=
=0A=
=A0=A0=A0=A0 IRQ 35 was zero in all three interrupt snapshots. Since Root S=
tatus=0A=
=A0=A0=A0=A0 was read only after recovery, I do not know when these PME bit=
s=0A=
=A0=A0=A0=A0 became set.=0A=
=0A=
Best regards,=0A=
Freeman=0A=
=0A=
________________________________________=0A=
From: Mario Limonciello <mario.limonciello@amd.com>=0A=
Sent: Tuesday, October 6, 2026 22:37=0A=
To: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Freeman Z <SHD-ISAC@outlo=
ok.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.=
Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (Ace=
Lan) <acelan.kao@canonical.com>=0A=
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
On 10/6/26 09:33, Kovacs, Alexander wrote:=0A=
> AMD General=0A=
>=0A=
> Freeman,=0A=
>=0A=
> Ok, regarding the 00:03.1 device, I am seeing that it is misnamed in the =
tables.=0A=
>=0A=
> BIOS Bug Report: Thunderbolt/USB4 tunnel port `_DSD` misnamed `XDSD`=0A=
> (00:03.1 / NHI0 path)=0A=
>=0A=
> But that more than like does not have any bearing on the root dock enumer=
ation issue...=0A=
>=0A=
> I am unable to create a case where I can replicate your fail on my test s=
ystem yet.=0A=
>=0A=
_DSD -> XDSD is a strategy I've seen employed when someone wants to pick up=
 reference code but has a difference in their design (for example they don'=
t have a retimer connected to the second USB4 router and disabled the IP.=
=0A=
=0A=
I don't know for sure; but my guess this is a strategy to avoid technical d=
ebt and mistakes when merging future reference code versions.=

--_003_TYCPR01MB109277E30BB08C87B1E3021CB96912TYCPR01MB10927jp_
Content-Type: application/gzip;
	name="d3cold-allowed-0-20261010-095816-public.tar.gz"
Content-Description: d3cold-allowed-0-20261010-095816-public.tar.gz
Content-Disposition: attachment;
	filename="d3cold-allowed-0-20261010-095816-public.tar.gz"; size=23264;
	creation-date="Sat, 10 Oct 2026 02:14:58 GMT";
	modification-date="Sat, 10 Oct 2026 02:14:58 GMT"
Content-Transfer-Encoding: base64

H4sICCufyWoC/2QzY29sZC1hbGxvd2VkLTAtMjAyNjEwMTAtMDk1ODE2LXB1YmxpYy50YXIA7b1r
e9tGkiicz/wVPYqzliYm2BdcmVH2yJIc6xlb1kpyMvtkcvhAJCThiCQ4AGlZk+T97W9VN64EeJUo
Cxpzd2IIQNe9qqu7qxs90Q36vabb7we3Xq9Jm5xyk1FGm9QxbGa2vrn/j8LPMgz5L/ym/5XXzOAm
F8ykTHxDmc4Z/YYY3zzCbxKN3RBICYNgPO+9Rc9r+ust0r8/vAy08efxPfVv6vos/TNO9Sn9GxZl
3xD6Vf8b/9144dDrt4mlcc1p8mbX7V7fBVFj7EXjNlHW0YmtY5c2Tk/aBHXWxv/XNdY4fnsU3zEv
4KZmNg7TVxy8QRsjaBu2usFwHAaAyZ2Mg/jerXvjTUZt4g3di77XaxTRkQvvMgg9chv6Y69NWAM0
Nfam7p6e7EaTaOQNe16vdSDbE6CpdLMxDPB1bOUPr6YYI+FkOPYHXjP0osnAi8j42iOocDIKwvEP
JPTcnj/0ooj4Eelee90baBMM+3fEvRx7IfHHJMYXEffK9YfTnKjXYpJpA+HdlWi/BnxVpJe1gGT2
QT0ne2dnRWGDKIGBEOTUI0N3PAmh0R259cfXZSiX/tDtEylUSYvbHfufvNYBlVSkf8XvdQOQkRdG
bXI18hjdFYa82Nul+C+C3dUpibp+/E8HBL7rxI2PTv+HjIOx248kJomhcxH6vStvlze++fp7uvF/
6gWMC02p1OYnoUXX94//usWESOK/YVr8G8oZpgtf4/8j/L79S2sSha0Lf9jyhp/IhRtdN74le33v
M0S9f01A2950ACJ7rdcE7YBAICZ7Zx/PyE8/C8r/8TP5npwdGKDTc0NrfAtwPkbuldeGCwIBshdI
8GSmRYE5EQqvfkviwAfwL/xezxuSbQx1pOsOe34P4tXOKiBZHmTCAyHbb/aO3hVAAtDTyZB8OD5U
7I0gZstGF6D7VyqKYs/QC7o3ZHR9F/ldGV4/Hp+8+/jTT4cHwDQ59wbQabihDw9C6NgGHnGc5iVg
bX5mojmJLvTmaKCFkz72MwHRen4ke7+kY0Nk0EUhrIOAHH84x96J9KNR1ycgb3d4N77GLszrRx6Q
445l9xSRk/0joHZ46V+RaOR2k46y1ZuE8DpAQ9KRL42cw1XUDf2R5BHeGkRkGACcbvDJC++gT/BG
gAi6EA/+LsFXup0yCugZ415UdSmyPd70/CH0uW7f/7fsNOEGcqiImPS8TwDqNghv3BA6GFC531dC
g6ZAW+QDLcOxBDYAVwWmAEA0BsbghjucSAXI7vXWDXuRIu0Tb0tuR6H/CUkZhygPfwiEDeFiGNyC
HUQBKH8EXSTo4Ze3H0hl369JQ2sSF5nq3ihA49C/ugK5IDOjQUc1lM5QaPsKqU7bX06G0KNCEwUj
uCSg0I7bHfkdTIM6IIntHbKNEPb2T47IyfvDJnSh/uUduQY4fS/ckeYVXHnwjkSF+vf6fQTuhwPg
32v2vD702igcBEq2JahjBSZ0hzvEHbkhOG4YDIiLSgzx9aZSEbq6YkYjZ14sNsz9pfhPD/cO3h/K
P/2h5DSYjEcTjAL9nhfGkhdtJdpbd9xV3vLx7DVvnRxILqJroOqVvD0Mhs3xZAjJJ2C9dvuXKBKX
nN+NvOY+GfUnV4nsczLelj6YqWInlfp1AMbx+e3+UUT+8XZftOA/el4Bk27kK4ZGgT8cR2TbBw0A
WLCuDMrJQevj/pm086HXBStrdoHsK09KXgo8ugbjub1WOnDTKCAJljKHDFARA3yTOOkF5SmRx7no
t4mvN5vo0j4kezLjA0MHIcDNKTvyNdCIm8UqpdzYDLVGI/LGpHnoTQIy8kfepev3G42f997tvvid
tZt/NoDTX38lWy/g1hb5yy7Zolvkv/4rf4Ntkd9++wHRDhsgLuJ1rwOypaJ3Lsy+oIT+wbbUK58h
6+WQ3zVi+C+2/R5pTnZIc+hBGK+Ad3h6+uG0LcOZG0n+tBwsJmFhdjg1vtidGl7sFkYX35K3IO1m
5Pc8qf+czEHJOVvo7B2cEvqZihb8R9/RpGGiD2dGB8IGeJCWghYh/wbFokscfN86aIJkh1ES0zAo
J7b7ioC1u0r/EC2HMhzDGCFSHgrw8gT5gwHABbAQtUDPU5qXJrh/5MXAJTq4/dMJ4y8jctCUgVWT
bqYcTGEZYD8SgcMmdil7hZLfxeYpGxStcTtvW+puM09a3twkkZ4b9n3sHZMAqjqK4CLywk9eDyIV
yPyI5jUn5C2Wv6U3DnZb0V3UuphELYiGLYiBfteLGkfqdhLVWhglWz4OP8LJaBw1zk/39g87px8+
nKsX1SC2he6NXd3px3eHuy1v3G1h/9KSXa3Wa83shmWDzsHR2d7rd4cH4DX4959px9yQvTp4NHRu
AL5NBInQHyDUDlUwGxITxjzxKE8qEfIBsJJfoIsKb9BFX++dHb47Oj7snB3u74rGyYez8w6+JP82
YVwNwfV/O+dH7w8/fDzfZZwi0g8qvo7c8TV0bGfne+9Pdl9sSyV9/93/fjf4rtf87u13778722lg
qxZ61HS+/uJ3cPI/4R/Z/M/G6d4vnXcffgImocmfTSW5Zujeav3gqrF3uv/26OfD+KkGmbF29e9Y
3EfHAOJ4/3C32PF3FIbOixeNc2iXqebPVtLhRq3kfgLjT5DAu3edk6OD3UZjcNPzQ9IcQUACrFuN
RrfvQc8+gu7wdxkeMLx97zXktYo1zSG8/HsCA2LcVPzC340PXePWi+SlLcJ/RANrDSf9fvrSrQuR
Z9FLGa34F0apHCU9pOS8mgS0Gzf2mM9gnZCYyCwkhL5sCL6M6UAvuB0m3UHoDYJPmNthi0R6Wgou
xngLGM9bMtZELegcW1kH2YqdVMZ3JaTTk/cdEPr+3ztvjt6dH55WU5oF6b/kEh1A+GK6/Rb5cRn8
VXIEySWXGR/dSQhp8rgjMYZIGtIuaRkGoxjZ9EtV0DOQYC+dS/lqB9LJ8RTUH2e9MwuoN82vmq4q
AKVlqSRvzQLbyzeA6DcPHgbHleBhujMPID6fCzEcoFNCi8Jj8scf0A9MvMQR/myACEckdlhy+I+j
c3XnJSL9ITapoyRyez1t64e4txf0JTk6PidgUu8bDXieunshWXjxVzC4/+L5NOHPRmPoQeDBYQky
kDZEKSDNMptBUgEq2YKeDfJoOYgh8Aibp8mcHKio4U0P7Q1ifDCBvDUb60xC5aZySKU1QBAd2SpF
2g8w/YP7uy9YLi78RSnkoPUCHlU4HAxNhuNL8tK9wAy0NRnewKhk+DKTvwcd67AQcBQmSCJGkfw7
jKA3gBQlRdNSs6rxMEzSOYlK+kswJyh3JLBRNTDF7LIw4rvfRa3vopcAKQTsWy9GkRR6PIE4JTgc
6xUlJ1V41HqBTyoE597ekJe/S1Sgzj9f5l5WRgLD4pKUj/deZiYL6j+bDHB02dw/+agmNqN0CNAa
hUE3l2wQ7OUhX42CrhohySGIS14fvMFM7FTqCVLCPSQfBtEDzMswhuOcp2yLI1k10NAafvivjpwI
nRLDRe8SpCDfV3fhAhRyFcJAvDlgpPkG+ISXtsr0VbjnTl6c/4aWCG6OESbimWF4SuTpGxDod2kW
1EFu2/4u/4H4f9s9fgP/fP99wluu49p+4ZP/j7T+76+06fz2/YvWDoIh3++SF36xE8JZjQtwyZv0
9p9FerGhvAO6/9vf/pZwh4qN3MGo73Xw71S+mVHGE9fxxV58IWeu4RJnrtU/cuYaLkGBHRiOxFc4
Y/369Ojgp0O8o+7j4OQ7OeA8oskFw4tDfPzP4Uvyz5T2rTRzO9e+E8c7W8VnsXcoGuc93JvzEHmZ
9RgYm/MIeZ5+nNoqeZkfkr1c5j1bE6X30tgJf5yebM17DIKd+1xKfOEbrPRG0p1DiDs8KfSPsYfK
XgP/HvhRBF68o+xq6I5g4D+ectq+e+H1MXjJe5nJqw5sdxeMW75C4HIrfSqtoNn0o6Bpm5TtDqNC
wykoU6s2uRh9etIqPgRupxqfyvHCtNinXkIjrpL+1GvKyKvVUPEq263Wx9Srh0jhOlqpFBnGoi7O
TkkvUu6S+AVaeWLpP0BvX4g6aZBo2hHBLqXb3pqOYLmuqZvFUqL0IW/+oKKXpPR474d8vtsLht48
NatYo9xod57rVbTL1tLmtlcuqSKnTAZhsAUDM2mhf+K03pay4+6o3McUX27i42b2WDXGtqq/eks0
FMlW66+FzinzxD9kl9J80yYvX/DvMTWlqOKWVNgfUnl/xGr7I1bZH/9swVW7lQ+p00w0cZ6gmSxU
SqrShBW8GMfiUx48iK52X/y1URpcqYGBGrzP6TdVjN96AWCSYVGx5ZzUOQ+nYvmiTaaAS0A38Ecl
UJnVNJtNcoKT+MOej0lrhHfW+zUayZBCRppCQg1/gz3jpA/ky5CTR6D83NsYPQqvw43K971ZcWwa
2bUrlyem19THMNi8mEB2WhwOpFALdQfzX5pKmee9G2fEVa8Ao8vDS19OADbkHGo+vBcZ2IFuRBZP
oHiUE+SFVHgZc06UNr4OwU5NZMn0FmfE8ustOMWYrnGp4gVFyl+mY/IUysMTROL2ZS1DEqh/mIY1
e9FsMsQp0ytQd6OBcfszxu2kS0k7jDRS5wzsc46chCQZDH/ZOz0+Ov6pnS0GkBefpRxS8nwIZrn1
BMwUI6ARPOkCknw5FtO2GjJax9PaUgo4ITg9Ra4EDw9gGIkApGVHPySLfv64uLpXFHQ84YOeDv3Z
Vm4a/S8ZxnRKsnJ2PuW2+C65dZXuL1G/yQS7bJH2ZvtgJf5wgqOUC6/rTqDTKplPotmXaEMvNUXi
yh3sdKdZoSy5RJWkovJFRD8Zup9cv4+yQ62lOuoHaDO4fnC8l2oqnf5IJx/jeY4Kw5UB+jJKPSTB
AvGE5AD8ANYQhLJWKHSTSfUhGSCdcLMl14XwqY/9Jq50e7gKkF9wRCTJkmMUSCeI7qKxN2je4mJF
PFs9Nc/gRwAMCRsEPf/Sx2XhO2jqR/GCrRZPl8qZmXSKI5iAYWGrLiitCj+83ZBy16ljxl3VxeTy
EsOP/2+vc3NR3VmpRlvSoiH8/BNDzT8l4twtCGWle9KPK++yf25VzCEmk3BFZeFSFogAHElyAoQl
lVon7+OF1LihIpTNnoabBVg9L8FVq4RbaRSomq2bdkm21KRdKlt0KNVp43p1vJQyeyl6YWeuprVk
dUa6LoPLlcgnBmAf1e2hNaB7E0ykgfE4pVZrV+14abeR1kvIKokd4oaDKWr8ZNGnWDun1sOAde96
pF4AWGpcrviJ+vHiP65e32KKH1xgboBGIjGoyIyLHmpJeZvt5EN2xTp8aeVdwyVvL98quByDpr5V
MxwTyIzUCji5wa4QQGzjq3H5ghvdDbuyj9x5pRwXvQ/RkoF7p+r+UK4xOMQcQ8lHCrlADgTK+rek
lCbERT/JMdnmO7JjHlyA84PPYukCUTPSODU1wJ5KosJylAqmsThFrTfKmoFUFiEIEsnBxX2vNxlF
MoDcjVRBRuj9P687luqXeaLqn5uHh/84OjuHp1du2OtjoWNwKftK5V1SDgBwIoNcbDgJxlvobT3y
4TR+l8gakmnb3Ts+gI4PUGXr9PE6ptvrqZflzTbm4Z4vxZh4AeC5HucW1+RS6zZyE/eiuD7agiC0
8wpAItVKWWhSEZIH6rmRHXK8sl5eGUVrw6e31373Gl7HcIoJQeoH5eXQW4+osHvjgU1cXmqN6ZWS
3QVhc36IbKyy2lORHjz4Ms7cjCvrgdJAPc9l1Zy+CoBYMoJaUYvwWf0FdIpx9YUKBuTDULniZIi5
VbFaI6mykN1nWkMz6rtjrG4iamGZfHx9vk+2O2+PDtAG9mFkTFrk5PiE7u/RHdQ/Luy7cvY/KdeJ
LR8wqmjnjkaeiwv5qvbnr/neQiNHag1frapCRjgC14hKtSdopnG3IxfjZQHBdMmJcmuwUhjnuGCU
SYmMLHZJDHcnZhjCFgh5MMI6LBV6IrQo1cP/QAL0p1s/kk6Qxi8gbISvK2px/Ver7O2StaQF3d2s
JaUl7SYWyLSs8paCIfNNrJdmbE+zy6Wq6qukhvxxHLkvfewii4HlVVpLRbJaKgjn+UKqbRkAQC/e
YDTe+SGG5l9mViIh50DFthPdxH3xhzNMPVRZBSKWfda57HcVYTKSYqFb6GO4LhSPyQXiuFuC9BeS
ysFF0H+V5JhK6cow8CfHAv0ggN5AFd0VK9GwiEMukMWVTRgAUXJynAhp9siNIq+XMNkNwtDrY4qJ
cTa1u9wwT3paU3GA9WRTgy2tGNcqlmFx5XrW0nDOBLGfkFOE01peaoF3akJHQkrlsnDNOWfSS5r1
lMxza5r55ap4QvbD+WG7gi+5PInNJcQgjobKe3/IZRXRjQ9BCoZ+KRJwH/Sgs6NjGN0cnnzYf5vV
kUQ7jUZ+3TXZEPJieyJ7pWa4kx9DVu4LkYVkjfy8M45KT/K35D4ROTeUX+PF9w4L701tFpk7IVJu
l2woqWqmnpVScdk8N9osQJ27IWWZufi0L67auFKemydzJ+PjsdhjbmTZamRzxclOMKzQGWFvufVC
ztTIKdhtLIiSBoN3d2aMJtVwZ280AoxYY/4yUpXW6ZQlWWWKEmdZwelOj87B6aptUolMFTr+OHO+
sTg2lArCCFv5NlFDRxAC1my9hoxqwaJMQ9ZeJi9vYZoXE1Sam5hWJmjrAjNZUFYK4BWmFZAowHPF
YqPSVAs7jnLYf6zQplyPKBSJAo2scs7JVVaHIy7VNxFZRT/KzTq3i1NOpyeE7JLpPU3Fd3CGuOqd
NDiWscv9AMujlYMfzO6SYe0Q0kI5Dyn3Xe0sRw8EUfXKOfhYMIFA+OL3QuXen1FsF/+7m9T0nZ5g
3n1+uCsnz7a3Ydy1y37A4dffdgtt5b3vv9/ZSSfPoOnp2W5VLJuaX95JXj+pfD2eYVZv4WpREerM
aeuswUl1gxRwbgVlpgXlX5GcyZcyDcmKZMmDfBArqtDTylcUA1WNFaX51pV1bko/rHwv05Wio/BG
sSYhXsAp9N7flrbYQcojx/EqMYLxI4S6xEFVfIcoIw3wFaRtY5lk5sDhbAOYW6BG3deqZahaaoTs
dSFJxtp83LAhc4JMHjH0a3ecgxdPeSrZ/CC3e4Q9CCdud4ybBGXqhwklpn2R15dBRltZd3+Zo7vs
lbhyaPo2hEHwkqet9FwB6PY2Oi35jjCKBFCC3lu5VEjId6Kndj+mhSNqfQ8AbFWXR2zNzARiSqI+
GBVhhfUK1dX8r5TmlAdOVyjE21CHwfSqstq0eRuH22yH6KoJy59V3U26eJKP3iQu0YOcJOm7SqF1
ZRKyRZUsKNHY4gqqj40WN+BWdHoqH5cjnNjCLvoBZk6vsJfJzBEzhiLcwoSghF+xHnOuphdxfQNz
oShJjErBJBXWD3FFMfht7OhynxV6M6b9ah+FJARLzne3su3Gy0uvlE6lKUSSU2UYtgjkdx4MFdyS
slWKln83LaaJ8+EkKfyg9g4ku5YJvNGUM30yPV0+Kfxl7xyGN4oOuUcCJza2Gm2Z/smH0EWPgn6/
A2PirMYcoh8E0HahMiRXTqYMOW6ePpfuRzU1yJJO+GcONvmvrMr9xV8aslhQRlwM5jgpmuwhSEYG
Lozc4vRGzgoke4tcOXTUGgrf1ov8ZoJExHLHwcGH/b/jtgOlo0Zah3SPX6LuH0EAEsfRMTl/e5ju
80R0Gm5UlA6cbFTUsDJv60EJOENloHjkSmBXrWCqXXe4EyC3n+LPCOf/yaFcUMSVX7XY53nKO6Ro
UlkWWoJlzNs1kI5j5u0aSF/K7XBITV5GtsLKcrq+ngs7p4dnH9+d726p7f240r70rv541JOkJQkk
TNIVpJ6fzEvEEOeAwTiirEvBkQMJvEh0kpxDkNyuCvf5HmWtnmQR0OmDCaZrKeNqz+kqyrT2s1xB
KWtBi5WTaV1oVdXkAgKnDj+YU92VPxZhbl1l1SjuW7IfLyHK3SNR0Jf2ouZJqzaYFHfFag2V38cl
TFvpsD/dBTpzTH82DkYtCdpbsO32B6zjueoHF8BUvNYVeWPMMiICqa1H1Nw3ZJ3xlgK1m6Apdxbk
tguoLuPvapod4rsc3km03bt49hS5XLLL+H/BJARFQRZMmjfQKPKR3K3/8+L33IzZn1ukGajA3RwE
oPhg6HelkOItVVvxvgLo9G8lTVggN8TILb0V5OPiFkIQ6dnRwaEUlBt2r/1Pnqoj72F33g0GA6wC
wHUm//JOdge+1+/FC5bYqBuM7tQOvyssqgIsQRHYWwhpu+n03XCnEYEZNA/jrBqjTtSCmImv/Ula
BP8lraut7PnLqLV9BhJ0+8eTwYUXtn/9tS33P7R/++2vO7/+3+yv71v/ZKeHB3v754cHrauXRRCR
BLGdNe40f/vrUELc+e88yF/bu78th+JoGsfE7xWpo5+xwtxtXu413xTaNs/ffjw+ODx9/eHdefPj
UZncXLvf+Z+/tpu/7fxu/Fm820qhvd/bXwChufO7NbP5weHPR/uHzbPD06O9d9OA8o3sP5v5P/VV
/mR5jB8LPGdWm/p5tgyEE3xgXsmDbOP3FnTrhx/e8IY8H6LiVIi47qDRkPslP7n9iVc5Wdw4LfYc
0ACz4NiEZe8unUXmfqoqAN3D6+UXq4g6QmA49ayBvodD2KL/9b3LMe5YlxuFc/5C3HEbRJLIo9GA
1EHmMK9yu4Ca6kQFTKRf4bJM1x2+wp3bxRMT5HKJOk9B1u008nU7ilq1LR4pVMllr1D+FL3K16HI
bvAV9NQ9uRTWUEVsXU9ua8/1KlgGACRAHkoirdHIdu1vf+I7WSlIMhXclAvyuTILZP+v5ao4mVnB
AAdPS+i6IWBwyd/UyrpE8aMaBmnkXRDcJElrPDoNQfsZQLkYQPbeQOyWVEwlq8kmWXKEhQkXkSpR
GabgkpM7wgHmcQgAp2CBpx9yi/3xsieuVmHQxJfV+n9WUxJKaNs4q4Jr+2ntB5ZkVFV/4APcVT30
8MiDsTfY0aSkyiszSmADLy77mLUgGcLz7WRNUI0ZsiVGuRq4kywh45SPXGmevTw5tZqoRjFyYTKe
7PclpLvCwnVpTRLyQY3sp6t60MBXckrX9qJscW9apYpv7H/wGIps93lyQIEbXnngmI2kTCZXoLM9
ZyVSbfORLMcLkQBIbpnVdor2LXZyp03Eyi5Xd8RlH5WHTDRkTzq1p186GHT1uIgnJyWyIyZyG/hf
yfqb/Fb6GZ6UnjcSq7TizApVDKLOK9iRx1agzFQxiLyr7wA6pCTeflbpiShTWWgkZaqsaBhBYtWO
R6ixiMqnVsw4tKJwTAVihgAKf0losuoGrQByFnS5yei/C6GAvDk6xZqi4gkpcW2PLM5NTVt1SZVR
Ia6bHYzQZItrznHegyTgS7LOPF5jVuPzpkKTrIXhoQV3ZDvmCZqBSLGxmntJjrpR78bhJD4hId17
CFGF7P5YMLO4POPoDGPFUFVrxqrFKV0pc7StURiM3Ct5ME5u9/mNl7CR841zNMkc6eT7fKCL8ieB
pKAqypSSAi08HubzdLFSIiHIx/OYXDlBXWRfsg1cS2svHd2CcshmRLBz9fHwDLdHMKDCmC8YeLkD
i9IzKKRSIY1QMRXLPtp/jf1lW3b7MnylC9wzi2l28hYRm9KsY1ySSCDrYaoraoplRmnkAkUXqoxW
qTFqJRVGr9R6SmWNUVY7ki/NUSVGyqixZ5hmXm3PDJPS9VdqA06WI0mXe4mtXrZeYhFgF/7dT6Ty
Uo7NUFVogyDFPLvKrrWGzPcaEMoJREx5xARpdv99CblhfFiEnKfOrf7iGQ47W42zt3vcMGEcAmKF
C9ztmWvyR2kfL0T2ZK78n8NkbjyZbkiegLfKMXWbpNtjKva3pdtaISDEr1e+HU8TZ2j3VEqoXlcM
5DDl+FXPcnTBkO8mG41uo45BfXGKuZPhT8eKGdLXKh6B/HrJyDxJTUeTi77fxZ4mBOPyblsq1cXy
J0xBVTUX2NwAAGiAIAf1DSherXFi1ear5NCstFo1t/1DHcjVzrePz1YbfALCM9qLWxLiXRHTbRQ0
BPb1cMXncP6j6i7vdQLwgvN/qaGn5/8aFoP3mMn51/MfH+WHu5TjjAguG6j9Jiif0XPqtA27LcxX
zOKWAbZgfU/tNqWNRsWpwNMH2TYqz+BVe4grb7Py7cOT3XhzQqMhp3Lb6bqsMAg5PFYrlursYHV/
MhzIYZF8fy97H4+VXPQ+8pO0EHYDd5vmVoLVHZzwTe/ajUZh2y5tVO7GZY1n4P9VW35X8n99pv8b
BtNF0f8506n51f8f45evdtg/+UizS5Zd8uxSZJd6dmlkl2Z2aWWXdnbp5FDQ7JJllzy7FNmlnl3G
6DBdzYICE6Lg70/38ui0efShuXdytE9KP970IHSoa0zJ5WSM2V4Dly4c/kSZNHNM7r0/OKIQb9pU
IKtW+yHpsL44q1bz0oUxVuBjLZAP472w33EHckrBbtfEXpdk1c5pNRx35RFBTiWPullXHp2cOnEO
GHjM5yVVQJluW3XiEbr+Ku9EdTK2vMlajvn0WWWVrGKVINdr6J0n+0fN92dHzbRcANeEksdFVps/
o+1yo4ZcQvjsXI38gFT84DHOyrUPcU8aMmg+LwYNe5pB65kx6EwzaD8zE+XTDDrPTIP6FIOCPi8G
9WkNCrYhBtlmu8VSd8E0Vuor5HnkJ+8PX8WHOrxSdy5uMZVF5vkjaJc9AvM87iurmZ9iWjyuSbPN
MS2WZ/rLpUTsgZnWl2faqOcorcS0Pte3XS/shZ8SH0e+n1rixNbk257L95Syn3AyxVZjeoVYVo8E
iy3B9AqxrHZJlzF/JCvy80zgxJ3BiMcTTXrN8i9DZ3kF/0Np2JTfexHTCv583fU7113JZ5qJMMpE
7UJ1gU99Hp96rbukhM+Lhfo0nw+fc/W5VgDmlNtPKcVg6vuj03wOP/k9HyveDPostOmkk2p5LkfR
qImzhsaDjgsM/mWYlMv8SpdFVQ48+i+cBzY2FIE4549osVa1xQ4GcunCqEr8GTWsWtlrTpWspEpp
sY8aZHmyirs5NnmJTSxPNZbP7BkzaqBNUWITl0+NJ5DLc6E/HJt6iU0d2Vwre2emZT1RbRolNg1g
03xaXabQnXuyaZbYNJHN+06fct20npI2rRKbFrLJn2oCZNC12LRLbNrI5gOmQMw2zC+uTafEpoNs
1mAQxq2pCqA5bLJypscwDTI3NP9pc/ZF1Mkq0iDMg8yaDTZtwebzWc6DGCZC5oJEiFFmPzmW5/FZ
ToQYZkLml8qEuME2wmc5E2KYCplpKsSFwWpiwvP4LKdCDHMha/O5kM4ek89yLsQwGbLY81ost2Ew
0I2E0dcZblln8tsjahvdq1kPUAwPmyzpX1gMDEuWD9/tHTtU7aEADh92CZl/aUUTrEw6+3jION2L
Odz80ilz7E27bPzd+elZovH1ZNjzwougjxUg1qNmD8xxNs0qm8Uqo19qjdS0+H1YnVnSy3IrZ9Gw
17nuuR3c6NJvd92wR5HlZ1apDX1sxvLe/kkHzKADMRhZfQLrovqq5eHTM7tqkr687F/WLmT+jD2t
WRZjKTOvZtlcgmWOLNcxyZiRLCSPXwd45MKHT174CQKVCwI4xLNkkVv+zLhlCbcfMS6X2BXPjF2e
sHs07E3w3AJyJo/PTBnWnxnDgpBzbzDC4xnlF8HccIibYDGLfGac6kVOU42az4xPyP73BiNlt8if
9R8Vf+3/rPhbj9IyfW4+Qc3qxfGLax9Y5LSe1XMzWcwPdwaKxVyKJKyacDuPRV5mcUZeJOrKYn4q
uOvhyI0vzoV4rVjUCyzi8GWljYq6ePosGgUWcbiy9i5F/YmyaBZYFMii+Ry2GeRYtAosGsii9cxY
zK9/H5x0Dv9xHk+icPuZcerM5NR5XpwWVsELnAr6zDhlMzn9cpND5kY45TM5fRITQ9bDcSpmciqe
mfXqMzk1/sNmv4T5nzL7Jaz/jNkvYT/v2a8a7L2DIYdlzAhGhZ0gpU0S7qB3NZo0yPH7oxpq8TgY
NvFERPk1wey0vwZ592E/Zoc7wor7ac4NHg8omW0bInnBSu5yCMfxGEzAWDxetWaOMFM503RyBWAl
xJiGmaQCpq3HEBhj6V3DTO4SmyVHxzFqp5fMxM0z7wI85Fweo1bg5qSWyjlRn5Zw1Ym/Qx/6Ajww
OM/Y0S8ZY5aRDvYFz4q4s01FItskKezU2nU7fcHQ0+oKzljVdFhuPiHnL7n1WyOrVHAybsz0LkMa
8FMW8oMLeVZOD8/S0zhZYlBEmGmRW67qm+lpHQhz7PRST7mCuwkEZtl6ipxm7+oJ24xm9BvpC/ny
A8PRs7spMG4Bg6dehJ8wnPSnNbO/966dwOR2zINuCCoSoTqUJ+zaiQ4E8Ji8wJxExELYZupszIyB
CWolIuamYTuJlJie3OU0OVqR43V8KVjio1wXib4EdfDdN8kHGrrqVPiMn/N3r9Pdto6Zys62crXb
qXCttKaUpS4KIufZzgyR3s2KW8Cxc1WpqfQdkQLj6RZIBmpNX8jU46QRg1GO3e2713i+ejDuBbdD
5OL0fQ0Dwfm1Jw/2xgP5x0WtvD2tJT+hB1rp94gsV8kzdPCmjgwdeJfAgddTKV2Zq/f7hzXk6r3b
vcavVcrvxhPvM359GGKD5Ockxw+ryWWRH/xsJ6YGR8d1TA1ggOj1svOZifzykN91ZfD21DlVxye1
TEk9ZA3UM8VhzNTJ0S/PQV/4WZTJKGbq5/rmp+Qn/PwQea++kdTDTPvrdyCew/nveNhtM/lM3Ypf
g1j4/QeDT53/Ti3r6/nvj/JrRXdRK/kmXAu13MoyldbVyKPp+rJY8A2FhaDSStuFn29YDCr9uAO9
L6jcdx+EveD17KMQy7ya/1qE3aip/6ffUF8fx1z/Z8Jk2fdfTPgbv/9CBf/q/4/xS77yojFHxB/Q
Bu9Un8ym6TeyYciN38RW/8jvYNtEffsEXkq+evL69Ojgp8NdRsqfgyFVn4Mh1Z+DIdWfgyG5z8Gk
ROvMqB/Rpk7rR7Rt6nUj2tKo7dSPaMFqKGlD1FDSVh1t2qmfTdsar59N25ouaihp0xT1I9q27boR
7Wi4dFU7okX9bNrRDLOGkrZqZ9M61WjtbBqI5sKqH9G6yetHtFlHm3bqZ9NMY8KuH9Gidvk0EG3U
Lp8Gou362TTXaP1smmu8fnGaa7pt1o9oi7H6Ee3Uz6aFxgynfkQLW9SPaJNa9SPa5rUzD12jBq0f
0dxi9SNar91CERBt1W4CEoh2RN1Wt3QDOherfkQLy64f0Ybj1I9oPPe5ZkSbGtV5/YjmtZs1BaJ1
W68f0Ra160e0I2pn0xZ0LvMGto4i2nliRM/vXJ4o0Sal9SN6fufyJIm2oXMR9SOaz53qfaJE437A
2hFtUbN+RDvcqhvRDnQurH5E42bs2hG9YufizCSazyLa7Y79T17rgD4AtTbndaHWoKt2J1+YWm5a
NaJWd1iNqLWYUSNq56+kPC1qmcZMXiNqhW3UiFqTOjWi1hb1ibdco4ZRI2r5asnNAmozyh6aTt1x
niKdo9CLcD9xSqf1oJnM5uh0dL0GdAroBZxa0CkcUQs6TWbVgk5bZzWgU9eoWQ86+YPmJ5uj06BO
Lei0hF4LOh3DrgGdhsZsVgs6dWrWgk487qsOdNpGHfojU6O1sE9TE9SoBZ0Gt2tBp6U7taDTseqQ
f1oac6xa0KlzvRZ0mrWwT0uzrTrI09bYg66bbI5OweshT6MW9mlrVk3s06nFPJij8VrYp6Ppej3k
aVr1kKftPPm8Tn26mIta0Cl0qxZ0GlY95GnVwj6ZRp9+/JR08qcfPyWdei3sk2mmY9SCTofN8SOd
SjrVP1+STq6xefsKnhCdczf2PyE6DduqBZ32vK3OT4ZOMX/H/hOic+4m/SdEp14L+xSaNW+d6wnR
6Yg6+JGuMYPXgk5h6bWg03DMWtBpszr4kTG/ZvgJ0clNoxZ06nY99G7VIg8xIM7XIS6Z8/e+PyE6
hc1qQadJ66H3uSemPBk6LY0aei3o5FY95GnQesjT4nYt6HSMOuQhtsYsqxZ06pTXgk6Tm7Wg0553
yNSTodPRqGXUgk5B6yFPg9dDnnPrwZ4QnU4d5hkY1Zjj1IJOnYta0Gnqdi3otK06yJNptA7zYECn
4KwWdBq6UQs6LYvWgk7HqYM8ucbrME8LdOq6Xgs6zVrYJ9fsWtin0Fgd6hmATlGHdQSg0zDrIU/L
qYM8dY3Wwj51jdeh3gbo1E2zFnSadVjnAjodVoc4b2hMOLWgsxb1YECnYddDnnM/5/Jk6DTrUQ/G
Fhx9/ITo1O16yNNivBZ0OqIO/aalMZPVgk5h10OeJquHPO1a2KetUcOpBZ3cFrWg06BWLei0BK8F
nY5RBz9yNGbTWtCp16GOBeg061BnBXTadahj4VSjll0LOkUd6liATqMOdSxAp2WwWtDpWHWQJ9N4
HepYgE69DnUsQGct6gSATrsOdSyca9Sxa0GnqEMdC9Bp6FYt6LQsVgs6HacOfiQ0Xod1LqBTr8M6
LNBp1mE/F9Bp12Gelusaq8M6AtAp6jAPBnQaJq0FnVYd5sG4odE6zIMBnbwO+8qBTr0O82BAp1mH
eTCg06F18CNTY9yqBZ2iDvtlgE7DqoferVqM4yyNcl4LOnkd6r2BTt10akGnWYd6RaDTYXXoN+16
1IMBnbWoBwM6DYfWgs5a1INxR6O1GMc5Gq/FOM7RdLseep/7TeInRKdTh3oGQTVm2LWgU9j1kKdZ
B/sEOm1Rg7gkmEbrUM8AdPI6nMsBdBqU1YJOqw7rxUCnU4d6BsE1Vod6BqBTr0M9A9Bp1sI+uWbX
4VwOITRq8VrQyR2rFnQavB7ytHSzFnQ6dahnELrG6lDPAHTqdahnADpNvR56t+swDyYMjdZhXyTQ
KeowDwZ0GsKqBZ2WWQ95OnU4J1+YGme0FnTqQtSCTtOoh97tOpyfLCyN1WIezNJELebBLM2ow/nJ
QKdVh309wtZoHfb1AJ28DvU2QKdei3laWzNrMQ9ma04t5sEcjT3tebBvvv6e7K8ntdUEQwluvV6T
NjnlJqOMNqlj2MxsuZdjL9TGn8fr46DwM3Vd/gu/6X+pwc1vGPyHC2ZSJr6h8I9hfEPoYwhgEo3d
EEgJg2Aui4ue1/S3u7tLpIoJXDVQ+U3QPaPnSXB5xRwYNgrHpt9Tu01po6FMphObzC5t5GNGoxAz
GtUxo1EdMxq5mNGQ8axNkh8ENnJ4LC+9oXvR93rq/mQ4cKMbryff38veJ3Tx+8hC0kKnDQiPufbx
HQyY6V2n0VCRszMOxm4fWE/i50Xo9668+DZvPDf/b47CoNv0h3AZTkbjaLV4gD6uz/R/wxIGLfo/
Z1ynX/3/MX45gyf7Jx9pdsmyS55diuxSzy6N7NLMLq3s0s4unRwKml2y7JJnlyK71LPLGF0D3Tx1
TiZEwfuf7uXRafPoQ3Pv5GiflH686UEgUddjf+CFyKTZXgOXjqcvP00mzRyTe+8PjijEmzYVyKrV
fkg6rC/OqtW8dKOxF/hwPfKH3XHY77iDHrJqt2tir0uyaue0Go67FHl0KnnUnbry6OTU6XZHPvCY
z1KqgDL86muNeISuv8o7UZ2MLW+ylmM+fVZZJasMWOV6Db3zZP+o+f7sqIlpVVv+v8bTx0VWmz+j
7XKjhlxC+OxcjfyAVPzg8d7+yVH78BMOIoBB83kxaNjTDFrPjEFnmkH7mZkon2bQeWYa1KcYFPR5
MahPa1CwDTHINtstlroLprFSXwEveeTk/eErMur63vXolbpzcYupLDLPH0G77BGY53FfWc38FNPi
cU2abY5psTzTXy4lYg/MtL4800Y9R2klpvW5vu16YS/8lPg48v3UEie2Jt/2XL6nlP2Ekym2GtMr
xLJ6JFh8CaZXiGW1S7qM+SNZkZ9nAifuDEY8nmjSa5Z/GTrLK/gfSsOmg8NZMa3gz9ddv3PdlXym
mQijTNQuVBf41Ofxqde6S0r4vFioT/P58DlXn2sFYFsI+ymlGAzZpKUAPPzk93wXuDTos9Cmk06q
5bkcRaMmzhoaDzouMPiXYVKu8ytdFlU58Oi/cB7Y2FAE4pw/osVa1RY7GMilC6Mq8Wec6rWy15wq
WUmV0mIfNchypm+aTV5ikyOby2f2jNni6WtTlNjE5VPjCeTyXFgPx6ZeYlNHNtfK3pllWU9Um0aJ
TQPYNJ9WlylMdk82zRKbJrJ53+lTbnD+lLRpldi0kE3+VBMgQ1+LTbvEpo1sPmAKxBxD/+LadEps
OshmDQZh3HKcZdlk5UyPYRpkbmj+03bsL6JOVpEGYR5k1mywaQtjPp/lPIhhImQuSIQY7iWoUVrL
yokQw0zI/FKZEH57dBN8ljMhhqmQmaZCXBdWTUx4Hp/lVIhhLmRtPhfSmf6IfJZzIYbJkMWe12K5
DTLtRsLo6ww3GzGyHwzHYdDve+GrWQ9QDA+bLOlfWAwMS5YP3+0dO1RtogAOH3YJmX9pRROsTDr7
eMg43Ys53PjSqdCp2LTLqvlbc3qWaHw9Gfa88CLoYwWI9ZjZg8BjWzbMKpvFKqNfaI2UUa7fh9WZ
Jb0st3IWDXud657bwZ0u/XbXDXsUWX5mldrQx2Ys7+2fdMAMOhCDkdUnsC6q6+a6hpyfpC8v+5e1
C5k/Y09rlsWw+Nosm0uwzJHlOiYZM5KF5PHrIIjG5MMnL/wEgcoFARyGYRAit/yZccsSbj9iXC6x
K54Zuzxh92jYm3THQUjOroNwnDGsPzOGIac59wYjL3THk9Ajv7jh0B9eIafGM+NUL3KaatR8ZnxC
9r83GCm7Rf6s/6j4a/9nxd96lJbpc/MJalYvjl9c+w1cBa9n9dxMFvPDnYFiMZci1XBercwiL7M4
Iy8SdWUxPxXc9XDkxhfnQrxWLOoFFnH4stJGRct8+iwaBRZxuLL2LkX9ibJoFlgUyKL5HLYZ5Fi0
CiwayKL1zFjMr38fnHQO/3EeT6Jw+5lx6szk1HlenBZWwQucCvrMOGUzOf1yk0PmRjjlMzl9EhND
1sNxKmZyKp6Z9eozOTX+w2a/hPmfMvslrP+M2S9hP+/ZrxrsveOcT50mNmMnSGmThDvoXY0mwKX+
LEKuWz0NVNhMyXTzmbDKK1hNdkQz3X4mXIq5XDrPhEt9HpcrbEbTOXWeKJfdaufMthYevz+qoTaP
g2ETD2nFU1tJduZog7z7sB+zYzq6FWvFMHlSDqNzltSLm9xKArhBDSu9S5PqTN2wkwPKBDXTigPL
NNMNloYZV8KCU+hxM8b19FRFy0h3YDq2Fe+NYLZD47vMMm2A+y7oun11lmOBm5NaKufECy+DcOAO
ux4ZBEMfElLIzgqMHf1ylJ2qK5I9IyDlRMjMNtISdZpucuTCZullWtfFefoCKDftkxnNXaZTuMLJ
ZvxSYKC+7NJIh5gi2zOio31A4kJug/CmwMrp4Vk71XZaHgqKT7DrhpOAESbL7qZFwHA3GeDpzLTS
u+k+QgaCSS7NxOLg0k5ZMbMAZJsp0VZqfIymLzBpfKde1L32epP+tGb2997F7NjUSogxbSpiXAaj
iXXrup0ISDcNXU9YMHQr4TGVq7AtPWlG0ypk3H0QS0Ewkfgo5zZPkiyR1rpwXU/e5VaKWJimgHff
TIbdsR8MCfhRv8DP+bvXqaUZqU3pOZtyjEQ0EBBSTbF08wFYV7ZbgqaXzMzt+EyFy5JDajEMpNLn
dvaulb5LnfRdlkYXJlBkQDWJroNg3Atuh8jF6fsaBoLzaw/CQJ94eAhWUStvT2vJT+iBVvo9Imvm
8gwdvKkjQwfeJXDg9dS4sszV+/3DGnL13u1e+0OPQIDr3hDvc9cbYWyQ/Jzk+GE1uSzyM4JBM6YG
R8d1TA2CaOz1slPiyTAY+5d+15XB21OH5R2f1DIl9ZA1UM8UhzFTJ0e/PAd93bo33mQUM/VzffNT
8tME9EXeez3fRbUBJ1+/QXO/7z/gWdfNbjBBW4lW/RrMwu+/GHzq+w/U5ObX7z88xq8V3UWtSz8c
3Lqh10I1t7IkoXU18mhaX7LoCywLQaWV9uL+oNJPvdD7gsp9BUanC17PPhGzzKv5b8c4jZr6/zh0
u94mv/8kBKes9P0n/av/P8rvWyIVHLbJZTzMbnzb+BZ8aRz6XgTJQfNicgkDiVZy5zb0x2Nv2MZp
hxaTQ+ZvT9rMlM0W/DpN/O3+SPzwX1EzuLxsvX7b7PmR9NuFzVuqPTQfemCqoZrlWNTsj7gdNLt2
wx5gbkXB5Rj+XdgybgotR6HnDUbjZg9GG9eL26mG0G7gX4WQgiQ8LtESm+Kv5/Xdu8L753tnf2+e
HB3IP/ZPPn6r3v8Dnhy9Pzw733t/Qsibj8f750cfjqcx/QH/l12nLeO/4vuNfIsLN7puCq4m7X4F
P/2NaJrGNDXhozFGuQPxHK3HH151Bm5400Hb8Nrkl9Oj86Pjn0jpQ2EL4PeK8IXO2iQcDTqg6ckA
4BbOsr3su1dRk5LucAz/BXmN8B93Mg6ajOA1aBgfX/sQ3lZGjQsEf4PIAGMy6R8/NgioU152ZH7c
Cd3b5ApIlIF/6PblaxnN8s9OB/+G1MkfePn7RfF0onEQqgc3AOoy6lwGIyXRDvwvjEF9NvUO9Dvq
gQIT4A2cG+uYuryDrnrXOfvfs/29d+/gZkfmcJ3r28vQRdwriiLWAkhjPImmtKBu7p6evO+cHp59
fA9qXxk+r9ByshVVaVmXWmYPr2W9grUE9QzWbnCSGOLhxNTbtJl8q6oCPhcGnoWzgDVlwPx+rOll
1I6xHGt7EC5+PlwZuqOg+71+NVtsM2yZgCiW6HgSDtHtMkK+p58N0aKfuY32mSMJXt5tylNeVtEe
pCLVuJQ2AZvOAJt9WYGNrcwXXxsXXcSXhr88rtjqJ5F7Va09Yzl/W41LYQpcQl8mlKxhlAi9bJTF
zoI9RGdRgdiYb5ScsbxVJjSlulsJ1Wo2WcK1tP0jLrFAnnwFea6DeCknvx+LSQegvkRayaW7KS71
ai5jWlJdegvs5m8olh+byTRYguyaJ8i4SR2LL2bUWd09lsN9X0ZnStUsSlUisx5Jo1W4lwxvZx/P
Tg6PD1ZMKLCigYuVMBwerIzAWKpjp0t1DesgXqNjNx8K17IGmcfF9KawnQSZyCEzTI061NCth5Ho
yogXRNGpXmk6o1gN1SKr4Zvi0VzTatbGVIwrRS7dTXFpLZfLF+LK0hgYNR3DWQmDjCsrIbDEai5X
SnCXmpcAZNyghsOr5yVCz+3dtcnpSeHL49fBmOBHy6e/Rr7a9IWVJ8PBMMPxqMUqMk7effyJHHzY
/zs5/vCLBJqIkult3mSWEQuS5RNA09F0y3BMa+GQcqU0dwXUFnu4MYrVFHHtz1SITnDpC9lcN/tc
iNq536TAXPi2rZv2qiPzVaBb9OG6m9UQ8/t0N6uhEo9kiIhLf7iubS3Ea3Vtq2EyHrRrWw23ee9+
IUEHvRAEMItUDJ4trnGbOQ5dOJ+82hTBCqjtzc8nj7o+PPE6fT8ad6KuO1R3w6DrRVEnLgn1eh0k
OpLPFPmd8TX2jGrqOXcNMu5chsGgcwmvle903Giwmhg4nTV9t870RcG0zApc+kJtP4jvVqG2Hk7b
OV3fJnrYuE5XYtZZfX1gFfiMPtT6AFsZ9T1ngJfG5egOs1adG10Juv2Ac6MrIXbuNTe6Cir+WMEF
cbENzY0ui/j+c6MLMfHNzaQtxC3uOWWIy/zCaKoNX82kAh/GNSy3HhIjw+l77DuvRyokT/tePxjj
lNIrVRjZ3t87PeicQDQ7PD5vrIyLr4Tr3dHx3zsfTxaimZafIRb2ffoKK3QrobYeJdMBQjrX7hCs
vjOCJ94QwAch5D7Dm04XHlwV3oSMSP4JjMQ9Y+dyOHVn3b5yVeGsGaLYKqamM5tyZdaekkmVtY3v
Rl5bf4XzIlEwxKvuJOxcTCCxGHler83pKzJwP0/dufV74+s2mOhl3x93BkHPa8PduNs6ePfu3d5K
5qozh2fTeAvMVSzVxa+CGr/7sWlz7XR63icfALpjQHStqjbUHX/oj323DzYcXKiXUdjyr7hR/m23
10sz/YpbmPN3In941S80zh5BdMl7RTcYXvpXk3D67fr5VqLJx/Eth9sVS+hFezWWC6+rYebUsc0V
vZo+mlcXSWVUn01qfHaCJNVISWWrkKpXk7oilcLG0yhmUOnmqDRXolI8MJUOVk7MppKtR+UDy1IX
Ol2RSvoFqNTxvOjZVPKnIUvdmStL8TSoNCxzHpX6F6Ky0DVwQ19iKmgj+QWgRmN7UvkFZgMoa0gc
ppOE4u3omaYKqBRjc6lCCZe1pO3pD257nD6K7YX+Jy+syFln3J+y1rh9mvuCTjueuv/pq3WvY92c
PVIiDOO2pB5xUSIsHjgRBsz8y6TghmPoK2aM/NEzRgHZ95KaYQ8bdnKYZ86NGivUkK2EmK85NxrX
kC1V1GjbGme2KcTiRVNn9TLq5XBb6y+axnXwy5TTMOZognJZm15Vx4ILOu/O2+Rk7+xsamDnDSHS
hHLz9RAPN3T7/Tuw7/F1uajm6xbsp73/EzcjeX2tH1xtZv8nw7MWren9n0DF1/2fj/H7VZXFUodT
Q/+NvP1wdk6mbGLsReM5m/p+jQvvBLOcuRDuW373a1xaZ+imI+YhKhbYYTOLaoxBLEvoU0bdzn/a
kIDpt8nQu42TS3IZwLNXBLr3XhDu0s/sIn6C1ywHVqd8Edi/e0Oclx0HQ3J2YIDVnxvk8H/Iee49
gxwE3ZsErA3dGWdzwdI215iiGAK7PF6uRHLPpRnRti2UEC2mQeJGub2AbLYufK5xy6RiWizYiY/w
7OJ8B9yO0+c2OesH423aZDttsu+GPaJS7nEOpODrg3wHyRr5OEqg6Rh6RBlaoR9rk19tapttw7LN
32RWRygj3b4bRYR+piYFKOos1DPo3LrXAD8ag5kPyAkedZuhYraxEBXAIRehj8c4jgPyK+SG8MJv
OSDCsRYCIQmIWx90dEt+xW+1Aqnwa8I/l5eXeYiGEKtDHHiDGGIClSLcImTTcB4QMjH1C3+MBlFA
Yi0hVXkoBJ6Dd/h5LMMLOYfULAfEofZCINFkhEYWkQNGDnjWGHxosUpO3h9+m0AA9Di0IwdUgSIq
/qmIl4PLuLkQLtfgT/LTRSsi7ifX78vjMtXBvDBklYOJV6TvD3zEenEH7xvkp3N4W77zmREcvhC3
6Dpku+uOJKTgktgZBpm7TUHQJYSdHNm8FGDLZO/1eqgOMHE/GAwm5CoMJiNiZVAgTNOFUGLLSQbu
6ogpf/jJ7fs9sh07TxP8ZwdHYclreI54hofT2Tbqruf/B3iiX1UEEEKYC5EtigBCN8VCICtFAGE4
a0BcJgIIawmG7xsBhO2whUgWRQD4v8V2MCsC6JwtFuAaEUAXJl8Id6Er6QabC4U9pInrpiEWIltk
4rrl0IVAVjJxrKxbHeIyJm7QOeFudcjVJg4aXEz+IhM3uFgs1VkmbgidLdbr6iZu6PpizhaauGEY
c1njD2nihmk5C5EtMnHDcuyFQFYyccPR14C4jImb1GIPCLnaxE3mLFbhIhOvHhtMAZll4qauL6Zg
DRM3DctcCHehiZsWnasE8ZAmbtrcWYhskYmbjrGY4pVM3KK2WB3iMiZucao/IORqE7cEtxciWWTi
lj4/1Il5Jm6BaSzW6+omblnUWgh3oYlbtj7Xe/WHNHHLMe2FyBaZuE3np576yiZuC4uuDnEZE7d1
x3hAyNUmbpv6YiSLTNy22WIZzDJx2xGLjWgNE3eo4SyEu9DEHWbzteaA3CaYaw4OdxYPVx5geOzo
S2S3D4HHEIs77ofAYxrGwkD1EHgse3FgeAg8DuVrzShcFOyJUapX6LmjSEBYF22syxhi+UA7DwKc
uUf8iExGPbnQBwjoRQ4umxN0utPTK1YS0mkW0rtUiDikHw57o8DP5oIBvJgzF5KAf713Smh1JKNZ
JMsLQ5/jpN3lJhQYJLTWQiCVcagq/DDIUJyF4J7cZCADxbKFZC+Kmow6Nl1rUqFbtHLGLD7Xyrtl
K+/OsvJuDq6w7LVGhL0p+kxnPn29Mn29GfTxnBcy22brpPN8Sn6cVk3uZPTxsvz4LPnpbg4um5/X
z8rF9KkoxkXVZG5Gn16OYvqsKGbaObi6YHP14pb14i4D15ifLUnvUKfGooOsk5rlIv5vZHsynERe
L+ef3JyfBa9JwUK0lm0vdOiHYrxbSYFDnWUTjmm8bDm8vSYH5rHYMPL/7REuW8m/oYO/GhIFJiNJ
UF08GEn3oYOZ9rI50nqigaCguyuRxG3nwUi6Dx06dZZN69YTTRyPViDJEPTBSLoPHeac2Z6pBbs1
HcotkmQuIknnlvMAJLFph1qZDp2tKZqunsa43sWloqNNIDMGNF4uO9QNsSYGs5uLo1aMo6iASoSm
bq+KEKc9pMDoZyx+Abhdd/hyHEP/gQwDEo3crpfDYpni/lguIRNWfa/ClINvW9YjcOE4dJNcGGz+
ZC1bxrzgcrZ5Gdzg6/VMXT11pO48AzaEpa+HoWjAzDDEUgZs6I6+Xo/S7WY+Kbw5LJlszT4LudBT
lkzXtZZjydLZej1BT1xmYaY3hyXbFOthQC7sfJi5WI4lx9aXneaqcB22nIOajBn3xzLbQU0u9FUd
dA0uhM3vj2UOFytM0d2DC9N8ACxzuJCzTKt55RpcOIzdH8tsLiwq7FUdcXUuLGay+2OZwwW3+ea9
29LpRr3bmpd7PZh3W8vU1dyHC8uyNu/dlr1E1cM9uLAXFOM8jHfbkP5u0rttbpqb925bOBv1bttg
+npLE7kZPdvU+WoT/MWcNj/BX5VgwADAWG9mOU+kQ+m6JWBVKXgG2Vlgz3MmlnlejA7T9XUreKpS
+Bxkbq4NeYnUPYdI2Maac9i6m4dj0LVrSKpS/xxkk5vrQl4i5c8hspZYZF9iutyx5+tuXkVA1ZAh
B9lZYkKfrD1USBHh4YwPsZ7OKRfmulsVqiZpcpDFEvNiZO3JmRwi3RLL7YupkoczJQ+jqnOoAjaj
usWNBTIljMoitqXALiXrysKRFcCvJnCnNMAHybbJcaARTsbhXdYrkskw6XtI6EV5GMvuj1ooZdxa
1/fcKF8fwBk12GZXmEjy5cYFaz6cMXsjpCyNX1C22TWnKlK6laRUVtUsrXWmKDBmTNNwtsyOrvUg
m/OrtRdCZjMhwwBnnfEN/cwVZD4Tsm2b64w56GehIItZkAGzsc44gH7WFWR9JuQF9f76TMjGAg1y
vsSS84KsnHOx/hakvCHkIOrzlbRMHs65SfV1t43krSgH0eJ8I5k957bOHiCz59wxnHX3EeTtO4Mo
qM03MlbgglP6GGMFLgSzH2CswIUurHUr2PMunoNoGOZGRh/gktajjD64sBz9AUYfXDiMr1s7nY9y
GUSdCnMj4xmuM8N4lPGMzi3xEOMZXdj6utvEWbVw55WP32uEpJvUepQRkm5VrcitOULSK7fIrDBC
miFmpyrkPNgIyaBV3f+mRkgGMxaMbkob9ONjN7ZlSUXzR3xN5DJng5sL6HeXgMjyEIUtFkJkK9Go
O85CiHwliJW1xFUQ80dekG852RuPh6/HwyY5uQ33x2G/Sd6fvmvK20fDnrwt/30bjE/6k6vvydkk
HIV+5H1PjvAcwH7QvWnCiHY/GIz6cO/iBIavB37UJO/e7XXHp97o+xyZllisHLES47axJMQi4+KR
GXesxTakr8K4SR2+HMQi4/rjMm7yOedmdJfwRJ7nWZRC3+dr/EpCtzcF8fNbiM9vg2hM9oPhOAz6
fS/MwSkfkDADDp5q8/HsNdbuktC78iPg3+u9SodN8sFwMrjwQuLkEBj2koRed7tk5IbuIIqHGNZl
l8Fdn3zywgi3e0A/wCn518QPb6JsgkFW2zk2ozmkVmlJeT3p2MJ5eOkUKHVK08ozMEgi041ciEto
nBwOr91hF+CfTUZeeIYnI2bArbJjTKIL/J/TJscxxcWzm/zez+qoItYzL/DPkzDoTbrjXRT0K3LR
7R2ow4uIpVGeQ8WtpVFFY9yXE7XJ+8twV7wiCQqAf+aFvts/lnLaPT082Ns/PzzIYdFLsT3DEoNZ
pFPLsGbDeO8OJ5dudzwJvVAegDT5DIxyzWnyZtftXt8FkdRPE/STA2mVplIzkHmW8ATAEk92aYH0
enJBnCZty54UBYc3pIJyzZySbgvNOFGG0vPGXnectwqbiRkCwO9GrW4WYo5ZQN5nL41rfbuw9VJn
mkOzpGHYRmklOQdkPcuwLUpnw1xkGrYtqnSMJw3OtQ3bscy57WYZh6mDcVQR7DTjc82u/avrpjyA
Na+5OLBxeBf7riSCJWAtC1d2ZoFdaHFGN29xhk1ZweKAI5bDpJvOkpgK9saWtzdAYgpzFpLU2gAT
noz/dnKRa2jZfFbDooW9gUyiG5B3wZUP7B8Nu1oOSnmWVvk+m2MWliXKx/YUmhkzrMK2dafSNcCg
YrPIeh8CiVJEfvKGhH/mK9iI7Zi0Mi4pJAuMxKa2VTASC//OGQl0oTSHChhaFtW6VgJYzDlY8mYi
yNuPr3PtHHt2u6KVYBbah2gWgubkltgMisVKVedxEJhnJdBOCGduO73STIQmuFk+hC0hXNPnGQqr
MBRRaShCs2wjO3ezCs0CU6G61cubig3j7oKpOBrVM2Q2Fc7yyNYzFolHCHsOnoK5aAyjSv5MYpID
pDvzABXt5+ejPfLOvYhUhClDc2i5qCaxBoA2y45kS1Fa8JluOcuSbMOhhl0dJxNDmtsRzbIdx+aM
0tmAVzcdNtN0wImpsJfGta7lABpRmRQ7ZcOJu6NKw8H6FsuYDWcluwFgZqXdOAvMBhrapbMMpxpW
W40uxzulkOcOelejSXzUeHpEaS8c/EYO3n98Td6eHJCj0/8hXbffv3C7N225KbvjD3ve510rAQ1Z
kW7O0qWhDPJy0u/PNEi90iB1zcFhlTMb8OoGaUx3eyzDxcrnt87GtZ5BSjTcpLPRpAa5zLG+Elx5
w3gOXNEus1ODc+11Zw4583JwQ8Mt+TO9gi+heKNS8YbGLDx8fzbgFZNigMank2Kaw2WUyjlm41pP
8RKNac6RVap46PMBTpe89sHnAjy3WFGdA2RTezagBYlyAoYLCMB0ZleolVPXZf0WYFsVZ2AWYa/u
unpBg7ZGRYYOFGitgm5dJQKm8sFbRUzFVGRWjyJB6bY5F9QKnQrCs+SXb2ekFNrstFa25cxe2La6
azE0AeK3Z3lQaklzUxJzhiXpplkuOyuAXt2QxExDgl6sLMN52Na1I0DEZwaDkhnxOWYEkHQxl+SV
rEi3cMpqVoYx14igKTMXNp1lQwa35/iwWHV4NKtjMUzoC9gcNIvM6aLn5s3JgYw5b04cx4gpMtui
5grI1rUmwKPrYg6e1JhOPbc/9m7I6fk7pHw/B8Fk9hwIRSOqaG4Z85rPTyNMPN+dz2kul33koUFK
Uk31nS48BuUji/eNaCk0w6C8wre6Qei1c6sP0qLkF8qAMS/+uhi+2IzGQehepR2uiR8PoXPIi2s1
l6XPdOYFGb5EtLRmWLdVtctjbUFaXNDSzH3UjXxyHURj8OWJG+Xe5VVDgCWFngNkCDonMi6R+4me
KMx16czJeyhzNM4ybGArYgVssybh2QIXBURct+chSn0UJ62u1KeO9l386FEOhk71eTCKXrr3b/j3
1v3k5QAY84mY76fg4xWW+6n7ye95QQpEhvk3qBXy8ed9SLVZ8kmPMmtkG9XVRh3tpFhMWuG/ZSy8
iMVYDYst5mpeLOGF9gwvdJhT3gVeAL0wZzG8wioS98yZwxcHF3jtFbCt28s4GAXnSiw14X+8/vAP
sre/n2squD6vadFy33s93z2Hfiqb2JdAdOHMAzLfeh2DQ4JSFc5oW/0fOfBDSEqae92uF0UyL0p6
OnL88/tDcrZ3vgex9Cd8gusq5OR/2oSSveOzozYxU0QwHCnN9Ea9DM2vUc/9jTDHEAY3mGkTg/Hm
xd3YI30cprl9coGlE6CibdQ0OX/dcgQnP/mvd3I4RKmuu4zjF/ywGuoFky08PSy4vMyBMEpfBCqD
eB/0PJDsMII4Liw8TxH/386g2HQJKIoQXAn0kl6oJz9n2Cvd7AVehNtN48V8cnDygQQhefNxL8Vp
z/DdZLhSMZ2+/JDDccw5nWgMfcU0EUYdBQ8WBQ92TG7YCxBCUMMT4OShleq8xNvXYDHRiRfKWptP
YDV4qCJ0rvEpoITnOlpKIPGLvPEYOabEGxH62QaXSW6NA8LMHEG6zh+eIHEPgkzBV1PJ2mHOMS2H
LcCVH53Bgxaj8L+fWlwzfiLv9o5zsBzhLIA1lVqrDD2DYDFGF0CYF/dMDYYgtHTOd9lDT0Lv0gsx
RRtAUjiYDMhR64PaoQ3hiWB4inIgy6UmZZAfRmN/AGYwDt1hBMAVNCEMQ0AwnwIJo0c2u3dZZlnD
qXRoU2NVH9YAcl2k2WX4H47/EfkGpWLBMnt78vPBWFy0f3aEg4CbFADorGowW5kNx0zEqXCIC27N
7uVV5PUhZgdhCtOYMcmVCmhhTKJGPiYxcMNCVmFq3MhhK5d9z8O2nrtJRIY+l61s8PrhJ/Lh/fER
WPj+4dHPh6c5GNbsdauyj+2dfTw7925yzW3Dmdd8voMxk1mlL6n5w9FknKIq007+7t2p2V03Iq34
E9KtUdePS6db+RLqVr7CuZUvJW7lq+BaWFLVAqpbkvJWTH/ybzt+X7Tpa2q02d7+IR7B+7olaVX/
NXjCFec2tWcLlS01UIXUv9onIe+h5cIuv9e8ime/K+iMhfoKXgvdWxbPQ709OiCfYJDBMon+OlPq
v5FgKIf4ebHFUpLAaY5AvXTQwUKlPqYuWYUu9wu6FHlmjNWkvT8lbTYt7ffBJPLuI2qWUQdDGH0l
6g7kCyBp6HgTCvk0hSqu3YfEzBkMUd6gudAa9oMhfiA9TOrpHtU8RIV5HBbMQ0+4E1QvF6At5O7s
DjqxwRPlzcjxVs4rnpQfL2bGzDPD9XozY+WZWd3qnhYzdp4ZfbUYdpiLsDKSsSSSiYePZCJHaOWC
P6AmGeeQ83SDSb+H4/BLfwhJylARq0Zw4WSUDf5SyMLQzbXn3T8HQ6/ZC4ZXfS8FiLWsCzKQFcfh
umfOqgAx5S780jx/KR8vjLzwg8LjdaYZAJthlidO5nO33uSzRCUsMR9VYUS7N+n5Qa61YSxoXcyv
4wqGFADO6DrVjp4UO6RYH7/TZK2Ukewq7/0He2390DTQZ98UvN9JOXTAe9de/ZAmloGylx86lkB1
e92ON7720lGjgZ8UNu8DbtgdZMD0e9J228sBMyvnrZcHNrjwM2gwWlnexp6sSZk0z1CpPrKiQ8lD
mu5QeNKh6LM6lJJoZnckyEuxK4FRs13aAiyNOR8jQWLQVYwYj+iETXT8H6p36A6Sr9SAwaZsm07F
Z+SXtopo2Gsi8W4+fjlmRaFTrrtJ1w/kwhU+6AzGltnBpdGO2+tBjMeQu7dP4j/SCYAm3uwHwU1E
okk08rs+jIk0CFwTSZjnj6GJO4Lr/ybn1+6YDNw7cuFhj4ozL9CbdiHY+T2gfIQ74aCXCICNEO50
Bm53FydBe/JjTX2/G0+yBujdEbDvhhd3kkUbNITfHJxm8TYIb/418SaeuiSXk2FXsaf47oxcH/uT
TtSF3v3X3BP81ohs2UNr6Hmj0OvK5bQUpEY+wuAvkiOAzu/Q+3VHkz96l/0/O7f/ArXAbTdeRwbq
BJ6XtJ6ddF2QBognLlgEYCa1y6uDv3588wt5/e7D/t9/I78OvbHkd+R2b6BzHnhjUMLYBePpuVhx
8lsCCuuoS7vE1gGFS5x2OXVYBxSXoEoDlvVAcUhoSgdnrgdKt0T5RIzVQTHcaIxFvbzKH6/8EYH/
gRfCfzujMMBluM7oZtzpXk+GN578ZNElTiQPA3Ctfj+QZpkDXLHtd66jJ54Qo1LQ2yT+Oy6IaJOm
xXJIjNJizVJIurgL2ht7EFgWYbB0azPycUoZ58PLBz+NtUn5MKwJpxuQDwC2SrvjHlo+gMQpnX7y
gPIxEMMm/EsCFqU524eVj0RilPYvPaB8TA3k71R78L3kg8tGVOeblY9EYlFnc/KxNZvbpvPw8QcB
O9TerHwkEr5J/7I1B+RD6QbkA4Adrm9YPiAdJszNyscR1W5wb/k45c17G5CPaesblo9tbsK/HIEJ
0KblIyiz6Obk46B8LMt5cPk4SLpubTb+SCQW0zcqH0Edam1EPpCgWBuXD2O2uVn5MMGNzchHN4zN
y8ekm5aPpfPNyMe2xMblA2NavjH5MAoY9HJ14b3lowALfaP9l0JiWM6G5WNZbDPycXRn4/Ix2AbH
7wqD0DdjP4bBjM3Lp3wux0PLx7b0jcjHpIxtXD4m0zcsH5M/fP6jAJe/X7UB+Rhig/FHaJw6DzGr
GYNi9GFAmaagxoP3qgqwITY6KlRILEdsUmsWYGCbkI9l6kKwDcsHkBibzDp0wMBN+vC9hgTsbHZW
SiIRG+1VJYYZk4/3lo8wON28fCxmblg+zsPPSknAOnU2Lx88nmaz8tF1viH5GMYjyMeim5aPLazN
yMcx7Y3LB8Iz26x8DG5sJv4Y5a/tbkA+xgZnpRQG09Q3I581U5PV5OOIDfqXIbsZ9vDykYDLHw97
WPkgEp3xDfbvjjy+Jq0G7olu0O81kddbr9ccexFu/zk8+/juvE1O9s7O2oUz/4k3xIpBWaIydMeT
EBreqXIZBakTQ9qljW++/jb7m9IdbXLKTUbxdF3HsJnZOj3cO3h/qI0/j9fGgcqH/vyb+Ijz6X8N
LsxvmMFNjpOpTHxDmWEx/RtCH0MAk2jshkBKGARzOVz0vKa/vb73ecrtyF7rNem6IywPbjTOwZvJ
J7ePhWkl9zz1okl/fF8nb5xf+xFxw+61/8nDIrux6w8jEgyhxfjaS0fvcSjT+sGVRsg5PJkMp541
4Bm5dSNZbDjEM2Ql3r53OSbBZIzVexJkgswdtxuEtFC5rUWu0FQomqF7iyQ0GscB6Uejrv9KfjVG
7Zpuym8ty63yuGEei/Ve4X740OtiseAdicbeSFI48sLLIMSyyou7xhglEHVDfzSOWbt1x91rPGGA
RC7GZFDL/glikdWKEQCHC3/gNU/eA0yQ86usxH+Ehe5D3C/qDnvyRMhxMHb7EfEkCVTjJNIajXEI
pKJnk+1PfCdReaRkDhJpyg39cAc0SUbu+Bpl9VcSjgad+GbfH8L7wEbhEzLQ893KWsA74pK/AXHd
GyJx/ahOStDIuyC4kc0AVQOPZ7j0QzCzDHK7CHDvzfnhqaRr6+Tdx5/IwYf9v5PjD79skYEbglo0
cjQGC7qQXOMW9gTugdQpqHuAxykgAOzMgMsfiA8tFG3q/bSoE1/GetdYEJKeUELbjitCXXKD00zQ
xzebBGlWqiBudDfsqvJNeBB5Hhl6IF1/7A12NCk7sJaO2x35nVv3Bjpd71MswoHnKiKkkk/eHzYh
e/Av78g1aLCPVefwfBukNLh1Q8Vaz+tjFS0YhksQ2g4I4RJhREDIaOS5IXEvwVQUb/3J1SuStAdC
b/DT3fDgwxnYhoSHMAAU6hyEIyHdAf1YqKvA5dqr2z2/h+WzYej1wf6wga/khMIA0Q5GkfJ4KcdZ
ulUCGAdk7PX75PZaFsTLJpIiiM5XHiZQEnBsmZJKjWyjo2ChLDq6MrEQv36OmdcoxJMOJO8gc5Q0
AALsw7G2UzR9sQNpWhQoj4u1jse4tU4OpPija6QDFIoPrt3+JR6U4JLzu5HX3JeSBfd15Xkdxx/O
yXgyhCiBagHfi65xXw6Gg64SA57FRPzBAI9MAYbvXqFPDlVltTLWGU6GPiXJjHUbe48CiN8CiOJz
YS8w/gqy/Y+3+8jZUEku90yXz/QdQI1USQ3N8FOU778moEspX2Vaw+gW0k9lgkEsrtH1XSRPQkFp
JJYkKcNS9W76fQJwHqBbChPIR8wQlOEvCe2nE8YLRf3QcIAOORn9dyFikDdHp5B25kSEDzxfGo78
LEJq+BJwdcyQ+sF8Fw0ag0FqtdIYAU2BFnw7J0RTqUVrqAP5mgqvIgfirBtCr7Mdc5uHA1IvgAXR
gtUrf0pax/FImUMjOfMPwxLZ/bFgnq4804AcnWGwGUJHkpkE1qtL/aBNQiY/cq/QSd0UnvKuYNqn
ZOV7jhnyfT5SQpBFBwPPB2ApKEVpE88ZHkEn5KHjhf7VFQoZgsZntTsNuug7PNEmk9kwKGBy5Xip
yL5kG7iWXoK3h8GwmboYyiGlQnbuPp5V6PYIRuQ+iYIBhBO0Ia8fqYCiDFaNcz6roDzpRn77r7Gf
bcu0Q8Y/gKW6fOJ9HgURPMQ3lYvIjjbayRtNbG0nB62PeMIEWP1QbkFrdiGKXKURRG4JSOOIiilx
kNHIh6HCOxn64zTigaJzLhT3Y7KjGEHgxSQi2XL28fX5Ptnu4M4REM0+GFrr5PiE7u/RnVcSHBqD
K9OVJGy+AiGBhmMThHh1C9hHqAT0r1gqsmuZZr6hrNJT/e74FbkKIbXJcjTplS+x1cvWyzFEyy78
u59I5WWy8UDaIEgxz66ya+3r8O/Lj/9OPr5+d7TfVJtojj4cN8GEVhwOLhj/UcOw0mt5n+GBNY88
/vsP1f9J6H9yu3c4WeWl/esAcmQIms2+H+Gmp9Fdo3EWTMJuOgScbS8aSFO7+nfjA0bRXCzAEc8g
6PmXPs4k2SRdtYXUN4rcK28bgum121NZJFm0kKs1MDXJgi/2zvmV4KSLDzGBx+EkNtmDzkVF32T4
B2Er9L0ofifGHUDX5cO4UQZdeCOSyCLsNEb4ci+QU3v+sNufxMPJyMNvvWE+B6O1T16vPDDFkVz0
NaB9/X39ff19/X39ff19/X39ff19/X39ff19/X39ff19/X39ff19/X39ff19/X39ff19/W349/8D
vpfohwD4AgA=

--_003_TYCPR01MB109277E30BB08C87B1E3021CB96912TYCPR01MB10927jp_
Content-Type: application/gzip;
	name="d3cold-allowed-1-20261010-100103-public.tar.gz"
Content-Description: d3cold-allowed-1-20261010-100103-public.tar.gz
Content-Disposition: attachment;
	filename="d3cold-allowed-1-20261010-100103-public.tar.gz"; size=16380;
	creation-date="Sat, 10 Oct 2026 02:14:58 GMT";
	modification-date="Sat, 10 Oct 2026 02:14:58 GMT"
Content-Transfer-Encoding: base64

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
PV/P1/P1fD1fX+H6/+nylB8AMAIA

--_003_TYCPR01MB109277E30BB08C87B1E3021CB96912TYCPR01MB10927jp_--
