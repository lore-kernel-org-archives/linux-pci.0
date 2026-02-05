Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021136.outbound.protection.outlook.com [52.101.100.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6CB3A9D9A;
	Thu,  5 Feb 2026 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770297020; cv=fail; b=miko0gGLGizkSm8bQ3MinYmA1B7r46JIu4FiNagSi2ug4/r4ioYiIuz34RyZhCxG31L5P9WJblpSREsK0VS98kCs6TIRyZ+fQw+CcrIkqf78VqkjqKVFqbVF5E+fiRcrMkHt+T7Jc7MIZkL9p9PyK+PbDa0rKj17eKaF7TNUJlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770297020; c=relaxed/simple;
	bh=LrBc6rsyKOLFE4V08j/B+tFHdk6Y/jze1nK3rg0ETiY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Y+vN6cpf9qKn6qeLw9xVhgAYmshNQK9ORwUI5Lft7Yx5GnhUG2CfblG7wBDjWjEJirtwH14qwvEMeVvlrGNkruu6x4idxLHaSRrpOytVzXUXSQhXFuFCSo2jwI3Du0EFsQ9ctlzH/VcIsTJi4gWrtNAM2x3CGfVLDC62bQjT97c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=kIrjPa+V; arc=fail smtp.client-ip=52.101.100.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="kIrjPa+V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfsLPTIPY28DN84Y932pZESs3dvxL/EBlOOrug3Yb1nQt5XrXpZ0YSpr+edC5kk1c9xdyAPwbMlEcNYUCRwxhN+Kc4kBJj4Pgaufa68SlwlKVcYxOjdkhdxYL5eeI4UwBVWDQXNzh3h0x1L8tcSu/QIAt651sNSCqkFMVefjZZVA8wXNzxFTdCUh0SkQfMfuQUd/WrCf9soEvNKBSGXfTT/rVkmJGfephdE+cBTreGnMfYMs7338vCuRg/SzEjEtKzInlSFDrKx90/EZk8L4D/QTcwihRb49RxQ3CUpg8pzoaMUsk3OX334yXXqLPHuVOKjx5pbXsdt6wnXqec/HGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ahb97hsOWgQDblZ1wUtXHY6U8Fb4NJXNK3MnJfkUWFE=;
 b=XuYErWh3luvhgSwFrgxkke1hvkOGH2QydzBphenn/HpKSfIsuCT9TtX2raMrnBECqJ7uIkJoAgUZ1eR+3HUc2u+JBPfEZIMhgG1UGyeMLize/vfnBg4WPAIHR9aK3eQ8MV7Ox44VMCk1SZviz5A0HIVyXcJQ0G9WLwKMXQBsxMk4j4yWpGdQsyeFQYcZZ6zQFTL3Q3XdUrXJ7RvDelvQcXlvX14i1zInaeX0IZ1+wZrZJA3qb+uIzaXUdOF7A49XfFpJGHduVv7/oa/L9oq7zyooFw0ND2LVW3xN9yZBEJnrkpp9g+ku2MEqzDdTVW5YJKYBimLBWArsfc7wYYm7Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ahb97hsOWgQDblZ1wUtXHY6U8Fb4NJXNK3MnJfkUWFE=;
 b=kIrjPa+VidzgZgcfHKczA41yegHv7koCKLZ08qNHqlv8tLw7W0eeHQYbI0Vx/zzU575ndra0t3DRLHKKA6tmnSUzo67Qd5CgS3q6vlJ8eBj7ctDXDWHFIidsSAytOX0e3NAhUzOv0pDpgd2Cb3HbFxxF3RVwgVzb7ENGlm+D9P8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOVP265MB8583.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 13:10:16 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9564.016; Thu, 5 Feb 2026
 13:10:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Feb 2026 13:10:15 +0000
Message-Id: <DG71X1RAJCVY.LJADBXREZ4XD@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>, <daniel.almeida@collabora.com>
Subject: Re: [RFC 2/2] pci: Add PCI capability infrastructure and SR-IOV
 capability support
From: "Gary Guo" <gary@garyguo.net>
To: "Zhi Wang" <zhiw@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260126215957.541180-1-zhiw@nvidia.com>
 <20260126215957.541180-3-zhiw@nvidia.com>
 <DFZHE3PGMQHS.3F108QF6VQEQ7@garyguo.net>
 <20260205135547.2ffc0df4@inno-thin-ubuntu>
In-Reply-To: <20260205135547.2ffc0df4@inno-thin-ubuntu>
X-ClientProxiedBy: LO4P123CA0540.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOVP265MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5bb898-ac41-45be-eb8a-08de64b7e7a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlJURU9UQmM5c2NISG9ZWUVKQXZIK1c5dEVNcGZ0U1VQcFBqRTJINXh0Z2Ux?=
 =?utf-8?B?RUlWMFpieFJ3YjZHRGxGblRYSjRWcDRDTEFHM1ZHc3YwVjZRWHBMNUpySmJh?=
 =?utf-8?B?WHc5TGRwenplaVpwc0M5cDM1SjBQWCtEQlVnbkYwM3B0d3BDRytjZlEwZ2RL?=
 =?utf-8?B?SjM0Vk1jYnRaYnVWT2FLUmwzZWJUSGhLSkx4VW94ZUYwYlNpTkc0MmtKTkUv?=
 =?utf-8?B?TWp2eWwrVFJLNWI4c2xvd0g0aFdyL0pBREY5cExBOFV1a0pMSFV1aE1MREJM?=
 =?utf-8?B?UENQWW1Ga3JQSXo3KzJsTkJsOVYrT3p3SzNWQTk4RnFNaDFtNFE3azNjaS90?=
 =?utf-8?B?aEswSExYTk0xTHgwbG55YzMxS01GOEVpN0hEVVRyUVUxaFE2VjZONzZQS2dk?=
 =?utf-8?B?aUlZWHlrK1hqQ0E3SzhlUy9zb1ZEOFdvLzNmNDJoNHJJeHRoRFFEb2REWWYr?=
 =?utf-8?B?MkFpcVZ1QmdiZzVqTjhudXozbndZZGJ0OVZ5d3hEZGhWQU84eVJiOGd1SXEv?=
 =?utf-8?B?d2Q0M2wyS0F1UWlsbDZBRXVaaitya2dicTdObzgrRklwTW91bUc2dlhkWEVR?=
 =?utf-8?B?SVNxb0R6alNiaXUwVVFUUHMwcU0vR053NThyRXhQTWtud0Z4Wk1CbDVzYStG?=
 =?utf-8?B?NS9ydzZINEo4aTVjSnhSUTl4bDBndnZ0bVYyL3VyeHhBMUtWRU82R0pacHJQ?=
 =?utf-8?B?OVJmWC9xNCtDS09kRmZzRC9nbnlZNlZPNkkwYUZQMGJvTzFBczNEYlN5czNW?=
 =?utf-8?B?WEJQVUg0T3JZSzVCc3NkODVQeUZtSVFkc1RRVzZLeWkxc3dBdjNhUk51NGVS?=
 =?utf-8?B?ZytOMWdqQ084dU1tb0VsRE9lZ0h4KzYwN1hvK2tQQld3MExLSzZpOHJZOVN6?=
 =?utf-8?B?TWJIU3JVcU4vWkNPaUpYNC93SVNZQms1TUw3TWNsWEtOeDlDdDFGUVROc2hK?=
 =?utf-8?B?MmNRUlJqTnV3R1RNRE1TSHBSNm5BTkMyYmdDUU5ySDFLZVBxdDBuRlpWNS95?=
 =?utf-8?B?bkx2SEN6WmlXM0VFbS9HR2E2dzBnWXJhWXFFMTJtc1NBVVJwcElUaTZDTHgv?=
 =?utf-8?B?NStSc2ZpZUd2TGQ1SDdCdzZBMjJXYWI4ak5pR3FRKzM4OGlvOThJeWhFYXJx?=
 =?utf-8?B?MG5rbWU3Sjc2VE1DRkN0QXVmdXZremhKQUxBUm1KcDdHTHdRbGd3ZDh6R0V6?=
 =?utf-8?B?Sm9LUVJSTnIyQzNaSGpwaTlFRW1iL3JGaEdha001R0pIRjJReGNxVWhTbE9Z?=
 =?utf-8?B?dHZTajFxWUpBNVpGSFNIWmVwZ2lCWnBlQ1NWclVnaFhMeXc5aU1JdnNpQUpm?=
 =?utf-8?B?TFI2SGR6dmhYR1A2UUFQZnhmYWZkVmJCMWpCeXhjWXlDWnh1aDU0cEYxZnF6?=
 =?utf-8?B?cGJoM2JEVStVWTdvRG8zSTZKM1RhUUt3cU9wVUkreWxWVHpjTHY0UUU1cndL?=
 =?utf-8?B?ZFVvNGcxckRUT3NlanhYZTNmQ1BQalBDY0t4ck9OQStXMC9ONDF4UlBkVUo2?=
 =?utf-8?B?bDdHOUo3elU2Nkd0bmlrMGVyOTNVbmtUbmI3a1FqZDhabXJrM0o4TkdlSmpY?=
 =?utf-8?B?OEllWXpiQTVraE9qTCtZbVU5cHJxN01EcTFKTHoyZDcrbXlFQ3RDSlFrc3BG?=
 =?utf-8?B?U215a1k5ai9UclVSelhVRFNXYkdoQSt4bFZJVXRSZllRa0Q2bnFHL004S2Ur?=
 =?utf-8?B?aVpiQm5rbjBkL2pibjRJUk02WElWSXJzT3dHVkxSdTNVa1hOVy80RHNRMEpq?=
 =?utf-8?B?d0FBUmM1UDFEelpKNVpBWkx6dUpvZ1k4akhPa21wSVVoTXhHcEJBV2g0bEJF?=
 =?utf-8?B?ZkQrZ3dLUHNYR3NOc3E3ZzArTkdGamErZHBVcGNRVHZCTG5UcjA0clJVWEkv?=
 =?utf-8?B?TW1BTUV0T3YrRktxR0ZXYmQyNGhKd1Y4THFtem5mdGdUVDVpZFVSeHJPWTdG?=
 =?utf-8?B?MkNlMjl5UklYUy9EVjk5QmFuempJeW51eGVBaGVxNGdGTkJMRGg0SWhVc0h0?=
 =?utf-8?B?S2N3RUwrWGFVdmdYbEtQQlRoUlU3R0V6ZXhjRWdBY1ZvMWFOaTlDYkxVVHh3?=
 =?utf-8?B?UUhscGdTWHBKYzEyenlsNWxUS1pnMDJuQUlvWld6OUNSbWYzZ3pyYVFlVUNs?=
 =?utf-8?Q?mV4A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHE0Ly9qZjU3bExob0ttMWFqL09qcHIwSEs3RHNzemVCOUVJRmkwZzZUM0x6?=
 =?utf-8?B?Wnc2MnlIcDd5aXdSWkV6ZENYdE5XV1Z6OGc0VzJyeGlWZFE3aytFWjFmNVdr?=
 =?utf-8?B?dExrNGQ4YjVNZk1taHFkZEtFRnNnSmUvOFVPcnd6M0lydi9UU2Jnc0pyM0ww?=
 =?utf-8?B?dThCb3JIekh6MjZFbDJtRzVzUm9vb0czZ1h3M2I0OXNkOEN1R1Q1Tkwrd3Nw?=
 =?utf-8?B?Y2o4Tzl2UnpLZjBITUFqM1Nzb1N1Q3lkVlRuSUMrSlNVWnVNS3FkcDByT3Fo?=
 =?utf-8?B?UEwwOFU4a1pRcHFPVkFJM255U0dYaDNrSlJ5Wi9oRXdjcVhtWXl6cjJTZUJS?=
 =?utf-8?B?bjFRZnQwQTgyTEI2ZzhYaUtDcGp3cU04Q21QVUF2ZnlPd045U29hdEV6eU5j?=
 =?utf-8?B?VlV6VnJQMzBXVStaeFZmU09xbWJkU1ZiRXYwRGlKSXJ5WTkwbWVva0ZjT0c3?=
 =?utf-8?B?eDNlRmNGKzQ2a296a3JQZnRGK0VRaWhLM29oelJmMGFBWklqUmRrVC8vam1C?=
 =?utf-8?B?dUZEb3E1UVk2c0NmT0VSWG0vdnBkdldzOGVEY0lZVlUxanBGc2hxMDltSWEz?=
 =?utf-8?B?aXJsTnQxQmVxMHZPMmd2MEd4YlNZd29GVGtjNUFWSXo3RTA0aE14UEF0NXZt?=
 =?utf-8?B?dGRpS25NZ2VnSzlUYTJxKzVNRkRKbStFeW1HSFhqMEtrWWRKeWJUMXBDR1kx?=
 =?utf-8?B?U2hJeTQ1dkNYYnZOMTBxNlZhZnc1TnZ4dDlWQ242YXR0b3ZIL2ViQk9YeDhL?=
 =?utf-8?B?bit3bU1Jb2RGS2k1V00yOGN3bWpyQjhLcm44SU01UkpNRGtldStRNWZOaFp0?=
 =?utf-8?B?U3A2anJNbkp5U3RIdzEwcW5Xb2NXMUNBK2ZPK1YvUFhzUzFMaUhnL1UrWDgz?=
 =?utf-8?B?NThYam5QMDRmQVJzUHhOeHl5a01MclJaV2tzRWZEVEdDTm5aTC9wRCtlSmE4?=
 =?utf-8?B?Nis0VDJwUkx5RkVrYlJVU3VsNnJPb20wem9VcnJOeGNvZEFESFo3SW82VWRz?=
 =?utf-8?B?SFpBREZZYUVpOFZUdFgrYlhzN1F5MCtUZUtLbktYQjFCcDg1MStkR0V1NWta?=
 =?utf-8?B?cUJKY0RWWnRwdXE2VTQwVFpWT3BmL0VZaXFkNkFMelgyOUJLWXo1eWR3dGhu?=
 =?utf-8?B?TVdWZkpnVkljU2RpcU1iOXI1a01ZN3BJaTc0WUxEeFhzRWprMjVTbkF4V2RQ?=
 =?utf-8?B?RnJCSFNLUm1PakxocVh6UzFldUlXL0F1SjRXS2taY0NsVDBqdmo1OTB5WVpo?=
 =?utf-8?B?c29FaUd6ak1Qb1ljNW5Hblp2WWR6RDBqSjJBNlVGUitpOEZJQURMM3h4VWNM?=
 =?utf-8?B?S3pmNnBZMFd1c2thbjRVKzBiN1d0bGtuZVFWYTlZRDZVSGxYR0tEOXplZS92?=
 =?utf-8?B?dnMydExHODJOMzdHMDRsTHBzV1REL3Z0c3NEbTVsWUJPRVBjTUQrQUFNR2ZJ?=
 =?utf-8?B?SytBOWVnWXRmU1ZKV3EvVXpWd29GcUJGZThobTdiSVhIWXlSdzYyakx1TDZm?=
 =?utf-8?B?Vi8zam5lTHF1cWd0RlVENGFRT3lUVkE0UWFkaVpWQisybDB6UnNKeHQxZUM4?=
 =?utf-8?B?cVFYZXMwVWRkWUk4c1NMNXZ0WkI4c3MwYmg4R2FjZ0JraG51blZoaTFQbmEv?=
 =?utf-8?B?d1hvZ3BjRWV2RXM4MzJZYnplRm9SN2NsanJsbEV2Q0xBTVE2Zjlqa0tDQXR4?=
 =?utf-8?B?RmsrREFLTm1GY1o2dVRmUldnYlo1T1R4QjZJMWcxZ1A2Ulk3RDVlbE56M09a?=
 =?utf-8?B?UmlEUVNTOVdqR2dXTEMzOVUxblpFRWdJRStVdzRrY0V5TzBDZUhLNzR5eTlz?=
 =?utf-8?B?VVZtWEorR0ExRytIblpIZ1RNNWFVR2p2N21xbXBsOEhENnZ3cGgzS1NzKy9m?=
 =?utf-8?B?Q1hvTVlCMHlId2NpTFJ3U1ZIZHVIN0VmSytPcUNvbWR0b2lLcmdGSVVCSkJ1?=
 =?utf-8?B?eXcvMTRGdFRvK3RCTEFNdUlvY2VWVGU5SlZoWmZIenRPM0VsbGdGNTB4bU5r?=
 =?utf-8?B?SXhxTFRJbjgrNDI5cVYybHhQcGs5d1F1U3FyRzFvZytUS05FUXpaRFF3K3Uz?=
 =?utf-8?B?OFAra0xSTHlISkxXOTZQZmFkWGRhWGEyckhJOHNqQ1dnZWtKN1BtMko3TEVC?=
 =?utf-8?B?emtsb043QUFpdlU5NG9RK1NWeEFpSG5XM002eVZnU29ES1FQQ0JyUC9GV1pF?=
 =?utf-8?B?SVdxbG0xMUtCWnpBTEo2K2tPYkVrL0VSZzJWTkdqa2ZqWWFjNVhUNVAzVk1Q?=
 =?utf-8?B?Y2xwUFljcXNUR1JvdytTZEp0bE1FVEhBb3JFdzlOUmZObWdnZXI4cDNTWU02?=
 =?utf-8?Q?MF+dPKUbQnT5OoiBJ3?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5bb898-ac41-45be-eb8a-08de64b7e7a5
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 13:10:16.2360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQVgiaY1+HuDkS8c35OpN6dFc6hAEijnw7TTCPOeVoVJ+TAzLFMvQ6L73DIDUseIqszX908UoMkTRUlDGPbP9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOVP265MB8583

On Thu Feb 5, 2026 at 11:57 AM GMT, Zhi Wang wrote:
> On Tue, 27 Jan 2026 15:36:29 +0000
> "Gary Guo" <gary@garyguo.net> wrote:
>
> snip
>
>> > +/// Marker for normal (legacy) PCI capabilities.
>> > +impl CapabilityKind for Normal {
>> > +    type IdType =3D u8;
>> > +    const START_OFFSET: usize =3D bindings::PCI_CAPABILITY_LIST as
>> > usize; +}
>> > +
>> > +/// Marker for extended PCI capabilities.
>> > +impl CapabilityKind for Extended {
>> > +    type IdType =3D u16;
>> > +    const START_OFFSET: usize =3D bindings::PCI_CFG_SPACE_SIZE as
>> > usize; +}
>> > +
>> > +/// A PCI capability.
>> > +///
>> > +/// This type represents a discovered PCI capability and provides
>> > safe access +/// to its registers. All I/O operations are relative
>> > to the capability's +/// base offset in configuration space.
>> > +pub struct Capability<'a, S: ConfigSpaceKind, K: CapabilityKind> {
>> > +    config_space: &'a ConfigSpace<'a, S>,
>> > +    offset: usize,
>> > +    id: K::IdType,
>> > +    size: usize,
>> > +}
>>=20
>> Some thoughts about this: given that the IDs are different for PCI
>> capability and PCI extended capabilities, it feels that we shouldn't
>> overlap them into the same type.
>>=20
>
> Make sense. Sorry for the late reply as I was evaluating what would be
> the impact of IoCapable trait refinement to this patch.

There's a few discussions about this recently and I think we've determined =
a
generic infrastrucutre for a subview of a I/O region is desired. I'm going =
to
work on this in the upcoming weeks and would report my progress on Zulip. L=
et's
coordinate there.

>
>> The `offset` and `size` feels like it can be something more generic,
>> something like
>>=20
>>     /// A subview into I/O.
>>     pub struct IoView<T> {
>>         io: T,
>>         offset: usize,
>>         size: usize,
>>     }
>>=20
>>     impl<T: IO> IoView<T> {
>>         // ....
>>     }
>>=20
>> This is just like a slice, but act on arbitrary IO.
>>=20
>> The capability enumeration can just be something like
>>=20
>>     fn capabilities(&self) -> impl Iterator<Item =3D (CapabilityId,
>> IoView<&Self>)>
>>=20
>> and another method for capabilities_ext.
>>=20
>
> I actually had a version of that, but dropped it. The C side already
> handles finding capabilities by ID, so a Rust iterator seemed redundant
> for the common case. Unless we need to handle multiple capabilities
> with the same ID (which is rare). IMO, it might be better we add it when
> a rust driver really need this.

If we're not going to expose any API that support enumeration at all, then =
what
you say makes sense.

>
>> If you want to add typed capabilities, an option is to have
>>=20
>>     enum Capability<'a> {
>>         SpecificParsedCapability,
>>         Other(CapabilityId, IoView<&ConfigSpace<...>>),
>>     }
>>=20
>
> But given that the kernel's C API favors looking up by ID, usage of an
> enum might be slightly awkward here (e.g., calling find_capability(ID)
> and still having to unwrap an enum)?

Indeed. What you have there makes sense for typed capability lookup.

Best,
Gary
