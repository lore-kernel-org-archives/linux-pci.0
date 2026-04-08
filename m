Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011038.outbound.protection.outlook.com [52.103.68.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D543A1E67;
	Wed,  8 Apr 2026 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775636895; cv=fail; b=jMxQEg2jxk6DG9EXEJP7Q0836HHPw5pzm9M9HNm4qND4GS0L9gzpM5URl34+QSHEWFuYdjuPuHc+V5oyXi8e5jxrLXjlh+eiMKvkVICemTqW3cbjpbeM3sOCIrD7kK4jb82ApSo2eeHaMquX2jPHdJX1g/0z+TCIolVIBzB0o4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775636895; c=relaxed/simple;
	bh=GeJrhXkjIlN0JFX1FywL36h62DRdqrwJ9uY/bpvjaqI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FkezqHQ9wEafOg4vINZ/miCEKl3Vd+Vn1WVf4BGCS63Anc6tWdhpAkohbz5a03ZossvAjaKobZDZpObNbQ3+qUi+KuUF80vNdGMw2Oh0ONTb6uqyfnHK7IUiYFFxsitUUlAGvpwOvZpRJrv7rc0TYYRqhy6PSUNTUoo/SQbuN4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dT93MRC2; arc=fail smtp.client-ip=52.103.68.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dT93MRC2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgmMTnXrlVoNcYTx3H63tyN/Tx5OLD2eIsZ4lC+rupGZCSOKSg1U9IK5P1+VAsVVUSOyLxdg8Tr51rOZlkwpOXVaze+a+4n8ppIF6zq3PFeEqGhfawC2MAjtkItuZ+diUTpXS7o2jq3B9e/zyBE6MbEQCojyuSPWolbYvJfrmJ1h5o6DTvJwhywXUi9cxajeCbCyufscPbILfe+E1IYOyc3gOlVwuzq7II5jsoZnlRJ/26FT2aLOw4he07JNA2BcV1xL5oHnOHrw/NPq62T4pzDoa3GVzhgYEAarYedEfA9IR3MNMYklmWH6kTIoXG7m2ofePAJtYWiQeYnYRWotDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YLAAJIpT8ksWWj9Xlf2gNO2llAijF0UawSoIARw/xE=;
 b=n55zs8zp+jgtanjHTnpIOCLWjiaLTynrBKz2eM3A9oFHkagVLT+LAJwnb+Z2mijNhnd7Q3v4KGSPBOPeAX9oLcuuqprOnjWW79EN8YcQfGLItsdpggm9Q0su6wAD8ZB2SZa+6PbxQLN7uvk2lBDpFtlZcCS7TiS6cNIPssb9l0N0DBeEtC03kNw3g/1RjJ2lMGDnhwqg+yjkQ/NaM+RDARvzhBe240sVrl1p52NGcf079BbWB+2iSfgwUnhPdH+igS7WRre0EqVfRsOAuFg8yHSf1sK8AhA9RAzEskFewzHZYOhqQfaCq+Mxx0yVdoXBNq8RnFZVRyUBGBci9vFG0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YLAAJIpT8ksWWj9Xlf2gNO2llAijF0UawSoIARw/xE=;
 b=dT93MRC2x/4kAdChX+xCMHYqPVfNzc2xBlXfS6nTFUF/IaYkdMPORCnm7oiYup1X69NipMvR6H+nwOrQy6o/1K/5OSgbfXIJi/uNy4SRi/0GIE+TqGtuLJdnQbONYyYfvUJWoKdcXxMzVFOBgczn0LR6gW58vKiZ9Uo3b8ecQct/hvMK4meuvlyLcvhGSAhHFydiaMfiVumU9mLNkKqTVR/Ov83VmPPHgN8fZ0Ucc8v1jg78n2Dh0yF94QCZVMlUTzCE1u06Ty8yo/HcCFkJQmL/PFswl4RMVCS20NIuER+U2byTYqfMnFkRljfjgFb1R0Xh+93RFcAS0tg+Or06Ug==
Received: from MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1e9::18) by MA5PR01MB11775.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:183::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 08:28:06 +0000
Received: from MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8a6b:3853:1bc:67e4]) by MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8a6b:3853:1bc:67e4%6]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 08:28:06 +0000
Message-ID:
 <MA5PR01MB1250034FF14DFFDF5C04093FDFE5BA@MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 8 Apr 2026 16:28:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] PCI/sg2042: Avoid L0s and L1 on Sophgo 2042 PCIe
 Root Ports
To: Yao Zi <me@ziyao.cc>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Hans Zhang <18255117159@163.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Manikandan K Pillai <mpillai@cadence.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Inochi Amaoto <inochiama@gmail.com>, Han Gao <rabenda.cn@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260405154154.46829-1-me@ziyao.cc>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20260405154154.46829-1-me@ziyao.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1e9::18)
X-Microsoft-Original-Message-ID:
 <c04b5b1c-c081-4d6b-9762-dd7959a1a82c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA5PR01MB12500:EE_|MA5PR01MB11775:EE_
X-MS-Office365-Filtering-Correlation-Id: 636348b5-a5be-4cb0-a088-08de9548c236
X-MS-Exchange-SLBlob-MailProps:
	obhAqMD0nT97+9kgwgO/mqEGtcymhevmiK5E35L/XtAxKR2gH8XthjC0hG72NpMn8oAjsfz803BUb2UI9TqgnLEoiiuefq4djr55TDbi49QtyR8usRADgrj+tnz9ay5F8MN4GQNzeJtJCpSAStdw4FsXGuoCj4+ZUYfT4oQh0lVVY4vqcqVGU3wcjGplc2kFbDDxsp3uKZtORU/ZN724gjY5EZ5dKAid8Q+tgSlFXVEIWU6TAXcmlerHLYACnPVpeYuep9TZRbG8LHaggmcZouJncqSNbHFKjxkNho3TIFLKfStc3ZZRWZMF7fQ2+gfEACnfhmL3CT1rA6fhFYvQ8Y8q2AJeTtE9iHcqq1bg5Ecffy0+xepEMYUNCvIoLOxJn01qD9rYZhTYe24E7XQrZeqAX6ym84Cv0NmiVqQbwOT8V8tNPMO7ZiHMUKdch4aqdf+xK0sGUialmc22HynxKGk/AMEc8HP/FfXurMbnP/Yw2oQ/EFOvKVT/qumhu8KhY0HEFxQZOOz2p5dy7ViQrhHXgbi5Et6AG7p2joG4N3qD8UbAl2EteiLfeK4OXhOrK0kR7S7968Iv1Bk+zrl0B7IdGdJf+a5oFyAYfsVLwoRQqhGf7O9lIA42XHPY/GSk4FYNTXXV+Zc6FW6DLhIVvguE38OsgIqsaVUmW4QhAljEj6IuO9m26kO3NeBS5zkfYgDhIX1tLdS3t1iPFdvj19dL0iM8DC1yuxsj1k5sQ+0fGInzvym9nugHiJN2PbJU6Mzg4bm3ugJre1aHrKPefPRrvOBielFFUTSyso4mwLdGtG779BCgyZGYIfPRVknB
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|22091999003|461199028|15080799012|24121999003|51005399006|23021999003|8060799015|19110799012|25031999004|6090799003|5072599009|1474299035|1602099012|40105399003|26121999003|4302099013|3412199025|440099028|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1lHU0ZRVmx0d0pWNWZLWkVDd3VRR0ErVW16L042dzNBWHNYK2FUczRaYWtR?=
 =?utf-8?B?M2s1WVloQys4emg0d2hSaExqaDR3bDNZUWlUYi9jeWNTNGJxdU1FSzVuQ2ht?=
 =?utf-8?B?dlc2RlJqdy9ja1FsZExSa2Mzdnhna0VEVVFYS3ZNWnVsZFdzYWozTUVaZWZj?=
 =?utf-8?B?RUQ5T2hVOGZjRWJpN2ZDbmMybDV1Z0NMZEl5WWUxb0ZKc2JNd2x6N0JpRFoy?=
 =?utf-8?B?MjM3UHp2bjV6Wk1WS2FHeXg3R1JnRXhLRnNtUy9wRGlMenRxb1NRMlZNbUl5?=
 =?utf-8?B?SmxTREJSK1AwNHU2UHJLa0lRWXUra1NtSmRwYVNiYnpoSzdjTGc1UGtmL3Jx?=
 =?utf-8?B?Nk9XU2FZTGxKYlJURCtXZHlGVFh2c1p1U0tpRnZvdEZhV2drSCsyR0thZ3Bq?=
 =?utf-8?B?bW5UUXZBVU9BdmhGbXJoUDBTL2lhSkpvRTZCazBJZzhvOWt6N2ZDQVQ3bHRM?=
 =?utf-8?B?U0VZOWRPOC9CZG5VK1JBK2FzajA3K2hqNWhiZEgzL2s2S21yb3djM3hxSVJp?=
 =?utf-8?B?Z3BLYmh0Z1NXdlhTS0hzVno4ZE5ySWsyS201V0NOT0hoYWRweW5Jd1BPQ21V?=
 =?utf-8?B?amFqSGRqbGdRdk9SM3JabXZ3UEY0REdIQitzZGpxaTM0VUVEWi9KWVVhenk2?=
 =?utf-8?B?bkdQNGlMVFBYUHFBVkdsL0RuOStVa0Rsejg0dlZUNDE0N0RVRWF2c01sb0ZP?=
 =?utf-8?B?V2RVTVR2NVM3TzR0T0xxbEFyZ3dVWDNWUHluZ211Y3FMcEQ0Z21seTRlSURH?=
 =?utf-8?B?RVhlaXBnT0VDcWNPYy9PQU16Q3JtYU9LRStwcEtBMWhHZit1U09wL0h3MXNH?=
 =?utf-8?B?QzltZDRIRmduV1hvYUc3TU5FOTkrOXFpdnhseGlMZEZhQ29qT2JzNnoyWEJJ?=
 =?utf-8?B?aGVVZVZqWFJXNWwwd2pRVnRLQ21IKzVvMmdTTE5MZEFHTFVua1dzVGlLVmJq?=
 =?utf-8?B?bWV4WlFFNWIyeVpTNjd0TUE4SVZtSktNTTlzRkgwZ1d1aU9DVEVTY0oyMWMy?=
 =?utf-8?B?eXlKcjFObUtaWkwrVlBVTHIzQUFvclkreFU1L0FiaUpvTHkwYlFCZU5RejFo?=
 =?utf-8?B?SVBSZThQOGF6VFQ3NkROU1BHcnFNa016RVZpbmRGT2VDL1ZsRlpkdFhoVVZr?=
 =?utf-8?B?Z3BoaDd5cUVwWFhNQUI2dUxhcHk4eXpkb1ZBTDBPdTQ5Z08yQjByTHl0ZzY3?=
 =?utf-8?B?WEt5YVRDcmQwSU4zWnlLUjA1V3B1SnpUM1BvNFJsbXNCT0tYaWRTNWV1aEty?=
 =?utf-8?B?K1NGU3RXbTZZeU1CZFQ1SDRYT2kxWjRGNlFZQVRIczhMWWNnQTlyM1o2NmdD?=
 =?utf-8?B?Qk1OYzhUbDlVbHFTWmNneTFJUU9pZzV0L0w2bFlvWEhIazZmbVgvNEI2ZE5J?=
 =?utf-8?B?Yk96YW5LaVA2c0NhNWdRYzZoUjdlVy9SUWVhUkljSjlpTGRUVTVCNnNuRUxI?=
 =?utf-8?B?YkNhZUlwVFZ6WlhkbVlIbUJBaXk3eEErN2p2M3RFWHpXRUk1Uit2RmU1K0s1?=
 =?utf-8?B?aHZyMTl6Smd6ZWQ4MnBnSERYaXEvMWVLZTdiV3NwQzdkWlViNnhsekFEQkhw?=
 =?utf-8?B?OFRmZ25vQmN4T0ZFVnhVQXFRWkE2SVJRM2x5ZjFaRE1UZXRBZVFpYUs2ZGtp?=
 =?utf-8?Q?hcqu30vJOGUYF61aJcAAstts+PZdhMqM69ipU5oLyA9c=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1loNmp4WEtqRzlTaWF4a2pyWm5IcndubVgzVGJYQWtDalo2Y2p0RU1uUzNB?=
 =?utf-8?B?dGRnYk9RQkRzUW1ZVitUNXRRNkJlTjcrRTExOTN2ZEpPZGgyU3N2TEtMUkt3?=
 =?utf-8?B?ZTduMVVrKzB4Y0dlM2k5RFU1NDhRVlkyQi9OczhlaDBmVUdNeCsvRXdDQUlT?=
 =?utf-8?B?RUdnVi9pUndjQkFJelhJRnhPbUVPUTVPS2ZZVmhpbTFVVHNIQnRuNVhTK2Rv?=
 =?utf-8?B?Qk9IUFVlb2p1ak96cllXcFljdFF5b1IwaVV0Ty9wZ3d6QWt1THRQSjZYcW1O?=
 =?utf-8?B?UVhoTDJYVDVCRWR3U2xuRXI3TTZyd05sS2RLcGZpdEpLazhNQUNhRzhka3Fy?=
 =?utf-8?B?c0c4WHcyRTdKRFZwNG1RZTVjdEg5aVdodXByNEhVdjlxRkpsTTRvT3pTV003?=
 =?utf-8?B?dDk5TVUzTS9UbEVwaE16WC91cmJIS2Y2N0ZwVUNsazJpSFp4c00wT0pqMnB6?=
 =?utf-8?B?TzVVekMxTjUwQW14TkF4MTREdVQ0ZWlxdHdHWDhLdDhTZ0YwSXk5cjdGWXpt?=
 =?utf-8?B?eFc4dEJiRDJSVnJ6eWg4TXJPampDVmpzUWMrV2FLc1d1VzJlRzUwNTYwNUVw?=
 =?utf-8?B?bE9xL1RWdExIMkNZSWU3Q0tJVk1TR290NlZVR05mY3czNW0renprb2RtKzBT?=
 =?utf-8?B?U1ZhNVVnaWR0MW9VRVRLeXZkbVE4TG0vVFNLejRJcURDYkZqS3NTMUVyY3ZD?=
 =?utf-8?B?bU5mS05mUk9NRnpNanhKMTVNVFBWZE1qbnVTSnZXeDE5em1jSnJhMFEwUGhx?=
 =?utf-8?B?UHJSMUhyZkpicGZqanA2bGk0STI5QTFzTDZ5YWtCMnZlODhRS0Zpb1AxYXJ6?=
 =?utf-8?B?bU1NR1BhcmVQSmN3UU5LWldBQkNOaFl2ekoya1RscEQ2alN1dFFxYUUwOXk2?=
 =?utf-8?B?amlGZUdQUVl0VXozU3FWei9ybWtzSlFpZ2lyY3R3U01NcjBuczJQNS95YzRv?=
 =?utf-8?B?cnRRa1hkVmRLM0wwWkN5clRqQjJTdWpRc1F6R0dvQ2hMWTM1cGhWbkFvZlE0?=
 =?utf-8?B?Tk1ZRkxvRzlZeDBhOFFJR0hXelJpRlU4WjYxeUtScUxjUXJKUkl2akVKdzVx?=
 =?utf-8?B?a0RsT2YxZEV3cmNGU2JMUGtKNlNxZVhYN20vK1JrdlNGV2pUbzBmN1paSlRD?=
 =?utf-8?B?RExJZEpCdkprdjRia3ZMOGlHYjl0NEpLaDhTdmVTLzhEajM4WVhDaXV0czR1?=
 =?utf-8?B?bEtzMGN0S254OFFKYlUwTnF3ZXdVa05ta2VrNlZpL1JiK0lkTkFOWFY1clo2?=
 =?utf-8?B?b3l3UkdHKzQ1cEY4U1hXTGdxMEc2K2h1c0xqdGQ3S0RSNURtcVVmemppS2dN?=
 =?utf-8?B?ZnVVa1ZuRitlNzV3eCtKMG1HekhkdWo3Y1hoMWx6UkZtdVpVdG1aU2N4alMr?=
 =?utf-8?B?dDFsUForL2N6ZURXSlQ5YWVqaTA5aEg1VHg2SlM0Y3hBOUhJMzlrUThVZlVl?=
 =?utf-8?B?TEt3VUk1WTI4eUpENkdSc0E1ZXhSMzJraFByRmpxckxBYitFd1hxMG1JbWV1?=
 =?utf-8?B?Nnh1b1JiU3hOTWlGRU1TNm1ZYTRac3NSelRlZHR3T3VNeXNsc2ZsR2NZYWlJ?=
 =?utf-8?B?cHgvTkh4c212eXB6eDVod2RJZHVMYWlPYUo1QWd6ZEh5d0xnSloxT3Q5dHI1?=
 =?utf-8?B?dGczYnlGN0lvOHI0SkliZGZERFFDVGh6TkJETXBXTngzOFBjZStHZGJKYnMv?=
 =?utf-8?B?MTdWejJscFlNalRmUXczTXA2R2lNSS9GU1dmd3Zxd3RCTW4wUS8wQUs4RWw4?=
 =?utf-8?B?Y3A0ZysxWUpHcitOai8vM2RYUkRMRnRMWWdyTTNLU25oNTh3bkxySFdneXI4?=
 =?utf-8?B?cGFZUlFLNXNTNisxS3dmSm1ZSkJOb2VYWVpvQVA4NmFYMFlHR3p4UURGV2Zh?=
 =?utf-8?B?RC96WG9nQzdoM0ora3dLT042azhuRmVjbEpydEdFbUp3VDhwcUZkQ2VyRzdB?=
 =?utf-8?Q?LGsAwzrcTZ3nEugYEHjdqaW8g0jUvdXN?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636348b5-a5be-4cb0-a088-08de9548c236
X-MS-Exchange-CrossTenant-AuthSource: MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:28:06.4026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA5PR01MB11775


On 4/5/2026 11:41 PM, Yao Zi wrote:
> After talking to Inochi privately, I'll take the patch instead.
>
> This series defines quirk flags for Cadence PCIe host driver to allow
> disabling advertisement of ASPM L0s/L1 states by overriding LNKCAP
> register, and set them in SG2042 PCIe driver since SG2042's
> implementation is broken.
>
> I've considered to re-write LNKCAP after cdns_pcie_host_setup() in
> SG2042 platform glue, like what has been done in the v1 of patch.
> However, cdns_pcie_host_setup() performs pci_host_probe(), which finally
> invokes set_pcie_port_type() on the root port. It reads ASPM-related
> LNKCAP, which might lead to dangling pci_dev.aspm_{l0s,l1}_support
> values. Early PCI device fixup won't work for similar reasons, since the
> fixup is performed in pci_setup_device() after calling
> set_pcie_port_type().
>
> It's hard to fix up the LNKCAP earlier than invokation of
> cdns_pcie_host_setup() in SG2042's platform glue, either, since
> the function also performs resource allocation/mapping, and we have no
> access to the RC registers before it returns.
>
> The safest solution which also depends on no PCI subsystem
> implementation detail is to have the LNKCAP fixed up right before
> informing the PCI subsystem of the device through pci_host_probe(), so
> here come the quirk flags and the ASPM advertisement disabling logic
> in the core Cadence PCIe driver.
>
> This series is based on next-20260403, thanks for your time and review.
>
> Changed from v2:
> - Use flags to allow platform glues to inform the core driver that
>    ASPM implementation is broken and should be disabled, instead of
>    introducing platform-specific hooks to do so.
> - Fix Co-developed-by tag in patch 2
> - Link to v2: https://lore.kernel.org/linux-pci/20260227181925.52475-1-me@ziyao.cc/
>
> Changed from v1:
> - Disable L0s/L1 capabilities through LNKCAP instead of LNKCTL
> - Introduce platform-specific init/deinit hooks (new PATCH 1) to
>    realiably overwrite PCIe RC properties
> - Link to v1: https://lore.kernel.org/all/20260109040756.731169-2-inochiama@gmail.com/
>
> Changed from the original patch:
> - Use driver to mask the ASPM advertisement
> - Separate from the following patch
>    https://lore.kernel.org/all/20251225100530.1301625-1-inochiama@gmail.com
>
> Yao Zi (2):
>    PCI: cadence: Add flags for disabling ASPM support advertisement
>    PCI: sg2042: Avoid L0s and L1 on Sophgo 2042 PCIe Root Ports
>
>   .../controller/cadence/pcie-cadence-host.c    |  7 +++++++
>   drivers/pci/controller/cadence/pcie-cadence.h | 19 +++++++++++++++++++
>   drivers/pci/controller/cadence/pcie-sg2042.c  |  2 ++
>   3 files changed, 28 insertions(+)

BTW, I guess you might forget to post this patchset to 
sophgo@lists.linux.dev. Please remember this later.

Thanks,

Chen

