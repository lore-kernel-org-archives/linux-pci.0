Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020081.outbound.protection.outlook.com [52.101.229.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF052DFA46;
	Tue, 17 Feb 2026 08:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315577; cv=fail; b=GUxGTzDI1biIUTThZoedBxvFruWUf0TCnoQk9HyQmEsP04fnDzZuRe2C/q4KjHnk2Tkuq1iT0uDKyRZqPpjPJS8No6IhgKya8tB4d9sfU8IneAZKoZGnQMnqwxbK4Dq9YQI9OMf7IHpeJBQ69f/+NyEiK/a/JkZ/FC9N5l/eaPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315577; c=relaxed/simple;
	bh=yYPpkjnhy0ZFLQ37LXaMIFbOH9NQvFdbcGMcU5dJDEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EbAJVv3HBXGY+53SGwVza0Wxd4TpcYi8bXs26YGYCWf5B7q1bmxGakc4l8awZP6CiIXllOhce187XfHqw29Sy7acixVOjsERpSsGep/qJs/Tfn5M466xXIzYoBwDxROgAa4PjMPsbZd+rhs7lFyAJA4y40oJRdDccdy2vbOyHaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=MVPiGLvS; arc=fail smtp.client-ip=52.101.229.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="MVPiGLvS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QL9Lz1375IIP+wkNYYVb3i6tPli5zTFlMGKAt0kd+WokrVdNygiGiuX+OqtPd/yKD9uUpybjr/EOLCiA4Zso/sHgvfYvSum4KRUWp7n/yM/6sWCpcXy7RwkGcqBsfl8skM6DrJsb0vrBnpZJZdGhqTMumLhEpQ/JQsGonfz1nPbI4q3pCDNtjCxL1LsZfo5FO5G9LPySEVgT5mPfQdDgakjTR79GYGvWB8fI3SiSMkqwsUOPABGC4UWpvlw++GyP25fYVcUcZIbjoTE8QgNZPMwkyEhUYck6ib/8PlRUfTWAmd7CZEkxAIU7gUnLdraSGtt7GkddEaabUSrQWsqPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpMBWHmKo9m4Bn5DsWqxUnKAG8hRFfAVV32vx7GzjJU=;
 b=KpQujll2RhgOKuAhJaKPMVEZJgAztoBjT6rECcw5SO1KzbjaiG98BNQSgdu3WvlkuphAUbIY2dKgDHmd0KvuMs+Fv3Xru9gEfNrXBw7J1MbWVZDh0sQAfCEk9Kq7EymIgy2/Mr8/2KNPf9BOPhwPw251hCfex5Zh18IhpTOdEMPLVQKwedNzoVhR5aUM6pQzZ7ZQHylh/c/NJU/fIJoAIo+6ZJ1H9ojvXXcRj/LWDUPTPbHjlnXS4c/qRgXrfX9YI20RhQaQOu/DXdO+MY5ydZSp3HjHgN1w6UMaAfkWn7Rrs+sQNXNHUEOYwMycDCFpasMam4oZodCRz7E87y7Iww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpMBWHmKo9m4Bn5DsWqxUnKAG8hRFfAVV32vx7GzjJU=;
 b=MVPiGLvSutXxpQYmijscGMwLAHbgqTDOuJfqQct7Ymk09jAKoun3wsl7TF8fLKnV/IIbT3UVxSAlB6Vtqp3GsEmjpCw9PbKCog75Xmnkuf3A982OaFe9kCJ/b/0q61tYTtAIyzhSLyDBig27AKumFlBtoPZpcs/QiLpjqrg0o5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7132.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 08:06:11 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 08:06:11 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	heiko@sntech.de,
	kishon@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	shawn.lin@rock-chips.com,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	ntb@lists.linux.dev
Subject: [PATCH v8 4/9] PCI: dwc: Record integrated eDMA register window
Date: Tue, 17 Feb 2026 17:05:56 +0900
Message-ID: <20260217080601.3808847-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217080601.3808847-1-den@valinux.co.jp>
References: <20260217080601.3808847-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0006.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 89a3fd3b-c1d5-4f71-54c8-08de6dfb699c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DE+ftTIR17rrqE2+BeJGrTDt5hyNI9yoiT2LD6X+1FJIH20pga2uyBgMiuMm?=
 =?us-ascii?Q?eMiIkvxvMqIkGiCjHo7c1xg5vwyhC46F6a8CrQhZpU6h7VWrCZ28SEPU5AmL?=
 =?us-ascii?Q?gcIECpdkGDiCTxVJIWbODsOwRxFqQd/W4xoL3EPJz+fxgI3BgdtJY4LUhFq8?=
 =?us-ascii?Q?FDJ2Qx7VG7T+xtCEQrkCwgokfaUHu+ri+VRhQTannLkyK/UAFF+MCw0G1ei2?=
 =?us-ascii?Q?J4K4aLvHBFC8nbi0+hNh3j0hGQF1NkO/I/MTgk86NNc+nNZ+bPimkv1oV0uR?=
 =?us-ascii?Q?aJx+XKwFZtHHDuv9jFwXuvCs+1rhxJuDMfIdeJzLEGQ9u2OiVLBcAQucdGJS?=
 =?us-ascii?Q?UdtftDbm3GDNW/DfUeW9g4FGGPiXXAjMYl5nY2OWW6ToXl5TwJeSTSOJhX14?=
 =?us-ascii?Q?QxOyuL8Z4cPjNphnIIqD+SN31GjOslHanK8uKGEkOqWPueTIi1smWelf6CmD?=
 =?us-ascii?Q?rqmR0rtDOw2nWZbL1WrEaqU//NLS3uyVUoXwqvB46pDFM84wyUdOIpVuq6nV?=
 =?us-ascii?Q?qSK7u7QUvU0IKF8ezIxFZxBHhZNHGQb45KYESHyggVk/0Xx0zS0PgCG46ios?=
 =?us-ascii?Q?25JhH1w92DB+kwqBAPVef/kwhm8GkyCOVWAfs1+hg45sYPr0IWkO5Mg3xNXE?=
 =?us-ascii?Q?e+KQnrYn1/0+vpGjxAJX1GPCPmscGxqAdFSX+sFZaEpSjtO7v31y1NKVdi8b?=
 =?us-ascii?Q?5muWcR84FPmFflZkglDaH7+9wmnAQFRHMqRg8u/nIVCamHGUvc/5FlCtJ+D4?=
 =?us-ascii?Q?ajx6XbryBQRNrlCNYpRfISaLymJW+6ODmPRXjlSEH6f9WP9uXXzqWYoJ7EUq?=
 =?us-ascii?Q?M5twMhRaukTJIpD2mKEiQXurkpkuDqp5BIScABElq9HzLdjZIRQOyxmmPjYM?=
 =?us-ascii?Q?GTzmhdnJwUekb1UgAe5bTCrjOqzlvUPkuDI0i4KGdB21Q96fqS5VXt28TMW/?=
 =?us-ascii?Q?Tp/Qzs9fwozu9U3qxIMce+2p8V89sCdj9IikBNMJHHpCfvbY1C/bBHbwZYAB?=
 =?us-ascii?Q?zDjqjkWubdGZ0WqQqJktiam1mDnZcFGtr7GekPIBqR4QieYvC0NvMekk3el/?=
 =?us-ascii?Q?Zi+iqUuZwBGowr+CLT2ejq8h/U7OxOEQGyhnHExu0/7xAjsUYbiuLCuvwTXy?=
 =?us-ascii?Q?eNOrbuOertH7a57JLFlNs0sWEyyvWppJE3TScpjQqF60bMpQ+BJMw2qUnZ8E?=
 =?us-ascii?Q?4Dn9NAcbvBF2SodUH836t+4cGc7rUntpm4rnIjlotcJy9Sc7OSV8PidZmEPz?=
 =?us-ascii?Q?Ig3blfNhF82LHSI6XO4kXC3wds/fljXAe2FiVreQ82gLitrNhaR6q1QxHDva?=
 =?us-ascii?Q?64xL57UhzEyQ7J8b/rjuCMCUDGeDHTi6rpz6ruWuscAYWPMdaM3q+MID3eYh?=
 =?us-ascii?Q?+jET3JU0K7VZN9pWqHwlHxYRHHwgor2bzRvfRuhSuF3n2bweZMFFge0Kbkwj?=
 =?us-ascii?Q?4/jgR+o9Wk6K7vnNH76xIkog9mjNIsE8zRQ9y0UowCM65oae1gTbU2hqxV4S?=
 =?us-ascii?Q?dwzvinCdfy0/JHcQlHTmzKq59bX+WqCpHXpbxWI7WiUGbOj4lE7vwlEeZ35k?=
 =?us-ascii?Q?phRHvIytkoYPs5XKy8vA83Zkitj54XeUt2TcqLH8zFh+mTi1B9BQaG9eGWsD?=
 =?us-ascii?Q?Qg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/cLQ4CwiRou0w6kqldxtUe03Zy1eNmmhnV5Qg0MqOCcg9Ar4f34P0yNvTIGW?=
 =?us-ascii?Q?K21igHU7QnKetlv8mEOC7A0EgKaScPxMMqZr7iutaKq6JSYHCXnMKEmp0dsH?=
 =?us-ascii?Q?2Jp3CRsKmCiUnrgr5VWnNZ8MGFvwWnFDMzJMQwLfNTOudAm8C9iIf6+7OqBC?=
 =?us-ascii?Q?6UdT2mgR85BUebpTQV69moVOWHzlurzPOPvhD1xU8iY6IXDx+zNr+UPqrU6j?=
 =?us-ascii?Q?gEP+Rpl8HCv4SIu5frsO68w731teOfIHaxrlc05FpDUyC1ZUiBf4krHz3wCJ?=
 =?us-ascii?Q?GF+h7YqKcTjZgRAmdaTXQ9T0/X2CHMmKQItGESYwuqZ/F1JuxOryVNZ58M2w?=
 =?us-ascii?Q?tgGigPwpmy439Tnh/Rg7KCnH2cwsUNN3HatHTH9DgMkI5uhVu8YUBE3j4oju?=
 =?us-ascii?Q?3PmK6pDkRnnHnasbi9ng0hbxTXO78SEGc7ItoouATBi3+GbuLD36O03qNgy+?=
 =?us-ascii?Q?o3iUm3w0V0RsBjSOEi5Uoh0LDE1MtWsNK0qQ15qkTpl787/C2bwAM5ZnCBnN?=
 =?us-ascii?Q?4QgvcHZVKmJhXw0ffLnJCaM4gkESI+5sWuzAnQQnGo/AcSRGW3N3pXZ+SpnD?=
 =?us-ascii?Q?zR0PW7jvoNJZ81yvUyLWwSTvJG/KF/TRX/CkDsyWVAB74gI7rJcVq86wHNZN?=
 =?us-ascii?Q?iRQE+WkKiqK1eliR+Bo6bh4areifFP2Li0+31JSCeH/yUkxLcpt5cs2uhsLD?=
 =?us-ascii?Q?5dgCqDD+7tEE8GeS6hnzKrUrC4GF4qzH/7zvk9dpsbDhxguPcKPeQiFUaE7X?=
 =?us-ascii?Q?zOlnVtL76nWURh4nd15cF/pbyOim4gVAM38FsVf3zoPQL5aCgBBO8iguERaK?=
 =?us-ascii?Q?zRP3JXUT2X8W2lzSctwue/yV1PLDtpUFKi/vt0UcLbdVERVcA+6fCOb1HRLv?=
 =?us-ascii?Q?RZ5pqasa2RBMBB6zg8vwTzA1ORZqDg80BP1WTup6ZnENKXDNbWbEXAa0Ffc6?=
 =?us-ascii?Q?BjekqNXUXRP8FWO1vSoxmXKtsKfN0q04IH/mu8BFQ3hCsNri5w22urw3I0g9?=
 =?us-ascii?Q?zIxMxd/GNFJh9n3jV6/jOHQPm4KkSttJ/BF4cgHdVXpUZ1WsGatMOlmkrifu?=
 =?us-ascii?Q?iZEZPqRexiD9ixF0RyKN+NxpA0v4VvtJ1vL/HdNxZy8R1vjdqA2inJfsEGg5?=
 =?us-ascii?Q?IGDL/BGLWHfy1aorGjaiEVQOz6KDPJ0UYCYeMMp1hr3IzcdZWcVrW6RJN/Sl?=
 =?us-ascii?Q?x+VuAVkIlkUATpiI/tZAJpZkkCz1bhkfympKZJfuk1t0/QdaF4kWxlG2z6nQ?=
 =?us-ascii?Q?sHKTfv7Oz42JIcrKbOvDoXk6FASCiWQioQhpynUuyeZLgctE4iFR4h1GP1cw?=
 =?us-ascii?Q?bKklJuTe8IMxDouEXqO3SiqsOy26tBFEtua5P8HN5YuwKFwwaYQASmxFk7B8?=
 =?us-ascii?Q?DPeRVFzQpIF+hZZHYzYcERpuLqQTgowX102wclFqsg31VfUMoGwTyCumhGHj?=
 =?us-ascii?Q?pIEskNDXtl0KtxZzv45lzMDH+ub9dg1vtqWas4U7gEXWBlWMxbPfUuWWi2BE?=
 =?us-ascii?Q?fY2+sa2+UDIKLC4Nyu0xdVeHbhDjZRSo/Wc3wvROOAFADvdbYtKKLNAdToDo?=
 =?us-ascii?Q?cquLE9wjQg1x9NMeDX+/lG2GQ3fh10+vh3JLhgXralJIHLjTluaFPkzdGpuK?=
 =?us-ascii?Q?p7KnHQU32hsl4+dnVA2PhvcaAtCGNrZKLuP8TaQl8PrYd8PnEethHC/97/7M?=
 =?us-ascii?Q?7RIp1d9s3Lo7vAxW3TfRzE0pELFXVKGu5pezFr5Y+Cf35JYMsGF5sxKE6SfC?=
 =?us-ascii?Q?X9Z2hhO1/QuLvFUkwH+7gD/h+5nR3d9n4W9JSeynja4xOb93ZVln?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a3fd3b-c1d5-4f71-54c8-08de6dfb699c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 08:06:11.0203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Th/DOrTqFvcozrVeuMWRdAjLai94vD82ZSTpZin+VDUBdOFf2JU2LSmODBz+EEz5t5JzlVnjHGdcCIgFn1TZ+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7132

Some DesignWare PCIe controllers integrate an eDMA block whose registers
are located in a dedicated register window. Endpoint function drivers
may need the physical base and size of this window to map/expose it to a
peer.

Record the physical base and size of the integrated eDMA register window
in struct dw_pcie.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/pcie-designware.c | 4 ++++
 drivers/pci/controller/dwc/pcie-designware.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 5741c09dde7f..f82ed189f6ae 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -162,8 +162,12 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
 			pci->edma.reg_base = devm_ioremap_resource(pci->dev, res);
 			if (IS_ERR(pci->edma.reg_base))
 				return PTR_ERR(pci->edma.reg_base);
+			pci->edma_reg_phys = res->start;
+			pci->edma_reg_size = resource_size(res);
 		} else if (pci->atu_size >= 2 * DEFAULT_DBI_DMA_OFFSET) {
 			pci->edma.reg_base = pci->atu_base + DEFAULT_DBI_DMA_OFFSET;
+			pci->edma_reg_phys = pci->atu_phys_addr + DEFAULT_DBI_DMA_OFFSET;
+			pci->edma_reg_size = pci->atu_size - DEFAULT_DBI_DMA_OFFSET;
 		}
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ae6389dd9caa..52f26663e8b1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -541,6 +541,8 @@ struct dw_pcie {
 	int			max_link_speed;
 	u8			n_fts[2];
 	struct dw_edma_chip	edma;
+	phys_addr_t		edma_reg_phys;
+	resource_size_t		edma_reg_size;
 	bool			l1ss_support;	/* L1 PM Substates support */
 	struct clk_bulk_data	app_clks[DW_PCIE_NUM_APP_CLKS];
 	struct clk_bulk_data	core_clks[DW_PCIE_NUM_CORE_CLKS];
-- 
2.51.0

