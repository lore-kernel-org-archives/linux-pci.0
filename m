Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013044.outbound.protection.outlook.com [40.93.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6D241DDFC;
	Fri,  7 Aug 2026 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111340; cv=fail; b=kaSO+r8n4EMJKLxhqNG/RH7a1fc/N6itOHVma1VSWzRzZJOzGcXl+IFgA760TsCbOeg628D1/aJm2dxaeRAq8Xex0SIqyWzMaC/L5b/BBOjPpqX/MSVsPLQ26jb7AG6ixKJ2wMw/ZndhtAzsMLZlvQzLpRR44jCLXAgChuFlgRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111340; c=relaxed/simple;
	bh=i71QquEQYj+fi5VcJDdASGbUvzCXkRJpjH3h7ikup+A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IOh7XwYHo3lXmTCgJwV8eiBtIFg/XKeUSzV52zGkPCGUCyRMBOXQQNlhMMUAX/O7UBX+bA7EbYdBjF2nNNjNKvVi5/jdirWtnbZeX91/boePMnYQqCOixF1RnY0b60BlyQlwusip83bsbDDBpAbdktmooH2QNDmrnWgC+lCCg/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a/8ouRjY; arc=fail smtp.client-ip=40.93.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a/8ouRjY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuDlmFyFHfTxg/RxFbAtWy5An/V+AyTJnBxDjFT9olO7e2wKqqB3u2CSPZvbBHTTKnqd9VJBEdLCsMuvH0RdYRpU1sP3Flmxa61vKjSAR6hPfsdtXFQKsnbqRcAPQ6TcHiOgGeWEE919oC1PRbTaSHTWdxUP1cU/OyDHGJthjsMyXbBst89/VjhLPcFtIIDUuhskIuEekuHbm2SF3nRoV0fHci1u3bTecGvraty0ExPA7oXjuxoV36IOx8q+vmZ2sFALJBpgDQDKCeWP6FYi0sPyRQUy/yJIEnzPoZwK4T+9qNks1mYd3ggKgWeclatAxACFcJaf9jJI9gZpYw5WGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YjuiZc5zX+AGFTspgfRBOVuphW0KWdkySyUuvt9C9Q=;
 b=XDXrLbcNIBiZuJvuTloXH0ETr1C2VWWwBwBwo4L6GOeWnsFYaFerNBw45ZdE8hxjfavAimTbnU0ujaljLUARReaCPhkRsFpc8FOTX/bEh9jzB1+a8d1sbo5cJ/TLEdIurWo125WJzYo0/B5DSGknwY8vbX4h0iVeFEcQrJb3LGIu71WwDntBGOuKrZon1PZYHnIS3WvycWGzwe19btLlGK1G3+lXha2pVxbrYJocv6ksVtTgsmH+m/0dlz69UpGI0a/pqLZCY434MWXyKyxHxAlw5Eb249vnyaK+pN66p0NH61OrC99ey8CmlRMVc2B57rnvT09nacQ/MsboEEK6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YjuiZc5zX+AGFTspgfRBOVuphW0KWdkySyUuvt9C9Q=;
 b=a/8ouRjY3gndpxfXefXp8Q8IOPtreWvCJ48aw0iE7sZl/J3okYIWFJxaYsZoGnerxlEUeAXQk53xZnu4bVRoeHuaj2sruakqCE60BzPINTMLHKn3xh8eR0t9OSG4GB+gpJ+n6xYtB77aqXfaROC5V2Pt7/BQO/siAAPBuDGd5y8=
Received: from SA1P222CA0105.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::13)
 by IA1PR12MB6306.namprd12.prod.outlook.com (2603:10b6:208:3e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 14:02:13 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::50) by SA1P222CA0105.outlook.office365.com
 (2603:10b6:806:3c5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 14:02:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 14:02:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 09:02:13 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 07:02:12 -0700
Received: from xhdlc250064.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 09:02:09 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v9 0/2] Add support for PCIe RP PERST#
Date: Fri, 7 Aug 2026 19:32:03 +0530
Message-ID: <20260807140205.1070367-1-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.4
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|IA1PR12MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: 58bdcf4d-5335-4fa7-8e56-08def48c7b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|7416014|376014|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	/GmFOmB5fn5tcatqFb8nHj525vMOgvqmQ9i41QwkycOwSGu3iS6qa4PrbcLw0wl0G5oPUnwWFNFIkEqDxa9wWhgTpxMWs0UCTSqwdw+NTIJ2Jwum7we9nIDoSgs5BABY5LVhcvAp2gEFZKC/w18uMTfP3t4LnGYmz7j+vdeAcJKtywnb0e1I1zvoG23BQB96MHCI7VJnxo8BIn6Dj2KE+QC6vduV5g2yFcuE1YTd1WAb6x5GyGJf6FDIqC+M8WjumffhsOjDJTLc6Td5nszgx1IFj34ysGCkrTTaLuk9L6jKXSR1hm1bS1seVzGWBClhEc3BsJFhLjBG+zq3dNyJ6bIqpcot1p8kZFYKdtDSAbvfkei+ddLf/NP6AbgIdmC4Kd1vgYZicgIrIwSe0x0peT5LFuqsGF7+6meTxuQy944pl2THMQfquy+yUBqB+dCCjaQaSJQMXisBjWhwnoHhoZm8Nanj/v4hmfr0g5qvcElkgEjXEaCSgUQuQOYOosviXxiRf38YArUdBAcUrXbZF0ubeVzXAze5clLvfJmnvXEZNY6TDdkp4PlbcwwgTi8G0hj5rd/8XR0OFDi/40L2+NcZ5TM1hIW8NBsmEtIx4jhKBu/XGUeOrLi2rCAMW6PF8RKKi2v9jtMmEKjliRNExbwPMVe8CBbRhZUPz1PrlnLOFdQz1ADTJ92lEg4+cXGUBJSmhHafaLtbex4Haivwnw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(7416014)(376014)(18002099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZEiiiPVX5ABMdckT04vt4fvYfxTOXQNwskK7CznV2lvdQYhBYvc6v80scfE3L8kuo8VKQdXQsPKM8KEaoZGTwOWt38KwJCn9zMqy7JcgiifJz8MM0iMYxunkUFASoZ1K5sdDrBd1g+6HU6Pwgc6lpT2ZlkTXXnmiyyiwGHfDMbz+E5A3dsAduqhmOvv8iMLhUuGoDgZtlof+h/4OOfBk4sACJeT4qXMQYHRFRnm5dhBqOv3zwUqUhcgD1cq/d+WDvzKrqy8UT8VO2SlNTy13V+S6YW3k5ECYH7/fokcXvZI1c+bi7vNz+Qtr0NiJOI5xAJ6qPdf9XGc2iNq7wsv27Qpd1bU6cDZXjERRmUq3FT7jpsJ4DsGQXWvKEVGl5LounmSRvHg3f7pZjSdnxH3pcZg5ihd+ITgIvSoN5q7MLVPUVlw20KHe1QxAKE72TUJ7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 14:02:13.3871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bdcf4d-5335-4fa7-8e56-08def48c7b49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6306

Add support for PCIe Root Port PERST# signal handling
in the Xilinx CPM PCIe driver and update the corresponding
Versal CPM device tree bindings to describe the reset and
PERST# resources.

Sai Krishna Musham (2):
  dt-bindings: PCI: xilinx-versal-cpm: Add PERST# and reset support
  PCI: xilinx-cpm: Add support for PCIe RP PERST# signal

 .../bindings/pci/xilinx-versal-cpm.yaml       | 38 +++++++++
 drivers/pci/controller/pcie-xilinx-cpm.c      | 77 ++++++++++++++++++-
 drivers/pci/pci.h                             |  9 +++
 3 files changed, 123 insertions(+), 1 deletion(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.44.4

