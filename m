Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021129.outbound.protection.outlook.com [52.101.125.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69311C3BEB;
	Sun, 15 Feb 2026 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771167847; cv=fail; b=oDrh8zK1hc2xn1HZUcok8UKBEzQEpITRjs6H5LFN0zfwA1iUJ3WDq5fmWcwHPH5K4zAy1JciK8pKJgxCkQzABIJobnX5LIy6c07hA2nKFbhrNQvSzFg+LxGTgipZain+N8mRdmJgrNqKaChxbMa8PzCDhs5c0URJK6Lm8Fo3BW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771167847; c=relaxed/simple;
	bh=iAsKWR7jqC/v51yKDHXhL0njIf7ipNKjodP6uGgmPnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z9LRdS3n8+hDPHUSOWl48SfEuLvIcirWvqWMnITES/Ts/byrtf4IiFPKbuayY9P0PjoX07WfHyvvGu/MQFuyjL/vJnmxZXn15RrDFVEfjVZX6uTjDdvSb1nXRKlCypjINWzRRw4hJuwRSzLTon+nhDxtQY1QPnUyYGZjSTVR5Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=UYBrzU8l; arc=fail smtp.client-ip=52.101.125.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="UYBrzU8l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4hdtS2RyE0yCYHIxRWM8w/7T0IqT2AkkfbrKcP5V7J2oQcZgfAmosyRdQYMNxKTWWK8WptwyurgsJyu4OpWFA9kOnJs348U3n8LLp5t39AX10NYJb7/T9H9WZ/FVBYXDWeqiQ0p3X6BiV/lRz7uXn1g23OA7KtkGPrwJ5KXIuGw/z0MywmhAxqhKD86ZNCibh5VDTfNF0DkpKay0R77SC6Rv+NogSu1LU3GTbMYXx4IZDxiSLwthOO7HkUdgoGWWRMuWV+DxQDe9T0wjsuHEhKRriVqIGk9TgkxCdZ1y96aQV0pt6Koj3OYWH0Q/iXup3uAuq+KeEO/FGWVuv23gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rC7t0hr7rDLQzA5IiWkx3RP9onDnfMSVdLkPuIxTAW8=;
 b=wGqcg42aY4rXM3dpMmqGrsM5PLMGplvLs9fSmJFIPnRaemdPuKrh8d3cf5jUO4etJfanjYUDBNDd2GO+8wkJiJf3cbnHVurLlRWBO0rFV8HtkiPGlcQ6u3BvZMI7/UNqj3gSlHgDbC8If2IGul/zFGsd2Uto4EO6qRj6CrOGvRIt8VMQvE98HfX3faC/lSswekMcVdKtjovmdjHymn9Ve5Pd127Eb8HumvYtY/LcRTMRtaHCmtpFmvLfm8N/u2z6hvWl/Pp6VqNuly4a6HXaP0cHCHkO/wVn0qtG07qMR9DDQDTSm1hinHo6EICgBH/84x1xxYAtUrA7l4AQlUeDmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rC7t0hr7rDLQzA5IiWkx3RP9onDnfMSVdLkPuIxTAW8=;
 b=UYBrzU8lwVxCMvUzvMikD+AIO7pIAevum0ii4Sg+sqx/T8OVu8mrkg8vvtjoQrdhqFR9arLLyPc+CfFWuCoQl/HA6QGo4Npqe/TZ7O3dAalLJDRvCi7AyHgS6LLBVLAKkYCZqPaoYo3AdIxG6D8QWL2K6djbj5BdOFahRnIfdFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7240.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:367::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 15:03:42 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 15:03:42 +0000
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	shuah@kernel.org,
	cassel@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 3/3] selftests: pci_endpoint: Skip doorbell test when unsupported
Date: Mon, 16 Feb 2026 00:03:34 +0900
Message-ID: <20260215150334.3391943-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215150334.3391943-1-den@valinux.co.jp>
References: <20260215150334.3391943-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0335.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 23078b4b-8769-4966-4db0-08de6ca36893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/4jRK7X2BoXSEI+4VlM2ulqHNqy3AX9Z7kAFYJl63bi55yLNoxFFFWeuCrZj?=
 =?us-ascii?Q?A/XXKUQSL15XvVoPssscxcL/V+L65qwZyyULX55AvsBrGsnSvFfnEBsFFAas?=
 =?us-ascii?Q?EHsgYgNGES2MuoEO310EORETrOOLgt6vQmWpvdDHcgyPByWUmpXuvvcuIn63?=
 =?us-ascii?Q?mIhepvHwbSbn3P14PPg5bjZ5ddtLkZxrY9cwx2+Nu3SHtngY4y2NbxfL59fQ?=
 =?us-ascii?Q?Vq3jqoL/VyMBk5Yjh9NWcCrOFzM3HSLpNThf3UFmk/b4DslCNmp5HA5S8NOb?=
 =?us-ascii?Q?s+JsQtZkePEAjeU+SgM9uuimBNy47iwxXpXqL5FrIY/J8HIX3gcYJjJQ92Yo?=
 =?us-ascii?Q?Zxg2dLPQZI9DDvcvejXxNHa9aXYlSCYrTKOSHjDbkS/GTCFaAqvOwIhhPXEI?=
 =?us-ascii?Q?j4D3fk8T/8XoYAm4r8CsMjtBkR74NMPXNZCKt8NCIBjHFWhANSeXWx9/92bE?=
 =?us-ascii?Q?CjydW536S+6hieRowl///GWQV9sgglGP5ffCjQnR74JKei8nRKPGuvUIb/gt?=
 =?us-ascii?Q?LMPh2OTYdJ+NFS158wqCBZ9D+Fc1i2WwjVyVQrityIOG3WciDq0b+f8/48vL?=
 =?us-ascii?Q?LbSyTT4szqWSbEi91Wavkf0h+YLcpW4kfOnwtnGevR83cAs13PvPbZPff3v5?=
 =?us-ascii?Q?mfd88uNBvECrhmdcEfS8TcPDHWLF42YWQQH+fzsCPTOJQ6/pdqFAzCLmqDtK?=
 =?us-ascii?Q?5L81KborFGUd8/vE45mBQYp/QXIKTKxSOO4Vq/1ppdUrNL2k/nuX9pW1yjJX?=
 =?us-ascii?Q?TevQQEKWGjLE872DkQqaP2IYRopzWBCtzIhKxT9K+BJUdEp5RVOzTJp1PhMT?=
 =?us-ascii?Q?lJhGqtwSBhSgCRNXe99XdYA35Qe7aiVpliEzbD1FvhUNoRdYP5m2rvOWkjSC?=
 =?us-ascii?Q?kX27I8Plm5qbJyWbxZk96ZN00BkNXfoVQ3eUNhBA8bzVdjfR53Y4EAYihywD?=
 =?us-ascii?Q?AtyX2oP+t7Cy6q8lcXlHHSmjGExYe6RnrRn2JT8OJ2P0QvsJ063uieDMI7cM?=
 =?us-ascii?Q?rDDyKKaFkH1pLZn+tsrrqqv7kBHPjPZwchRJH0g6IzE550KnStotKr6mX9a0?=
 =?us-ascii?Q?uh7l5gZDlCQcgR1maLMlpIvb5c9ris/hzzip4ydf+hjAb8KyaxVD8xWglfRm?=
 =?us-ascii?Q?khVZeimuH+uYW+jPv8xB9njIDnNHE3uER4uWzIoKji4UobYNQCX5Nln+ECj5?=
 =?us-ascii?Q?jKPd3xm5r8r4U1yYaIgUgM/9tn/hk6FdvS/6RvY7+p8F9pOMsd8Se5y2V66O?=
 =?us-ascii?Q?pIowznbOVwhbmGY5pkGXbWPR7VSgj98w/mC4B39qw8YHF4++OG+Atm/IljTx?=
 =?us-ascii?Q?kTAofYxJKRxiP+eBj2T0dkfUFjMxxzaeT5Kg+10GgMGz2RegeVu1e1kYoK8H?=
 =?us-ascii?Q?GfW1YRO/Cja6oTwki8+5BMQIJ+FfCvS13YpnRcWcdWJy/rNOFXVUkUmG+EUb?=
 =?us-ascii?Q?3RrNkAchb2Xu7lKspETgiRS2CJePaChBAv3Kbfs0DD1cLFPy/M5jMw9qj67l?=
 =?us-ascii?Q?edVNeGrL/ezA4ZNSz0a2kysoJjM2PJ0DE7zzXIItibLNOAEktoXiJ+/FQi0z?=
 =?us-ascii?Q?jBs92np6C5C777suiHI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ngg+e4hPgNsHfeEXDGD6Y0AYCKHnNjZeLDoHjy1GR5efRvkGuz/V6PSPZ1fv?=
 =?us-ascii?Q?0x8y0jBKaSj/AJUR2V/0G5qUqzqWJV/SgfDTC28dqWgx8xJxpzpRyNdkeqih?=
 =?us-ascii?Q?hmrt+fKXTM8e10n/YA54snqUt4YXENQsZjVIwuH+MrtW+HnxNIRpewzykpWp?=
 =?us-ascii?Q?g2+HQxPMA5wDTUd9kzDMjUggRztnT9HvB48+JTFku/NjNLPA6iop6MQik1ps?=
 =?us-ascii?Q?wrvH7149dJbFykpO8sDPgKCwB+B4PcWnbxHCI6UWaScLksjuTFVErs+2Dpbu?=
 =?us-ascii?Q?F+2XbsZd0qEsL4RynWCoKaoAGP+y5QmK2vlJgiH+V1CKGNyIqoXi4Ff2qv7j?=
 =?us-ascii?Q?oABOXX/I3N0k1QqZhoHYi1zPOf7d3GYEXszKChLA30tqUu2HDCRDPQQPo6m0?=
 =?us-ascii?Q?0Pju5ZxhvCVD2LbIZNUhTODrP1anGYxsWrWLjOPTvA/1uVyFc0D+84H0Idl2?=
 =?us-ascii?Q?l4LVCE4pVaCnqtTKw22gpxpd0w/jjmRmHElCVDFPdIBJO+JONI5tpwxvV+Sl?=
 =?us-ascii?Q?vb2iHFFsfc2aBuRrRQ1dOg/pNKibtv4fo5XaSExM2huoL7wQq9aWQXxrZ2dP?=
 =?us-ascii?Q?Kxv0iZhLzLJOwCMqcIByUTktkOaaQ+X++pXcXjis4etRLpUyXjXqVH+6GuWV?=
 =?us-ascii?Q?S/og1PXVDXIiROxYa/DsnnDK8CXjJ4C79cDJ5PSRjpgzx6JXXfUxfHZRsVAF?=
 =?us-ascii?Q?Br6iU9WtjTjxFinvk2ibU0TfQpvEfFczEi0+HkN6lovdvXsMstIZRlH+uHS7?=
 =?us-ascii?Q?z/EOA/SlQN5SYNzSua/tyTMEW/51aEBGGYmIvwFxYCqGMIXegG6vrqdY2BiB?=
 =?us-ascii?Q?ilaOYFgTsPxn7XizHyaBmlFlSNq/ZGhzkw05Tv5t/pTsymhDUvHN5fD7Hcyq?=
 =?us-ascii?Q?0NotxNHgQNn+rb/eJbY7LClw8pJ89r8V9rFZBds1oJAq7/A2cKPriO5vkd7F?=
 =?us-ascii?Q?4/w8StcrnU6auW+C8UsHPYcErBJ9aTNRawXpx5G/XP+AWyZr44NHNIKidGgW?=
 =?us-ascii?Q?7ku5tKZePR4Tp+EECe5gZCj3zv+bvVCxO9vz1wAuZMhBhQSG0VJN0cW4/AVH?=
 =?us-ascii?Q?b7H328p4CrOQ24Wen6WiwLDLvLkfZQX6XCYodNjsNXtDU2hbha4y+7tegjjt?=
 =?us-ascii?Q?FgMnrbd4nnSCMlKZCKb1WGLAAPE7DNLhNSdGdJRE7pItIWkkMRLRRlKM6bRq?=
 =?us-ascii?Q?RZ95+GTAueiEsSb3SR9ltvWXoqzHCqv127kXUPzeZTwSgIQVUfA5njQFxGN4?=
 =?us-ascii?Q?4vi7LnPDsN5UrWLahxhW1Bv/8GLCjv0jxs/hNxJ1FiZ4HRzmANqpVImJnqXM?=
 =?us-ascii?Q?Qt5xPJ54vozZBs7nQS+u5RZXGAi+TLWsKxm0gg9biQjjQTytJmhr2SSZZzK4?=
 =?us-ascii?Q?BkBnCcLVPi5W6FIpOK9KwbL3Zyb9qGpjDv7tOIvsShY/zDwdqevKoQwC39QH?=
 =?us-ascii?Q?VUo2kyB2AJhFoGKSoJNXwlmM7C8ZS8wVCJqV0IVyGrg+bNyQBpRWNMzUleXn?=
 =?us-ascii?Q?5oFTf7+odbJgS6GOzXtq5eqQASG7GiF+jc7T0UDX3YpmoKcY9HKjb0rKesZU?=
 =?us-ascii?Q?81F+us7Te/7uXbPmN9LTsLybHzGOdG4n2OyqM6c+XExU+5aI88Yfi10JRa0j?=
 =?us-ascii?Q?0IZWvS8eJ/kjLRK6+2lCb1sDF7bZBaeHm6RuOAljN6I2fKz0sRcgvYX9JeVv?=
 =?us-ascii?Q?B3YmBb/1Jp/pEnnKZ5caTzK6III04rxT5ySeMVDh4xH0fCuq3pDqpeyM9IHD?=
 =?us-ascii?Q?gnxs9IHZRVds/NkjnNwwc2e8IRdu/a2N1ury9Jlnxvr1/As1nobe?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 23078b4b-8769-4966-4db0-08de6ca36893
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 15:03:42.3530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nX/j3sbCgQkRXjzDb9211EadZUNwwpSsWS8enI5BEeze6dD1+jQ5E5WocQNOBxGpWXnnXpOfA80d5tX1NDdPkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7240

PCITEST_DOORBELL may return -EOPNOTSUPP when the endpoint does not
advertise CAP_DYNAMIC_INBOUND_MAPPING.

Treat this like other optional capabilities and skip the doorbell test
instead of reporting a failure.

Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index eecb776c33af..e0dbbb2af8c7 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -276,6 +276,8 @@ TEST_F(pcie_ep_doorbell, DOORBELL_TEST)
 	ASSERT_EQ(0, ret) TH_LOG("Can't set AUTO IRQ type");
 
 	pci_ep_ioctl(PCITEST_DOORBELL, 0);
+	if (ret == -EOPNOTSUPP)
+		SKIP(return, "Doorbell test is not supported");
 	EXPECT_FALSE(ret) TH_LOG("Test failed for Doorbell\n");
 }
 TEST_HARNESS_MAIN
-- 
2.51.0

