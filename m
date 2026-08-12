Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF7E386C31;
	Wed, 12 Aug 2026 04:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786510416; cv=fail; b=hBJaDKnk3rjnvoF/p9S+8SprgpxJI4BCWNbWiDP4SPxWfWoZ4Hum6AMsDAaDqq6pPVkk++108uTZ38HAFpiGBc+CwnjO1tsIMS24aP+T9IN90shhhGKcHu2t+VVBuMQzNaCxIwfgW3cZRwSkXil7o6TU1rdQ0bhW0R5O83Dp6no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786510416; c=relaxed/simple;
	bh=qw7ax23KDmRBLKkfTbfgMVxAtDbhdycaToXHgA00oIo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eZBIDCo8P6UEUuDfBfNHFnDktY4sF2NqCBPF4uDgqahR9BPNHfq9LHsrAM7QNyrGKp01FbO+zg8l6RCBP1ZxG9GVLVDa+aAVsFGzBnGB1FQ6w23Wgvbd2J2zgrqnM+l3q0ulP/iehM9z7kTnkk474Vn0a/dQjL6iocVbYBLTPB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r2tLSEl6; arc=fail smtp.client-ip=40.107.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r2tLSEl6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAGW3gc+GKXAjoVRKQcXvEBye392ROJGr3cRIjH2JwWXLrmUInnoX7NyVO8SC25kVrLJTYeq5F9jmc58hOtdKXfz1768vNpwWIi9v+ZsUzLPFDzjvKRWOfVpxspAg3MTstkS8mcCgo32RUircd6XLmXBbksieOYubNeNaxyLc0gg/9qvBY/64iK4DB5/y9X6nHarYv0P5+27dwA6jiVLmX+JcG1D5hGy63GW9565M2d4rQFPNXcjhgsfbK50KXNiBAfTrm0eL2+6brbKY4CUIpCAC20SrfsCR8YsHVm707XootngOeqdvWX4T35cKZVYqOIpRpL+6o3qsyo2IX6fvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6HzO7PdVgAtF4YKZKEO6BfOXDeJDba3g+dgtw9rBMU=;
 b=OKbKf3of+H6t5Fs8h0HD4ICYF/q3ggRIumPxhKqtwym20nFaVnoTH9uXvAd74NrWFOUQ5Zxeg58dbsE5eVBrGdQ4u1AIRq8lcXH8Ch7tVzuG2qp/qbgRQKuW+pooasetw4ZOTYnZUg0mS8QnvwAuMxa+qaV4MArPjzrbEQfE2l5ap+L1Aijs27l3qhgUMWLgNfDfA79tzQ5qybIg9dyNp/rVbBzUgJ3PZ3voomdTU9HFBaPBty2AUOY/oicQxbmjdz0NAsPTuRBHIQkRKMrz6grDMtFzRetkT5+fwsKgawvO5zQ8p88fB/UiV0GnCR6l6HbIq/Ihax+wHYO7H+cBOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6HzO7PdVgAtF4YKZKEO6BfOXDeJDba3g+dgtw9rBMU=;
 b=r2tLSEl6cr48XeXr3OzB+DngEhRgFfMZGSeGnwEXqOd69TT3iqYWCYAzUNKhE/GAaUf2r+HTGS3Wby2FF7LErY6gis89PJSdjRXBtyh2bE7w79hmHn3mbuucYBr4gEXa/QrmfWIutnHmJWDRTYHSkZepyQ1fwwuZDwdtcBKKAPQXAc/Zj48PnaRiSVWX4hMVsALXThDjuoGjdYrTM+F+dscSzeru0bixXNZJxEGXIRvwnCHRZlPLVZr14l54Iq+Q12dTAweBXAamFW7QAHpeDGGnCghc4rwf7zLGxLEKnJ8QDAEQngsRyD+X5k4AMcR8dGXOandFqAZdkJM3LOkESQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 04:53:28 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 04:53:27 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	skhawaja@google.com,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: [RFC PATCH 0/5] PCI/vfio-pci: Guard resets against active SR-IOV VFs
Date: Tue, 11 Aug 2026 22:53:18 -0600
Message-ID: <20260812045325.2733631-1-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0078.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::25) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|DS4PR12MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f2d680-7bdf-40b1-8ffe-08def82da5d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	DeJmqnR/L5wfSOofvb2e3UNNppxFKj2GiqiOIqY0FY9JrbVuX104xllSYHYVhZ9Bsc09gy8hAu93/Gclia0ltYiVnLmMdqpyKxkJ835jqJGl0fEOsxRmrYLCZzme08HMCD7fzKZlqoynuNsdT521M1w24wc4O0DI17KMr7/PwswfKkdHTrxPD78ZHGONMtaFd46/pthDyHUQEw19Ga1efvqtHWa6K1dBN6Z31GUPfXduUcKFNjNFAI7VYd4Wq+ZQxF7+sB0uE/Pw9vCbd7A90SmW+VAeSVELbRd/UAUwIWcDTB581OUSxJvCOHEup+hZD3elaBmgAkR4Za6qtEjoPCaI2obQHJuc2ua7rjXdOWgil+SfwAfk0PbxYjquf501wk9+h656hIjCPh5FpNdW27edmEql4jPa8Y7bAjFWbEBJbQam2XVibVWRkuFnzcXpbBMlgcipYH24gbohJxHIvClRCbm4kbKXWds6xZE+8TczJ90wA0Rq3LBtaxxdqywIB4Ap/gsFM5/Xc31wCzZ8p5ADxrxLBxv/SI2uUFmu//x2pK6Kz4Gta0Wq54enaQ99alXSV9Jabr2yNIMR6CM0Nx/aHi7SZHybj39Oz/BYMuYHQKpB3QG+mvqJfGwuZcxYRKw2VLDPY7kmHDgTZi/SQ8/IURS9ucYxm+aNzDXGf68=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2uUoaNK9oyi9WlQ11T+CS5RGffC0oTjiFu8FYU9M0S1HVf4CxNngEpf27PRP?=
 =?us-ascii?Q?0LLgqEV0NGXp2ApvUJ9a+UM6jj+Om5OFasE3I8tqp6x8Cci+P+/G5N8D4xij?=
 =?us-ascii?Q?oplV9pPIwIVKygQpMGjYocDWHrxEQpXpRCxClgqd0CDx8nhCdeIb4XfRLmh0?=
 =?us-ascii?Q?eANKJU8jjJGFCMUkDetI4WwgJ1eb6A5YveSr723KIil5sUI9iurNfmQwshd7?=
 =?us-ascii?Q?HB8h/VNrbN42jtVfJCOum+5PidV82mHPCY9nA4loo7LGn5U4WWc7vfpJMKFo?=
 =?us-ascii?Q?5RttcvVJwlVVEXf8U79/qRHdzzLPOkmmcnAhkWj5sS2FodNEKYEkJ+c1ArNd?=
 =?us-ascii?Q?qGlHUg1T/MYpfpnxpCMqaZ0kHjqQY4micHvbpDY65spAB4CbVJrZoasVssv9?=
 =?us-ascii?Q?4dvEzDCey1KlrDjaH0fNs3hI+RBmLBbWPk/rsY6rhqq8a9GVkf4EZZlFGVcw?=
 =?us-ascii?Q?Nx3C29QiUopXazT42hW92sIZxPpNzVMLrEEZN0oMbUhdUBq/sNyhB2dRLtf8?=
 =?us-ascii?Q?ac1fPvdQEee/GnLS4+rSgURdCGaGhDpbzgJX3LxIbI4IuvoYhRil0O0wNPr8?=
 =?us-ascii?Q?VHJMWv6B28pYcSfRhanHHxnmh8y7vJMDaEUNn7q31IOJZbOjnzDx8J5HqJG1?=
 =?us-ascii?Q?Lg7/ADxpyfe9yZtCbdrLxoTsfJ+vXgcgwpE4GBL+joc/wBJ9vqepq6TRw1FO?=
 =?us-ascii?Q?IYnQ+g50FRLQ4j3zikVJHkY51ufNaSzp3wvxJ9LAgyVorcntL4g1J1VQ8BC8?=
 =?us-ascii?Q?PHIhvXozcwNr4qtifzqSnDd+tk8d2jBOW14ewqXjWMiLSXlDR18lT+ivhfxh?=
 =?us-ascii?Q?rhP2NuJS1YJfXQu73arWAEk832HTWYu2NlPiCanDFjQKlZVpo889IMTrCIdc?=
 =?us-ascii?Q?4yIv7oJJ9QdOluZKiJWWejlOt5s1s2dF4CAC+xDb3C4AZzWHbJuVbu2TE2lB?=
 =?us-ascii?Q?GPUExSbhj7uX1LLEg+bSG5YvzRDAnyK62akc/aF4ZVAe229orBQof3XwTZ39?=
 =?us-ascii?Q?DM699lq1gfRZqvchxfyRtuhXqWWjK1E7RMigMRD0eYFIeH8S7f3pJ8F7ry73?=
 =?us-ascii?Q?cEWkgldTeN48uyOOowQSBiXy9bquFnwOvALuvYEykXUklo104JXmMkju4iDJ?=
 =?us-ascii?Q?JXSfcKhIdz7Pt3iNDDZjveAjALVVj43/kHIcOaJupiia16lI9F/SFTurexfu?=
 =?us-ascii?Q?oes+BQUihMbMH+2URXIpd2se/eHmXuc6euVIhQsYqNB/KHOKrPvuETQMAepy?=
 =?us-ascii?Q?N+KbKdRdPa4tf+PJ95DIFQMD3fNJNbTmx5u/IfW9RLTR5MvLgEUfsyFfZUqg?=
 =?us-ascii?Q?/Yr/vR+hgrvX1MGxTo0JRruwcPT8n6o0g7aZEDnUvOVZFP763aHP+0Peo28z?=
 =?us-ascii?Q?GkrtjP9ZhVAZ15QVj11rrjyP1SI+CLEWI68/Oiea52h+nVFRMAcpjaHYveab?=
 =?us-ascii?Q?rqGqhGKXM3UseYIShalkLbZWfESxgrGhCStwGQRRemTQrJz85ITvUJuBqRdX?=
 =?us-ascii?Q?e2+skyjDoCGq3EdQ9v8ddIxIA+qckTmbBap9pwYiItSqn+skAof6QU7/Qorl?=
 =?us-ascii?Q?tbIyjzUv287Ej8/y0OmVejzbDDp0iIA6p8H0C/FIViULio9cmSPKEGlUVArn?=
 =?us-ascii?Q?VZN7lzZJiZulvz7+bpOlXLmWPTN27S+WRBMUe33wYLNOIlQacTZjeyRgWis5?=
 =?us-ascii?Q?ZsV3sptizXMRZCLS5zPLN3tI62+P0aLrCFACkkc+s7H33xeQYaLfZqrdieJ/?=
 =?us-ascii?Q?D98UJe+WfQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f2d680-7bdf-40b1-8ffe-08def82da5d1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 04:53:27.3990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyAVQ+/I7qDsnujoj6y4XnMI95btmBrEKPaWWkDVUWQKIunEb+HNrfCBZBYgL0gkvzDaZ7xUGePC4rgD3JFN2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748

It's recently been found[1] that vfio-pci doesn't restrict resets on PFs
while SR-IOV is enabled.  This can not only result in an uncoordinated
disruption of the use of the associated VFs, but the ongoing use of and
access to the VF has the potential to result in machine checks.

This series proposes that this gap is largely an oversight of
pci_reset_function() to recognize that a PF reset affecting SR-IOV VFs
violates the scope boundary of the pci_reset_function() API.

Patch 1 introduces guards in the common wrappers where we can hold
device_lock to prevent .sriov_configure races.  This covers locking
conformant use cases.  __pci_reset_function_locked() can't be gated in
PCI-core; it runs after the potentially destructive .reset_prepare.
Therefore its callers must provide the gating, along with the locking
and state manipulation the interface already demands.  The vfio-pci
change is included as an example and known use case here.

Patch 2 introduces a callback to pci_reset_bus() which allows a lock
dependent callback to be evaluated after locking the physical hierarchy
and before initiating the actual reset.  This allows use cases such as
in the following patch to evaluate the SR-IOV PF configuration without
racing.

Patch 3 implements exactly that test in vfio-pci-core, such that the
hot-reset ioctl can be blocked when SR-IOV VFs are present on a bus/slot
affected PF.  This completes the lockdown of resets induced on behalf of
the vfio-pci in-kernel or userspace drivers.

Patch 4 exports pci_reset_supported, which allows patch 5 to remove the
latched reset_works flag, which already had the potential to become
stale due to reset_method manipulation through sysfs, but now may also
become stale due to the SR-IOV state of the PF.

This is RFC to capture the discussion of [1] while it's active but
requires testing before formal proposal.  This effectively side-steps
the feasibility and security question of the operating model in use by
the referenced thread by generically gating resets affecting PFs with
active SR-IOV.  Please review and comment.  Thanks,

Alex


[1]https://lore.kernel.org/all/20260805003355.728299-1-skhawaja@google.com/

Alex Williamson (5):
  PCI: Refuse function reset of an SR-IOV PF with enabled VFs
  PCI: Add pci_reset_bus_cond() for a caller-gated slot or bus reset
  vfio/pci: Refuse to reset an SR-IOV PF with enabled VFs
  PCI: Export pci_reset_supported()
  vfio/pci: Use pci_reset_supported() in place of reset_works

 drivers/pci/pci.c                | 117 +++++++++++++++++++++++++++----
 drivers/pci/pci.h                |   1 -
 drivers/vfio/pci/vfio_pci_core.c |  28 +++++---
 include/linux/pci.h              |   4 ++
 include/linux/vfio_pci_core.h    |   1 -
 include/uapi/linux/vfio.h        |   3 +
 6 files changed, 129 insertions(+), 25 deletions(-)

-- 
2.53.0

