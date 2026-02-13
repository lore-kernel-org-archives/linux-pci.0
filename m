Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013052.outbound.protection.outlook.com [40.107.162.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EE41DDC1B;
	Fri, 13 Feb 2026 04:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770955664; cv=fail; b=JYuLp3lFxiLrh8Yj8s6ficfMPFumaOWCLVTYCCPJOpl+2laflM8tSPIVOLcMXkBVnNH85cptjYHL7nYNjbKXNO+FJRpQF2xUbIZLNUtYXF39R8RryBZvZX8XJeKITM5H5h/K+GiB+kc9OHb8CjT8CZ0ENzEoDeFWkBtRk+KNUr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770955664; c=relaxed/simple;
	bh=rkM556hOpBnjKJp4IRPZM9Fj1at/Dj0BA5OzhXcsQsA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=q0vd0k+MsF2osthChyJlms1YBPKZhxUqDbL5Nnbg2TObx+2hz5d6SmMIhVbVF/Oxojhc8uKTvjwZtDSbuINTbjVdW26fig31henqcz5nAzDsK6zx5xR/uHmLTubRKToCQZq8A12UbDI9tRzfecd1Krqm+LO8RnMjzCgrxVCKyOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QiW9yFTb; arc=fail smtp.client-ip=40.107.162.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QiW9yFTb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLR9/1HrhZxlJ3u1o8QQKaKw5bMG/iK10MLK7dA9Sh4eEd539i43mgpG8E29wGJzya1CTLO5B6Oj4SfIx6VHYIPyAGo8/25fzHcv1S0T4PzPObxcQFCF9L18iDrn06l1edU/BXlj5n/hcmt2eLtgL4Gj7bjTagB9c4+30xD7MFhoLuF2GZEl2nzG5cc2Dbqj2Aiya3+5prmj8O55nvkUkf9f5pEBJ5sJzF07BX1iOF5L5nGi2hbIO/W68G0O7ND8t3m3f0ZLN1ptYzcONs80s9S/SfNjJJpSvdcmUitlq5JriwLgO6GvUEPTOacry93LsjZCcSFQHnyCc2rvICurJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImoLgHRgl1mxU+VUQI2c4iUDvq+wWI5kHosQeXKTvKA=;
 b=En5GqYMPYPQrAcaQGwLlIRNQ3MVGFVFQLV2gOLifZGIQAwKc4siX7GaJpplWyf7c0poPNXmmAcXi6GaDE8zP/0W+ak1wP1htN7NksHnlSJzWexEp22sI3hJ5xNDio9tDyykx1jeXHTtUnIkEDoNghiWlWu88tEtkyIE164jxm0UGhsvDlVyaeL+LLWoTaRJdYC/nFQVoSes9voQnsu7OYuymyVIHZz1l38oVBgUdGiV1lGQhXmxMrnurWbuF83IyHsLKWsQRvgBCGg8AZpgAx4d3KGlFRMURIvY/xSNJ3jIPgj3D0f3S7oVY0PhGUJStajB+vMyfHPGJjg4e+RElFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImoLgHRgl1mxU+VUQI2c4iUDvq+wWI5kHosQeXKTvKA=;
 b=QiW9yFTbUDPhwAiszfjHKCVsoiJ/MMNv9INbY0MKrWqXBchrPSkamn7Sto0Wr8tEKBLtCkeOBMmRpisSiC1IsI8JK3ZuGMmDe+S5Z5XFC6eJ+5DgIIkuhtGNfRbcgHqZmRO2C8u0Gw5g8ENBFmehdPEu1W29feR8aSeP7aPt8Z/p8nSdcBvNayuHOTDUv523BiJyaapZYrzpxvZQYZlmO3DD9L60g4pHHm95uaDz4z1XXfzWurmYIdV0p/owGiKzMfftUXdibSQZ4p+tpGN3q/VjCZIEepgwkOQdlV0/m8WnA38TeEqknwc0LLusGqUe6bX5TeLqdt1sEr4xZ6AWfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DU4PR04MB11900.eurprd04.prod.outlook.com
 (2603:10a6:10:61a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 04:07:39 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 04:07:39 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V5 00/12] pci-imx6: Add support for parsing the reset property in new Root Port binding
Date: Fri, 13 Feb 2026 12:08:40 +0800
Message-Id: <20260213040852.3340547-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0206.apcprd06.prod.outlook.com
 (2603:1096:4:68::14) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DU4PR04MB11900:EE_
X-MS-Office365-Filtering-Correlation-Id: c3db3662-a4a5-4d9c-575e-08de6ab56d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUN3Z1dFVlJhMHJKTXlYd3RlMS9QZ0xPYjVMbWdNR2JkNXNidm5oSXNxRUtL?=
 =?utf-8?B?SVhQd09IWDRvSG1OSlVzZllFSUpSa3B4NDFQNEZJOEVCM0xRNzRaMG03K0Vr?=
 =?utf-8?B?WUx6bHpIc01BZWlkOEg3UWpjbFFFNkFBYWtvRjc2aXBQZFcvWit3bm1vRnJt?=
 =?utf-8?B?UkltdHFkTFQ2cENaRHNiRmZhMHBpbTBEbFd6VHpsckRVcG9RTml4ZHJjYTVu?=
 =?utf-8?B?RnJpMlBpQis4RGlZdlRkVDR1eDVUN2FOc1ZKQ0ppaytLZDFxTEpRTndYOWla?=
 =?utf-8?B?dDBKTXNMTXJkWi9QNHd2K2FtK1orSi8vbTUxeW51VDVzQmVWVnAzMGlwaTYz?=
 =?utf-8?B?VlJjdHMwZ2FGRVJraWVrZVFnTkxxRktibllwcUV6TUtCODM4UWU5RHozajdI?=
 =?utf-8?B?ZVFVL2ZQdnVBWTc2cndEYjlUejlzbGx0TUc3WWNNSHRWZEREbnZOSTVBU2Jp?=
 =?utf-8?B?SE5paTZmWmFVQ3dVMUw0WHFHRGU4TEN0NmpEWXlFVWhvUUNQUjJuQnpLdkFC?=
 =?utf-8?B?M3RydG9mQ2c2WEJRc0VuN0VTVHpYMWNHQS8wUVZ4UUVtN1E2aXR3aVN3U2Rr?=
 =?utf-8?B?bmhjWFlqd2FrVGI3Smtoa2lvUE95OE9tQzM3eDdzaFZYKzZ3RUpleDJqMkhR?=
 =?utf-8?B?YzhUYVNoanVLU0NzakxBT2RtYXFoK3lHRDcwRzlqbjdRWWJzd1doRk81SmtO?=
 =?utf-8?B?TjJFTFB6OUJPWjhickRjSGo3ZWJ1RE9NNFRncTRKVGxhYXVXTEkvVXJ0UjR1?=
 =?utf-8?B?WkNTK0tZR1crQ29aTnZ2dzREUGd6dEFRdUZ4b2ZMQXpaVUdKT1JlaXF0UUdo?=
 =?utf-8?B?OXNYcFZDQ2lYZTgxSWlhdC9Xa21oZHVpWitNMUlRNFhkQ2lSVXhjOTJJWXd0?=
 =?utf-8?B?bXl1eFRIWjZuMExkazhENitqVVNDaGVnaURpbE81NS9KYVRZbHlZR3AzWFBj?=
 =?utf-8?B?WThSMDBrRTdBK1FudVVldmtOQzR6YkZ1SkZEMVRPS0lWbzNNaktvdFFMRXBC?=
 =?utf-8?B?bmRBcS9ZSkxwNUMzVHhOaWtkSUhjMVM3NXRteWJ0UkJFWTNXYVJleVlHS0pO?=
 =?utf-8?B?NUE0cVVrNkhzb0EwNG5Ya0ZNZ1pOd1RHOHFOdlE1NEw0VkxaWUtVN01BY2dv?=
 =?utf-8?B?V25rOEQrd2ZtKzI1VlpkaEhhbXB4NmNMdUU4Mll5SW40Uk8vbkZ4dVhhNHJJ?=
 =?utf-8?B?Q3g2dkdSZlNSa2QvcE5SOTVRS2NJbzlBQk00cEtUVlhuTGRlK2QrMGtVVVI1?=
 =?utf-8?B?VlZjamhLbmpBaVlTR0praWJTYSs5ZXcxS1BMdmZ3RFlCdlh0VGJkeU1xRHlo?=
 =?utf-8?B?ZUYwamJ6amtleGlyTWdZSEJWNllIVWtJYnUyVzJuR0dpQ0pVWUYwLy84MWRT?=
 =?utf-8?B?Sk1kM3hkN2FUYkl1ZVg3TkxGY3hjWjBQang2dDdFM0lLVHZ6UTZFL05rSFNW?=
 =?utf-8?B?dUFHM3dIaE5qd0w5VXpPSzU0QS9kZmxNYkJzMXVVR2lFL0thYWZjY1VmUVhI?=
 =?utf-8?B?Wm1ReFVhOVc2Y0xVZytJd3RjYjRGMlh1S05iVXNZUUozeW5kUm1qUTBranFk?=
 =?utf-8?B?UEEwOXNhSWFYcGNBcWJ5TjQwdVgwMFhMTWV2TUZHOHRKMmNpNTd5ZnRXMlZK?=
 =?utf-8?B?SXBSMGdLOXh0aVRtWjBJZ0hyQ2tuZkpFcm52aE9VeVQ3Q2J6dFlJZlFhZmRY?=
 =?utf-8?B?T216c2g4NmJNaEZUbWlna1VwT2pYYXFhR1ozQk82ZzJKMnBUcC9nWmdOVWZB?=
 =?utf-8?B?T2xNb0VXZHZ6OTdPWWlqT3hzVEpYSmc2akcyVGdBRU1GMkdQWkRTNFhRZEZC?=
 =?utf-8?B?c09HUDhmZWJuRTdQUFNmdkJaUUJ0SUQvVWp3WXlhQUZYbWFOYzBZZEhBUzBj?=
 =?utf-8?B?Q1pEQ3FUY0pPOXcxRTFLNGl5RS9NRXArOU52SGJteWpHcndSWEhzbFlxejJz?=
 =?utf-8?B?SnBJNWRHRWMzN3NWUW9xM1ZDWW9yQW9SZUNnQ2Q0N1hEMTBiYWoxc2xNdHVE?=
 =?utf-8?B?SUlSNTJZN29FYnNieHdPMDQ1aUIxQXlIZy9RV1gyaHlYbGczcm16TjF2cXJs?=
 =?utf-8?B?OXZwL2E2cDY4UEo5S3BVVXNzaVdaVnlEVnpCYWxXOVR6bmFrS2VuUERtdHdq?=
 =?utf-8?B?S3dDVzBMU3NBb0ErU2VqN2hJVFlENG5ScjQ0TlhkUHVFNlpFd0VtVjJ5MmNE?=
 =?utf-8?Q?c8M+9gmUuAvDVBlEsB6BqWbuXHQ5r7KryTIaSv+B2i5W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGxZVk9CMU9rdGZyL2pVYXpSWTFIOXgxcWlHVmVlK0x0b21HY2NBZ1hlcGk5?=
 =?utf-8?B?Y1diSzlGUXp0eHhSTzBBWkFkNnpWeXkvUXgraXArTlQza2c3QXROZTcvNVFO?=
 =?utf-8?B?OE92M0ZQbVBKTTM5Z1JaTGxBWGZGWmhJMVo1VVBNU1Z2L0tHbUhhaHNEaXBP?=
 =?utf-8?B?WE55TXVJSjF2SnlpMkg3RXFSYTBMd0xOTHp3Z0JBdWtyQWhCWmFUL1lRWWda?=
 =?utf-8?B?c1pHQ3AyQk1IdWdGOE9jZElRQUgzMmE0eFJkTjVoNlk2NUFqOXdMTHo3a2JY?=
 =?utf-8?B?Z01tZHN4cXNPNTg2UEdpNEZlK0hzdUFKbGFkeDB2YzVqTWRIVXhVZFhreXV1?=
 =?utf-8?B?YjhaWWxZamY5VjNWZndOd3pNeHdpSDB6aStpL2lvQ21sVkp6RURjaS9HbDF0?=
 =?utf-8?B?ZW1hcW5LS05Fck9Ub2ozMngxYVI5Nm1NOXFDcExBaFJ5cDFMK2NYQXZtamNN?=
 =?utf-8?B?bU9LaXdjaHpFaXhWMHA1eFh6WDVXYzNWcGNoVnlWRmxGclpmd0tpM2dEYnRW?=
 =?utf-8?B?b1ljN2ZSbVZObDl0RWRIZlEyNmVlVUFrSVVZZEpBb2w5MWNhTmM0WnNmc0Ny?=
 =?utf-8?B?UkovL1BSSlhrTkpSQWZvWWNpRkFLeGlvNExTS3BrZlNjRnlnbHF1RmdpQ1pS?=
 =?utf-8?B?dXZZeXYxVFRtazFEd2o5NVdKOGlRNENqMC9lSDhvVEt5NWp4dFk0SWJ1Z2N0?=
 =?utf-8?B?cnRjNHNXNUR1MVhEdzlwMXQ5ZVJ1MCtoWndGSG9vTnRkZ3VuRkRSNGhpMDE5?=
 =?utf-8?B?QUJCa2NjbTIwNk1GUCthZ1VGWE0xRUc3WW52WjhIZXZwd25QclplYTRrblln?=
 =?utf-8?B?b2E5VEdpZmc4RkptUVFEYUVsVjc4UDFveVlzNWFucXVZMHhiWDBMNFZRUERK?=
 =?utf-8?B?bzVQU3lYeUQ4R1NiZEc1Tmk3S0lmM3pzVzJCdmZabHMzTWhwVFRBMkkxT0h3?=
 =?utf-8?B?ejFNOFBhV1d3WFU0QU1FR0JzdE1NRGpWMDlZSVBQbmtmaVJBeTM4OHVTL3px?=
 =?utf-8?B?bHBiVmo5dWw4dGUwV3h6TTNGdG5KblRkbTVRb0E4bTk0Q0FrcmNqeE1OeTg4?=
 =?utf-8?B?WlIrZ2VrR3NJSklHQVlqRmkwUklNclBPWTdleHRzWVBBQVYvUEpzeXRCM0h0?=
 =?utf-8?B?UStXSmZDaDc2TjNLYjV2WkJNSUJUbkNkaEdaeXpRdDZDUlYwbE1IRzdHMEpJ?=
 =?utf-8?B?TG1BZUpRMjdOYk5sUm00SGdDSUJZTHFqU3h1WWpsZjIvM0JGa1dVMHI3dlJm?=
 =?utf-8?B?RlkzK1VGSkZFZGpTbGRVR2VXYVhrYmRmNDdmWldRK0FObEpiT25GaE9UWDZn?=
 =?utf-8?B?aldDS0dVa0ZLK0M5VEhJaWNYWmMwR3pLd0djd0RGeUUrV3QvUzc1a0t1M3da?=
 =?utf-8?B?Sy9kU3lVY1pJejZqa1JmbTZqZkU3bFg4eCtnNXhNbVBweEhicE0ray9peHdj?=
 =?utf-8?B?V3E1TTVmamcySWNhTm9IZTVaNllnMG5waHFCdnR6QllRUjhIVkFCaEt3U0Zm?=
 =?utf-8?B?WkI2Y3oxa1BEQjFkNlZMOFZybDVqZVB0dlQwajhmbHp1dVJ0WHJZWVNqc08w?=
 =?utf-8?B?ZzlLZHFSWjAwSDB1bmFJMGNSSUhOY3E0R0Q1UkxJaEF1a1JEc3A3dVVJM0p5?=
 =?utf-8?B?OVQ5YkxFMEZYOTlTMDBVT1RGREFMeUh0b3Ard1dNRjJSQjNQMFgrUVpRZExu?=
 =?utf-8?B?aVkvd0t2a1JuUDRHdTZidUhRbTBXSjlkeWdCZUVFaW12NHp3cHV5NWdKZi9O?=
 =?utf-8?B?MW5uclZHVEMvTlpSanVJWjlKaU9wdWtsRzBpeVdBRnNjZkFLRzZySVBHQ1BN?=
 =?utf-8?B?WTVLZDZkQm5ENXNsLytQN1BrUUExekw0L1RBSGdkS2pwMFZrSzg4NUp5WW4z?=
 =?utf-8?B?bVM4NlZLellsdDFNQXIyNnJyaEU2UWpPM2lEd05KWitOcFFoUzRSYlYyVWMy?=
 =?utf-8?B?QjIwbS9rWDJDSXV3cXozektyL0p6MmJHampVOFFkNitDY0lQNUdvZm9ySm1h?=
 =?utf-8?B?Nzg3YWFtNkpmbEFvZ2ZlbjlocHZMNjNxMUwyQ25RYjlwb0VPS0xadE80QjFB?=
 =?utf-8?B?L01CYjF0emhTVlNvdjR4Sk9adlNReTRHUzJTSE9HTUpXQ3NGOTBDWlQyRHAv?=
 =?utf-8?B?bDlzVUFZMjJYQ0IrZEFwSGp6ZlA0eGJjZ1VPZFozTWZzU3NERHZ0RjRWZWVJ?=
 =?utf-8?B?TGs0MGtCaWRyM0hZaHczZzlndkRscTA0MGtGbGdXZ203a1l1VDBBa1R4UWNX?=
 =?utf-8?B?NS9jVmlTY2oxUGZJNWhCekxscU1jdEV2c0FKTTFLQm5QR1NuMmFia1IzV1Jr?=
 =?utf-8?B?c3V4OStEcU5wcFFScFhVN1pUSHlvOHIydFEvdlBKY3FIYWNpZ0VTUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3db3662-a4a5-4d9c-575e-08de6ab56d7c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 04:07:39.3102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSL83tb8u3/h/ldTtjoCbWvyjJMAe1V7mKKVWOb7pSvXopSFLGkxzdv7FJWKVcIYxOeTCN5b0aizAOvFDRcXlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11900

This patch set adds support for parsing the reset property in new Root Port
binding in pci-imx6 driver, similar to the implementation in the qcom pcie
driver[1].

Also introduce generic helper functions to parse Root Port device tree
nodes and extract common properties like reset GPIOs. This allows multiple
PCI host controller drivers to share the same parsing logic.

Define struct pci_host_port to hold common Root Port properties
(currently only reset GPIO descriptor) and add
pci_host_common_parse_ports() to parse Root Port nodes from device tree.
Also add the 'ports' list to struct pci_host_bridge for better maintain
parsed Root Port information.

The plan is to add the wake-gpio property to the root port in subsequent
patches. Also, the vpcie-supply property will be moved to the root port
node later based on the refactoring patch set for the PCI pwrctrl
framework[2]. 

The initial idea is to adopt the Manivannan’s recent PCIe M.2 KeyE
connector support patch set[3] and PCI power control framework patches[2],
and extend them to the pcie-imx6 driver. Since the new M.2/pwrctrl model is
implemented based on Root Ports and requires the pwrctrl driver to bind to
a Root Port device, we need to introduce a Root Port child node on i.MX
boards that provide an M.2 connector.

To follow a more standardized DT structure, it also makes sense to move
the reset-gpios and wake-gpios properties into the Root Port node. These
signals logically belong to the Root Port rather than the host bridge,
and placing them there aligns with the new M.2/pwrctrl model.

Regarding backward compatibility, as Frank suggested, I will not remove
the old reset-gpio property from existing DTS files to avoid function
break.

For new i.MX platforms — such as the upcoming i.MX952-evk will add
vpcie-supply, reset-gpios, and wake-gpios directly under the Root Port
node.
Therefore, driver updates are needed to support both the legacy
properties and the new standardized Root Port based layout.

[1] https://lore.kernel.org/linux-pci/20250702-perst-v5-0-920b3d1f6ee1@qti.qualcomm.com/
[2] https://lore.kernel.org/linux-pci/20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com/
[3] https://lore.kernel.org/linux-pci/20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com/

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in V5:
1. Add the Root Port list(pci_host_port) to struct pci_host_bridge for better
   maintain parsed Root Port information. 
2. Delete the pci_host_common_delete_ports() as now the Root Port list in
   pci_host_bridge can be cleared by pci_release_host_bridge_dev().
3. Change the common API pci_host_common_parse_ports() pass down struct
   pci_host_bridge *. 
4. Modify dw_pcie_host_init() to allow drivers to pre-allocate pci_host_bridge
   struct when needed.
5. Allocate bridge early in imx_pcie_probe() to parse Root Ports.

Changes in V4:
1. Add common helpers for parsing Root Port properties in pci-host-common.c in
   patch#2.
2. Call common pci_host_common_parse_ports() and pci_host_common_delete_ports()
   in pci-imx6 driver.
3. Use PCIE_T_PVPERL_MS and PCIE_RESET_CONFIG_WAIT_MS instead of magic number
   100 in patch#3 as Manivannan suggested.
4. Use "PERST#" instead of "PCIe reset" for the reset gpio lable in patch#3.

Changes in V3:
1. Improve the patch#2 commit message as Frank suggested.
2. Add Reviewed-by tag for patch#1.

Changes in V2:
1. Improve the patch#1 commit message as Frank suggested.
2. Also mark the reset-gpio-active-high property as deprecated in
   imx6q-pcie DT binding as Rob suggested.
3. The imx_pcie_delete_ports() has been moved up so that the
   imx_pcie_parse_ports() can call this helper function in error handling.
4. Keep the old reset-gpio property in the host bridge node for the
   existing dts files and add comments to avoid confusion.
---

Sherry Sun (12):
  dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in Root Port node
  PCI: host-generic: Add common helpers for parsing Root Port properties
  PCI: dwc: Allow external allocation of pci_host_bridge
  PCI: imx6: Add support for parsing the reset property in new Root Port
    binding
  arm: dts: imx6qdl: Add Root Port node and PERST property
  arm: dts: imx6sx: Add Root Port node and PERST property
  arm: dts: imx7d: Add Root Port node and PERST property
  arm64: dts: imx8mm: Add Root Port node and PERST property
  arm64: dts: imx8mp: Add Root Port node and PERST property
  arm64: dts: imx8mq: Add Root Port node and PERST property
  arm64: dts: imx8dxl/qm/qxp: Add Root Port node and PERST property
  arm64: dts: imx95: Add Root Port node and PERST property

 .../bindings/pci/fsl,imx6q-pcie.yaml          | 32 ++++++++
 .../arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |  5 ++
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi        | 11 +++
 .../arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts |  5 ++
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi     |  5 ++
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi         | 11 +++
 arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts       |  5 ++
 arch/arm/boot/dts/nxp/imx/imx7d.dtsi          | 11 +++
 .../boot/dts/freescale/imx8-ss-hsio.dtsi      | 11 +++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts |  5 ++
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |  5 ++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 11 +++
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  |  5 ++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 11 +++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 10 +++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 22 +++++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 10 +++
 .../boot/dts/freescale/imx8qm-ss-hsio.dtsi    | 22 +++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  5 ++
 .../boot/dts/freescale/imx95-15x15-evk.dts    |  5 ++
 .../boot/dts/freescale/imx95-19x19-evk.dts    | 10 +++
 arch/arm64/boot/dts/freescale/imx95.dtsi      | 22 +++++
 drivers/pci/controller/dwc/pci-imx6.c         | 81 +++++++++++++++----
 .../pci/controller/dwc/pcie-designware-host.c | 12 ++-
 drivers/pci/controller/pci-host-common.c      | 58 +++++++++++++
 drivers/pci/controller/pci-host-common.h      | 15 ++++
 drivers/pci/probe.c                           |  2 +
 include/linux/pci.h                           |  1 +
 28 files changed, 390 insertions(+), 18 deletions(-)

-- 
2.37.1

