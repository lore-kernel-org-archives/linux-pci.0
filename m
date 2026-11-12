Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794452445;
	b=Pb3LSzeCyD+JGL0W5RBi/M/FUAqzh9nMyNiUtE9CJyTANmH+DHmr2V3pOcxRX69sdjNC
	 3Coh6+W0Yif1b/Q42KsqqenolkzfhZcmix1o3zeH0d1+tOPa7qZ6YOlp01xvft1/BflQx
	 6etWm73xjHKOR/uQhTmB1hIdiCja+PwrKLS69lNdLPBCtjt+iQtjbJSOvkdZNINMEP73n
	 zJ9FXLnX+82h/DGJNJu50XVUmB5cCAdrSKxEcylKYfnyMuIBHK4r09Gj61G5v1PdN897u
	 8/rkLkKzP8oOzbFnPxctpfl7RRZjJ3/bL/M0bkdYbTE19iuNlZfTO+f3jA0KDA+qEuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452445;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=n5C/jtSJ4hNFqVai0fu6OYmHh1O8vcx2s7ZB3WwXtq4=;
	b=5DM5TG0LPKvexPyvKIo0Dw8f3fTZseZCf4H/Z7EeM+UAvSO4f79HOPlHtBGy2n1xgO5W
	 DAMqYjls35juz0l6XjmdRwv8vabNF+e1uruKIOMHsLtfu34Ga0gmicx4p6sjXKT7aGyn9
	 YrAMSoRO9kAuqWIBU4RUeTcgVUe1DJE62xNHtr0IMeFzBomQr8dcPmRDyn/bkprJy9hai
	 Z4GDs3bVHHxDwAxVWJ1oN4297dmaePJgsv3UTcROjJMYSwSO8eNguVczSpz+wXZzw15DO
	 sh05HSTkYqX/t/V5QDtZtDrgTpNck0PLcQec8pjK3LL6GuFldXYxHC+wGqyPaNTdrqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=JkjJUxMe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.43
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EAF606A321;
	Thu, 12 Nov 2026 03:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93EAF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=JkjJUxMe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3yyUO6oIIpoNDoNOw0WI+h38NoAp9GBlChwYHapFyDCE9IWAJF/EdiAdNZlo9O7/hTgHueZvSMKRYBt341izyARW6abBdozjR8rK6jQ7NvS0oKjNC1Ln9Y40516IHT7W5O90qFAdG406nGdMaQSbmsKJhChlq25DAbfMyRz81t2ePEOxLo2E0WCJfT+QlQB2AblGZW+9zF5Adv3kB92XST3oLNQdDv+UBjdFEzy6bmzhJe+Ai4GHHhF5DUHKmCcO2nGFO7rb3cGRYgxIGa1Rr6AgInIlUOTQ2U0UnM4IAEz/Dz66mzdtFdlSfL+4+ms84ntaIktEXe8CbhFm78FiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5C/jtSJ4hNFqVai0fu6OYmHh1O8vcx2s7ZB3WwXtq4=;
 b=jNQD6dqTsyHLVn2QQTEmQwwW7jsSJXu4yB3RJar+j8BUCembPRxQ0L0EyBFQC/THIV1IYKJFEFwErVmuY7I8MSg6oRd4f079m7ZZwEQZGvQFhQnyPi9T331CE2ZCLg3EtT4x5jmL8U3KpEBP25VFfTFMAnGHoa+UwYKx/PAgZgIUCR2dNdzBz/jyc0B1HMLBoNwcT3cJ8RKp2giVmKoHcJIGChZsOaqWfMkZ/1hREGUuEDHjAC+BlGkZNCX0oEL9a4PdKCxroyYsx+/X6iAoXp3uHeZjHqgPwyeyl6j4lfyw0i20uCT9LiPYOa8gqKQlNX36u2/8Tle3ieh4CpDH9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5C/jtSJ4hNFqVai0fu6OYmHh1O8vcx2s7ZB3WwXtq4=;
 b=JkjJUxMeg3pmjb1dOOZuq2pAz00nsgjH0oPlPoavLQtmaBV4tehe9o8naTL66uYrF7NWyBw4zlae6NRx2t1ZGo4DgjZxNzYxiHldpLY7GPbJaRLS5fZ9/sZ0XtimLss11dFNC0cHWKdLiIY57L596Ep8ucewHMTqLgXyyN1TfDgHAb3QKlGrQGaDdPzOkeALct0vfRNf3d32sPw8JjVGDRa/Yme2STuKx+R+gXvjKLbJfIEAewK2aGNY6pOwUyi640rMu82qvksKJPw+ip28Gf2H7mdrbVRmD/ZLhZ61l6vn6CeIwN9GclZUMdl+lIHx3B1pLA5McUYhd75sB6rvWQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 12 Nov
 2026 03:00:41 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 03:00:41 +0000
Date: Wed, 11 Nov 2026 21:00:30 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Check the pme_turn_off callback return value
Message-ID: <avUrzss_VTn5m3I3@SMW015318>
References: <20261111041821.2259326-1-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111041821.2259326-1-shawn.lin@rock-chips.com>
X-ClientProxiedBy: DS7P220CA0039.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:223::33) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM9PR04MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: cae4ca29-d5ff-4898-30cb-08df406922ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|19092799006|261022105027099003|261021121427099003|261021123027099003|5023799004|11063799006|261009223027099003|261102123227099003|56012099006|261028144727099003|261026140227099003|261022075727099003|22082099003|18002099003|261026121527099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	EaWZb4yRTbDR3qHmls18aAS3dlnbr8nDZsjYz3ocOuwNBl7arSPoBwY5oni+tHdkWLXFiEAQJTJFTvCbGm4i0VOSjCAs9KAp+6sexEhHa4ZOuQyVvJIPCI0NUxHhkg1nLu9S4iATkx2ojMhzkbu5CFAUok+VYmITZDnZkGYOFbLaf+gu66mqJCiyL820v1NKhMbB18V0JGW4YVba/mGX458eperFua9OTVHXJH+MJBhVRAV97Z5pDoi0SU+IvtU1XBAWjFBcBH22xotcCyC8Z1Ze7vESroVH2/il+87HTKKQB82lk0OCSwWU9ojROynTLgElXdbHtJR4c42ATAeoenawaYwyrXjk9Gy4HlwT4XhqU+8HyDaZsFRO1SldYHqEhBd9TLRjrnHt3q/Bcta3IurtkeSTz9lC56VxsrSRZmoxYPh+BoLlFzw3izV5Yyf7hWcu+nJjW8g2NhwyKJkUsXp0rNetAgxMrXp+TPuwKpYjZlcXISHG08eUrBMvFTAoKMlUVTeexy/xppe2RKPZDGp6tkMZ+lX80zFPG6TMkbvT3JUmv7JAMc+mdF9oRADzqrCM5ITFZrMNJhVZMe9JPS5ISRyPLmysMXqVMbRPG/MdtR0hRNSzk2k03wabTLb8VGxcB5pReKLOK31ukzR2vamowoPlY/pldn/5QFTAcvc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(19092799006)(261022105027099003)(261021121427099003)(261021123027099003)(5023799004)(11063799006)(261009223027099003)(261102123227099003)(56012099006)(261028144727099003)(261026140227099003)(261022075727099003)(22082099003)(18002099003)(261026121527099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JQEf3ogBgmZbaoaFON28Kde/EWryKjO3cFxjl21aO1fKGjjZU7G6ZLtyqaw0?=
 =?us-ascii?Q?HVcNVV9CvG4mtYxuGnEeCWe/+m4+npRH/r55Qy8vBg/TWmyjIsEyKPA1OCve?=
 =?us-ascii?Q?40zFj6TcUvAOm4WlcPc4ZtFGlHs0+6IDw8OekoedNHrjQnaFioeTrhwa1wzI?=
 =?us-ascii?Q?lLSPb5zRUEPbYBVBXZg1ljHgO/GBj3GEe4e+8AMo3BPd4UB14C4KH8+jCJ6m?=
 =?us-ascii?Q?mlsBSXT/n9qLlPK6X6YhkjrXmRkLc0NiBjySSmIVHRIeEYxxAwPzIQALe6jn?=
 =?us-ascii?Q?iCHp0cDngVgESqyxKFnpR6vkoXVgs2EgcUS9OuwR1IqUpzWqqL8cOG+0Tjey?=
 =?us-ascii?Q?MM7dN8vkmLzAPZMV+ua6XVOrX4h+NMN52FIM6UR6A/UML3cqEMB73rdQhE7k?=
 =?us-ascii?Q?uhsLBhR/23Cck5GgxhsPsk+B4ev2ENTjJ1iFG5CtWuk+ttJkOssgk+g6F4fH?=
 =?us-ascii?Q?4bMr0ryU7wCKEil2NECukjQj8Nk7yobsnWPQlJ8mrodu7I440qL7bgjh1bco?=
 =?us-ascii?Q?p0SCcRmhD4WCTpY2BTcztM9FrjQntQxtVFaJJPj3eaXMsElgzrgWAQikAJxZ?=
 =?us-ascii?Q?HMheSoB6Nb/NxpCv+60niawLlWVNuB+Ysr/GupBPE3RR67K3VIF6u2N79wYo?=
 =?us-ascii?Q?jEWU5Ht7cgjTQgcSnCoA/zWbrDkGyD0A/VCbXWKx6e7/25NFKU5aaqEfHyYJ?=
 =?us-ascii?Q?kBepnoEGMN9xmjg0kz4sYGNBm+XO7ukmRRtwGwnYWW6bG8hBcr4N5O1ump87?=
 =?us-ascii?Q?7xYb9HleBs/hd6dmXa7f6Ez1RW5GO+HeKfY/ME4Qmoylj/+/MWJgEUtpCbjD?=
 =?us-ascii?Q?fZU1f/pxwveKMwn0tzTehWOg3A8GzfxKcs798Y9wOTlltXoP6g0wp8DtjgyD?=
 =?us-ascii?Q?tt6iaUjiI7uG+awQyLIRPf8qtgjRDo9f2/zTquK3/J9RAoPK0IZ96JPAc7Iz?=
 =?us-ascii?Q?D/lwlujOmF70Z9Srsx4BIZxBxDNslmhGrFyy8DhyyJBkMYexhMd3W2YybiZo?=
 =?us-ascii?Q?OpEDcRH9dM9OcUUGVg+jelYEdRRD68oCiUeZwNolJcNoCcQ+YkWBQJAcWOaX?=
 =?us-ascii?Q?mBspLa0Gvooc6gWdKiCk/WE2cU6u8SxyCjXhzA4A8mKnV+bTW8vpn5euMcue?=
 =?us-ascii?Q?W8NwH+4fkKpCNZ8mEqZ89AcEf2kJbO5wEubV4yHJ/q3z8BMLiWpfLRhEBVnF?=
 =?us-ascii?Q?IqkVbK69hGMspGwsiV1NQNyl7aUvg2N079j0U07QLmhyDzfBCRr9tYHNXz2Y?=
 =?us-ascii?Q?Zk+H54WYIBkAOCy5392Bmb0V3p+Ruc4oHN0W0o1Crryo27zdzNaOZOKlwU5T?=
 =?us-ascii?Q?suYFq5gUoQTvl/2Bc7BrdaniEa1Aue2JCNheGKDafL6cJmcQuwsDBKf2Zz6w?=
 =?us-ascii?Q?Hx5JMniTwNK9IYmLeWCOdbrqVeYx91Sqwm8Sf/0tvncpQMNgiSqqOjfMb+DQ?=
 =?us-ascii?Q?/fXp0ZwGwwT2twwkJ/uO9ufwwT7fnf3Z30eZ32Lm5QEJk1JARmdEGrKzUQ5P?=
 =?us-ascii?Q?Tku+yAeISQ720yQcDcSZR+VF8pLzUlo08mMg1lGl2Mh7xpG49PG7cRbav1pY?=
 =?us-ascii?Q?1T4B35Tchh1l/yKtIqoBQocq0wW1wuZ+qE+pnHLM2B+Z4XuVfdE+B1wf0sPZ?=
 =?us-ascii?Q?FoNZ9BR1pvqaWM608UAX2L9hAxOUYPgo4yGvJm/e+Lq2wN4i3B9JUMBq6+B5?=
 =?us-ascii?Q?0jBPSCRZyd2U+9rKJ6VA0SszTfAI83r4Ki+Jc/ohqO9ua9WVGhxVJMvYUlwE?=
 =?us-ascii?Q?aPcSzn2UgzNBc8Nuf3mLQ7dAHmQ9X+cK5Vlhu0YyuNqwEtXzcxRR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae4ca29-d5ff-4898-30cb-08df406922ee
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 03:00:41.3493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVCFwLZMwlIEVy4jbAlfTgfyj2ndVezoHxfmla4XyicYX4gidmO5KTAcZa4DnhAKxaPToxSsVG7vChTTstRec5spMfdzr+Y967Olzgd1MNlFKAPKKqQEdv1tEW4PGRFH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8954

On Wed, Nov 11, 2026 at 12:18:21PM +0800, Shawn Lin wrote:
> dw_pcie_suspend_noirq() invokes the optional host ->pme_turn_off()
> callback but ignores its result, so a platform that fails to send
> PME_Turn_Off still has the link brought down as if the handshake had
> completed.
>
> Turn the callback into an int returning function and propagate its
> error from dw_pcie_suspend_noirq(), matching how the generic
> dw_pcie_pme_turn_off() path is already handled.
>
> All existing implementations return 0 except:
>   - the Layerscape PF LUT variant, which now returns -ETIMEDOUT when
>     the PME_Turn_Off handshake does not complete instead of only
>     logging it;
>   - the Rockchip host, which now returns an error only when
>     PME_Turn_Off could not be sent at all.

I remember first version it is return int.

How do you know PME_Turn_off have not sent out at all?  I remember spec
require continue after timeout.

Frank

>  Its PME_TO_Ack and
>     L23-ready wait timeouts remain non-fatal and just log, consistent
>     with the generic path, which does not abort the suspend when an
>     endpoint fails to respond: such timeouts are an endpoint behaviour
>     and must not make the whole system suspend fail.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>  drivers/pci/controller/dwc/pci-imx6.c         |  4 +++-
>  drivers/pci/controller/dwc/pci-layerscape.c   | 22 +++++++++++++------
>  .../pci/controller/dwc/pcie-designware-host.c |  4 +++-
>  drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 16 ++++++++------
>  drivers/pci/controller/dwc/pcie-eswin.c       |  4 +++-
>  drivers/pci/controller/dwc/pcie-qcom.c        |  4 +++-
>  drivers/pci/controller/dwc/pcie-ultrarisc.c   |  3 ++-
>  8 files changed, 39 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 38a59795f98f..643b591c789f 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1575,7 +1575,7 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
>   * register is reserved, so the generic DWC implementation of sending the
>   * PME_Turn_Off message using a dummy MMIO write cannot be used.
>   */
> -static void imx_pcie_pme_turn_off(struct dw_pcie_rp *pp)
> +static int imx_pcie_pme_turn_off(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
> @@ -1584,6 +1584,8 @@ static void imx_pcie_pme_turn_off(struct dw_pcie_rp *pp)
>  	regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_PM_TURN_OFF);
>
>  	usleep_range(PCIE_PME_TO_L2_TIMEOUT_US/10, PCIE_PME_TO_L2_TIMEOUT_US);
> +
> +	return 0;
>  }
>
>  static const struct dw_pcie_host_ops imx_pcie_host_ops = {
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index 475aea3ef58a..8bd879226971 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -117,7 +117,7 @@ static void ls_pcie_pf_lut_writel(struct ls_pcie *pcie, u32 off, u32 val)
>  		iowrite32(val, pcie->pf_lut_base + off);
>  }
>
> -static void ls_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
> +static int ls_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct ls_pcie *pcie = to_ls_pcie(pci);
> @@ -132,8 +132,12 @@ static void ls_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
>  				 val, !(val & PF_MCR_PTOMR),
>  				 PCIE_PME_TO_L2_TIMEOUT_US/10,
>  				 PCIE_PME_TO_L2_TIMEOUT_US);
> -	if (ret)
> +	if (ret) {
>  		dev_err(pcie->pci->dev, "PME_Turn_off timeout\n");
> +		return ret;
> +	}
> +
> +	return 0;
>  }
>
>  static int ls_pcie_exit_from_l2(struct dw_pcie_rp *pp)
> @@ -179,7 +183,7 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
>  	return 0;
>  }
>
> -static void scfg_pcie_send_turnoff_msg(struct regmap *scfg, u32 reg, u32 mask)
> +static int scfg_pcie_send_turnoff_msg(struct regmap *scfg, u32 reg, u32 mask)
>  {
>  	/* Send PME_Turn_Off message */
>  	regmap_write_bits(scfg, reg, mask, mask);
> @@ -195,14 +199,17 @@ static void scfg_pcie_send_turnoff_msg(struct regmap *scfg, u32 reg, u32 mask)
>  	 * to complete the PME_Turn_Off handshake.
>  	 */
>  	regmap_write_bits(scfg, reg, mask, 0);
> +
> +	return 0;
>  }
>
> -static void ls1021a_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
> +static int ls1021a_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct ls_pcie *pcie = to_ls_pcie(pci);
>
> -	scfg_pcie_send_turnoff_msg(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), PMXMTTURNOFF);
> +	return scfg_pcie_send_turnoff_msg(pcie->scfg, SCFG_PEXPMWRCR(pcie->index),
> +					  PMXMTTURNOFF);
>  }
>
>  static int scfg_pcie_exit_from_l2(struct regmap *scfg, u32 reg, u32 mask)
> @@ -222,12 +229,13 @@ static int ls1021a_pcie_exit_from_l2(struct dw_pcie_rp *pp)
>  	return scfg_pcie_exit_from_l2(pcie->scfg, SCFG_PEXSFTRSTCR, PEXSR(pcie->index));
>  }
>
> -static void ls1043a_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
> +static int ls1043a_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct ls_pcie *pcie = to_ls_pcie(pci);
>
> -	scfg_pcie_send_turnoff_msg(pcie->scfg, SCFG_PEXPMECR, PEXPME(pcie->index));
> +	return scfg_pcie_send_turnoff_msg(pcie->scfg, SCFG_PEXPMECR,
> +					  PEXPME(pcie->index));
>  }
>
>  static int ls1043a_pcie_exit_from_l2(struct dw_pcie_rp *pp)
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index f531c5b51b3c..eb11556aca72 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1249,7 +1249,9 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  		return 0;
>
>  	if (pci->pp.ops->pme_turn_off) {
> -		pci->pp.ops->pme_turn_off(&pci->pp);
> +		ret = pci->pp.ops->pme_turn_off(&pci->pp);
> +		if (ret)
> +			return ret;
>  	} else {
>  		ret = dw_pcie_pme_turn_off(pci);
>  		if (ret)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 0ece9c433229..9836ea9127bd 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -440,7 +440,7 @@ struct dw_pcie_host_ops {
>  	void (*deinit)(struct dw_pcie_rp *pp);
>  	void (*post_init)(struct dw_pcie_rp *pp);
>  	int (*msi_init)(struct dw_pcie_rp *pp);
> -	void (*pme_turn_off)(struct dw_pcie_rp *pp);
> +	int (*pme_turn_off)(struct dw_pcie_rp *pp);
>  };
>
>  struct dw_pcie_rp {
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 525a26ee1d07..ea7ef0be1214 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -464,7 +464,7 @@ static void rockchip_pcie_host_post_init(struct dw_pcie_rp *pp)
>  	pp->bridge->broken_l1ss_resume = true;
>  }
>
> -static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
> +static int rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> @@ -478,18 +478,16 @@ static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
>  				 status, !(status & BIT(4)), PCIE_PME_TO_L2_TIMEOUT_US / 10,
>  				 PCIE_PME_TO_L2_TIMEOUT_US);
>  	if (ret) {
> -		dev_warn(dev, "Failed to send PME_Turn_Off\n");
> -		return;
> +		dev_err(dev, "Failed to send PME_Turn_Off\n");
> +		return ret;
>  	}
>
>  	/* 2. Wait for PME_TO_Ack, bit 9 will be set once received */
>  	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_INTR_STATUS_MSG_RX,
>  				 status, status & BIT(9), PCIE_PME_TO_L2_TIMEOUT_US / 10,
>  				 PCIE_PME_TO_L2_TIMEOUT_US);
> -	if (ret) {
> +	if (ret)
>  		dev_warn(dev, "Failed to receive PME_TO_Ack\n");
> -		return;
> -	}
>
>  	/* 3. Clear PME_TO_Ack and Wait for ready to enter L23 message */
>  	rockchip_pcie_writel_apb(rockchip, PME_TO_ACK, PCIE_CLIENT_INTR_STATUS_MSG_RX);
> @@ -497,8 +495,12 @@ static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
>  				 status, status & PME_READY_ENTER_L23,
>  				 PCIE_PME_TO_L2_TIMEOUT_US / 10,
>  				 PCIE_PME_TO_L2_TIMEOUT_US);
> -	if (ret)
> +	if (ret) {
>  		dev_err(dev, "Failed to get ready to enter L23 message\n");
> +		ret = 0;
> +	}
> +
> +	return ret;
>  }
>
>  static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
> diff --git a/drivers/pci/controller/dwc/pcie-eswin.c b/drivers/pci/controller/dwc/pcie-eswin.c
> index 5639666d5148..ed498601312f 100644
> --- a/drivers/pci/controller/dwc/pcie-eswin.c
> +++ b/drivers/pci/controller/dwc/pcie-eswin.c
> @@ -269,7 +269,7 @@ static void eswin_pcie_host_deinit(struct dw_pcie_rp *pp)
>  	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
>  }
>
> -static void eswin_pcie_pme_turn_off(struct dw_pcie_rp *pp)
> +static int eswin_pcie_pme_turn_off(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct eswin_pcie *pcie = to_eswin_pcie(pci);
> @@ -281,6 +281,8 @@ static void eswin_pcie_pme_turn_off(struct dw_pcie_rp *pp)
>  	 * the skip_l23_ready has been set.
>  	 */
>  	pp->skip_l23_ready = pcie->data->skip_l23;
> +
> +	return 0;
>  }
>
>  static const struct dw_pcie_host_ops eswin_pcie_host_ops = {
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index eba1b2cb30f0..9548c6568c82 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1594,11 +1594,13 @@ static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
>  		pcie->cfg->ops->host_post_init(pcie);
>  }
>
> -static void qcom_pcie_host_pme_turn_off(struct dw_pcie_rp *pp)
> +static int qcom_pcie_host_pme_turn_off(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>
>  	writel(ELBI_SYS_CTRL_PME_TURNOFF_MSG, pci->elbi_base + ELBI_SYS_CTRL);
> +
> +	return 0;
>  }
>
>  static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
> diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> index ee844ff7ed55..493b6c68b42f 100644
> --- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
> +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> @@ -77,12 +77,13 @@ static int ultrarisc_pcie_host_init(struct dw_pcie_rp *pp)
>  	return 0;
>  }
>
> -static void ultrarisc_pcie_pme_turn_off(struct dw_pcie_rp *pp)
> +static int ultrarisc_pcie_pme_turn_off(struct dw_pcie_rp *pp)
>  {
>  	/*
>  	 * DP1000 does not support sending PME_Turn_Off from the RC.
>  	 * Keep this callback empty to skip the generic MSG TLP path.
>  	 */
> +	return 0;
>  }
>
>  static const struct dw_pcie_host_ops ultrarisc_pcie_host_ops = {
> --
> 2.25.1
>
>
