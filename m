Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA52148850;
	Thu, 19 Feb 2026 03:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771472565; cv=fail; b=DQBsWeM6elugetHzo9Fj8Yy7D/HLI3kXH7zPrgIXbiizevySuqQ9WLwmQ3+qtlL5LMx/F6i7frdWgx0HY0CidfBKVVzTxmLhLhMzrTMuOQSHdOi6Drpx+SuGln9hmdJgp17UFy/BOuu0GoNFo9JCI/K65bX0X8vh3NBjsGTkmgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771472565; c=relaxed/simple;
	bh=DDrTPu/vYzmKtYd8p9vkxpvF6Ci8UE+DNIcBYwtqNZ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kf50x3L++4gNt7Pk1YfiPS6446/Gtm3TiYqLu7danFWFlRCZVOT8B0wjG0XZXlFsp+Bh2sXBPM8i0Dby5b/E9/LNef8e58SlTp3Q+JlzvHOEC3iuZXpIF3UXg2gfA/zM1RMLZOgOfz387+ANm904qGLUDBYFOv4JHNqEwFlJQEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N49e8nix; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dH2Iu8bp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N49e8nix";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dH2Iu8bp"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61IHE4f53675640;
	Thu, 19 Feb 2026 03:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2MhXFBwBn2SxWYMpxdU6cSU3qoAZt0YCWYthNEc1lPg=; b=
	N49e8nixIzut4v8NTNWFfhFcT4UoAP7/CS9Wf6hL1J+ijefYSJuSXwedCAN4w9oL
	Qw020efyk+Y/9ZtySDwLqYfG9ySV4uZKtLKBvWtmx7u61deVi2kxnWlbIEJRdWzy
	xWXjZb3oZWYXY8PtcNiz7ospNS2xTk2Co9EC+GzB8KsbCvitsmMUxk5FEOizNCBT
	fbupSkN0bZy6Ep/+eKfhm4/qvxr9+FURQHWBn+LtjnNvG1Cxir2qHsUNJv85bbw+
	M2z/QzEzygCWHygBchkYuPkghMJT2sT5l+unV8DLNpxoI8lkVhCsyh/P8pkkEEXT
	I7q7cHGmW2Xz3pLN+6pQig==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0axq3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 03:42:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61J1F7L4038960;
	Thu, 19 Feb 2026 03:42:19 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb24pdpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 03:42:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxcUF9fR1W6XJOi0oJrolvyjcvz+siISaGlkdQx8V+JYky3N483rO5stoB+5LH17ELqMeIqZc4UINEfrrQRULviyUXu9IZ3Krs7RsiUmhszBjbmXXyKlOt27Dqnb1v2nDwVL6Do431Yaf8BzNXSfP+w87iqxuGOmGNTxj+AUd85Drk8rskMex8SM/00V3/nvaFn9xSuGnkJzobf0eYb3PwlBHJrxsDPb4/2clY1a+DFaXQmMAHNjF79ZKZy5AL+nn3BElwfR+G/IIxDpvPLAdYjm+DV98a3iYVhd1tFBW5nDC+CC2WLtcr4Efn8Bvs5YeP8JVO3NQmpdaXW9KCkjOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MhXFBwBn2SxWYMpxdU6cSU3qoAZt0YCWYthNEc1lPg=;
 b=aqh3X08JsntIh5E28TrrGRT2KSdAK1nz34ILfT6NDwjl1h+gWQxMHsNQihV4JTutHDOdhNIrQ141uh1hQ99THM0u/wGp0+ynlq5GzygumACVVw+YFl1aw6/tNUxBK18mq9uY/M7Rp35z7NQNnSj3ZWdJQla25F1AtO8wBgjWpmafO/Qw0p8wedYSFAS7XSzp8yn6z8hfUb9DCcLVyO5s9HtSjEv7blJnT0ksusHH41oj2hRzlMJwxZaKlJrHmt6aYq09FC+fjsdrOxMMaosmabbjhdzcbOd+lMWntJSY5LqP6CvJnWeMEHx7Hc9DcX5hgTWKrtC4R7g7uCvSbP2UOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MhXFBwBn2SxWYMpxdU6cSU3qoAZt0YCWYthNEc1lPg=;
 b=dH2Iu8bpLv+wPRXX/5D9TvXPmT0NzPsDXM2wTt0jhbnMVP7uhdTDgtVs8s4Bhnx+z/sBg1WVyju6+2ym+b+ZwxbVdZfFZ1XQDqEvtsnWjAWrxpZRATHRlhLcKf6Rk6mcGb70Xnd8HHAuM6/JKAugDKZw5ur7y4wtEwUF+R3gN9E=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SA1PR10MB7554.namprd10.prod.outlook.com (2603:10b6:806:379::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Thu, 19 Feb
 2026 03:42:14 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90%6]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 03:42:14 +0000
Message-ID: <d6d04a8f-5845-4627-8cf1-a6875cb21fbb@oracle.com>
Date: Thu, 19 Feb 2026 09:12:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PING][PATCH v2 0/3] PCI: Always lift 2.5GT/s restriction in PCIe
 failed link retraining
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthew W Carlis <mattc@purestorage.com>
Cc: ashishk@purestorage.com, msaggi@purestorage.com, sconnor@purestorage.com,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
        Jiwei <jiwei.sun.bj@qq.com>, guojinhui.liam@bytedance.com,
        ahuang12@lenovo.com, sunjw10@lenovo.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2512072345220.49654@angie.orcam.me.uk>
 <alpine.DEB.2.21.2602041709010.12532@angie.orcam.me.uk>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <alpine.DEB.2.21.2602041709010.12532@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1P287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::22) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SA1PR10MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 3434eb36-4b68-40a7-5ade-08de6f68de96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEJPaURKU1lEYkZIdXRWK0psVkV6c1M0MmtPRGdqQmkxR1NDY3BXeXpGQmU5?=
 =?utf-8?B?a0VHeHVLcGI3QklzOUhUSEhuRG5nVTlieGNLWDk2UEhwTGN1S2FDUVdTVERr?=
 =?utf-8?B?WDNaelRoNy9Ia3BBM1Uxb2FFUEMrL0FFc0F3SFBPV3VCM2VxaDZ3UDNwUmxV?=
 =?utf-8?B?WWZadXhhT2hwbHN1b3I1T3dIZHltdzRjYUFGMzJ6NjMvdXFTUWJ6bTNsSTVJ?=
 =?utf-8?B?M0hVd0ZJb2M5MmhYd1h3MlgwUGV1RjUycnlMWlhmTHc4bDdCQmFVcVB5V1lC?=
 =?utf-8?B?TXFVK0lteFFFMGFsQU05NlFuM1FlOWV2SXdRL1UvVE9pbWhCMHY1c28ya0Ez?=
 =?utf-8?B?RlN5V21FODVvV0pPU0xDeGJoRVRjUDZiejN4ZjFUb1Axck1jTDgrSjh5b1k1?=
 =?utf-8?B?ZmJJYjFvbENwWHVsMG9VaGgvR1NkUWJDdzFSbDhsSkpjdXA1NCtFQzcxeDZx?=
 =?utf-8?B?aHB3OGlOK20xNmtIenpOV1Y4NjBxN2pXNDRoVXhWU2N5SVk5Q3B2WVhUYmo5?=
 =?utf-8?B?TVBwQ2YvQXdWQnNVRjBocHd0UjFsVVhuSElzRmtDQmxyb0R2elZ4NGh2dmNa?=
 =?utf-8?B?V0h6K2YraENUd3hSemlucmRUck5DTW1rdk0wTmJXTTFRSzdKdGh2dDY1QWJU?=
 =?utf-8?B?M3RPUzRIQWthYkh4RVp6dGx1d203QThVcnhSeThYQzJQbEVOZnVyTTRDOFhn?=
 =?utf-8?B?blhEZ0lLVnBjeHdjMkFIYzduZVJlRkhjOXlWR2I3MW9idUErcFRDSU54MTJh?=
 =?utf-8?B?MEpGMmdXZngxcXVhNXFEY2F5dTI0TWxXUkJoQVlpRFc1MUZxdk41RnFsTENG?=
 =?utf-8?B?eVhyeFFlTDJnd3FYV0tOYWc5aFVod1BYbzY5eFh2dGZycTNjTmhVVjVLSGFp?=
 =?utf-8?B?S243YkRINmFmOHliVUdkb1BHWDU0RjY4VW1HSTRWUVJEV2NoRE1Xd1hLYzJR?=
 =?utf-8?B?b0RWVDQwVytNclJnS0d6Z1Y5RFM5RUlKQWQ5QlhxVFhWQ3EzSitYSjZzc0ZF?=
 =?utf-8?B?bzNNdkljYy9oQU1LYkZuWGxYd1NRVmsxU1dWaU1RUUltNFp2UlNnclpQb1Js?=
 =?utf-8?B?dXZtMlBMeUtqZTNMWU1SUmN1djdLT0V1R1JIWWNkYTh2WE15VVE2bmZURDdG?=
 =?utf-8?B?SEkyY2JJVDlIdFVaTTFLMjlZbmJvd0IybDlRVmtFQ1ZXekEvVFE4TmlhVjE2?=
 =?utf-8?B?am9NdS9yd0ZTVnVYMms3MjdVYW5ZOENUQmFpQmduaHB4RXRyT2ltS1RhOE50?=
 =?utf-8?B?Q1hBcG9xSGpZdzJKK1U1Y2lRdVZKQ2tZMStWQ1ZSdEpIV1RpaDJtQWxGMDRo?=
 =?utf-8?B?RGcybHBMc2ZKZExrV1k1SzZYWHllOGpsMjEvZW03azhsR1pZaTNRK0VaU0FX?=
 =?utf-8?B?M1l3T1RseWJLeXY5MEhxQ2Rjdlgyc0tOTzNXUEN5Q2R4QVV1UUtrWGpvTXNG?=
 =?utf-8?B?WDh1UXJxUUtNS3R2NG13bDlUYlA2ZkRXZ0VFZDYzQlRMOElIeTMyQ2hoVWJ5?=
 =?utf-8?B?S1ZRNVZPTTRqWHovSkdlRXU3b2FzYVpxK2pqcVJxZDg1cWFSUFdPbVpYZHpE?=
 =?utf-8?B?SytMNVNjTXRXN29LV1c0WkFuelZBanh2RlJOYlErVFIyQzg5eW1oQ0xjVmYy?=
 =?utf-8?B?WTg2cnpVMStUTWdCbmF1SFdhWStBUmVUNkM1bzNKanRuSEFDTGY0a1pCckNK?=
 =?utf-8?B?V2ZpYXM0cnZoR1haNElXc1dkVkhFY3VEa3BGemVybDZ4TS9EbVpPV1MyWjM5?=
 =?utf-8?B?dVArSFRBZDcrRUVFck9sdStYWmh1Zy9hZWRGUUpvYnltL3VFUjlWMEpHZU15?=
 =?utf-8?B?dnFqN3dSRGFvTCtmZzdMU1N1T0dNMU00Vm1hM2pKbml4UHhoZWJLTjN5QmVB?=
 =?utf-8?B?UzdMdUpWZTVMdU80Ylc0WVQ3S1ZUSkhXUnJ6Und2cjlGSFJ6OW8zMGJvQVAw?=
 =?utf-8?B?dTBpaFJoWVZGM1FlVkVObjNFSHBIRU1QNVEyaUFac1MzRWVtVytwMEpZU0RO?=
 =?utf-8?B?R1h3S2JHdThHS0FtOG1WVDJDL2hQMVh5L2UyVUxiNjB5R0cxcmJaVzBtQ1VG?=
 =?utf-8?B?QUp6eFl2VFVSTmVRUjAvU0VMZUdzN2Nwc0JpeUZGUVJ1OWJKRElML3JxZ1JK?=
 =?utf-8?Q?ljWw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUZ6OWYycWYzcnFYZ0FhWGlmWlBuR1ZWVXBRQVBWc2lKRjRsenpOSzc4U0V3?=
 =?utf-8?B?d21xUzBFaFkzOFBuMTNodlJoN0J2VTR5cVFRUDRuaW5nMStsdEtkMENWUW90?=
 =?utf-8?B?ZC9HZXZadjB2K3EvNmNjN2RpVHZONFh1cjNCcFNZejJoZ3duODVNMnBUa3py?=
 =?utf-8?B?M0luN0tPeXRmdEJjQm1iUmd6VkJJTW9xM2VzMGx6Q3lkRXlxTGRjSE9hQUtj?=
 =?utf-8?B?ckNyYnltK3RueFh3SHFINW1sVUtJeExGLzN6UFhhY2hnQjhwNHU4SnM2ZHpu?=
 =?utf-8?B?NlJBNnd3S1dVdHZXNm5SV1JTa1FlcGpPWjY5UEEzWnJBVlVBbVhXWmxqVWc5?=
 =?utf-8?B?d0NVUFF2V05MZDRuNFF4MGI5ZHo1Rm1kM2Y2MGhXSXh6MEVTbi8rcjNqNWV3?=
 =?utf-8?B?MmVBdmhhT3VWT20yWDNVWWJGTFBqZ0pLL0F5QXhuL25hKzN4UlQ4UDQyUDRG?=
 =?utf-8?B?bitwNHpONEhDWXJ6aHQzaEJoazRLV25pSVJIUG5NOUx6dUJSWHFYejd1NkNH?=
 =?utf-8?B?QmJTVmR6T0JwUzdFU3hEQnExMmR3T0xSZktTb2E4cHZIamNsQ1F2NDc2WGJZ?=
 =?utf-8?B?MTYrZE1ta21PdVBuUzFoZTlLWlVERDNuemFZQzhXQnROUzlaVkp3OGZTK2J0?=
 =?utf-8?B?REdreEloK0p1VGJzR1FrYzIzcDBBVmw3TUJGd0tHdkJXdy9PYUhPMnpGMmMz?=
 =?utf-8?B?dHAzZmNBcmEySFJlMVhuWEpIYVZ2OHZFR2NXcWNGd1N3MkRIOTg1TmY0NHdN?=
 =?utf-8?B?d2tTM0M2Q0tJc0s3am9qSVlLcE5pcXg5cWg0YjM0amdpNFl2SnNoOHBRLzE4?=
 =?utf-8?B?ZGdOZWZLUmJhTWFBUjlyOEJRcUJKN1BTR2JZK0I0M2I3NHB3TG1vWEU5OHJv?=
 =?utf-8?B?cHY0a3JSWncyZERiK2JzdnQrUWZpT3JHS2RKZE9hUXFFeVFaOHJReVNENmZS?=
 =?utf-8?B?aWk5MXhiNlFrNjhVYW5FMDdqTnFxNCswR28vN3hHdUdPQ0VjZHRZWnBnT1dq?=
 =?utf-8?B?Z2s4L2d3eWlLK2NzVXVsL0JuVHByWUZQa3FGNENPZ3QrQUE3NHBhQ0w5ZGg0?=
 =?utf-8?B?aDNoemdYTWEwWVZpalp1aGNSSS85dHd2amNqUlh5WkQvdDZqM0tjS0ppWjYx?=
 =?utf-8?B?dE1CeXpGYnZuUis5UFkxS0VsY3JZWG9qRXBiY05LdExKclMyRmF3ODFYR3dM?=
 =?utf-8?B?N3prMXc0NDA3NFQ3QkkrcHljcmphdjd6K3F4UGRJbzJTNDN2ZGlwN2FRWTBT?=
 =?utf-8?B?M1I4MmRRTnY3QXB1dk1nTmcyOEtRd0RJUzlLMWV4WTJQMm41ZXRIUmJVKzhI?=
 =?utf-8?B?TzZWVGpIOVZPMUQvaU5xYXM0dDRseGI2WnlIWFlubmVhcXYyZFhYdnU5MmR6?=
 =?utf-8?B?cTVCZzQxVFZITTRMMVFWcmd0VEl4d0hCQW9DNkh3RGpPb3pieW83NGZRTWgr?=
 =?utf-8?B?SWhHT09meXFacTVSNXh1V3A4M3VDeXdOWjBwNzZLOTdRQy9MNW01YU9NWWlj?=
 =?utf-8?B?UkRaMzRhdjVwWW5aQXdrV3d1MjZDQ2JuTjF2S1hCYm9WRE1YOC9tSGMvWFRO?=
 =?utf-8?B?WXB2S0xXT3MvRlFIZllJTHJXbVJ3MzJLNjJRcWFvTzl2cTI3SWJZaXlEUjZQ?=
 =?utf-8?B?TVNFN3J6NnV5OWFVU1BqcU05dFNNbHpvQnpUempNaFZQVHkwaGtvV2Y3OWV5?=
 =?utf-8?B?ZXEybXM0N0VPaHU5ai85RjBReUg0bVluVVNxQVhpOHhRTHBnZlV5MFM4akxr?=
 =?utf-8?B?SS9QR0grbEJZOVdnYi9rMCt6QWFKUDYwVTExNkpycnVmQzlhOVNoWnRibk9p?=
 =?utf-8?B?Rk1UQTN0dnFnWnNEUlBkMHlpNEdMVU1mcXNWWGJnYXhTeHJ4cGlqYkp3TGJp?=
 =?utf-8?B?YzlENHBBQytjQVFmQUlRZDByY25YOGpxTVA1bmp1bzUzMHRtK0JnY1EvelY5?=
 =?utf-8?B?em9RZVZsRDdURDhYUUJhT0xCSmpWR1QxNHUxVE9OUWU2SU1Ld0duVGRrQ2ZR?=
 =?utf-8?B?UFkyY2RaZGJsaEJFL1pXMFhBbEdSenVyQVdFRXp6eXFYa240N0JXNnJOcmhw?=
 =?utf-8?B?bFJoQzdvRXJLUkFTaElDOGVhZjduV1FEQkk2ZklpUklraWtvTll5OTFVeUtu?=
 =?utf-8?B?a0taWnRBSFIrcjEva1RRZnQwREZLcE1PTXc1T3hKakVoNjVFaURPaFFnSDAx?=
 =?utf-8?B?UUVBdXZoNGlyZ2tUWFV6Q2pFRjVxa2RpeFZySG5Bb1RsMWdDMlZkWHNscWNK?=
 =?utf-8?B?VHEwb0QvZXJGazcxMjBTdHdHS2R2cGRxSEowZmxaZGoyWk9sajZUa1BEeGw1?=
 =?utf-8?B?NG02dzNNNGpBVlc2TGNGbVJHdG5SLzg0SEsvSUVGOVlnNGVEYUt5bXUvNHUz?=
 =?utf-8?Q?cIX1dKPUDG4RVUYQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/CAJtwzEHaDHVBzdET65qvBgsABUxYtfoj6M+RqdYjnp+OV9R+R5X/EPEekZrWrLgTTeyHwRGZXOqfuEpAOADTbCii34x5r7jgVHyPO4EDt5blyNdnNEIEmcRoc6Ee4TPXB+u2zgCKQNpAP9cNsJkexlcjGVzLvnyYTFahQuyH1yLaKiTtdLb0WrPbKlQt+f/OYzfwB3LcFvMa0e5H+m34IQRMk8tg9nbeGm4jGtSk2fUzhiDnHMki2VaYjJOV6XXoVsQFCV1SjAUBW78/IR7w5IQ56LfuyW3BlRz6KxewSPyACaPf6Vtt2XtSVNMv3oKfzpl6WFatO9y3PV7l1v4fOgZZuJcAkKbQqNzoCTAHLU+NxF0X8KNnhpfZ4+n21Lsoeb8UtPQ6e4TmDGltnM+YB0VAxuFt951wJxphD9+Ng/L6FymXFQ39r0S9NizUvNgUTERCSW8p/a3zOK79in34lcDjlx2qC9ly6SJOTQBtYfEspB2CCqyZZHxK6kHNGFxXslTbLTrwancq8F5wpTakDC+TIAyydde7HvYL00jU6dfB7CZJydidBBXG5GDQrKJxtso/78ztMxvEmNK5lqeW25C7eu55ywkdfdN253ZH8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3434eb36-4b68-40a7-5ade-08de6f68de96
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 03:42:14.2370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xw7qeKYKFS9hfB82MnwJADN/vXwBThHZCfKFcIoDrSw6j3SvBvVH1zd4mmKAQro6nYPS9P9IukXeWxZZzpTLvDPAPz+WSju3W9Rpdfd7NlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7554
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_01,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 mlxlogscore=995 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602190030
X-Proofpoint-GUID: ji6xQJApGIhV5Nw90eWIgGY0i5KOcFbn
X-Proofpoint-ORIG-GUID: ji6xQJApGIhV5Nw90eWIgGY0i5KOcFbn
X-Authority-Analysis: v=2.4 cv=UsVu9uwB c=1 sm=1 tr=0 ts=6996869b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=BcPKCTjPAAAA:8 a=KCRrQsRhzwUMNXg1vg8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=MNXww67FyIVnWKX2fotq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDAzMCBTYWx0ZWRfXwHt3CTHca2Yv
 QAl4+AuhTHGOybcehwo5Mjrb0RH6hfBeY+oHPJMU6HlFDGhEaoY84NWHDCOHLIWYhMZ4kU73gBC
 8+/uhdHDC3wyb2udhSJ8/Z5boYMnIl3hS+/JDXIh7sjqtzxAYWK/vxI2zIWyeboRzRsjh4aPPhZ
 R2LD7xpZ6GqroVPU57T+WYj4fhx1j5zrfxtTqAuVx7UGlEYi96XOykEjIB5CbdUoUKmhUnDlnBl
 qF9xHNX2xOIWr3KPgpyJ27BGKUDGLkjKGlmOqJulMcGNte90UCZwPs2/raWFS2lpNQxMrhhmEix
 sAHjsBJR8xDwr6uwCSNqYosqca4REJJ8/rOfXgxXay51M/A+q3QpHj/PBO+qj1DAAlPLQHyer2p
 JYzYHVkoxCRTSw+MGsTycgmyS2wKaf3x1FiIRdD1nz/1NSD0M1mDKxMjIghylO4y3Z44gusp/47
 E3T0NxOrBLdKAwAiDmA==



On 2/4/2026 10:42 PM, Maciej W. Rozycki wrote:
> On Mon, 8 Dec 2025, Maciej W. Rozycki wrote:
> 
>>   I've figured out that backporting will be less intrusive if an update to
>> use `->supported_speeds' is posted as a separate follow-up change.  So it
>> is now 2/3 in this series, after 1/3 comprising the original patch, only
>> trivially updated.  Then 3/3 moves the maximum link speed determination
>> earlier on for an early exit in the PCIE_SPEED_2_5GT case; maybe unlikely,
>> but essentially free now, now that we retrieve the speed anyway, and makes
>> code a little simpler yet.
> 
>   Ping for:
> <https://urldefense.com/v3/__https://lore.kernel.org/r/alpine.DEB.2.21.2512072345220.49654@angie.orcam.me.uk/__;!!ACWV5N9M2RV99hQ!OAfq9yiKnpdaetDotJN22sQQSGBYwwgga65vyQgENCufGjXofXKzxK_fIlCshhI-_EDkeOuLzjgvx4I5zng$ >.
> Re-verified with 6.19.0-rc7.
> 
>    Maciej

We’re waiting on this patch. Are there any updates or plans for it?

Thanks,
Alok
