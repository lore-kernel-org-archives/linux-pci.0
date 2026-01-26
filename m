Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021124.outbound.protection.outlook.com [52.101.125.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B2C26E711;
	Mon, 26 Jan 2026 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769414164; cv=fail; b=qOmIXLA5HORGxdQpdQomiafrQrOLD/xQbPcWa35xlq4Vxt4Syh+ZPhQO7xJSoRyMWo30nsDYXnqe3h54hkaVqQhZ7qjQz/ISWgceSJq7Vro63ipaK+6RCK7hQK/GBz1tM0hAqiWHwK3PYIr1PUCgCeD5ZLpkUTvzPkhWf1nkbgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769414164; c=relaxed/simple;
	bh=QLM9m26W6vOACXQ0XcB5ThqhYwCEBeKncJnyAnnSzBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RH/26EPGsSBdTBqPnoQHwyWqp2HdhnMBSMlQzHScRr2R8TUPi41IboPZUMCk2Y44BalQ+6bpjBUvM0QtdE4gObF8rSyF3CVrGbVYpFHYyGODL52nQN13eIPu+BKvtBSZ91uKjQi+JjxNgZDS/as6qRhybqHOqOUdaoiVaV+Vc1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=XVM0fSBO; arc=fail smtp.client-ip=52.101.125.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="XVM0fSBO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAciNZ09cToQsEE/bv2IGRSUlCzygZYTxypORQ4mSHGx4nScfFvpBhv/MnXpsDo3yqAVUqog+4JZO8TNhmoBE64unPoMUz4PkmcRN6FQE5CnQVZMoIOsEl9WAVBWs8KfE+wVgPxhx0KfYL7G40Ly09fxsuy20cu+BIqMRuhm+pMUxiMMCONBMPqcddvLL0nc9ME7asxsZkJQDJiqggfaZONuU+tQ234EfqKdbLUir4g0ilGg2oDVwUUzuccCBA0hVxiiZ/qJvEB4lsWRtTtfDjMw2Jk+uYI7WXNUp6uNcPTlAz5/DrMQldEnUVwJhaPNKI1yCim876/2PcUtpDXZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zve/d/8tyaSE952gQ6RO3/RgmQidDcpvAPN4yVRAEAM=;
 b=grKW3Gaig/d5qvkWNF7nsEbeqgT5jhKJ/D+kom/IlIubcWhRuCB2Znt2qvvjfbH0ajdeHnMTAx0yaOE53/ri1cM41vjvXjm03C2/dYhXgyXRVyVn4/QRpHDFYpXQPi2lQKIoXQmgRi8XYRB65VclbfXVqNqxoUE6lbvprD8sDTpxfbJpxVi1JqTHSbc+K9ZYowaJTDVOergsbka0VUlIdq8Z+fas7ye7S5WOpe/c8507XVi4iCHnbCWLgr/DJGfsVKUtXgkBqOjMXioyM2sqx81Boc9B8z5+dtBL6ZHnPzkhKRod+KoauWmmNSxlCjgD1D8V9J/MhWnl14zydaSHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zve/d/8tyaSE952gQ6RO3/RgmQidDcpvAPN4yVRAEAM=;
 b=XVM0fSBOusuS00BpsRqFIJIoUdQSLj6YxsXMTnybJUZ1ORiHoUdWqDSsOulK3F4/sKPX9/2mdzjbC7pexYHQTQRVB3eTmpdgHxBRHK8Tj6gyATczBpEdH7ywb/eeBedFEGsxm9uAX+6Y8gyYMD6h4fU5eScuRzC4mX6YM+l2l3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB5359.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:263::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:55:56 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 07:55:56 +0000
Date: Mon, 26 Jan 2026 16:55:58 +0900
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: dwc: Expose integrated DesignWare eDMA windows
Message-ID: <x4cilkxvg5ccqqx244ttxgh2kgj7x6bf2e35suwguels5yiqxc@ij53hgrert7j>
References: <20260126071550.3233631-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126071550.3233631-1-den@valinux.co.jp>
X-ClientProxiedBy: TYCP286CA0339.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB5359:EE_
X-MS-Office365-Filtering-Correlation-Id: 02fdf629-5e13-4f7e-f53c-08de5cb05613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5QLdIJP2SHvCHaT0afMurq+zqoprV/UsNBwXZF0OZ+qNipEEbgwhNR6c2u4L?=
 =?us-ascii?Q?T4N25JQWt5j+L8O/G805ZhCkMjd1/8O17H9uacOIXWhI8I8M1nOtqngyHPrB?=
 =?us-ascii?Q?LPTOWh2tyYnQjQTtXlTHTHHgJJcDGkEv4LMR+HXsDbjAAkCP28FyGngdO/ED?=
 =?us-ascii?Q?e+6EoV/4XpIxcG1f8vJv0Qumt28pDSuMJHLdR7Wa2OzhhDAL6f8Aph8S5vts?=
 =?us-ascii?Q?lx698vAwVWnBXZQSajL6A+QpK1cyxxeBBVDWeDE6dyrGvNigLgjpLuhGgnxh?=
 =?us-ascii?Q?hp/41UZaJeiLbO/C4/ngHJ7xDab2Z87ApLSSVy6Wc0IOQesUnwazHARBhWC/?=
 =?us-ascii?Q?ZMGnsmPyFr9QD9Zp8aIrwkZbRHHaDv2ptkzo3g4RqTqoE/Jth65BT2bVTX97?=
 =?us-ascii?Q?2B0KYHALJQ85MhH/6CX4tde06AvRFk6qkzZKMJm0IrssAHQWhpmiBxT82JXp?=
 =?us-ascii?Q?SnzESS8Lnzh4kF5IkcgxQlkNdrmV/bgjbnNmLfhKdgDsFv9vrGbaBBPe2Pnb?=
 =?us-ascii?Q?9O8VCEl4biJM1sUfZHc69N2V4bv5DfTW3RKHrSR9Pj8oOlNDYpEiRDXWZG4s?=
 =?us-ascii?Q?h0I+vDjru8DH4TZFqpNREFDMZKlATh81nbt6LXQAlxALWDEqRG9vrZZue61y?=
 =?us-ascii?Q?i4+KoJPCH0bjWj+c2BwdEZQ4WM9SGHLFfAVTDeiUwPTZjVd80asiFYBkdLpL?=
 =?us-ascii?Q?4ddV1b9HY3HqK1JU1+qtDMEBtnkcAk03+c28EnYizL3gGHkx3mPeGOrLzTXX?=
 =?us-ascii?Q?kUX3auqepMPqgiuAPDcjpcHANoCepcATWIk5cxi87povu53Q3KbnwA9Achz/?=
 =?us-ascii?Q?LKYyvoB0DyvVTXQqJDCLR5YXF/4/v5C9pXGDMrSMhr2JNbLZAtWefWXLWhUr?=
 =?us-ascii?Q?IUw6x80R5NelHrTw3X+TeGbepxAWOY7XbtZuOAjBzSkg2yMym3Psu73lDFlt?=
 =?us-ascii?Q?PctbwSlCdUnKXrh22Vx7LnambIfnexJYJUjbiZPT12jWnk92B8CSXOgyWgdv?=
 =?us-ascii?Q?DCAwqyRag+TtDCTYzCMYuvxiMT8KICqUJ0TTqrinAfhmYhhoIRmGp0IyuAcz?=
 =?us-ascii?Q?X1j/cMLDhS2bQQFLs9ZWhWM3A22XSDvtPDvskmfzHmRFPs0PoBmDv8UO6Esw?=
 =?us-ascii?Q?pQ+5Aoo1quL8LZXf6OZxYe+AlRt1/yNDXslSshduowUHETF5e5JnmPKZ1VTA?=
 =?us-ascii?Q?WsOCc+sUiFOFOYaUZcEKNmy16/HXaGE2FW8GRJ7grTyv9M+/C06F5OqVxL9A?=
 =?us-ascii?Q?E4W0X3oZjobvOsTwiUyldUM/+TnUJOerv5EmyuBVq0fJ3uKoMw4Gc8DPh83I?=
 =?us-ascii?Q?29v7QdsmEk3X0NaVSvfDyx3wm2fXYwsw1TwMEfKU4KWjjn/QOfpipKbKBhcj?=
 =?us-ascii?Q?8j+9VZQ4PaJqY9LSmkyLYYtURqjys6BCqZC9YW5GzUgmkgAiXMog5rmPqcmx?=
 =?us-ascii?Q?Df9VZaAxRpJxw7RmTO2PRTBSHeqpz4tM9mvmOjgk2IRBnjx9721aLPpZM2VU?=
 =?us-ascii?Q?G3lzTxb6pXg43ta9EFb52uzvt2P1pV0QFPX2qHAWtiwR11SEd6VKa7m47fTe?=
 =?us-ascii?Q?a2FrReFX4y+ukurS3PA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O9tP/Nk22qLT+QDUjqqxNJJ5xQo1n94qudLwRDh2TsbX3BYDf3XAX93k+MyL?=
 =?us-ascii?Q?EaPWx6yubGawykaNwTqhgCn5i8wb0/rpXTQnPNu3m3SjKh6UqsV87rxhs9SI?=
 =?us-ascii?Q?rYKG4jqp4y4FJ0fEJkuAgvlWuikEoF8w9BNJv0mNl0D8HUeeoJb+Xct+FkRM?=
 =?us-ascii?Q?k+Cdx1X6n+7z/22S0k6q2gOdOI9uesixPk3Wxoh+O2QgL+1XoY0ZopAI5wTt?=
 =?us-ascii?Q?2W4EcIYhORY8I8j/jfAmkL5+IAIRtB2KhXtbf8szp39AIuw9eYClYHJx+hZW?=
 =?us-ascii?Q?xDws73L9EEWCgkMF7EwG1IoKsRYxx7z264O6aZTepMSAY5Igd4+uT+IxP+mR?=
 =?us-ascii?Q?5o0S7aihnCeyUtMqclLLud8Bp2h15Ucu8WL0Lkd5YSIaPBlpfQ+sPF6HC832?=
 =?us-ascii?Q?XM3HZIwhfiSSYHIX6BZ4epAnzvU1li9ZDiXmRSV+8HbnecMG4fh1lV4jN86o?=
 =?us-ascii?Q?nwCJHWawhenD+EKJDSsw9T6oUJ5Q9d9s7I3JVpWDSgYEtpkp1tI36Yo0AJ8w?=
 =?us-ascii?Q?lt1bsd9TML1SwMB7Ay4YRmuZXSCzoZ8p6gcdLOVML9h16d9kHymB0oQiW9pz?=
 =?us-ascii?Q?hd2phLZWs9qcN47Nr+OhnnUrXXL7zZArg2Dk/vT9I9DB7D2YlZ/RoPbCyqtr?=
 =?us-ascii?Q?rXdHe/D3fxSHtQEa+C4bkVu1z3g5yGdUOlLKa40b4e5FMSTdmnMvdaP8I4mX?=
 =?us-ascii?Q?FFtw6Zb86ciROP4UL+QpDbqKmx4ftH/S8tg/52Z36eHn1VFfZape4Ez7PSo9?=
 =?us-ascii?Q?Maodbe2nc6RJoWr46cWY1mQ4Qwffoy4AM0zHdX1eNQic6gVmAs2mt24Fd1Bp?=
 =?us-ascii?Q?B2dCwoP6dQi5RM1DT9I2KBIcK7ubersSuGUoxKpG/91vGoojSNK0CswETApy?=
 =?us-ascii?Q?xOOj0u2jc1PDMEYNP45ApmYzck/zBqKmwLmbHsB2PdLhKjStSooIBiFYztGo?=
 =?us-ascii?Q?dStcY3ZenaudDcvH+K+kT9DKf7Gq5A+23uRdgKadO75dccQahZgg0a+ThvL4?=
 =?us-ascii?Q?DXH2XXVd1Z3koFx2gMJ7cO4acQf3i5wvsC8h7pnea8prIVMo5cnSc6p0L0dE?=
 =?us-ascii?Q?WmbY7gxTzYu+UfRKxvfBPekOkOXPNDioiK8Ltv1guc5QrXpuU59HC0k4O9NM?=
 =?us-ascii?Q?ZqLES0zv6TfHz6Xxt0RzMzPFIlKW5XfnUGfGc2olit39DjbMxlK/p7IGC5er?=
 =?us-ascii?Q?+35uLyoYeVZ3aO/Z974rTNos0FBXtNgRmdaptaN7S+WgN0CA3ueZC46HGv7f?=
 =?us-ascii?Q?KPzxe4pWnUfZzJudkwv+3KGkr3bvPNpzoi/Ut1gznXB5CtmKZhbdit0EjPWa?=
 =?us-ascii?Q?nKnds3XMNIu/MHiwspQ97P6i9TDIL2HZmF05PqkHArVXdNmJXavuRKYvuaIE?=
 =?us-ascii?Q?jFtko7vWtXx6Vr4VAHS+8yqteQLcO+QqdKkHfN7p3WQrgMZExvD98MK1CvLm?=
 =?us-ascii?Q?fgXGNaTp53CftHusEykzICuWjvYBW7U2WDb1uye53q9BWrLKUWj5Sgz2wMgu?=
 =?us-ascii?Q?r2DBukicR0vQ+9TweKVjG/GWzmJ6gF/aiTwNL44Kn7Ztfw8ylYaNfAOkAjiK?=
 =?us-ascii?Q?4MxvjxHl8BCRigJ0BVBNNpdygnzEUmWtaqQJQ5uqBl1Sx+veIRY5mBBnq/Sw?=
 =?us-ascii?Q?3hbWsUf8Q/XXSx/QGjpLZW7kzcqKkMLbGu9zC2bk/b1teAgB0NotWapZBKTb?=
 =?us-ascii?Q?f/4VAZF8YK9sdJUz9FIXgWhmqtoDhwc1ys0fb04Qr3pnfPRHdJC0Mj/NvCZ+?=
 =?us-ascii?Q?ykwLSyd9n5pVO8cOYfszxgtQg7yd9IKLRliWI3CFXjl8ZXi86cKi?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fdf629-5e13-4f7e-f53c-08de5cb05613
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:55:56.2094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUnra4FKDMWIDrOEUyUMLqm/JRdP0WH9JPkWHWc4hthFlA0ayb9VelPmptu5tqOhoxpLY8UmRj9ClMtGoMTupg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5359

On Mon, Jan 26, 2026 at 04:15:48PM +0900, Koichiro Den wrote:
> This series adds small, query-only helper APIs to the DesignWare PCIe
> endpoint controller driver to expose resources of an integrated
> DesignWare eDMA instance. Specifically, it allows querying:
> 
>   - the physical base address and size of the integrated eDMA register
>     aperture, and
>   - the per-channel linked-list (LL) region base and size, keyed by
>     transfer direction and hardware channel identifier.
> 
> The motivation is that some DesignWare PCIe endpoint platforms integrate
> an eDMA engine that can be driven either locally by the endpoint or
> remotely by the host. Remote eDMA use cases (e.g. [1]) need to expose
> the eDMA register block and LL regions to the host through PCIe BARs,
> while still allowing the endpoint to boot with a standard EP settings,
> without DT changes to hide the eDMA instance from the endpoint itself.
> 
> The hardware channel identifier used by the LL-region helper can be
> obtained via dma_get_slave_caps().hw_id, introduced by a dmaengine
> series posted separately.

For reference, the series has been submitted here:

  [PATCH 0/5] dmaengine: dw-edma: Add helpers for remote eDMA use scenarios
  https://lore.kernel.org/dmaengine/20260126073652.3293564-1-den@valinux.co.jp/

Kind regards,
Koichiro

> 
> [1] [RFC PATCH v4 00/38] NTB transport backed by PCI EP embedded DMA
>     https://lore.kernel.org/linux-pci/20260118135440.1958279-1-den@valinux.co.jp/
> 
> Developed on PCI controller/dwc:
>   commit 0ecd890e3cf5 ("PCI: dwc: Rename dw_pcie_rp::has_msi_ctrl to
>                         dw_pcie_rp::use_imsi_rx for clarity")
> 
> Kind regards,
> 
> Koichiro Den (2):
>   PCI: dwc: Add helper to query integrated dw-edma register window
>   PCI: dwc: Add helper to query integrated dw-edma linked-list region
> 
>  MAINTAINERS                                  |  2 +-
>  drivers/pci/controller/dwc/pcie-designware.c | 74 ++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h |  2 +
>  include/linux/pcie-dwc-edma.h                | 72 +++++++++++++++++++
>  4 files changed, 149 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/pcie-dwc-edma.h
> 
> -- 
> 2.51.0
> 
