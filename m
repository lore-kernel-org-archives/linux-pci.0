Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81C21EFFB7;
	Mon, 30 Mar 2026 02:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774837055; cv=fail; b=FwOUW4NsIcHETjMtz8W6/rqEjVlcZ+7q9bDUgJH5M69pZRAYPEMUHpMln6dcUmCl8LauP+4lM0P6qZokTHV3uhcMR8rSaBsFY9zm3qJ98X0jibRRWDbFL+xwPTood2uwxiE6D15Gq+O/NcfFkf6zxciehRrRrgVCE7uM8n3010E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774837055; c=relaxed/simple;
	bh=1+44ff3QvcWaZ1TSmUuTDUuy1XtVV9sFpz8Whrjz6XE=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=KsOJ5dD9Ot7GvRPX8lRclLKVznGZQEhe0qt5oXjp5BUB8KmEZAy+WStP6T9F03+/Ug8jfFVKWvqkjDuseTeZYIplU/teKHrTFZ3QpFq8gHjZuUEsG7xyuML/NCL1HrjnEfyKk3VnYPtY757RjiLHNSLUoLl8zSdOG9YsKIrvpLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Iwz4b8sL; arc=fail smtp.client-ip=52.101.62.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Iwz4b8sL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlDhBr+Dq+eQpjYKeLuSwWNnJPdsijeESspe20qQSzrepC4E+0GIT4s8nH0FQhgkld1vzvcU5uMaL1ZKc8aVrDCrhjWLPNauYoiB1c7/1q3QH5DSDAiWCgxccVGLpYDQnUkFDSHJ1pWolfnWJRoTpi37iy8ec3DuGZXYjSaTuV1Nz48Cwo+hxWdsLofnZHzsnGk59dx+fDfeFwFP8C6V+gNqcI0C5VFHHGNzSH2Wg93kuJQbvhuAy1g5AXOfcY2h8FpPU9s9BtcsK0I2hjrVOqbQkaunnS+e/79L9t1DSMWtH6imNsMveyZGOIIoTzhbqXwQz9NU4TpJSUpJwxPM0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6qG3+YCcpM4p/0C0hnFmBoJ6Ec70A3ITd8yema5bo4=;
 b=xUNsFY/q7t5IuZGamzazVRsP35S8tADRaJVhY5eF+6eCj5qVd5XJyy90kwnTd4X8uqNdFg9FiMBFKxm+l99aim0tK4FOpujGk94seCnnjnJIKxj8ymo6VfP07XFtsZI8Mfb9GDfW7NcHuisetg+jHBCQZib0NV+ajEajDUYhnByj+4eZenp/AvzYpmY0IOXX/3avY9TWvRPhzUKkwjNP1PYayzUljSoli1/Gfd3F+jqDmxmwWx+zXup/4tD6Shjfi4lukhxGcEqqgCCBxExa4uLOQRhCh2yvtp7kOsZrjbYDhkE1fwokKNDankY4pXoaRA1r1EyO+YmQRNVi6sPbpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6qG3+YCcpM4p/0C0hnFmBoJ6Ec70A3ITd8yema5bo4=;
 b=Iwz4b8sLPWctqFhGQ3GhNrEIPObfx9ov3hxGlTl//i2OOOUxLjhxOdZmBSjdWxK/SlsGkh/3UXqhQOpvnv/HYL2IB8GKT1KfzTX3XtV5Q75muS+4RrfqLhevgC7rESYhFlIUIZ5n0PSzq3vN7fMlEXFMS19ADiRn/flqel4gxw8i0wbPh2IOqtdU4IWXGeZoffrAX8tqoJCs0elY+5Bz4Y8607CF7Y99eI1uNh5xsOBP6BZhdjceDpJQHEJ8oWUrbxwFs0oSszT7NADoX6aPKpy7p2GyKX1zxqm0C6FL6nQwawpVI0egGUuZBgxSvrwq4i0Le0YeHb1CB0xDTKQ/7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 02:17:30 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9769.006; Mon, 30 Mar 2026
 02:17:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 5/6] PCI: tegra: Add Tegra264 support
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jon Hunter <jonathanh@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
In-Reply-To: <20260326135855.2795149-6-thierry.reding@kernel.org>
References: <20260326135855.2795149-1-thierry.reding@kernel.org>
 <20260326135855.2795149-6-thierry.reding@kernel.org>
Date: Mon, 30 Mar 2026 11:17:16 +0900
Message-Id: <177483703695.914339.17915071896858286824.b4-review@b4>
X-Mailer: b4 0.16-dev-ad80c
X-ClientProxiedBy: TYWP286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::13) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f6c2b6-b6b2-48b4-6118-08de8e027f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bm86FC06TAZCU7AblKEnnxh/sy3lPWRgKsXl0LJlQKE1G0+Bp1EDWR+tOltXkNsXhpjVpQUeznCmyIEkA6r9CDBkEnaEzTbm/SH8P9OHVtNea16ny9dYvrjLn6hPDjdYhmJeMjbmL+yVcY1Dwz1K4M6dno/3Oa9S3XSMrozMlKoWwJY8IvS+kFcerUHp0HTubkY10mxxllskik9pyThNNZIPJtrS1vynDWwWzProTkbjJMNx8URXzqcL/tDlI4lMx6L3ZsDDih+Om+zI5d2OKRQREnCTtKaMclivUhoXzZ7Er6WrDCLH+4y+765Wezjc3vbX7Q9IH2+LiHhmOVaPceUo0+cwGiNUhrTqA1I+on3EuB+NeCpa5m6XCU4elFNoqJ0QFJeaQKctY5Vgl78vWn6/L5NS7qNte8erM24O7m7nLyZF73CmMwaxkWcJhaq1RXQ3KkkqY+ERakbXutW/JxvM3tf3vLm1ZUJc0wWLR4zgy1JI0xdgUgc/Sz7j0s7cXkgWX7SlRI2oS9HvWYx3hxl0K6vmcIPmlj9Q32G8s3AtYH4gsVZ0yNw/0PhqpWwmIiobX7h1OrDJdesRyNKFrCo8NtIqXA5UOoH1X2O09ohudRsQNfTFoN8P3xc9H/ermjWlMWBNmZiGpLrSmFXeQj91+q/CLjfvYIs2z/GWFjv6cmEc02bFMArVyTWrBNeEqj9ekOPdFmCUfjcAZzRTpMXdOpVRK+b51W9ugpg8sZA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXNzL1JmSzJPY3Z4WklxNExYV0RIVUxmVHUxeXIxSmp3ME1ac2lLZXlMSUxL?=
 =?utf-8?B?S0V2Wmo4RnB5dXBOVExDQVhTZUlkdjNDaU5FZnRveVhNQkdOUU5qMEVPOUtn?=
 =?utf-8?B?RUowZUQ0OGxjMUo5NXp6QXI5UzFJY255bitqRlRKaUpqOHU5RyttTE16OGJJ?=
 =?utf-8?B?VStxUm1Qb1pVSmMxdHZWZ0pxR0loYWJNQVEzSFRiTng1cnBYc1B6Vll5VXBR?=
 =?utf-8?B?TXFaZklHb2pKRkxiVFV5SCszbG95bzgwQWh6b2JsMlNxdStUd1BXUlduT0ph?=
 =?utf-8?B?cXRaSnlIVGdDeUs4amFzdndZWkNBcGp3Tm1qek5acHpOYlNNdGVLUUVFUnJX?=
 =?utf-8?B?RHJWV0xabEgwU1ZXVC9TNVkxMGFyMzgydU9Vbm95SVkxenRDajJSMDA5Vitn?=
 =?utf-8?B?QjRLcXNPY3BGdXl0Z1RLTEQ3eStYd1J3UzNYNmpVU0lDWEJ2V0lwRjcraXRq?=
 =?utf-8?B?YU00bS9SeUVoaWxOSFA0cWNWRU9kMkxUUUFWUC9pclFMSnVwajlxR21vZnYy?=
 =?utf-8?B?dGp6d0VsUDAwUzB1NGVCNXk3T3lNc2h2TFpQVktJbSsrYW1oNzMvdE1ZbnI1?=
 =?utf-8?B?K0VhTTVSU2hiOFlraHovRlZGdXNHQWtZU1JnY3VPYlVtYVhlR0FoZ0xsZ0hl?=
 =?utf-8?B?aDI3NC9mRTdBaTFiL3crdmFyQ0wrV2k5UWZSSi9nT2o0Ynpqc3p2NW9YMStG?=
 =?utf-8?B?QlJaRG1MM0F6TkREVE16N0ZNTjY3SDRIaDBxMFdDVFdSUnBUNTZEUmxUTTF1?=
 =?utf-8?B?QmR4UEdBdXo4ZVB4MmtIOWl5cnY3TWh6UW53by9lYTZMRG9ocFdBd3hyU1J6?=
 =?utf-8?B?Y3NkSFF3WVJjc2pZRHpsMnlyck5TS0grUlVKZE5aUjNSWWJ3OTVaS0RJRTFq?=
 =?utf-8?B?ZXhaa0RHRDFHTjRqT1EwM0NqM0xRTGhmZlFCSXdCTW0zY1U4bXJXZVVTZmFr?=
 =?utf-8?B?c254VG9tUW5YZWcvK0trRytTWU4rNnRsYVJZVlJ3bDdpU2hYZXpId0o5TmFt?=
 =?utf-8?B?ZDlyR1RXeTBzL1FCVzBnNThkcnllR2ZTelZ6cXJHc0lhMHFNbnh1NTZuWUE0?=
 =?utf-8?B?TmtBTHd0RCtyeUlUbE9IdmFJWjhTMUFzSEExWEQvczBNNzhpcVYyNEtTaFhF?=
 =?utf-8?B?c29MTnVCTkFuS3pjdFpFS05vVXRiOUdZVVZ0UU5kaEg0VTRXT1RCSkJTZlhE?=
 =?utf-8?B?YnRmNHpRVmRObXBmaURwdUsvZmFLSElad1ZrMEttNGx5ck5WajZoL3pScDZN?=
 =?utf-8?B?K1A5ekNyZDlZNWxYMWRmb3FoTEgvTlRPTWFCczV2cjh3U3QzVHUrSFNJUk9V?=
 =?utf-8?B?M2ZRQ21XOU5RR05wblRLVXJKWkxCMmJQeDZyNlVMSXV0UERLekQ5WU5RaWdC?=
 =?utf-8?B?TGVCSENGZi9zeHdXODQrZXFua21OWVZjRDBoRjV6TjRwVFd3aHV5QTBqQ1NX?=
 =?utf-8?B?UVNpWlJkTG1odGMvY1hBaHJVRXhnc1g0WUxKMkwybXpZdm9XRGQvejlvbHR4?=
 =?utf-8?B?QzRNb1I2YlA3blpIb2tSdjNmQUdZdGh2TUVWRk5heFlXa1Z3RXl3SDNIUkVS?=
 =?utf-8?B?WDVBSVF4ZmVWZmNnRzRLczlBeFJjVEZlVzFLdXJUNThBdG5RbzNxQ0I3ZWQ2?=
 =?utf-8?B?cWpZYmpINE1jbTV0V3RaTXFTNGZMY2VLcVVpTmpCWUR4YldFR2kyU0tZenJv?=
 =?utf-8?B?a2FwcGRhRVJWWnp4MU9malpuT2p6N0ZoanZYUU80T0s4dnNmL0QzVzZFbzFW?=
 =?utf-8?B?b2pkOVFoWXlUR2NwaWhyYkw4Q3RJNVQrS3RUcFNiUm1vOThCWkRjUmdFME5X?=
 =?utf-8?B?N0o0OHZKbWNOMlpUb0l5MXpsaGNrUkt0QzMxTEpySkpZLytkMVYwc3dORE5T?=
 =?utf-8?B?eEFJYk5MTHJ3KzVnQThjaTFLVkJNb0lFYnlFTlJGakFJcHgwRmNLRGFZRnZs?=
 =?utf-8?B?SzZVZnlNNFExNDArT21jZUdteURWeDAvcU5RM2w4S0djcHpOTW9PcTZLMzNs?=
 =?utf-8?B?eGxyUUY4cEs5cEtVR0lzRHVMVDFoVEZKUjVFSzYyVmhHRE11L0dFZGxQcDYz?=
 =?utf-8?B?cGlnWks2WnplVTM4bWxQbkpNZlJNVzdseVBTTTJOODhMemQxeDM0VlQxYWJt?=
 =?utf-8?B?eURkbEhYRFNUYXYvNDNhR1pTN1ZXTWkxQzhMYk44emErc2FKSGdNM3d6RHFM?=
 =?utf-8?B?TXZRTzMvN1V0V2sySWNqUEdwVEoxSVdRc0NJalBlVWpTb3BSY2QwLzd3ODBz?=
 =?utf-8?B?dTYxdEVSaWwvUWxDc2kycVJVV3BrcnhTNWhwRDhVSStpaCs3N1oxbi9LNEt2?=
 =?utf-8?B?ZytQZmFBZi82a1lybTV5NkZieGpicDAraDNMTjVNYm1oaU5iaGhCMHpiYmFJ?=
 =?utf-8?Q?oaghEo6IqxaJo8veXqmKLuuvJhbQRvsGDp2lyzCh+M3Eu?=
X-MS-Exchange-AntiSpam-MessageData-1: aNdPrSxJpZOqNQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f6c2b6-b6b2-48b4-6118-08de8e027f0f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 02:17:30.7062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3u+9rKx0NzKEsuz3yDontvKTH/e7zqR6cZX01hRKGCB9yu+cBvTzT+1S0tL97de7I34fHfQ8rRuxiT40v339SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996

On Thu, 26 Mar 2026 14:58:52 +0100, Thierry Reding <thierry.reding@kernel.org> wrote:
> diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/controller/pcie-tegra264.c
> new file mode 100644
> index 000000000000..21872797e41a
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-tegra264.c
> @@ -0,0 +1,522 @@
> [ ... skip 137 lines ... ]
> +
> +	value = readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, value);
> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, value);
> +
> +	bw = width * (PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]));

Nit: this now has unnecessary double parentheses.

-- 

