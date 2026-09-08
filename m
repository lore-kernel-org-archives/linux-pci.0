Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814B5583ACB;
	Tue,  8 Sep 2026 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885416; cv=fail; b=bG2WDSHDajvyVWAdXJ+KO+H9dnAaIE1vlqdW/C+oZN0RGoAb1LM90E62NaxTdsB+s0p79tTohcu6VSvjy7TRgs0tO0bpAGvdbBRSo7Z3y/qYxoit4nlHL4x9fHwRga9qyL7ISHrs/jr/gmmYHDXMsN+Ep4iN0IonbUgm1KmH/0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885416; c=relaxed/simple;
	bh=gp9260Fc3qrs0CiEiOZqI9nYeQFsF1IIvnV+jgiySrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fsb8j2JNoe9xXKag6nBPJD/KK8g150UuLh3iHWq60Nwus75tlnOWvuANvb96KsICoNlaM+n0jIn/T8PIQ70Nmbk1dq/YVha+LusPvJFJ/hv5MQOyMBCuweZIjOeBuzxPaRlHIrqgjC92ewIqaO4YYJ/jug2FT/Tddn7ADDxmSjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ALbsNpVF; arc=fail smtp.client-ip=40.107.209.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ALbsNpVF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjddWXcjXo9puSLbPBbyU3WK/SCmA31lcf/JBicwwLweEXtfVrQQmzHZ+LG0kT19p05Cbxyjr8JsH4mKAS8eM6kZ96eNEQs14x2JX90kOEv0PvVBCq3RygkwVW45IugQBbpurkQFdEpH2SERoaCrLTk3ykW7P9w9BupnBbgKO4cB51toq/DoArlhfdNjRcZp+UelkHnJIRndpYNxJH2/tYk+J8/DUIf4zmIBph69ao1Y04oR0gfZ5flGmOiLupKIBbLnPccfHmAga/UOmnwCvAyMByEaXvTQsg11yDRv++rFlYHpGmiZ00AsqGCwvfVG1/SjEoURKXyLohxiv1pGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2Yw4g8kWJPhdHiVuHGdA6mKRDCEwkKPx+eDMl/+Oag=;
 b=uc/O0vLPQrky5J2eIAqVVnaKviuJnQIweg5jK+BrSK9ReqvAbWVdyQu0q093wOvEYyOFZFWX9o16yOEnrCair6h+gza+QZtRDYPyiXBur5XN1l6fhuX55Qp+w8rGq5lsfUCbS+ese0BzFMrv9xBJ33R1l7rWCnxqHlNb/OqysCcyNrmSIrId1qcMfUp5zn/3fX1m1jsszijcuulGDv7pzCLJT5cHVo9glXWrZM/9TUiEx10nHdLHl0O3ZJEnTTdNO8n38NthtxC68VoreHtd6ZVXuaWrhR2Lk0WQwHrIS32p/ApJOK+vHGiVZX7PLvJJl4RWN7bOAB4irW40lorreA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2Yw4g8kWJPhdHiVuHGdA6mKRDCEwkKPx+eDMl/+Oag=;
 b=ALbsNpVFK/SXW+qEYqRPRWasGI+mtJC/X67kW8A2HMcSs3svUBI8a1PAd1B8b0qznSY/xT5UUvJ5+mtYDHjfRgj47IaE2P6T9BD0w65D4MCXgFUR9kfRGQq6rxaYJdOHl8ymr37k6RMF4tg3txEav6LR+u6zarUxKuBnwdr/6PdpkcUJj9R4CFigYp3NWADcsoN5j1RnV4DiCCOBYKKKwp42cLplHbcCfF54ABlD6bRveAH3YQMjh8hWXQasyz95v12SzlYdjVFCusUXHv0MQOGg6hbJdd7LGxri0kyhdkwDkAerAclZKwrCrhVjHUVtguEROrO2NceKx6ORuGZSEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 16:36:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 16:36:45 +0000
Date: Tue, 8 Sep 2026 13:36:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com,
	praan@google.com, kevin.tian@intel.com, kees@kernel.org,
	smostafa@google.com, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com,
	bbiber@nvidia.com, harsha.v@oss.qualcomm.com
Subject: Re: [PATCH v3 03/13] iommu/arm-smmu-v3: Drain in-flight fault events
 on domain detach
Message-ID: <20260908163643.GB2779763@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <8717f3329313f40308cff20006066283ebbb3a56.1788222485.git.nicolinc@nvidia.com>
 <178846311316.1308030.6266899352044838554.b4-review@b4>
 <20260904140906.GR4157646@nvidia.com>
 <aptMynoQtAf1Jcr5@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aptMynoQtAf1Jcr5@nvidia.com>
X-ClientProxiedBy: CH2PR20CA0008.namprd20.prod.outlook.com
 (2603:10b6:610:58::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 506afac9-c49c-47d5-7263-08df0dc75ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|4143699003|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0boTpDuxru7iQ3+GkPPqFVa+Cqv3F4P5L/VRLr+E7U0U1x0w+7i1VuSNZLH5wKEwK78civiFQsYqzEJgPkgPZtZN9QGolIT1rZN4JB0tvtXDZvMP2h7dkOoBknScisGgIdUw8Yk7Pom2PlGMxNHnMf/ko3sVOSrQDiahq4b+q/uxxSUUVDhbk+8L+uXV45w7qaEzWTC883hevqjNWLlRCes6QMDbiL7bxkwORC7hRuU581huZVR29XbuF6CAFvODiRc0V5gMMIoFMdmZZzps0HjWPROMKimdiqTRYWeGFghkPcrovOIYlJzSNvp+IcRnoPnqAV/JJDS/JhmAxkPwHx990NUMVbNYypCiJ9duLiQTp4EOTABAOypF/H9uuxxqMle7s/bAuFLmjp81as/ZaQG7OMUeZwBIOeKDsP9DlOOKRbS2XoFhU9LUCGN7CHMC2oPGfrTJcNbkY9NkrC1urXx/mygUP28JoSptfYUHkdicZejLuTu2GVXidnO2umBZ6re8QqJvC5DalSWmJL3NVJoXPFpe/UfkJXKQtkGSyWXCLbZ6LR+imjV7CVkdMov+Wisocih2qXjJrk2DbfaCx5ifCV5ui32nmvXsz7v84FyBtuhRyLgYHzbzrWziR3lYI20VFRr28nzIWTfkbQHbQjQ44vAC33t1YJpquep4XGE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(4143699003)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Q993w8slbH4bbiBbDg0UoDWFrD6wg9PVOxi4cjwtZXtvjHrlVqwkE7o/jS1?=
 =?us-ascii?Q?uIDCqViv32GQyJRK5H+6+hDQMwL21fToFr3e/c3bK2Hhrs2yzzVFAeeOxSGH?=
 =?us-ascii?Q?5NgTtgOHtzsFxQNb444ydlkASqJcbr+KanK7iugqvfjXotN6/aff/Ynw1XzO?=
 =?us-ascii?Q?Y4n+haR6Dc+CgkipGEuNu38KdpvF2Fneyrt3fdrWE12Q+oeE5+CfIZnaij53?=
 =?us-ascii?Q?wDjKZZtHWB48CPq9Gy/0rMeshwIl6vAb/iIguasQXF8XscnidmcQx4uH1U3k?=
 =?us-ascii?Q?x5aaHyRFJa9qcXHeNfmytvGAm7Gxu0upQZ7Vv8Tran6EleOscYlJynNDmUcv?=
 =?us-ascii?Q?8Ht804OWibMiU+fc2C0+o9mo57O0SSoaA6DB/PcQOh4OORsjkKdGgkOcSqoo?=
 =?us-ascii?Q?xO4ImjmqY4WaVz3s8cNHO7uMBV7NiCl4zgfa6KXW1XSIGRqcfjMQXl7jAhQA?=
 =?us-ascii?Q?NNaSU8f/rQyfvuueWXdkqyeQeRvdoj2pAXGMYtZHp1Y1apq8m/o6Y2ua+tvT?=
 =?us-ascii?Q?VIDUrdCN/bPRoMA7NDLj6cY5i2m9TloZUclIi3PmxOWrgMX/e1z+ew+ifcNd?=
 =?us-ascii?Q?pOJcS8CXFoGrFFeyA8mPNpNgDSbh3Ts7o6qv5N7q+hmr3nPTqlKYv3RScpuN?=
 =?us-ascii?Q?4ftT/9g/V/eYUPf1XNyQ+S++dMy6znGPkkyTsvNwT+EPTanavxemS26Iawe4?=
 =?us-ascii?Q?U9SIN0yqb8RILmUuv+KY1fHjtpbHkbqdYOxk3k0HoUe0HLbZ822s5vVsUxI5?=
 =?us-ascii?Q?282UgDqxDAfWABtbXVW6EQgZOYKtXrCgqAcQJr4P5yScZfBZfQzsHearjqh8?=
 =?us-ascii?Q?YjplFU8qtaOiNp06yWWU/M7gzAtMDjW0IGYHzp4kLqF/+bf77/eGf5cGhcn3?=
 =?us-ascii?Q?Bgv2cIVbYpY4c2LSoRHmMQZ4f8xG9Cetg581Owloft2pz8rVsaw/LXMJTKiw?=
 =?us-ascii?Q?koG5BCfxZsfIrtVZe28hKmjd/SIXZMw2gs0lW62Tolwg08O62biwDDPfONus?=
 =?us-ascii?Q?PFbeMssoLfwiaAs25sPdqHPzEU6gqtoPgpNe6buNdEqLwpgMjvWCiAbC8emw?=
 =?us-ascii?Q?LKKfXFisBV+l9Hxmy7HReYPtHH+xgk+rLKjRQ9jPrkBl8KRCILvcY9uqkfCt?=
 =?us-ascii?Q?GjVDNuswQSUHH9W//zNHPfkz+d0QZjCjKn7qtMzwQ8hwXP5dBboULi3Yab2F?=
 =?us-ascii?Q?NgHixdUuSyyvcrpAr0CDbRx46YEvUnFMQhd6llB0W4eKRF+KbdroIepngJFO?=
 =?us-ascii?Q?+5ViZ28rq23PxxZaWreuUdHGgQ/F72TDYTjkaHjwNgFUsxeqzksm/mSIidG/?=
 =?us-ascii?Q?mhGMENiPEI3vl2hK/0r9cKX5tCwCSuJhpiiSti0cB7dRm/SqRnoC/XqnBff9?=
 =?us-ascii?Q?jj/dbB5rbwfk4wRHpmpQ1/J2r6/XvQns3RDBXdz8MU206GgnQSuqNo9iCVpl?=
 =?us-ascii?Q?Zh1e+P0aql1JDpE4MlE1OzwCk6r3+kPvscr0fqYce2Owz1ub6NmiFd6utlCW?=
 =?us-ascii?Q?e2ymOeCbkmnQvDx1vkyHPWoB/rYPLdsRe+GCdQ7FLkk12G+Hg/b7+qKlQiwx?=
 =?us-ascii?Q?06bNzIqn3fciNw5d2al5jG+yRNz2rWfKMXnifmjtdCGP39grjEHDC+A5skr8?=
 =?us-ascii?Q?DoVsA/5JVk2dZTBc1LQPBq8r79BSpVAAMlzDKI/6KBfqkb960KM95Z9qJPCz?=
 =?us-ascii?Q?+y6Y8tePY92fCeQxZ3ygAo8/KMgWet4xt6wXQ2e0RenVa+l3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506afac9-c49c-47d5-7263-08df0dc75ec6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 16:36:45.2952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDsANY5oOY6C0jRmzxQwubWnRTVR1kustDRg71HZftHPh3mS8rGb5iJNQbnlX3Xd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8201

On Fri, Sep 04, 2026 at 03:57:14PM -0700, Nicolin Chen wrote:
> On Fri, Sep 04, 2026 at 11:09:06AM -0300, Jason Gunthorpe wrote:
> > On Thu, Sep 03, 2026 at 12:18:33PM -0700, Jonathan Cameron wrote:
> > > > Also run the drain for every stall-capable master, even when the departing
> > > > attachment did not enable IOPF: such a stall event has to be aborted while
> > > > it still resolves to the old attach handle, 
> > 
> > That isn't the model for fault handling. The fault is delivered
> > unpredictably into either old or new domain. It doesn't matter which
> > one.
> > 
> > Domains have to conclude their fault proceessing before they are
> > destroyed, and attach to the a non-fault domain has to conclude faults
> > before completing the attach.
> > 
> > But there is no requirement to deliver faults to any particular thing.
> 
> Edited:
> 
> Also run the drain for every stall-capable master, even when the departing
> attachment did not enable IOPF. An attachment has to conclude its in-flight
> faults before the attach completes, as the incoming domain might not handle
> a fault at all.

I still don't understand from this why an non-fault capable domain
would need to flush on becoming replaced?

Jason
