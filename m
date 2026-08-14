Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012055.outbound.protection.outlook.com [40.93.195.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6694746B8;
	Fri, 14 Aug 2026 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718279; cv=fail; b=seIUh6j/k+GB/xIrJIco3ACBzbqkRaYLCWH82VncDQjl+zPywafQfKDdzOVwDVsHueqrVk5yzgzAJwOpLf4jXj3vKh8oNd8o0tVGyW1c5OSK5MZXy9+t7oGBD+RwZJi+NAvSm3nyLQcO+NcAWv4tSjaqMNy8mNCByFIJJGxy0yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718279; c=relaxed/simple;
	bh=3sMPVvTDanpdGtLVr+b5sXcuCMcY9yVVrMZVLX6YLjc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MrPGBndM8YoPlFOo43bKFwkiT9OibId7e1hBNuqPALwscH+CBYSuFsVf7w22aeZuFJSR2AQmX/CVgauqx3x22en9YYKx/qwSvSVv7qvW10MSKeW6v6SaDkDP/1518GZjxg6deM8IEsIN4uG9VUgJ49xWojAXF9GS7/tcNwfzIIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y5Hbg29K; arc=fail smtp.client-ip=40.93.195.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y5Hbg29K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkyinlWR7zJD1n+Cx2p/YKrYIzX06NDqD2/bCZERhi2A4yg8DNEN1AaG2nMN/NA0Oi6ZH//lGHWbIsCzPCzsa0p0JWwk6hnm0icu4jlM8GbfY5iFThN77U0YWYtQouw061Pgat3Xzp5mU8+5FDrCyyLvhdH7ewNEvnurVaRaQ3VDK24b2FD/tYgFfuPDrgD378wJbkdDen6VMljHUgG+ziVvRRYnBCQrw86fnBR61qnAf6KXSpd8sudxe3l8rQG+ejlo/XO3ySu/gCLzkZqFEF2J/Uurdr/YX/bmC9U5InbEt68DFXiE/yNkvGZ2A6o3LyB9MgQMIOCsiMiW1aeGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAbXs2JDNVnS2yRhIqImmuU5m+ymVvDTxWJ5mx1yioE=;
 b=caI409MPZ91K6stdiBw4zfi1pSGwRwh7Pqtm9vKrRQPyYGlSVLvi96LtHHE+XWYS8MQV3Ns7Qq07ED0JF4ABW6QK6V4laOAnVe8IGlvCftod/p97FNZ8648mQ44ZkVFlmqJqP3DH0Nyg+T7NFshbytvbhHPJK1SL3LJGWtPHaCSbqK6WH0hlm1gzuzuhEa/lr34UobS5Gr+VGaIGYJ6L7he1nYaY+ydGDMXvZGGHXQpb0P7uVZDn1nasam7hky7Vwh1XwOHqugNai3d8C2YilGJs4hzEFIM+8u71WwhkCUSsk0PkvVDpEB9mFqaz9KQsJiSYtFER4dc6b3Zsv1b/9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAbXs2JDNVnS2yRhIqImmuU5m+ymVvDTxWJ5mx1yioE=;
 b=Y5Hbg29KuizgGOoQK8qB4Yhz6ZfpKjLa/n2HKJRJ7yijgzVsyvvSS1JNfpSt5CJTF9U2Tj9Mxg6z0jnepe9c7cad6hhIoW4y7v1pd/6ngOjGht3QnFG9kod5vEmxfelyjDRaOtYINXgj0uIKDBr+M50SUdb+0/3oY1lcHHzHkIEmBTeZtngJSzgyGfCdF0QCleQKE9gtdBp6/GmiMQYgnZfvyapYXW36kcGWpQR1bsWVcjjRJ3rr9WIi0cVBKy1XckYB5D1n8LAyZejkFPT8L9Iq7elmZl//RSPujoZYfxDJIQPvqjaXXbgSbf913SKEqLH3oVCj+AS3BC01aU8dcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by LV8PR12MB9417.namprd12.prod.outlook.com (2603:10b6:408:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 14:37:42 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 14:37:41 +0000
Date: Fri, 14 Aug 2026 08:37:37 -0600
From: Alex Williamson <alex.williamson@nvidia.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: kvm <kvm@vger.kernel.org>, Alex Williamson <alex@shazbot.org>, Jason
 Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, Kevin Tian
 <kevin.tian@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Message-ID: <20260814083737.66bb83fb@nvidia.com>
In-Reply-To: <an5JbIzz40svS3xe@google.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
	<20260812045325.2733631-2-alex.williamson@nvidia.com>
	<an5JbIzz40svS3xe@google.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:ed::8) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|LV8PR12MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: 800530ca-f294-497a-4244-08defa11987c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xBarNBWee0vrR4sLSF9dQbfuir+l5M5Ggh/9TCofl/W+BDuBgw01FFpLL514SaSytFuvutW/cBiWqgJTLS7oZanALnh3waYNXegCnGHamfIJRy2GtEk1YiP2wgESFCtJLGXhJlmPl7c3tuqZvzfEfp2xo6MTgRSTWIYDFKB6ZvQqIlaqEDr4jbdzZoroYuqKB4jTtxzVAkNltQCtomZtgApz5wz4DjbSUQPhbipG5Q1TgX32WIgBPyFIFmLcR9n+GjSLU1Y3ica+xhqe0wrn1NTlglEI5XZHxooLTxtxxsPs3QL3JpbkwKYNQ7REMpCUEh5JTmLuDDpAAktT6Kao9UAFjCA1pj3Hci+HI2dTdspXNRmpnXrDEivvjpSwgmO6bclVPUdkneOjyq9RrGfaebtI0zV0fxo11+DBDSFPJxSZ6lxhURzIpRm3R6gw2yJBK+uIydLtd1jNrRYHtuTon/HQo/AVn2eLocDzki8jfVGM8YcnP8PaIsq7Mqh/7YcQuuSL34Qsq5Qqekvr1JWTcQlsFszKARpRS5dsgRpK3ihlbRaPmRVvghNF8oknA2LadcXHMWgkgfOtA0hZYx2+XkRQMFFmkH/nkCyKXJn6otK5P57ENqgovSobliarImiZiN+VAx5HUCztePLCbE6l+8EriY0KjyIfRrdrsxc5Ypo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fw6rx/i7ubGM9z4BZgs9REe/+RWT6ej5zsSJIit5y9Hx7y/yRKpbIfsUKV1a?=
 =?us-ascii?Q?RxQ4f2NZy/hhuJfYyoIJfl0+6KHWx4GGLRLFZUjprXzyQwfhUf4oD4p7rbjE?=
 =?us-ascii?Q?G30uAnO4V+p52t/UX3w+fZoUVtrxQL0QMiLt1GS3Ry8AIsbPTdpgdEjFr8po?=
 =?us-ascii?Q?C+B883+hWdKJxjwnZhxwJsNu7UJPTS9/7QLgwtOt6dinYK1npvhTehmLjkq8?=
 =?us-ascii?Q?04BEpIWeQyAa+eUvZKcPSJymi7PnXm7PM+j28XMxWu/n0XAkI5FOsuq1uvSl?=
 =?us-ascii?Q?l35uAfMBjaA1CN3a2/o4HoTuo6rXGT9AP8QV2LBbyBrCfKR0IFQv/E4l68+g?=
 =?us-ascii?Q?+wcDaIdOXcOG47Od0awO5sOl3mjsVmN2QjhL5hy9AqzAZQ/05kSQOxCYU5Yp?=
 =?us-ascii?Q?4KgJJco47spd4e5apA6hUkiuquyUGaDlOZ/cH3SWpYDnIkIANRfncEW/01uQ?=
 =?us-ascii?Q?HbU0lpz3KrNij0tDwIzEJhh+FBduQWENZntdPSnNZ0v/OwlQFZJDyCVshEoG?=
 =?us-ascii?Q?/+/+o2xUXOncJjsNa1qenH+FBtsDDxpHLx74Io4hqni3z4yE/pDHIk5u6Zz4?=
 =?us-ascii?Q?Yk0JbDB+b7tuo53Y3ox2KNNdVEY4YmUD07/1ZPyr5rzuO+Sv4OBAEzVCMbBY?=
 =?us-ascii?Q?kMJZ+gbA9hj974gbf09tpoYGk8xqV23dmfcc1bUwRyZ4ZO7gbKkiwDc8cXpP?=
 =?us-ascii?Q?696pheYyYxkC7SCmw/ZoO2f8FCNTCFpOBEdIah4MoByos19Q/y38FVrjcziU?=
 =?us-ascii?Q?ddEETjjRGlp3yRrthu57sfbjEDj0sIk4Bp/rBeC8UNdXCuk1VIefqF2sEGsC?=
 =?us-ascii?Q?RcmUIsObtmVnNbQkU8vpx75Y2CFmN6IU7QVbiFN4afm6KvTVkWCNZBUaXFAA?=
 =?us-ascii?Q?k2i+FfltHnAWlWYfviCmgWS1QWtTJgs9aJuixU9o+P/L+2d9PI2nr8i5xPoN?=
 =?us-ascii?Q?Ij8AA8j2R8mJjFCOsAbsRGQAZk5SGV/8t4s+jGVslkQxV8VIKSa6dgLQ9C4u?=
 =?us-ascii?Q?XtOW89why2VQFaHyn6C9Wpr03cjCBXCJX0L/I8C/A49MOoik59TA2e8oS8vI?=
 =?us-ascii?Q?Akb2L28iCFUNKBFGhPkKWaD+CAa1Z/G0jXUlwEHS6GVsgr3QM+PTWkU0D+Zz?=
 =?us-ascii?Q?DPkftXgpJPjO3QQGoauDGXS3uM5FlaB+aG0LZccHcbdJUUBaAifmkHvCrSqe?=
 =?us-ascii?Q?y6Mep/QEKin+jNOm1BSbSAGR3JrWhoXenl7lQqG2fXwIpizub8ZUgBWTkIqU?=
 =?us-ascii?Q?6rQHpinULRPSw/0YPFIRIzEZZh4qWKmDJ37wgLElHO0Yv7cAkNJYOlUfmNcb?=
 =?us-ascii?Q?Yp5ef10nKq4JHIR++Nf7i0nmu/4NHcqA64L7+yzwdyDAGSewnlICkgoAQh3a?=
 =?us-ascii?Q?NYiKb1+x5LzlwVkruSeVcm87J9STT11HB87GtcLQvsQQL2fzso3GoZtNhLVw?=
 =?us-ascii?Q?NWBfBkzQZWAIEin9ACVxrPLDJOLDZ1mec/YP4wvlxLbV6ukiJKObmlUN/wg/?=
 =?us-ascii?Q?qRTIuPN4qi9oYaCVaI0jYbxRWnhRRo2QH2Jz5x0eWjtkX2bmJqz69Vb6BqUX?=
 =?us-ascii?Q?+WpH+8zIBkHox+X9jWbcubs/tCq/VvEFTSBQZvcv5ZTzUFAiXjdx6klKlOda?=
 =?us-ascii?Q?FcXklQzmAqPyOyHNxjPc+1pTEcIiIebCldKojEQ9ZyQEhelUuOExY0R4hh3J?=
 =?us-ascii?Q?Fyc5rGF4x4nH7f5ORiE0lj6mejV4MTMARJe/wjCi8PHIMf1Ryk3Hta5Qb3GW?=
 =?us-ascii?Q?M6x+7UgyvQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800530ca-f294-497a-4244-08defa11987c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 14:37:41.5798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kuOAZJOJx4BO/6qOZpdp9TNl9HJW5ofYk4CYHXca1U9oCOAR6KAc8DzsbSDszqAuiwseTNOXBsl33y99TQQ2Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9417

On Thu, 13 Aug 2026 23:22:33 +0000
Samiullah Khawaja <skhawaja@google.com> wrote:

> On Tue, Aug 11, 2026 at 10:53:19PM -0600, Alex Williamson wrote:
> >pci_reset_function() and its locked and try variants are intended to
> >provide a function-scoped reset.  The bus and slot methods supporting
> >this interface refuse when sibling or subordinate devices are present.
> >SR-IOV VFs however, are not currently considered in this scope.
> >
> >Correct this oversight by testing for non-zero VF count in calls
> >through the pci_reset_function() interfaces.  This test needs to occur
> >under device_lock to avoid races with .sriov_configure.  It should
> >also occur before pci_dev_save_and_disable() to avoid calling
> >potentially destructive reset hooks.  Tests are therefore added
> >to each of pci_reset_function(), pci_reset_function_locked(), and
> >pci_try_reset_function().
> >
> >The __pci_reset_function_locked() interface remains a low-level
> >primitive depending on the caller to perform such tests as necessary.
> >The vfio_pci_core use case of __pci_reset_function_locked() is pulled
> >through with this test.  Other use cases, such as xen-pciback, that
> >don't obviously support or prevent binding to SR-IOV enabled PFs will
> >need to decide whether VFs are possible and can be preserved.
> >Additionally, direct callers of sriov_enable() that do not hold
> >device_lock (lpfc) are considered a preexisting, non-compliance issue.
> >
> >Fixes: dd7cc44d0bce ("PCI: add SR-IOV API for Physical Function driver")
> >Cc: stable@vger.kernel.org
> >Assisted-by: Claude:claude-opus-4-8
> >Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
> >---
> > drivers/pci/pci.c                | 19 +++++++++++++++++++
> > drivers/vfio/pci/vfio_pci_core.c |  4 +++-
> > 2 files changed, 22 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >index 77b17b13ee61..b40b00c0c0c9 100644
> >--- a/drivers/pci/pci.c
> >+++ b/drivers/pci/pci.c
> >@@ -5222,11 +5222,22 @@ int pci_reset_function(struct pci_dev *dev)
> > 		pci_dev_lock(bridge);
> >
> > 	pci_dev_lock(dev);
> >+
> >+	/*
> >+	 * Reset of an SR-IOV PF necessarily resets any active VFs.  Such resets are
> >+	 * beyond the scope advertised for pci_reset_function() and variants, refuse.
> >+	 */
> >+	if (pci_num_vf(dev) > 0) {
> >+		rc = -ENOTTY;
> >+		goto unlock;
> >+	}
> >+
> > 	pci_dev_save_and_disable(dev);
> >
> > 	rc = __pci_reset_function_locked(dev);
> >
> > 	pci_dev_restore(dev);
> >+unlock:
> > 	pci_dev_unlock(dev);
> >
> > 	if (bridge)
> >@@ -5264,6 +5275,9 @@ int pci_reset_function_locked(struct pci_dev *dev)
> > 	if (!pci_reset_supported(dev))
> > 		return -ENOTTY;
> >
> >+	if (pci_num_vf(dev) > 0)
> >+		return -ENOTTY;
> >+
> > 	pci_dev_save_and_disable(dev);
> >
> > 	rc = __pci_reset_function_locked(dev);
> >@@ -5290,6 +5304,11 @@ int pci_try_reset_function(struct pci_dev *dev)
> > 	if (!pci_dev_trylock(dev))
> > 		return -EAGAIN;
> >
> >+	if (pci_num_vf(dev) > 0) {
> >+		pci_dev_unlock(dev);
> >+		return -ENOTTY;
> >+	}  
> 
> I am wondering whether we should return EAGAIN from here, since this
> function is used by vfio_pci_core_enable() during open and it doesn't
> fail the open on ENOTTY. Basically whether we should allow the user to
> reopen the device if the reset was skipped previously? In the previous
> instance of open, the device was setup with vfio/iommufd and the vfio fd
> was abruptly closed and the reset was skipped. But the device went back
> to the IOMMU default domain and that is probably an Identity domain. If
> we allow the device to be opened and re-enable busmaster without a
> reset, is there a chance that device would continue to DMA based on its
> previous setup/context? Probably unlikely?
> 
> Note this is different from the current vfio-pci behaviour where device
> is always reset during close.
> 
> Maybe thinking with too much paranoia about it :D.

Devices are only ever opened into a user owned domain, the IOMMU
context switch happens before this and regardless of the reset.  Close
also disables bus-master regardless of reset, so there's no risk of
ongoing DMA if the device is placed into an identity domain between
close and re-open.

Actually, I think -ENOTTY is a leftover from a previous iteration where
this test was pushed into the individual reset methods.  -ENOTTY allows
continuing to the next reset method.  With the test guarding all the
reset methods in this version, we should probably use -EBUSY.  -EAGAIN
would conflate the try-lock contention error, which is actually a usage
race, versus the PF is not in a state to handle the request.

If the user owns the PF, as evidenced by them being able to get to
vfio_pci_core_enable(), and reset is blocked by the SR-IOV state of the
PF, I think there are arguments both that the user implicitly opted in
to the best-effort reset, as well as a use case that allows the PF
driver to fail and re-open the PF demands this behavior.

Further, the PF requires vf-token authentication if VFs are open within
the vfio ecosystem.  If the VFs are instead bound to in-kernel drivers,
they've already been opted out of that security barrier.  Thanks,

Alex
