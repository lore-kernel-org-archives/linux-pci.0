Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091E537CD59;
	Thu,  2 Apr 2026 08:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775119476; cv=fail; b=nOMAT1oMjSf2plxQxZShatH1X/4kXPL2CUN/Q+Ls9E3r30B6XDIJCK4F8adYhRHmOj0HwjYK0ksgoo/7aWb5sftt4ee/efnSDhhQoQoaewDELDrAyNMgnKRB4GLXHxOiTEghUsaiEu4DGrCkrr9/31oqtOCp/tOukihZSKh2XB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775119476; c=relaxed/simple;
	bh=6HrFPC3k38VfvxRq9nk6k8QXMF/c4TaBtLtRH08AqWQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mx2Zj412MlCZFoXwnCQ6zK4xRn2aHPBjd2d/gl92gXjGdLd0VnXRPyxuhvsfA9t6ettslxGEfcBryFbovf4rMZy27uWMbm8xcLhVnkG9nOKm8ddg4bkiiSKqcNEeSvxINgS/M8Ub9Zcclykme3b3Vv4sODrVf3ns4bLmWMMIypU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LV3Ml8H6; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=irl/vKEd; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LV3Ml8H6";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="irl/vKEd"
X-UUID: 271337b62e7011f1ae70033691e9ac7d-20260402
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6HrFPC3k38VfvxRq9nk6k8QXMF/c4TaBtLtRH08AqWQ=;
	b=LV3Ml8H65/mKjZRubhHdYLxsC5IP7Yw++IBqjXHdrxVn0dvoCFWIv+ZeBYx5Rl9kuqE9zTNRAkNjLikyopvY0hVMNiIq/HkAXwX+/3gjIe2tqjD3pE/hT7YjfzRFWW4SZD+1fVGstlRlGdsq61HC9f8RcchRL0Jj2jdpWtdhtRg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:8a461f2f-c309-431b-a074-8b53d92a3eb3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:7e1e6dd5-060f-4ecc-9ee0-121eeeb4a682,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
	l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 271337b62e7011f1ae70033691e9ac7d-20260402
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <jian.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 236241711; Thu, 02 Apr 2026 16:44:25 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 2 Apr 2026 16:44:23 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 2 Apr 2026 16:44:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TREj7V5S6bICyi6UW1ClHYzkU/rDQFR+kf56iYHBF3tWPNcfLslCANJxiCiHvo3TGL35BZbjUTzhK3jHBrnPrwbMhpyBbnTdvDlrp9HHZJzijlyIS6SShgBQ4ZphOZAqVQSaXsbTb4USQkSWeLIWoF8Lxken/BCDnWP9rNEPDc0GHlhCzQ7XbK0KHRY5gvZRoMZUGINhcphPMOb36xSW0j5NUxw3dyH/JhUh78bt3tn8AlKSfyiWMKKcZOzoxjIPofOQt49JsSnNlRndjn6RaBBkYtUKU9zDnTz0Bzmpr2fO6Yq/5sKpqB4+1lKNuiIAZpUsbbO/6qf6FFGXwffJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HrFPC3k38VfvxRq9nk6k8QXMF/c4TaBtLtRH08AqWQ=;
 b=bzrqT5QpjVirGko8qqW/qJyT8jDCGWgC6R2AZYF5YSLuqvV8slBWJ2Ov8+qgf6+NFuLTMaX4nB279P5kLrB4SWFV6hOA58fdkO/vgWCxgDnua6Vsod5g+lUZdu+H2fo0S6v6HSRC3Ds3DO2vQd8w0itI9CnFZJ0YhIX6xOpbVaVk+wPh1YV45sFfxn9eVkmXEwuAPh+a+KTU4ATXUxz1lT+uzkdyJ+NIYC6nobbkQLz+8eHucFSahCqKs4zMVsCqnl98SQqCMm5HEviRIuUyaIfejhaUhFf78Jazc0Bw+B6YBm4wg9m7K2jPfsJNBSAIuHWZy8k+hKLvkzC1OTL9vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HrFPC3k38VfvxRq9nk6k8QXMF/c4TaBtLtRH08AqWQ=;
 b=irl/vKEdPVq8FEZLu1+QVZ9y9b6n7VnMSJDtLJXx1CXRL33CxWrNsK2kENH3Ubaj+WR/frAQIz0z0Kmp2RxCHRp+GxoxqJpXcDjrb3fb5XXTA5kG0v6oSqlGSX55DaIHbv07+lCbpJ9RbgtPItHi9X3GBgcSacoJQf0+nGVuHGo=
Received: from TYZPR03MB6021.apcprd03.prod.outlook.com (2603:1096:400:128::9)
 by SEZPR03MB7218.apcprd03.prod.outlook.com (2603:1096:101:e7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 08:44:16 +0000
Received: from TYZPR03MB6021.apcprd03.prod.outlook.com
 ([fe80::6f0d:b0c1:5f84:f355]) by TYZPR03MB6021.apcprd03.prod.outlook.com
 ([fe80::6f0d:b0c1:5f84:f355%3]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 08:44:16 +0000
From: =?utf-8?B?SmlhbiBZYW5nICjmnajmiKwp?= <Jian.Yang@mediatek.com>
To: "mani@kernel.org" <mani@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	=?utf-8?B?Q2h1YW5qaWEgTGl1ICjmn7PkvKDlmIkp?= <Chuanjia.Liu@mediatek.com>,
	=?utf-8?B?WW9uZ2xvbmcgV3UgKOWQtOawuOm+mSk=?= <Yonglong.Wu@mediatek.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "robh@kernel.org"
	<robh@kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, Ryder Lee <Ryder.Lee@mediatek.com>,
	"AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: mediatek-gen3: Align PERST# sequence with PCIe
 CEM specification
Thread-Topic: [PATCH v1] PCI: mediatek-gen3: Align PERST# sequence with PCIe
 CEM specification
Thread-Index: AQHcwYZi9c83wFejQ0uhlYP3QBboprXKIH2AgAFWO4A=
Date: Thu, 2 Apr 2026 08:44:16 +0000
Message-ID: <9013d68ffdfff49c852f609e2e8b6f5e13741d22.camel@mediatek.com>
References: <20260401031917.9108-1-jian.yang@mediatek.com>
	 <x6nabkumov75khx4icgibrmd4o3oz5drm3cfthh6j2himsihla@echprgpjanoq>
In-Reply-To: <x6nabkumov75khx4icgibrmd4o3oz5drm3cfthh6j2himsihla@echprgpjanoq>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6021:EE_|SEZPR03MB7218:EE_
x-ms-office365-filtering-correlation-id: eadb28a7-63f1-4d91-82c7-08de90940637
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: i9HGTvFU8BGOTRXv8BA4v404rDeeYQRI+KgZBkKwbdIZrdrp/wZo4E0jKsbtaDTl9HrGiyvj5Qf3mExfb2/qB52p/CG2oC+yc+4yCccE8PkoUlIJ5ky+/uaQd8uPlRZ91NhQDLelAvUE/VvUJahZsvFzA/5mejxW0Z7heDpfdDF0ujxrSlJLeID97ocy2jgPDsUXGHLk3niUdqso6e0uvAtkZiGFSOyd6DAHKX+3cQhqBjZi0wijxxhJxl7WponAe7Onzk5fbGJekj4erZHJCPxX9tRL1spCcuoZfDgtYFvcwtvtlm63GCkrnPwmyK8qsNslxP3amAiujvj52XhJpL+gYsQkvJWGwVSuxcMTFlTKjX1IGfYwqowY+Aaas30EDaGAF8d0YNv6JnLCiF/V75+EqDpbkoesUZSK3fCAZ1fd1z+cH6v+nnBUAK4zxddtOOO5ndZxi+cComBSIchgz3vOmHxXJnFiW7pFpSsEOH0nnOvgKqZXH4/yxHfDOr5eIGcb1gZ4QX9NStZF6a3KckdI3HQzYir0cEdl8JqwMDcdUEa5P1W0YvrFWMg2PSd20Bs0lDX5mDhM85pwKVvaFEdsBF2snBa//aE+f7O3tfLCc853BL48LdxDZr6K/VXPBFJbImNojxvbt6pCMLkZGoZ6fywWHDNUn8LL3cXEqLI7iMfQTO8BFKHr/Kf0B+yvtDmhj2rhTk70z4pVw1oomfA0NQ+ET5/jof+pIH89rNybgPZ0V1UcSxX3xvjxqLfgpSVeOoWoBU6lgSvcHpm+ZnDZ74IzjEWZlZRxgO9dEsw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6021.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUNNQXdHejRvNFBEQjRvT3hValR3Z3BIK0Q4Nkt0TlhGWlJ4Y3J3MkZKNFky?=
 =?utf-8?B?T0lzZFRoNEs2Sloyc2JKUFIrb3A2dXlueDF3THFEbFFaRnRxWjROeFQxNFA1?=
 =?utf-8?B?RVY1Sk56SVg0dmMzdXlRNmNlbWZkZ09PQ0YxSzlXYUl2aGc1b0R3NEZlemRz?=
 =?utf-8?B?dTRLM0NSSzFzV1R2WkZiWnBaNmhDbHF5L25FaG1QS2l6UGtQTFJsL0haK2pU?=
 =?utf-8?B?TlVmYjUrTG5EbXJmTXhHazNuOUpkSnRjb25xZ1BTRTViTS82cFpyQ3RESlE1?=
 =?utf-8?B?d2lSTmxuTDhDRXRiSWxiREVFN1ZLQ3B2dVZOQzJrNG5laXZZZTgzdWlQUDc3?=
 =?utf-8?B?ZXgyOFdmbUdtbzNOdCtacWN5ZVlTZER6UWNHUUloa08rWE5yR2FkTUd1WEFr?=
 =?utf-8?B?L1V2RFp3RkNwWlo4VjE0U2I5d3JkbEwrQkxaVjVSemhEdHNsMGU4ZkE0bG5h?=
 =?utf-8?B?cFZ1VEdFWFBJNVpCOW40UnloRk9nYk5Pa3hwaExRQThFRlFJL1B4MWZ1NjZI?=
 =?utf-8?B?R3FXQTI5aERrSDZtRlN3WjJCa0JwMDZWMmR1aFk1ZXk1YXRpQ1UzWWsvU3N5?=
 =?utf-8?B?enlSNnZlanZHYWFHUW54VnBlN1FidDd2S3E4ZVlrdXJwa0dlY09ZRnlCQlN5?=
 =?utf-8?B?TVF2YjVGajBWZ3lLWGVlV2ZVNGV1Sjg2anJPY1FNai9pTlkzTmFxUzdyOVBv?=
 =?utf-8?B?ZVo0aHR1QjR3VFd3MWJhMDZLV2dRWHllMmtzemdpbzBQdkp1S1hyNWRMZjRM?=
 =?utf-8?B?MTlUS24wS29UNzBnT2pHbkFDU0ozM0EvODZJc2NBckxtMnZyNHJCM09NNXJj?=
 =?utf-8?B?Ri92NEtjb2NVZUVYSkw0ZWZGbGJERTFTdlZkUmRnTG1paGpNQnJBMzVJM2Rn?=
 =?utf-8?B?UGF4T2FCeGcvQWwvZ3I1d1BPUTdTaENrcTR4aE14aDF5SXY0NnVGbFFGT3Ri?=
 =?utf-8?B?bjJQd3l6ZUF6TC9mRnQ0WWNLRUhMVTI2TTVCZy9za0V6c1hEdExZTnVaS0ZV?=
 =?utf-8?B?NjBFUVN3VkJxRGlmUXdLQ0VZTFlUM0g4Z3VCRndZMGtKZjBrdFZzUkxVd1Qr?=
 =?utf-8?B?cHg2OEpzRitqNDJhb0F6S1BrNGFUaUxhaTE4OUEzZEJVcXlBUXBHQkp3R2dJ?=
 =?utf-8?B?dFNCbWJCeFFyRlkrT3lybHQ4NllhR0hqR1dFeS9lbFVsZ3hZSytXT2tGb01V?=
 =?utf-8?B?ZWd0SFBleHIzbEwzaXFyVXRsUlRTV1ZTQ3NRL2FHVm12VDJObTJkTUZ2OG1t?=
 =?utf-8?B?ak5JMUFjQW1PWkRta0RYam0zNDNXb0ZSTlA2SGNDM1NMNzhoaThkc3lHeXFZ?=
 =?utf-8?B?VzU3THhKeklvbXdvWFRacmVqTkJQZUZnQkdGVnBOdmZpZ3ZMNU1tbzRkZkRl?=
 =?utf-8?B?UjRuMGh5Zk56TUJycThQY09uV252cHFXNW13Mm5yV2N1NHJCUzFNaXpoVzhn?=
 =?utf-8?B?a1dlWEljYTFMbkFaNkVQdSt5Wkp3TUhuVmJiV1BONlg0ZVlUZzBMeEZFNWUy?=
 =?utf-8?B?NTAwR053cCs1QlpBT1pOQlBGWDNjNHovMlhQVmhqd1NUUmhLd1ViVVowSGFG?=
 =?utf-8?B?cnFCcWxJUjgyT2cyMjJRR1ZQMGJqREJtMXVNZkpZWkZBdWdSbVl2eVEvSHM3?=
 =?utf-8?B?V0luK05CVUFHdjZQVXZCSGRTb0pMYXp5VlpQNjRQVmtTdUExWS9udXY3VE9N?=
 =?utf-8?B?djR6TW5rTFFlL0ZVMmd2bFNsVS9nQytLNWlMbXV0d0RLbWNMTVBGbmh4OHpT?=
 =?utf-8?B?SU4zWjZNeURiODNUcjIzdEZwYmZ1Wnp3S2gwblZXZldJR2hBZlp1MmdyNWRD?=
 =?utf-8?B?K0VOOHhObHhxbm5xa0EyOTdwTmlaQWw2VzRCZzFlNDdkc2kwbDJRd2NySEZQ?=
 =?utf-8?B?V2o1ZW5zZDljUDNKUkl2R1ZDZlhPUFN6Mi9MQ0VvVWU0akt2TWxxeVFnZDJw?=
 =?utf-8?B?Zk5wVFowdDdVcWhLcEdMbnBqSnNIMXRZVmlXMlhQRFBVc0haSW9CbHFyNDJz?=
 =?utf-8?B?MVJsQnVOU1RnUytNYmtXTmVUWUlSenY4eXQ5SXp2dmc3Qy9tYVExdzR3dzN5?=
 =?utf-8?B?V2h2V2V0d3c4RFd0K0JlMmVLZnFqTXIrKzQvM3dJeTkxS1RkK1hyTWVSQ0Fu?=
 =?utf-8?B?VEliYWRPVGtBUllydnNVSkV2Yk9HS0luRU5iaWh0N1I4OEg4ZjdqU2laU2w5?=
 =?utf-8?B?cElPUTBIL2krMHQ5azE1K0xiTmVTWlBtU0h0NEloempweE1KN3hNUHEvUXBm?=
 =?utf-8?B?d1pOVVdrZ2hNbmRIeHQyQ1FFMjY0eVdNa0hmYWtubHE2TzhNbzBydXVxR0F2?=
 =?utf-8?B?NUx1RDJhRW1XdzRwZkhzampYZVNMK1dEcVUxL2V2S0k0V0tUdkVLZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4AE5EE74C23F142AB4316D3C648AA7F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VDRnchZaAgciFzNwpTmHL7hQI9Q3TlQxDZCklXsf0rqwaK3x55uqocZasW3UsjQsqXMNICvr1WXmxHJJG63truKJWs3f4GzCP8eeJIJUUUN+gO43Oyea6dWOdRgwUdbQn1VhcQC7CXS+Lis0qKvlP9eBifrIfD9Qn/f7L7OSRDXSLFDMkNFoL8+kOofdKztGY7itYUZsbRfek2HP4w5iAIWXEsHUfanHAqOoYbKJ3vcq+8cB9IxembCGHQW9fXaGuraR/XHW2AMwBWpBSJijW4oVo+XPSXuV96RHWnb665lWo3v2Z/VfOUnk1AsiUhCt+6gva9hRWZtGFHDDAybVfQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6021.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eadb28a7-63f1-4d91-82c7-08de90940637
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 08:44:16.6639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0vd5xPgNEshCQ+8oiXrBuYczIOyaaovcXuzoG4VrM9Bn6Y6iKFJOwSyRuG19ISJhAbh2Zd7CtoYhnPNdfkEodw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7218

SGkgTWFuaSwNCg0KT24gV2VkLCAyMDI2LTA0LTAxIGF0IDE3OjQ5ICswNTMwLCBNYW5pdmFubmFu
IFNhZGhhc2l2YW0gd3JvdGU6DQo+IE9uIFdlZCwgQXByIDAxLCAyMDI2IGF0IDExOjE2OjQyQU0g
KzA4MDAsIEppYW4gWWFuZyB3cm90ZToNCj4gPiBGaXggdGhlIGNvbnRyb2wgc2VxdWVuY2Ugb2Yg
UEVSU1QjIGR1cmluZyBzeXN0ZW0gYm9vdHVwL3NodXRkb3duIHRvDQo+ID4gbWVldCB0aGUgcmVx
dWlyZW1lbnQgZnJvbSBQQ0llIENFTSBzcGVjaWZpY2F0aW9uLiBUaGVyZSBhcmUgdHdvDQo+ID4g
bWFqb3INCj4gPiBjaGFuZ2VzIGluIHRoaXMgcGF0Y2g6DQo+ID4gDQo+IA0KPiBZb3UgYXJlIGZp
eGluZyBtdWx0aXBsZSBpc3N1ZXMgaW4gb25lIHBhdGNoLCB3aGljaCBpcyBub3QgYWNjZXB0YWJs
ZS4NCj4gDQo+ID4gMS4gU29tZSBvZiBNZWRpYVRlaydzIGNoaXAgd2lsbCBzdG9wIGdlbmVyYXRp
bmcgUkVGQ0xLIGlmIHRoZQ0KPiA+IFBDSUVfUEhZX1JTVEIgc2lnbmFsIG9mIFBDSWUgY29udHJv
bGxlciBpcyBhc3NlcnRlZC4gV2UgaGF2ZSB0bw0KPiA+IGFkanVzdCB0aGUgc3RhcnR1cCBzZXF1
ZW5jZSBhcyBmb2xsb3dzIHRvIGVuc3VyZSB0aGF0IFBFUlNUIyB3aWxsDQo+ID4gYmUNCj4gPiBk
ZS1hc3NlcnRlZCBhZnRlciB0aGUgUkVGQ0xLIGlzIHN0YWJsZToNCj4gPiBBc3NlcnQgUEhZIHJl
c2V0IGFuZCBQRVJTVCMgLT4gZGVsYXkgMTBtcyAtPiBEZS1hc3NlcnQgUEhZIHJlc2V0IC0+DQo+
ID4gZGVsYXkgMTAwbXMgLT4gRGUtYXNzZXJ0IFBFUlNUIw0KPiA+IA0KPiANCj4gVGhpcyBpc3N1
ZSBpcyBzZXBhcmF0ZSBhbmQgbm90IHJlbGF0ZWQgdG8gdGhlIGJlbG93IHR3byBpc3N1ZXMuDQo+
IA0KPiA+IDIuIEFkZCAnc2h1dGRvd24nIGNhbGxiYWNrIHRvIGNvbnRyb2wgdGhlIHRpbWluZyBv
ZiBQRVJTVCMgYW5kDQo+ID4gcG93ZXINCj4gPiBkdXJpbmcgdGhlIHN5c3RlbSBzaHV0ZG93biBw
aGFzZSwgZW5zdXJpbmcgdGhhdCBQRVJTVCMgaXMgYWN0aXZlDQo+ID4gYmVmb3JlIHRoZSBwb3dl
ciBvbiBjb25uZWN0b3IgaXMgcmVtb3ZlZC4NCj4gPiANCj4gDQo+IEFkZGluZyAnc2h1dGRvd24o
KScgY2FsbGJhY2sgc2hvdWxkIGJlbG9uZyB0byBhIHNlcGFyYXRlIHBhdGNoIHdpdGgNCj4gaXRz
IG93bg0KPiBtb3RpdmF0aW9uLg0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMuIEkgd2lsbCBz
ZW5kIGEgbmV3IHBhdGNoIHNlcmllcy4NCg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKaWFuIFlh
bmcgPGppYW4ueWFuZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMgfCAzOQ0KPiA+ICsrKysrKysrKysrKysrKysr
KystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1l
ZGlhdGVrLWdlbjMuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVr
LWdlbjMuYw0KPiA+IGluZGV4IGE5NGZkYmFmNDdmZS4uNjZkMTc3OTE4NTY1IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4gPiAr
KysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQo+ID4gQEAg
LTYyLDYgKzYyLDcgQEANCj4gPiAgI2RlZmluZSBQQ0lFX1BIWV9SU1RCCQkJQklUKDEpDQo+ID4g
ICNkZWZpbmUgUENJRV9CUkdfUlNUQgkJCUJJVCgyKQ0KPiA+ICAjZGVmaW5lIFBDSUVfUEVfUlNU
QgkJCUJJVCgzKQ0KPiA+ICsjZGVmaW5lIFBDSUVfQlJHX1JTVF9SRFlfTVMJCTEwDQo+ID4gIA0K
PiA+ICAjZGVmaW5lIFBDSUVfTFRTU01fU1RBVFVTX1JFRwkJMHgxNTANCj4gPiAgI2RlZmluZSBQ
Q0lFX0xUU1NNX1NUQVRFX01BU0sJCUdFTk1BU0soMjgsIDI0KQ0KPiA+IEBAIC0xMzMsNiArMTM0
LDcgQEANCj4gPiAgI2RlZmluZSBNQVhfTlVNX1BIWV9SRVNFVFMJCTMNCj4gPiAgDQo+ID4gICNk
ZWZpbmUgUENJRV9NVEtfUkVTRVRfVElNRV9VUwkJMTANCj4gPiArI2RlZmluZSBQQ0lFX01US19Q
RE5fUEVSU1RfVElNRV9NUwk1DQo+ID4gIA0KPiA+ICAvKiBUaW1lIGluIG1zIG5lZWRlZCB0byBj
b21wbGV0ZSBQQ0llIHJlc2V0IG9uIEVONzU4MSBTb0MgKi8NCj4gPiAgI2RlZmluZSBQQ0lFX0VO
NzU4MV9SRVNFVF9USU1FX01TCTEwMA0KPiA+IEBAIC00MzAsNiArNDMyLDIxIEBAIHN0YXRpYyBp
bnQgbXRrX3BjaWVfZGV2aWNlc19wb3dlcl91cChzdHJ1Y3QNCj4gPiBtdGtfZ2VuM19wY2llICpw
Y2llKQ0KPiA+ICAJCXJldHVybiBlcnI7DQo+ID4gIAl9DQo+ID4gIA0KPiA+ICsJLyoNCj4gPiAr
CSAqIFNvbWUgb2YgTWVkaWFUZWsncyBjaGlwcyB3b24ndCBvdXRwdXQgUkVGQ0xLIHdoZW4NCj4g
PiBQQ0lFX1BIWV9SU1RCIGlzDQo+ID4gKwkgKiBhc3NlcnRlZCwgd2UgaGF2ZSB0byBkZS1hc3Nl
cnQgTUFDICYgUEhZICYgQlJHIHJlc2V0IHNpZ25hbHMNCj4gPiBmaXJzdA0KPiA+ICsJICogdG8g
YWxsb3cgdGhlIFJFRkNMSyB0byBiZSBzdGFibGUuIFdoaWxlIFBDSUVfQlJHX1JTVEIgaXMNCj4g
PiBhc3NlcnRlZCwNCj4gPiArCSAqIHRoZXJlIGlzIGEgc2hvcnQgcGVyaW9kIGR1cmluZyB3aGlj
aCB0aGUgUENJZSBpbnRlcm5hbA0KPiA+IHJlZ2lzdGVyDQo+ID4gKwkgKiBjYW5ub3QgYmUgYWNj
ZXNzZWQsIHNvIHdlIG5lZWQgdG8gd2FpdCAxMG1zIGhlcmUuDQo+ID4gKwkgKi8NCj4gPiArCW1z
bGVlcChQQ0lFX0JSR19SU1RfUkRZX01TKTsNCj4gPiArDQo+ID4gKwlpZiAoIShwY2llLT5zb2Mt
PmZsYWdzICYgU0tJUF9QQ0lFX1JTVEIpKSB7DQo+ID4gKwkJLyogRGUtYXNzZXJ0IE1BQywgUEhZ
IGFuZCBCUkcgcmVzZXQgc2lnbmFscyAqLw0KPiA+ICsJCXZhbCAmPSB+KFBDSUVfTUFDX1JTVEIg
fCBQQ0lFX1BIWV9SU1RCIHwNCj4gPiBQQ0lFX0JSR19SU1RCKTsNCj4gPiArCQl3cml0ZWxfcmVs
YXhlZCh2YWwsIHBjaWUtPmJhc2UgKyBQQ0lFX1JTVF9DVFJMX1JFRyk7DQo+ID4gKwl9DQo+ID4g
Kw0KPiA+ICAJLyoNCj4gPiAgCSAqIERlc2NyaWJlZCBpbiBQQ0llIENFTSBzcGVjaWZpY2F0aW9u
IHJldmlzaW9uIDYuMC4NCj4gPiAgCSAqDQo+ID4gQEAgLTQzOSw5ICs0NTYsOCBAQCBzdGF0aWMg
aW50IG10a19wY2llX2RldmljZXNfcG93ZXJfdXAoc3RydWN0DQo+ID4gbXRrX2dlbjNfcGNpZSAq
cGNpZSkNCj4gPiAgCW1zbGVlcChQQ0lFX1RfUFZQRVJMX01TKTsNCj4gPiAgDQo+ID4gIAlpZiAo
IShwY2llLT5zb2MtPmZsYWdzICYgU0tJUF9QQ0lFX1JTVEIpKSB7DQo+ID4gLQkJLyogRGUtYXNz
ZXJ0IHJlc2V0IHNpZ25hbHMgKi8NCj4gPiAtCQl2YWwgJj0gfihQQ0lFX01BQ19SU1RCIHwgUENJ
RV9QSFlfUlNUQiB8IFBDSUVfQlJHX1JTVEINCj4gPiB8DQo+ID4gLQkJCSBQQ0lFX1BFX1JTVEIp
Ow0KPiA+ICsJCS8qIERlLWFzc2VydCBQRVJTVCMgc2lnbmFsICovDQo+ID4gKwkJdmFsICY9IH5Q
Q0lFX1BFX1JTVEI7DQo+ID4gIAkJd3JpdGVsX3JlbGF4ZWQodmFsLCBwY2llLT5iYXNlICsgUENJ
RV9SU1RfQ1RSTF9SRUcpOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiBAQCAtNDU5LDYgKzQ3NSwxNCBA
QCBzdGF0aWMgdm9pZCBtdGtfcGNpZV9kZXZpY2VzX3Bvd2VyX2Rvd24oc3RydWN0DQo+ID4gbXRr
X2dlbjNfcGNpZSAqcGNpZSkNCj4gPiAgCQl3cml0ZWxfcmVsYXhlZCh2YWwsIHBjaWUtPmJhc2Ug
KyBQQ0lFX1JTVF9DVFJMX1JFRyk7DQo+ID4gIAl9DQo+ID4gIA0KPiA+ICsJLyoNCj4gPiArCSAq
IERlc2NyaWJlZCBpbiBQQ0llIENFTSBzcGVjaWZpY2F0aW9uIHJldmlzaW9uIDYuMC4NCj4gPiAr
CSAqDQo+ID4gKwkgKiBUaGUgUEVSU1QjIGdvc2UgYWN0aXZlIGJlZm9yZSB0aGUgcG93ZXIgb24g
dGhlIGNvbm5lY3RvciBpcw0KPiA+IHJlbW92ZWQuDQo+ID4gKwkgKiBXYWl0IGEgd2hpbGUgdG8g
ZW5zdXJlIHRoZSB2b2x0YWdlIHRyYW5zaXRpb24gb2YgUEVSU1QjIGlzDQo+ID4gY29tcGxldGVk
Lg0KPiA+ICsJICovDQo+ID4gKwltc2xlZXAoUENJRV9NVEtfUEROX1BFUlNUX1RJTUVfTVMpOw0K
PiANCj4gUEVSU1QjIGlzIGFzc2VydGVkIGJ5IHNldHRpbmcgdGhlICdQQ0lFX1BFX1JTVEInIGJp
dC4gU28gaWYgdGhhdA0KPiBjb250cm9scyB0aGUNCj4gYWN0dWFsIHZvbHRhZ2UgdHJhbnNpdGlv
biBvZiBQRVJTVCMgc2lnbmFsLCB3aWxsIHJlYWRpbmcgaXQgYmFjaw0KPiBlbnN1cmUgdGhhdCB0
aGUNCj4gdHJhbnNpdGlvbiBoYXMgYmVlbiBjb21wbGV0ZWQgd2l0aG91dCB3YWl0aW5nIGZvciBh
biBhcmJpdHJhcnkgZGVsYXk/DQoNCllvdSdyZSByaWdodC4gSSBiZWxpZXZlIHRoaXMgZGVsYXkg
aXMgdW5uZWNlc3NhcnkuIEkgd2lsbCByZW1vdmUgaXQgaW4NCnRoZSBuZXh0IHZlcnNpb24uDQoN
Cj4gDQo+IE5ldmVydGhlbGVzcywgdGhpcyBhbHNvIGJlbG9uZ3MgdG8gYSBzZXBhcmF0ZSBwYXRj
aC4NCj4gDQo+IC0gTWFuaQ0KPiANCg0KQmVzdCByZWdhcmRzLA0KSmlhbiBZYW5nDQo=
