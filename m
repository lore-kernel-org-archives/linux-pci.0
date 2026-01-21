Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022083.outbound.protection.outlook.com [52.101.101.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8937F24DD09;
	Wed, 21 Jan 2026 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769009811; cv=fail; b=UkN0KzFLHrCnXZNwcD7djIs/58E6Aat8BSwCg+b3zFcNXVKSMalR9dAtNuV59yvJKNRFF+o+d4fX8/MUcU1ebEXiLH+2yvPsr2aAMgYKc5FwMfnX43Z1hoDlG+BRQeE2rQvtAsHhx8E2H0Zp1Lw21+RoK8Bkhfp+c3why7sS2LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769009811; c=relaxed/simple;
	bh=jol+BQD/J8PKsBf8eVTT+zx5/4cIGqYwXl1DZWeO1is=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=IlFTVhPgAVrGhTOpZgvlNqR7H3ZRwAlWR5MMeCOHbfJu5n7G4WGPf2OW5DqGiDSHI7o70OwmnlQrygclPzMkcJjBsv4Id4NodDhxFbvlrcOMw97UjeCjJulAwePIlgZ9o/8R78CALazeiJub8qxhwcb0IgIIZR967Pt38qJoNNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=oJZXajHz; arc=fail smtp.client-ip=52.101.101.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="oJZXajHz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQBA0dx5orifqT5ecWB8yi6nU31wh+CbeKdyBjiqKJfxK84KhrbV4zFCKKGzXMtYDC28anSLUpAaCF8sCW1lxUbSZQ3/8XHPaWqwN/QJ6tCVNgxMbX5rqzCls1yRbNKKEB9ZNpQn7wNYMrLtjKNjNR+1Fdh3/sL1jmC48I0eDZcBtURTPypBLunIF7gNDdCfvrulghZMmMCyttPUZ5YUBd9bjiB7QHVYj6oRzVLXgpJljO9BZjV+u/6OVF6fWUDQTuBbNx6t0JET4DtnlIulvRfCmN1xy7FoZD/3v2qrBjX6J95RfJyoQ4zTll7/LhzCpl1tzPRjw9hM4XnnOIZO3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAAWwsMYsVIUPHXFecvY1m5jl3ETSDBewhnq6cKO88o=;
 b=Jc8wVsg0thgYBRveKBmSmFP+ai3exIGk88g0uLqfJs+egreIRpukbIWqozXl2UmT2VltgQr5nmi7Yg58Q3wLl5vLJkOQ0/XJaKndl8RI6nqhhg+6R3lpRh3pkCfWhzyH5f1dHQZWvHYHhq7tnlvndKzEw3NmBGvyCVUfcC6vaf5cGbcarH2sRl/2zvT3IXr8AtShtDpYcTBXdACFGfVpIQMaQpORG2KbTw7QkTu/nJlmPEpJtDZHMfSM+3xiNAKnLNZpokTdzQHQitAT4/eszSG3gjewl7zUPwvPyQAkvjdyhuZf91xNA6ut0uAVtJWsgZebczPuhDwtw80ggNf60Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAAWwsMYsVIUPHXFecvY1m5jl3ETSDBewhnq6cKO88o=;
 b=oJZXajHzZylsp2koe6mtTUViFaFjmu8txhgEMbBRZECRUmGGBml4vifdDr1cUC6UihfznfqvQ49yqBh3U1o0vYi7EKO+j9kmI35ZLgfg2qBO/q73tQgpirJlWCtRoomhmpHbfgjxDxhysjHhbwMQkygXuos3aFdbSHs2X4Ob9GY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB2848.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:17e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 15:36:43 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 15:36:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Jan 2026 15:36:42 +0000
Message-Id: <DFUDN05YDH4W.1VXNXWWZST0C6@garyguo.net>
Cc: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>
Subject: Re: [PATCH v11 4/5] rust: pci: add config space read/write support
From: "Gary Guo" <gary@garyguo.net>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260121142355.4761-1-zhiw@nvidia.com>
 <20260121142355.4761-5-zhiw@nvidia.com>
In-Reply-To: <20260121142355.4761-5-zhiw@nvidia.com>
X-ClientProxiedBy: LO4P123CA0094.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::9) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB2848:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb1cdfb-d60f-4810-f602-08de5902e0e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Unh1bi90L24wa3ZqM1ptN2N4bjhUdEJ6aGJEcmZWY04vQStPRVNXSmgwdzZp?=
 =?utf-8?B?MFlpemhzQlJ5WmF3L0xJNUlLRytWZ3EwQVRUZ3NiSzlScUVxOFNYNUU3bzRM?=
 =?utf-8?B?MWo2UjRKUEF1eWlzWUZrOXhWT3R4bkVXTXVTdjdycjdNNVhOdG5oZ1lNYzhB?=
 =?utf-8?B?VnA5YzAyUFlZb2hYQVNqdkk4YUlic1ZEMWd6NzlhM3ZsY2Z5N3Y3dDBDdXlM?=
 =?utf-8?B?VEZtdmVFcHNzVlhzbStsU1prRDl1ck9QZXoxZlFKNll0Y0tqNnJDQUlPQlRy?=
 =?utf-8?B?MmZEYTlPMjhmSGhNN2RKVG1od1kzK01rYzJ5Uis5L2N5cTJ5bUUramFlYmNT?=
 =?utf-8?B?UkdHRXBpVlhiZnU5YVprT0U1Rm1SOWt3YURJSEs3bmwrQ1NFdEVvclhacUtn?=
 =?utf-8?B?c3hxbE9scGkrRS9zL3VGODJLSE9rbmpMR0hLMlk0L0pjSC83bUk4eGIvdFNS?=
 =?utf-8?B?bEI3dDVBbS9XZzZFbDFYWkpISjFuWUxuT0dDUER5M2R3ZWMzaUprMzdhTHNO?=
 =?utf-8?B?M2NKR3JKVitJRisyRzFDeWM5azFNYktYaUlqbmNtY2RKTnRyb2RSWnlETXRO?=
 =?utf-8?B?WGUxM3dIVDRmVmx1UEdLTTllUjg4ZitTRkxocDlwc1hDZFduNmJjVVhwWlNt?=
 =?utf-8?B?cUs1OVF0ZTlIdHdKdVlSSzFBWEZOaU9rbDBPWU1jeDM1YlRWNE80VlNBdjFN?=
 =?utf-8?B?SUFFRVlCVld1VDV5dVR6TlFEV3NqYjRMVkVDV0kySWx0OHdtWW90ZU9lKzhZ?=
 =?utf-8?B?TkJrL3djOFYxZDhmZFR4dXc1Mms0cHkyTGxJeTNCSlAxS1BKOWd5QXZOWFVV?=
 =?utf-8?B?TGlCei9qdXk2RWp4dUtUWXZ4T045NlJpSHZ3TkxtTllIMkhSQXJTREVlM3Ez?=
 =?utf-8?B?YjR0SWJFbDhkQldIVHdtay8xOVZ5SWpxckl3WGVRcTBWSkpGNzFLZUVidC9H?=
 =?utf-8?B?dCtBWVcvanIwWXVCV3YyOWI1b0hRUUY5Y3lza3EzMzJmUkpFZEhPUmNFeGpO?=
 =?utf-8?B?QjY3RlVKQ0xmWEM0VEJDV2ZCN09vQVp0REZiRSthVE42M2NHalUyLzBOZHlQ?=
 =?utf-8?B?WFBSTGJzTTVmWDVGbW1pRnNHU0Z4Vzh0Z2FXbVZsMkx5VndNaFY3clVBZWJV?=
 =?utf-8?B?aGhubXAyVGc0U2svZ1dnRzNaRTBaYmpHMnJJL1lHMTRrRW4zVG1yNExoMlBw?=
 =?utf-8?B?WDBFL0sydHhQQU14Nko1STkxT2VZZVlZUU84SFRRbVIvUEVRQUt1Q1BSb01m?=
 =?utf-8?B?di81cW9rb3c1S1JrRmlRaFFmWktBVHdUK2xGWEpEQUVwUSs5WXFJRlF2Vjc4?=
 =?utf-8?B?VnBnOVZHZ3lkckg3Y2FBaDJFVXZRSnZ2RXpPUFcxZi9ueU0xRWg1N3o2anVR?=
 =?utf-8?B?dmwwaXI1eDkzMU9QQ3JhWVJ0em1Kck5kYnFXYzZqeW8yUXdBZEpoajB6KzNR?=
 =?utf-8?B?L2ZqOWtLZEtNSzBVUGxtRFBnb2NEWHRSTWJxdFdMRC9vc0FqSUNWeG1oTTNX?=
 =?utf-8?B?clE1dFJraVhpYmw2c2tpY1FuS3c1a2duQ1VIZXJYUlZnakpRZjZaK1A2eUQ5?=
 =?utf-8?B?WEtnUE5RV3JEWHdhdUVSdzhhemw4K3NnaVhTM0VTWVc4RHhTTktaMXc4K1E3?=
 =?utf-8?B?dTUvM0VPTFVaRFVibzlEREU3T3FiSW5lSG9Zd0tXdHdPNzNMT0tjYUI5cm1M?=
 =?utf-8?B?NFJpaVBKZXQwdVJpUlY4WTh5RDlHRU1nd0VsVVlPbnUwU3AzYy9zRXVDekFD?=
 =?utf-8?B?Q2lsUWJMQ2xnZjlUUkdvZFl5ZVpkU1hNL3RNWTBXS0dLNVVrb3dNSTQwUklU?=
 =?utf-8?B?Rzd3YkZvSlR5RWlEVmIwVFF6UE1kYmtaSjFqd1k4NmZhdTlIeUdyMDFFYUxq?=
 =?utf-8?B?bjNrUyt6QlVzWFMwVjR3cDRKbU9OSVJWaDcwREJTbGdPTFhkNWNLaWNpUmpY?=
 =?utf-8?B?RVpqR25xNnJyOElVVWtRRXNoT25yS2pWYUlxeU52dHFJd291SXdvS0RQZEFL?=
 =?utf-8?B?UHNBbWExN0NBNFgxd2h2OUE1VzBvMXhLREtPM0VVT2t1VzNISFlURHpTNlZL?=
 =?utf-8?B?Z2xQeTY2WEN3ZnNocTNZdlVyb0c1U3Y0R3NpWnlTUXNVNVEwRjFGd25GY0dC?=
 =?utf-8?Q?bRi4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enBLNTBQVWNqMEJObVVnSkh4c05JTUU4c1BKbXBKVUlBUytHN2llOEllM3lk?=
 =?utf-8?B?N3ozckJWYzFFU0s4cFUxdVdFRWh5c1p2ZFFYTDlRYTBnRUFncUduREJaNUo3?=
 =?utf-8?B?aEMyVWNmU2p3VzA5dWNoamtNOWJrZzVrbzF4Zmw5dzNPNlBtQTFmbVJkZ0l6?=
 =?utf-8?B?Q3JEaGdrTk5GZGVpKzBaZE5JSXVXbGtoVFVVeDdQSHJPM2twcHk1eThIK3lB?=
 =?utf-8?B?KzM2bUFCZmU3eXlHS0NQd3JlZi9IOTN6bHpXWU04alptK3ltbXBFTno2UDdW?=
 =?utf-8?B?YlBhVXNFZm1xWlBJK0VFTk93R2hFcHhsOHRqbHNOQU52dzd2ci82U3BjT0JT?=
 =?utf-8?B?VDUwV2VJY2I3Vld5VUtKc21zc05hYXpWbU9mdi9NQVhUOHNBRlZHcklRUmp6?=
 =?utf-8?B?ODdrazN1YU5VVFZ5MVU0RWpxOVFyQ2hEMStnWm9QTk1tQ0R0MWhyQkhIdTUr?=
 =?utf-8?B?RnFZZm5GTEhrOEszU3p1TWNxb0EvaEppZmJBU1RRb3hsdmg4TnJVT3lsczBK?=
 =?utf-8?B?ZFJJaC9TYU02R3JBMmhnV3R2UVUvN28zZ0V5S0xxVlI0YWFRVzhsN21xbkVu?=
 =?utf-8?B?L0l0UnBTNWRyK3JwaHcxcGk2c1VDWjlBVU9Deno3ZHF4eW43dnJHUTFYd2t0?=
 =?utf-8?B?d01pL05ScFM0WEpDQU9TWThYOGhTaHBOeC9hR083eWlQdEk2QndsNEIzeU03?=
 =?utf-8?B?enNNWGFHQjBVTmdnbGVrRlFyTXdJRFg0SlFRdkJXOFdkc3J4a3ZEbTc5K0Vw?=
 =?utf-8?B?ZnpkMWdBamFuYUR5VWFBNUg4Ky9nclY2U2szYzVlNlh6UDZCNU43aHdSUktr?=
 =?utf-8?B?NDhxMEwrUmxIb0twTHlqM2UvTU9YQ0tUaGFwZENyTXpiU3JwcnRyS290Uk9Z?=
 =?utf-8?B?b2dQNUpMMGZCdW5pb0FHL1kzWU43TGZwQ2lycXpVUnlPVktnL0k0QUl1MC9W?=
 =?utf-8?B?WFJSbFo4QktSSVpxaXAyOGJONUpwQm93b0ZGaGpiRUt4V3JUWkhRUzFCOHBW?=
 =?utf-8?B?U05sd085Yjgrem50Z0NycC9ZWm5RSXZKU2hhOTR5RWY3em9oUUY5ZzBzMTh6?=
 =?utf-8?B?WFBFSnZOMHFZSFI4WkNRQVB2eTI4ZWh1b0NMT2tiSTVKMzRsajRxaXlTb1lJ?=
 =?utf-8?B?MnJNd1pZM2ZxT05CTWljMjJlSUI2RGEwbEc2RDhIRmRpRytwbThMODcwbDJt?=
 =?utf-8?B?M0duNUNOMHlEYTlIemR3T1FtMlczSlNFUUk0MXdKKy8xLytRWjdhRGMxZkQ1?=
 =?utf-8?B?YlFiYmRQamIxeFZNRUJCV2Mvdzh5TEdHMEhPSXIyR25CVTcwYmxwSVhpaWUz?=
 =?utf-8?B?dzY2S25sQ3MrYXoyV3ByMnFuYzZFaXNzbERLT281ak5RZldrNzl0VzM2UFJG?=
 =?utf-8?B?TWRmM0Z5WmlPdnlML1BBQVJIVUtLeWZqWnp0bDN6ODFONGd2d3krdGpUS3pZ?=
 =?utf-8?B?bE12VTFMNU82N2tmRkFiR01nUzBBc05KdUttWGVCMmYxN2laTmRCTzZSK1dG?=
 =?utf-8?B?TjVSYTVVMEljV3UrU3VUTi8zZWROc3FNaFUzcmsvKzkxS2lQT3B3UVM2SXpp?=
 =?utf-8?B?eURPTjl2WndsT3A0ZnhaZ2NLdUZxcVRsUWxHaDk4cnVvR0JCUGRjY1NvZlBn?=
 =?utf-8?B?WnZLWDZmWXVMRnpGUnlVSXd2aUdzSE0wUWVHZ1FCR0tyUXpUT3lPUWV5aU00?=
 =?utf-8?B?dTREeXQwcDUxWnk0bUZ0UklQZ1NHMENuZVBMOXVEamIvVHRuOExjeEZZSitZ?=
 =?utf-8?B?REdOeDlybXJWOEFzRnF1UGNub1lVbUJWVXJvWGpXY2pwa1MwTForWXp5aEI5?=
 =?utf-8?B?b1krd3pVcjMvNXdYd1FBOUFjMWtNRDhTbEx3UjIxeStLaXlpYldIcW1hVXJ1?=
 =?utf-8?B?WXI0TE0wcEwyWTVyTzNLRVN3VXF5N1hKMUlDN2tQV1BYaXhHeEwxZnZLbmNC?=
 =?utf-8?B?eDRad1YwNHBuWU1PS0VKRkFQZWJaekxnTWNDSmczT1l5T1VQdXBCaEJ4aWNj?=
 =?utf-8?B?WlFRL0lYSVBMbFB6aTUyc2tpWFB4aU4yZ0FYMVRJaFE3Y3NMalZvVW9NNnJz?=
 =?utf-8?B?dmpTdzVLeVNRY21MKy9OT3lYWE9FNU1HZkQ0cHlsT3hNM0o4a2RsZGgyeHpL?=
 =?utf-8?B?TkI5cFZRTnhnQklXUVM3WWh6emo0WjVKOG1nUGxUNW1rbkFxSS9NVktEQ2c0?=
 =?utf-8?B?V09zMnlsVEpHSlZSMS8vSW9aZFBnSCtPa0FCK2J2ZHB3Y1c5RmF3OUVOdC82?=
 =?utf-8?B?alI0eDd1cHUydDlwT0FoOGdKbXJIanFqdG1JanpBTzJmRVAveTgzQTBvRStS?=
 =?utf-8?B?dDdQREo2Q2pGOE1rZmtud2JXdFBEb09VQWQvbkVTOHBHUWVJQmtTUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb1cdfb-d60f-4810-f602-08de5902e0e1
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 15:36:43.1689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHcdTxNMXwlsqPdBbi78roD0exL5UZhZZN2Vi0x5eymBhLLJ0xSxbVBhSl1wKTRmZuQEl2y4Ec+qJ7Y5Gf4rtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2848

On Wed Jan 21, 2026 at 2:23 PM GMT, Zhi Wang wrote:
> Drivers might need to access PCI config space for querying capability
> structures and access the registers inside the structures.
>
> For Rust drivers need to access PCI config space, the Rust PCI abstractio=
n
> needs to support it in a way that upholds Rust's safety principles.
>
> Introduce a `ConfigSpace` wrapper in Rust PCI abstraction to provide safe
> accessors for PCI config space. The new type implements the `Io` trait an=
d
> `IoCapable<T>` for u8, u16, and u32 to share offset validation and
> bound-checking logic with other I/O backends.
>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  rust/kernel/pci/io.rs | 161 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 161 insertions(+)
>
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index e3377397666e..e9c540fe80ac 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -8,6 +8,11 @@
>      device,
>      devres::Devres,
>      io::{
> +        define_read,
> +        define_write,
> +        Io,
> +        IoCapable,
> +        IoKnownSize,
>          Mmio,
>          MmioRaw, //
>      },
> @@ -16,6 +21,134 @@
>  };
>  use core::ops::Deref;
> =20
> +/// Represents the size of a PCI configuration space.
> +///
> +/// PCI devices can have either a *normal* (legacy) configuration space =
of 256 bytes,
> +/// or an *extended* configuration space of 4096 bytes as defined in the=
 PCI Express
> +/// specification.
> +#[repr(usize)]
> +pub(super) enum ConfigSpaceSize {
> +    /// 256-byte legacy PCI configuration space.
> +    Normal =3D 256,
> +
> +    /// 4096-byte PCIe extended configuration space.
> +    Extended =3D 4096,
> +}
> +
> +impl ConfigSpaceSize {
> +    /// Get the raw value of this enum.
> +    #[inline(always)]
> +    pub(super) const fn as_raw(self) -> usize {
> +        // CAST: PCI configuration space size is at most 4096 bytes, so =
the value always fits
> +        // within `usize` without truncation or sign change.
> +        self as usize
> +    }
> +}
> +
> +/// The PCI configuration space of a device.
> +///
> +/// Provides typed read and write accessors for configuration registers
> +/// using the standard `pci_read_config_*` and `pci_write_config_*` help=
ers.
> +///
> +/// The generic const parameter `SIZE` can be used to indicate the
> +/// maximum size of the configuration space (e.g. `ConfigSpaceSize::Norm=
al`
> +/// or `ConfigSpaceSize::Extended`).
> +pub struct ConfigSpace<'a, const SIZE: usize =3D { ConfigSpaceSize::Exte=
nded as usize }> {

This is quite long to write. Given that it'll either be normal or extended,=
 can
we just have two marker types instead? So you have

    ConfigSpace<Normal> and ConfigSpace<Extended>

Best,
Gary

> +    pub(crate) pdev: &'a Device<device::Bound>,
> +}
> +
> +/// Internal helper macros used to invoke C PCI configuration space read=
 functions.
> +///
> +/// This macro is intended to be used by higher-level PCI configuration =
space access macros
> +/// (define_read) and provides a unified expansion for infallible vs. fa=
llible read semantics. It
> +/// emits a direct call into the corresponding C helper and performs the=
 required cast to the Rust
> +/// return type.
> +///
> +/// # Parameters
> +///
> +/// * `$c_fn` =E2=80=93 The C function performing the PCI configuration =
space write.
> +/// * `$self` =E2=80=93 The I/O backend object.
> +/// * `$ty` =E2=80=93 The type of the value to read.
> +/// * `$addr` =E2=80=93 The PCI configuration space offset to read.
> +///
> +/// This macro does not perform any validation; all invariants must be u=
pheld by the higher-level
> +/// abstraction invoking it.
> +macro_rules! call_config_read {
> +    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr) =3D> {{
> +        let mut val: $ty =3D 0;
> +        // SAFETY: By the type invariant `$self.pdev` is a valid address=
.
> +        // CAST: The offset is cast to `i32` because the C functions exp=
ect a 32-bit signed offset
> +        // parameter. PCI configuration space size is at most 4096 bytes=
, so the value always fits
> +        // within `i32` without truncation or sign change.
> +        // Return value from C function is ignored in infallible accesso=
rs.
> +        let _ret =3D unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr=
 as i32, &mut val) };
> +        val
> +    }};
> +}
> +
> +/// Internal helper macros used to invoke C PCI configuration space writ=
e functions.
> +///
> +/// This macro is intended to be used by higher-level PCI configuration =
space access macros
> +/// (define_write) and provides a unified expansion for infallible vs. f=
allible read semantics. It
> +/// emits a direct call into the corresponding C helper and performs the=
 required cast to the Rust
> +/// return type.
> +///
> +/// # Parameters
> +///
> +/// * `$c_fn` =E2=80=93 The C function performing the PCI configuration =
space write.
> +/// * `$self` =E2=80=93 The I/O backend object.
> +/// * `$ty` =E2=80=93 The type of the written value.
> +/// * `$addr` =E2=80=93 The configuration space offset to write.
> +/// * `$value` =E2=80=93 The value to write.
> +///
> +/// This macro does not perform any validation; all invariants must be u=
pheld by the higher-level
> +/// abstraction invoking it.
> +macro_rules! call_config_write {
> +    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:ex=
pr) =3D> {
> +        // SAFETY: By the type invariant `$self.pdev` is a valid address=
.
> +        // CAST: The offset is cast to `i32` because the C functions exp=
ect a 32-bit signed offset
> +        // parameter. PCI configuration space size is at most 4096 bytes=
, so the value always fits
> +        // within `i32` without truncation or sign change.
> +        // Return value from C function is ignored in infallible accesso=
rs.
> +        let _ret =3D unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr=
 as i32, $value) };
> +    };
> +}
> +
> +// PCI configuration space supports 8, 16, and 32-bit accesses.
> +impl<'a, const SIZE: usize> IoCapable<u8> for ConfigSpace<'a, SIZE> {}
> +impl<'a, const SIZE: usize> IoCapable<u16> for ConfigSpace<'a, SIZE> {}
> +impl<'a, const SIZE: usize> IoCapable<u32> for ConfigSpace<'a, SIZE> {}
> +
> +impl<'a, const SIZE: usize> Io for ConfigSpace<'a, SIZE> {
> +    const MIN_SIZE: usize =3D SIZE;
> +
> +    /// Returns the base address of the I/O region. It is always 0 for c=
onfiguration space.
> +    #[inline]
> +    fn addr(&self) -> usize {
> +        0
> +    }
> +
> +    /// Returns the maximum size of the configuration space.
> +    #[inline]
> +    fn maxsize(&self) -> usize {
> +        self.pdev.cfg_size().map_or(0, |v| v as usize)
> +    }
> +
> +    // PCI configuration space does not support fallible operations.
> +    // The default implementations from the Io trait are not used.
> +}
> +
> +/// Implement IoKnownSize for ConfigSpace with compile-time size.
> +impl<'a, const SIZE: usize> IoKnownSize for ConfigSpace<'a, SIZE> {
> +    define_read!(infallible, read8, call_config_read(pci_read_config_byt=
e) -> u8);
> +    define_read!(infallible, read16, call_config_read(pci_read_config_wo=
rd) -> u16);
> +    define_read!(infallible, read32, call_config_read(pci_read_config_dw=
ord) -> u32);
> +
> +    define_write!(infallible, write8, call_config_write(pci_write_config=
_byte) <- u8);
> +    define_write!(infallible, write16, call_config_write(pci_write_confi=
g_word) <- u16);
> +    define_write!(infallible, write32, call_config_write(pci_write_confi=
g_dword) <- u32);
> +}
> +
>  /// A PCI BAR to perform I/O-Operations on.
>  ///
>  /// I/O backend assumes that the device is little-endian and will automa=
tically
> @@ -144,4 +277,32 @@ pub fn iomap_region<'a>(
>      ) -> impl PinInit<Devres<Bar>, Error> + 'a {
>          self.iomap_region_sized::<0>(bar, name)
>      }
> +
> +    /// Returns the size of configuration space.
> +    fn cfg_size(&self) -> Result<ConfigSpaceSize> {
> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
> +        let size =3D unsafe { (*self.as_raw()).cfg_size };
> +        match size {
> +            256 =3D> Ok(ConfigSpaceSize::Normal),
> +            4096 =3D> Ok(ConfigSpaceSize::Extended),
> +            _ =3D> {
> +                debug_assert!(false);
> +                Err(EINVAL)
> +            }
> +        }
> +    }
> +
> +    /// Return an initialized config space object.
> +    pub fn config_space<'a>(
> +        &'a self,
> +    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Normal.as_raw() }>> {
> +        Ok(ConfigSpace { pdev: self })
> +    }
> +
> +    /// Return an initialized config space object.
> +    pub fn config_space_extended<'a>(
> +        &'a self,
> +    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Extended.as_raw() }>>=
 {
> +        Ok(ConfigSpace { pdev: self })
> +    }
>  }

