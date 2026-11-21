Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795266755;
	b=Nsif2PtlS19m0ZGXsgRN4EitmwL22km3cFLRHUZ8QV2Ny4qutt/+3A4EfGK6At7aHlGJ
	 RCtlYPegGNCdc1gmp+0WvbKYdKTMcevJsyKdOyZcksLS1WgOGpmY0cWVaKpAnzer33BoX
	 uQovSr8DkzrTloYbVgafEo4jfN+OBug24BefSIo7F1TIKual4OSVprMYrx/n2t0wx0HJv
	 CfeNAVs5Mh64yEblei7upWzh7BkhyBYZHJNn+fGoFxmXTMvXbZx/2mU/sWfPIJwKG5Lka
	 odqrNJsxfH+Eg1HR9EiOQwiZeAC3ESGEht/xwWlyzQkrVW927EAlZ0CRmXw6wBSDKoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795266755;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=yQnyivCG2C0casbEGhbKxTfLOU9Vet5YZCNFEoJvdPI=;
	b=5DBAEpRLwMS7tRql03nzJLNStkxTfMIAhElKsFrhxrBRuOqtjqw1owVEpHxAR5pAP222
	 YcPBRVBTDL1JVw6PmuW4FGdCXbE3CYJKe6TCmwp/5UvnYqUz7L8vZ3Cg9ZRrWtKzrIu4y
	 33t5jQoDTs3jjRw3tlf4aJhr64CdfUngk2GmqS0i+lStR1hlsYrX5M8LMNafEHAgSOfnh
	 djXJTI115DHEPl8vub/o5RO052A5sIVjCog9ZJlNQM1BrE5aoXmP/RzIorb+9jE9y5/IR
	 8mAQQXRZJ5IqQSqDFldwE6yS0wH09F7ql/0Xl2tuSTvlgc+hICVCdcTQV5VX2FMSEsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=iEa1Gy3m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.34
Received: from WA1P291CU003.outbound.protection.outlook.com (mail-polandcentralazolkn19011034.outbound.protection.outlook.com [52.103.53.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511C3606A333;
	Sat, 21 Nov 2026 13:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 511C3606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=iEa1Gy3m
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngoXLotStXy+2/Tmkub3HJgiqhCMO29zQ2FoM8lmsRo949Rgpin8us5a+9Muy4lCWwJYGRaaX1npYm5o5HhqIGF+QikYGPHSKJ58akbps6zLyuOKPslz0/VdNH5N8deQfDEPJrmIYTUzZ1XeMYi3f7Frua+GAuFVqspkte3WeJp1n92n/qIb+a7a8296ajSLF5vExl3IurEJX5LqsHlRPBYfqgLwwgCaQwjNo5UWl+J5Yd0q/NElN4xJp7jg85nsHXB1NGPxR7JGPwWZwAOVj0rf5EIWmaknSGVUpXwCVr7sBkVgDDgTCk0DTr3DAdlnAzWysuWjFcsEQnMV5w1XXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQnyivCG2C0casbEGhbKxTfLOU9Vet5YZCNFEoJvdPI=;
 b=BSLyatkKd5NF85DAmcO3jb8GidJaFlGt9MddVSlkPzR8QNecQHDt+ZM8W5CaLdpltFYX2urgr24RPpNVGtEINKjqiM0vxPyzeuFE5FAN/5bjxDrm3qDfqPRtnKkTK0fbS2Kfs5ZXAHN0DM8lVsjNMvJUut2Hx10fGsTA51Rov0Ff5eUdVbiRuaFHwtMPFAbUd+9j6zWE6yiJp866m6btmfGLCexe4oQef9Yqqcx5crhh39oZzGE2yLr2jmCE0cegDcSzoUF+HLr7TwKjR8t0VrM+lZmmToDTzTr8NgDu/in7bRZQPYtY6zZOdNyOKowfRLI9N4S+R04M6bOvWGaaQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQnyivCG2C0casbEGhbKxTfLOU9Vet5YZCNFEoJvdPI=;
 b=iEa1Gy3mt4vu3thFloDqoALT9WKzYZvccFNJx2IxbThFpt+IO1EwLM4y8oJ0w1Xvtviugtf/cja9dEUD5T3Vi1j7N+tLys5QCxawqaMr4DvyNMxxJjRMvlKoczSkzL4INE5gfeiwblAIAaSV0Tt1oK3kYI/6WolSR/cXeqJUlBjUTX+KQPJRQpjw0Yhc/L7mlAADGqgyaoGFNXRUsL/B+cxIiXA5KQ8tHg6fgqXFb47iOmNokWd86JFxgQpJNbj68BHtzrk4cZdcuxeX1L1TgrY0lOP9eIPVaIEEjDp0TybMEmPdTwEu3jYV5Foyry7XT0UMz1tbf1kotDdErd4CzA==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA0P291MB0097.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.13; Sat, 21 Nov 2026 13:12:34 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 13:12:34 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "H . Peter Anvin" <hpa@zytor.com>, "andriy.shevchenko@intel.com"
	<andriy.shevchenko@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?=
	<habilerenturker@hotmail.com>
Subject: [PATCH v4 2/4] PCI: Convert pci.c to pci_power_t helpers
Thread-Topic: [PATCH v4 2/4] PCI: Convert pci.c to pci_power_t helpers
Thread-Index: AQHdebn4iVVtF4gaikq15w8H8uYCew==
Date: Sat, 21 Nov 2026 13:12:33 +0000
Message-ID: <20261121130936.53191-4-habilerenturker@hotmail.com>
References: <20261121130936.53191-2-habilerenturker@hotmail.com>
In-Reply-To: <20261121130936.53191-2-habilerenturker@hotmail.com>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA0P291MB0097:EE_
x-ms-office365-filtering-correlation-id: 7ea4789a-71be-4367-7f33-08df47d11b36
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|41001999006|15080799012|8062599012|8060799015|19110799012|31061999003|2604032031799003|55001999006|24021099003|16051099003|25010399006|51005399006|102099032|440099028|3412199025|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?T1lhb1VGMzFBVWtCN2xDd0RCUDRNRkYxU2NUUHZyc2ZCdTVEUzVGZ2UrekJT?=
 =?utf-8?B?aDdYOXlnNUZxK0ZFOTEvS2VUQ2c3QmJzd3ZaejhQQXArZHA4QVh0L0xQck5y?=
 =?utf-8?B?eEhtblFFRXhzckhLU1ZZYlM3ZW1PUzVhbncyZnNnUWR6UFZSRzVrcnZJdGpq?=
 =?utf-8?B?VjI1bkE3bEVzWUc4MDhNSzVPQmFiUnFwcWp5NC96VjkxdnAvRjBWdnhJd0ZB?=
 =?utf-8?B?ZDdBL3BhL3RUK2h6Sk5rNGliZFBtUDhsdHhKT0ZHblpzSmZKR281cUZsNGF2?=
 =?utf-8?B?YWxFQU9Rbk8xMWNGZUhMYXN4UmE0ajVqS2hGbUJwRjVLRkNBbGdVMWhvd2Zp?=
 =?utf-8?B?QlUzMjB3eGhONkh3d1pIb2FoS2Zoc2JjVmZRdCtMNlNFR1dLWUhvODF6T1di?=
 =?utf-8?B?SDA2WVM4WEtXUXlLRHBjcXJ3Zk93Zm44ZmhqL2llYVFRamJ5dXVlR1lmcFZY?=
 =?utf-8?B?amd5eHpHWU9Tekh1bFhseFdkV3NIaXNrTFJ1bFR5aTh3UFJ1b0NDbUFSOTdI?=
 =?utf-8?B?R3dJd0pjSHRyRUtJbXBHRFlKKzc1UkRDQTEyMis0L2x6cHBaUVRCR2laQ2th?=
 =?utf-8?B?d2RSaVVxSTFqdUYzVzIwd2tFQWVmL1ViVjlPVjZNZWJLRjlSQWYrbzZMK1N5?=
 =?utf-8?B?Mng1ME9SMCswMEhmOWwvN2NYOGRIa2lpc0dzbzBxM1BYWm5sS0hIcEpLU05y?=
 =?utf-8?B?TUUzQTFCa05rdmV2ODZ4Sy8wWWdRSVpkcEduMGYwTlNXYjAxRnFqZlI2OENU?=
 =?utf-8?B?Y0liaG1JNWQvQWF1bnd3VUJCU0VLYXRENXdoV0JYM2pRV2RXSVkyN1RUM2J5?=
 =?utf-8?B?N1czclZZQ001bnFpdlJBTWRWdE5Kd01LOVFMUWdsVHJYN1Y2VndCRFJhd1l5?=
 =?utf-8?B?VEZxZUxMNUMrQXliN3VBMlgwOC9jYmNFME0zR1FPUzJ2dTlCQm40aEtwQkVk?=
 =?utf-8?B?VTRYV0tndFk4eURubWp5YzFxcHcwZng4NE1WRFpQY1YreXhLNWJIbU1KbzM1?=
 =?utf-8?B?SjNTamlaUVJvRjAyMkJ0eW1reFJQc0syNngwV2RwSHVGR2tPU0Q3Zy8wV0Zw?=
 =?utf-8?B?TjRzdldTc3lzdlJCSEhiRGwvR2piaWlMLzNuVWo2blR4OXRrSDQ5V3NXODZG?=
 =?utf-8?B?V2k5cXNwQlhrSGRBWVhNSFJUZDdZTjNjRTRhVm0vY00rcWthb1lzU2tVZVBE?=
 =?utf-8?B?TFZxcnZWbHBGQlV4WUkvVkJDbThSODJ0SDE3bzdUWURtOVVWa2ZTc3IxQ0VF?=
 =?utf-8?B?eXRSM3M2K1dwZndvMjJMelUvMkN0bnlZUXd2QzA2R0hVU25BeTMyY2Y5L1Rl?=
 =?utf-8?B?SCsxNFFLVFFJVHc1ZFlsaENONXEvbmVNRDFNWVlPSXZhUTBDZ1VKcVFZQWY4?=
 =?utf-8?B?UUpRdGhlM2xWVGhUMWg0Y2RxNmJmd1pKeGxQcks2TFJKRkdIR3R6cUlRSWhl?=
 =?utf-8?B?V1N1ODFsUVd3angvd0VnNjVUa2ZzbndOSVpvNnBlM0YrQ1puS0o1UnJmWHJm?=
 =?utf-8?B?Y0VndFVpcGg3WHgzT1ZBcUdqUVpTMmZwNTdDUEl6ZUdQSTJtaVN4L3grTFF3?=
 =?utf-8?B?UVNMQT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VUdrVTgvMFlsZCttcTJNV3N3OFVpcDlmV2RpSW9VNDBBa1pVMDRrQjZMSFBy?=
 =?utf-8?B?UFMyZi9PNUl1QlAydzd4YmVGMk1rQnZSQlNIYit0ZDhKUHdvRm1ZSjg5MlVO?=
 =?utf-8?B?b0piTzY1VUJXR2J6QWRkSnMzRkpwYkNmS2lEcno3aTNkVlVBRHJSYUhFVEhu?=
 =?utf-8?B?dkNmcGhOUXdwRDdkRDlpbzVsaDQ4UC9nWnF1N3Z0c1pZMVh0K3V5eWNDUnFq?=
 =?utf-8?B?ci9iYUpCME1RRzhHTTV2RUQvbGh1UjkwM3VqQnZ6dXBtNGNJVFdTZFFCY0li?=
 =?utf-8?B?NjFiNVp3NnJQZGxLeW9ud3ZRV0wyK0ZxQ3Bld0V6eDZhTTN3ejFpdlIzcnJG?=
 =?utf-8?B?MHRpd00wVkdZSVYxVmJYb2hseU4xTG9KWjArR3k3bHF4RXlLeXVCbWFtZkli?=
 =?utf-8?B?SWxDNHBDSldKWkFIbTZqRmR4SVVaeUorL0ltRzBrQzVpZ1U4dGxWcnplM1dX?=
 =?utf-8?B?QXVMZ25RZDFVV04wS1NOMzNEVUlvV0RrRkdOWFM5Q0dhdG9DQkhkT2NtdEhM?=
 =?utf-8?B?NE8xdTg0dkwveGM1UTltbnpKeElIUHNtcmZ4YS9RbFd2cDI3Nmh1YlladXJZ?=
 =?utf-8?B?d21HaVdvaTNqQ2kzdVA5dEpzcmJ2Z0lpOGtiMzk0bVJxVEtPZW9XR2tPM0VY?=
 =?utf-8?B?WDJha1d3bGhDeHlBdkx2Wm8yME1XNGxhZitGS0orMDA5aDVGQXUxeENiRXNp?=
 =?utf-8?B?bXJmVFo4QnZOdm9QTnBONUJoWDJkQ1lYQWY5cEZHUXVVTEpBTDErUUEwQW9L?=
 =?utf-8?B?Q2F0Q1Z2MDZrVzFHMG4yWnVKMFZseE1nL1pHc3EwQWY0eFgxQ2FPZVFteHBo?=
 =?utf-8?B?TGN5WkROdlQ5OHlyWFVZZzd2dmFSK1EzMEo5R1VMODNCUlFKaXdyQkFVVHIx?=
 =?utf-8?B?cXJNekd4MkNndDF4eC9HQVNzSm10OWxLZStvQUdDVmpOWSt2eTlTYXorWVVT?=
 =?utf-8?B?ZVcxdUZtUDFrN1Zva0pqTzlIdUJ3eHpGVXhYR0NoUnZVWENadzNZMzA5V1BY?=
 =?utf-8?B?aUVVQzd3Zlp0K2w5Wm1maERhMGRPb29zeU5ucDNpdEducHI2MXJwZFU3OWZR?=
 =?utf-8?B?SlUzcDNnWml5d0llU0VjaUxSN3FjdlNSVklLaGJqN3JYaFNXVjBadmpsblJZ?=
 =?utf-8?B?S0xJOFFBN05qNnlqY1p4a1Y0VUJrd3o5UURVWE1QVFNqWExEMTNVQmpiYmtz?=
 =?utf-8?B?UUdhTnIwN3NyOHd2bmViMXFOUnI3VkNKdlRSZWhqUzBycDhZTGNxc0RKcWN5?=
 =?utf-8?B?YWwvb1dZNGNGS285SjZheE1lWWRtL293cDJmTmx5K2RWN1AzL2ZDT0lpcjhk?=
 =?utf-8?B?WmJVTXUvNDZsaTE3a0FIVE1KWWZ6cnhPcEpwQkI3RXRoTWFJdDJOYkQ2ZzEz?=
 =?utf-8?B?Z3ExS2NHUlRnSjFaR05ORWYzOTI3bnRoLzQxeTZGVmlhTWo0YlNreWhlMDll?=
 =?utf-8?B?Z0MzSytaMDlIMm1MUjdXOGptV1hKZjl3cHJHMUlKSFBuam9jQXMydVR2bW9z?=
 =?utf-8?B?eFd0VWdrUjdOUU5rUUczL3BYeWV5R3lDdExKVXZlb1c3V2lTTFp5Rm9lTHEy?=
 =?utf-8?B?R3N6d0ZsckQ3Mk5NT3lmT3V3dVNHcjhhZVhuRm95UVA3TWkrL2swWUhCWTll?=
 =?utf-8?B?T1ZiNFA1eUJqRkFwcHVrZ1hzTkdmRzd6dVVaQ21FbkVHVFpBcEZ5SDJKeFlF?=
 =?utf-8?B?V1pINkp2YkZYbUc1YmRoSzhuVTdtNWo0bmZtTk9HSlN0RGxWRTNReVo2WmV5?=
 =?utf-8?B?N01yOTFKdGd3a2ZtVTE3cU42Q1JLQWQ3NHNPSnB6UUFLSlNtWlZjRnVaR1Va?=
 =?utf-8?B?T05jNFRQY2UyRGlWMmpJNmVBRndoeHNhRmNpSUI1MUdyMEJ3YkVkQUkrRU9T?=
 =?utf-8?Q?SeSCO8V+N3DhO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6AAC6B67E89B44C8ED5A8A37D97E62B@POLP291.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-2112e.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea4789a-71be-4367-7f33-08df47d11b36
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2026 13:12:33.9153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA0P291MB0097

Q29udmVydCBQQ0kgY29yZSBjb2RlIHRvIHVzZSB0aGUgcGNpX3Bvd2VyX3QgaGVscGVyIGZ1bmN0
aW9ucwp3aGVuIGFjY2Vzc2luZyB0aGUgUG93ZXIgTWFuYWdlbWVudCBDb250cm9sL1N0YXR1cyBy
ZWdpc3Rlci4KCktlZXAgY29tcGFyaXNvbnMgYmV0d2VlbiB2YWx1ZXMgYWxyZWFkeSB0eXBlZCBh
cyBwY2lfcG93ZXJfdAphcyBkaXJlY3QgdHlwZWQgY29tcGFyaXNvbnMuCgpSZXNvbHZlZCBTcGFy
c2Ugd2FybmluZ3M6CgotIGRyaXZlcnMvcGNpL3BjaS5jIDogd2FybmluZzogaW5jb3JyZWN0IHR5
cGUgaW4gYXNzaWdubWVudAogIChkaWZmZXJlbnQgYmFzZSB0eXBlcykgKDQgd2FybmluZ3MpCgot
IGRyaXZlcnMvcGNpL3BjaS5jIDogd2FybmluZzogaW52YWxpZCBhc3NpZ25tZW50OiB8PSAoMyB3
YXJuaW5ncykKClNpZ25lZC1vZmYtYnk6IEhhYmlsIEVyZW4gVMO8cmtlciA8aGFiaWxlcmVudHVy
a2VyQGhvdG1haWwuY29tPgotLS0KIGRyaXZlcnMvcGNpL3BjaS5jIHwgMjggKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDE2IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaS5jIGIvZHJpdmVycy9wY2kv
cGNpLmMKaW5kZXggN2M2ZjJhYmE4MTQ0Li5kMzljODk3Zjc3MzUgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvcGNpL3BjaS5jCisrKyBiL2RyaXZlcnMvcGNpL3BjaS5jCkBAIC0xMTcxLDcgKzExNzEsNyBA
QCB2b2lkIHBjaV91cGRhdGVfY3VycmVudF9zdGF0ZShzdHJ1Y3QgcGNpX2RldiAqZGV2LCBwY2lf
cG93ZXJfdCBzdGF0ZSkKIAkJCWRldi0+Y3VycmVudF9zdGF0ZSA9IFBDSV9EM2NvbGQ7CiAJCQly
ZXR1cm47CiAJCX0KLQkJZGV2LT5jdXJyZW50X3N0YXRlID0gcG1jc3IgJiBQQ0lfUE1fQ1RSTF9T
VEFURV9NQVNLOworCQlkZXYtPmN1cnJlbnRfc3RhdGUgPSBwY2lfcG93ZXJfdF9nZXQocG1jc3Ip
OwogCX0gZWxzZSB7CiAJCWRldi0+Y3VycmVudF9zdGF0ZSA9IHN0YXRlOwogCX0KQEAgLTEzNjgs
MTIgKzEzNjgsMTEgQEAgaW50IHBjaV9wb3dlcl91cChzdHJ1Y3QgcGNpX2RldiAqZGV2KQogCQly
ZXR1cm4gLUVJTzsKIAl9CiAKLQlzdGF0ZSA9IHBtY3NyICYgUENJX1BNX0NUUkxfU1RBVEVfTUFT
SzsKKwluZWVkX3Jlc3RvcmUgPSAhKHBtY3NyICYgUENJX1BNX0NUUkxfTk9fU09GVF9SRVNFVCkg
JiYKKwkJCShwY2lfcG93ZXJfdF9lcShwY2lfcG93ZXJfdF9nZXQocG1jc3IpLCBQQ0lfRDNob3Qp
IHx8CisJCQlkZXYtPmN1cnJlbnRfc3RhdGUgPj0gUENJX0QzaG90KTsKIAotCW5lZWRfcmVzdG9y
ZSA9IChzdGF0ZSA9PSBQQ0lfRDNob3QgfHwgZGV2LT5jdXJyZW50X3N0YXRlID49IFBDSV9EM2hv
dCkgJiYKLQkJCSEocG1jc3IgJiBQQ0lfUE1fQ1RSTF9OT19TT0ZUX1JFU0VUKTsKLQotCWlmIChz
dGF0ZSA9PSBQQ0lfRDApCisJaWYgKHBjaV9wb3dlcl90X2VxKHBjaV9wb3dlcl90X2dldChwbWNz
ciksIFBDSV9EMCkpCiAJCWdvdG8gZW5kOwogCiAJLyoKQEAgLTEzODMsNyArMTM4Miw3IEBAIGlu
dCBwY2lfcG93ZXJfdXAoc3RydWN0IHBjaV9kZXYgKmRldikKIAlwY2lfd3JpdGVfY29uZmlnX3dv
cmQoZGV2LCBkZXYtPnBtX2NhcCArIFBDSV9QTV9DVFJMLCAwKTsKIAogCS8qIE1hbmRhdG9yeSB0
cmFuc2l0aW9uIGRlbGF5czsgc2VlIFBDSSBQTSAxLjIuICovCi0JaWYgKHN0YXRlID09IFBDSV9E
M2hvdCkgeworCWlmIChwY2lfcG93ZXJfdF9lcShwY2lfcG93ZXJfdF9nZXQocG1jc3IpLCBQQ0lf
RDNob3QpKSB7CiAJCXBjaV9kZXZfZDNfc2xlZXAoZGV2KTsKIAkJaWYgKCEocG1jc3IgJiBQQ0lf
UE1fQ1RSTF9OT19TT0ZUX1JFU0VUKSkgewogCQkJcmV0ID0gcGNpX2Rldl93YWl0KGRldiwgInBv
d2VyIHVwIEQzaG90LT5EMHVuaW5pdGlhbGl6ZWQiLApAQCAtMTM5Myw3ICsxMzkyLDcgQEAgaW50
IHBjaV9wb3dlcl91cChzdHJ1Y3QgcGNpX2RldiAqZGV2KQogCQkJCXJldHVybiAtRUlPOwogCQkJ
fQogCQl9Ci0JfSBlbHNlIGlmIChzdGF0ZSA9PSBQQ0lfRDIpIHsKKwl9IGVsc2UgaWYgKHBjaV9w
b3dlcl90X2VxKHBjaV9wb3dlcl90X2dldChwbWNzciksIFBDSV9EMikpIHsKIAkJdWRlbGF5KFBD
SV9QTV9EMl9ERUxBWSk7CiAJfQogCkBAIC0xNDMyLDcgKzE0MzEsNyBAQCBzdGF0aWMgaW50IHBj
aV9zZXRfZnVsbF9wb3dlcl9zdGF0ZShzdHJ1Y3QgcGNpX2RldiAqZGV2LCBib29sIGxvY2tlZCkK
IAl9CiAKIAlwY2lfcmVhZF9jb25maWdfd29yZChkZXYsIGRldi0+cG1fY2FwICsgUENJX1BNX0NU
UkwsICZwbWNzcik7Ci0JZGV2LT5jdXJyZW50X3N0YXRlID0gcG1jc3IgJiBQQ0lfUE1fQ1RSTF9T
VEFURV9NQVNLOworCWRldi0+Y3VycmVudF9zdGF0ZSA9IHBjaV9wb3dlcl90X2dldChwbWNzcik7
CiAJaWYgKGRldi0+Y3VycmVudF9zdGF0ZSAhPSBQQ0lfRDApIHsKIAkJcGNpX2luZm9fcmF0ZWxp
bWl0ZWQoZGV2LCAiUmVmdXNlZCB0byBjaGFuZ2UgcG93ZXIgc3RhdGUgZnJvbSAlcyB0byBEMFxu
IiwKIAkJCQkgICAgIHBjaV9wb3dlcl9uYW1lKGRldi0+Y3VycmVudF9zdGF0ZSkpOwpAQCAtMTU0
Niw4ICsxNTQ1LDcgQEAgc3RhdGljIGludCBwY2lfc2V0X2xvd19wb3dlcl9zdGF0ZShzdHJ1Y3Qg
cGNpX2RldiAqZGV2LCBwY2lfcG93ZXJfdCBzdGF0ZSwgYm9vbAogCQlyZXR1cm4gLUVJTzsKIAl9
CiAKLQlwbWNzciAmPSB+UENJX1BNX0NUUkxfU1RBVEVfTUFTSzsKLQlwbWNzciB8PSBzdGF0ZTsK
KwlwY2lfcG93ZXJfdF9zZXQoJnBtY3NyLCBzdGF0ZSk7CiAKIAkvKiBFbnRlciBzcGVjaWZpZWQg
c3RhdGUgKi8KIAlwY2lfd3JpdGVfY29uZmlnX3dvcmQoZGV2LCBkZXYtPnBtX2NhcCArIFBDSV9Q
TV9DVFJMLCBwbWNzcik7CkBAIC0xNTU5LDcgKzE1NTcsNyBAQCBzdGF0aWMgaW50IHBjaV9zZXRf
bG93X3Bvd2VyX3N0YXRlKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHBjaV9wb3dlcl90IHN0YXRlLCBi
b29sCiAJCXVkZWxheShQQ0lfUE1fRDJfREVMQVkpOwogCiAJcGNpX3JlYWRfY29uZmlnX3dvcmQo
ZGV2LCBkZXYtPnBtX2NhcCArIFBDSV9QTV9DVFJMLCAmcG1jc3IpOwotCWRldi0+Y3VycmVudF9z
dGF0ZSA9IHBtY3NyICYgUENJX1BNX0NUUkxfU1RBVEVfTUFTSzsKKwlkZXYtPmN1cnJlbnRfc3Rh
dGUgPSBwY2lfcG93ZXJfdF9nZXQocG1jc3IpOwogCWlmIChkZXYtPmN1cnJlbnRfc3RhdGUgIT0g
c3RhdGUpCiAJCXBjaV9pbmZvX3JhdGVsaW1pdGVkKGRldiwgIlJlZnVzZWQgdG8gY2hhbmdlIHBv
d2VyIHN0YXRlIGZyb20gJXMgdG8gJXNcbiIsCiAJCQkJICAgICBwY2lfcG93ZXJfbmFtZShkZXYt
PmN1cnJlbnRfc3RhdGUpLApAQCAtNDU5MCwxMyArNDU4OCwxMSBAQCBzdGF0aWMgaW50IHBjaV9w
bV9yZXNldChzdHJ1Y3QgcGNpX2RldiAqZGV2LCBib29sIHByb2JlKQogCQlyZXR1cm4gcmV0Owog
CX0KIAotCWNzciAmPSB+UENJX1BNX0NUUkxfU1RBVEVfTUFTSzsKLQljc3IgfD0gUENJX0QzaG90
OworCXBjaV9wb3dlcl90X3NldCgmY3NyLCBQQ0lfRDNob3QpOwogCXBjaV93cml0ZV9jb25maWdf
d29yZChkZXYsIGRldi0+cG1fY2FwICsgUENJX1BNX0NUUkwsIGNzcik7CiAJcGNpX2Rldl9kM19z
bGVlcChkZXYpOwogCi0JY3NyICY9IH5QQ0lfUE1fQ1RSTF9TVEFURV9NQVNLOwotCWNzciB8PSBQ
Q0lfRDA7CisJcGNpX3Bvd2VyX3Rfc2V0KCZjc3IsIFBDSV9EMCk7CiAJcGNpX3dyaXRlX2NvbmZp
Z193b3JkKGRldiwgZGV2LT5wbV9jYXAgKyBQQ0lfUE1fQ1RSTCwgY3NyKTsKIAlwY2lfZGV2X2Qz
X3NsZWVwKGRldik7CiAKLS0gCjIuNDcuMwoK
