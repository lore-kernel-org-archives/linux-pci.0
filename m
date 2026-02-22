Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazon11020099.outbound.protection.outlook.com [52.101.150.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3784E4C92
	for <linux-pci@vger.kernel.org>; Sun, 22 Feb 2026 00:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.150.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771721253; cv=fail; b=dFrE418GM8mjRqlr4DUKVeX+J5n1g3s9wyrr5kRMh0a8Y9aFIlhYWb6vOgRwITCk2Kcg742hOcWjjb8FZv63S//65ZnmbGbrgz4dXXSpzS24eBNLYFPsVMojya7+u9eCwNrnopNb73rYriXeTYE6zTRB+dm0DfI3kObBKm9z0Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771721253; c=relaxed/simple;
	bh=zRvh9U4ILgUlyWO8HU96GXTg0VfMEKFQZqHQBzwQIig=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=FF/BVAzJ2gtZBCQNTLx18IrmoWq5MRXi4lFcZ7lnYBmMl7cMG1LedUsIPrNa/oj/AUEKO7PcPdosvGMAuY12g3StdaFxXdUXqcembHE3em0xXEV0dqfRHvrllBm3gBk2mpWRQZ2jLcjXbfnfL/xaV8AxfvoMh/xCk2rqlObZOfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; arc=fail smtp.client-ip=52.101.150.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W302uoR9LkAhCy7u120eawyJBMj3ea+A2BtkBmppZ4uFLgeD773O1IO3bVJhaB004eVOXn4WrKWYGph/SknxRxh3oQwaLNlHhuut+ZlDf9InIDn/YGPubOIzjGlF8HTGuAybvRSuGYx4d53Iod1AzKD76Xdafnoq48TvjNMHozzVXCqF3Tk7AXlXMN7XZZ6ju3eJsS4kDuMHe+gRnAH90YGcfXWSZnwR2c4F2UI+AC2cHOg9pviA+MZdT/M5670mDa8L+l2d06nQIAe12nnHfuiqxCOn9Vk3KeATSY4UbMpsrOAZVyYeiJdUuNCdzsAtWSDSqGLco/I8D3oWRLFloQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bt2pOPvGJTdNqrDoPJxdoxsZdYdtpTKoQdyHtw7hMbk=;
 b=dGupZaPYaDBUJ2DmWWRZP1gQctD6whM960BfirLb+YU3xpA7+KWTkEy/lU5ZgO1wpYfn3marE0xmhRBQkXfDRKqvQ9ZwtZ2bojDgF+v/LtnncDQWMK8jNV6xz71wcTJhdCpv4/ovWX8y9a0aKoBMbc2NeAxUkizay0Gce9LOb2TpQ/wHBgIzSufDzfBJb3v+a/F39MFxzi7DPprPTZetCHps23XMm1TXI1KzSKw9vA936M5tyG3Hm6kijzZy/ujyIQXqyjXGjCY3H2F9UW+joAimkQ4w3q4sGWQRRDJPrPFVT8LYfQuSf7oPxyfNkB7vjo1gcdrJCgUiMyNMtO8osQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:73::13) by
 SY7P282MB5865.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:2d4::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.20; Sun, 22 Feb 2026 00:47:29 +0000
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f]) by SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f%4]) with mapi id 15.20.9632.017; Sun, 22 Feb 2026
 00:47:29 +0000
Date: Sun, 22 Feb 2026 00:47:15 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: linux-pci@vger.kernel.org
Cc: rudi@heitbaum.com, mj@ucw.cz
Subject: [PATCH 2/2 pciutils] setpci: Fix discards const from pointer target
Message-ID: <aZpSEwpJqb4IgCWh@4c9b59f0293a>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ME2PR01CA0074.ausprd01.prod.outlook.com
 (2603:10c6:201:2d::14) To SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:73::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYYP282MB0960:EE_|SY7P282MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: 5751c8f6-e81e-4cd5-cf40-08de71abf474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fCjWppwEN4Ya2ifRJ47kmbsOgk9cmZ8Sl0gYqWHmhBbXKGL6oyI8QJQCiaOB?=
 =?us-ascii?Q?H/r5fV12ywTf9mvqbmgnC/IF4O67qv95w01CDyqg4xxlK0pqz5eeISGHfe7y?=
 =?us-ascii?Q?n84mqw+f4NVu0gCs6j06r+8g0L3mta1n05Z9T4TiBONWC5aWH+CgY9KDK1jQ?=
 =?us-ascii?Q?n/lqgwXwANiNEVzHtT93tUieEudfa/oC1CaDvUYbIeqhTeDPmUtBJyHpNQvi?=
 =?us-ascii?Q?FY+Q/S0xI9/BEOcEphpjmNo5KcTTkjFMrvQ+8ARydtSIRAC3tvkK2Vvw11+/?=
 =?us-ascii?Q?JosDRh1lmR3BZ2CbuMSxjmZOi+TjtxV5ohIS8y2dKFyaK+34xPHQ9svFYCQg?=
 =?us-ascii?Q?zZq5YaiK2gFuclkxHyr4O6mUXRyautp0QUm4JSkHBoPanE+FL2WB3GDTkDiQ?=
 =?us-ascii?Q?4P99uMeUKOrl3tX/34xDrq3IsH8aHxbow/qB4HLTGS7YkR7jSId2aaoB3iUW?=
 =?us-ascii?Q?1R3rdIdYr9K9eR6SQL7BzXYMdlEsgDZij+sfi7LRatPZ+UlnnGbxINaWJmG6?=
 =?us-ascii?Q?/iX8RA4YrLXVkXqwdf4sb3UFD0svlFA0Hgfh79WymkqQVQNDg9fJz9tmWsQn?=
 =?us-ascii?Q?qx5AA4e6ud8Hnw42A4cZYEhLmKVeqKvKgo7ejbrsOayoSX5Pj3z/UzYabATJ?=
 =?us-ascii?Q?Bcj2XEii7jjWPERaUcsfl/mthGWqa5lHfUXqfXYf/8MPRuXToUKDT7MQ8Xiy?=
 =?us-ascii?Q?uBpg3WxjqwYPkviOWCXJUjZHcmf03YnlyHk2CYfCKQ5z+TvIo5Cdaon2WEPc?=
 =?us-ascii?Q?GfkbNrxDgNgHvjWKmVnU7dD0I+NCYrSs+28Y+DTVMspNkYsRwgPHaHhfQalI?=
 =?us-ascii?Q?PZFAaNTmzHA9QMtXhKjYWWL+khiODjI5mDNhmWofoAIU9CkOJeaMtbg+h26g?=
 =?us-ascii?Q?PaIWDX2SD8PXvYiR/MQhCQF8D8gv9QFHscltrVzz5iMOPEAzK1SA0EVao/Sz?=
 =?us-ascii?Q?gUG1UN27s3uJMca+4PgxOtDx9AW6ftIUADZZTx+ATbWS7q8485tqSNEop2H9?=
 =?us-ascii?Q?xMXlrJkkLoxAvlNmyg0r/CYeMlVDoc/s8UPiInaqiUPzDUo7Dut4e35TY78O?=
 =?us-ascii?Q?RokGLrrxcFMaz3WAl+TnJ1fKK5abino+1TO5unNI+zCKLcxee5eAnDmYrmwd?=
 =?us-ascii?Q?ql2GwIarY4MbYXSbBDSYUL4ezkPS7SEJOLaPDfT0Pxdc9eFZCj57clmwE5qK?=
 =?us-ascii?Q?qwf9/5mXzZxcszD90XfLpjlSF5BE15nLem1FGkyPJaSrHSZ/bS31IdziKX2F?=
 =?us-ascii?Q?1YEzk9UBRXjXGBq40gDUsxuB+N2iJARteDFPZklWelKFwnTkivBviG/Fv/Ll?=
 =?us-ascii?Q?bzOk/pYUsu2oDm0sUTFSY34XBZCnNBB472L1c2amkD2u753dVY5TDM/LrEvf?=
 =?us-ascii?Q?42XoSNtJcjXRKumOcKxdcvOuMpvUH99XfbkyGk7YEV4aZz2jR5jpzuDovf4i?=
 =?us-ascii?Q?tsvYtIsXmV+kWNZpF00J+qD0L9vmOzpocLQSzWASrFYyr4fRL/kQxSoHTunV?=
 =?us-ascii?Q?iKmM6oT4aZYk/A9GGiEVEqypmyQlO+Rc+rR3ojpjpXClnBuc/1M07YMfFA+v?=
 =?us-ascii?Q?SNO9LzlKI7b7elJrw9U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YK/51DX2Rik3LqSeW7MZQ6khV34k5kd0ksrszTpQ70Atdpq6iSKQJ7jTQ99A?=
 =?us-ascii?Q?W3xr0fjHBnPnDMRjK71/Fr3pes7XdUK95pv/A09qnoWc3tQkTL097y/FPJnE?=
 =?us-ascii?Q?Qjx/gvuy705f5RAzLkBUFgTv64ArBy8Pt2A/RFBXNfBvRipTD9inTW5Navhw?=
 =?us-ascii?Q?pM42Wd+l5ak5Pzf5lzFqIytxawR+7N5wDOKN0vnqHhAxNKNsz/GBVf2yNhUQ?=
 =?us-ascii?Q?KgcOFuQFPI97QHKrZCZHmwHYIc5yv04xqK7WTDLcUaOkAMae00f7mKotHM0M?=
 =?us-ascii?Q?HiQSwMourB9K47i7jlqlRH/kOw1T6k08OaX9cv0DyUHWml8VXvJCUJfrwVhO?=
 =?us-ascii?Q?8r6A+I3AtufTMObJDH09xvtr52qGImPPVXeLd7L9jWvuGeQ3fNz0AGP44CgQ?=
 =?us-ascii?Q?2IRGvTk3DhAwYO0WxegHSWetVcXprWQbfX7vdvXk0mBsLS9uNHsBdLQblriP?=
 =?us-ascii?Q?YP8I6ozEgm8FRmze51wyxqDpcsp6OGYnDgH3Abve80ZFN3S+tclZ00pcp3jZ?=
 =?us-ascii?Q?hudeuNoC/bAuj3LZbMPWftfjkvvyehaHYTYHuEnJ+PPq0igzbiYRe2jNReT/?=
 =?us-ascii?Q?LRynpOqLkEW0Y0hm6QlfLqBYCyafqCuTBu1rgSa9euXAvp7UL0yzD6QAc2hw?=
 =?us-ascii?Q?8jueUN41EHtwEXc6M45P6uULd6K/iSaJeaHEBKK9kAGNPcAfkopB/yRi2kOj?=
 =?us-ascii?Q?Uq8Cw1Gwa0LMlD/BYmvQqPvs+yqbvOMWho6MO3+NI2z9mCI5dm+ub9I1pQcV?=
 =?us-ascii?Q?hFAMh7+DMKDq0e6fuOkpuk2Zh6s18mSMRgHasiBqsYJPQdDcunHkygctDL2x?=
 =?us-ascii?Q?yTSzrB6FOTcf5XmofaZUoZ70qdYBu1KxHV4kiE0U3+mDbIIQDILFaZFkhDIG?=
 =?us-ascii?Q?/rwsXCUuTmZfQuUqyKXaOmfBSTVf2bE83DdcuIxQNpUBrYyxchKipCeF1gIg?=
 =?us-ascii?Q?0xVmHmrnMLdRXDBO+WIyw9afB7lbR91I9tLOfanbwIIg9QSpZzPOmUMrv39r?=
 =?us-ascii?Q?T+/LzxAYHoYKtr3diO0J7MkcqKaC0qW9YcECXTxb+oKvjfFvdedgu01lrp22?=
 =?us-ascii?Q?Gb3brL6V/PQ1h8PtASaOioBf+Z+JAzHxeG5JSH65Moi7eTNVf8GofBt4upco?=
 =?us-ascii?Q?X8LBKYu4KVg0haR/CoOiLWcMGu67MwmsRNGAmjE9+uOdPjY9eqr4kVtiG8yq?=
 =?us-ascii?Q?HcVtpEToUHzJW7W/ADxJWH69mqZKATLZNvvkTg7GBGLId8KvNOYHN+H/RZsF?=
 =?us-ascii?Q?7HOMWnBxjPWg/Jnzu2VawdQK3biP3qAMjsFwd/sTzRXz9zLtC7/hvTlqHQWq?=
 =?us-ascii?Q?fi+oZZ+clXpKoJqtgVaY29MdCqxypapmROb23RHsKgEwrttyWPKuQ/l1f+Zd?=
 =?us-ascii?Q?AFgcj3+Ctojwtv2X0lLHiFzwt0StT1jMd3cULwXzFMop7PEw+vGwq+4ThjxI?=
 =?us-ascii?Q?OAqwx1YVt2Vsg6WASc3Sfpet0IzMTkyZGRfvWB+ayLgpTUmr6Sz7Fh1UDsOl?=
 =?us-ascii?Q?6wr1dxELRsG3cCA5QYfmbPxWFeyO+TclOkYYC+flyNMaOTtQyvhIt6+9q6BZ?=
 =?us-ascii?Q?hYHB6yOsff8RemcoL7AhOm2J8yPWFRTVe1AKeM+pVYKcXumX6rivdT6czmos?=
 =?us-ascii?Q?BSu5WVF9IgpW+1+Ugn9V1B1+JGJNSk8b4vEEldTKK8IOju0G0u9jINg+jdRW?=
 =?us-ascii?Q?X1dTEm/ydFRRUnVSCIAZwM91XyoOhRj6sp0tnZ7pwU/73ydzHi0S7wDY7ms7?=
 =?us-ascii?Q?pZcuWRw27w=3D=3D?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5751c8f6-e81e-4cd5-cf40-08de71abf474
X-MS-Exchange-CrossTenant-AuthSource: SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 00:47:29.1421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QR29/llii+1cvlMIoxQPEBlQ12e2GjbeKy+5lPEvr0oJ+sTUQYXixWJ3iHMvJ5AP5R7dR9k7UpVHvhjoZP5BRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB5865

Since glibc-2.43, and for ISO C23, the function strchr that return
pointer into their input arrays now have definitions as macros that
return a pointer to a const-qualified type when the input argument is
a pointer to a const-qualified type.

The char *e is only used as a pointer to const char **opts, and only
used for comparisons, so declare *e as const to address warning.

Fixes:
    setpci.c: In function 'parse_options':
    setpci.c:513:19: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      513 |             if (e = strchr(opts, *c))
          |                   ^

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 setpci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setpci.c b/setpci.c
index 9ce2ed6..b833250 100644
--- a/setpci.c
+++ b/setpci.c
@@ -488,7 +488,7 @@ parse_options(int argc, char **argv)
     {
       char *c = argv[i++] + 1;
       char *d = c;
-      char *e;
+      const char *e;
       while (*c)
 	switch (*c)
 	  {
-- 
2.51.0

