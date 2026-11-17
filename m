Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794895966;
	b=B0+GLDhFdxLV//gXdYzbk38Ih6gqhoJp5O+miDZMM7BsOnpJN7CUo256DdOLIex5VKZI
	 CPz6R4Z4ZOevN+xDqexqR03WEOvZ0++HDzzmVaYSS/W5WdU4cfg11vBiWgU5mUWLv19EX
	 xAgChTKuqI9LtExnoHb/BLFJLii0f5AfWvVdQFkh6ATuo8U8C4Kgo+JpgqzGLo8nuTFUF
	 0z+VDe6Pho365unIFp1MB2rhcTqDRS72GlWGvfLTtuXrhNFyaXEL83vHWYNbQfKDMW9tN
	 lyHlMc7WbhjlFc0RDBK+5A7SFu2yNT2ml9kYhLTMooeoIon61c5fKRDj842TWW80S4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794895966;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=DtZLIZlfdmxHK2Na4B1jKjJX8sygZ3NTY2gzlbaQTK4=;
	b=EXADLtJCwcrq7XgW35uijhOKFnvecrzrmF8B2bnAzsi/yxs8MMX3nhkCp+C3w1luueM+
	 0lyBZAa9D9m7W0h5GZge9eSm3e1mkoeDjjHWwqibxeyM258p7NlZ+HIF8pCbb0MV/g385
	 1ruK/NSaLfkTpO0v0qYkNVv62YZpn4JO90kHO/nxMKu7dRaifjbfPfrVOgHanOQ9OMaw6
	 Cj9klQ6g5LnJd/wCHm+F6ft0Z0lOsAeAvFwebUeh60wTTK1xLCjne22UoxfJOHsP/8Kal
	 rdN/Y+cw4SduW1SnxFHGRyDTAhGIc9HuXGdZf+mlq9WX+CxBFAAdzddGV4o4nuZ/oJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KWIcfaqG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.25
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CB4606A31C;
	Tue, 17 Nov 2026 06:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85CB4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KWIcfaqG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQCUd6nrhRUK8wPiBJpSc6Yb6bm+trbCq5ZjaMzSMNqMwixq71NyJnmz/fYFXfd7QUhET5TAcCZ3GNoA/92nQynEKQDCurbX2ES1OXDpczcQU1RZ/PvxfKq/TGGFdGdyrvQHmekhn5OX39dO3ajeDSeIFU77tt7mynWYmr56h1uPWwWuHLjQO41JP5LxDllSquVP7m+pNEneFnwRAFkc/OH5VWHEYwT8LDK/IDZQHnaONerA1RaCmU23fvrYEDrufNpHgTi2sp95sz6nG+ely4lcprkLpIt2ToznJWK2c/YWk5hlrjGFHUpXwy/iwHyRE8eRndtBuv0SMjusLl/zdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtZLIZlfdmxHK2Na4B1jKjJX8sygZ3NTY2gzlbaQTK4=;
 b=dFNv5V6l1fExOFsLbwn1UuL32jnTX7ce8B+QSQ1pEvVE/b9QVhQuNN5LgmWmym++IFThm1SYmzygZJWLrClCQ526Pc4/F2RJn8lrVyXef1YBwrqDy9d01h5Aadksfj9NFg4jpQ22/NIUaeoYwuA9R3wTg0vSUzPhqYMxhAs8gQYpbYwfc+l0DMUAYXRU2yxf7MK15AvaSw4ZlDfyH9ebwMzTyRNdwceWi1DVcCz9HpzXRZ6IjtdssEt7nGYxciTJAH7Tv09dm15nd5myPy/TUEmbV96e+Fu1PY2UHGX0uTo5agzalocpf6Bi34+HFOdcTmdPPqMu8VVyMELfAGAsAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtZLIZlfdmxHK2Na4B1jKjJX8sygZ3NTY2gzlbaQTK4=;
 b=KWIcfaqG6/Oi4KNtie0oxFTFnUEGt4ZqJ/nNHKHEFJZi2Ft9BUfRPDnopuIQw7FB5s0NflbyoBMClmJlzcGeH5lXE5LxXYuZ0D3kRk2NjZhuKFSkONf0TRpfeUcKM6F1U7rVyn/7yx3HBFSqqaRFfxAg3CmzGbIm5QM9zSTIl8NgId6ZopQaZRnK7VOsukhEQNrz+Zua581oa9QRGdp0+c+nIpd8bA8GmT0+xxhLrhPVlw2M96Ovu5yBViN8QTFUy1XzVGqv6kiBktm+NJHMSL1r/+f95F/EqKrwV7nN0Ra4Hlz0QmshYkVz6NMIYpRT9GB/tqF4O4ixcXUNPuQ/kQ==
Received: from CH0P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::11)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 06:12:33 +0000
Received: from CH01EPF000BE941.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::31) by CH0P220CA0021.outlook.office365.com
 (2603:10b6:610:ef::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Tue, 17
 Nov 2026 06:12:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE941.mail.protection.outlook.com (10.167.244.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 06:12:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 22:12:21 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 22:12:07 -0800
From: Alok Kumar <alkumar@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
	<skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <jhubbard@nvidia.com>,
	<apopple@nvidia.com>, <joelagnelf@nvidia.com>, <ecourtney@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
	<alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
	<boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<peter@colberg.org>, <xinmengs@nvidia.com>
Subject: [PATCH 0/1] gpu: nova-core: populate GSP_INIT timeout defaults
Date: Tue, 17 Nov 2026 11:40:52 +0530
Message-ID: <20261117061053.915254-1-alkumar@nvidia.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE941:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af5b2f7-97e0-41b6-e047-08df4471c4ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|23010399003|36860700016|18002099003|3023799007|13003099007|5023799004|11063799006|56012099006|261028144727099003|261026140227099003|10067099003|261021121427099003|261022105027099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	yCWHsYMntZB8cpQHzQIdsPIxf6Pg2ZM+ALYS6ClZySSVR6iNx3BmbvzmgJQoh2vrVUirmpg7d0AZcKeQHgy1VLtiwNsxAcRFDdRokyO7D5/2bX3ICGRK9LHT4GbfikmVAr3FH6lEaCtRQXETOhvM6FWvC/puPH8+27OkL06F1qgCqCRSOCZNnJ7L38uF3ov5yZ/MFVAAeqAUKwQtl+WivMBW2oTT1UhsfK4zUPG0GJ9lXu12rmeCPonNi5S+sJuT79Wk6MT9OKe28kehNEEseo95JJec8TwrRCl7ZiAWhMd36HBszHkmomtRHeFLq/UwWNj699qQZKPCBi4ump68B5Jwk/5CBaFE1YhM7dZJ5ELDR2lK1Hltce8BRbpcAyhrjHAuV7aUQPJ8hdXFYJoSXaKxsRwjAk4bei0yXD4/VCENDUSDBKW8WQquKQdMu0MKw+HeXadSg/c+TzrNETDR8UEswjb5W26Dm8Sdqevvk4V6p3cYnGivW23MFMa3BoDWI8PKTVQ8DMZYcicBwHjUAImhTvkN3YEo9u1IwQG4CILhBJBdoohe4tZWEyfHCoBdTD5J/rLj7Eyg7TdEIcAPNgVLsbmq5j24BjjNzjgAVko6cvTIL/8mXJTGA15yvFi45AmgEOJOslGb+PAsuY6UXyyBYYTigE+1NbyEfQrHF5XRapxxmHrzrfNDgcEcxMnF8IjD0WGj2heTiso/XZeYmQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(23010399003)(36860700016)(18002099003)(3023799007)(13003099007)(5023799004)(11063799006)(56012099006)(261028144727099003)(261026140227099003)(10067099003)(261021121427099003)(261022105027099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jld0/2Fj/g6QqRa2UQ8NR79Jn/C01wqzaO81n/z4ThWVMFUP/B3H37gXyJOO14R1waRzgzpC8owrLkz1EeVNEk9JE9MqLIDhGAYU24fL0+qVopxbU8fzUVL5bDaJWIFuVV/IAgGIp/djyE5r/+SJIWllaptrnu1hUH/BiVzacb4Fh9PzSS4jGQ/uwqHA4svD22Mv5m8JZSOKwa0kBl96S2XHqJi95wAdMDv9Vky63Rqp2A1Dex54Qm6E31PSn3Ksf6vL/MYaV+tzqWIYJMCqaDIdRYosMxV45OaMkBQaugW+GQiOUmQpYG1jtwUuwUqngsgnQ8wW1bnuMDfvKfdm0l3R1wAtF84L+/WWgtv4dga5y8Zx4qUoY565l5Mqw/sGNgD7j36ACRNoevFcTxDPSNAANg89e9SdFqiD972eizjc8B/g0rcQkiwDTG/2v0zT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 06:12:33.0572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af5b2f7-97e0-41b6-e047-08df4471c4ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE941.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792

Populate the GSP_INIT request with nonzero default timeouts for vGPU.

The patch encodes the following keys as u32 values in microseconds:

  0xA0: vGPU timeout             1,800,000 us
  0xA1: graphics-mode timeout    4,000,000 us
  0xA2: compute-mode timeout    30,000,000 us

This series is based on:
    [PATCH 0/5] Transition nova-core to use TLV variables for heap sizes [1]

The complete integration tree, including the prerequisites and the
companion VFIO driver, is available at:

    https://github.com/alokk-nvidia/nova-core/tree/nova-vgpu-wip-20261113

[1] https://lore.kernel.org/nova-gpu/f1f132172061996beb4b5d64ebc68e4a6bb0a1e2.camel@nvidia.com/

Alok Kumar (1):
  gpu: nova-core: send GPU timeout defaults in GSP_INIT

 drivers/gpu/nova-core/gsp/fw/commands.rs | 11 +++++++++++
 1 file changed, 11 insertions(+)


base-commit: d1046d643c171875d6d350dcacbee89f56c7272a
-- 
2.53.0

