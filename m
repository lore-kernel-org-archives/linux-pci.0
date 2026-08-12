Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47A825DB0D;
	Wed, 12 Aug 2026 22:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786575195; cv=fail; b=Q5Lf6ksi5oWfXJnXjwbH2thWO7WwMKPle8RJSRIuzyVLARBp6PzHKiOO8otxf+XGxk7H0DM6JrHJ47/2Y+77D0CmHoWN7KF5zDQjf5vfZFxZjQ+3VyyFKeLrh9okXfBLwfxxO/H8S+87yufWJLC/rKe0Uoi9NfbY2h54/D4wSdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786575195; c=relaxed/simple;
	bh=ywRkRg+aURfGnH4ysB/K1V+AUKFSro/G+lEoxuJ1nx8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gy0cjmszGRz8jue9BuQfksv8S4SZQpi1YOuyHIhKoARn9jswGxJrpaXCi30CiBHElSCUTTIPQi8a1dBiO5+0Zz6JTEf8FDYFMURcXCjDHvt0Inlyj1C1rAdOnHY1VMOQ7YZxEl6QwjK/iJFRXWD7BAE1TZT+EEkys7b/TxmKN58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SgUyP227; arc=fail smtp.client-ip=52.101.43.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SgUyP227"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1hdjhC2t4iP6TToVb3AcHrMSpXVMdDGfeotef/us3eHbeG8pZNoFFBZLnIvv00ww65HhRSnaV54a9q46xq6I363eoHxxeElHMw2vJ9R5IdrQY/Raasa/qmxC5T7igihBJUcDIoenI6YWCPoOR97okNjE+fA38+O+kNxGOa9Da4Ddy9yk5mf0XlIACMOnpDfwowEDqhZgkVr4l0Jn53b21EeQZNwK45r4cpdqzrhLs3ZPC8F+lXKPTjY2nxd6yMvPJrt9l6QsM5N5QHinfIYtUXQFC0CjtPK8juF3LVYcfB03Z6yELZT20f/mUWMAmcW1eTisS2Gnh/BHjUI5BHogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NlrvW7BxkUAE5bAYobgpv/zbECnKz9wTDuR1mCfi04=;
 b=vNzd0lo8P8VjCq3Rtwsri9dgoLjyLNWLciqtwJ0leb8lnN7iw0ljq1L3Z62ez932rZl+WuiJB6hgOvxJAcLa2pRUZ6b+D75oVHtK2etSUT5Jc5au2/QeTnrnS5UjUJ2kc0SiAf0WadwqE403YPBaIc13JgFqn0E5OG1WkRZMMdLRw7rzU4K4czjjOIq7p8T4Ug6iWZYD+FQ8cQxXW3fMtCPqtH9Pnb+UiV5w8W+Cdr8/9xI+KKFu8kbf5zg97xwu8AEuyguEKtl8KAZfGUK6ueMfoyDg1zYo2yZKb+C7bu6HL1WD5fAfJw32zTY81L/QfoNR83aGp0ZSdmmdmh61uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NlrvW7BxkUAE5bAYobgpv/zbECnKz9wTDuR1mCfi04=;
 b=SgUyP227mImcQ+hndiDN6oIFGPMp4irtlAtFGYtEifdrFWA/uHUV/AdmJaxk8SIRubOsIJudgHjawi9tjrc5ibe7qMLfPZ5UE13BPa23qjxSKfDm79dYVeuoWgEExN9Mj5r1u8InWwNofMysUkWOSlkuopmyoIAikK0yI22rzgId94lEOu08+hB5oBpwNKfc7v97YojacS4YN6BD7TeEnbquPwy5MFyZPhUXLsQaBbJLDFOAP0XoDUOo3oQv+J4mfaREmphFtqSKyioeAW8n3h/56WFMN5fLQu+SD7ZtBnHeoCiRVS4v2H0plRCHPTHmFW/dRbOm/F+peEId1Nz6Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by IA1PR12MB9500.namprd12.prod.outlook.com (2603:10b6:208:596::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 22:53:10 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 22:53:10 +0000
Date: Wed, 12 Aug 2026 16:53:06 -0600
From: Alex Williamson <alex.williamson@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kvm <kvm@vger.kernel.org>, Alex Williamson <alex@shazbot.org>,
 skhawaja@google.com, Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas
 <bhelgaas@google.com>, Kevin Tian <kevin.tian@intel.com>, linux-kernel
 <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
 Andrii Staikov <andrii.staikov@intel.com>, Mitch Williams
 <mitch.a.williams@intel.com>, Nick Nunley <nicholas.d.nunley@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Subject: Re: [RFC PATCH 0/5] PCI/vfio-pci: Guard resets against active
 SR-IOV VFs
Message-ID: <20260812165306.31300443@nvidia.com>
In-Reply-To: <20260812214554.GA1067593@bhelgaas>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
	<20260812214554.GA1067593@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SA1P222CA0105.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::13) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|IA1PR12MB9500:EE_
X-MS-Office365-Filtering-Correlation-Id: 93af26b4-b346-41d3-00d7-08def8c47b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IED3epmGOui3F79nikHqKhawW1BJLkJaTaduvqG6t0F4PdgUWFk/0iC6It4DhdGr/8QyqTVnGFf0BpwniqCU3PSyW4a8I8NxxAhpIALrTOfX/4BES4RjfzccmBgxp7f7l0wVNYXXUoJEae3+NIhxIPHeAB1hFkz2KnfPlsfDXLWwc8m8nmLrcgaXEb0YxgBBOSE8tFauGEmCtozGASAIhHOJnu8a7r6V/4UZFVw1DzA8l+aVd0jz1ZfxXAcc4X5AX/o76nE2lf6+NRvAp1YPBDyaJz3ZQjgQnp4ru7GEjltEiUH/dCEDsFPObSLzu7kcx+G1Xijfxi2Zjb8XZost/cl9H/zS1I7XN17P07S7E1MRXkQJlqOgBtCDKQm6sSpIv9nXMSEeFWG6FjdtX7KXkvpAo57oV6UILlGGRmXKKGVJTRfXfrrfIShrSaodgn1by6xLyP5NYSi9XYWJPVU1WnRypkpT1dEtJ0X7s1XfxrbUy8bXFRj+NUHLaAnFjclUZJzWKKUOSJaVyWAW5Ar7eryy1w5sIElO+OEDoHVjUGdXW8kr3XdGOjjHSWkPY8jtlTXSrlZx4nbBZg/X3VpxmNmKxH9tfwv0OgrhjmpIJMeFE7oeYayfdo/bJ9NUirtb6zuG1gNBdRK11HuQMZtHjh2x9u5ZUuoxsI8jqJPIc1s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aERsbHI3NUZ0bGIxaXZsMStpV3pOZkxGWm00bUhTejNaNVlkKzdObFZnWW8v?=
 =?utf-8?B?d1FrNHVlblFRSlYzWW9jODIvT1E0NFhiMU1hV21qdTV0TVlvd1hGdjdmVzEw?=
 =?utf-8?B?dkVvKzIxUkE5Y2JMMEVmQlNLenptdEtxcjc1dCtBRmthMnBlTEFGUWtXSDI0?=
 =?utf-8?B?Zjd0NDNMT2M0TmpBRE5SdklwVkZqeXNuUFZGbkIxTHJOeWtTZER1cnJ5dDBr?=
 =?utf-8?B?dDRTbUdXYWtNQVF3dlJHWmEzRzR6bkk1RmYySFhIUzN0d0xhYnFyTTYzMlkw?=
 =?utf-8?B?SmFXSStuZzhEK2dyUVFTZDN0eEVOdUMrbmQ0REZQNXNEd3FZUTJ2QXdlR1pn?=
 =?utf-8?B?WVlLYTl4bkUzTDJHZ3dJaXllOG9raTVwbEZHaHBwd2FUcnNlaHl0cEJoNy9u?=
 =?utf-8?B?OW1SeWlYREh6SDRXWFdTK3NVM1BPMEtIOFdzYkpXLzd2UjNvL0dXdzRiV3No?=
 =?utf-8?B?alNQM1pTaXNLeFR1TWVhdG8zNkVvTlN5S3FCSzRHaFYyVlJMeUlndkNqbHhl?=
 =?utf-8?B?aXhDRWhKNzMwMm9QYlVVcHZLUVpHNzRhOFdsNEFxeEFYMW1uM1lVQWtIc1JV?=
 =?utf-8?B?MzBxditMRjFpQnNkSEJOenBPb3ZVL0kyVFhTV0J2NmdISVBMRkE3OEpydC9h?=
 =?utf-8?B?Y3hzWjBBSkU1UEtpMEFOdTNBb1FvankwZ09wYlhnQkR2Z3g0TCt1MXdKVkto?=
 =?utf-8?B?Qlh4NjVLR1MyK3haZzU4cGVuc0VpQTV3d1Bxa3BDbjBObzBOODlkanI5Um9k?=
 =?utf-8?B?b3IxeUl3MHk2dW8vU0N6TmZUaTFsTXo0SzdjVHV6M1VSNEZybHI2RWN3dnlz?=
 =?utf-8?B?VkFkVXRQZmhWbzJIWEFkeVBpR3h3K2lQUTBWWjRqbTAwT1pEbkZLeUtXQitL?=
 =?utf-8?B?OE5HOHRkNDlLQ1owWEJaR2Q5OFVReVF3SXYvcjdZbi85UkZOdWlrdUs3ZStj?=
 =?utf-8?B?cjlpSEZXcm5KU0tWU1FUSVdvVFUwdlgrS0xFZ1pyQWl4NnhLUjU2NXFWQUcz?=
 =?utf-8?B?QWRibGhTWXBHQkJ2R1VKZEc1UWU4MnB4dHRKUjI1VldwZnZyREFpZ0ZtMnVj?=
 =?utf-8?B?enZqbmJSUk9XTng5TUExN3A3RDZLdVcwK0VwSHV1Rk0wYWlaY2tvRVV4Y2Yv?=
 =?utf-8?B?SS90RDhicHprUWw2bnlOTTNYeFI1WjhnTkJYa00rakJKTElTVWtEZEM3anBN?=
 =?utf-8?B?S2J2NkRuYmw2UGdNSmhpWnpiRWpUVzJMaGp1YUVaa3NBRzRWeG9UWWkzM29Z?=
 =?utf-8?B?RkpXc0llbnRHMWpON0cvdHo2QUw3UnZ3WTU1Rk1MWkhLays5ckU5U0oraUU4?=
 =?utf-8?B?K3pyMjNqeitwRWd0YkRTRHRWaUFwQUlSNExZaFIrYzFyazNvUmEvZXZlb0JL?=
 =?utf-8?B?aW8xNjBrbDZYYWR0R2czVFFRRUF1RkRIVlB6MUVVUzFiS3RITnJ3bnFIUllJ?=
 =?utf-8?B?Y3VLelcwZEJBMU1lbm9aUmNFdDN2bDZUZVZPcVpnanM0aUZzUXk5TUkwUmJO?=
 =?utf-8?B?WVNZTjBERFB6OG5PQ2hSTm9xZGpwS056bFM3aTRid2hjdW1CMXhobGxVcW9U?=
 =?utf-8?B?RlRBeE5yMExrM1lYSUJKM1ltekJzbXNkNWZCNXFkWGl6cVNpeStSZk9ER3dO?=
 =?utf-8?B?YjIxZEk1WDI5bHQxd3BDOXBnQWZxcFIvS1JjWWNiU1ZiNEFTYWVBZE40RkFx?=
 =?utf-8?B?NkpQQytubldXL3dKbksxQjYzc0FDR25QZVRCVFkwY2tFWGV5NzlGMFVISXZV?=
 =?utf-8?B?Wno0NnZUS1p1b2NMajZFRzQxM3FicVBHTkFJc3ZJNTVvajBUY3gxT0JkdFVi?=
 =?utf-8?B?UnVtd3RwdjE4b0U5VXJwU0w2VkpnRzAyN1Uyc1d3VjZPaEZoK0s1cG9tWHZW?=
 =?utf-8?B?V0lTVmhCWWoyZG5zb0RHcG94SGtKNi8vYW1jc3JLMnNQU0s5U0FrQTRKRXk3?=
 =?utf-8?B?Q3lVd25FVjV4NEw4UysrVmRPY0pFTExSeWc5bnNQdzhlVWQ0dExGdkVCczZJ?=
 =?utf-8?B?bGRWbWlWSkZoQ1pmVUdXbXdsQzFxcC9nTmhtQlFuK0hmcDdQcVBoV1FsQzYz?=
 =?utf-8?B?YXU1VjhBUVk5c1ZxZ1k1dG5keVh3RFdBYnlxdVhkTUFmSWtESklMQW52cU5K?=
 =?utf-8?B?enl5Rk9mclkwdWVrN0NjbkkxdFNkMEM2YmdabG9GMVYwL2c1U0J4eWN5eDVY?=
 =?utf-8?B?SjFSNWtRcitXaEQwUDJLQ2t2TnF5bTlJNGx0MVp1VjZ5NFN1d012eEc1cXFx?=
 =?utf-8?B?OVpZelM3WTFseXBKdWQ0Z2VLc1lKT0h5Vm5oOUlyT0dRZzhYMlJldmQxUWps?=
 =?utf-8?B?alhDVkZ4TFVnRmNVQmJrdEtZTElVSWMvYlpsTGdEWmkrRFgxL3REQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93af26b4-b346-41d3-00d7-08def8c47b3f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 22:53:09.9647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YbHalmIh1DOdgSVYYGD50sAFsxL88r0XJXJtN0Q6NwiGL82JEGBzs9bd0wQwNh/yccNEogH9ywCkH7eSwraMtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9500

On Wed, 12 Aug 2026 16:45:54 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Andrii, Mitch, Nick, Tony, Przemek]
>=20
> On Tue, Aug 11, 2026 at 10:53:18PM -0600, Alex Williamson wrote:
> > It's recently been found[1] that vfio-pci doesn't restrict resets on PF=
s
> > while SR-IOV is enabled.  This can not only result in an uncoordinated
> > disruption of the use of the associated VFs, but the ongoing use of and
> > access to the VF has the potential to result in machine checks. =20
>=20
> I suspect this might also be related to the somewhat weird usage of
> pci_restore_msi_state() to restore VF MSI state in several network
> drivers:
>=20
>   https://git.kernel.org/linus/371e576ff3e8 ("i40e: Restore VF MSI-X stat=
e during PCI reset")
>   https://git.kernel.org/linus/7e4dcc13965c ("iavf: restore MSI state on =
reset")
>   https://git.kernel.org/linus/a54a0b24f4f5 ("ice: restore VF MSI-X state=
 during PCI reset")
>=20
> I think these are a little weird because they only run on a PF but
> call pci_restore_msi_state() on all the VFs.
>=20
> I guess these paths are recovery after FLR of the PF destroys the VFs,
> and after the FLR, pci_restore_state() on the PF re-enables the VFs
> but leaves them uninitialized.  It seems kind of ad hoc to restore VF
> MSI state but not the rest of VF config space.  This all seems kind of
> messy and makes me dubious about exporting pci_restore_msi_state()
> directly to drivers.

I don't understand how the i40e and ice NIC VFs can continue operation
with only MSI-X state restored.  It seems to directly contradict the
requirements of the PCIe spec (7.0):

9.2.2.3 FLR That Targets a PF =C2=A7

  PFs must support FLR.

  FLR to a PF resets the PF state as well as the SR-IOV extended
  capability including VF Enable which means that VFs no longer exist.

9.2.3 IOV Re-initialization and Reallocation =C2=A7

  If VF Enable is Cleared after having been Set, all of the VFs
  associated with the PF no longer exist and must no longer issue PCIe
  transactions or respond to Configuration Space or Memory Space
  accesses. VFs must not retain any architected state after VF Enable
  has been Cleared (including sticky bits). For security, unarchitected
  VF state configured through the VF must be cleared or randomized,
  with the exception of persistent storage data.

For the PF driver patches noted to be effective, the VFs must not be
scrubbed on re-initialization, nor can a .reset_done hook in the PF
driver do anything to avoid unsupported requests from ongoing DMA and
MMIO accesses while VF Enable is cleared.  So it looks like an
incomplete fix for non-compliant devices?  Thanks,

Alex
