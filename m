Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.92
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792503433;
	b=3LDu9GAzyZuo89XAPAcfLZr/ZsLd3BcCFMoDvLuOJc+k794X+CBmI/JwNW+J2Nnnvo15
	 2tPLg7ruQxpayCFOFDzjoz7aUMT4ReXmvgHePsSRur6U60XzFjgAv3WnHmIOphF4XN0mE
	 03HxvQFTOa/kKKYgyjbG9ZFINhyyTYdAb3gm2Z51v1MnVETEGSuKxK5ww1uyOjqn+s/ch
	 1owFMgmSeLI+5v/s8ys+SkPpGCBFGXctoESVed04Z5H0DNLazqiuXa6w6hcPl8bhOCMVH
	 eBzov3UIv+bfJ/QNh4xwVK/KN7+7MbsvsiLTWu1374gIiztLbE+Qb+lF2xpcPdVmJgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503433;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	bh=GEzMky08bQyMX+eeMACSqxKHMATyk6e+NKIYHRU3SjQ=;
	b=ViUQvwvi+gGBvWoLJlZFA0Dawypi70F4kiXU3oeJYVqF/AiwGnl6wvQGKfuw8fEBXFVM
	 dbEafoS1CoXzRQiZ52xlbw5VcPAeoTJF1/OqSvqucinn1+pZIVQJfABe4NEYX2AGsAmmq
	 fLab63HDf3CAN5/zMt6+bGJL2uo7LZEfTPWcZrd98z36uSvbo/uYJS1m3GXWismEncrND
	 7KpWkXN0wKJ4hQIOxYt0xKk/nDD3WRkmVdebNROrObQW5noQtTSgo4LevrJzMQL0JkzjH
	 rgvqT4gYaxnpCkO3gMgC5uLN+iGL4lnDnVhw4hZrYPkiiag4MuKgJuy/DgDhQEcXmzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=EGhryio0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.92
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021092.outbound.protection.outlook.com [40.107.74.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E763606A323;
	Tue, 20 Oct 2026 13:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E763606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=EGhryio0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6GY9+ZxOFmurLe6k8sR2+T1wZ7u6WvRBjaBd+Houe4DWhpgLQ+gQe4ik8WcGiwhD+0hFuRAi9Mi8I4c99P+mXEa3iRtMpegXU+QQjoFqUOwPnu2F2aGHayxEIhkd9r+fC+2fsqKvT/TXXdvCeVbd4Zbg9xqOwtkBTyd0D0A/V/Lsfawv49luZAEXfTRKGegybFpi0r3pz1H1dbJB72HBmbgRGVsfXxnp/qw39+HCunK2vf+EuBPfiSJZnCq9l2J3/Ekyo6OGqKUo5PuwTdr5hzwYOPG92LP9WuFFZgLK6ME4D86UgWSKeC/a8i+I9EaGXQdk8EqHUwY+md8T1lc5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEzMky08bQyMX+eeMACSqxKHMATyk6e+NKIYHRU3SjQ=;
 b=BJgn5JejmKTOKdw1x36PvvRpF2E3XfpvSmJulyr7bW5Tz0pCaE68xINVVs4rivyLj/fF2wTEBdVysH290Uq/p3I4WKr9+NtorQc/bllfCovLoZ9CuDA8ZCbTy+ejo+kwE2MZBUTw+rpNZ2xttCvsszMb1ckzrL6sM9xgMaegGhRZxYKtHmuDJt3ZTuzEMfdms51EBnCysur4GFYtt8buLndoBwJAy/fwHobTXqk5EDMZKiN3XWGxqp3/JqkQKHMdr1n+qWfincGfK4sqaNoelY9MBHlUlrhm2GpDMmiUJzU5D84Wt8J1KwgzQsWdQ1mJ9/NeT4HoZ7H9QswipI6xUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEzMky08bQyMX+eeMACSqxKHMATyk6e+NKIYHRU3SjQ=;
 b=EGhryio05w/OurvWl0WH/K9Upoyz8LSx8Kd2X0GUwo0eRZcmGeQklYaL1j1ZKNWXT6XedN4vxZRb1b4KSl1p5eJfDk5AAjMHRleMFMHf//69/Eod/w2xBKxitxgtoDSn3ocJEAYXJzeV2LItL4YhOcHtpsuIBYhaDXS3+PTT8T0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB5658.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Tue, 20 Oct
 2026 13:37:08 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 13:37:08 +0000
Date: Tue, 20 Oct 2026 22:37:07 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Frank Li <Frank.li@oss.nxp.com>, Frank Li <Frank.Li@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI: endpoint: pci-epf-vntb: Honor MSI-X selection
Message-ID: <pzyfs2bwt2ey2te6kpc2ttco3btwto34yzaq3jggomsshjjold@gynf2ztpfnz3>
References: <20261014053256.2378817-1-den@valinux.co.jp>
 <as-UJX1jD8ZFiBxk@SMW015318>
 <x53diijgm6cqfjc5rlihi5q2q54nxdbgvs5u3cfxg5zfdo5w4z@hayq2svzwfes>
 <j43nhj3wyu5tocjiots2xm4v2yxtngsxoaafkvxtputxxttw7j@snrzxkr66vkp>
 <atBo0WvV9S2xhVc4@debian>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atBo0WvV9S2xhVc4@debian>
X-ClientProxiedBy: TYCP286CA0024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6d6dcd-66ec-4f04-117a-08df2eaf3cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|23010399003|7416014|376014|22082099003|18002099003|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ldctSTbGZrakanlCulCnvyNp1gobQHhXTIxRhrvzsrpYCYJF8+QQOlilaOA0WzvYMMFDvwjULjyQQmKhm2nXvbG+CcdUYBoaWit55uXGeANHHUnhuQtcFHVzFHMSGAPJX9SALFYMs+jAk9O7VyyNaaXxTWF0/M+mQEUvl9DRUFABLRUB6DzZk2IGwfTO672ZE0lfVe17e/qGfMazXFOow55PzoeKPGQiaAjq+6x/CWjrcMvJtqpwfSRF431D/qBzwvlDR7lOVZ+ANCd58NqnIS3pF9/HP11akJNwM82FoCd0fg9HRMsIgV4Hyeb/iUB0JrBKzOoqy6KVaaSWTk1dGa+HAJ0reKqCcWpVBToLD12uFaUbusRmYzUBBX9lC8ou6ekrHnn9G7CiuF7kFsz1QYd+kxf0SlN9Dpg+NUTuThAKEMrs7CLd2QaKtZn9DiyoGhyaFLg2WgbdVDC8iZicae+Z+sv0E8cBbipSNvzJzTqF6Lki58Ci/e2A+Xw9BVV5FO4L1jFXKCYRo+QvKOaM/dmqq1FhaTyzTfuGcSQa2wSAGbxWt7OUJMWP4Cmb5axziWDxxTi4Qv4+3NEnC3R6utArrTWY8vSHx4JP7aAFOTqVc0bf0cEHU2tIuNYiPttiXDsoIwSzabtwmbwlY4N/E6iPz4r7HlY9k9j90efw9XI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(7416014)(376014)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bW9ROVZkckhERVE2RWdFeHM0cWlDNzBlbitXL25vSWRLNzNzY0M5NEk3UUZr?=
 =?utf-8?B?blpUWXp2MDNMNlF1bjIzYlZQc3lscnFxV08xcWwzQkFzUXJlUXQvUnlpTzZM?=
 =?utf-8?B?QWhocDM3RWFSem8zcmtEY2I1UC9EakhMSWtTc1FCeHR5QWIxb3NHRnBvTXor?=
 =?utf-8?B?S0VzYnZDYkpiL29tSVVyL1F6Y2toa09QUTdkK0RYNnpHdW5reW80NllLVEg1?=
 =?utf-8?B?cU5KRlltWHI3a2hBdXd5MWhaMEhrMy9DZDlsWSs1bVFRUEwwTmR2L0JrTzVZ?=
 =?utf-8?B?QlE4OXNTUnl5Nk82alBHUVlacFVyeWU0Wk5JMnB0dGxtcmFLbm9oSFMxdTNL?=
 =?utf-8?B?WjBsVk1jL0w3Tnl0K0JFakZyL1J4RHFJT2hiQzBMVm0yUWZpMGRpRHFDN2VQ?=
 =?utf-8?B?cmpSdVdZU1p5UThHZ0orSERCdi9EVkVVeXowZGlnbDdrL2NJdWZhNFBheTlz?=
 =?utf-8?B?K3krdmFsU1prNjlYeXJJeVRBZWh0TW91YlFGYmEybitvOS9MUEF4SC9hT3Zj?=
 =?utf-8?B?R2ZuSGpGRlBzT21Eek1yc0ZSWlNMdVJxdmVCUjZnSzF6Y05KWHAzSWhoUHIx?=
 =?utf-8?B?bVVuM0VrZHVsUW1JVm5Zb2lweU9YdFE3VWdmSjhJaWZSUlNEUlFGRFBCVEpp?=
 =?utf-8?B?TE5CQ292Q1VCZ3F5NWU2NytjU09EMFdnaUhoeFNmQkRJL2VkSURNcG0rbmh5?=
 =?utf-8?B?enZzSEdPd0RBa1duMk1hNXl3QVlXaDZNQU9HTzN2UWppYnBWNmwzKzZjK1ox?=
 =?utf-8?B?YzFPWHJyWkJEWEZyTU5ZaGpaaFVJdGx2OU1uRzZuenovVk4vNkhBcWk0ZXAw?=
 =?utf-8?B?MFFYNDBOMGZWMlBCOWNkajFzZHBIMG9EM0xoY0NXM1R2dGM0UTVxdS9LNzFX?=
 =?utf-8?B?S2VtYnB0U2hQYWJTSzNpNkpiMGgyaGtlQ3B3ODBuQi9DakEzK3ZwbTF5aTF0?=
 =?utf-8?B?c1J5d3pDZGNCMm1RbEcxUGJTTEhPazMzYi9CMkxER2dFaldvMmJQd0ZydkJB?=
 =?utf-8?B?aFkvcjN5TCtkcTZVSUhwVG5vbG1rcFNGZHk3enl3WEJTbGZPTVZkdSttZ1I1?=
 =?utf-8?B?ek9RQlRGM0o3ODh4Zm1TZnd2WUFzd2ZSQ1VzSEplMXNNKzg3WFRaemEwVURV?=
 =?utf-8?B?L3p1MG1EZUZwSmdFL2ZuNW1VZ2tDOVo5a3RJbHc1RTdxRzVFQlFQazlEa0NO?=
 =?utf-8?B?S1NhdTIzSVAvc3Vvc0piekNVUW9rSWZvTWZaM1U4YzFXZkFpTklHbUpYTkli?=
 =?utf-8?B?YVRXR3JJTEJCOEs0MGhyd3E4OEVXSWxkblhlSVgrMERhTFg3SkpMUjNuOFVR?=
 =?utf-8?B?SzNPb1ZPS2p4YmZpRG9rZk1JWXpOY0NxazBuSEpBNGNkWlJIWnhqRmNIZndW?=
 =?utf-8?B?WjNYMGN5RzRodTM5RW1GRFVyZ0RvVTVUUWp2V0FWQXJUNlhRbkdPOWFVUWda?=
 =?utf-8?B?ZFk5Z1cwaG5rVmNtVlpxeGFnUldGTXg2SjRrWlU0cThka2dSa2VJeXFsTzgz?=
 =?utf-8?B?bXRobzIzc1FaL1RXbkJoNWgyRUQzUGtFN1AvakdrNnhWWHJrV1piOHJSV2xZ?=
 =?utf-8?B?amRiMXN2dzUzVGF6K1NITDdJY1J6aSs0dlJiUnlDNEpKNEhOVWFJaVk5Sits?=
 =?utf-8?B?ZGJTRnhoMVp6RnRPejc0MHN1U01GeWM0cFpzUkc0SVAxdngveDZPYW1nRFRj?=
 =?utf-8?B?d1BBYkJscWZkTE85ZXIvSTgrb3RkQ0dldjNXUmU1Y3RXcm93ekpCbGZaSEQ0?=
 =?utf-8?B?SUc1MTZDRFQ4OU1xaXFVaWJGaklZRVFKeWNBU0o0RGxwaUI3SkhpdDRNc0hN?=
 =?utf-8?B?OHV4SW8zaG5HSi9kdjExVDlHUE4zUTF5cUFzRmdoZUh1NE94VkN6eTVYTVFS?=
 =?utf-8?B?T25BdFEwUUc3NFhBTVRvejNKU2MxZ09mSmUvSXhiMXBPYjk4MFI0cS9oRVNW?=
 =?utf-8?B?czlpR3ZhMFNtWThYanlyWWZDdjRQSXNFSTdkSHowQkRHdXVQSW04S0xsUzIr?=
 =?utf-8?B?QXFIaXF3SmIzTTBiWWlZVGZqYVFQVGJMcFhreE9UQnpReFlXeGpka2RreWto?=
 =?utf-8?B?cE1pUjR6R2NFOGlrY0szblRYQnNFT3NzZ1JaVVVSc05nR05yYTY3bGx6N25E?=
 =?utf-8?B?VE9SWEM1TCtTQWZVaWZMQzd5aU5mOE1zVVVidk8yRHk4OUx5UUR3LzBvT2ZI?=
 =?utf-8?B?RVVNRE1EUitqR3h1ejJtRGsxYnlHN24rZWlqUHpmTHgvZlQ5a1hZWlREc056?=
 =?utf-8?B?MjNueDdYdDlZU1ZpdGk0NG56SVd0OTN0Q3lxUXllSUJQVkVTNjhvVnVrYTF3?=
 =?utf-8?B?T0ZEV2o5ZGFUcEZISm9KcG9xTFRjcHNmZDF0S2drbEJiblhoL1dBUmM1R09i?=
 =?utf-8?Q?YfDRbpwERUGhdFFuTrvvjGXwOPmbfEZ67MbC0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6d6dcd-66ec-4f04-117a-08df2eaf3cd9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:37:08.6337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/c33RoeR2MH28veoV0mb4OsgCp3qriE9ab7VX1xKo+kwhHh71zaEMsvA2GsOL0OCwxCyPm8TeSyKrSFz2SyRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5658

On Thu, Oct 15, 2026 at 11:21:55AM +0530, Manivannan Sadhasivam wrote:
> 
> [...]
> 
> > (+To: Mani)
> > 
> > BTW, I'm thinking of basing the next revision on [1] (thanks for the review
> > there too). This MSI-X fix conflicts with it, and it's not just a textual
> > conflict; the new link-event notification also needs to care about the MSI vs
> > MSI-X selection.
> > 
> > Since [1] already has your Reviewed-by,
> 
> You mean Frank?

Yes I meant Frank. Sorry for the confusing placement of the "(+To: Mani)"!

My apologies for the very late reply.. I somehow missed this email and only just
came across it while going through my inbox.

> 
> > I expect it to land in pci/endpoint
> > first. Please let me know if you have any objections to adding [1] as a
> > dependency.
> > 
> 
> It mostly looks good to me. I'll apply it today so that you can send this patch
> on top of pci/endpoint.

Thank you!

Best regards,
Koichiro Den

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
