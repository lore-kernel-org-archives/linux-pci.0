Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D75A3016E3;
	Thu, 22 Jan 2026 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769087681; cv=fail; b=FtQ2Oni6Z/aMo6dNRKdw6xjmBJTfQK0C9hkdSHN/px2pUxg66tiZNVF5NggG/ZNiuRUL43OYfrzfHC4dGBl0y5m9fzpUdcFNMyztPYYxoOWSFZ5/ZYJ4BSOua45odKp/93Fhs5kx2ND5TsiA9/tPnQtJi3GJAoTiOpL+HBMIesY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769087681; c=relaxed/simple;
	bh=ELVf4dhJauMT/nP95AP4d2+n8YfsUIsOwaAKghGFvR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PDj+pOuF5cIrlkQ2W0nqy4JL1YamUhzqqtocZRgSE3aNeam778t3H4HHxRoSSxPd1o4U1rSqVVk80IVhGLZOdqD4CUPqZaNr3q0mAw/RzldBNTJvxa5yQ77rkI+NBdtVQBPbRqMU7RAm1RmB0py4rJCYHJoXE0R1CIjGNl4uBdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bM4NmwlZ; arc=fail smtp.client-ip=52.101.46.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bM4NmwlZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oC1/44dK9ZiaFrfk1EkZP49VYqkG6eDcXdACMQSLmK2w+MgjHTsMCACCtGmtxRxnS0bBJ8h1fWIH84Z5yMdCLKMxyMxuvEnknzV4qGVEsp7Zk4br3ErqVgAY8z+72UdWCt6x4zRgOHRacBOGP5TNDegXEQy7yQQcIH7ahNMTC8h/9F7QyxrlQdT7NCf8zXedoCi56OULV0/60ZRKI2kg4ft+EmYbNTa3x2mBpUFS/+NwvsXnM4FjUAKKMjzZ389i0TZa9Gv/WqlRuNwp9p+5BBmivvBId6KS7sLpLuDe1BkC8q7X/dkma9zaqQzWjPY8VJNRvG336KX9EJsa9FOHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzBFsjCUMeWApgIagprm6rUbDfFQlSRRGjGulktrXh8=;
 b=dFQUSE3QHmfboabLcphUyLIN76cmr688Hyb9KB+yI1+C8Vz5mklBbaVuLdqryIXGNVBUk3OmkttP0pM1Q7k4kbDkliS65srN4YUoNsrb2U6ekMJNXO+3iHk/NcPmOLSK/4zvHABbGBfkemPPceqnEx69riYpteAG9KdRTGcmPk8eI1j45uZDEjoZowvTq/y6Cvwh7Ru+kDzsR/mKU6E3WSuyimjocG0cClukZ6b5RtTWJjBB5JqPMGxkKwkzIKXV3ym/pr4HVO5emX1m8I7mDsqbCZGwqhIh2G72SMu7i/mYZlGviSwS0ZLn/kZu/PDehJi7PQ2577vFdvBsukY7Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzBFsjCUMeWApgIagprm6rUbDfFQlSRRGjGulktrXh8=;
 b=bM4NmwlZxzQqFIC/srMoiV3SkyfXNJCt0agYmDHYjXQGVTj5f5y1DQeKu+aBcdX5oIwC1/8zQ1cAYEDd3XyRdUOIDIfCwNzCoV0OEB1X4Q+kqEFkegENFNKJHt9LWQEgaAmct+FuWeYPFaYItTVdxNueCzxkZ/BtysxwzEoAUE2oGMf4P5IqsOlzmt88XCcYYqWNuIPoby7sBcJOYj19ojqWVXDLQecHLMZf5JSigRrLaHr4Xc+bI+SXgUYCVXtHiubCIc4rkcK+MePDiKCY6VWb5li1q4LB5cH8HEqfAT+GRtuYn7KiIlWRSyhO25utU9bYUmAOLnG3Bq+tGPGoXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB7983.namprd12.prod.outlook.com (2603:10b6:510:28e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 13:14:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.010; Thu, 22 Jan 2026
 13:14:35 +0000
Date: Thu, 22 Jan 2026 09:14:32 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: dan.j.williams@intel.com
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260122131432.GJ1134360@nvidia.com>
References: <cover.1768624180.git.nicolinc@nvidia.com>
 <d1768bb6384050a23769f20ca28216f520f77e26.1768624181.git.nicolinc@nvidia.com>
 <BL1PR11MB5271F0BDC68C2D7F172122E98C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20260121100307.00004e60@huawei.com>
 <20260121130315.GE1134360@nvidia.com>
 <6971b9406d069_1d33100df@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6971b9406d069_1d33100df@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: BL0PR01CA0006.prod.exchangelabs.com (2603:10b6:208:71::19)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: 25823723-25cc-4c85-8c07-08de59b83005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+20kGrW6IAF0vaDeEuCaqAfFjNHXj3OHm1ui2uHt+LGylfAUXbMdzxoKz12v?=
 =?us-ascii?Q?Zr6dynmpoGaZxvmRE2G3LQ2gF42/gE8cE0MuqYuLAxNyY4eLKoPDE1uZSkck?=
 =?us-ascii?Q?uS4NUG841UqnHr2nwgV/Go1sx5iC63PZpcY/qWUZ4XXxwyOsI37Hg8RJe+cW?=
 =?us-ascii?Q?heVoWG6C0/HinAJXidYSSQorXqQloq/L82HoBxp1yZ1vUbCg2+vhGASmwe2p?=
 =?us-ascii?Q?7q1rl8bLr4jv6wRIeJ5EfU9aHwbBUBay6a4XcC8hvAPyUM59lYGCI+MqSONH?=
 =?us-ascii?Q?zL7IHT/Him3UZbUK+3LJzT7K++Ozuaowa2Ut1mkeqijPxRE9fGLPAPHULyp7?=
 =?us-ascii?Q?GdJzoOlVs8a1eBzn9tsy3U1GRzL5a/7vSTQtov6M7W92k4lclBVCG4SQID1P?=
 =?us-ascii?Q?7AlstITWQlp7r2YY7+VRyz7XF/trZwTYAi+0wNKCx5hZbxe4SBEuFK4hpuJc?=
 =?us-ascii?Q?A/Ma1v1aA6ups5DXFX/ULGtuq8YCE+CkjyBEqs7a17NPdshCnVwpg17OKIPD?=
 =?us-ascii?Q?l6WMtSX/4yjEBLzCOa+cj5kvp1LjQSZdfrVXjLBn04dLBAMEITpyg5oah/BR?=
 =?us-ascii?Q?fy71G59y4f7ft58FvDsXUlQW/ZkzDhTXdOV5Mr46Wfv21BS/JncIrYB55naL?=
 =?us-ascii?Q?EkfbVW+KlQPJg6if2BW+q6aiGytTOahcqBVdAJAOVnJbPbPxpqJWA96qvjRY?=
 =?us-ascii?Q?UcZ7KkBE9mgJ5osh9GcSoNngYUCcuRjjvYa+pUWIGlVubtC5uTmRwXTeRxzs?=
 =?us-ascii?Q?HpFYHAxH+joUUpFrvyvBZhPnvhEaLI/I/PARCbIOK9xuvAHKIagHYZ1dLoBO?=
 =?us-ascii?Q?5BaiMAt0B8feWHye9K8vy2iUFjh8j6NxGiZ+2qQdrD2WMNR4lBjgd4YZ9o2l?=
 =?us-ascii?Q?tGq3FJjdEmtHnyjMDJJ4iGAoYCJ58BZkLD7303clFOiHmN9ijbjt6ZlZ5L+f?=
 =?us-ascii?Q?ymNE2LN6hIVjLPSKK+uYZ1k68sRm9973t1H1axSC0cHbHj6Zlun9sShSasGL?=
 =?us-ascii?Q?2nTE2IzRqfraFzRNaJ5uohqhMbrvDjYBP0edgjs34UpH0z4DDLKJo+lidehn?=
 =?us-ascii?Q?CBKPNe9qflI4CO23PuKQlCvdIpNPYijVRABPRtrAYhW/46tOtbbCbdRJbEz5?=
 =?us-ascii?Q?Z++xkChXhLb/KTwz4+Rw7Ox34K6/CKRMkkQY6YgYkI06wf0eAjvnda8zhNTG?=
 =?us-ascii?Q?wiczgqdtveBg/QGJuq8JEOhnGtUEfnDQpKTnL3XqfkmU1/Jlf6oKaaj0IXly?=
 =?us-ascii?Q?CQtIbkrlRWbt508T7bh6yrDGU/mMMjdp2S1zDgZuJk/LbdxTgigB9vsUeMom?=
 =?us-ascii?Q?73imb+zKmVqccn7jMfNvBcqEFTrtMfjEHv2SGi/KisAlgrx3sPHgKsPpsqvt?=
 =?us-ascii?Q?N7KQEg4iEbzDlMfu07ZjYfkM8ZQn2Z6jHFQZsw0Fl0wLMI5b6Uo6Nid+Jlhh?=
 =?us-ascii?Q?4cdDzz7hO/H0q5Mec0CWeCB1S6C7+oQcqgdOtOiJZT+ECT1lO9Ky33c9ANSF?=
 =?us-ascii?Q?IP4ec+Vp6CYRTngRws8YCV1T0m0NI24WEW+tXXcdTbeCtQgzO1iOJU9+nz0M?=
 =?us-ascii?Q?vvMstE6ChfKILmOHDlU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CvhDhdDyn02LEEIcYwpwxeW5ZkySRaFsqmDFlo+VO38T0MKUjwv66Ji/YPvB?=
 =?us-ascii?Q?Q8rBhXesDAb4LmQwYpQhK5u1H9ZNWUP7nA3SkEr4c1eSmlHurUKqD8zRwNtf?=
 =?us-ascii?Q?inajiM2fgW5mTNj1A6fTfWUMYDTaeqvnpwwRHFC3Uq8qHeGrsN4fFXIknvT4?=
 =?us-ascii?Q?AaeDoU1d/JqnDa07HK7V094z+Nj5MAeOE3Me5Ta5CwuoWA+IqvZtM8LTe2ZE?=
 =?us-ascii?Q?w+jgMMQFdoH9A2ZzADzXh1MCy3BNCq/ivoQ96alp4nEn7Z8yc33JXwQT/ilF?=
 =?us-ascii?Q?RBbeS82iwfC+AlQjKvjE2tXecrhDK0OlLj7A0bU5CxofC+4ZXt4Wya1PZysp?=
 =?us-ascii?Q?MMxPKZFStVmxwPT40cX6LC14zoV3+BFTz9utqBj44pqA4/cmI9WKFJ9K1l07?=
 =?us-ascii?Q?z7yqzU7cpb74pJy0P2qfg7pNrGbZqRXzicYNsk63RdK9tmf182M2nEAmZwFL?=
 =?us-ascii?Q?bHFQ1PSJNtpwTZukhAE1uLXfSn5Y8e4lifcXJxGZIxGUCbVsbyw1KOqM1aKj?=
 =?us-ascii?Q?ttO9vGEP2u2DZ8ym6d8y9FL063EStRKCiEGX8lo7+F4KzQeQEGXwEirlIpxZ?=
 =?us-ascii?Q?YRz+T6x7xg9r7ITNxFgDXreJaBteWVsYszrHcI5dmrZ1US1RJ2htZLBaa/z3?=
 =?us-ascii?Q?RA3VHfexZBoVBVlwyFf08LLbzFSQG1aFQbW0VP8ihISAUE5TItsiBJg14xiB?=
 =?us-ascii?Q?oo5xU5yVc2LeWmuUAOJeyR+iljlJaywoI/GQKQmqV/h23H7Mpz4UPdnqO0cw?=
 =?us-ascii?Q?a0Z91g6JWgJrCP+Hid+mzZSrprFhpTnZRVItFBS2A7lfdKbveD4lywdGe6KN?=
 =?us-ascii?Q?AKyBZPlGOFyg0DGNhgvJTivdaVi43pKJPpUha03pQ/aPTmoF+7k06eRiFJjS?=
 =?us-ascii?Q?WQIvurdkLRSfr13QLXyqhgA87qYCQzE8bBr3xZYX5N6zTw6mW9dwBrVCzqBE?=
 =?us-ascii?Q?r/T0hUEQWV0VAgRYN+UjUvcDGDgNHy2Hw093iTE1dfsFcJMLQqm0rItvSWvF?=
 =?us-ascii?Q?fdstL1XDG0kmbhkEmI368abAJrvAdhvSqvNFxzvezbr5kyvj20z9LDQ0m39f?=
 =?us-ascii?Q?jRqVYCMY7zgEuH/ipeIWI6qTJvPnCUzJuH9Na74XcRoYdoEqqo5lpSOeCVmN?=
 =?us-ascii?Q?aKpuhz2BTruspJxNPgNhqLKPvobkXOyPDuAp/HQSGmA7nXfhYUKPkPJYSb2T?=
 =?us-ascii?Q?dJmwPU8ulETZ3VTVOnC/A5WmXceHFSsKgzJKSX1wp02l15RX/XQg4JOkkxWn?=
 =?us-ascii?Q?z7Ts40rkjwt5kZNqkfDtkiybQORPWN79rD/QF7LNtrL/2lXSslcoKfrdnQOx?=
 =?us-ascii?Q?NBaSFcUHV1gpHFcRzSVAvtTmXs9QlvVrdX11xyDwvlJbRYj0SD7MuIpZZuM7?=
 =?us-ascii?Q?fwVRfx6bFqLzrATt6fpIhVYLIIfw36CBLB8WCNIsWouVJnn4DRF5F6/QCnlU?=
 =?us-ascii?Q?CS3b8PdisecDU9HxWTVRY3bHvqbvymeUU9vuI7aQwyR2SF5VQO/vDNIOBoRR?=
 =?us-ascii?Q?hctR1x45HUq5MIP4h+4xxvw978Y7N7f4WuQ0Y1s7DBOtdLZeNTzc89xj3uBI?=
 =?us-ascii?Q?XZaRxk40oLaDvynV0puV2FJVztB4LOrF5LrRMhQfXHySKvIadBBO35iMSmQY?=
 =?us-ascii?Q?q3Z3G32j96h9s3vMymdTZ4Jdq1VrnhvC7N7rhNpB4i6hJmsLZVuUzAFaoCuP?=
 =?us-ascii?Q?OZG+Qv5G+9Rwb2p/JflICTJdXeE9wIyQ6nyacLnXux8zXeBV0SgdXei2M5uV?=
 =?us-ascii?Q?dLJNb+hCRw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25823723-25cc-4c85-8c07-08de59b83005
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 13:14:35.2600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: neMu/T5LwQ/RPTQCkbkLaXYZU38CwTVqkhaszt9t5hP1h4bEX928LH/Q0uERer4j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7983

On Wed, Jan 21, 2026 at 09:44:32PM -0800, dan.j.williams@intel.com wrote:
> Jason Gunthorpe wrote:
> > On Wed, Jan 21, 2026 at 10:03:07AM +0000, Jonathan Cameron wrote:
> > > On Wed, 21 Jan 2026 08:01:36 +0000
> > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > > 
> > > > +Dan. I recalled an offline discussion in which he raised concern on
> > > > having the kernel blindly enable ATS for cxl.cache device instead of
> > > > creating a knob for admin to configure from userspace (in case
> > > > security is viewed more important than functionality, upon allowing
> > > > DMA to read data out of CPU caches)...
> > > > 
> > > 
> > > +CC Linux-cxl
> > 
> > A cxl.cache device supporting ATS will automatically enable ATS today
> > if the kernel option to enable translation is set.
> > 
> > Even if the device is marked untrusted by the PCI layer (eg an
> > external port).
> > 
> > Yes this is effectively a security issue, but it is not really a CXL
> > specific problem.
> 
> My contention is that it is a worse or at least different problem in the
> CXL case because now you have a new toolkit in an attack that wants to
> exfiltrate data from CPU caches.

?? I don't see CXL as meaningfully different than PCI in terms of what
data can be accessed with Translated requests. If the IOMMU doesn't
block Translated requests the whole systems is open. CXL doesn't make
it more open.

> "We have a less than perfect legacy way (PCI untrusted flag) to nod at
>  ATS security problems. Let us ignore even that for a new class of
>  devices that advertise they can trigger all the old security problems
>  plus new ones."

Ah, I missed that we are already force disabling ATS in this untrusted
case, so we should ensure that continues to be the case here
too. Nicolin does it need a change?

> I do not immediately see what is wrong with requiring userspace policy
> opt-in. That naturally gets replaced by installing the device's
> certificate (for native PCI CMA), authenticating the device with the
> TSM (for PCI IDE), or obviated by secure-ATS if that arrives.

I think that goes back to the discussion about not loading drivers
before validating the device.

It would also make alot of sense to leave the IOMMU blocking until the
driver is loaded for these secure situations. The blocking translation
should block ATS too.

Then the flow you are describing will work well:

1) At pre-boot the IOMMU will block all DMA including Translated.
2) The OS activates the IOMMU driver and keeps blocking.
3) Instead of immediately binding a default domain the IOMMU core
   leaves the translation blocking.
4) The OS defers loading the driver to userspace.
5) Userspace measures the device and "accepts" it by loading the
   driver
6) IOMMU core attaches a non-blocking default domain and activates ATS

Jason
