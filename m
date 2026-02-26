Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021096.outbound.protection.outlook.com [52.101.125.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D9930E852;
	Thu, 26 Feb 2026 01:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772069154; cv=fail; b=Prhaoi3gpqZIrByl0qAXac6AlrF9XrPb01S7hlIqU4vyQ/uRLJcw6mXIUWeprF334hFYECU4nFVCPueXFy7+v+G8bmpVKEMa/GkZ0pKdJa1b0C6enwWeslTQO6spSQMw7VFH1cg9RQrL3t/kHsd0LSIv05qdZ2zcjyXVvEuRYAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772069154; c=relaxed/simple;
	bh=tgLTtkhoy5Fx4dFnrOOK5h/TeDoaqfYSvyP8grr72jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mrYa42t7U8iGIB7/7i+jjwVT37HmZmjmZTBUC4wAjv4vw/vzCYpBqEAPQujLV+xCKqrff6YeyjISHEgxGBqERzPtc+qCf4RU4zsXckGTuNw7QXalYTDxB7kwZsB4VSTvGv2lelB72XFdUCasYYNQ6ZIOLaMTC1t46dzLGPhYP24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Crze9mdN; arc=fail smtp.client-ip=52.101.125.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Crze9mdN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jj9ucVGTlZ6TaloWwbalcUGwiSYXSvBEyQw9pX3jdY//WIEdHH+BFHXDOjPVNxpfLNh7eAZti+a766SyjgyGayqr+Sy5HPUqZCBRTgJtkj8+a+8jBt8dba4fNSn9nruqoQ+/3fAqakJWhrZCFQTKYISdD7T6EP23a4C8Kxgu6aj5YP5+UnnS2s+b/vSSzKNa0BJF8h+Y15XyB1u5BqgSoefmg6VPa7NyXhIW+79lIqWk69JhhPcvx7aATXL/9mase/jOJXXUqrEpZkmMbs8gnjLp4EHlXQt4f001CvfGdsCP5Hgzi8++8zasJ5MKSkMpiG5hnOGvWHydSrJAOxly1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n060uP+UtUDGcM8QJqr9W1qdTvHW07r/afy1GCkYNqQ=;
 b=dqTKeWpj5TMZF+GuY7sRTHupJzmXJ7/3C7Jp4pbGZMuCFL3m62l/YoceMB5eFbq76cRYXE+xKkmuOoXk1i6pNpb57L5GaUaFK4VA7x5801gmj5Nb1+76wAGnZIetjMvrhwevV48rSE9yM1wnNEiuymPaVgxuD/tk0d//2rukPqeQvQKEmyuynLcpKywMGw3HFJCDoquX7pWR0fz+oWBrKF0ISb1/8BBySdN9uabDLuVNHyIdi9st9Mg1Qpy+xFTx6tk41HmuYKHSzSyP+bDixYVTLNsp8u1TSGBXEY63BAXEm3Alo/ULsqk6/5oL7OXRcSUXs237qb1uj8Cjsu3JGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n060uP+UtUDGcM8QJqr9W1qdTvHW07r/afy1GCkYNqQ=;
 b=Crze9mdNqfJc4S9U45RuF+ksI+7EoVudMAMznjP8fceg87rUddDUPM833rUP0GpCQ0tHFvG4t0UT95g4owyjlWL2JC7aWGW1XnFEiGgq36Z6fwASsLtT+hLsfEGcoC7ZpHEhMd86zpUF6nFHwLRnQ1T3r+L9oQMcqetJjgy5DyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB2396.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:15d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 01:25:50 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 01:25:50 +0000
Date: Thu, 26 Feb 2026 10:25:49 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: kishon@kernel.org, jdmason@kudzu.us, mani@kernel.org, 
	dave.jiang@intel.com, allenbh@gmail.com, kwilczynski@kernel.org, bhelgaas@google.com, 
	jbrunet@baylibre.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org, 
	ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] NTB: epf: Make db_valid_mask cover only real
 doorbell bits
Message-ID: <2kypcbeqlgf4f5wsot75tyhxlhr5mvh23i3soezvcqjzfch7gq@hu3fsj74kkji>
References: <20260224133459.1741537-1-den@valinux.co.jp>
 <20260224133459.1741537-8-den@valinux.co.jp>
 <aZ9kgupPm1swi_AM@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ9kgupPm1swi_AM@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P286CA0022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2396:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e56933f-c21b-4212-cf2e-08de74d5f9f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	DtSZHqQI8WHwbW9mJsTLDkj39vXqMXULydd/jcC9nim0BGCvu7j26fiYSx9q9CAH+5QjZraFXWjzvqF28oc2ZxCBo5ec4FjuWys1twaZWZJz0QRjXhcQpsb1FURwvQkXB07jQwaG5HD4YSpi98IMzYZ7zbjlRmES+M8HQrm5hPWBLOKDqzAA+yYP/suOecbahq+jjr7ya81vfXabJHROGJppWZ74gKKTziiG9DI4pr/aVGF0wmfrv41akVmOlYHVomzJkcwmKGw7B26k/VEPN36yvgtWGkqzblZK7rXCovUZyrarqVBXm9Mrh9EmsJJjl5enQQ0dL4EcHbtw4PLvH9N87psxmTPOi56En7a3QdqbjVIEa0GXGva/UnFehEX875n46gezGUoxp0xo0dzoPjAbvQ7JewwMwlLIkchS4ZK1Q8+v4kchCmhJgqNpvYLBH3E6SgWyCdIT+bI1zB+BDkq5/LmPDs3wKmhDn9ku/qJA1X06L0L6curmOmCiPy+wAwIf+n8OIrd+WrfRwnkP+XEeRnorIAidWIM1hjDuGIIoyp/PpbcfLbls3EEesJUriEWQi5gamWNGKYotKP0JPURHKFcYDxPIbYpyBSTc4UNX164G6A/PJTElBHCt74MKLEiZdX43Mb1enm92AsRGh0QP6Q79/6lT2h++jN7hQjbgwPUBPnqh1QAuurq7YvWwRtQbus5OOLW75BOfr0wL1zPC/7KgCvMp7fkbuBU3k2o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O8WjkAfeu7LylTCrrxebop43bt1N2wKxHBgzyZZwDK3YfKzgwfBhpI+GV9R9?=
 =?us-ascii?Q?W/437rTz7VwEDM8K1PbcQB9s7iTBzJ4yi1LQzpEjk+ShmBtreSZxyknoPeSL?=
 =?us-ascii?Q?ffWkjjoiYYUtcC5Z59MKoyG3L8MKRcFbVDZSDU5nELNL+enqJdcfXBGbmqKC?=
 =?us-ascii?Q?T359go5HJY6nDWckYmdJ8EgNRqwW2Y3tuLIQuQ/m32LsnDWLOZeUWSah80Vk?=
 =?us-ascii?Q?9jol4uuzxbsoIt52KQuZBBWp0T2FJIocWPCZdLvEDZMtUAqdCIldADWxDxEY?=
 =?us-ascii?Q?m9EGm3kJ6NQs5zpE4ndVD79iDg636Ofg/YHeAZ3rfM/k1xz7QyOwpSP2MZCx?=
 =?us-ascii?Q?MNlLDJnvORJODK9POaEfKtvyvxy7GgLjgrqOqEO8RcpxT3jZ2AX60wG8IGpD?=
 =?us-ascii?Q?cU0tpTVsyiJyxfsdlXK5fEl8IQusF8r9bn+CVn1nE4RCTvhOjl2L1WN55AyK?=
 =?us-ascii?Q?XCowVKjlO9Hi54pu1RimuI3quiYxOM/fGuJ9Cwp3HiLjGsPap31QBvE8L5dA?=
 =?us-ascii?Q?1lyxC7Z9e4DhEamTncmygT1iq3V/lF5wtzhbKBiBaeuTZSd2cNsH11K+stI3?=
 =?us-ascii?Q?OkQV3D7Vjy9U9eIzb2+8z6rFUxyn+pVQBElChst/ftU5hBGSvd6mfpAc+S+F?=
 =?us-ascii?Q?COCarwox0uVCOrUqvdb8sMIK9DMeA3VDGrHMbn2H/VksaTk1j71O7xOPJdvS?=
 =?us-ascii?Q?41gtPfBmbeJLKeDMLGj6EMgeezY2L1PQrM0IAfniQMuyyf/ynbmzguNm8pXT?=
 =?us-ascii?Q?ladRKGUlPJGhQM9najkwp6702PWBQUpa56pQHGmvxArK+B4+ZgnbEpkNkN9p?=
 =?us-ascii?Q?byh6zdHIjxcvRtCJPOp4cF0BXjATH9T4feS7HI4DcGg3SAmFlCzBO9yRIVWP?=
 =?us-ascii?Q?iT49euclKA3XI93JrIY4t8TnTdFob3PuQMEcMcT/7gzd8fqdY9+fMaQUloYa?=
 =?us-ascii?Q?GBS8rgUJuDQPf/8yak636Q4vEnsnura6njEJCBiqd2olr0Y1xYDgnGFwpzLQ?=
 =?us-ascii?Q?n9zgjJ9AIQlzkqgnNvV7GOIVJh7c5LZkVzAsLYr6NA4lxwgJTbz6VdfpR5Qa?=
 =?us-ascii?Q?7DANGTIpmRoRQiReKbTcPVMG6HUoTeNGO7Egx1Fptmd4gsGrNvf04nI7tFLm?=
 =?us-ascii?Q?aCpuW4gxboKnTedp2wXGDVyTOKAgeZ2b2u+MNiBv1hupaLa2cnQgZTiTMDjz?=
 =?us-ascii?Q?Hl0JnZ4D0szIZwn2+/56KnOUJNd7aJbhgaFkF/8CRgVN3odJTK+b74lo+B4Y?=
 =?us-ascii?Q?mX8e1h3wyQncgw2bwBFKVkej6GkswV2s6TB/IUJxxd5ZoBT+zen4G3kImfV7?=
 =?us-ascii?Q?xeh8dLjoonnXtfwJyoe61+erbdcvaQwXOweKQBdN0u5x+OXY7mHWXc281qCn?=
 =?us-ascii?Q?Ptua724qIbBGHhp3cLjJAAZM3yLwliTnhNDG0LrOu+lvLbVVh6Vr1IGGLARl?=
 =?us-ascii?Q?EZ+jM9t3YJzlhOzY0nZYqhhqGWeoRvcBQzfmtNQeoD7lytMhSSLU7JtTy8yo?=
 =?us-ascii?Q?Z8xWmIBZeNyWTw+gkYHhZYNEQ3jzX/Wue2qIWFomonAhuX7y+x/dWkB/7oGf?=
 =?us-ascii?Q?AOj0dh4Q33JHKFpFXnHOH9Bt8WxyBetzJDgsoyh1BL4V1BqCgW6laxnTFVQ6?=
 =?us-ascii?Q?wyRXWehuf4xUM8749fWXZcP5ydB6cYM4kAFNrTZFLSt73oobRwR4BR3viNyc?=
 =?us-ascii?Q?6Yh+w/acEKIkOz+75EWNid9shOOKqef4WxndP16ioy0ztHnf6kQ+33nEIBP5?=
 =?us-ascii?Q?gfBdU8GqedRa4ytLhZrkjLJEpQcQBqDe66N3EL/MK/gVcje9EKys?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e56933f-c21b-4212-cf2e-08de74d5f9f3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 01:25:50.4947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zR9osakmSOL4iwUZzwoyzI3tEtBg+judh1suhZHBNoxefNFt6MRyU3WSTGCoQ3X5SgCBrLWdZtYyAiNG7DAiOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2396

On Wed, Feb 25, 2026 at 04:07:14PM -0500, Frank Li wrote:
> On Tue, Feb 24, 2026 at 10:34:56PM +0900, Koichiro Den wrote:
> > ndev->db_count includes an unused doorbell slot due to the legacy extra
> > offset in the peer doorbell path. db_valid_mask must cover only the real
> > doorbell bits and exclude the unused slot.
> >
> > Set db_valid_mask to BIT_ULL(db_count - 1) - 1.
> 
> db_count -1 or db_count-2, previous patch use db_count-2

pci-epf-vntb.c (struct epf_ntb) and ntb_hw_epf.c (struct ntb_epf_dev) define
"db_count" slightly differently, historically.

In pci-epf-vntb, db_count is configured via configfs and covers the entire
doorbell register range. The capacity is hard-wired into the shared register
space (e.g. db_data[MAX_DB_COUNT], db_offset[MAX_DB_COUNT]). The peer ringer
applies a +2 offset for DB, and that cannot be changed for interoperability
reasons.

In ntb_hw_epf, db_count subtracts one slot from the full range to exclude the
link event slot (#0). However, it still does not account for the legacy unused
slot (#1).

So effectively we have:

  .---- pci-epf-vntb "db_count"
  : .-- ntb_hw_epf "db_count"
  : :

  x   #0 link event
  x x #1 unused
  x x #2 doorbell #0
  x x #3 doorbell #1
  x x ...
  x x #N doorbell #(N-2)

This is why we see the apparent difference between "db_count - 1" and "db_count
- 2" in different places.

Koichiro

> 
> Frank
> >
> > Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/ntb/hw/epf/ntb_hw_epf.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > index bce7130fec39..ee499eaed4f3 100644
> > --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> > +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > @@ -580,7 +580,13 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
> >  		return ret;
> >  	}
> >
> > -	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
> > +	if (ndev->db_count < NTB_EPF_MIN_DB_COUNT) {
> > +		dev_err(dev, "db_count %u is less than %u\n", ndev->db_count,
> > +			NTB_EPF_MIN_DB_COUNT);
> > +		return -EINVAL;
> > +	}
> > +
> > +	ndev->db_valid_mask = BIT_ULL(ndev->db_count - 1) - 1;
> >  	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
> >  	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
> >
> > --
> > 2.51.0
> >
