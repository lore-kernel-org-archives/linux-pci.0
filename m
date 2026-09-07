Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021120.outbound.protection.outlook.com [52.101.125.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D534E8E1B;
	Mon,  7 Sep 2026 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788788796; cv=fail; b=ej4lvyBCyvPRSktPHXgxdogr81gGznfAkFF9YYj5CYz3IJxtqnPFNFG2VHFQyKLsJ3ijJZhHQg2Wtx/5X8jmPoOs7FLZ5eHBSxDRd8g91V+h13d/igmFnwwU29xSHWE99IyiE94UrbsQLxPz/ryPY0tKXXTe1tw9kxfAORjnV1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788788796; c=relaxed/simple;
	bh=nVFV0hrbz3W/pkc75g/YFyu1lkHy8BKdCcZ0La49YD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IokZYcNXopGdiDmXo216B5Nb0BAvMmRM8fpxpZ1Nd6tJVLHdGx6tntYMUIWfc8rIVPraFMyNivhmeHsUH9Xn1JiMfQIR44d0f7RaRm3esXZt7xYAnK5eZ98bFawHfw/djq1b28mdt8We/oqIsqsDN2qiDn4QX5CjAZrlFD0fqc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=IafWbkMj; arc=fail smtp.client-ip=52.101.125.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="IafWbkMj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLinXxdZ0F96R1tPGQASIMKUUC+aT5lDyl1I6tL2XZ3q7X8rJPm1HAUjvaIVUVieU7TP52F3RTLxT0f1kS0XR4kzUmRkDyGxLGDIrjodWNWgv3OtzqFo1Bvqz9SBBZcEwUmIMd/+dYlNUCK8nUrWOOpjDxdQIkXBjONBnYyPItwwVrrMrNB4eMnNhV6auGUkl43CrIoT9reLCtuwsxz3uXOfhTPoP5DnxatSGPwYHf+tnEJ9TeArucawaktjvu17F9tdf2L0q0y+E8kYYEkmGu6oFTSW4DsZa9zaplBO2b9+Ids2e97IAfabuJt0wpa6y6051aqJVEpiQbCUaDaFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRxDXEmPO3IMDPmV+veNbwvFK1v2f9x/Cj6j7PAbOYQ=;
 b=vlD6ie0P8PBle/cc+Hj1fygU7ckg8b2LarnYyOSrZ5+GIiB4rjIru7Ru5RiBKM4izK3/up0Yo6+dBXft8f9YgOcpdrw2AcBvVlPLu0OlU3X+Z6CNKMTPzshH4aSvzTAYvFRz9qre9k14rHqOLZgEC++iGbmoiXXzE+miA6GOCCFpe3AzHvZ9QfGTy9xOwdvDUpnumxzL0DPBU+5jk7fX1JlTIXh6D66sJfVV1OWY3UP1GK7DWAnqRfC0iagE3R0UuK1wl4a+Iu6B6urvqH/AywGQMnux8g5+DXKVACUu/0LXDGeMUrV/l+mOrjC/YymNLrYCAfPT0fDi+W+eR9+EcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRxDXEmPO3IMDPmV+veNbwvFK1v2f9x/Cj6j7PAbOYQ=;
 b=IafWbkMjfpkX6y78NqjwTyFhOzvwzymAGdPxVY0l0Vw3kSj/rBq4SlSZzCB+7l2olg9k59qiNUiXmxkY1TIakL/VwVONADGzfBCEEcUp6Nk2B6obJqL3JUyseIlFLzhk1MmehiCFo3NPKI+FXYK/6rylE1zysfcwX4lskxnSw2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6626.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:321::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 13:46:23 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 13:46:23 +0000
Date: Mon, 7 Sep 2026 22:46:22 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-pci@vger.kernel.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [RFC][PATCH] PCI: rcar-gen4: Add missing PM ops
Message-ID: <2wbqkglawux4ti5ldjodf2xszq73hwyxln6da62daj4dtc5xp2@fya75y7m54cp>
References: <20260906173234.522400-1-marek.vasut+renesas@mailbox.org>
 <CAMuHMdWLxG8xSHwTneu=xT8bxs4io7QSw7ziyPUDo6nc-zx6Qw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWLxG8xSHwTneu=xT8bxs4io7QSw7ziyPUDo6nc-zx6Qw@mail.gmail.com>
X-ClientProxiedBy: TYCPR01CA0186.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9790fc-497d-4f38-9d5d-08df0ce667e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|10070799003|366016|376014|7416014|10067099003|56012099006|4143699003|5023799004|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6zq8o06ZtNqMkDFJqb4YTXJmZMNz3pgg94o4g4sXFLNk9Q5gjjumtcLxwcF8GTKRpNf0nRGjJIdL/RT6S4gQwfzXk2haPCcfjhV01Aebz9vUzkJiwCLLY9uIiv9hZsmlLQNXaAZTbCcSHbfptDfho/P7XUci90XuX2rO4Xl8mU0KDcCgqk3+7JmHQSWsgu8zugUKMoRmFYtp7ZqsMTxUcifJ6PDil2a/qAFzalb/w1AkGXCmL1cHbbSMfK/BexicYoT6vWoiLCEta1gphuvuGWF/uBN/WcHzAWJcqmWUVf95FUDxV8EF2phjaYBsY/+N2hH8ERvULZ3CIsk+cMkxL0Z0IFDLaxrNeSLNRSYv6ZD+awSklbCORJyVMEF5xRCBoegvPeOebPFq/1ek86a98VT08d2QP2ksSgWO52TUEsZZ7v/JOQBX1ouu9Y5ET42KyrGIZW+qpOIJsug0GFi8o0X7HsQUeUXul4QMd3MXgqMznM+EE8ItnqebAKIlo06SD6xHS95/CPftZ1EwVXuwibWgr4ZNUlIzO+nvT7GbjB1nx7kvZG76uq9BUO6URmcMPQTK4/E16eARrtT6xtxexNPMnT9LdapYjxinu2b+o/Hi8b4b8L0R0wYeE2z7V1IPFp/62fINM+ObLB6O5bvnmjgeybw8zn0F/0rQ0lyGVHc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(10070799003)(366016)(376014)(7416014)(10067099003)(56012099006)(4143699003)(5023799004)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A7iy4CzxG+k3qG009xZoh5nTxhJ9FIS+tCMMSl7nC0p58OD93wrZ1Puxe8fu?=
 =?us-ascii?Q?AyV+8twOyn4ZlixzXUKFgjMYcHkq8ggfaRfKFuztKpAojMC/2ZcEn8hNKcoj?=
 =?us-ascii?Q?qniWNegapqchMIERVhZh/gmQf+1qGYs2t4ULgjp3ywj6bkAKtbLK/cKqGsWI?=
 =?us-ascii?Q?iItKhfuD+3rQns15Oa8FusRkvD5snsS6EC6bVLzmnkL8d0iTyR8cMxe5VUGH?=
 =?us-ascii?Q?/wGpMv5ZjJXzmBVbrzeB79O8mNKGckJP9t96LVgqC9rIWwl5rNf0MiPBO8WA?=
 =?us-ascii?Q?CSl+vLfA1P3God8+lYVNSDkMiOdqN9faq0INzm6j2L5FXQGCjHVXzv++d3m6?=
 =?us-ascii?Q?paJ6MMIzzjwq1dycLz9WRHwf6oLA3bMc7MRP0+DO052F/GYUyzs4kX0P6Dmg?=
 =?us-ascii?Q?WbHmidv6/Q2ApowjsVhMRIm349FuozF/M8Yck9qODEi9g2TvQ2c3yo8QaKwh?=
 =?us-ascii?Q?Mpef2DbUbjmKiNi/pZR21GVLA7C4hoMZTWD4eDt+biqOW6zRAuNEYsr8I2lg?=
 =?us-ascii?Q?r/HKwveH2F98kX8LTgom7vCQs50B0j3zZaGeeZd49AdvizJO1/q4bQUF+4yA?=
 =?us-ascii?Q?cXWcq3BbL0tEYb/mDyREzUR+h83x4hhH04rNz57aHY7k7REk6ogPN4jPdjqk?=
 =?us-ascii?Q?U8+/tvMr8Scu5jg1nAt/ww6Onz7a8EqNVO6Te+Uq3X8m98cHGYL43C1c5/hz?=
 =?us-ascii?Q?j8IIImGx+f9rl+T+T4qtjuoSPRYE96Lgn//CBx6W7pQAoCKQphql4FP4xlvH?=
 =?us-ascii?Q?nX/xTD0yBGbvuuOMuazpV3ryIhauHQazQQ/MY1RRSsOrI0M26uegQq5tWZvp?=
 =?us-ascii?Q?eQUnsw1mIe/s6JRArV9IRQJZKktkd0UFxCXdpAg8VVjQ/weq5LRGV2yUIArR?=
 =?us-ascii?Q?USFUG1f3zbIcDRjIidHcxmKeZXUZs9q/Soa+wLbA1P98rdoOHwNz53XKv2ll?=
 =?us-ascii?Q?M2SKbWUKLLXtfOgbUlBB5atccn+HuwWtpPaBVmPscINz4roQq8702wKSHkFi?=
 =?us-ascii?Q?XN2ekeiMIKg8wOvLy5YgcfbVwdPI7ZsIVmOK4KtR6FPvP/fhpE+Sfo00TkV0?=
 =?us-ascii?Q?sE24RWtB5NuDW1/v1u2hnqy3LtP/hjIN+igN9JfWPwvHvsxv4UceLwIzM9yu?=
 =?us-ascii?Q?UdMZ7n+IJDLwMZ2xXRWnSqFYkQweTZnujdRrWnXesIUGuvpYlTuQodzYnwxr?=
 =?us-ascii?Q?BN+pFPuoOEbqoo5Z+77IApm7J4yLkcd9aR04MKYGspKukcEUWOHbYX2qOjnU?=
 =?us-ascii?Q?Biz7C8oFTJrj4ypEiRNeCHfZfyhyBcvl+8VIOeVdcux1/zCpYT7yjBZmmRJr?=
 =?us-ascii?Q?+5LLhFxSoPZzbJolnn7y6i1WTZ0I23v/AZuxxgJ3xFK5+r1EXRKgRd+rNDar?=
 =?us-ascii?Q?sCzKDwIN/RhGri8YbRA5fjXTkeCaGmLA4HSapZ8EgliNf0opvO81+PQY0zav?=
 =?us-ascii?Q?8uotvgMtA7vqMxvRGLFJqim8BtmEewKPoLQJ89wpfqM0P9nhtJK207tcCod3?=
 =?us-ascii?Q?lBdae9BhFfmKxRQIEY+4EAfNRdATKam6+5F9cD3Fwz/4DVKPhpjLan7tOKjt?=
 =?us-ascii?Q?e2omBKDzxKOhEzL8O5w5jHzzKeO0L/Mn1+naag+bqY5hXKYKF/hwkTAc6khD?=
 =?us-ascii?Q?wevUJSEDlHHyoBwbxd+C03u6m3BYD1ol7IaCXuGBWhp1GI4RRIBDCKAE2zZY?=
 =?us-ascii?Q?JYWsmQ3di8X8kJn6KLJMDJfbzsqg9MPYjufp2zJaV4twlXB5YQC12axpT385?=
 =?us-ascii?Q?ZdRhLTyKWRg8+LEjNxB0a3+3qWoSJlWGR0t9PEcsD2olrpvALB2o?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9790fc-497d-4f38-9d5d-08df0ce667e3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 13:46:23.5696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXAXPd5JelyqMC8JWIGnAfdErxtMX5P8dOZg8WkvrMrvFDRUWAoT66qjQZp3EPguwZF8MFaCx34bhaHZXvnehQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6626

On Mon, Sep 07, 2026 at 12:26:42PM +0200, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Sun, 6 Sept 2026 at 19:32, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
> > The R-Car Gen4 PCIe controller is part of a power domain. On R-Car S4
> > and V4H, this is an always-on power domain which is not shut down in
> > suspend. On R-Car V4M, this is a dedicated A2PCIPHY power domain,
> > which is shut down during suspend, and the controller loses state,
> > which prevents the PCIe from working after resume.
> >
> > Fix this by adding generic suspend/resume noirq ops for the controller,
> > which tear the link down on suspend, and restart it on resume. Use the
> > same PM ops on all of R-Car Gen4 to gracefully suspend and resume the
> > PCIe link on V4H and S4 too.
> >
> > Test case which demonstrates the problem on R-Car V4M:
> > "
> > $ hexdump -vC /sys/bus/pci/devices/0000:00:00.0/config > /tmp/pre
> > $ echo s2idle > /sys/power/mem_sleep
> > $ echo platform > /sys/power/pm_test
> > $ echo mem > /sys/power/state
> > $ hexdump -vC /sys/bus/pci/devices/0000:00:00.0/config > /tmp/post
> > $ diff -Naru /tmp/pre /tmp/post
> > ...
> > -00000000  12 19 32 00 07 05 10 00  00 00 04 06 00 00 01 00
> > +00000000  12 19 32 00 07 05 10 00  00 00 00 ff 00 00 80 00
> >                                           ^^^^^
> >                                     Class 0604->00ff
> > "
> >
> > Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
> > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Thanks, the output of "lspci -v" is now the same before and after
> s2idle.
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> I don't have a setup for endpoint mode, so I could not verify or refute
> Sashiko's claim that suspend will crash in endpoint mode.

Hi Marek, Geert,

I have reproduced the NULL pointer dereference at pci->pp.ops->deinit on R-Car
S4 Spider in EP mode with CONFIG_PCIE_DW_HOST=y.

(I used next-20260904 with this patch and the following fix applied:
 "buffer: fix NULL dereference of bh->b_folio in __bh_submit()")

[  102.467803] PM: suspend entry (s2idle)
[  102.495431] Filesystems sync: 0.027 seconds
[  102.499213] Freezing user space processes
[  102.502243] Freezing user space processes completed (elapsed 0.002 seconds)
[  102.502783] OOM killer disabled.
[  102.503013] Freezing remaining freezable tasks
[  102.505171] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  102.508276] GFP mask restricted
[  102.554124] renesas_eth_sw e6880000.ethernet tsn0: Link is Down
[  102.557676] PM: suspend of devices complete after 49.149 msecs
[  102.558098] PM: start suspend of devices complete after 52.385 msecs
[  102.562380] PM: late suspend of devices complete after 3.853 msecs
[  102.564497] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
[  102.565156] Mem abort info:
[  102.565344]   ESR = 0x0000000096000004
[  102.565591]   EC = 0x25: DABT (current EL), IL = 32 bits
[  102.565938]   SET = 0, FnV = 0
[  102.566140]   EA = 0, S1PTW = 0
[  102.566347]   FSC = 0x04: level 0 translation fault
[  102.566665] Data abort info:
[  102.566856]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[  102.567212]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  102.567541]   GCS = 0, Overlay = 0, DirtyBit = 0
[  102.567842] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000487961000
[  102.568260] [0000000000000008] pgd=0000000000000000, p4d=0000000000000000
[  102.568747] Internal error: Oops: 0000000096000004 [#1]  SMP
[  102.569124] Modules linked in: sch_fq_codel
[  102.569417] CPU: 1 UID: 0 PID: 1837 Comm: bash Not tainted 7.3.0-rc1-next-20260904-ep-00002-gb46bcc4e34bb #3 PREEMPT
[  102.570107] Hardware name: Renesas Spider CPU and Breakout boards based on r8a779f0 (DT)
[  102.570632] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  102.571086] pc : dw_pcie_suspend_noirq+0x5c/0x258
[  102.571414] lr : dw_pcie_suspend_noirq+0x58/0x258
[  102.571725] sp : ffff80008504b970
[  102.571944] x29: ffff80008504b9b0 x28: 0000000000000000 x27: ffff800082baccd8
[  102.572416] x26: ffff800082cddcf8 x25: ffff800082bacce8 x24: 0000000000000000
[  102.572887] x23: ffff8000809f3b88 x22: ffff000440377310 x21: ffff800082d0f000
[  102.573358] x20: ffff000440c58410 x19: ffff000442418080 x18: 000000000000000a
[  102.573829] x17: 000000040044ffff x16: 041000f2b5503510 x15: 0000000000000000
[  102.574299] x14: ffff000444ffbda0 x13: 00000000000001e1 x12: 0000000000000000
[  102.574769] x11: 00000000000000c0 x10: 0000000000000af0 x9 : ffff8000808520cc
[  102.575240] x8 : ffff8004397b2000 x7 : 0000000000000eae x6 : 00000000050f95a1
[  102.575710] x5 : 0000000000000eaf x4 : fffffffffffff000 x3 : 0000000000000001
[  102.576180] x2 : 0000000000010000 x1 : 0000000000000000 x0 : 0000000000000000
[  102.576651] Call trace:
[  102.576818]  dw_pcie_suspend_noirq+0x5c/0x258 (P)
[  102.577133]  rcar_gen4_pcie_suspend_noirq+0x18/0x28
[  102.577457]  pm_generic_suspend_noirq+0x30/0x50
[  102.577764]  genpd_finish_suspend+0x48/0x178
[  102.578053]  genpd_suspend_noirq+0x30/0x90
[  102.578326]  dpm_run_callback+0x5c/0x2f8
[  102.578590]  device_suspend_noirq+0x74/0x260
[  102.578874]  dpm_noirq_suspend_devices+0x190/0x2a8
[  102.579192]  dpm_suspend_noirq+0x28/0xa8
[  102.579455]  suspend_devices_and_enter+0x310/0x6e8
[  102.579778]  pm_suspend+0x328/0x3f8
[  102.580012]  state_store+0x84/0x110
[  102.580247]  kobj_attr_store+0x14/0x28
[  102.580504]  sysfs_kf_write+0x80/0xa0
[  102.580758]  kernfs_fop_write_iter+0x12c/0x200
[  102.581055]  vfs_write+0x1f8/0x388
[  102.581289]  ksys_write+0x64/0x108
[  102.581517]  __arm64_sys_write+0x1c/0x38
[  102.581780]  invoke_syscall.constprop.0+0x44/0x110
[  102.582102]  el0_svc_common.constprop.0+0x3c/0xe0
[  102.582415]  do_el0_svc+0x20/0x30
[  102.582640]  el0_svc+0x34/0x1c8
[  102.582855]  el0t_64_sync_handler+0x98/0xe0
[  102.583134]  el0t_64_sync+0x170/0x178
[  102.583388] Code: b4000061 aa1303e0 d63f0020 f9404e60 (f9400401)
[  102.583793] ---[ end trace 0000000000000000 ]---
[  102.584102] Kernel panic - not syncing: Oops: Fatal exception
[  102.584479] SMP: stopping secondary CPUs
[  102.584822] Kernel Offset: disabled
[  102.585052] CPU features: 0x0,40000000,0040002a,01180a42,0800e01b
[  102.585451] Memory Limit: none
[  102.585659] Rebooting in 30 seconds..

    [drivers/pci/controller/dwc/pcie-designware-host.c]
    1225 int dw_pcie_suspend_noirq(struct dw_pcie *pci)
    1226 {
    ...
    1286         pci->pp.skip_pwrctrl_off = pme_capable;
    1287         dw_pcie_stop_link(pci);
  > 1288         if (pci->pp.ops->deinit)
    1289                 pci->pp.ops->deinit(&pci->pp);
    1290

Best regards,
Koichiro

> 
> > --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> 
> > @@ -952,10 +968,14 @@ static const struct of_device_id rcar_gen4_pcie_of_match[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, rcar_gen4_pcie_of_match);
> >
> > +DEFINE_NOIRQ_DEV_PM_OPS(rcar_gen4_pcie_pm_ops,
> > +                       rcar_gen4_pcie_suspend_noirq, rcar_gen4_pcie_resume_noirq);
> > +
> >  static struct platform_driver rcar_gen4_pcie_driver = {
> >         .driver = {
> >                 .name = "pcie-rcar-gen4",
> >                 .of_match_table = rcar_gen4_pcie_of_match,
> > +               .pm = &rcar_gen4_pcie_pm_ops,
> 
> pm_sleep_ptr(&rcar_gen4_pcie_pm_ops)
> 
> >                 .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> >         },
> >         .probe = rcar_gen4_pcie_probe,
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
