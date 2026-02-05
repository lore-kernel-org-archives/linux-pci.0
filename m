Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010045.outbound.protection.outlook.com [52.101.84.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039411D435F;
	Thu,  5 Feb 2026 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770305454; cv=fail; b=HSdj7Av/zVb9GA6e3qyE4EuyRGmHewCK0768t9eLjeuDdWB+odj4TKlNeizpqiBcXhyJFrmHrA5kB7dWjeNnbiQPli/HvThmKNHsciOgU/O9ZsBHXrFEkB8t4Ly1QLMOTYYHqy4c6XadxGXy0P6GCLjP9V/4+3yG2TIM8P2wqZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770305454; c=relaxed/simple;
	bh=PMDc86zxabTmJEyyoYK9eZFWK3fXNUJNBoQ0iTcV8Ow=;
	h=Date:From:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=apYn7ZhPJfR26xOxvuuHUgndLThLwS8zb54Qa/CGGTwz7sD9rbuXQN2tv9BBf2BWIDulikuiW6ADgl+PdylTSSaiBdfVhY4YH37odS1epvFQLZIHgI8fIlYg8HR1qDEPv9kQ6BjJTX5qHowABE0UCQZHqYaNpKzRMxO3jnQc7n4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V3yW8KaK; arc=fail smtp.client-ip=52.101.84.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V3yW8KaK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8bz1e6ada5fXK7OtqPEAJq+FHX9jvTIBHHBxffHPaZuekBy0RzzQEW0VirS0N1nHAZs0FlAJTSndPuPkWl2kXLWJ/ocqrokQ6hI1ZTUnIo70nEfjYg9vaDkpwyQ0d5QthjLI2EnXi49ileXF7L3y8jXsTIVO8NA9NTM9A/qDZZA+MGm/d7eZpItraM+UV/SfGTRBJ5IwEOvpFb+8mR+gbr7AUfCFq6ldTH6SOMtRYVTGsYWTqpRamE0UsROg/ST2mytmnq3OGX1BRpf3hQFVBYdKCMP4dAFPSZezC4/GdVmqSWLIuvLlm1uI6MoPFw+eRd/QPRw9ODCororCC+Nsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQFOZBmcSJTdTNTiiMnRRIX012JpoOpkfXPFtyIvrqc=;
 b=QdcT5aKeFp5rIHRY2532yifFZSmAOZfFZlJhKCu5qC5fQ0YvOHEIYYoT0C9yxHh9VK4afinvZH01u6ZLsNnhvVo5lWDmMtIAFQhlrAX11sD7USJcaKR0Id9Z5PpXU/9q3qLhcV6EXocA71lWLbK9db3qojQzw6LF+zkIpTKK3OmtFVYd+QDhi/cjYUD+PnSi+WzRwcNfMm6VzOzxZImJrnnFj+DI0QRt/gSx7MYGvhUp9CSttu1zlQ3wvnWMaKHll9D5hLqPY5HzLT4ZqMq4xL12gs8Krw2utr7Rn1u7XCrCIuXIWCLKFhBHYoSkAYsDKHl0ONoWL6v0SntmRA4vDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQFOZBmcSJTdTNTiiMnRRIX012JpoOpkfXPFtyIvrqc=;
 b=V3yW8KaKkpGriyAY7nMtnpoHc/KTfIsHKZBThT0k4XP8rv8QdGfpSNDwymStZiNTWjeJos8fY88unRrCo4Lj1q/sOfE4GtkrGewmPDcGbdfl5gcJhi+TY4cRgqIYskZhuFpqa5HCwo0T0og7tqZrMC++4RYCZWiMaXkEd40BwztLd6gbM2sV1EA3H3nidkHHgITxj7AjDjRFyFhH8CcHQronpiz1t5NRUk8cN8UNZ57LHdd8787Y8LV2zt0AdLPalS8Ueu6ixJvCglCC/szEvCYgF5vsM5qPhT53GrGpNOzUtG1T5jXg1G+B5sSuFLUBLoNpX95rmoAMCg2W8yjx4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI2PR04MB11275.eurprd04.prod.outlook.com (2603:10a6:800:296::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 15:30:47 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 15:30:47 +0000
Date: Thu, 5 Feb 2026 10:30:34 -0500
From: Frank Li <Frank.li@nxp.com>
Cc: Sherry Sun <sherry.sun@nxp.com>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 03/10] arm: dts: imx6qdl: Add Root Port node and PERST
 property
Message-ID: <aYS3mtQlUZGe5j9_@lizhi-Precision-Tower-5810>
References: <20260203015614.2957479-1-sherry.sun@nxp.com>
 <20260203015614.2957479-4-sherry.sun@nxp.com>
 <mp25jwvoimpesfwtpmyeltdpbu7aznahxvkcn6jxg5jqzxck4i@pium66rnpdd3>
 <VI0PR04MB12114DBBE58AB89BEEDC28C019298A@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <gshz5zc7qkfkqkla2mkpu7jjf3sctrqf5jo5vszzgxzpegxzni@yhdqkykyn2ar>
 <aYNkDWt89b26wJWf@lizhi-Precision-Tower-5810>
 <xx6hhc66xwlr2qmhhm625cocmdng35a2h5vochzrg3gxb5f6tt@465qo5ugahfg>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xx6hhc66xwlr2qmhhm625cocmdng35a2h5vochzrg3gxb5f6tt@465qo5ugahfg>
X-ClientProxiedBy: SJ0PR05CA0148.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::33) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI2PR04MB11275:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e7ca41d-5a8f-4aae-651a-08de64cb88ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1o4SCtEOWJTb0tUS09URmZaamxoUXZ3eEE0T05acDY5SEZRbEtJT1Rnb0Qw?=
 =?utf-8?B?R1FSZG11TTUrRkVBN0U1VjNvVERhZnFUZko0aXBHRWVWYVlkY2lhTWE3aXBk?=
 =?utf-8?B?bHdnL1h0NnJ5UWE4bzNwU3FTSHBqcVdWUFF2d2c4Wlp5QVVLbTZnMnc3Qyti?=
 =?utf-8?B?UmJjNDZsc2RNSVd1d0FqSDVPY1NEUldURDRNcGZZQWMwN2Q0TkNTYnpFMmN1?=
 =?utf-8?B?Sy8wNE56dU4zTmk5V2w0UEt1SFhTc1hFcmVoSnBiajhvbnczeXY4NTJ6azZP?=
 =?utf-8?B?dzFxeEdGWmlQSzlCZ0lpMDhlaGtHY1ArRHoyaUJzZTh4QUR2NmdRZUpla3Vr?=
 =?utf-8?B?dUsxUmNmRVlpZ0JxSFo0a1AwR0VtVGxuaitlYzhYdDlvbS9OWDRIUCtwVmI0?=
 =?utf-8?B?RzIwSi82cUtwK0IzVzAvT0k5MzZIUXdMK1pSSDVodnQ1MXNkVzMzSjhsUDRv?=
 =?utf-8?B?MmhaWGxheUlrMDJXRXE4OUdLdW1DZWZpYkpUU2xHNnIvb2EzT0ZPTGx4U3Ry?=
 =?utf-8?B?azZ2ME52bWpBa0hheXBxTFkvdWNSRWtKM0dTRDFMOFdiaWpwUUxSVDhxWUtY?=
 =?utf-8?B?RzZXeFk0QXc1TGI5OHRMOTIySCtsZk5mSVdCNXNWUzlEQ0dnaFlkdXFWcmNx?=
 =?utf-8?B?a2pza0dhYTRzTmV6TDYrL25vQzZYNzhXUGtSL0tBM2Z4ZmtmamU3SWJmLytD?=
 =?utf-8?B?V3lLWTMyeThpMUpQUkFxTUY5TGN2ODNvYzdvZmQzWWFCT2YxbVRZaHltdldE?=
 =?utf-8?B?WklpaWhWeTJUTVFQY2t0bUI2dHNyUGVuRjdLSG5CcU5Db2IwV3RJVHV1ZkVm?=
 =?utf-8?B?c2lHS0JhczRzOGltb1E2UUg3S0tST25Ca3lCMi9QYVVGRHV1MFA2QW1YeC8x?=
 =?utf-8?B?QXRxQVk3RW0xdHBXVXZIRXF0WGNaWFdSUHpOQWZaYmo3dVJXNlUzYmFQZGVy?=
 =?utf-8?B?RFQvUUxjZUNja0lGVXM4aWpYZkU2MjlHMlZEU25JVTF5MjFUeU9zdDlPTWJm?=
 =?utf-8?B?dERaYkhTM1B2ZWY5ZHFVUDlpLzFrZlV6dVpGSmt3dk1DSzYxTXhjanV1cHVX?=
 =?utf-8?B?ZWRjaFhvckx2N1Y3U3kwZllJOTYrK2svNjhyVVVqZG8zbmZRUXZRWXFRak9D?=
 =?utf-8?B?WkJhMmNJakE1QzBwM2wrWnhEVlpOL1l5dG9naVFGdXZMSDgzOCtvRTZFZTJJ?=
 =?utf-8?B?R2UyRFExRUFIUVdTT1hIOWpVY0IrR1dHTWd2MDNlTWNlM29aTHVITlhPRDIv?=
 =?utf-8?B?ZmFkaGJYUzRRUjNnVzJPVXBPa09wKzJoNUMzUElydmdxYktnMVdKN1pIRWk3?=
 =?utf-8?B?MkNUT3ZhZzl0akIyK2Q5aWtYMERTSW5UNGs2eDBMT0t4SzlWL2JtZmpzcTc3?=
 =?utf-8?B?VHNSazArb05nVmpiTjVjRjBPc1ZLV0FacThlRHZ3eGhZRW1VNGxRam9UMStD?=
 =?utf-8?B?ZUExdmc0enIxdkpZOFVGeFNManRBYXNZMHFqQk9odTAweWsxcEVjbE5wVFd3?=
 =?utf-8?B?S2RpbHN0amZ3anJRd1ppZHNucEo1OElYeWpuNWpTWEdVN1pCa2RPME5DU01m?=
 =?utf-8?B?SGpaZ2paU3BXajI3VS83R3YrWGw0ZGo2TDhKWkd5REdiQWUrSTF3VFhPK2lv?=
 =?utf-8?B?cjVSK0dLclk0K2YxZzZuQVphM3VMbk1sTk92Vkh5N1kzUUg2dHZ5bnRXNit6?=
 =?utf-8?B?Z2hISStmWTNnVVpCYmxuNElURXpXMk5vTHAwUUtPUmp2bndkUU1ieU5kTXJN?=
 =?utf-8?B?eDUrQ3llM1llWnRTN2pDdlpvTHpoVm5qenNMZ1BZc1pDbFBTUWR5MmRQWTBV?=
 =?utf-8?B?L05pRGRVREZrNjFXNkkyb2xuR2xaOHZiSVZFNy9WdmMyMUplaGhGc3dnQUV5?=
 =?utf-8?B?THFOZ2ZMMUgwVFZOU1Q2Z2NIZ1dpVTVCem8xUkdsV1NzOVNNbkdsenpuVTBG?=
 =?utf-8?B?UUdLRVMxZ2ZFdml4Q0VTMk56NTJ3aXpuV0d4Z2dLSFFVaU5TWGZIbngrN0VH?=
 =?utf-8?B?V0NSVElyRzFQT2VEVmF6Q1NCWktQZVlML2RiMEQ0UEZaZXI5NjhuL2Z5akI5?=
 =?utf-8?B?SlRVbWIrbXBsUDFmSWg0QW16c1M1Q2I4QUJQSVpuSWVyeWhoRHJvMTFyYzBk?=
 =?utf-8?B?QU91SXVBeHk5U2V1dE1FTTZibG9BYWdhNU9MOXlxVVBvck9BSzNiK0tPbmdJ?=
 =?utf-8?Q?FMcYc8gklXlFBTP535Z1rqg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWhFK3ZiMFY0TEEwbzJaWjdSbElzaDJmQ1VYbzVnN0tRdzR3MVZ2MWIyaGl4?=
 =?utf-8?B?YURkVE05VkVzRmZhWHN3enRULzRxUmtBSlJlamRXZ01iTDc0ZG93RVZWaHZB?=
 =?utf-8?B?WmpZdUxsR0RwbjAwVFNxU1JYN0pUd0NSS1BwbE9aRzI4MzZrb1l0VmdGTjc0?=
 =?utf-8?B?SE1kTUpTTHU4V3BQYmlQU2tSaU5MdThLaGxaYmlwQlZydTY4dFI5NHk5QTNZ?=
 =?utf-8?B?TVlCNmtaaVNxbEx2WWZ5ZDB4d1ZpbldDektlNGR3djdtSVEzOXMvY1RYRUNM?=
 =?utf-8?B?aUVRK0ZZU2Fpd2xvVXk3dWlxZWtFNVZpQ2pacE9mVmJKa2RYejMyNUZXYXVS?=
 =?utf-8?B?Q2hxN3lkdGNTMnR3Tk5WN2VYNU5pam9GRUthOGRZMlZjL0pEc1RiZmNSYzdw?=
 =?utf-8?B?Smd3YTNJYm8wRUI1Um16NExkb0JhZlJ1N3dlSS94dElNbGd6em1Udm1DbkpI?=
 =?utf-8?B?bE5UeUdzaGZyb294aGIrYWpEOWJSR1MyeFlJUjJkd1pqcGptbUp2THc0Ym5Y?=
 =?utf-8?B?bnlWWUxUMkpoaHlrOUJscWdPaGxHNHdOek9ibmdZZ05qa3dSdk9YWHkrOWND?=
 =?utf-8?B?V3NkV3VqcjZwaEFONHlBMURIV2JXVTIwWGtqRVdDUkJ5ck1FSjZHYUtZUXdn?=
 =?utf-8?B?ZzNzMEdDMzRXNUNnbTQyOWhMdUxiT3FJNzhFQmpaeEZlK2FXWVBWWCtqQTU4?=
 =?utf-8?B?R0NzdGlZdzB5WjMydi91ZTZWMWw1b1p2M1c3T1FtRHBKbzRCanFqS291dWRO?=
 =?utf-8?B?ajRCbjlFNGl3b2YrbjQ0RE9UeUhrenh1RUlCVFBiL3J6TWkvN2pJbndrQkZ3?=
 =?utf-8?B?RXRSV1pnNXYxUjFMaks0aVUveCsvSlJ0anhVWDJFVjlnNjQrOWpMalp4bXJz?=
 =?utf-8?B?OUVRelUyaXdPbUhHOVIrcjdNMFVtcE53MXBqQmppbnhpM2w3RjdWL3FVU1Q1?=
 =?utf-8?B?U2ExU0QvbElzQkJrRE0xbi9sb0ZDUGVDSHp1Y2R4K083Y2xRdENwU2VFa1RS?=
 =?utf-8?B?c3ZIUnlXY0dOUkVoU2llU3pkelF0a0JoQ2xYZXltM3lEanc3K3lGRXV3MlNi?=
 =?utf-8?B?YitIVmw0RDUvN0dQV2dqVUw1dTc2THI5cVJSemhvWlZYQ0thSnpGdlE5ZUJZ?=
 =?utf-8?B?N2VEU0doMnlOL2tucS9Od0hid2d5K2xOSTFIdmI0NDZ6a0tpcDByOVQyWlow?=
 =?utf-8?B?M3hIOWk4VWoya0NTMTNNMmFnU0xhdFM5VjNpaE16R0hyS1pHeDAvWGpVaE9q?=
 =?utf-8?B?UFZrZUdKdy9sU0ppTHI0dDJSQkpIUWd6aVVBaEV0cGh5MFR3dHZQS1FOM25D?=
 =?utf-8?B?M0FZNFd6TVFJZjI5bk52TnBRZnlVelBWdVlyeHJmZVRlZG1COS8zUnNlVUxa?=
 =?utf-8?B?WTI4TFh0QzBPSWNCMkx3VEIwV2ZVcDFBajRmNVB6czZNdDZST3BZR0svam1v?=
 =?utf-8?B?SklHNUphSitmd1hGaDFLeG9FRklGcXFMb1NUL1NNTWR1UWplbTVFc0hFWjlN?=
 =?utf-8?B?eEJmN2NkOVh1TXlWMXpjUGVmekJTNEk1cjVzY1BTcmJPKzdQZStvWmFSOEFR?=
 =?utf-8?B?elY1QlBIRHFVb0U4eG5uQ04wMy93Ymtwa3h0MEc3c1ZxUHJQMUNNSHRER3F5?=
 =?utf-8?B?RGYwK3NET1Y4U21wN2M1TVhjSVo2YXI0R3NHK1d5QWV1Yi9hWGFiNHpZcW1w?=
 =?utf-8?B?bGVVVkh6cGN3d3VrU0VjdWlkMkEwN2pGUGlpOU4xTW9yaGE3aks2anN1Q2Fi?=
 =?utf-8?B?V1pyQUFybWxtb0JGQTA2c2ZpR0dmbzdWdlV6d0U5Vi9VZUZkcHJqUDUyYXJM?=
 =?utf-8?B?RjJXVUczT0F1UWh1bGlkRTZmbitTRmdZUHB6bzRMMUh6aXMvMDJxclhJV0I4?=
 =?utf-8?B?L1c1VXBhYjZaUTdUM0dKQTdJVkZRQzEza3RhTEcwQ0w3K21GaGlseDlYWEVa?=
 =?utf-8?B?M0xrTkg2ZXpKMEhBRnR0ekJGMmN4MzYvcXl0L2V3eTBVbllVVm84TEMvWVlB?=
 =?utf-8?B?SjZIVDk0b0FJRkV4ak51K2VJREpMNlFuT0t1am9DZzd1R28yTEhReDlUZWFj?=
 =?utf-8?B?aGkvRFpQU3VrU1VzQnIzdDFlWE4rbUFqb1VKa1BPeXZQN2tlOVdhR2Y1YWJp?=
 =?utf-8?B?QkYyOVRaSmh1VUFqQ0tqWnNRNmZHZENjSG1hRmY1U2QrcnZsNTJLMlhNQWRL?=
 =?utf-8?B?VXpFZGF6S3hyZXRPOWVTdVAzQW9aekgyNkxCbzBFcDhycHlXcHhHTEhMZU5P?=
 =?utf-8?B?LzRkblFhckhoZVlod2MwT3dkYzZ3dWNCUC8wZ1ZGZHZSeGZEYWFRRkFTRk9h?=
 =?utf-8?Q?b4pom59nfp7RETaYAZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7ca41d-5a8f-4aae-651a-08de64cb88ec
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 15:30:47.3876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OD6f65clztOEWKsxjv9TBp6RDl0+SqaFnrs5nYiTpkohM2caYvpHE+Icj/n8KEi7GSk02Vkal9QGPeUc/XtVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11275

On Thu, Feb 05, 2026 at 10:46:05AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Feb 04, 2026 at 10:21:49AM -0500, Frank Li wrote:
> > On Wed, Feb 04, 2026 at 06:03:55PM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Feb 04, 2026 at 06:44:07AM +0000, Sherry Sun wrote:
> > > > > On Tue, Feb 03, 2026 at 09:56:07AM +0800, Sherry Sun wrote:
> > > > > > Since describing the PCIe PERST# property under Host Bridge node is
> > > > > > now deprecated, it is recommended to add it to the Root Port node, so
> > > > > > creating the Root Port node and add the reset-gpios property in Root
> > > > > > Port.
> > > > > >
> > > > > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > > > > ---
> > > > > >  arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |  5 +++++
> > > > > >  arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi         | 11 +++++++++++
> > > > > >  arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts |  5 +++++
> > > > > >  3 files changed, 21 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > > > > > b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > > > > > index ba29720e3f72..fe9046c03ddd 100644
> > > > > > --- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > > > > > +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > > > > > @@ -754,11 +754,16 @@ lvds0_out: endpoint {  &pcie {
> > > > > >  	pinctrl-names = "default";
> > > > > >  	pinctrl-0 = <&pinctrl_pcie>;
> > > > > > +	/* This property is deprecated, use reset-gpios from the Root Port
> > > > > > +node. */
> > > > > >  	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
> > > > >
> > > > > You should just remove this property.
> > > >
> > > > Hi Manivannan,
> > > >
> > > > Actually I have discussed with Frank about this in V1, Frank suggested add
> > > > comments here instead of removing the old property, just in case the dts
> > > > used by old kernel to avoid function break. Or maybe we can at least keep it
> > > > for some kernel release, then remove it later.
> > > >
> > >
> > > If the new DT breaks the old kernel, then the kernel needs to be upgraded. But
> > > typically, one would update both kernel + DT or just the kernel, not just DT.
> >
> > But it should not impact bisect. Driver and dts is not in branch. If driver
> > applied ahead of dts patch, it should be fine to remove it. But default
> > linux-next can't guaratee the merge order.
> >
>
> There is no need to worry about the bisectability in linux-next. You should only
> worry about mainline. So if you ensure that both the driver and DTS gets into
> the same release or even if the driver gets in first and DTS later, you are
> good.

But the sequency of dts and driver shouldn't affect existed function

For example:

cleanup cpu_addr_fixup() patch, which require dts change first, then change
drivers.

You required keep cpu_addr_fixup() function for a while.

>
> > To avoid merge complex, keep it for a whole, then clean up it later.
>
> There is no complexity. We do this all the time. If you add a comment like this,

It is not true. When I try update dts, rob and other reviewer require keep
back compatiblity. If policy changed, please give me link, so we can
follow latest policy. Actually some other system start direct use kernel's
dts file, like uboot. It is not very strict for new SoC, which still is
developing.

> then you need to remember to delete it later, which unfortunately won't happen
> all the time for us humans :)

It is true. We met similar case many time, like vendor property, fsl,abc,
but common property abc appared. we still are required keep old fsl,abc for
a while.

Frank Li
>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்
