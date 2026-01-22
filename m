Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020134.outbound.protection.outlook.com [52.101.195.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02433242B8;
	Thu, 22 Jan 2026 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083162; cv=fail; b=sDr289Q5gIqpxHfI6oq0F4+YwinfEIZTkVUOxrykG9mbCRjAeSdFALSXNnw5oKWpiRCfoz7PvpIP9iCfLfgYEeLnXzxCVj2sOeanBvpuXL7NzSkX8keYJ4KlnAsfWVAMy3+0oGFrwCp20sszUzS8jbcjedszSUf3JzE9QIPB114=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083162; c=relaxed/simple;
	bh=Yn/Bwjop6kMRqpcJ3ZWjWQVprme7uonBotGw4R5maTw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=RMLOutLrLRDrye4Xk+IwZCyMmEzAZ2PjCAZOaYbdFaT0GU+Y3If9tffBwMOCZTLSq7eQ0qnAQzH6BfgvJCkUsFCBuvwIQEjrS1WCcRXoeXoYSt02aYlPo66Q0DB3+pYxGifmwCvIEGnAQ0rk2hCFfQFQAt2qJFRfDvgXZSDhmNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=r54yjx5f; arc=fail smtp.client-ip=52.101.195.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="r54yjx5f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6NfYlcFlfEHS12X78GAnMAbOfMDFhOnYcFh/dk53tnhs1/cdVcKXN6SJBvmwQGHdZUZfxqcPUq5GD4yY8rJnfl3yBMtIcmn1UMTA4coxb7KNpO3wi+odzmASPXP4d+aHI4Hv+PfI6M0ycYSF+aTYwLDAzaELU7b0gn1LyytEJgMGZ/OfZCX+56CIdgVIh2GlrfkAoAxKeWgXcGKDn6nB2y7uftu9e6+dgJIKDxfN173NDjlYFhL2hceFNGlwExqVNKPuL2MGWmu/Ez94UBYn42XjpKrqdC1t//5EmxuUgW6r8EaCaYXeQP4oSEdxOIo5grYin2u3hkITRf7YGWBKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B608Nr9iGcEAAABK6T2Sev2ctGQUUeMPWDE7+eODDtc=;
 b=iE0t+jhvzezblxNHzMBq7X7ZN1YmgFdFE0EBhbPpD/7VHzLoUR1vZ8XWDYZIi62/o4pmFEScOVU0jg3Wq5hzHvSH7ev8nKvr07y+fEKiEzpleniRnTFhAvwzqXwGYnvabATYLV81S3Xt7CrffgZIRY/v+nXMyHAMTi/6z2B9PulNRF1pvKadFVXqgtILn3gdBiVDdJh1h/krB1cHSe/gKKGM9IkXeL6B3tvntSa2sYLC9OLFfws+WPoGIEThxVcffnaqCdEtedx4aVVTlb8v59YpBsv5qI5Ry8XW47Kq5xSLkngJQ/Iz5lyVvh12f6cFVUWfNYwPwmBat9aSwkVmCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B608Nr9iGcEAAABK6T2Sev2ctGQUUeMPWDE7+eODDtc=;
 b=r54yjx5f7XydfFB5j4IPZT56KYUCoMXHsy1hRdEQ834DwVkMcy1jm+JJBYWTPfcUGvTt0TieXsxUty4jdg6ZahehlTNGJrgahdJbIMwgOIhsr/Z1+m2z5heTe/dmoAgspEcDJkP497pRez1Ui9W9PEIqEskPWeU/9e9EmofZw/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB6405.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ca::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 11:59:15 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 11:59:15 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 11:59:14 +0000
Message-Id: <DFV3N1SHS8SK.338Z25H89HINU@garyguo.net>
Cc: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>
Subject: Re: [PATCH v12 4/5] rust: pci: add config space read/write support
From: "Gary Guo" <gary@garyguo.net>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260121202212.4438-1-zhiw@nvidia.com>
 <20260121202212.4438-5-zhiw@nvidia.com>
In-Reply-To: <20260121202212.4438-5-zhiw@nvidia.com>
X-ClientProxiedBy: LO6P123CA0030.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff4f13e-f6a9-4329-805d-08de59adaa35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDVUZHFQbHQxVS9mM0hGY01IakQzSHlrRzZaNUtMc3VlaVlUeEtpSUkxZWZE?=
 =?utf-8?B?U1R5WjlQVkk0MTE2NG4xQ1drb3kvaGU5TzNibWF4WFYzaHhlUTBsdDJpRWFl?=
 =?utf-8?B?Y1JLd3BndzdLTVJKd3htNVROdFBCVEZ5UEsrZnVIZVRIMVRscEFxV0JPL1dS?=
 =?utf-8?B?OHlCakViZ0U5aE5SMXV2TlhmRXhvSDdVSzJ3WjEwcUlvRklaRTN1d0c4RjUx?=
 =?utf-8?B?c1JDZTR3MVVwbnl3ZFBUdlc0ZzJqTDRKV2VleFk0MmdJaHBzcUlwM29Qc1Zr?=
 =?utf-8?B?bVRmTi8rUncrZmcvT0thSzllQnVWOEUyd25heTVkZlJSb002a29rSHM2OFhQ?=
 =?utf-8?B?clowbml1R29PbG5NYXJ0TEdhb2xLcG9NVGxJbFNKeFFyNTZrUjN1cTF3eXRr?=
 =?utf-8?B?cnRxZmVWUFI2NHpaQ0c0VVFFK3E2cXJnQ1NHYk94cjRGd1dRanBVazRDZWpQ?=
 =?utf-8?B?Q3dTK080cFRlU0xIQUZVVmJRUFE0YlJXdlY5SmI5WDlmY20xS2xxUXh4LytM?=
 =?utf-8?B?MmZLcUlmK0EzYkJoNWgvU2FRMTVIT0RYYTcrNVQrZWh2TkYwK1RMNVpuYjQy?=
 =?utf-8?B?RWVrV25XcytXdzZhVGR2NXhkcitWb1hVVVpvVmdTYnlNem5nVzVySGQ3elE4?=
 =?utf-8?B?ZWdZQnVZNjh4dWM4SDhGdkoreFJSbS9BdVlUVDFqMzdwbU1CSGZmRFFhelFp?=
 =?utf-8?B?bENTQWFJcjhBWTI4SlNIb2U3enVMYWo2NnM2eUNicWZrYXM0bGMxTThOYUVU?=
 =?utf-8?B?MU5GVG5JaDVhcm5CM2c0bmZYMXBlYkV4ekdpMG1kS2Jrb1JyNjRDVGNxaWhB?=
 =?utf-8?B?c2RjWUZsd0YwSEpNVUhsNXFQNXRKN09OeTc3UTZZYXd1dUZvemJvWmkvNEN5?=
 =?utf-8?B?cSt4aHFqMGxxNmNnaERQSDZEUGY1VXlDakh1YUcrN0lHUlk5REM2ODFWRk00?=
 =?utf-8?B?RERVU2xabkMxYUtjQ0QxalhsaWNIbkYxWE1VRU9wYW1PTkVYc0V0Zko3VER3?=
 =?utf-8?B?aGc2V2ZtTDJzdGdBKzcxek9qYlhXMzh2dUhEZlB2d2xxOVU0S0ZCWVIveWNk?=
 =?utf-8?B?ektsRlVKNkJvZ25SUnpjK2pPZldHeUgxdHp2QmE3WnM1ZGQwRUZzQTlhK2hK?=
 =?utf-8?B?YlpHRHZlVVduQUJrdVVuSC9DSTNaamk4cGZHT1ZNbzkvUW0xcXVNT2RMV0I3?=
 =?utf-8?B?L2RWOW5QcmR1SmcvRFdzWGduRTFxM2UybFVkVUZERlVwS2hLRWxSZS9LOWgw?=
 =?utf-8?B?L0ZTblFDNXE2V3RMUVpqcStRcCtlNEh0Nk5qQU9ucmVkMHUrMUtkczJPWnpM?=
 =?utf-8?B?amFEZUVsd1g2dS9GNVZlV3RIVUtXaHVBaFhUdm1neGo2VFJBV0NvOGxjejMx?=
 =?utf-8?B?OUtaMzlPVlRjL0VwOVd6V3B0SHhLdmN0SVE4L3pDZGd6ejRDU2dlc1R1NUVr?=
 =?utf-8?B?Vis4cHFmaTI2bzBzcDEyNWtvdStwMG5wS3NoQnZGTWdnL0FGams4anlmS0F6?=
 =?utf-8?B?UXU0bktvcjBWajByQm5xeDFLYWRSR0FyTEhYNjRYbjVpcloyNFY1MlliNXlS?=
 =?utf-8?B?WHNrZG92cG1QN0FpWkxKZitDTktIVENJS0FVRTNWTDA2aVVXQXlTMXNpbW55?=
 =?utf-8?B?YitEVG1VREFOWnVtVFk1YmQwNnIxbzVDZVJUNGQweGhxSkVsMTRIaTZRYnJl?=
 =?utf-8?B?QkJ6VktDMThCSXl3UUlWRGVUem9qMGZqbVRLRS93S3A2eEszQmpVZ2k0Y2I2?=
 =?utf-8?B?dGpXUEtyaHB4VXNVMHVpODJXMlZESmlwR2FMaUMwNHZzTklZUkRIMWl0a3hO?=
 =?utf-8?B?bEN6dmtGbFhIMktTdmprU3cyNjZDeU50OEs4VG42UDJVREYzSGJOZzMvRXFM?=
 =?utf-8?B?VG5HeTlkNXpMeWpGNGoyZnFCYklHeGxleXRsazZST1IyNUdodmxuZTZXckZJ?=
 =?utf-8?B?dm5NRkpJL2NnTzh2RjZzK28waGdjYVlKVThVRGpJY0RxY3ZqR0RTVldoZEF3?=
 =?utf-8?B?ajdvNDFVNzBUczl3TDFuR2tDWDJoQUhjS1FhODJnUWYwcGYydkk2QnFRUGto?=
 =?utf-8?B?NE5LTG1MME5VNXVzNEJtdEZmTWViNzBQcS8xSTNtZnBxZjNINGRNVlFaeXZW?=
 =?utf-8?Q?3rHQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REdLUWRkeWttYzY5a0lOOUp3NGxJd1NHdXBjTmV1cEdqd0M0b2ZBakNEb0lO?=
 =?utf-8?B?cDZtMENVVXhrMk5JUUVlNWsxNmw2a1M1dmVyZzFNRlliVlZtWHFIRjVjb1FF?=
 =?utf-8?B?YnVQb1U4dkI0bkNzdEJ1Y1gxVFhncDhtSEpwaXhWa002ODB3VXFnbVNiMDdU?=
 =?utf-8?B?VTErcFNDVFkyY1hxMUViR3ZYUXBKeDJvQVBhclI0VjZ5ZGJqVFRpdDdYamc1?=
 =?utf-8?B?Q1lER3lFNlZjQXhJc3F4V3lkK091ZzJBV0dEazhrQ080amZBcTVwcThiNFRz?=
 =?utf-8?B?QTFJMEd2VDZuQjlwVzM3SlJjVGRBTkhYeUZoYm1OTE02bm9peUhSWXp3c2VD?=
 =?utf-8?B?bUVwc05ZRkpCazBFc2xRNmhUaGlWS0g2Sm9rOEhWcnJFWmRjUkRVdEJJUG5U?=
 =?utf-8?B?SG1ZbmpyVVFxVTJXb3hUaWdETnlWZTRYUFVTOUZ6WDJsakM2NklwOVdYOUd6?=
 =?utf-8?B?ZlV4czUyMzRWYkl6VDUzVk1vcTVqSC9ZSlNMVDBNajNFejlMc1FkczhkRWw4?=
 =?utf-8?B?SklqazBuZnhzUy9zU05wY09LUDZVZ3A1eDVzVEIwMmZuTXRPSXJDQTdld0tE?=
 =?utf-8?B?cExQMTdXelRQeG9vK2o4djFCcjhwSFY0dzF1WXZFdUZZMXlIa3lQZjN1Y3VG?=
 =?utf-8?B?M2p3cVhHY1NteEVnUGF2RjN4QTdKVXovMkZSYURhN09MTDhIeUk1dm04UkNm?=
 =?utf-8?B?MGdNdWZwQ21CeSs3d0x4T1d1cG83TzFETUtHdlZ2dHc3eU9QSDAra01hRElN?=
 =?utf-8?B?T3ErY2FLM2pmV1gxYWZwNUg3aFFOaHdPQlVzRjVtd0VLcjBZbjFvT2VDOHQw?=
 =?utf-8?B?UzhZRnhNSnk3YmxVZEhGYUc5N2pQTVFYdW82bkUyU1htQytPRi84WE1Id2dT?=
 =?utf-8?B?eXJDRGNLWlVoVFBlLzYyN01kYWhxNVgzODk0eFRYNFJkVTRjSkxVay9JeWts?=
 =?utf-8?B?alQyb1NVMHJ0TitpeVNXR3Bna01TZVZXd0MrL2VMS2EzR0cwcDR5Q284b29G?=
 =?utf-8?B?NVd5Y0VtS0oxbWR0anhWOXJyUllsamtKVlVRNFYveURxN3lrZm5KYVh2ZEtw?=
 =?utf-8?B?WVl4OU5iV1oxNkVPM09jQkVyZkphNGtCenBIMnIvN05rbWNoVnk4WUJaOTM3?=
 =?utf-8?B?RURiOG9kTlFwUWd2US9Cb0NycWs4Vlh1SmdjVGw4V2JmcFk2TVJFNDBoMHFw?=
 =?utf-8?B?Y0xIbEpoMFVjVGF4TVRZNUdORGE5cVBqMzJMdnZUUktneDRSTWdlRVJlWXRQ?=
 =?utf-8?B?QVFyOTB6RGJZTkhkSUlUWUZNOUFnQzh2U05BWlp6ZUR3bjFHRUFnMGNvcXlw?=
 =?utf-8?B?MGNNd2pYNC9mZy9mZk9jaGp0dnROZkFpUWl0K3F4WFJmejJEMU5NekVTdWR1?=
 =?utf-8?B?OUk3NmFBdlhFQXRMRk9VMWVqbVM1SVRkMXNXYmhLM3U3MzlHMzF4a0VZaXgz?=
 =?utf-8?B?elUvemlGZjdrYmdaMGRWOFZsV0hQRXBWeDd4R24rL01yK0d2Q0drRXVHb0w1?=
 =?utf-8?B?dUY5Qk1QRkZXZWVCS2cxSm1TSVBPeExaZk9mN2hxK1FuTktiMFJTMzBZbFR3?=
 =?utf-8?B?MGRBRjZvVUdzQk1Gb1pxaVRFQUt6c0FYbXdUK1RSWjBUdjlPdUQ3emdUbzBY?=
 =?utf-8?B?azZvcC9rWDBVOGxhdHE0R2gvK1FjZklWUnc1bjF2WStYRWVHVXdhRnFteWI1?=
 =?utf-8?B?VlBQbnhacjRkeWR2TE5PZjIwTG5uRFJxQ3FtNnI0Z3hpK1loTE9Wem9tempK?=
 =?utf-8?B?NGhDb2ZpNnBmOW9pYU9lZkE0bVlST1prMzFuMGMvdnl1ZHZtZXFQdkhUNWJz?=
 =?utf-8?B?dGd5R2haOFJrbElqOW1QelBHMnZSYUlkcUJCREpLdDdLVVc4YlFOaDhpbEo5?=
 =?utf-8?B?NGRsNEpTckdhc0JkU3RvT1lnNm50Zk5ucDAyQmd6NzFobW9ZeDBjOUozeGZ0?=
 =?utf-8?B?ZXVPV3JFN2ZIbktUUytSK3p5NHAzekhheDY3RkxGZUdpT2pkNFZYa0gwdHUw?=
 =?utf-8?B?aERDdmVINkdCR2RBOVZUZE9OVTJtNVREUUNPZHBBYmowS1ZCNDcvSmpVWStF?=
 =?utf-8?B?WVowaSsycG1wTFlhSDY2ZkZFVUpOemoyWHRkS2wrZGlFZkkwWWhmV0I1cmlZ?=
 =?utf-8?B?Wmt6cGVqbVVUcy8xYlNlV3dNN2pCVFZlQ1NLZmM3T2ViRlBnS05IeFNHOXBv?=
 =?utf-8?B?SlFXeUtXaTRsWDVKdS9qRFo2ZjJNOEhiVWZpakRKMjA0MVdqRGMrOHZ1V2o1?=
 =?utf-8?B?RWxzUkNOZzRvVUZNc29aRGJSUi9STHRJQVovUEVOaGhRWUkrb0RjbW1MTmZw?=
 =?utf-8?B?dnA0anNIa01QOWZFZXJmVDZNWDY1U2hSZktOQ1lhRDhuK3FZUkRIUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff4f13e-f6a9-4329-805d-08de59adaa35
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 11:59:15.4024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwbe60cNPzNpGisDR+5zqbTHC0WRWfYNvQv2mYPndDI/n6YFgI4rMfjzLYwXhYulZul42/270P/A3AZDDwdu7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6405

On Wed Jan 21, 2026 at 8:22 PM GMT, Zhi Wang wrote:
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
> The `ConfigSpace` type uses marker types (`Normal` and `Extended`) to
> represent configuration space sizes at the type level.
>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  rust/kernel/pci.rs    |   7 +-
>  rust/kernel/pci/io.rs | 167 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 172 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 82e128431f08..9020959ce0c7 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -40,7 +40,12 @@
>      ClassMask,
>      Vendor, //
>  };
> -pub use self::io::Bar;
> +pub use self::io::{
> +    Bar,
> +    ConfigSpaceSize,
> +    Extended,
> +    Normal, //
> +};
>  pub use self::irq::{
>      IrqType,
>      IrqTypes,
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index e3377397666e..39df41d0eaab 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -8,13 +8,149 @@
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
>      prelude::*,
>      sync::aref::ARef, //
>  };
> -use core::ops::Deref;
> +use core::{
> +    marker::PhantomData,
> +    ops::Deref, //
> +};
> +
> +/// Marker type for normal (256-byte) PCI configuration space.
> +pub struct Normal;
> +
> +/// Marker type for extended (4096-byte) PCIe configuration space.
> +pub struct Extended;
> +
> +/// Trait for PCI configuration space size markers.
> +///
> +/// This trait is implemented by [`Normal`] and [`Extended`] to provide
> +/// compile-time knowledge of the configuration space size.
> +pub trait ConfigSpaceSize {
> +    /// The size of this configuration space in bytes.
> +    const SIZE: usize;
> +}
> +
> +impl ConfigSpaceSize for Normal {
> +    const SIZE: usize =3D 256;
> +}
> +
> +impl ConfigSpaceSize for Extended {
> +    const SIZE: usize =3D 4096;
> +}
> +
> +/// The PCI configuration space of a device.
> +///
> +/// Provides typed read and write accessors for configuration registers
> +/// using the standard `pci_read_config_*` and `pci_write_config_*` help=
ers.
> +///
> +/// The generic parameter `S` indicates the maximum size of the configur=
ation space.
> +/// Use [`Normal`] for 256-byte legacy configuration space or [`Extended=
`] for
> +/// 4096-byte PCIe extended configuration space (default).
> +pub struct ConfigSpace<'a, S: ConfigSpaceSize =3D Extended> {
> +    pub(crate) pdev: &'a Device<device::Bound>,
> +    _marker: PhantomData<S>,
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
> +impl<'a, S: ConfigSpaceSize> IoCapable<u8> for ConfigSpace<'a, S> {}
> +impl<'a, S: ConfigSpaceSize> IoCapable<u16> for ConfigSpace<'a, S> {}
> +impl<'a, S: ConfigSpaceSize> IoCapable<u32> for ConfigSpace<'a, S> {}
> +
> +impl<'a, S: ConfigSpaceSize> Io for ConfigSpace<'a, S> {
> +    const MIN_SIZE: usize =3D S::SIZE;
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
> +        self.pdev.cfg_size().map_or(0, |v| v)
> +    }
> +
> +    // PCI configuration space does not support fallible operations.
> +    // The default implementations from the Io trait are not used.
> +
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
> +/// Marker trait indicating ConfigSpace has a known size at compile time=
.
> +impl<'a, S: ConfigSpaceSize> IoKnownSize for ConfigSpace<'a, S> {}
> =20
>  /// A PCI BAR to perform I/O-Operations on.
>  ///
> @@ -144,4 +280,33 @@ pub fn iomap_region<'a>(
>      ) -> impl PinInit<Devres<Bar>, Error> + 'a {
>          self.iomap_region_sized::<0>(bar, name)
>      }
> +
> +    /// Returns the size of configuration space in bytes.
> +    fn cfg_size(&self) -> Result<usize> {
> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
> +        let size =3D unsafe { (*self.as_raw()).cfg_size };
> +        match size {
> +            256 | 4096 =3D> Ok(size as usize),
> +            _ =3D> {
> +                debug_assert!(false);
> +                Err(EINVAL)
> +            }
> +        }
> +    }

This method is only invoked from maxsize, which turns error into `0`. Do ap=
art
from the debug assertion, the error code is pointless. I think this functio=
n
should just return `usize` as it's specified in the device (we should trust=
 the
C side that the value is sensible).

The check, as Alex mentioned, need to be done when ConfigSpace is created i=
n
the first place and is too late when you already hand out `Ok(ConfigSpace)`=
.

Best,
Gary

> +
> +    /// Return an initialized normal (256-byte) config space object.
> +    pub fn config_space<'a>(&'a self) -> Result<ConfigSpace<'a, Normal>>=
 {
> +        Ok(ConfigSpace {
> +            pdev: self,
> +            _marker: PhantomData,
> +        })
> +    }
> +
> +    /// Return an initialized extended (4096-byte) config space object.
> +    pub fn config_space_extended<'a>(&'a self) -> Result<ConfigSpace<'a,=
 Extended>> {
> +        Ok(ConfigSpace {
> +            pdev: self,
> +            _marker: PhantomData,
> +        })
> +    }
>  }

