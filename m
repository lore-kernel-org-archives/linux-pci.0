Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6AC5304AC;
	Wed, 30 Sep 2026 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789930; cv=fail; b=DNla4rrzVU4MIjpJ5rcNTuHnNxbBx1aQFnaVkMe74655Rw0mgzB63VZqXumrav+jmJssgmmm1P+FY7nloY+YGQjkg6CH+lbmoizo7qDseUCa/io47t2T8VwBOJPh0/a17MuF3AJ2j6xObtilaULYOurGbkyVGsfQdDxZkmmnK6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789930; c=relaxed/simple;
	bh=h7Tu8nMFBQf73Y4+KsEX0hz5W2oDw0fACJYr4cPYT1Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WdABxUY7C8Hxu7wxUWaRKp3mo1CeyGAvYQSL/vdLFHOleSzeQYoGcY8bzsHizwV1775CqSq33GBU/RXmKaVNxfpwi+I1x091sh2QomRal7OkgaFGFwjX2A6TOGwU8B1r4Kypr8rW31VAiS0MNHB4WhQ0W7T7FGjZMCswbUMRBe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TAR5Uhxt; arc=fail smtp.client-ip=52.101.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TAR5Uhxt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bj0X6GtB5KBHKC+LisSy2VM1F8FC1c6mYXamOS5Rqom3Lns3X4QmRZIS1Y82hwKY8wcCNtyhDUKavANM3jexbDE2EYRukjgdmG/YyyqYP2KtfdkXk9im3AWntdoJ0uKZEGOOITX6Dz+f21ILgQbi/ApnFaSaFJHeaChvDZpiy+4VTSRa1xHqAcoWFdt5WCJcYckjF/Zz1ygfJ7aob74zXrkrIHF01CKGhDyj7iSARDLaKrY1OPYFocK4IkHnQz1p9BQ38QYS3nn9ztV+rcFDdt7XW5YdpaJ7zXsJfW0AvJ6xIHZMfcvS+28aQ/Hf1Wg5fCp1UTuzDmnQXOyK0+wJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sAUz0R93eUErSdqv6MbEMBCGP4gTsHn0nHdpiLmUNI=;
 b=xtE1nFn+xKCV8U+IE2L1BQeCCv5hIbdF8pHF1NKnEEI6AyRF19boru3WGmwJBPOCoNa4TY8XErfycO2KdWXnY/AymhNgvRXPmEAzIg22Pg+mpnd1DdnHS0EO8arVBYV71V1wy7/IQ5R3NOjnSEVQKRMecWBV3fBhFhW0QyucbTsTNiVGIR/2crVy0SkvWkILKSIIdmcJTvlBzyWnBIqIPaZEQjKkNM0Dkgx9t+lCzzOEpfDlxyELOKbXVv73ROmWFU0aY+Tl446RU6c39LnPbwyptBIClr7Dqnu2lE51/Ilgx0V5TVCIp/iUX2NM87q55pgYsR2D5EMmbPPxWgLqIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=collabora.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sAUz0R93eUErSdqv6MbEMBCGP4gTsHn0nHdpiLmUNI=;
 b=TAR5Uhxtcb0G+JYyaiSb3FIlKEsnODnFbkZaLaSzORgZwm+o2Bt3r6C4OsqdoAlAZB+X3lOx9so6kSLHFZnVQv0Jxqa7ZlRgEwqsrSgRAuNtV3NMhc/cttjy4awVFIQ2vqQj/1cA0eh6iu7GWC81glliSx2a1YrMtXviU48tuPLaxyJX2HLzRe+rj4pFppUIEdZVeiayPoX+/le0gMDyKwV2oIagbaqD2Z7jG0AQie6+PuWsoO6GQd+SlIqF+0VeJp1LC6jI3vDx4CG942qLBONltdIjG4fwxaoa53MANTqQJiclTjDoh4TfCVOoVRBoIzJ/kbINbmYzUCPMYUlIIg==
Received: from DS7P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::21) by
 DS2PR12MB9589.namprd12.prod.outlook.com (2603:10b6:8:279::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.16; Wed, 30 Sep 2026 17:38:39 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:8:2e:cafe::18) by DS7P222CA0028.outlook.office365.com
 (2603:10b6:8:2e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 17:38:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Wed, 30 Sep 2026 17:38:33 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 10:38:08 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 10:38:07 -0700
Received: from inno-dell (10.127.8.11) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 10:38:01 -0700
Date: Wed, 30 Sep 2026 20:37:58 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, <joelagnelf@nvidia.com>,
	<daniel.almeida@collabora.com>, <tamird@kernel.org>, <work@onurozkan.dev>
Subject: Re: [PATCH v9 1/1] rust: pci: add extended capability and SR-IOV
 support
Message-ID: <20260930203758.4d8f1b95@inno-dell>
In-Reply-To: <DL7UAU8JQMJP.JBZ591QQ7LPH@nvidia.com>
References: <cover.1787830828.git.zhiw@nvidia.com>
	<2e9d992509299c2f13de48109c4c933f53817acb.1787830828.git.zhiw@nvidia.com>
	<DL7UAU8JQMJP.JBZ591QQ7LPH@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|DS2PR12MB9589:EE_
X-MS-Office365-Filtering-Correlation-Id: 52dd15bf-6e5d-4c29-254e-08df1f19a6b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|23010399003|1800799024|10067099003|11063799006|56012099006|4143699003|6133799003|13003099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HVMnHf+Z72D845CDOnpBixsBMUxv6HX7hTU/nXFEWIemTkfxxB1SKmaIEGdc6WtseTe8VEpQWORic2/YbIsOm4SzkQcc8v1F06dGUs996bmWOXG28XFxg/QdgTKh75uwku0Agu3yHqKtncj25Drq/MAvYPzkQ+H0cSI6x5/yKiMW7l9rvIYsnmoOqL28fEjJExt/rnQKwmvhNQGl4nzsOH9f/QEK6K7DZ1ZfhchmvkgpTAXsJ/N9VypshHlITbLYMRXLyf5EjrLnKioAFqrZXwbuIgrf+KzLtQN1HKRpJ+y4/yW/Z7h2D7abGe0JqYwmH9Rq+DjwDZ1rV01uwKolleTh6/jJ5tuW+qD5ZVLa+lztTZqLtKMyInZKIDZ24CcO+FNuHLLO+rDQ/W39POc9yviKoX9J1Xei0tUTzW7q3NSTqdk7s8cdoAXjnIrzkXWwvpFdEYUAul/cp+yJrTamt0Cnh1aKjliSgjLtGrBm7VS/LAfcigkX3mgSWivJRLTTdzyLzWjvKvTbFr2wsUViwIJ2DSfORuN7C8bjvd48u3ZOUHPtt5bEhwKfjO2pcVRMeUpJjXavwWvxN0QXNnYoJVZI6ln5wNAyut+OCCyY3ZCJ+1JOKijNapQp/B/sK8BQ0BVD51SC8dC65Gk3Z2JgON/yhlQBKpmyzvNHpfK2z6+3r3DhphM3BEm1XXNqPlrSoqQUCxqRlpJKb0X/N5uDVw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(6133799003)(13003099007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RbSYGvrYkpTXSKrzqsDdoyKG6XDVyWkrmyUfsk9XDVliX/ib4X+qcuMlWf+t3GxAaeM8LG0DuwUCPf577T41iwOP88wtSb+2ApfhsMxsWdpBt6/PCkZBOGzD1sKwZrNVk2Q0KQ38IgAbYTYD1qPBtNMKxyHyKefDe7rrf59sY7FaMfGy5rEKRP/AzORu9t+2WyccI1lwlbmCBio0Jl76psdLwLJ9xE6sla9aO829IzkNKXlOn0MZoJdL8VIzaOSjNyPwrYYMoQuixKQMDgV2yAWdPrw937nV+VCoR4dZd/eU0Pel/DmhxHPnj+tUnK17vrUhmy2M96M3ljqhnUVmxvtheNnzKZNvfQQD2gu2Tjer+yzJMwM3RYlx2dFNoI223OOD91ofS5FvjK4tZqwbcxeadeOUXz8hpXtc929mQuwvGAkf9Dr2CY2RML1RxDGO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 17:38:33.9856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52dd15bf-6e5d-4c29-254e-08df1f19a6b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9589

On Sun, 06 Sep 2026 10:24:39 +0900
"Alexandre Courbot" <acourbot@nvidia.com> wrote:

Gentle ping for the next step. :)

> On Thu Aug 27, 2026 at 9:18 PM JST, Zhi Wang wrote:
> > Rust PCI drivers have no typed interface for locating and accessing
> > PCIe extended capabilities.
> >
> > The SR-IOV extended capability describes VF topology and VF BARs.
> > Expose this information through the Rust PCI abstraction so drivers
> > can use the existing typed configuration-space accessors instead of
> > raw bindings.
> >
> > Define ExtCapability to associate a capability ID with a register
> > layout, and add ConfigSpace::find_ext_capability() to locate and
> > project that layout. Bound the view at the next capability or the
> > end of extended configuration space. Add ExtSriovRegs and a decoded
> > VF BAR iterator that reads and validates all six VF BAR register
> > slots up front, yields decoded BAR addresses and widths in logical
> > order, and keeps the raw configuration-space slot advancement
> > internal. Since PCI_EXT_CAP_NEXT() is a function-like macro, expose
> > it through a Rust helper.
> >
> > Keep raw SR-IOV registers private because PCI core owns their
> > state. Expose the current First VF Offset through a read-only
> > accessor because the Nova GSP ABI needs the raw 16-bit First VF
> > Offset in Routing ID space. The pci_iov_virtfn_devfn() helper
> > instead returns the low eight bits of a calculated VF Routing ID.
> >
> > Link:
> > https://lore.kernel.org/rust-for-linux/20260818084633.1673214-2-zhiw@nvidia.com/
> > Cc: Alexandre Courbot <acourbot@nvidia.com> Cc: Gary Guo
> > <gary@garyguo.net> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> 
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

