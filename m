Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795150039;
	b=oLWnCPkLYSNfRo3i3w9yvHer3VT/B/QcQCAmRf4jq81ZU53cgRViCD5mDPPYtFvR8xAL
	 decP8vfpCUrwXH/eUq0EPcOsrGGHj05X8AFMNqn51lJKrPjgjvvACd0p35rG6SGVIQ98A
	 XZQR/NdktIk2eZDNMg1hKfLeQFUc09jj2wpw1xEWPNoHJaUrYgf0NCoW13sw35sD5KZqP
	 9/IURlIDyiPMnPmbn02ceQg2rft6SsQLaaOcmR1Dv61Vj6dQ4CqIHTc5GTJue0WfcfIBl
	 SBmR/2zyDXoANZQqO1eWHrKpT5q3cdDSXbFhv8t4ri7Czgq2P8nvWewbEXbT1LDKmlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150039;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:X-NVConfidentiality:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=OyhMVP0lDKL6tPEy7UhCKl4Q9OEsLxDeLMAjco1QbBw=;
	b=5bamNAKpyC0tJ5AQ2RWRFB5Pd2KP+wCKqPwwgF7i8EFKsx1cM2X9re2XSwbYG+BsyeQr
	 YXPoOm2dqrfp4L45lTfgI6zRw9yzOccxzMhWjY2+7i4tISia+vMPaX6UTong7vjyFv7fR
	 brE5ffW8jxN4AjHwKU2X+Vf1///+JiboZXHeHd1sctv99WX7JMlXmJ9j639xjkb7coBPd
	 mqfLupoEKxzfN8TL6jydhg8OPwIRML3CtmULNKXCuS7O2EcirxbDxBW2aMDhBwq8qVnIc
	 ab5wWGwuJdV8nzVeCzv2NmNQTVzYSsibj2/m0m7H+RFkSVvZwd3P6+84I8C9scycCIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hJ6yGxrL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.35
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250B860A2628;
	Fri, 20 Nov 2026 04:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 250B860A2628
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hJ6yGxrL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0/X+Dkc6vB8uTZkmnC0tsbEKKXYuc/5yhiSPc3OT7EH8fgoL2+Xk3ypGjuQ23sv3Wod8DB4nXyHl78dBRsVP16REEPO0WEPIe2bNwJRitO1II7/DeiguR1xVlhTbZJbM5wqDwrUINPegt/pZ5rhtLE+ltZOjgcPonuohybDckZZ11TMiIgUA2oMUt81EZY09D7F63z0eP53WFzTk6M8c+YuO+eqebOT9dD7tooG3J356paFWBFQk2iBhG8lXU56cXrBMwvOytdAxE/inxSMibHeciZooP1VNnv9Y1s2CKF0uvR0xFhgFYfJ1+iQ1Z/WEGW0kbibn8oGP2Ka4FL9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyhMVP0lDKL6tPEy7UhCKl4Q9OEsLxDeLMAjco1QbBw=;
 b=doIEAusO8MMIq4WRONc/vMM+FHX1ilFFNIol2AQWsSTllTzhcbHphR7tMMUpI13jBsS7mcuC+c4pTJqxGPoLJGQNzFjGcw9qoPUTSTB4Nz7aOuFAfiHHvL/OlPMhYtwRRVlJ9vYtKW6DYvT3f4Ojx8I6Rqr8kAK+ERM57Scn+QTtD5MxV7h+mpJlD+0rQaA2jYeRlEs1lvpcVK8JBCdH/8sXqxNWyU3QGznqlNbz5IxKtcEnnWY2HfK85KgnM1ZGrCJSO5B3BdQS61OsvLrCxnOis32eNkKfdPWxWyTEv3MdWjgtSbEVZTNnMOTjijwQ3LHBNMdqNlIf6FV0LDOIog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyhMVP0lDKL6tPEy7UhCKl4Q9OEsLxDeLMAjco1QbBw=;
 b=hJ6yGxrL1PQUrQs5HeQ6d7kFy+RTPaynx0kNJ2yFGc83EAySFZCw9moB7bhatyrNOPm7qp+m7Jnzl+UHetHbBbGask8UuCqS4WUwTJcd0F3W3P6nQ7Jyl2LrKvTHk7hgKrJVAOOQJAYPNav+8Bw9Au31PmqsJKcZ6QNruaDtc3VS+uPePngOn/eFI4sSumxiSL6tEPE9mPqouKkBs0LzvFl9X2/bCABwsYkIyOAa0f9DKbsmGnQkI8bG2A3/JJUltAcLDLXNBsVZxF2McSP74Qu4xkyTmejx/asVxAcS3/usXm8pFvms3LAI3lmJoiSCpUrimziwuRCAlj/tXw152g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by LV0PR12MB297887.namprd12.prod.outlook.com (2603:10b6:408:608::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 04:47:17 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 04:47:17 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>
Cc: Timur Tabi <ttabi@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Eliot Courtney <ecourtney@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	LKML <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 8/9] gpu: nova-core: gsp: add the r000 load-and-execute bootloader handler
Date: Thu, 19 Nov 2026 20:47:03 -0800
Message-ID: <20261120044704.165223-9-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120044704.165223-1-jhubbard@nvidia.com>
References: <20261120044704.165223-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::7) To SA1PR12MB5614.namprd12.prod.outlook.com
 (2603:10b6:806:228::7)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|LV0PR12MB297887:EE_
X-MS-Office365-Filtering-Correlation-Id: 3317aaa4-5f3b-479a-57a8-08df46c15a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|261022105027099003|10067099003|261022075727099003|11063799006|56012099006|261009221227099003|261009223027099003|261021123027099003|261021121427099003|261102123227099003|261028144727099003|261022115727099003|261026140227099003|261026121527099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	3gf5uiFDgE/cGZLGG/WjxycMcQ7JGdxJ0arrlG/9ITJu6TkxNjP96zEitUwlxdRlVn6tr8PcPUwJJFnEczzNR2tnUBKwuswbHz4fhzLZXEYEjskMUlXrE5HmrEYOmKpkGQcF12kxYG+pKhtQ8Ef2WlhO0dPo7DlO6fibpckjk8psbwI4f+PwD5aPAzZSom4qZrcoYgQ5Tk5Ws/+Bi7ZV6z9xgnsxw9t4BJDCDI3gNRC6gkcGifQ+HKSXFaXWx5OLXnaWb176z7rUs/3Jfc5ULf03TjI9xekqgGHv3yUEuVrfE3CVv6MJFvNgSvBdUiqDlJ2hM9jDSfsZwAsQOs5sRBJcY9vwErOY2w0nFijL+/rq1nLkCBXXHVhJE55K8/UUDWZUW2o1ZA3BsSUtkpCEq1VUvNJfC8/AUZJfn1/CGqGXwdpes6MDwtBdX+oL/qkEQel04dNwFZUaWRgoWRgjiMWFKVd+zVGXjGXU1gfDSw410Vsksgn5UGw8UAzMzfmQ7WJgYsDqLK+jOCpZKQs63g0zVPp1yolH0aEBQjssTNxr9Cj6q4BX/GAhYTaMVLzR1DBCW9HWUBQ5HnWOQkkF7fHCo2za1SazEbueJbrBtjN2YU2jz6LCxcxQgC4Hutc0oEHZDFSNLRmxlBaEbUPyCk07ajhgIPBjvZar7o2zXaI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(261022105027099003)(10067099003)(261022075727099003)(11063799006)(56012099006)(261009221227099003)(261009223027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261022115727099003)(261026140227099003)(261026121527099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?alXRL1YHB1lq2cbgbO6YURCoAvvbJHUxLWVYr96HQHJRTJZxvwDd3fxPz1Tc?=
 =?us-ascii?Q?Jvd4MKUOhrVGIz4mNQKH0n3ThSB/iUPnZj53jW0E/irWNaU1fCwrbiRwpDix?=
 =?us-ascii?Q?bTUWBQAPBReXxhH+FzvnXFoWw4qbm8n+5Ghl+zEcw+HBicn+KtmPVYXlX62U?=
 =?us-ascii?Q?bJlw2kIyjBSw4BpqwoWSPw7HTMs3XxtcT+xbPHcfoF/uBkp4jdJHk4rL5Vyc?=
 =?us-ascii?Q?sLeK2GqdBGuOXehBmjqreKdwuQZN3egWYeTwKM6EfN/rcg0Mksmh9ODHXywt?=
 =?us-ascii?Q?Nqqg54zUTduhQbFbv3tblX49oZmBLMXLCjYED1q+LRRxhRZcw4ah2MG96XMk?=
 =?us-ascii?Q?ZB1bEbm359WwZQF0SxrSbLwQnJFVvnwosnY/vV0CDUFxzVVFcp290FLN6tKg?=
 =?us-ascii?Q?edlKCTEsW6ma3gGmyG9ThuQYv4WY+retjXeGSuK3iBAAeNOzwNZUSBRG/3xF?=
 =?us-ascii?Q?3pAPAaiZTem53Drxhvx6jdlQj3JLG4uD9FgjPT2XjXEZ0Y73I6rdVEYUrarA?=
 =?us-ascii?Q?fPqezutbGK9Ov6zBH1fHsi+k3sprBTv1YsJHph25tCVgMU0GH/6rjbaWznXz?=
 =?us-ascii?Q?i8H9/Cxrtg04Sjx1IoBQb/YxhPIl52UcxGWrjVFv0pmHdlMjxH1m0N15bBr1?=
 =?us-ascii?Q?KdN306yEvPWMIN0gVQyZc/wkyTIRF61hnew9/sPQ+ru7dMwEDl6fjE4muQ70?=
 =?us-ascii?Q?suCe0wh0p6Ib9qTq2zMA6HerGHeFjIoDkCNeZbYqUh/yoaMuHvlyeYxlAubh?=
 =?us-ascii?Q?2jaRV3n9iPLn4kMitGs2NaluHH1u9CNwMhyUswIeFO+POW7Tavw3M0HHBQ9h?=
 =?us-ascii?Q?7d5Yjf60t5K451B2GUMqPr/din5luRuai0CkssAUMT1hGRkFMEerPFtEYn7U?=
 =?us-ascii?Q?Yk6JNjxmjM0BLhdOhhXMXUl74TZHd/1T8UKarsgcz+NeNEmrisfDKYcN4NCb?=
 =?us-ascii?Q?SrzDzX+DTcrXnolvQIN0QS2CdRYX5/JBPpercRT2NaidOdOJiX+9c4j/57oE?=
 =?us-ascii?Q?OwYZyBjVY2XdAMg5xOKG8v2eoZ5MmGzW9owip2Z8LORF7D4Z4JCuFQFqjZKM?=
 =?us-ascii?Q?LxqCNCvM5wN199HSxxcqbl2FE+jsf8ZO/JIPvvHOT4NFLqLA1JC3KzMuEYYg?=
 =?us-ascii?Q?R0IyNf447mZSAjZmJrFqr0/uus5YRInjKK7eYxDmL3+jVeNyBiJlc+bPyy8W?=
 =?us-ascii?Q?mMSc1+I2uY1Y2+dOsbit8M60tYVFkIqIZtJ4doIOnp35WIXFFwsXpFNcOyT9?=
 =?us-ascii?Q?Vv+78nxwVvrDMK8QQ6U5/YiYSH4o/sETBSXm7lR9e+GnfuxtyJHT1pVlOJFM?=
 =?us-ascii?Q?IjYyZGltfAD5Mivf9F1BYffEWdLawnBi8+ydzcO0yp9bHZXcFlA8LFRauX4r?=
 =?us-ascii?Q?XEhqWwWFesFdL9kuIpyaJcX5gxoBaiDpyIGNuXxp/Lc5WJu5BjIy/q2O18a9?=
 =?us-ascii?Q?d2rnX9fyoyI1pRnFaiChyOBaugc86wMGvsPzKYrF1JWuYZ0XFPZ3SnVJzwyL?=
 =?us-ascii?Q?q8uWY/pC1LG8yX4xA/vY13c1UvPYCOVUMrp3jmsdmde5MYZGzThVXxlxAY/c?=
 =?us-ascii?Q?vMqKQVaLp5Am8QjRekzVFvGlSazgTcKtTl9f4mOL0Pe9nP0A6jsMhQMUekXG?=
 =?us-ascii?Q?suMkcU5e0Onk4ZMSKUcfA8m+nXIRFuNQO5VGMb/Xg4PTR1MLIt7bqfLQ125t?=
 =?us-ascii?Q?mqenOnsF0tovb0TW95mjOnLs2sGIE5FSLzhq8I52c+ZjVG3xlTGmRDM4B1qS?=
 =?us-ascii?Q?IYeuKmjSjg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3317aaa4-5f3b-479a-57a8-08df46c15a4b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 04:47:16.9019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fz9p/ZAfWpzCIxtlG/jHVC6UVMAkP/guufsRB0PeX4N3Dnq5KqaqVkXWBL0GMyPfPe+8y62gEFahDGWHOToafg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB297887

On Turing and GA100, the r000 GSP-RM requires an image to run on the
falcon core during boot, through the generic falcon bootloader. GSP-RM
is suspended while the image runs.

The driver runs the image on behalf of GSP-RM, in the following steps:

1. GSP-RM raises a load-and-execute event, which carries a descriptor of
   the image.
2. GSP-RM suspends the RISC-V core.
3. The driver waits until the RISC-V core is suspended.
4. The driver resets the GSP falcon, which selects the falcon core.
5. The driver loads the bootloader and the descriptor into the GSP
   falcon.
6. The driver starts the bootloader, which loads the image and starts
   it.
7. The driver waits for the falcon core to halt.
8. The driver resumes GSP-RM on the RISC-V core.

Nova-core has no handler for the bootloader's load-and-execute event.

Add the handler, which performs steps 3 through 8.

Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 .../gpu/nova-core/firmware/gen_bootloader.rs  |   8 +-
 drivers/gpu/nova-core/gsp/load_exec.rs        | 164 +++++++++++++++++-
 2 files changed, 170 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/gen_bootloader.rs b/drivers/gpu/nova-core/firmware/gen_bootloader.rs
index 751335c97e35..8d8c94cc19ee 100644
--- a/drivers/gpu/nova-core/firmware/gen_bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/gen_bootloader.rs
@@ -13,7 +13,10 @@
     },
     prelude::*,
     ptr::Alignable,
-    transmute::AsBytes, //
+    transmute::{
+        AsBytes,
+        FromBytes, //
+    },
 };
 
 use crate::{
@@ -123,6 +126,9 @@ pub(crate) fn new(
 // SAFETY: This struct doesn't contain uninitialized bytes and doesn't have interior mutability.
 unsafe impl AsBytes for BootloaderDmemDescV2 {}
 
+// SAFETY: This struct only contains integer types for which all bit patterns are valid.
+unsafe impl FromBytes for BootloaderDmemDescV2 {}
+
 /// The generic falcon bootloader image and its IMEM load parameters.
 pub(crate) struct GenericBootloader {
     /// Bootloader code, zero-padded to a whole number of falcon memory blocks.
diff --git a/drivers/gpu/nova-core/gsp/load_exec.rs b/drivers/gpu/nova-core/gsp/load_exec.rs
index d9a4ccd88289..ab0c2959d3e8 100644
--- a/drivers/gpu/nova-core/gsp/load_exec.rs
+++ b/drivers/gpu/nova-core/gsp/load_exec.rs
@@ -9,7 +9,8 @@
 //!   that verifies an HS binary. The note in "Root of trust establishment" says why the GSP falcon
 //!   stops running GSP-RM, runs an HS binary, and then resumes GSP-RM.
 //! - "Falcon memory subsystem and DMA engine" describes the instruction memory (IMEM) and the data
-//!   memory (DMEM) of a falcon, and the DMA engine that loads a binary into them.
+//!   memory (DMEM) of a falcon, and the DMA engine that loads a binary into them. The DMA engine
+//!   accesses the framebuffer or system memory through the FBIF (Framebuffer Interface).
 
 use core::array;
 
@@ -29,8 +30,13 @@
         FalconBromParams,
         FalconDmaLoadTarget,
         FalconDmaSource,
+        FalconFbifTarget,
         FalconMem, //
     },
+    firmware::gen_bootloader::{
+        BootloaderDmemDescV2,
+        GenericBootloader, //
+    },
     gsp::{
         cmdq::gmc::MessageFromGsp,
         GspBootContext, //
@@ -223,6 +229,106 @@ fn handle_hs_binary(
     )
 }
 
+/// Runs the image of a `GMCAPI_CMD_EXEC_GENERIC_BOOTLOADER` event on the falcon core of the GSP
+/// falcon, through the generic falcon bootloader, and then resumes GSP-RM.
+///
+/// `params` holds the descriptor of the image. The generic falcon bootloader loads and starts the
+/// image that the descriptor names, per [`GenericBootloader::run`]. The handler:
+///
+/// 1. Checks that the descriptor in `params` has the size of [`BootloaderDmemDescV2`], and gets
+///    the FBIF (Framebuffer Interface) target that `params` selects.
+/// 2. Waits until GSP-RM has suspended the RISC-V core, for up to five seconds.
+/// 3. Resets the GSP falcon, which selects the falcon core.
+/// 4. Runs `bootloader` with the descriptor and with [`FLCN_ERR_BINARY_NOT_STARTED`] in
+///    `MAILBOX0`, and waits until the falcon core halts, for up to two seconds. The image halts
+///    the falcon core when it is done, so the handler learns from the halt that the image has
+///    finished.
+/// 5. Logs an error if `MAILBOX0` still holds [`FLCN_ERR_BINARY_NOT_STARTED`], which means that
+///    the image did not start.
+/// 6. Resumes GSP-RM on the RISC-V core, via [`resume_gsp_rm`].
+///
+/// An image that reports a status writes the status to `MAILBOX0` before it halts. The handler
+/// does not check that status, so the result does not depend on it.
+///
+/// # Errors
+///
+/// - `EINVAL` if `bootloader` is `None`, if the descriptor size in `params` is not the size of
+///   [`BootloaderDmemDescV2`], or if the address space and the cache attribute in `params` select
+///   no FBIF target.
+/// - `ETIMEDOUT` if GSP-RM has not suspended the RISC-V core within five seconds, or if the
+///   falcon core has not halted within two seconds of its start.
+///
+/// Errors from the reset of the GSP falcon, the run of the bootloader and the resume of GSP-RM
+/// are propagated as-is.
+#[expect(dead_code)]
+fn handle_generic_bootloader(
+    ctx: &GspBootContext<'_, '_>,
+    bootloader: Option<&GenericBootloader>,
+    libos_dma_address: DmaAddress,
+    bootloader_app_version: u32,
+    params: &GenericBootloaderParams,
+) -> Result {
+    /// Expected size of the descriptor, in bytes.
+    const DMEM_DESC_SIZE: u32 = cv!(size_of::<BootloaderDmemDescV2>());
+
+    let dev = ctx.dev();
+    let gsp_falcon = ctx.gsp_falcon;
+    let Some(bootloader) = bootloader else {
+        dev_err!(
+            dev,
+            "No generic bootloader for the load-and-execute event\n"
+        );
+        return Err(EINVAL);
+    };
+
+    if params.dmem_desc_size != DMEM_DESC_SIZE {
+        dev_err!(
+            dev,
+            "Generic bootloader descriptor is {} bytes, expected {}\n",
+            params.dmem_desc_size,
+            DMEM_DESC_SIZE
+        );
+        return Err(EINVAL);
+    }
+
+    let fbif_target = params.fbif_target()?;
+
+    reset_gsp_falcon_after_suspend(dev, gsp_falcon)?;
+
+    let (mbox0, _) = bootloader
+        .run(
+            gsp_falcon,
+            &params.dmem_desc,
+            fbif_target,
+            FLCN_ERR_BINARY_NOT_STARTED,
+        )
+        .inspect_err(|e| {
+            dev_err!(
+                dev,
+                "Failed to run the generic bootloader: {:?} (mbox0={:#x})\n",
+                e,
+                gsp_falcon.read_mailbox0()
+            );
+        })?;
+    if mbox0 == FLCN_ERR_BINARY_NOT_STARTED {
+        dev_err!(dev, "Image of the generic bootloader did not start\n");
+    } else {
+        dev_dbg!(
+            dev,
+            "Image of the generic bootloader halted with mbox0={:#x}\n",
+            mbox0
+        );
+    }
+
+    resume_gsp_rm(
+        dev,
+        gsp_falcon,
+        ctx.sec2_falcon,
+        libos_dma_address,
+        bootloader_app_version,
+    )
+}
+
 /// Payload of a `GMCAPI_CMD_EXEC_HS_BINARY` event, which describes the HS binary to run.
 #[repr(C)]
 struct HsBinaryParams {
@@ -271,3 +377,59 @@ fn read(payload: &mut SBufferIter<array::IntoIter<&[u8], 2>>) -> Result<Self> {
         Self::from_bytes_copy(&bytes).ok_or(EINVAL)
     }
 }
+
+/// Payload of a `GMCAPI_CMD_EXEC_GENERIC_BOOTLOADER` event, which describes the image for the
+/// generic falcon bootloader to run.
+#[repr(C)]
+struct GenericBootloaderParams {
+    /// Descriptor of the image, which the bootloader reads from DMEM.
+    dmem_desc: BootloaderDmemDescV2,
+    /// Size in bytes of the descriptor, as GSP-RM defines it.
+    dmem_desc_size: u32,
+    /// Address space of the image: [`Self::ADDR_SYSMEM`] for system memory, or
+    /// [`Self::ADDR_FBMEM`] for the framebuffer.
+    addr_space: u32,
+    /// CPU cache attribute of an image in system memory: [`Self::NV_MEMORY_CACHED`] or
+    /// [`Self::NV_MEMORY_UNCACHED`].
+    cpu_cache_attrib: u32,
+    _reserved: [u32; 4],
+}
+
+impl GenericBootloaderParams {
+    const ADDR_SYSMEM: u32 = 1;
+    const ADDR_FBMEM: u32 = 2;
+    const NV_MEMORY_CACHED: u32 = 0;
+    const NV_MEMORY_UNCACHED: u32 = 1;
+
+    /// Returns the FBIF target that `addr_space` and `cpu_cache_attrib` select.
+    ///
+    /// # Errors
+    ///
+    /// - `EINVAL` if the pair selects no FBIF target.
+    fn fbif_target(&self) -> Result<FalconFbifTarget> {
+        match (self.addr_space, self.cpu_cache_attrib) {
+            (Self::ADDR_FBMEM, _) => Ok(FalconFbifTarget::LocalFb),
+            (Self::ADDR_SYSMEM, Self::NV_MEMORY_CACHED) => Ok(FalconFbifTarget::CoherentSysmem),
+            (Self::ADDR_SYSMEM, Self::NV_MEMORY_UNCACHED) => {
+                Ok(FalconFbifTarget::NoncoherentSysmem)
+            }
+            _ => Err(EINVAL),
+        }
+    }
+}
+
+// SAFETY: The nested descriptor is `FromBytes`, and every other field is an integer type for
+// which all bit patterns are valid.
+unsafe impl FromBytes for GenericBootloaderParams {}
+
+impl MessageFromGsp for GenericBootloaderParams {
+    type InitError = Error;
+
+    fn read(payload: &mut SBufferIter<array::IntoIter<&[u8], 2>>) -> Result<Self> {
+        let mut bytes = [0u8; size_of::<Self>()];
+
+        payload.read_exact(&mut bytes)?;
+
+        Self::from_bytes_copy(&bytes).ok_or(EINVAL)
+    }
+}
-- 
2.56.1

