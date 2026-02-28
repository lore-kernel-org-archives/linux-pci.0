Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021072.outbound.protection.outlook.com [40.107.74.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188EC2D838E;
	Sat, 28 Feb 2026 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772296435; cv=fail; b=oOZsb0jCBM0sTRU/nDwttRj0H6/9K2danx3PBSr+jDU7E3TrDkUwncm7gEpk5fMkB6V2JnuP5lGTps+w0hROTakcoVVlBIlkQLbqzDAuCqrQ41wUDhbBUAt4Z9n6rsUORC4JQY7o7ePxQtAznaSbazBVD2bRV7gCKS7s82NqYVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772296435; c=relaxed/simple;
	bh=ReYm5uhfX5iTn2HD0vdX/elN09HWBZAVs57C4haEzew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QJdoggaszn9sE7K6lgddyoAoW6hTzjEdDZEcx09VVHlBe1mEMzW7LU3CCXz0e4JSHu2SUa9p04T/uoa3Ju++nj9pPY0iddylN0znxdER6IRC8FqdX5ISiY7cGjm6gEN9vgmcCYkbV3AOFJldCpuSudr1nMax+ww2V2ZGjLfA85w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=OFgDKgoz; arc=fail smtp.client-ip=40.107.74.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="OFgDKgoz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vr+l1qqvwHfjPokBxQYRA2ddFWTRwCS/z9GQJwSqUBFjgcNwp4aJlVE8pjbneEt9Afap7qYBIV4s4z9/ARS7WXQNF75k3P7v+b+0Yk5XnuPW0g6SPFz2fC6QeINHbk8FyvLeYu4WMo0oXN4n3SJldFtyypBG3G5ZChgGmfjhoR272PO1IrO6ebGLL6CbpR9z15GgcP/wykeZB/ffDoj1c19vqzL1riOvO/xGr78Wzi8E6IAvS86vf2diAzyuX0oEd94/K4+IaJPnhP6XivSa8Z3DcPELpmWughjScfaqm3PuARSfHdBXZdwLjQA28bdMMow/CfwUt3Bs33iONphziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pCOb9dyr6/+xW/eLaaPtrhkZ4NKDPQAGLwfVqmdSkA=;
 b=qSXMWOYfoDhkBVmhtJoDmh2Mz+Oqw8AFsDuEqd5/JZLNNtIQzsnkh5ovQlHuaNVhDOfIHGw9HW4IdIlk1laGrSgP4LWILRjZF8oDY+sxll+X/42JqJFdAV7gNPxUtngy6YGBjlDa105/Z8msYIXg5q0uvhcnhaAvtJb1CLw/pBXmPuValkHi8Sn8HS7bL7msdopCrJ8sJZSSauFdyoN7bXUO/uZUw3tXqNLUwQ23rcstocaZy0m6kVbvwxRPvS4cxGAOfdP+GI8J2oCzqNp1eMnSJocpB3oxumgo0+tEM0+7vYeKBfTM6ephVq35Lut3x4/bIYayQkU1567K6wtbDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pCOb9dyr6/+xW/eLaaPtrhkZ4NKDPQAGLwfVqmdSkA=;
 b=OFgDKgozxp9UkjELQgrw92llxiAp8de8FzUDBpJznufFY0P2UP1OO8ag4ADC8+056dn/ubi/NTf/9s8E49RR3de/y6pihn7XTWJU6iIofnNnaORI9Ywl9P05dXR3s8X1pYl/ukDLjGRfq1v+Cu+1EPoLxsi20kliewjPoVZJ1mQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4510.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:19b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Sat, 28 Feb
 2026 16:33:51 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.013; Sat, 28 Feb 2026
 16:33:50 +0000
Date: Sun, 1 Mar 2026 01:33:49 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, kishon@kernel.org, 
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, Frank.Li@nxp.com, 
	shinichiro.kawasaki@wdc.com, christian.bruel@foss.st.com, mmaddireddy@nvidia.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v9 7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <cevi2tkpb6kpdufnhlujey3dfsv733j66ulezobmiemro7vdm5@mffq47qhkxui>
References: <20260219081318.4156901-1-den@valinux.co.jp>
 <20260219081318.4156901-8-den@valinux.co.jp>
 <u5q2ntwbjlqweodsipkkxcdtyt4zikfbyvriygsi3a3asbujc5@rgpblec4nwa2>
 <aaG5asXVV5sxRbnQ@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaG5asXVV5sxRbnQ@ryzen>
X-ClientProxiedBy: TYWPR01CA0043.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: 3115a5bb-be73-4baf-9ee0-08de76e7279a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	Tfklc+tQcbajYP5S75TBF9+ajUojKTFNjAS2RlNtZcj7SlTWAF1pwEKtdNwsgWHZb+IAhKK4Nua+nbjzIinxpOVk1c1xiDo8jgbM6PdUnZd/DkxOpr4baaFyC6RrXfgStf9aoziKzLTbFSyWSXZDF7UI36skk+GrGTLg6itq4AGauF7qvesf3RHphf7smGTB73pkS1CXmL89w7Ud+le+9hnY/QiUTmpHM3zCDmGxySdTMakcnYbl0Hf5vGN1fuALlq61hGlXwrzjFy4rvBp0DaZLt4KIRd29THXUw07umBEG4yhVSgmvlMFZdX6b7L1eeq0VGSujd64LUS503ABXGczvoXAMhEVnv6mWtyDgE1scRwLN72ZFZv6gFgrDfEAgKsjDxz0gQNoA5RYhjBVtlfRsDkMnrPUGDBpCMRFKbeKqeWNSADv1q6vDFuyQfHuWJ3UVqAqsSJtF8VNcT3F3TH+NTBaLyZwzHQYviTdjPrWosIb1qoL3RbF3XDOrFck3zlPJ/UAcA1QFQ5H9Oc6C9gJYobcELUtS8N5GxpcQIz61T9Z82zYDAyHsCrW5cd6hMk0jP5+J9TCXeH5FJHH27q7r1B5MgPY33DWaCc8C2Gi0WcyAQyrupoUpalQ2WMcmiWh8erruevOKFcXQKr0sk/BGG6ZJoOfQw3cpRMEUE1OCBEQqmuiGi9s1PV1Pn2Ou
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?50cVy7V7oLWIxyfUWA/vWV8Bx/+T6taqWOXq0dP5k/n9eGQNHuesU6vdHrVN?=
 =?us-ascii?Q?+49Tvb8wYx3BTaTAkgb9xRn3fWbglJT5QA7y5hrf3iHeoIAxglksX/TCHMFQ?=
 =?us-ascii?Q?p4UFzTFVINhCqUeErgduRJIviQzhgaXJDCnTodm+7yeUj593OXUzCJVm1auk?=
 =?us-ascii?Q?RQ3BVvOcLKymI7SjfOnE0rhpYzLTPTX4fbAhnkTGczM69sqemxM8h/cyBa0Q?=
 =?us-ascii?Q?UkoVMxvhJNRtBFTrAhSiZFrxDGGtQ67HlLAChsN0Q9iiTWjsNIde2H8Ov/Fr?=
 =?us-ascii?Q?yBSxtSjpeq6q2q+xynCPz4WGqTLEYUeU3xiNJDQMRKbPenVU8u9mJnfmjCE8?=
 =?us-ascii?Q?CC8NZIXVGOTNUSBFC+thPpaLQlNi6DWJ2MG+1/CraNx+7hcJ5fL7llmpIiAg?=
 =?us-ascii?Q?kYEV6GPdCIPC6rbXK3BylxPjk2JKh9DbG47yHYYCXrFmZj532CLDipNOyoS+?=
 =?us-ascii?Q?Cctn+ZuXyq/gqhe1zKDJGIMsDYPN86uji9kZAYHIiNvgK4vdpfc+VETLIIhZ?=
 =?us-ascii?Q?r76EKsLsYVW/tHHMjq8ckAAlBGpD3cC8V4Qgsor8nnXFKV5+Fk4PD4sLAiLl?=
 =?us-ascii?Q?ngp+/W4c4+4FEQO3Y6dKn0zjtzNjB+P7HhlW7a8opbx0CwDKaFZjdVXGRbeu?=
 =?us-ascii?Q?WKW8DeMLJFdrHxk51dXUw3/2R/mPuX0T6XyXdGB2/dB8XSj1KN+N+gyi2jUA?=
 =?us-ascii?Q?r3vs8Jo00HK0U/r5Pl8ggacY41N3QlCRyAAMBHwGx3FsnBCCH8nTEicOe5/H?=
 =?us-ascii?Q?JB5s9H7+u2g2wDpWfzFEdtpVyYueJ8eryRT7HC5QOyPgwrXS3s40XCZaL1Sy?=
 =?us-ascii?Q?bnZI/8hfoyboG1+h7WWdWU4wAXNyUh8pk6VbOLqg9UptLipBY04X62lEd+TL?=
 =?us-ascii?Q?wXfyIKDOiyNznw6j5mNLS+EuxN1U5YRnIfMv1IG2VOulCUlgNJoZNXhmgaZy?=
 =?us-ascii?Q?ACoMhOR4b89ahWBqEhk7cDn7siXEuV08U1TTtdo56hoNmXGrFY7Sza34vGzU?=
 =?us-ascii?Q?pO3Xk1yb5OWIPh58uCFM0S2dH8kQGGq6KrjPVb9hFPx/ZnOvceAFGpbaVQXP?=
 =?us-ascii?Q?HUmVeiEcLpi0m74OK/8UvyYQUhX4Pv0hXxxbfGAM0H+AWyPjATdUF+q6VejE?=
 =?us-ascii?Q?5ifvrwBkfkjZ+5Oo6tehzSqkl0R+mnXsRkHzlS/skSAmYAVEAx2S9ESGHwWO?=
 =?us-ascii?Q?Da9Jfs2j1uwLvDTgsXstJsAfn9OOwHaePQzoHvIVTfkmZL9ct0eAdYcmzcvl?=
 =?us-ascii?Q?olB8m161HEX0vLWGhE8ZmpJdnTGZlh3meHg+o7eIudFhVWBUGdYw1n0kQBuy?=
 =?us-ascii?Q?W77+6sgxm99fAjgZTqv9kAfNqiPngqceD4JrY6XwZp6r/odizzLx26gRIcPs?=
 =?us-ascii?Q?tcIjHNZ0Aux5J+VigdVG0F/FPgN30kudqhoSI3qOS3BtaNUCy2bc/NCmksR7?=
 =?us-ascii?Q?jE3HglpBn+AQzhkrABNp0XUSmfaUMSj1QKqFM7xwyWAOkie68ZS4C1w4GlwE?=
 =?us-ascii?Q?4tZ6f/yBcaeFu8DinnEpbrLtD1jY2yDCoWOCGjK060W7/XnUgykpzE+D0j1B?=
 =?us-ascii?Q?jxCCn6KV/ut+eIRM0j1cV0+THiSCDx9cujq5aBGXkuv6ljQDzAOvSMPKoChC?=
 =?us-ascii?Q?6R+mnzfZppDpzJxvT+rwtCpfH2PMto46Sas+IsJguluOUDGWwipFrweDf495?=
 =?us-ascii?Q?osk/Y5Ff2shFkoVh/gdEdScvQqjsYbXw+BAaRFVjF/FHCw/10jex43SFj9lO?=
 =?us-ascii?Q?Cj6+k9QybSmikh6GEK6B/JitZNUJMOkAaFibjlQ5WhZ3mAgQKXlc?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3115a5bb-be73-4baf-9ee0-08de76e7279a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 16:33:50.8149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdr0XgoYl/ZZ1RWEnYzpiiEqNmEVusFYCqYaIx9chdUD/3mc6aKU5ht5ACyZbbl5EvBAHJFXlcIPgHvrRPv0mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4510

On Fri, Feb 27, 2026 at 04:34:02PM +0100, Niklas Cassel wrote:
> On Sat, Feb 21, 2026 at 02:42:35AM +0900, Koichiro Den wrote:
> > On second thought, I'm wondering whether it makes sense to handle the case where
> > the embedded doorbell target resides behind an IOMMU in this series.
> > 
> > In v9, we simply expose the raw physical address without establishing an IOMMU
> > mapping. When the EPC parent device is attached to an IOMMU domain, a Host->EP
> > MMIO write through the BAR window may result in an IOMMU fault.
> > 
> > Initially, I planned to submit IOMMU support separately as a follow-up series
> > once this series is accepted, to avoid making this series too large [1].
> >
> > Niklas, any comments would be appreciated.
> 
> These patches are for NTB/vNTB:
> 
> > [1] Supporting such an IOMMU-backed case would likely require additional
> >     patches for vNTB + ntb_transport to demonstrate usability, such as:
> >     https://lore.kernel.org/all/20260118135440.1958279-12-den@valinux.co.jp/
> >     https://lore.kernel.org/all/20260118135440.1958279-16-den@valinux.co.jp/
> >     https://lore.kernel.org/all/20260118135440.1958279-19-den@valinux.co.jp/
> 
> If the diff you pasted above is all you need for pci-epf-test to pass the
> doorbell test case when running against a PCI endpoint with IOMMU enabled,
> then I suggest you just send a v10 with those changes included, without
> any additional dependencies.

Thanks for the comment, Niklas.

The three patches mentioned above are unrelated to whether pci-epf-test passes
when running against a PCI endpoint with IOMMU enabled. From that perspective,
the code snippet I pasted in the same comment (which you trimmed here) is the
only relevant change.

I'll prepare a v10 with that snippet (polished up as needed) squashed into Patch
7. Before doing so, I'll also take a closer look at your v2 series to see if I
can help move it forward.

> 
> I understand that you would need additional dependencies for vNTB to be able
> to use eDMA doorbell on a PCI endpoint with IOMMU enabled.
> 
> Perhaps, drop the vNTB changes from this series, focus only on pci-epf-test,
> get this series merged, and then submit an follow up series that adds eDMA
> doorbells with IOMMU support for vNTB?

The vNTB changes already included in this series (i.e. [PATCH v9 5/7]) are
necessary. Without them, vNTB can break because the doorbell fallback can occur
behind pci_epf_alloc_doorbell().

Regarding the three patches mentioned above, since I included the vNTB ping
performance improvement in the cover letter, I thought it made sense to consider
those three patches as prerequisites for this series. However, as you suggest,
it makes sense to treat them as a follow-up series.

Best regards,
Koichiro

> 
> 
> Kind regards,
> Niklas
