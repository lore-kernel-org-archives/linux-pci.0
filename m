Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021123.outbound.protection.outlook.com [40.107.74.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58376374192;
	Fri, 17 Jul 2026 05:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784265015; cv=fail; b=OjzangSFsOsJ2UOlI2PZieinD8oOvYGV2X0hMlD/iKhQph25k8HXesn7dwult69wofnsmtBn39Vv3dRtncdKSvsUT9XFSiSHvrl5/ig3uEuHpwtWfi2aYTZmgeepL/JCpBfFAAOd0fQE74Y+kEr4PAuFshygACUaNWQ1He22Q8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784265015; c=relaxed/simple;
	bh=V3g9UbitaDjHzRbqrWSvX/QVR9wG9i1Bki3gwv4SZgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RfetwQZjtzNWg8JRN8YolFsCrr25GaSI/VVurKY5Po3wn5cIdPPJmfuYxN6SYVlEwHCtGABTljcYMPhpGSESnxKe7OlVgo1EtDo3EJ71aqZemtPtLsUoIF3dqoYWlSTAZXL30dSOm75yGJW9lQAsNJcVmxEFEnXwchaeB52MdTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=wD6JwCnV; arc=fail smtp.client-ip=40.107.74.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="wD6JwCnV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1AyioYx+EDqdzugRgw0t7q0BOvdVYQ/1VSw+A1F4+Tyxxxo5gZlQnnMNDnkuq9M1xS3kSPTsQfOTIHoDvOCI70xaYGXy56SyhTgFQhgInj7IEebboRYFxp9myPStM/PAYnDOeVvLlDPYRSrBS+4i/AEAwpRgUHixWkmIN1zb7FvcUdfG75GG4hsLZ5CSFvX1QhZ3XPJiO6/3wdoTkS1IX4qW7pDBb+C/kywgXRPEe8wBcyGIpkGmamNipaPmTpzeuGFvcK4KovRKqsCRB2tXmtR2t+1uSdEvCPTzrvqATQts8aeAf4pSOAuiJ7K3pBLhX/n/JRj47rngwhL5onIWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNGL5zv+q3UOPEZve6Bp83Kvi/8kfMt1QesY8274nvg=;
 b=aSVy8VBRbh9VXhWjkQnVf9GvydCmY4e8geDug4Gbpc/4n6MOiw9Z7o8gDzAehqim3YSCOhTf9+UZQjgRSRT8HekGhI5J29fPR1XXiexdZhB6Fb8Yb+OK6LZ3cuyc6kM4w8muqjDk2ZDgAgL1hEPKplLJ08/0ohgron2uXbYW/q1rEblEguu4U1fa9xZTfRID8/mkJGn26okHaK8Tzy1rhkDqGtUGRu2nR+Gij7ALPxlkDI4oJ6qEPF/IFN2BW9UyvQg6ZN/Y9JmQogFGh9wsZrXhUCB3SYwzt2rmmc4FBVTojPVeTtaG4Hu571IAPstVSc/J/mY/WGQ+c6rKpuKYkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNGL5zv+q3UOPEZve6Bp83Kvi/8kfMt1QesY8274nvg=;
 b=wD6JwCnVKlP5jZvt593gI2AaMCGIQXMs7I0zPPitPL20SOqNRzd8SZGhHesd6WwmSHWjXvZLId9OIiwFcH2bf44ybN3suv5wsPjCEk4DmPAIMwwLyB8gaJiLaJgSTh2QUFX3WRYvkBXBbZVKHi8HwuhBMTn1ZyyRdBLrT1pSLx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYVP286MB3119.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:29b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Fri, 17 Jul
 2026 05:10:05 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 05:10:05 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v5 3/3] Documentation: PCI: Add PCI DMA endpoint function documentation
Date: Fri, 17 Jul 2026 14:09:53 +0900
Message-ID: <20260717050953.2145851-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260717050953.2145851-1-den@valinux.co.jp>
References: <20260717050953.2145851-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0012.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYVP286MB3119:EE_
X-MS-Office365-Filtering-Correlation-Id: 60df7235-ca12-4ded-ddc2-08dee3c1a9a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|10070799003|22082099003|18002099003|3023799007|10067099003|56012099006|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	ooBazm9ppPN/KFbSuVv6Aw3UHPTYhBnb0TnKT3aJBx3lze/BoEAi0PUzA+yoi/xLAZtBVcGAK1CQQYXHlElEVvYklsuBwiheNoZqXpTAS1qv71yCR1CJaF1oc8gES9pp/JZJqpKx6Oeus9J3hBv9mMfK6g+BRc9QbbfWE7LYQzHHre/bK5nMR1uodmF5Yl4qfcdSsKSIMNF53JVj8GlxxI/4/YxZefgrT/A3gHQ9uW35Gs9ASChadRQd6ILg3jctBN+4fxZz2k9wlOIX/bRyUUzvwIgYHO/ygltHxClzJCBDKV+dAZelTW71UpxY0fqF6UD9eRSEe9ACOQ1gNbu/p1zUlO3ixFUFUzko+CpstClC5vfPMMp7pWoQ8mNCwCO95TDyPUQyoFrSZZHq26gdb4zbUyiJIoxDEpOTeFfA92GWJ0fhMi8E3KfMH/07n+9MUEbXV3rH/iEd6X6tt57uk1/EK4KI56j55KcPHUR2bEGZf05ZNemXGKdjiN/Nh1NGLynm4/iRvyQwuMORcsYf3g1lDPLsrV8fXHHvVwuN8tcvdo3+ukOenobxk4+/l4ztDr6R3Qq6vRS9YHOgI5T9KhEZv7Z6dl5Gry2OjEQkSwv1U/akO8HSdOSMyYtaivwkK1mBZ8r8d9MF/T/0rQbIYrUxEzjen+nx/qxkPV6H3/akRxD+ewCOtZ/gO4eBIYIWxhgy4fnhDmrMA0zaxL+8NQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10070799003)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(6133799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GUtt9ZBUV8p93azpcLHTUBogwjqHFVQ0yXyCWzhGLxbOBYDNcWifwEYHE6Xl?=
 =?us-ascii?Q?SEeIx9fideHOKA+7yNAbQOgL1aFvVBhSnI4V2q/owHZIIJpUPwD+7e9qBnDb?=
 =?us-ascii?Q?FxT2dLEjTFgeB2aw79vCWudO9WHjcgXHGYkZQPeaITyi2CmL7q0Cp0I9+xOT?=
 =?us-ascii?Q?kYGFZQTHhwGutIFyRYO35XOrOSegpTn4wSzw/p2C3IP7YLrV0MNR5xcTVnqF?=
 =?us-ascii?Q?qW9LYGNJEhoGRli2n1LsU64msuxmRSUzd85JNPxNVJxFKaW9zCekz7NRlqDT?=
 =?us-ascii?Q?wgP9Mg9GZeYtfAwkbr/fUUzPUK+4gtvBWVw6vC+f9Rwgmn8ZdkKZb7WrqbyI?=
 =?us-ascii?Q?nksooe/nZ+DidoxXnVrQ4Jxk9LHGj5cjxqPImsiWSUY/d6klsvu2YVAX1XxE?=
 =?us-ascii?Q?jl0JlnRTQu08TfpaNwu+rMxvdgrz+u/tOwlRcJrxX1Ig/kUAN5a+cbMaDXn9?=
 =?us-ascii?Q?v037zXkbPXtJADpWhoZkctGgib94QNxvJbN3wskZESD+JbRxuJvvHlEAgd18?=
 =?us-ascii?Q?zhQ7VOoTrwTwqGlMqHczW8qAiblIbFEHqA2/OWCCVmVO1ryG2fHqaMaMe7oX?=
 =?us-ascii?Q?wwx8bh6S7MEan/IyndhVyhlbHzLxwHBxPBuWIj4olQqyvB7QlpHZQwGwqMen?=
 =?us-ascii?Q?IksPy5PTOQYIj94dsbYGq77ZvlA1q5ktNDRhvuNSmliJ/Rv/I6+3mjg1fAp1?=
 =?us-ascii?Q?Xj4tWNcraOjQwcT7cSdCeXqqyFl8kSWKYXoIKyxkt0wcbRzox3tNlJUb+tSR?=
 =?us-ascii?Q?goM68DYG4mQORObCDi7XRw8bs4SoVNpUFFhjFuVarjWllST4lpQIwuY9jccr?=
 =?us-ascii?Q?gTh5JXyHRQ0sjVNlN/LP/dA4VLNKEvrkKj01Mrz1Ii7NOIHuVvayLHar5+8J?=
 =?us-ascii?Q?EGQndW4FNyplptWQJFN33eLxsN7Z4w07LPI2qGf65blK0fn/GCac3LQwKPG5?=
 =?us-ascii?Q?SbH05MmZyH3DVIX2x9ckidJX9UrkXECZVupx7HafnIGIAdeeVJCGUEIWC+iM?=
 =?us-ascii?Q?qNOHRvaZci8A3NJkJSO+wLPovMi8b1mhxV60oxjiXwqvN7LFG2O0iOhwxEeb?=
 =?us-ascii?Q?+OPV4CslHrIVKZU5nwYe8JUAXonabj8pxIxdipIEhTd3/lpczERPtsCWsrhr?=
 =?us-ascii?Q?ga11waEjGSytqheJyRhvSoKHNJjn6sHV1X1TRzExpUMT/FC0VXq7PdhgLy8R?=
 =?us-ascii?Q?aF4yAF+OvSPcR62S8L3GmZqw6/3K0wc1t/EEKEa7Mw1BQ29ob0J9kehNWYgs?=
 =?us-ascii?Q?FyOpJf41A5YRChU9SMWNVnfhZlUWh+n9KxHUY8XhBUujvXQ7RBgZri+x3mZK?=
 =?us-ascii?Q?fpSIPODh3g7KAoDUpHYBN7LW5IJ23GIIxVhHLudQSvfKQ76GQCSpb4O1psDp?=
 =?us-ascii?Q?6J0qxwj+sQqpkPiNjwpEhB6l0ScxkaA/F9DfPnW14k3luzAjtJVTdT9cbU0Q?=
 =?us-ascii?Q?FDNLywQ/T4LX/DGb8fqhugD5RRs+kSXHi1eJhYnhsK3QiPO6+n/kKalX+6HE?=
 =?us-ascii?Q?uhbctQLhgLYP5UY5vD9LYngx2asZ64v42NWoZ5950sLjFFrO+KVCoKhExpvP?=
 =?us-ascii?Q?TzBBVpyAnXbcvwGKu88VMhcupXdPJ8PzJc6uZ/6hZ5yUyQK5J/n3ClW24O6F?=
 =?us-ascii?Q?Wm4QmQpTWXHm7One2itjzXcKT/838z2krTyckhYY5FtqMP/g1l2EnPOikaey?=
 =?us-ascii?Q?zseNTwhsXNz5WkMnzu96lHeNWRa7xB26CQzSs6ODLMytVITULXEyl1j4W13I?=
 =?us-ascii?Q?swZ5BLBmcT280EePZtHaBrlFyImwZ/+mj6lWw01IGB8so8SsvJ9r?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 60df7235-ca12-4ded-ddc2-08dee3c1a9a8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 05:10:05.3450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUxElqfIPLFIEIUHYr2MUE22R4uI8qY0xbFf+0p7EkqWsaGsbXiw2Fq9aKDGN17AzD5jP1BKC8DIWXY9FOso7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3119

Add a function description and a user guide for pci-epf-dma. Describe
the BAR-resident metadata consumed by dw-edma-pcie, the configfs
attributes, endpoint controller requirements and the host-side DMAengine
usage model.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v5:
  - No changes.

 Documentation/PCI/endpoint/index.rst          |   2 +
 .../PCI/endpoint/pci-dma-function.rst         | 188 ++++++++++++++++
 Documentation/PCI/endpoint/pci-dma-howto.rst  | 201 ++++++++++++++++++
 3 files changed, 391 insertions(+)
 create mode 100644 Documentation/PCI/endpoint/pci-dma-function.rst
 create mode 100644 Documentation/PCI/endpoint/pci-dma-howto.rst

diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
index dd1f62e731c9..cd4107e02ec2 100644
--- a/Documentation/PCI/endpoint/index.rst
+++ b/Documentation/PCI/endpoint/index.rst
@@ -15,6 +15,8 @@ PCI Endpoint Framework
    pci-ntb-howto
    pci-vntb-function
    pci-vntb-howto
+   pci-dma-function
+   pci-dma-howto
    pci-nvme-function
 
    function/binding/pci-test
diff --git a/Documentation/PCI/endpoint/pci-dma-function.rst b/Documentation/PCI/endpoint/pci-dma-function.rst
new file mode 100644
index 000000000000..4de02553f5ff
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-dma-function.rst
@@ -0,0 +1,188 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+PCI DMA Function
+================
+
+:Author: Koichiro Den <den@valinux.co.jp>
+
+The PCI DMA endpoint function exposes an endpoint-integrated DMA controller
+to the PCI host as a PCI DMA controller.  A matching host-side driver
+discovers the endpoint DMA metadata and registers the delegated channels with
+the Linux DMAengine framework, so host DMAengine clients can submit
+transfers.
+
+An endpoint Linux system can already use an endpoint-integrated DMA
+controller locally through the normal DMAengine API, for example to transfer
+data between endpoint memory and host addresses reachable over PCI.  The PCI
+DMA function provides a different ownership model: it delegates selected
+local DMA channels to the host, so a host DMAengine client can request and
+program those endpoint-side channels through the host's DMAengine API.
+
+To make that possible, the endpoint function publishes the DMA controller
+register window and descriptor memory layout to the host, reserves the
+selected local DMA channels on the endpoint side, and lets the host program
+those channels directly.
+
+Constructs Used for Implementing DMA
+====================================
+
+The PCI DMA function uses the following endpoint-side resources and
+configuration:
+
+	1) DMA controller register window
+	2) DMA descriptor memory for endpoint-to-RC channels
+	3) DMA descriptor memory for RC-to-endpoint channels
+	4) MSI or MSI-X interrupt vectors selected through configfs
+	5) One endpoint BAR used to publish metadata
+	6) If needed, one endpoint BAR used for dynamically mapped DMA windows
+
+The endpoint controller reports the DMA controller register and descriptor
+resources through the endpoint auxiliary resource interface.  The PCI DMA
+function uses those descriptions to build the host-visible metadata and to map
+resources that are not already visible to the host.
+
+DMA Controller Register Window
+------------------------------
+
+It contains the DMA controller registers programmed by the host-side driver
+to submit transfers, control channels and handle DMA interrupts.
+
+DMA Descriptor Memory
+---------------------
+
+It contains the descriptor memory used by the DMA controller.  The PCI DMA
+function exposes descriptor memory for the delegated endpoint-to-RC and
+RC-to-endpoint channels.
+
+MSI/MSI-X Interrupt Vectors
+---------------------------
+
+They are used by the delegated DMA channels to signal completion and error
+conditions to the host-side driver.
+
+Metadata BAR
+------------
+
+It is the endpoint BAR used to publish the endpoint DMA metadata and handshake
+bits.  The BAR remains stable while the endpoint function programs the DMA
+windows.
+
+DMA Window BAR
+--------------
+
+It is the endpoint BAR used for DMA resources that are not already visible
+through a fixed BAR.  The endpoint function may switch this BAR to subrange
+mapping after the host-side driver has found the metadata BAR.
+
+BAR Metadata
+============
+
+The endpoint function places a small metadata block at the beginning of the
+selected metadata BAR.  The format is defined in
+``include/linux/pci-ep-dma.h``.
+
+The host-side driver scans the function's assigned memory BARs, looks for the
+endpoint DMA metadata magic, requests DMA window programming, waits for the
+READY bit, and then parses the metadata to find the DMA register window and
+descriptor windows.
+
+::
+
+	+----------------------+ metadata BAR offset 0
+	| endpoint DMA metadata|
+	+----------------------+
+	| optional padding     |
+	+----------------------+
+
+	+----------------------+ DMA window BAR offset 0
+	| mapped DMA resources |
+	+----------------------+
+	| optional padding     |
+	+----------------------+
+
+The metadata can also reference resources that are already host-visible
+through fixed BARs.  For example, an endpoint controller may expose the DMA
+controller register window at a fixed BAR offset while descriptor memories
+are mapped into the DMA window BAR by the endpoint function.
+
+The metadata is BAR-resident instead of a self-contained PCI Vendor-Specific
+Extended Capability (VSEC).  Some endpoint controllers do not provide writable
+configuration-space backing storage large enough for a new VSEC payload, while
+they can map endpoint memory and controller resources into a BAR.
+
+Channel Ownership
+=================
+
+The ``wr_chans`` attribute exposes endpoint-to-RC DMA write channels.  The
+``rd_chans`` attribute exposes RC-to-endpoint DMA read channels.  The function
+reserves the selected endpoint-side DMAengine channels so that endpoint-side
+DMAengine clients cannot allocate and use the same hardware channels while
+they are delegated to the host.
+
+The current metadata revision describes channels in dense, zero-based order.
+For example, ``wr_chans = 2`` exposes write channels 0 and 1.  Skipping a
+hardware channel in the middle of the exposed range is not supported.
+
+DesignWare eDMA unroll and HDMA compatible layouts require each exposed
+direction to be delegated as a whole.  For example, on a controller with two
+write channels, ``wr_chans`` must be either 0 or 2.  DesignWare HDMA native
+linked-list mode uses per-channel registers, so a smaller dense prefix can be
+delegated.
+
+Interrupts
+==========
+
+The PCI DMA function exposes DMA interrupts through MSI or MSI-X.  The common
+endpoint function ``msi_interrupts`` and ``msix_interrupts`` configfs attributes
+select the interrupt vector counts programmed into endpoint config space.  At
+least one MSI or MSI-X vector must be configured before the function is bound
+to an endpoint controller.
+
+Transfer Addressing
+===================
+
+The host-side DMAengine client supplies the endpoint memory address as the
+DMA slave address.  For example, the ``dw-edma-pcie`` endpoint DMA metadata
+parser passes that slave address to the DMA controller as a raw endpoint-side
+address instead of translating it through a host PCI BAR resource.
+
+The host memory buffer used as the other side of the transfer is still mapped
+using the normal DMA mapping API on the host.
+
+Endpoint Controller Requirements
+================================
+
+The endpoint controller driver must expose the DMA controller register
+window and per-channel descriptor memories through the endpoint auxiliary
+resource API.  Endpoint controllers with other DMA register layouts also need
+matching metadata and host-side DMAengine driver support.
+
+Current DesignWare endpoint DMA support exposes only channels with descriptor
+memory; HDMA native non-linked-list mode is not supported yet.
+
+If any DMA resource is not already host-visible through a fixed BAR, the
+endpoint controller must also support BAR subrange mapping and dynamic inbound
+mapping, because the DMA window BAR is assembled from those resources.
+
+Current Support
+===============
+
+The current host-side support is implemented in ``dw-edma-pcie`` for
+DesignWare eDMA unroll, HDMA compatible and HDMA native linked-list layouts.
+Other PCIe controller DMA implementations need corresponding host-side
+DMAengine driver support.
+
+The ``dw-edma-pcie`` PCI ID table does not contain a generic endpoint DMA PCI
+ID entry.  Users need to bind the host-side driver explicitly using
+``driver_override``.
+
+The current metadata revision requires the exposed channels to be a dense
+prefix of the hardware channel numbers.
+
+Security Model
+==============
+
+The interface is intended for trusted endpoint/host deployments.  A delegated
+DMA channel can access endpoint memory addresses supplied by a host DMAengine
+client.
diff --git a/Documentation/PCI/endpoint/pci-dma-howto.rst b/Documentation/PCI/endpoint/pci-dma-howto.rst
new file mode 100644
index 000000000000..4bdce63c6f7f
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-dma-howto.rst
@@ -0,0 +1,201 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================================
+PCI DMA Endpoint Function (EPF) User Guide
+==========================================
+
+:Author: Koichiro Den <den@valinux.co.jp>
+
+This guide shows how to configure the ``pci-epf-dma`` endpoint function driver.
+It uses ``dw-edma-pcie`` as the currently available host-side driver.  For the
+hardware model and layout see Documentation/PCI/endpoint/pci-dma-function.rst.
+
+Endpoint Device
+===============
+
+Endpoint Controller Devices
+---------------------------
+
+To find the list of endpoint controller devices in the system::
+
+	# ls /sys/class/pci_epc/
+	e65d0000.pcie-ep
+
+If ``PCI_ENDPOINT_CONFIGFS`` is enabled::
+
+	# ls /sys/kernel/config/pci_ep/controllers
+	e65d0000.pcie-ep
+
+Endpoint Function Drivers
+-------------------------
+
+To find the list of endpoint function drivers in the system::
+
+	# ls /sys/bus/pci-epf/drivers
+	pci_epf_dma  pci_epf_test
+
+If ``PCI_ENDPOINT_CONFIGFS`` is enabled::
+
+	# ls /sys/kernel/config/pci_ep/functions
+	pci_epf_dma  pci_epf_test
+
+Creating pci-epf-dma Device
+---------------------------
+
+Create a ``pci-epf-dma`` device with configfs::
+
+	# mount -t configfs none /sys/kernel/config
+	# cd /sys/kernel/config/pci_ep/
+	# mkdir functions/pci_epf_dma/dma0
+
+The "mkdir dma0" above creates the ``pci-epf-dma`` function device that will
+be probed by the ``pci_epf_dma`` driver.
+
+The PCI endpoint framework populates the directory with the common
+configurable fields::
+
+	# ls functions/pci_epf_dma/dma0
+	baseclass_code   msi_interrupts   progif_code    subsys_id
+	cache_line_size  msix_interrupts  revid          subsys_vendor_id
+	deviceid         pci_epf_dma.0    secondary      vendorid
+	interrupt_pin    primary          subclass_code
+
+The PCI DMA function driver also creates a function-specific sub-directory.
+The numeric suffix depends on the endpoint function instance number::
+
+	# ls functions/pci_epf_dma/dma0/pci_epf_dma.0/
+	dma_window_bar  metadata_bar  rd_chans  wr_chans
+
+Configuring pci-epf-dma Device
+------------------------------
+
+The host-side ``dw-edma-pcie`` PCI ID table does not contain a generic
+endpoint DMA PCI ID entry.  Choose a PCI vendor/device ID for the endpoint
+device::
+
+	# echo <vendor-id> > functions/pci_epf_dma/dma0/vendorid
+	# echo <device-id> > functions/pci_epf_dma/dma0/deviceid
+	# echo 1 > functions/pci_epf_dma/dma0/msi_interrupts
+
+The PCI class defaults to ``PCI_BASE_CLASS_SYSTEM`` and
+``PCI_CLASS_SYSTEM_DMA``.
+
+The function-specific attributes are:
+
+============== ============================================================
+Attribute      Description
+============== ============================================================
+metadata_bar   BAR used to publish the endpoint DMA metadata and handshake
+               bits.  It is kept as a stable BAR while the DMA windows are
+               programmed.  If this is left unset, the first usable BAR that
+               does not already contain a fixed DMA resource is used.
+dma_window_bar BAR used for DMA resources that are not already host-visible,
+               such as the DMA register window or descriptor windows.  This
+               BAR may be switched to subrange mapping after the host driver
+               has found the metadata.  If this is left unset and a DMA
+               window is needed, the first usable BAR different from
+               ``metadata_bar`` and not already occupied by a fixed DMA
+               resource is used.
+wr_chans       Number of endpoint-to-RC DMA write channels to expose.
+rd_chans       Number of RC-to-endpoint DMA read channels to expose.
+============== ============================================================
+
+A sample configuration for a DesignWare eDMA/HDMA compatible controller with
+two write channels and two read channels is given below::
+
+	# echo 0 > functions/pci_epf_dma/dma0/pci_epf_dma.0/metadata_bar
+	# echo 2 > functions/pci_epf_dma/dma0/pci_epf_dma.0/dma_window_bar
+	# echo 2 > functions/pci_epf_dma/dma0/pci_epf_dma.0/wr_chans
+	# echo 2 > functions/pci_epf_dma/dma0/pci_epf_dma.0/rd_chans
+
+``wr_chans`` and ``rd_chans`` default to 0.  At least one channel direction
+must be configured.  The selected channels are exposed in dense, zero-based
+order; for example, ``wr_chans = 2`` exposes write channels 0 and 1.
+DesignWare eDMA unroll and HDMA compatible layouts require each exposed
+direction to be delegated as a whole, so set a direction to either 0 or the
+number of hardware channels in that direction.  DesignWare HDMA native
+linked-list mode allows a smaller dense prefix.  If ``dma_window_bar`` is
+configured, it must be different from ``metadata_bar``.
+
+The common ``msi_interrupts`` and ``msix_interrupts`` attributes select the
+number of MSI and MSI-X vectors exposed to the host.  At least one MSI or
+MSI-X vector must be configured.
+
+The function-specific attributes can only be changed before the endpoint
+function is bound to an endpoint controller.
+
+Binding pci-epf-dma Device to EP Controller
+-------------------------------------------
+
+The DMA function device should be attached to a PCI endpoint controller
+connected to the host::
+
+	# ln -s controllers/e65d0000.pcie-ep \
+		functions/pci_epf_dma/dma0/primary/
+
+Once the above step is completed, the PCI endpoint controller is ready to
+establish a link with the host.
+
+Start the Link
+--------------
+
+Start the endpoint controller by writing 1 to ``start``::
+
+	# echo 1 > controllers/e65d0000.pcie-ep/start
+
+Root Complex Device
+===================
+
+lspci Output
+------------
+
+Note that the device listed here corresponds to the values populated in the
+endpoint configuration above::
+
+	# lspci -nk
+	01:00.1 0801: <vendor-id>:<device-id>
+
+If the host was already running while the endpoint function was configured,
+rescan the PCI bus after the endpoint side has completed the configfs setup
+and started the endpoint controller, if the platform supports it.
+
+Bind the endpoint DMA function to ``dw-edma-pcie`` explicitly with
+``driver_override``::
+
+	# modprobe dw_edma_pcie
+	# echo dw-edma-pcie > /sys/bus/pci/devices/0000:01:00.1/driver_override
+	# echo 0000:01:00.1 > /sys/bus/pci/drivers_probe
+
+The device should then be bound to ``dw-edma-pcie``::
+
+	# lspci -nk -s 01:00.1
+	01:00.1 0801: <vendor-id>:<device-id>
+		Kernel driver in use: dw-edma-pcie
+
+Using pci-epf-dma Device
+------------------------
+
+The host side software uses the standard Linux DMAengine API.  A DMAengine
+client driver running on the host must request one of the channels provided by
+``dw-edma-pcie`` and submit a transfer.
+
+For an endpoint-to-RC write transfer, the DMAengine client uses a host DMA
+buffer as the destination and an endpoint-side address as the slave source
+address.  For an RC-to-endpoint read transfer, the DMAengine client uses a
+host DMA buffer as the source and an endpoint-side address as the slave
+destination address.
+
+Troubleshooting
+===============
+
+``pci-epf-dma`` requires endpoint controller support for DMA auxiliary
+resources and MSI or MSI-X.  If any DMA resource must be mapped dynamically,
+the endpoint controller must also support BAR subrange mapping and dynamic
+inbound mapping.  Binding the function to an endpoint controller fails if the
+required capabilities are not available, or if both ``msi_interrupts`` and
+``msix_interrupts`` are zero.
+
+If ``dw-edma-pcie`` fails to probe on the host, check that the endpoint was
+bound to the host driver, that the endpoint BARs were assigned by PCI
+enumeration, and that the endpoint DMA metadata READY bit was set after any
+DMA window BAR submaps were programmed.
-- 
2.51.0

