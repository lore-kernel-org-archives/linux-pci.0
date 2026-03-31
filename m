Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012045.outbound.protection.outlook.com [40.107.200.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ACD3750B6;
	Tue, 31 Mar 2026 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774958905; cv=fail; b=cII9e7noAV8QBFd95XAu/FQ7Bjrwr+eKdL9pJC7JC/CAfZT4F1zEtGFF7ar/vLK6KaBRqtV6L4WNew0TM6kJ8zSKaC1vG3hVFB11Pa2slxQmReKu72jMSsBodZ1+Iyg9ygDQe7EJddqczh+sojwyCYc3ejyZ2P1rTscmw03tqzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774958905; c=relaxed/simple;
	bh=iqlZ6W2juleQc6ub69VW6/gWWjCIkBO0cubcqr7hL/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jjsbXV57QYkWsn8HpIB8O66JTDs5tHYg37Ta6FTbNJSFhBCnEZFx81ajToSOtWvT7DLqNp2lp2XIXcipbdYU1EnQBqk9upBtC9oItGCnZQwyRDsOgN+cZaT9F0/LT1zSa3Gp8Fwrkr66/fB+RwNa5o2PBhz5hs5bTNKid/hrRGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sSNXBJRC; arc=fail smtp.client-ip=40.107.200.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sSNXBJRC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUS6xNE3XpZLEJ3AxaHhy7pfe1BCne3lL2iv37miGwQpJ+HO1rbQfHKh2zGB3Uf/vN0fFYkqSpbkiZROqIe1J/1izJfhDq4We6VOkiGw1pW33agkFGElOe57Y+EsfDPLj0IU38mI8opU4DeTgEqbRrX9O6BXAoWEEDth+TNJsRP6jAq0tf/c/YTuurncIFtaN5N+l2B93ZEcvJ8NkE1g7Rwmhf6JuznT96k+NPnPWsnMwreC7AyoRQqRGSr8a23zAXQB92H7n7wEjqZInZC/17N7mIopxUMopcFK/6nO+RT8WHB0BgysvtpJQGcxnoNUKHcq3fH2qyzehAgcG85BcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMuiR5FANByCN2kHwFzhr8xHmsKqH7ZwueFZJt//iU0=;
 b=hX8E8DzEIG+GyE/B+Ghtfl+d6h/StZk3vPAYVPyCkLMEVrfSoPHZx9xNq2LLgPdim+EGTi0iOB1qhWY2rlDi+rAuxZQ48wB/zyZhG1FuRozdBxA1AIsZEcE1BMzsREhCTHZZqDC6yJVx+0U6+FggFyc2OiIaw+TS6hHjrshRviYo2FVw5vsYdb1kbZ9/UrDeTJGGmUaTfcAzyd9GecEEw6OLnt8W4czYj49UNw4C9YY2aD3fxWnMI5zakN2lVQsYF5RDmUUG5k3AK7kKnMaHCibGua2gGDjj15e5Llgcf3DL/gJ7wiyN2TSwv9GyOeEcIuOPObf63n03EpQqOqAuYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMuiR5FANByCN2kHwFzhr8xHmsKqH7ZwueFZJt//iU0=;
 b=sSNXBJRClnnDQEadsZ4VjXxrd+QlR8jsiZvL/zB0FxXFO46CXobvWYyc+pTFMJCPWajDNHieUVS9Xh54Jl1KLA7wmnk9xeLAtOXXxfXxnQ5qFUEVCvfl+l4frqW/e4/rgTuz5D9K1TzW0Hurs8Q8hEDyWTZb8fhyhaAmCBrC++YQR3NT78Rg3MPTGVWPio1y3BEAHOMpMLb910fPNpu6SDgRBBI8mKMS3+W0hMf4DENVhcO390QHrW9wTqiE9in8B7AM74XyGk9endwE7sknQ5Kgc/PRht/woseRqLNUUsumMG0AKM3sw8XC6IAZpdaOISVmxGeKtOUv0MKSA/qNIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.12; Tue, 31 Mar
 2026 12:08:18 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 12:08:17 +0000
Date: Tue, 31 Mar 2026 09:08:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
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
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	Vikram Sethi <vsethi@nvidia.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <20260331120816.GW310919@nvidia.com>
References: <cover.1772833963.git.nicolinc@nvidia.com>
 <0e8d1ee1557c54943dd15ff836576de4c3aa58b6.1772833963.git.nicolinc@nvidia.com>
 <BN9PR11MB52760A7F20A1CC2BC0DB018A8C53A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52760A7F20A1CC2BC0DB018A8C53A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN0P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: 361a4fed-d852-4610-0bb3-08de8f1e3177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	96xgR8Kn3bP1Gpg9ayb5bQ+SgZu0NTCpksW+HIX5Ljz4RHIz/jVKug5C8I8xtmpH3csyDMORl8VTXQkRENWUDGD5et7SRDdYH0UNgDfEPIn9t2OYo9igxCEGwWIn92EKWD8MKmPb9zWbUsYM3jN8WFXP+Tz6wJMIG3yRYPxPoMvgsjaGYOnyWfewaLC+AUdtkGDIE5fxgVhVGVWnuppdQs3V9+J3j0nmxD9YfIkb/o3YDV0o02qiBJ93m/64uTOO3Cu9TmTIkobyFIMxrfYGefmvxiNgfe3oq6QRpM3QRtyFQ8sBtMiHh38hC1C2PAgYkDYE92HI1wWQN7wjCYwm4GC4tqT1m3muCf3HT20CEg5FmAcNAUcHlkBOr2G8jFvkJII1gzvANM8S4XF8amu3WmD/s3tx/Go3zz1A1ugY8aZzOhvrqL00vGlS0VMp2UnvYry5YGEGKKzeWHxaNPzDPDGSq8XYZz2Du0vJybPCAiERXcIboYerc3Cp+A1623zIM9a6m5l2skDMMnUj404CkHHS+2zYSkOif3ZUk/dbOtqO/FScH5QVTixZJal44ymMJq8SF4lcol9yU1f1J/gp48OQcOj0HVeZiSUuupFUq+4k8QA/OWeMvOb5W0btYhsiBUby3nRjxb96L8D38chddh6TqPXiGf1DWBcRqCd+hEmNI/XwQLgfmNsqzn3vNPWrNKKF5Bzn2WITVMtEWaeYYTjsn9bzijT0P34E0HQvzVg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HOp/VAUYCMWLsya9kpsd8Fikr99V0m60PNBPxcD1HZlsUo2iPMzpvcpHd6KU?=
 =?us-ascii?Q?7zFBdGEmap2CHir2GmMQ3T7puGYWGtzQ6JREcnne47rtDnGKM53FzcQkVYle?=
 =?us-ascii?Q?//6GIeU8f1+QbXZuDjVCaB4h52frKCA1reyI1S+JZmUbX1o5rb484RY6aMJf?=
 =?us-ascii?Q?InowfXQ2RWCxN3/1NV4sL4U1cU2F+rHtOIimv5iLibmquW5XoVcdbBTuqpAE?=
 =?us-ascii?Q?EfXmkCpoUTgSMt5TsQ6bxJWs3n9jx+dBO4ayPZmWUdsIl+OsiUZTGtWduEt4?=
 =?us-ascii?Q?YitBUxT+z9dgeqvWW4oRWZiAzbT6aliRGaFSqZRR6ga+EMxCFl8+PwSDAYJw?=
 =?us-ascii?Q?C23GE0UpWFft61O+Hz/Ol4lImWWE2+UfSU9Fc7RUCC3CHhx1Br6l79vuY2qR?=
 =?us-ascii?Q?q/Dkv53Jy5RemQtgsNj7rkFfTzkZcIP+aRjGSZxJ/0fycknCdIWvCK+btQND?=
 =?us-ascii?Q?SYlE3mKbxEU/mmFud5ma3ZC/q2YmTrwy6ns6Ub1ALZQ7Ge12torrUGPb0jVd?=
 =?us-ascii?Q?MAuMYVjzwVemn4YzOr1ZyGbIukSC0gpLzmPnTcwyHCZQgOr3x5K+dJD/jQ0G?=
 =?us-ascii?Q?bICtjQqBOvgaOHusLjOryoG+TKaGPNielQ7N86+vSsCv7byqAhuYxdLc4xeC?=
 =?us-ascii?Q?Ezjl+wpZ2MW6jm8fkrngyx9VQlKflO6XIQCnEBzSZDEsVhvq2uBCY/C6HnGx?=
 =?us-ascii?Q?OnlTYh/k0cdlmo4RrRC8n8j3EfKTKhlkRohUxvpB0fDGbTg7ef/POIN8DBrD?=
 =?us-ascii?Q?0G+6S8AGc4XFYgSpywCXdqCyYvD02UuDUzmu303CoId+1joVLI2MwJ1VRqwI?=
 =?us-ascii?Q?gh6iHZ3hX4FwGHUCYKJjswhk2ItVvSYeAM/Lh+9FQz/3QHLp1uyrze4uFZxn?=
 =?us-ascii?Q?1N20NdlVzAW0e6cIOsGLbjcw8nVrDRwaQziR6MvL7KVJJozYUI3A5nVGjwRX?=
 =?us-ascii?Q?G9ykQUlAKdbwRlkpRzHd8RhCKrs905WaVt8r7az3Wxtxyt65OpPkM3GSzXfr?=
 =?us-ascii?Q?8R2HRtHmn4gXOb6JQrXAt5SuR6tRff8PRWw101JBL1LyfdZvwvGMxwB5O9ej?=
 =?us-ascii?Q?2ndhYMyQF6IDyuj9rS8dNIrfT9lffK+dCnHFvHypTOLLoTXM5ZnqpNNSWAW/?=
 =?us-ascii?Q?HkSCJoF+VkeAVRUYWP9BdPUB/pyRBr9NAWdkjtd24SKfe7oJEMYxBAL1PdIO?=
 =?us-ascii?Q?EiP32DK1+f/ARj7W1W/SKpnxID33OMrqKN91PGfigs9ideUZKzP+AIIfMYNg?=
 =?us-ascii?Q?3K7gTxQ7CAlnw99zPbakdQiuJl1W00cqj2VCH3cJj0lRN5Zov4Lco5aleLh9?=
 =?us-ascii?Q?HVnmA8VGpWagrX3zqnxkRKK4JN+VuI23YtdkTykQLu42KxFBQ4qA/zUzlkwq?=
 =?us-ascii?Q?zYVIEePTk0c6SQP2ZNDS+XJnLBMAkjfF2KNyRoZkQzPccXv8sVzcivftVPdz?=
 =?us-ascii?Q?XoN4X54w7DG8qmty/8YUmF5mGByPOm7xFT+6l5//JJwkH/KJQ7gpvspAljhe?=
 =?us-ascii?Q?gXn5377VLRL2tRAAvOsVcypRPYxUC02UoWOXhLTWcQDDyjEFMq+0VWgGZkIh?=
 =?us-ascii?Q?go5yHcMwgzbeXvKY4hsDTBo9+d7RRaSRVx6pNEY7Vbr2oZhLhmYIndxWvo0E?=
 =?us-ascii?Q?cq+7FST4MqVjGE3XvPbLKF3arPDq1fX/1s5SEpR4UZXtEHFnZAz1nrp/NyVE?=
 =?us-ascii?Q?Pd3FzZlWaeUQOdtQ20EDZUzNEIKwWlOVpg0jW3aZaMrrGzje?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361a4fed-d852-4610-0bb3-08de8f1e3177
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 12:08:17.7646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKsDbKju1lC3qArWrKXPtkAZq+mQXk3IGbKF0Ti/m6fEI7d3MWG7d9vP+yiho5jO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560

On Tue, Mar 31, 2026 at 08:40:17AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, March 7, 2026 7:41 AM
> > 
> > +
> > +	master->ats_always_on = true;
> > +
> > +	ret = arm_smmu_alloc_cd_tables(master);
> > +	if (ret)
> > +		return ret;
> > +
> > +out_prepare:
> > +	pci_prepare_ats(pdev, stu);
> > +	return 0;
> 
> is there a problem leaving ats_always_on being true while
> allocating cd tables fails?

I would expect this error flow unwinds back up to failing device
probe?

Jason
