Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850AD1DB54C;
	Thu, 14 May 2026 04:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778732740; cv=fail; b=mrvkwD3yNAH2zGKE2Dxgn/nI1bCcjZbyM1Eay2jL6JBW+bJLvII5yA7iboUVfgUPDdpf/e6LUfNpfnS3Y2q8JiQsjDql9dFFuahrxaP5OC/wwrf6YV+LEIebK9GMUSRi26Jjdym6D4xX5EFqeKi16U7D3JVUFiC/ykUy9Olkeok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778732740; c=relaxed/simple;
	bh=hEowd5YWBCSFu4Lr9VYs33EClS8I3xXJpmOhpvioY3I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g54poZZStHj1WBOld7H9PR1MAbvxBDFk18EvK791S6JZn/Xgk9b4uL9DCw6ELZRXX923ISVf8JW3rb73oFcCGeg6vGlPI4zVNk9d3AM18tImiqunTJtvbmNO2Qn+TlbVIuKBLXszny0AkAoP/LRLeT4Fsl7NXp0+Yiys8V1nGtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=P0gzHZk+; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=mfLd5h+B; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="P0gzHZk+";
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="mfLd5h+B"
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DMes4h3459013;
	Wed, 13 May 2026 21:25:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=hEowd5YWBCSFu4Lr9VYs33EClS8I3xXJpmOhpvioY3I=; b=P0gzHZk+f8y9
	oKKKbIdmeyrMOtu4oYqMV/YrA1sD75YUdwNRhsmaAHPgTA6wng2MzKIGnJWe+O/n
	Q1giJhnennAl/J5azKjAQCUyQegtzFgoTWOPva2KcXdCr1pZECiZEgzIrjHqNgyG
	VpGlb41BaCqDIqE3kvNoRDvuHe3MIfiVrkA2rhyfADKJE1O3Rt59bZn/R6CPiVVD
	mF9RpWmYwUYJb2htIqLO0uWrZhjJCb/RcjxphrbqhxdtE/rktMoDXyNOniR1UMWV
	v927GC8P2zRuzsXmIHBUKa1fEiJonsV9pDUpz+zBEq812POsw8TzkDdbtQms0vRV
	hlnSV97O7Q==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013058.outbound.protection.outlook.com [40.93.201.58])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 4e4uw72xuc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 21:25:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHHeKCwgd8WfGnNVQSBjzYPkozQL2UwZuxits4f1+2hseMl0gm92/aHef6FQ1gC0E8GalvztiIXFJ3rIPw6fnqANnAMU7zfjvgxkkUaoUP9O2G2GE+9Bz9GTkGZkpLMA1mR686AfaR3TgutIfZHygVxEvQys6yy5ZsskUlNmlEptCSyAWPQKXDBr4LjKBgBHDjogsEsK69OfbJckTAoI3RUBxGumYUmEVp10EfD1Sv31DDx9Sfe+OhW5xy/jAXyB2GcIcqnAm1HiSBXDZ/+nfpiBX3fJ/SATdb8fjYmcuOMbkNG28awgIFCgQP22wMf4osmePWV/8TQBiVDsNKuyiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEowd5YWBCSFu4Lr9VYs33EClS8I3xXJpmOhpvioY3I=;
 b=IF1I/1GIW/YlykTiL/vM7uMKJqtULep9DSLgWyhV5Rt3xt3muX5PU40oYntQeQLXkr1xwa9AuV6RAvgxQxeeNQB7G6ko4ASkYTid4B0mZUoU7QtFDGwa4m4u0o/75YGu74sgWQiZIFZkGAS7iPn+Uj/X3rjfm59uvRwsFcH+GrHpucXWm4C38nkQ63tq+1VCwmaw4+5+d3JQj7v9ynjjwhXeAWgvp2QUggy5uVRB1KixtLoM7oTMeSy2YwdaIe0LDgvtUa8HrE8QmuU6MNKFTKWC3QNns/k7eH8gklO/wgkn5txVrDC0mhoNNgpSqLLqK3G3tPjToHeUBnRFjxOJHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEowd5YWBCSFu4Lr9VYs33EClS8I3xXJpmOhpvioY3I=;
 b=mfLd5h+By/4GKRHIw08y+W7GA2+XuXH/pI2FM+aB1/OCvwPxQ9RdUToLzyjyNukEjMxNidpoLTeB3rqevK65iWtvxxCKE+hBWaydPZCVsxUep64N5NwXTCeZaK/Haf0imsktiHLP0bKb9pE0BqM3YDB3UgPs1zFrnI/+KudoqmWnIAN2cYBXTfL+hfk1n5Yw/Cta4FZM8+JdJ7K03tnSDPkNl5Z3qGxygFNfaLJItUlVhfw7CZYa8b8gHETevPq+bBCR8NG72N3qDnkB+QMQeOn2VeGRtegReDs7D3uAy1+jCqDulFP2+zVz/M8d4Z1dBCE2S4I83mgbDjiXSoNUBg==
Received: from DM6PR07MB6716.namprd07.prod.outlook.com (2603:10b6:5:1c9::16)
 by CH8PR07MB11596.namprd07.prod.outlook.com (2603:10b6:610:2bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Thu, 14 May
 2026 04:25:19 +0000
Received: from DM6PR07MB6716.namprd07.prod.outlook.com
 ([fe80::2e20:ee0a:1b4:1175]) by DM6PR07MB6716.namprd07.prod.outlook.com
 ([fe80::2e20:ee0a:1b4:1175%3]) with mapi id 15.21.0025.012; Thu, 14 May 2026
 04:25:19 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Hans Zhang <18255117159@163.com>, Aksh Garg <a-garg7@ti.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
        "mani@kernel.org" <mani@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: RE: [PATCH v4 2/2] PCI: cadence: Add debugfs property to provide
 LTSSM status of the PCIe link
Thread-Topic: [PATCH v4 2/2] PCI: cadence: Add debugfs property to provide
 LTSSM status of the PCIe link
Thread-Index:
 AQHc3pyNnZNz+XuLFk2tyTbjytxOIrYLdCMAgAAMzDCAACh1AIAABeuAgAArNICAAAmmgIAA4sbggAACsoCAACuRgA==
Date: Thu, 14 May 2026 04:25:19 +0000
Message-ID:
 <DM6PR07MB6716C10C5CAE75890FAA61CAA2072@DM6PR07MB6716.namprd07.prod.outlook.com>
References: <20260508034101.1910036-1-18255117159@163.com>
 <20260508034101.1910036-3-18255117159@163.com>
 <3ab81da4-a745-4e85-8aa3-3a217e3fdcbe@ti.com>
 <BY5PR07MB6705FFD54E7D97EF5AB0A211A2062@BY5PR07MB6705.namprd07.prod.outlook.com>
 <f8ada2e3-15c2-43b1-b013-2f3fd263f25f@ti.com>
 <c0bd820d-9716-4109-9d5e-7e72e0716cf1@163.com>
 <31b5f0ad-70a5-4397-8740-6808d0266a7e@ti.com>
 <329f790d-303e-42a5-874f-8eeb616352d7@163.com>
 <DM6PR07MB671631B20C59B8760D728A3EA2072@DM6PR07MB6716.namprd07.prod.outlook.com>
 <156f44d7-0adc-49ce-be6a-5b875a2c97fd@163.com>
In-Reply-To: <156f44d7-0adc-49ce-be6a-5b875a2c97fd@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR07MB6716:EE_|CH8PR07MB11596:EE_
x-ms-office365-filtering-correlation-id: e24a8b52-0fa2-4a3d-1391-08deb170ce71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|38070700021|22082099003|11063799003|4143699003;
x-microsoft-antispam-message-info:
 h7GdXQa8zzSo/4QXXJbkLbgWn85GPZSTdG97Vsg+JszEDj3eF6tVNYNfoea51n3iofEQpz/k55sGQ0viU0F+q0hxZxVj34mmRDBswkbSDE0zzCLDUjUem8osAxu8YCXXZdnbU8XY424BEFvvmKoOueE0WG/pXZ+3HML2aZx45sLcs4sGWLqfXmAjMqdw+nHdPFhFybZrVea2vI99i5Tr0cXUh1e3QMQSsc1ZoP4HdMajhKS8Ar7SB/3HGn1QIhaP/5aw9f8vzHbS38KAp2HrX0pgjTFXOS6S3Dguvie+9bZZ/kShsbjuHXLv7VHvV0j3KqFQInMnJCx5NDkZbhPSf1SJ3mslClowqPi8HDtIOiklK+KcmLLgS9PxfyqZnBITQsJGO/o/hbF/i+CFymSWgMJOs4psX7JfzNqtP7DonnnbrB5ejvJt+Kf1rjr9icUcab6+sBUE1p225rW+k6OoO5u4BrHLwBtmJGVvMtG/6be7M8aYpQddKFQwKzGU004vG1J37+V8bcpXajkbzyefi1ds/sg/jSAv/US2RHWYewTcH0zXTrhENW8NVr8MbNnTlnuR0Pa0dSpgShnjA9ybrRuxQzfL3eJOH6b+oHWiz8MmFRpmTTtbyi1Kt3uXU4CLfooN+1GJzwJ9LOiysZNZweOWIBRJ6X2G83qE4OfH6KkQugwuR6lC9VPjgtrgo895fM6o0QE3S1+aafbRNxQI/g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB6716.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(38070700021)(22082099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NzNlZzFGSEdlTFZQQzdad05VK2VERHAyNm1mTHorQlRJUWtNVlhobXJhbU5P?=
 =?utf-8?B?YnJlZkJRUFdmbXpoaEFQbFJPNmhGNG9DbTB2emtCREtjMXlrbXl0TlJYYkQ3?=
 =?utf-8?B?MkVFbjZvMzljT2lySVpyRHp5L0RvU1VGd2Y3dGtUNWVRUlNDTDJpSWo5SlpE?=
 =?utf-8?B?aTQ3UEFpSjZzdDdEamp4SHpNVm5QNGVxMDZDckY3RTBJZkpGTFdnMSs4MkNw?=
 =?utf-8?B?WWZnTFlRWllTRXRVakJuOUVnbVc5WStwaHlLYUJVY2JVWlJrVExxM3NjTk9Q?=
 =?utf-8?B?WXdqM0x2aCs5SVJJbE1tQVNNN3lwTnRjSGprTXJGVzYyaTNmK3hTMHBXNVh0?=
 =?utf-8?B?TmJVbUpDbmFWYUpaSUtlWG4vT1FQUmd6S1JTWmcvVVF3K09PVEJXdENDcWps?=
 =?utf-8?B?VE1EWHNlaS9GN3p6WEg3KzF1Wkw5dG5qQk1oUlNRT2NPVVhqamJqbnhvN05u?=
 =?utf-8?B?czRWWXVVT2pOTG9qRCtNcHNmOFh0TFdKVFBSeEtFZ1NRMGN2SHd5SDFJb1h1?=
 =?utf-8?B?RlFhRFExblhxN2lpcFZCb2p2dWlBdVhCd1hWZEkvOHF6amJpMmhzME83Wkk4?=
 =?utf-8?B?YUtCWVBvV29QQno1V1lWSkVRVGE1MGxOeHg5c1FJb0p0K0U0akhBZzlqcTZr?=
 =?utf-8?B?RkR2THZTc1JkbC9KMUozMThBK3NacDFubzJ0dC9RcyswTTBvUmRPczRXN3JK?=
 =?utf-8?B?R1dhbFVrbFNuelpPODNYSnQvRmxzOFA4a1dIU2lscjlPV2JFbXpUZTg0bWVS?=
 =?utf-8?B?NE5YQ0JLUEtPWkZxRkJRTEFaZ2g5bTI0VFJoUWZNazNFcGU4NXZ1TVNuVHB0?=
 =?utf-8?B?aURvRXAyWjlFQmViMDZiK0xPUFZQdndlYUplSUV1Zk1LU1U0dVkxdDhaV1Mx?=
 =?utf-8?B?eGxnV01pQ2wrSEZzbVozaFozaTR2RzZReE82ZU5qLzhDNDlYUHRUTklsOGFU?=
 =?utf-8?B?MmVDUW14NFdwdXhrUWhzcmNVVTQxUVJsZHZ2NnJueFZ1ZnFTUEZkNWVrcWxX?=
 =?utf-8?B?ZzQ2Nk8zZHlraHZDR0JpUlhmMUY5eTJ3Z2RsSGU3TmRCUTR4KzVLeTBKdzRX?=
 =?utf-8?B?LzZIMUlka0VhaVhqQmhTNVd0ZENmZWt1QU1iaHEreUxYQWlBSXZXa0tEYXRJ?=
 =?utf-8?B?eTFlOTU2M2prRlAwejhrMzV2N3VnU2g5YzhjMEo0Sm50UitDelJiRk9KR1VX?=
 =?utf-8?B?OWZEQXF1TlBjSm1CNGV2QjZiSTg5ZkFLcnRmaHd2NWFEQ2FMbnRnZHQvaDl2?=
 =?utf-8?B?WE9IalZmQUtmTndBc284NlBBdlRLOEQyRlRvMTU3ZS9tcmZpbnliSlp3OEYv?=
 =?utf-8?B?YURJQzhOc3BzdGtJZ3pKeGQzcmxYSWlWK2c5QTc5LzUvY3IvQWxRb25lMmJR?=
 =?utf-8?B?c1pnNTJ6Z3o2OGFMWXhweFFFaHAzdzJVeTRQTldkQm9TMjhKYUt3WDlSWCtO?=
 =?utf-8?B?bjlncFUvU3RBcjEyRElRdGtiQ1lGdTFyblBkaHNEdnh4aWwzdEVWcnNjUFpL?=
 =?utf-8?B?enVGWGIyT1UrU2E2YlVWcnd1VEhqdVVGT1dwK0Y4TExpQkdBbC8zRXUrM1kz?=
 =?utf-8?B?ZFNDK0JESVNsNnNKd2Q2bGNNK1VoaklyMTkzQ3Z1ZThkUUxMSElpb3VBcEhN?=
 =?utf-8?B?MmNKV1Z2SzA5TmhybFBOWEFKbkpFWHdnYWNWczRsWTVhTVR5K1JGQ3dzVVg3?=
 =?utf-8?B?YlB0Yk1ucUNQNlA0N1RkUEE2WmJzL01nTUpqQ2hNQllpa0lWVC9qSjJMQWhO?=
 =?utf-8?B?bG8wWlNSQkgzNDBqaGdGYUhaMTNOY2hHOFJoclBGZjM2MFBRaFVOYnB0M3NT?=
 =?utf-8?B?THRodUVvQzR2VVpzZXg0UDVTMHRrUlljaExHRWd6bE9ZWWZpQ05OSXg4M3Jk?=
 =?utf-8?B?MzRvaDJHdDVOQk0xKzhmRHA3eVUvSk96eDlhMEh4OHVITkdjS2pMQm1ncVVV?=
 =?utf-8?B?a2dZZEY2SUtPSnhwSzVIMmY5MkcxQ0tnbTZrODZrUCtiNlBtSFVOMXUxeDJN?=
 =?utf-8?B?RjJvTE9QMHhOdDU4RVRaUWJjOEVxVGtkbjNsTWdiVjdFY3A4QVZIeCsyT0Ja?=
 =?utf-8?B?T1FudkJGN3dIaFNEU1F4MWVSSndwNXRnbGpwaC9DQnZEUDNGV1VRVnJuZnEw?=
 =?utf-8?B?eWhsSlFLbElIRlRmaERJc285RFdpVnRSYlNXL3QyUE1UaFVxbDk2cU1idld2?=
 =?utf-8?B?Q2Q1bkluaGJQSnp1QnY5SytaTnB0RTdMUGpwS2xHZ0Q0Mm5zWENyNUp4bjBr?=
 =?utf-8?B?d1MvbTgycWZOTHVKdEhDZ1MrY2U2U2FJaTExTzhtTXVhRGdrSFpiTzVyZGxD?=
 =?utf-8?B?bHEzTWs4RnlMOXZwL1ZackpkQ1EzM0c1RTEvRlVaTXhzMEV1dWJxQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	kBgOZe0Twciox7qV3Mr9F61Sdy9uXu58Qb1LC2hS2mD8JdAVwhH5og4qbZwn9DHoa4EpLD5CjIRwrmSm19MGhJjmI7jw3YEWQgzRoSY6+mBjoUFnREnyzeyTYGeuvgKaXMSF0PVvPtM6Xa5Xd4sV7nTMlP69KF/CMUlaeFduagNcea5bSIqsXA95xxKxVhU1fv/HHiiVvOQlaOPmOc2UEmeUzSBHzKG6k3bgk+L7QltXtukQQlWKvPyA+w8WdEJnWt6wX8GZsk7jdMVnD6NIs6hS0LJC/7KyGFkeTHAz0rew1x4Vm28c4zZVGHU7RfdyAIfqV1d+AwnZKJFgU4Y1iw==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB6716.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24a8b52-0fa2-4a3d-1391-08deb170ce71
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 04:25:19.0565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kFS0YcToqKxKhm3T1JPY7ZubukwMv1Dkps+T9kRSTaexdtyIyjXv46demVasQdOW66liX+ql87vFgKmUlQWJ+2rvb1MsEvTOH96ZbKFSoa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR07MB11596
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA0MCBTYWx0ZWRfX9VY9sTDkqXQW
 3SUcd/QEKufvQnEmv6pUwLAFS7hsMU3fsxQykjPiBY2EbLxLzWfHTiViIyqHKwEzxm/9PwEhtpc
 rL5AWPEj2U50t0BD5jK4s7cW7PrGskk8K0Lht0wsXQJ6kX5osmovZQz6VW1CW95jG6RmmPwS8jE
 2MK61vAaag9qUi9E9/LEKSyYmXjDEOA660PpDM/U0pQw5wHjk3RjHTQU5SbpV4NzOvADB3oGYm8
 yoxvWfNaAysahtJmG3Lq/4e1MFYzuq9vP0eMctfCrzzB2U05WCu19pg/q+iOnRop7Ij2aFRVKiy
 Bozy9hAQdhhB8HsT7EZjwcwmfyJ08hlB2MxTn6Ug1KI0MmF5k2xtLfygk81y3R4HbPj9ocO0WfI
 yI6f4outAL51ctfn5ALkkcVCTjlX+phDJBdpRB94XAFhGRDZg/FiLIv8bkB7xS9TxJWx2Hfx+m5
 L8FrENGDR5Sox1NF8Hg==
X-Authority-Analysis: v=2.4 cv=FccHAp+6 c=1 sm=1 tr=0 ts=6a054eb1 cx=c_pps
 a=+UayH2mdqs80qU9+PBkj6w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=Zpq2whiEiuAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W8fx6O4W8wtO2w6lYej3:22 a=jPItpJ3sizTKmla2ehJN:22 a=uherdBYGAAAA:8
 a=VwQbUJbxAAAA:8 a=Js5SbT_J9-SCu5zYvDkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4M-hpa5zymJx3UtDpby1kqACvCakgNaF
X-Proofpoint-GUID: 4M-hpa5zymJx3UtDpby1kqACvCakgNaF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check
 score=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140040

U29ycnkgZm9yIGFsbCB0aGUgY29uZnVzaW9uLiBKdXN0IGNoZWNrZWQgd2l0aCBkZXNpZ24gYW5k
IHRoZSBIUEEgaGFzIGRpZmZlcmVudCBzdGF0ZXMgZnJvbSB0aGUgTEdBIGNvbnRyb2xsZXIgaW4g
Y2FkZW5jZS4NClRoZSBIUEEgaGFzIHRoZSAxMjcgc3RhdGVzIHdoZXJlIDB4MjkgaXMgdGhlIEww
X3N0YXRlLiBTbyBhcyB5b3UgbWVudGlvbmVkLCB0aGUgY29kZXMgd2lsbCBoYXZlIHRvIGJlIGRp
ZmZlcmVudCBiZXR3ZWVuIHRoZSANCkhQQSBhbmQgTEdBIGNvbnRyb2xsZXJzLg0KDQo+RVhURVJO
QUwgTUFJTA0KPg0KPg0KPg0KPg0KPk9uIDUvMTQvMjYgMDk6MzksIE1hbmlrYW5kYW4gS2FydW5h
a2FyYW4gUGlsbGFpIHdyb3RlOg0KPj4+Pj4gT24gNS8xMy8yNiAxNjozNCwgQWtzaCBHYXJnIHdy
b3RlOg0KPj4+Pj4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+DQo+Pj4+Pj4+IFRoZSBhYm92ZSBMVFNTTSBz
dGF0ZXMgYXJlIGludGVybmFsIExUU1NNIGVuY29kaW5nIHN0YXRlcyBhbmQgbWF5DQo+Pj4+Pj4+
IG5vdCBiZSBhdmFpbGFibGUgZm9yIHNvZnR3YXJlIHRvIHVzZS4NCj4+Pj4+Pj4gVGhlIExUU1NN
IHN0YXRlcyBpbiB0aGUgZG9jdW1lbnQgcG9pbnRlZCBieSBBa3NoIChUSSBTb2MpIGFyZSB0aGUN
Cj4+Pj4+Pj4gc3RhdGVzwqAgYXZhaWxhYmxlIGluIGFsbCBjYWRlbmNlIGNvbnRyb2xsZXJzLg0K
Pj4+Pj4+DQo+Pj4+Pj4gSXMgdGhpcyB0cnVlIGZvciBIUEEgSVBzIGFzIHdlbGw/IFRoZSB0ZXN0
IHBlcmZvcm1lZCBieSBIYW5zOg0KPj4+Pj4+IHJvb3RAb3JhbmdlcGk2cGx1czp+IyBjYXQgL3N5
cy9rZXJuZWwvZGVidWcvY2Ruc19wY2llX2EwKi9sdHNzKg0KPj4+Pj4+IEwwX1NUQVRFICgweDI5
KQ0KPj4+Pj4+IEwwX1NUQVRFICgweDI5KQ0KPj4+Pj4+IEwwX1NUQVRFICgweDI5KQ0KPj4+Pj4+
DQo+Pj4+Pj4gVGhpcyBpbXBsaWVzIHRoYXQgdGhlIEwwX1NUQVRFIExUU1NNIHN0YXRlIGlzIG1h
cHBlZCB0byAweDI5ICg0MSkgdGhlcmUsDQo+Pj4+Pj4gd2hpY2ggYWNjb3JkaW5nIHRvIHlvdXIg
cmVzcG9uc2UgaXMgaW50ZXJuYWwgTFRTU00gZW5jb2RpbmcsIGFuZA0KPmhlbmNlDQo+Pj4+Pj4g
dGhlIHJlZ2lzdGVyIHJlYWQgc2hvdWxkIGhhdmUgcmVzdWx0ZWQgaW4gMHgxMCBpbnN0ZWFkIG9m
IDB4MjkuDQo+Pj4+Pj4NCj4+Pj4+DQo+Pj4+PiBIaSBBa3NoLA0KPj4+Pj4NCj4+Pj4+DQo+Pj4+
PiBGb3IgSFBBLCBteSB2aWV3IGlzIHNpbWlsYXIgdG8gdGhhdCBvZiBEV0MgLSBpdCByZXF1aXJl
cyBhIGNvbW1vbg0KPj4+Pj4gaW50ZXJuYWwgTFRTU00gc3RhdGUuIEZvciBlYWNoIG9mIGl0cyBv
d24gUm9vdCBQb3J0IGRyaXZlcnMsIGENCj4+Pj4+IGNhbGxiYWNrIGNhbiBiZSB1c2VkIHRvIGlt
cGxlbWVudCB0aGUgcmVhZGluZyBvZiBMVFNTTS4gVGhpcyBwYXJ0IGNhbg0KPj4+Pj4gYmUgcmVm
ZXJyZWQgdG8gYXMgdGhlIGltcGxlbWVudGF0aW9uIG9mIHRoZSBmdW5jdGlvbiBpbiBEV0MuDQo+
Pj4+Pg0KPj4+Pj4NCj4+Pj4+IHN0YXRpYyBpbmxpbmUgZW51bSBkd19wY2llX2x0c3NtIGR3X3Bj
aWVfZ2V0X2x0c3NtKHN0cnVjdCBkd19wY2llICpwY2kpDQo+Pj4+PiB7DQo+Pj4+PiAgwqDCoMKg
wqDCoHUzMiB2YWw7DQo+Pj4+Pg0KPj4+Pj4gIMKgwqDCoMKgwqBpZiAocGNpLT5vcHMgJiYgcGNp
LT5vcHMtPmdldF9sdHNzbSkNCj4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBwY2ktPm9w
cy0+Z2V0X2x0c3NtKHBjaSk7DQo+Pj4+Pg0KPj4+Pj4gIMKgwqDCoMKgwqB2YWwgPSBkd19wY2ll
X3JlYWRsX2RiaShwY2ksIFBDSUVfUE9SVF9ERUJVRzApOw0KPj4+Pj4NCj4+Pj4+ICDCoMKgwqDC
oMKgcmV0dXJuIChlbnVtDQo+Pj4gZHdfcGNpZV9sdHNzbSlGSUVMRF9HRVQoUE9SVF9MT0dJQ19M
VFNTTV9TVEFURV9NQVNLLA0KPj4+Pj4gdmFsKTsNCj4+Pj4+IH0NCj4+Pj4+DQo+Pj4+Pg0KPj4+
Pj4gc3RhdGljIGludCBsdHNzbV9zdGF0dXNfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKnMsIHZvaWQg
KnYpDQo+Pj4+PiB7DQo+Pj4+PiAgwqDCoMKgwqDCoHN0cnVjdCBkd19wY2llICpwY2kgPSBzLT5w
cml2YXRlOw0KPj4+Pj4gIMKgwqDCoMKgwqBlbnVtIGR3X3BjaWVfbHRzc20gdmFsOw0KPj4+Pj4N
Cj4+Pj4+ICDCoMKgwqDCoMKgdmFsID0gZHdfcGNpZV9nZXRfbHRzc20ocGNpKTsNCj4+Pj4+ICDC
oMKgwqDCoMKgc2VxX3ByaW50ZihzLCAiJXMgKDB4JTAyeClcbiIsIGR3X3BjaWVfbHRzc21fc3Rh
dHVzX3N0cmluZyh2YWwpLA0KPj4+Pj4gdmFsKTsNCj4+Pj4+DQo+Pj4+PiAgwqDCoMKgwqDCoHJl
dHVybiAwOw0KPj4+Pj4gfQ0KPj4+Pj4NCj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gRm9yIGV4YW1wbGUs
IGl0IGNhbiBiZSBtb2RpZmllZCBhcyBmb2xsb3dzLiBPZiBjb3Vyc2UsIHRoZSBmdW5jdGlvbg0K
Pj4+Pj4gbmFtZSB3aWxsIHN0YXJ0IHdpdGggImNkbnMiLg0KPj4+Pj4NCj4+Pj4+IEZvciBMR0Eg
SVAsIGN1cnJlbnRseSB3ZSB3aWxsIGFsbG93IGVhY2ggUm9vdCBQb3J0IGRyaXZlciB0byBpbXBs
ZW1lbnQNCj4+Pj4+IHRoZSBjb3JyZXNwb25kaW5nIG9wczo6Z2V0X2x0c3NtKCkgYnkgaXRzZWxm
Lg0KPj4+Pj4NCj4+Pj4+IHN0YXRpYyBpbnQgbHRzc21fc3RhdHVzX3Nob3coc3RydWN0IHNlcV9m
aWxlICpzLCB2b2lkICp2KQ0KPj4+Pj4gew0KPj4+Pj4gIMKgwqDCoMKgwqBzdHJ1Y3QgZHdfcGNp
ZSAqcGNpID0gcy0+cHJpdmF0ZTsNCj4+Pj4+ICDCoMKgwqDCoMKgZW51bSBkd19wY2llX2x0c3Nt
IHZhbDsNCj4+Pj4+DQo+Pj4+PiAgwqDCoMKgwqDCoGlmIChwY2ktPm9wcyAmJiBwY2ktPm9wcy0+
Z2V0X2x0c3NtKQ0KPj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqAgdmFsID0gcGNpLT5vcHMtPmdldF9s
dHNzbShwY2kpOw0KPj4+Pj4gIMKgwqDCoMKgwqBlbHNlDQo+Pj4+PiAgwqDCoMKgwqDCoMKgwqDC
oCB2YWwgPSBkd19wY2llX2dldF9sdHNzbShwY2kpOw0KPj4+Pj4gIMKgwqDCoMKgwqBzZXFfcHJp
bnRmKHMsICIlcyAoMHglMDJ4KVxuIiwgZHdfcGNpZV9sdHNzbV9zdGF0dXNfc3RyaW5nKHZhbCks
DQo+Pj4+PiB2YWwpOw0KPj4+Pj4NCj4+Pj4+ICDCoMKgwqDCoMKgcmV0dXJuIDA7DQo+Pj4+PiB9
DQo+Pj4+Pg0KPj4+Pg0KPj4+PiBUaGUgcHJvY2VzcyBhYm92ZSB0ZWxscyBob3cgdG8gcmVhZCB0
aGUgcmVnaXN0ZXIgYW5kIGdldCB0aGUgTFRTU00NCj4+Pj4gc3RhdGUgdmFsdWVzLiBIb3dldmVy
LCBteSBjb25jZXJuIGlzIHdoZXRoZXIgd2UgcmVxdWlyZSBkaWZmZXJlbnQgTFRTU00NCj4+Pj4g
c3RhdGUgZW5jb2RpbmcgaW4geW91ciBkZWJ1Z2ZzIHBhdGNoLCBvbmUgZm9yIExHQSwgYW5kIG90
aGVyIGZvciBIUEEuDQo+Pj4+IFRoaXMgaXMgYmVjYXVzZSB0aGUgTDBfc3RhdGUgc2VlbXMgdG8g
aGF2ZSBkaWZmZXJlbnQgdmFsdWVzIGluIHRoZSBMVFNTTQ0KPj4+PiBmaWVsZHMgb2YgZGlmZmVy
ZW50IElQcy4gT24gTEdBLCB0aGUgTDBfc3RhdGUgc2VlbXMgdG8gaGF2ZSB2YWx1ZSBhcw0KPj4+
PiAweDEwIGluIHRoZSByZWdpc3RlciAoYXMgY2FuIGJlIHNlZW4gaW4gdGhlIEo3MjAwIFRSTSku
IE9uIEhQQSwgdGhlDQo+Pj4+IEwwX3N0YXRlIHNlZW1zIHRvIGhhdmUgdmFsdWUgb2YgMHgyOSBp
biB0aGUgcmVnaXN0ZXIgKGFzIGNhbiBiZSBzZWVuIGluDQo+Pj4+IHlvdXIgdGVzdCBsb2dzIGlu
IHRoZSBjb3ZlciBsZXR0ZXIpLiBIZW5jZSwgaWYgd2Ugd2FudCB0byBwcmludCB0aGUNCj4+Pj4g
TFRTU00gc3RhdGUgc3RyaW5nIGluIHRoZSBkZWJ1Z2ZzLCB0aGVuIGZvciBMR0EgSVBzLCAweDEw
IHZhbHVlIHNob3VsZA0KPj4+PiBwcmludCBMMF9TVEFURSwgYW5kIGZvciBIUEEgSVBzLCAweDQx
IHZhbHVlIHNob3VsZCBwcmludCBMMF9zdGF0ZS4NCj4+Pj4NCj4+Pg0KPj4+IEhpIEFrc2gsDQo+
Pj4NCj4+PiBZZXMsIGRpZmZlcmVudCBjb2RlcyB3aWxsIGJlIHVzZWQuIFRoZSByZWFzb24gZm9y
IHRoaXMgd2FzIGJlY2F1c2Ugb2YNCj4+PiB0aGUgcmVzdWx0IEkgb2J0YWluZWQgZnJvbSBjb25z
dWx0aW5nIE1hbmlrYW5kYW4uIFRoaXMgdGltZSwgaXQgd2FzIGENCj4+PiBwcm9ibGVtIGlkZW50
aWZpZWQgYnkgU2FzaGlrbydzIHJldmlldy4gU28sIHdlIG5lZWQgdG8gYXNrIHlvdSBhbmQNCj4+
PiBNYW5pa2FuZGFuIHRvIGNvbmZpcm0gdGhpcyBMVFNTTSBjb2RlIGFnYWluLg0KPj4+DQo+Pj4N
Cj4+PiBCZXN0IHJlZ2FyZHMsDQo+Pj4gSGFucw0KPj4NCj4+IFRoZSBMVFNTTSBjb2RlcyBhcmUg
dGhlIHNhbWUgYWNyb3NzIEhQQSBhbmQgTEdBLiBZb3UgaGF2ZSB0byByZWZlciB0bw0KPiJFeHRl
cm5hbCBMVFNTTSBzdGF0ZSBlbmNvZGluZyIgdGFibGUgaW4NCj4+IHRoZSBzcGVjaWZpY2F0aW9u
IGdpdmVuIGJ5IGNhZGVuY2UuDQo+Pg0KPg0KPkhpIE1hbmlrYW5kYW4sDQo+DQo+DQo+QXJlIHRo
ZXJlIDEyOCBkaWZmZXJlbnQgc3RhdGVzPyBJZiB0aGV5IGFyZSB0aGUgc2FtZSwgZm9yIHRoZSBM
R0EgSVAsDQo+d2hpY2ggcmVnaXN0ZXIgc2hvdWxkIEkgcmVhZD8NCj4NCj5QcmV2aW91c2x5LCBT
YXNoaWtvIHJlcG9ydGVkIGEgcHJvYmxlbSB3aXRoIHRoZSByZXZpZXcuIFBsZWFzZSBjbGljayBv
bg0KPnRoZSBmb2xsb3dpbmcgbGluazoNCj4NCj5odHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtDQo+cGNpLzIwMjYwNTA4MDQxOTU2LkM4RjEw
QzJCQ0IwQHNtdHAua2VybmVsLm9yZy9fXzshIUVIc2NtUzF5Z2lVMWxBIUcNCj5VMFU3RWYzZU9v
Ync3ZDd0cGo5bGxndEdyZ1pkWHdnV0JkNkJwVmNaLTlGLUtudXdZM2dOcUpvcjhpSy0NCj5mUERX
TGFrdHZWdnJrN1FtVFJHRlNDOSQNCj4NCj4NCj4iIiINCj4gPiArI2RlZmluZSBDRE5TX1BDSUVf
TEdBX0xUU1NNX1NUQVRVU19NQVNLCUdFTk1BU0soMjksIDI0KQ0KPg0KPkRvZXMgdGhpcyBtYXNr
IG5lZWQgdG8gYmUgZXh0ZW5kZWQgdG8gY292ZXIgYWxsIHBvc3NpYmxlIHN0YXRlcz8NCj4NCj5U
aGlzIG1hc2sgY292ZXJzIG9ubHkgNiBiaXRzLCBhbGxvd2luZyBpdCB0byBleHRyYWN0IHZhbHVl
cyB1cCB0byA2My4NCj5Ib3dldmVyLCB0aGUgY2Ruc19wY2llX2x0c3NtIGVudW0gZGVmaW5lcyBz
dGF0ZXMgdXAgdG8gMTI3LiBJZiB0aGUNCj5oYXJkd2FyZSBlbnRlcnMgYSBzdGF0ZSA2NCBvciBo
aWdoZXIsIEZJRUxEX0dFVCB3aWxsIHNpbGVudGx5IHRydW5jYXRlDQo+dGhlIHZhbHVlLCBtYWtp
bmcgc3RhdGUgNjUgYXBwZWFyIGFzIHN0YXRlIDEuDQo+DQo+IiIiDQo+DQo+DQo+QmVzdCByZWdh
cmRzLA0KPkhhbnMNCj4NCg0K
