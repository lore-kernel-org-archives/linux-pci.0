Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBE03803EB
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871350; cv=fail; b=P0HI7CeQ8lxBAouF2imZuoC+pOhyJvv39zT5CdKO4u/tLjNXkXHBelNfxWFbWq/0k6UNmIEARA+JARh9nNTQ3rHKiBQaxRoPVJhtyZrST9jt/wrZe8VOpNdHqj2rYzFKnBW4WSkDgmc6OymdD00MivTtgYYXrkAozG70v0Tnknk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871350; c=relaxed/simple;
	bh=d9kZz61VR9SLJ9YHX/CsrLfqDosnky/zNhxodyRxeOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SUVJiJVRrDTC/jIxyAfk0JIDFDraP4S4U96PMEsx89MUhXiBBUPupEPgpXlG2Sl9XhE5jfgt1qip77dkxaWiOo+jhBs6+DzNSAnsGFEMdpPKImoM8UtmURoUB7Ouz9F+NzBqg+0uvQiEpLKiEJVFMrVtqdVrr5iuOo6tpQVTRWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NIqxsNAv; arc=fail smtp.client-ip=40.107.209.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NIqxsNAv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIPUxkiJuDJba32Bc7AJCV3u3B162VTZa/fpUHFZEHF+gR/BynVI2cqNr3/zSJTbO4mwmjQGc0eSV8R1fL3029dBQspjXuwT29Hz8apevo87LTNrCzjsM+rEFV2Hh49oUSiisiNMdKwBBnb1gGWXZgCegNZAH+hPMG3J+4jgeCahawxlZsDMJ9Fyq1BwOMf8WSkipKyPNN9MN1sXcjPF7Xl5t+u9yqn7YO98sI3W0YIIf9oNAa2LSwoGdA+XiswrMrBqUY2ahyoyqHQelhEgSuiNgrVeU753I2YwVTdNG4MQcg4BJ/scW43OtWgqv7mOJ0jj2TzXMfNZ3gm92YG0LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9kZz61VR9SLJ9YHX/CsrLfqDosnky/zNhxodyRxeOw=;
 b=hyDg0872ID0E3MgL7uuqVJVA6r33p8QQuqtM1lZUeLtGvQayrREHLOJZOFMDf7Vj1PVA/q8TMJgi+PvyDIVf02UTEqD4ENAADTAlfYW5qZiEDhupTifqeBdC3IwSAj5qaDr62LxYUs/i5KZb1Zgo+Bo2PRQTUprh7u2+nkcnHvBxS6tXpb4ieYhc14XYps+RWMGEiEBSKOxxhNw9RmKBZ8zeHj/EweSFSumOGO+yAjocy9PO2iWP+M1NGymTXp4oWB6CGWyjK9bVlvjOyO2C2TCjoLfphvyuA0ZzzuP8mkXQ/tZ+qVbHoWMyh2fUY9H8cTEy/Qz9vLmxGE/m7CbfvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9kZz61VR9SLJ9YHX/CsrLfqDosnky/zNhxodyRxeOw=;
 b=NIqxsNAvEgKVx9LPcLBv6uTALQUSQS4G5/yjx20VtzV3L21+gAAJ0uJzPncCt4Qq59KU0JoGmCqr9R5xi1Pz3v9J5kovlnPDWSJ3kEGneXYogs6ur9N3AnK/ljV96IfkNnmqMC5xdxK2gRR+CVYmDkc0v7ceOZuDD093ilyzYIx5DPWPSYLWSiBl7Y1IGvCaHN8v5w+zPEoCkm8P+cb7Rk4U1L/ShKyZZWU0oF97sMFvhHyXBdoMDkdnIMr1COaL7T+tXstSOGHRcWVht8dESQTf/MdgobhX/qD/Cm3yDnR1vvR6Nz7Z/JvDVo9Z/SN+nx2FYdUz5Ud9wwww8d6QPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB9122.namprd12.prod.outlook.com (2603:10b6:610:196::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 11:49:04 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 11:49:04 +0000
Date: Mon, 30 Mar 2026 08:49:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	bhelgaas@google.com, alistair23@gmail.com, lukas@wunner.de,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 09/19] PCI/TSM: Support creating encrypted MMIO
 descriptors via TDISP Report
Message-ID: <20260330114902.GA310919@nvidia.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-10-dan.j.williams@intel.com>
 <yq5a4imuanoa.fsf@kernel.org>
 <abPlt8oNUOqGvbA3@yilunxu-OptiPlex-7050>
 <228298b7-76bc-4ffb-bec0-0c35fd487c4c@amd.com>
 <20260323182014.GR7340@nvidia.com>
 <fa1c6e1e-068c-46d7-a623-58c225bb03f4@amd.com>
 <20260327114921.GL67624@nvidia.com>
 <d5059386-1ed1-4110-8283-16e3a8407760@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5059386-1ed1-4110-8283-16e3a8407760@amd.com>
X-ClientProxiedBy: BL1PR13CA0400.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: dbcd6072-a343-4cc5-5bca-08de8e525734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4xAv9TdQ4sPrN/JELBRhSufw/oK0eneHWJJg4+zAG9+b/fOZTsYk4otTgCjK2xUrztzS+YhbqqE1dHBi68PrWWBAO5qUvHog1AKzU6GAhGbyl3ugIvL+mehcwsgFnr6Tt9g4vXXtr05D9qn49SS+vtRiCru9hE2Zjly7p1dkY4Yg5MUbXFz/70TxFN6QTDrZIJfoBFAk9/MJp9s/nn43T2JOAwfQ1a1twRJ/pxsbsCBCjbzKSGVWoshxY/M8RgfomsWt6rWWVNHlDeyciashLe3rZ5S6po9W0+yWtFGVyzcX8Irl4HipbWRyv0ARY1zyIccc/wNOSSbJsBRVjUQ+F0199Qp7WjWD6nCYuylBJ6MK7BgXWg6kZcACAZNIOv+118xeHI4KK8xgMzOm9ENKoiqPt0GCpfZwThcLK/qc04HKH/ARkbhwsvd5X13X4dcC73kdl5dj94GXz2KyaNv5rKb7e1MwSzNRxIf5nHrPzPAWFDk2Pp7bNWG/R9jp6hZWu1q97nrzagERy20Hanv84gdBzABFuZQA7bAPAPkrLRbKg1zOGPSQcvW9EZdKksNT+yLdoacbEXjrJUjDg5hKnLxI43qoZ9bz5ZXzuFwv5CMQbOUZPYW1+Z63Z7WiNWHHcr2CsbIDnDq+wvQQx5qmiVZ0JCWotz/lJRPnGui0p0EahmHy14oNRvkKrTNwqF6E0/jqTU0/nfotzAvIGq5GUBudsxVwCJzrSw97WeYEgEQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sQvSr1TF2E4Pp1+szJxmb3+z+aYbM+MdQdoNA2TB/iB/Vix3GwlxC8KS10L9?=
 =?us-ascii?Q?VzQW28Zyh5+26YiV3madSNOlqIFyHGErJIuLReYimmzpmBBKBrW97FP627xK?=
 =?us-ascii?Q?dTVHGbwiY+pwy+MNcmpo1D1UcwbTTwmI/9MjgaXRHrBNXSPO20Skqz5t5lHe?=
 =?us-ascii?Q?sRaEVpM1L1VKXxf/cP5uonPNs4w/X+2mekFT7Pb3SkqYy+vksFLmyzxJC04m?=
 =?us-ascii?Q?+OyHpD9cQAE4oNmbK7hHtE4GuzJ1JTrWdtAjBJbLR/9zJaY1OC0iISm6XTp9?=
 =?us-ascii?Q?1obbOIG6PP6JEOwV2l+ViPwnPoivl4NHZNXJ6Nusk3g5z1Gife3gSa27t00i?=
 =?us-ascii?Q?bx2KEISl8/ALi9JqfDKo59y5RIx0BlFwr6x8LyGnVVuQu0g6K3WRyRA1TwED?=
 =?us-ascii?Q?UDVBbkg/24Bo1PRMLd63TM+CpFyhyY+uwlB+I6Q2UlNIBdAzCikNd2YW/hdd?=
 =?us-ascii?Q?6kgsNUmy4prlkw88ObiCP6aMM1fsAJkHRZkMKwtZDWR05AQ5pFQjREmudDgN?=
 =?us-ascii?Q?rymIKdkKqUEs72VLmiEpTwl6OEy5DNSbpSwLpRLL01mOVSFEX0uGO3j78bZn?=
 =?us-ascii?Q?XmcdYE3PFTBXDeH0y6MgxFYggW179Oeze1+70HmdgE6zL5gz0dLxZYudGIBN?=
 =?us-ascii?Q?58q+pk5tpKFexEDVKxddBcciuPRLznyTZVekLlixute63d8tVuRGfX/t7oOG?=
 =?us-ascii?Q?IFk/3cCJX62GPaooYOwwPl5waSCc50qbZHtjnt8o1u+WNpfi0sldqGDaoMQE?=
 =?us-ascii?Q?3e80nNN7vrfWvBpMN0HcwyDAsYi5wmiieVUg1yapNBgApsRchHVJVupdGFQA?=
 =?us-ascii?Q?ZyjSzi4sfThpMYv0O5ROrkw4x6YrCOlr5NJI6RoC7dfU+2OH/0x9K+q+F8s8?=
 =?us-ascii?Q?eFnVsZlKdrPK2UtDMtCmp+iaY8VOWYRFZQk8Wxv0hBevBDlKu7dYRUmJS7RP?=
 =?us-ascii?Q?ufZXw7YrwROm/47MOaWzZudRFi9q5DZqkH2B2tTo9qIXBWY6nuAxc0xXsbDZ?=
 =?us-ascii?Q?Ihmc5hZxE3dYMe+uGI3Pt5nbXcahVrMIoM8c9fDY87YDt9uw0ZSorCPHPWiI?=
 =?us-ascii?Q?+P6kraO5IVENYTEn46zJ71oc3L+N+rOiXGqAmUZF+IsH785lTy5cIdY2Q2rU?=
 =?us-ascii?Q?MQoT1J4x9SwhhWL4oiLQlKo2Yz21iGtqtiJKxJxwsP2/DELYuJErXwz5Okfg?=
 =?us-ascii?Q?YSm0Dh8j9Xe89p+RWb44bY786KsIYKp0DFNjIeJNhWERZVtM2a2QTAzOXUZr?=
 =?us-ascii?Q?SoyF+bBoJV3pDBS0oz1yTY2JTgprAJpLbuasMwITxCaJ1PTMmcoj5xO7bXv7?=
 =?us-ascii?Q?3X46YQXQlcKsQPWQdR3aZBH+4ccEFTFApFnLtBqqQBkkVECEl+P5qsmohO3S?=
 =?us-ascii?Q?A654VGzTviBhQC7oTbfPSreFvhNQDWKeALkulh6eegJoX2/U7B5VAZ0RY/gF?=
 =?us-ascii?Q?tzrK1cTuc0UVhW08jnL9k4R3CpUGclUEXyGUgB1Vjzs+TimlcZZVivqouRN2?=
 =?us-ascii?Q?ejDaz4gXIl5FuCPYnoCuc76kuJFKm4C/p4mwB+cxqj/zqDsj0OKzt/kCwH25?=
 =?us-ascii?Q?BJJQRbxUZMQXkCVYn+a2G5xdOtVI6qINJE1rz912o+Ls83ITGu7GKJdPiReK?=
 =?us-ascii?Q?X6xYXtVWw2qR9J9o8iDDsrqtmYteMaFLDw0lr8jsY/TF/VLE6aIp/m/XqSe2?=
 =?us-ascii?Q?8vfiHBU/7CTIJWJU5iXSXVNnocIcjNn+/bQ+Bl85oXzuf+9/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcd6072-a343-4cc5-5bca-08de8e525734
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 11:49:03.9851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzTRyeuaozr9px2EBpo91T8pqUhYNgjMdgeLmGaPfm1TrQnXVAcNHbRXmFErvHXD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9122

On Mon, Mar 30, 2026 at 04:47:44PM +1100, Alexey Kardashevskiy wrote:

> What do I miss? Thanks,

You can't tell where things start so there is no way to relate the
offsets to something the kernel can understand.

Jason
