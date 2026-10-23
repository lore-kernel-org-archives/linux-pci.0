Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792770064;
	b=S4mm+sZ6y+zkA/icWPtdhAgq6gc9M/RNwNiHOtE4I7Lkw+xANOPZxU/5ndhJer+Hoo0V
	 NaP7W0GkWuhvGAnT5rSHWrmuBAxCUvBFDSffhOxBxCMwuk1FetWfteeUVwCkdIrnljDwR
	 uYxt4yonvKIL8BjrC+UDCaBnnsK+q7dYZuny4WvXqcNtjfEu4bNqRXQBzzAoRMiXpllnT
	 OIQSfbcdc2kg/EPI7frLgtHaGKZ/hUjLKaMQmCrpZuiLrHfbMEVcsolYWKFOs/3gLtrpE
	 A86p2k1LMv5A5i8MYGYx53ddaGETHy04JdjB/T0scEQi9yNkzEqWfHEEZgbKZlJff0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770064;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=sGFuUjDXcH4/q0VsCV6HZ3jvsDaDFosc6BZmFIuEpJQ=;
	b=neBMS05uNxZmy/3StK+SnH2KKw2Qyo2mA/qhYBdj9GZNAAL+ZE6wKqL/424HvhhjjK84
	 jOCKkphi+UMeizrXCQEYQ2EWdZKDHK7vt2Yhgc0yZePieiPrC9IzRnAjUZCHTEXHLhCgu
	 tqJd+gTcqGpFCnzgRy7gxeS7SKJHU7yL0iHfimaF7LSIhpm3Bi9mdLBW/eVKo1XWKoYyU
	 7O2zwSZShkjuMH8u5J0r3ghv/JncQiVQpFeAnBw7j87KFgRb8uW0MGgT6hGRVrGPOEMSR
	 MVRyZzGqv6zyAmtpjBA+fYjbngtSn3LC6HU0ejkqzYGCw3qUWbvkzmqIPMtO1yodOgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fSkON16I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.5
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C09606A31B;
	Fri, 23 Oct 2026 15:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68C09606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fSkON16I
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojdtotUUdSazHyC8RPpDzDRxavLV+6tqtKTIHO+fjU+WePL3C1TwST05S+HgazCrFHcQPZlXcxg9R7EChx8RmzNfw5f82LusvgaAZe7XhNRzVTJe06oikVHBLiaZ+gipsx1Mcw+NI3Qkc6Oq8p+VhJKq/GR5szsmFfltG314qfepP0LkvSHWsAbP6xG1Aa2cwENuIXiqtfou+3tEaHRBnfmA7zcKKMzVL+lp+KR1yrNb3HjyJtfIfFKQjlcuisayHTj+t8CrUVqj0RaGqy65s2z6a8G1Dwh5NjhceLwSbqPjjpjxutZ2YPRCsD1cV7TFImUydBNFOIo/dJypnFKk1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGFuUjDXcH4/q0VsCV6HZ3jvsDaDFosc6BZmFIuEpJQ=;
 b=Rpekm/0OO0dTltb259bpwHqW0RHJyuD/K/h6GRfxhFg/Hoy2lvV8BjJFhNOsitw8K/xoRurZw22D46nY8/eGqPoJgOWKUBlY2uR6ywSV0A3D27TUF1mioxrwwkWwSYyfU4L138B/TaHBPj1AbWvcajKM9CeoyCS3CMY3gSaR73hkTJXz3ZvATwVCX6zS4HAU5x82jZxQNnPtgaAtePxqZ5pFCqXbgIEwajJKsPIc3cZxkTH2UT5ChtVJ5xkZg35jEtiN8Upqev9r04UYho2jIxNIrxhda1IYZPGPevIDXpfkQofZhP6UUNPNgvrG3aRSHC6LTVoLhwFj+2y2zYE/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGFuUjDXcH4/q0VsCV6HZ3jvsDaDFosc6BZmFIuEpJQ=;
 b=fSkON16I2x7Q/LxYmFqgRNpel0Uba+DM8TLdqNOyL2KclY7PsR7rDJyL6YcPne9xZutO1HvE/DT3SotLnMblEJpLikYdKm5YEPhaNNWnKvv4fiLuQfDUHF+b/cDPbp+aK9JHBayOsBSy+RgL+RID/bsXe7dFlEWhgNFmKRahx25rQXl6bNCUlBJmdtbjl03OrGcmtrx+sTuTg4uST+iaHIUymp0qBWnbNe3Tte2upnXrfAL5CUDVCh3vCKmV5iu6svxa4mzYhtPw65bcpKCLv9vN4+cJM1aHW32XfYC9rudkc0iXmkP9VdpRzMujl7qO5aCpo1Rp0ITEFPL94SwNqg==
Received: from SJ0PR03CA0343.namprd03.prod.outlook.com (2603:10b6:a03:39c::18)
 by CY8PR12MB7753.namprd12.prod.outlook.com (2603:10b6:930:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 15:40:57 +0000
Received: from CO1PEPF0001885C.namprd02.prod.outlook.com
 (2603:10b6:a03:39c:cafe::61) by SJ0PR03CA0343.outlook.office365.com
 (2603:10b6:a03:39c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Fri,
 23 Oct 2026 15:40:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF0001885C.mail.protection.outlook.com (10.167.249.245) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 23 Oct 2026 15:40:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 23 Oct
 2026 08:40:30 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 23 Oct 2026 08:40:28 -0700
From: Simon Song <xinmengs@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
	<skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
	<tmgross@umich.edu>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
	<alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
	<boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<peter@colberg.org>, <xinmengs@nvidia.com>
Subject: [PATCH v2 01/12] rust: pci: add VFIO override device IDs
Date: Fri, 23 Oct 2026 08:39:56 -0700
Message-ID: <20261023154009.2246627-2-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261023154009.2246627-1-xinmengs@nvidia.com>
References: <20261023154009.2246627-1-xinmengs@nvidia.com>
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
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885C:EE_|CY8PR12MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: c299ef05-ebec-4311-d3d8-08df311c070b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|23010399003|1800799024|11063799006|56012099006|261022075727099003|261021121427099003|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	zoTVyVcRHtKBhxksdHRC3ekMVk/WQ8aCAN7PMbekPP0HDKSxrNcS2C1FbF+FTsRSl+CRzc3SA11B7ab7uJ0uhCpA8uxYVQvOkFVq0mg69jnVJd2bWHHoJr0tcnX9ih+mr0ffLNXzsELZVBWpE+fhMUznzKvUGojAwjWniqHuDvx+2rCQe1IF0qmdWDkSt4esBn0BWLZdja/A5qo6NdnMZa3PAAnMCckoEibrc7nKg4bI6zSuv1TDJQCjAodfb7DCLOghfwkzBm496dn6Ip5Zb3vMBUaC3Ek7GDhOopGtkAiKBnwxXzsrXOHk/30PDZzYMTWOJ0Fvivd8cLtCEO2DC52tLjNz9KWOg7qiNm17Gefa/VfUlnBHgtCw0+bb5nEYc5MQFw0Q9ZYZNJ1BH8uUnlmNmTrpjizASgm5s5MaAPxDNH7OTwOMSDgvENVNcm93v4RbFzVYgfsefv71FmmU7dCDclZAY3WdSda/BQkoCFY9om1Gz9DBAIv8jVZQm7aHm9+px9I4Rq82IM7iyWwcjQ+3lhFFehoIULtR3qiWZ7e65EHJ5Rh4FQzZMo2yCM7KoH/dC1CpYxQmu3kH8LE7WZbu3ceiGxoyGIXiqKIvbQcP4AULSvx8VsakWWU7bt7k4Yhk5UC9x8O+DH5GknXMtKT11Y1MQ1IgfPt0QKAETDtSdz10O8MoUk5VhURtPPymCjb8Z5DpClhgciA8f+y2TA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(23010399003)(1800799024)(11063799006)(56012099006)(261022075727099003)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2RIj28q97JhZlVjMceFhZbjePZzcQy4SfAqOV3tiIYh5hVXRBuvrZoAIY7VO++ikFnm76qpwuA6KNOjvKJVpR2W3MBl8ycF+5cHkSNJpJqcJAlYZrtuhyQtGzHO7umwmLyYTfL0GXD2Km0Ikd3Uc1KxXZNEspuk4DfiRVWALF+2V+8B7WrgI97Jf1ODAgM68jVUPGlGxy2JLhH11M5WpWqmSFp6kZYehuKfvlPl9tvlmJbTzMVOBRo35L85c2X0l/jqVMDKRi7bK+9qjiA4tyPGjngjVRuT9QjzgDU6rOUxh/4HqAcfXrZD4ymeUY30cext/PC3J+f6s2kniIkl6bdM/36E7tMyxVvNpoSeifWYCfVLPujSsl07VhVBXIzYcvoltuw2LV9+o88RIlOC0H55Rx82tzIF5SvFJ9EgyLzmbe5MOzXztRpGMrXYxQZq3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:40:55.6328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c299ef05-ebec-4311-d3d8-08df311c070b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF0001885C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7753

From: Danilo Krummrich <dakr@kernel.org>

VFIO variant drivers need override-only IDs and VFIO-specific module
aliases so userspace can select them for PCI assignment.

Add a DeviceId constructor equivalent to PCI_DRIVER_OVERRIDE_DEVICE_VFIO,
matching a vendor and device without restricting the PCI class.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/kernel/pci.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index d83492e06ce..10864ffda4e 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -206,6 +206,13 @@ macro_rules! module_pci_driver {
 impl DeviceId {
     const PCI_ANY_ID: u32 = !0;
 
+    /// Equivalent to C's `PCI_DRIVER_OVERRIDE_DEVICE_VFIO` macro.
+    pub const fn from_id_vfio_override(vendor: Vendor, device: u32) -> Self {
+        let mut id = Self::from_id(vendor, device);
+        id.0.override_only = bindings::PCI_ID_F_VFIO_DRIVER_OVERRIDE;
+        id
+    }
+
     /// Equivalent to C's `PCI_DEVICE` macro.
     ///
     /// Create a new `pci::DeviceId` from a vendor and device ID.
-- 
2.43.7

