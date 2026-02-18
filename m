Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021109.outbound.protection.outlook.com [40.107.74.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C802F616E;
	Wed, 18 Feb 2026 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771432586; cv=fail; b=rJZQCVv0CA5kHgLkljf7EJm8edqJS7dHdcZybDWTPTTJnCX5tShxzgVNEEBDLJv2fck1GBK7sbfJJPLxkU7/r605Q4esEb9l9jkNGKYv7JL1t55/+NB2E5aGP0iKeIXU4z/aVMdzCsuO6R+kVmet+AQwDR5wZMv/Xg+bAKqvLRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771432586; c=relaxed/simple;
	bh=5YBvO+9F0A8KReHu+6BySZDEazXcROkYjqJnxUoFEFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pLH72JVLZ6orqWXbAxQUSrRSoTenOJ5QfW/DylGcK8oyf6K+ADaxE2X4jzjOYd1HKpXlcnK58dlta+fpw6/ijnv2W3nfmBi0/7NsoSJF8hsURfl+0Oxf0jDmZ9HcZnULwsd6WPXiV7VZgv8jTJPaeTtX6Q5B8w6ooBF5qbCC4qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=SDSV1hWz; arc=fail smtp.client-ip=40.107.74.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="SDSV1hWz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEygo53H6KGEz0im+Fqdajv0zcvGnc6vUElVH+FX2fCkvx/pb3RmZOwq7DGXXBel5QZao3ryIE2RO88E3VXrXAkU5ZehaSpaI2cA/sGU8gBfolQdTW8k50TgsIXjjf2Bpw2WdhgziR6VujXxCwnOqwxkMWL3diUwVWr8wa3Z5BDLIC9J0AY5Ns89Ki2zmtD1InkR9iNIrOxSBOrZYQjgqbnoqiTrMRQ03xmNWMCp3W8JI1teZozHqNkdM1kIKubVyMRffWHm19seD2q45+mjP3RkwYzMc9tsa4vEJl/53/OFlwu6sOl2nAiErHdHoXkXPUN+lX9qti4lKuub1TklHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wj5XSkjO3l3nPKCLLsQW3FprlvYIllENT43A2+hfinw=;
 b=n0Axx2JdfWr4hIl1HpRW0SAzdhX3Smv54dR4dcpwm8W+dPPEml2rv4KHTB+aelHXrV1M96GuRtj3ZtJlBGxzIFl9/GCTyIeDLMTLBO3cOaifaO+K3RhiEkMhS8g0A4bDEFV6oAmwjOdEqUknx6z9wWdiM9CyzP1eKi5vd0txlU6TGoUCcn1uC43KW7nL4brB+ED9S/7CW6N5ZDyhDWU1bU56G9nxA99QJ7nH4x2MeDu04+wqetSLeGiPjgYXlWYjCIJysnffM1JxSywH+Fm+YVDCQCVbX6SbAJb+dsVVpdCp3FLyzcapU2m1nXbmv7/4WH8FeTQQoG8RVGdPYuiKSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wj5XSkjO3l3nPKCLLsQW3FprlvYIllENT43A2+hfinw=;
 b=SDSV1hWziukpKKlta3Bg+ZMXxxddBV4omqv4RpNr+iR6PGGC3DiRx0PHiwM6KHFurXdbJ+m6/3aferFdwbp8IFrJkpuLLTgFsdeUJZsBWetMrbLvXn8z//kvsLTyfUUvwUzZMQ+wy3Fp01QOqJgc88/7fKHP/nQb+WVCQhzS4Js=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB5598.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:294::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Wed, 18 Feb
 2026 16:36:18 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 16:36:17 +0000
Date: Thu, 19 Feb 2026 01:36:16 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Frank.Li@nxp.com, jdmason@kudzu.us, dave.jiang@intel.com, 
	allenbh@gmail.com, kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, 
	jbrunet@baylibre.com, lpieralisi@kernel.org, yebin10@huawei.com, 
	geert+renesas@glider.be, arnd@arndb.de
Subject: Re: [PATCH v4 0/7] PCI: endpoint/NTB: Harden vNTB resource management
Message-ID: <zet2ktcxydgsbf5ij4476vqqrb4apwfk2iag737ht5htphobhs@3dbc6i4vl26y>
References: <20251202072348.2752371-1-den@valinux.co.jp>
 <7hqhqbtqvrw6bqraykdbccllags6gyal6rekb6yehcfx2tzhet@lex46cqheta5>
 <ap43e4jypppkpavrhf4ewgeivwnfrlldykkqyf3oqk6i4ckbhx@cg47vhgjzbrc>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ap43e4jypppkpavrhf4ewgeivwnfrlldykkqyf3oqk6i4ckbhx@cg47vhgjzbrc>
X-ClientProxiedBy: TY4P301CA0126.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c87db0-309d-4bb9-3aa0-08de6f0bd6fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnBLajM3TElBMkg5WUN0NW5ySEQvYW94SndGWGUzdVZvNVRVV2dtWVQzMUQ0?=
 =?utf-8?B?NUxWa0VGUFp3L3MweEowNnBMcWIrcnN1OFFvc0p3S09mbGxtaEtZdTJLQUJh?=
 =?utf-8?B?UUFCeDF1R091cG1ZSjAzRm5kcGUzbFp2cno3cTZVYzZlMmNTMlZyM1VraG4y?=
 =?utf-8?B?ZTZBVGhvSGo3UkJSVnE1VzMzMXgxUnpOSG1yd09KRmVIQWJVNHZDeDBvZVMy?=
 =?utf-8?B?Q3NKTkVoYWNDS0x4QjJ1NDIxSEc4ZmxaMWJpZy9wRkR1NG5Kc3k2ZGpGT3g3?=
 =?utf-8?B?LzkrTlplYUU0dGtDYnpPWTlQbkYwZGN0d0pUd3o5QTVxVW1XZWtINTh2M0dV?=
 =?utf-8?B?TCtDRWtoMnBBRmJlZEhqaWhMSk9oUkRhRHJGYUxvZU4rNmQreEp3d0dBRFl0?=
 =?utf-8?B?QVFwTVRFR3ZoaGlnd2g3WWRpd3JIRXpRbkp2SzdMZGhuRkRXenZPMXBDdENP?=
 =?utf-8?B?K1RrNVRPMWdpbkxRSGVRbzM4eGZHdWUxR0Rya2xVK2ZKdlZKT0ZMK1VJOFdE?=
 =?utf-8?B?SWdjbUNuYWRJZE1QVGw2U1NzU2NXVStWT2gzMjdSTFRhdHY5dWZPMTM3aXd0?=
 =?utf-8?B?ZUJCZk0xTHc3M01vTHRySXY1NHNpemRUbnpJZE9qUExpSTlHU3VkWGtTSExI?=
 =?utf-8?B?eW5aSlNwNk5QaVhzNW1CNjdaZERPR2huTFNMbGtKeFRaQ1Z6MVVGR09pQ0x5?=
 =?utf-8?B?bnd5VGwvcXNBaWJjZ2syellEZmZRUG9IOFgxckN1K0t0NGpnd0tQSHFCMTBt?=
 =?utf-8?B?L2ViMzZqTGlNU3ljSTBpZDB4c3NyU1ZadFpLYmFGVlFtMXZaM1I3QWVmNncr?=
 =?utf-8?B?eHd1SnIyWktibGNJakQwRktBRFpwbHdkTVdUQXR2OW1oTGIyNVNlREdLS01s?=
 =?utf-8?B?bDdWeDVkZWVVeW1tZjNDRk42TWZxZHpZR0plUzFPN1lKR3laZmtKaHlsZ1NP?=
 =?utf-8?B?dmxvT3Eyankxc0xsdE53MHM3eDhrY1pDTmxwL21oejN5alZucDRKWW80d0FC?=
 =?utf-8?B?SWkrTlY0aEdUTVBLVjV5UWwzTUNLUC8vaTJSK3RtVkF4VzVUWGd1YkJpb2Zh?=
 =?utf-8?B?QVhpUzFVM3RWTmtpVjVDRDdDNFF5OTR3Sk1FNzhNY3UrSWpHdkFiQjdLN2FM?=
 =?utf-8?B?TVNZUXhkbmZ0YnJUdDZjMUgrenA5cTR2SlFCU0FNcFR3bjYrRklJc3pIRjhU?=
 =?utf-8?B?akdTcngvR1daZEFCajBpelVkWElybCtZeXFhaHR5TUt1SEFlRjk4Y2ZwM3Mz?=
 =?utf-8?B?UWtxeVlrc2lwdGNqMzJZMVZUTEFZVFJDUTZuci9PY3VHNElNSXBLa3N1TUNX?=
 =?utf-8?B?a0ZDLzM4VkdkZmtZaDQxL0RuYktiSk1IMEhUZ3dDUUxUbU5EOWRtaFNTYTBJ?=
 =?utf-8?B?NTJ0OHAwY0lCMXhlL0dCWmNPMmRQRE5FekpEZFZoSU5Hb2lFL0pWWU1rWFg0?=
 =?utf-8?B?SmFOS0N1c1lZUzNseGd6N0UxN05QMWIwcVBybkUvVndMU2w0WFBEOU8rU3Ra?=
 =?utf-8?B?TERvYi96bHZFRUN2OTNwUndvdDV5V0VBdDVuRjFDOUhiaFI5d1phcTVYakdP?=
 =?utf-8?B?d1F0bTBqdmc1SEVtNWdDY3ZwMENhUjRLazhIOTJTdUcvZnI1NnJPSzl1ZytN?=
 =?utf-8?B?RG1mbFU5TzRINHVNRnpIZS9HTDVOeW5sWDd2N0Juby9sTytWS09VWG9zR09x?=
 =?utf-8?B?dTZhWHQ5SlVzK3ZRSHMxc0FDYTZWYms5aE1pS0k3anpTTkhUd2Jzbk5FZC9u?=
 =?utf-8?B?SDVXNmVIRDdDbFZjQWhycmIyM3h3anRzN2lEYzlWL1pMaXU5eDZ2UnNRQ3c3?=
 =?utf-8?B?WS9OQys2MmdhTzhKb25uZ3dkOXAwRW02WW0xVDU5OWtMQ0N1K2dMOGgzMm5t?=
 =?utf-8?B?cUdxam5RYThKMUptWnE1WG4xcDBUWWpSOWtidU5rQWtnQzh0YjJYMzEzRzFT?=
 =?utf-8?B?bm9QdUl6ZHlpQm0xaUJNY29jRkY3enF2UVVBdHVLRXZZT2FqbVlINTJ5Vmdz?=
 =?utf-8?B?L0tZOGxPL0VTSFNnK1FqMDBobXJ6QUtPSEVraUpQczN0VS9ha3lmdzh0YS9x?=
 =?utf-8?B?ZXdSaEp2NWNHbzZib3NKZ3M4ODRHOFQ3QUhwVFpZV0Vzd1loMnNnQncxNDRx?=
 =?utf-8?Q?M3JI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjZzV1RVTXEzbXEwZ2NDQmhUeEwyVGxmMWF0L2p6cWNjWHdFN2ZDamFOLzJ3?=
 =?utf-8?B?SXV4emR4UjFSM2Q4RlNPT1hlblEvV3VxNC9JT1VDZWY1ai92aFNuRDdlSENQ?=
 =?utf-8?B?VmdhY3JtMExMR29Pa09wMlJxZmp1MGdnL2lObmJVRnlvSDdkSzg0MkhXS2RL?=
 =?utf-8?B?SGd6eitIRUwzZmc1Vk5VUU1PMDlBemJ1WHRpbjB3ZHZyTm84VFlCU0k4NGV0?=
 =?utf-8?B?WjZCNnVmZDEzWFdnd2lnQWFURE1xaDU5WFdlNTlkNjJVYzFMTUZNWi9FSkFn?=
 =?utf-8?B?RU1wTTdFdHRrN01qb1lzcEdpNUNHRSt6d1JsOHpycXV3RGNmNDM1Sms0TERY?=
 =?utf-8?B?TTMva0N1bDR0clFVejlIRCtncm14Z0ZFMVlKeFc3R2V0ZndIeFlUSkhrM3Mx?=
 =?utf-8?B?K3dGY0NVYXpiQldVVXAvblZZejU3eFBsNzA2T1dRNU5LYnBvdzZnWEx0TTE2?=
 =?utf-8?B?aWpXWFFhdXBreWI0NUYrRldKVjEvSXE4RlB2c0UwMTc2MmVtcnFoVjVTU1RC?=
 =?utf-8?B?a0FyeSs0RStqV0FRc3djS2U4N2dZbWtQaWxZZDRrLzdqdHh1ZCttRHIxQWhP?=
 =?utf-8?B?Z1dyWmZIVS9jV3JwYThWdDREaTdnTkhoREZBTC9ncEhDZWhSSENFdGJqV2VD?=
 =?utf-8?B?SzZFVjVjcW5wWmdaei9BUUdvMGpGN1VSbHNyZEZLRnFnKzJYcTl3RnpZTXJt?=
 =?utf-8?B?NFJwT2lUS0JjM09UWDR1a3lYMnRkM3hmUmhoRmFxTGZTSzZPSE5TLzNkcnRO?=
 =?utf-8?B?Mlh0clQrRGVHcXk0TEYyUytRRTlLaGRZdTlmNDRQL05WbzduUXJIRVZBZzRD?=
 =?utf-8?B?b1ZpcllCdUhDcU82TFZBMnRKdHNCc3RQQSs5QmJxT09OQjFpRVN0Ny83VjZk?=
 =?utf-8?B?TDg4aE5GRVdTay9aWSt3Z2pKN3RlVS92VmxLMk9yS3U4RjRkZERyYi9BcmJr?=
 =?utf-8?B?cGp1NXQ0ZDEzRlMvSHFxRWFFK0lFaStPV3oyM253T2hvVjg1bXp1a2wyZ3N6?=
 =?utf-8?B?S20zUmFndTNwMGtJcXVueG91VUE5VXVYK3FNRkhwUFd2Tk9mc2NKdzVkeFdH?=
 =?utf-8?B?Skh3cDlCeVFKWkhkU3d0K3VSc05OY0JNTG1lQWRhZytaVzVHWlNwc1Z5cm90?=
 =?utf-8?B?S2x5MGJ3WnZ0QmNLQ2NxRW05MFA2VzBHeXhtRnZMcCtnTTZpb2g4a0tkTnIv?=
 =?utf-8?B?TVlDNGdEdkhNSm4xdEkvSXFlRkNCbGQwdG94TmxTeGxzQmJjU0QrSXU4Q2Uw?=
 =?utf-8?B?dEFVZzVsRGJucERaY3l4NWhraXJJa1RjR3ZLRG43eEtnZTE2MWZJYWFRcGhK?=
 =?utf-8?B?ZFhteGs4bm9zc0pxRmZaaXBDb2htSWxyYXBjRE9EejdYNXhITmx6a3hGWWVP?=
 =?utf-8?B?RUNlMGEzRUpUTVNLVnFoaVpJamx0M0J5RXF3SkgwbWJPL1V1V1Y5emhUbXJY?=
 =?utf-8?B?M3F2YkF3dVN1a2xwRXMyb09ETDNzOW1uQ3hwNzZ6dEV5RUMrYmdBOWhmNHlw?=
 =?utf-8?B?V2pnVVVKRW9mOS9JR1dZUXhNcENpaitWVUVIZDdUenJEMG8zT0ZnNFgrNDFX?=
 =?utf-8?B?N0JuZGhPQWNid2FpUitqSW9WbWI1Zm53aWhtMC94VG9Ua2JmSEpOQzBHSzhw?=
 =?utf-8?B?cjFZaWxTeWwxUDFOejhUdko3U3c4bTBPL3NaYkp1ZXBYcGNKSFNJQkRQZWFt?=
 =?utf-8?B?OUtHK1J4cmhMa3RmK0RWVUZNcnVUcFBJZ1RZY0hBL1NJMmdUY3RXK21KTnJT?=
 =?utf-8?B?YnlHS21vVVlyczA1S3h1S2QwYVVwSUp4aVZ4UHlEY283M1JMV21zZG1pQnh0?=
 =?utf-8?B?Y3lpZ1NNNmZYK3lKUjVESTgyZnZ0YWVYZndRU3lSUnNBOURpWGRCVUpvbEly?=
 =?utf-8?B?T2xZSDVqOUd2Ky9PaU1WRVQ2cng4RmZUTnVNMjBlb2JtaVBEWnRBMEVFTWlD?=
 =?utf-8?B?d0M4SVlULzBpT0p4V1luT1FOTHlsdDl2OWQvSnpZTDRva2RySTBqRTllVVBS?=
 =?utf-8?B?MU9LSXBBUTl4YkhKWFplY0lWb0JZZ3d4ZFJhOGp6OGZ1NlJRNEdBa1E5aGkz?=
 =?utf-8?B?R0RScmErQkZ1MVQwTHYvemNYZ3RJSW9zRFg0emowVkJWVUtSakV4bkJ4WUFN?=
 =?utf-8?B?MDZxWmNaeG9Jb0ZTWU9oeVVRWjZxWURpVDYwYTU2MlZnV2xXbmE0c0Y1VnVL?=
 =?utf-8?B?b21VNWhOWHp6SWM3ZGNlcnMvZEMrdXBVZ1ZlWm9nZ2YrVFpkWmxTWUg3N2N1?=
 =?utf-8?B?WnZoNlltYWl2K0RpRFdNK3pzd3VNb2FzRlA3SGU0aEJjaGU2V2cvU1lqbkRH?=
 =?utf-8?B?ZVJ0bFhRT2V5TTNGUFNZazMxMG0xV3BvUVdkWFNIa2FKZ1RkemJjNGVYdGE4?=
 =?utf-8?Q?lEmB24Tp6UmUOTuahxnT7J5ZXhQIqZhDsIUnv?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c87db0-309d-4bb9-3aa0-08de6f0bd6fe
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:36:17.6078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNdqfie5wucxi4OhbXLMcM8WSg1pLMeGPtHJFFClBZLs62PkDHZFWleF9wJ+x4H8hygU2lekOjkRsYSWLaurFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5598

On Wed, Feb 18, 2026 at 09:52:08PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Feb 18, 2026 at 09:45:22PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Dec 02, 2025 at 04:23:41PM +0900, Koichiro Den wrote:
> > > The vNTB endpoint function (pci-epf-vntb) can be configured and reconfigured
> > > through configfs (link/unlink functions, start/stop the controller, update
> > > parameters). In practice, several pitfalls present: double-unmapping when two
> > > windows share a BAR, wrong parameter order in .drop_link leading to wrong
> > > object lookups, duplicate EPC teardown that leads to oopses, a work item
> > > running after resources were torn down, and inability to re-link/restart
> > > fundamentally because ntb_dev was embedded and the vPCI bus teardown was
> > > incomplete.
> > > 
> > > This series addresses those issues and hardens resource management across NTB
> > > EPF and PCI EP core:
> > > 
> > > - Avoid double iounmap when PEER_SPAD and CONFIG share the same BAR.
> > > - Fix configfs .drop_link parameter order so the correct groups are used during
> > >   unlink.
> > > - Remove duplicate EPC resource teardown in both pci-epf-vntb and pci-epf-ntb,
> > >   avoiding crashes on .allow_link failures and during .drop_link.
> > > - Stop the delayed cmd_handler work before clearing BARs/doorbells.
> > > - Manage ntb_dev as a devm-managed allocation and implement .remove() in the
> > >   vNTB PCI driver. Switch to pci_scan_root_bus().
> > > 
> > > With these changes, the controller can now be stopped, a function unlinked,
> > > configfs settings updated, and the controller re-linked and restarted
> > > without rebooting the endpoint, as long as the underlying pci_epc_ops
> > > .stop() is non-destructive and .start() restores normal operation.
> > > 
> > > Patches 1-5 carry Fixes tags and are candidates for stable.
> > > Patch 6 is a preparatory one for Patch 7.
> > > Patch 7 is a behavioral improvement that completes lifetime management for
> > > relink/restart scenarios.
> > > 
> > 
> > Are there any dependencies between pci-epf-vntb and ntb-epf drivers? If they are
> > not dependent, you should always post them separately.

I'll make sure to be more careful.

> > For this series, I can
> > merge the endpoint patches (except patch 4 which got merged in other form).
> > 
> 
> Sry, patch 2.

There are no dependencies between Patch 1 and Patch 3-7.

One minor note: I just realized that the Patch 5 subject is inconsistent.

  NTB: epf: vntb: Stop cmd_handler work in epf_ntb_epc_cleanup

should have been

  PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in epf_ntb_epc_cleanup

If possible, could you please adjust the subject when applying?

Best regards,
Koichiro

> 
> - Mani
> 
> > - Mani
> > 
> > > 
> > > v3->v4 changes:
> > >   - Added Reviewed-by tag for [PATCH v3 6/6].
> > >   - Corrected patch split by moving the blank-line cleanup,
> > >     based on the feedback from Frank.
> > >   (No code changes overall.)
> > > v2->v3 changes:
> > >   - Added Reviewed-by tag for [PATCH v2 4/6].
> > >   - Split [PATCH v2 6/6] into two, based on the feedback from Frank.
> > >   (No code changes overall.)
> > > v1->v2 changes:
> > >   - Incorporated feedback from Frank.
> > >   - Added Reviewed-by tags (except for patches #4 and #6).
> > >   - Fixed a typo in patch #5 title.
> > >   (No code changes overall.)
> > > 
> > > v3: https://lore.kernel.org/all/20251130151100.2591822-1-den@valinux.co.jp/
> > > v2: https://lore.kernel.org/all/20251029080321.807943-1-den@valinux.co.jp/
> > > v1: https://lore.kernel.org/all/20251023071757.901181-1-den@valinux.co.jp/
> > > 
> > > 
> > > Koichiro Den (7):
> > >   NTB: epf: Avoid pci_iounmap() with offset when PEER_SPAD and CONFIG
> > >     share BAR
> > >   PCI: endpoint: Fix parameter order for .drop_link
> > >   PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown
> > >   PCI: endpoint: pci-epf-ntb: Remove duplicate resource teardown
> > >   NTB: epf: vntb: Stop cmd_handler work in epf_ntb_epc_cleanup
> > >   PCI: endpoint: pci-epf-vntb: Switch vpci_scan_bus() to use
> > >     pci_scan_root_bus()
> > >   PCI: endpoint: pci-epf-vntb: manage ntb_dev lifetime and fix vpci bus
> > >     teardown
> > > 
> > >  drivers/ntb/hw/epf/ntb_hw_epf.c               |  3 +-
> > >  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 56 +-----------
> > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 86 ++++++++++++-------
> > >  drivers/pci/endpoint/pci-ep-cfs.c             |  8 +-
> > >  4 files changed, 62 insertions(+), 91 deletions(-)
> > > 
> > > -- 
> > > 2.48.1
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
