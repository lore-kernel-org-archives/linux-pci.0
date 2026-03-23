Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021103.outbound.protection.outlook.com [52.101.125.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7061EFFA1;
	Mon, 23 Mar 2026 01:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774229345; cv=fail; b=OuYLywVM4L/DDvdTtfSvlX+Np2vP64oz9nocVJ/w2PAquAj8khV7B++44TNacUsVSo2SZBFCbWkwI3KlXI0SA+/osoJ/36bV9P8BfHxR5C+RwA+C759Lpk8sUxCYcxNFXGmdWfQvWgoBHDSjgyK+FEm9VwnBfIwBRq2Rau3OeRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774229345; c=relaxed/simple;
	bh=f869ZKIWKwwhcARWsohiEVKiyR0U8uSDkl3cd9WzMwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=to4y7Szp4ANMCRv9RWuXtJi/mkxA9eFL4kjMgDG0YPHfE3pwuMpX56mEQi1W8N2Y5DaptWOSDYbGQ3a70JJmaZwterednu6qKteBE2p9xOi1fBOsU9d4oEPxIzOIWMCNqE11raP5CeX0dtMuA42gFnAXTb/TTnisQoPLlaNdwKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=OURjek6I; arc=fail smtp.client-ip=52.101.125.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="OURjek6I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otqXBPSrfveuwZvU3AxgCrBfXTt3r6vXDLuU4bTuNG9qjS+Xfi0MbnpCuiVtWLG6R6IrQB2yEsB5dha53dA7HRoc75oCsOERVt73MDJ0gf9BRr3sD0S3dc/zeyUUbh1xHAeRLSIWVdObuNWHZGAk35j/+iY/1fAppqalgHiG2SblNPxKxLmG4D8P7mFFs/72Ox19G99WRp9bjGdO9aWEMTMZQwyDVk863IVQ1KV2wACl2soBZRGnxqLOpKZjOZDdrySzmlZKM4cpepB7GZ96auiag7fAGx7viHIsPI8DppN46Terk4+inYW2y9zAwrnErM9Q4iR8M9j1CgzJ+MwPtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZR4HOoGzeXX3Mhn109Lt26vG0+n88kfKlRnPx6y7/Ss=;
 b=bcBDpPSEI8GM4keqVf6v/a2OeeZJ+IuMU5HYj4PR0Zv2E60BUW78kB4BlD0ChySWepwltATw6IdWSO/v5HfsVjtCb2Jm8WZZeZXz98LQSnkGA+Yhp1iw2UZMVlFjZ/tWrfqxDi0CwITemba8joC8ErEKpI+ujPt49eYSwqFQmje93kW8gesa7qef/THgvRQaT4Kv+sdg4kY20kL1LeyIePgXduF6leVyKMXsWfgVE2ZMG2x61fgfTV6cleJtTvdlUzjFh7SAL6iYVImNXl0OuaXyuC0B/NNQywtHWCrlE2zO0DLnwKtulhN4NESO8fkw+zkc172PZ8XVMC4xkqXzwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZR4HOoGzeXX3Mhn109Lt26vG0+n88kfKlRnPx6y7/Ss=;
 b=OURjek6I2nn5jvzqzu35vLjhVQOa/ElBynMVJlrAr6ft/iWvUGKwcWx3BiJ6C/lY1LIxF8/naEYX9+4ctQhUA9OW//CDgU7Yj/yCBKQJhtyfkAxo9dkz+rp6bsA/Boyijp25bY8GInDAmmEzEjGTnKj9lE05AoILSU88zxrQSxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by OS9P286MB4011.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 01:29:00 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 01:29:00 +0000
Date: Mon, 23 Mar 2026 10:28:58 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>, 
	Frank.Li@nxp.com, kishon@kernel.org, allenbh@gmail.com, kwilczynski@kernel.org, 
	bhelgaas@google.com, jbrunet@baylibre.com, lpieralisi@kernel.org, 
	linux-pci@vger.kernel.org, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] PCI: endpoint: pci-epf-vntb: Document legacy
 MSI doorbell offset
Message-ID: <zpy7kokrwom566chj5oulejwmxkwkp4udoh3qea3j65yzb4qev@zsexhjlm7qnk>
References: <20260227084955.3184017-1-den@valinux.co.jp>
 <jne6ovpgukznu36lopk7aydv7rmcp3tl4pstn2fo46r6rt5jom@zxz27fgjom65>
 <e44ccisq4hnmy3lu3lroxc7ou6ssbr25bawbhr4tiud4pztxbw@spzprrgonwq7>
 <rnzsnp5de4qf5w7smebkmqekpuaqckltx73rj6ha3q2nrby5yp@7hsgvdzvjkp6>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rnzsnp5de4qf5w7smebkmqekpuaqckltx73rj6ha3q2nrby5yp@7hsgvdzvjkp6>
X-ClientProxiedBy: TY1PR01CA0184.jpnprd01.prod.outlook.com (2603:1096:403::14)
 To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|OS9P286MB4011:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d1c70c-47aa-4bda-6db0-08de887b8f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gcJRwIOjATdiC6GhdCkN2f5cMtzgT3MljdSUmWDJuzLMKgl26LiQgxdi9vtbto4FKUSBm3zPcaaQVTi3Hm9rYjtBadGCT6i3iVmh8F+qHvPO2fi026m/KNXGm2z/XKXVkRiP/n1FG6s8+1jsRsBk5kg7Eb4RlRMf+1JWdjGtoNtbkoxoknUkyqGNQxx4u99EJzvYfcYA9mWd4FK3vm6cz9TD0bEjm5ZmX9ROGI/pOS1WhHNJpPwxXXRbERxB+QgMoVpyby476Ft26ju90IOW03nTnOFCGcQSJ+sYjklqd63QHV82p+DPOdfhjl3MqfiI81CdxarmleMcC4ggAQvIEJJNVfG3k1gWtgb/zRGBjvcs12j3J9vp0Ttuttuu5PLaC0oSV5ZOLew7EZASwffrFw7adPcvr6U84gbOMr0pts/fnpZGotQcOhh73oVwqq0qBrmrk3tiAMQZhn49ltUef31RcVgJDRbGziZBqvy+wd8sPxmXRqObVdd2J4nI/dJPBDigztCFPEMnwORdVnNUiDhTzGOCT5KL3S8g+vc0TUWAB7c9fkcdM+7kUZ0al2wKa5WW1gIXFDFyTgRVg5KMxOGWV3dbdQ8BOg9bbjG0PR0oYr/CbLIOu40W6sNVupeBiyghlxkHgmaXO+1Gj69YGLCGJwfDaBjVgYMxWUU2mGzNI9MCXecFwrP9SBFg9gy+/BcgcyWT/jCWA41HyEVH4vpHo0XsZFpY5j4hrGBFXTI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlJTS2V4RDYvTWNibDVoYlVPYi9ZRjVpZnhNODV0M2twMlFKb1hxRHpIYnow?=
 =?utf-8?B?c1Jib2ZKZVlXUjd5ZTBwU1RWM2creENLSVY1cU05L2d0T3hNY3V3b01tLzB3?=
 =?utf-8?B?MmJwUWQ1RVdEQldpWWcxNWFMT3RHRDFNcCthaC9raC9SWlh3bUZlS2ZJak5H?=
 =?utf-8?B?RzRqOUdjL2lMbWxHa3N2MUZJMmN3ZHJuSW9QMjh1Q3BPNWVIQlZkQUtlL3VT?=
 =?utf-8?B?WWhnWHZYOGo3NGhNbXJUS1VBT2ROb0dUbGJlbiszeitieGgxM0xYcXljYTNO?=
 =?utf-8?B?OFlCVW95NmJoOEpVSFY3SjROV01YTUEyWjAwd1JWYlVOTVBiTWQyU09HMkNN?=
 =?utf-8?B?bkQ1b2JFRWZPeHF1M2xiYXdYajBoNjJVYndDTy9xYWFvMkhJRk5FT3dIRTlK?=
 =?utf-8?B?MHhrZzVoTy9rSW1pMTVMcW95dDhHZXR5d1d0Mm9obzU1bzQ2SmJNMGlmV2JR?=
 =?utf-8?B?SHRYelEwN04rWERCUzM3MFp0OGo3dHJxRWdTRGZRamtoRGN1U2ZtNUhiUWp4?=
 =?utf-8?B?Z0k4SlJMdWNuOWlVOUNUVGNTUUo2Q0tRaGlHTnJ6L0Ntai9BcDU0VjZic0Ri?=
 =?utf-8?B?R1dYazVhN21xZ29iMjFnMDlMZVlkMmNPYWw2VDZEMUZOWkhhVFhYNW1pV3lX?=
 =?utf-8?B?ZnlxREd5Znl3MnBVR3hRbnU2cFJvRG84T2hyU2twTFpBVzlVS3RITE55dnZE?=
 =?utf-8?B?b0tOVlRRVm00Vjk3eXp4bWVnNEd2WTdmajhiOHVjYjlYU2ZXS3FtRnFBUTAw?=
 =?utf-8?B?RE9INng0Y2g5SGJKNGJKVjlYREpDOWI0RXRPb0haQXFPaERTbXJCZkNIOGNj?=
 =?utf-8?B?R3BzaTR4Y1B5WWdtK2hWYTdXMEhPcVJrZkxJTXZxWld0WlhzUXBYQ0NqNmhY?=
 =?utf-8?B?dFBwM1FEL1BIN2FwUUQ1YXRjSWIwWUhaWm95R3dHTGpSeENHdUx6dFBuaHFp?=
 =?utf-8?B?b0FQdzR6aFRqZXV0YTNMM2FyRll0OW90QnFISmFtOFpTc3JrczNKNUxQU0RX?=
 =?utf-8?B?WlZ0Y0pZdXE1L0NGZzl1VlJUZ0xBbDRjOWVTOXA3cDFLdFZMVUhoNE9ENjRW?=
 =?utf-8?B?UWV3TEVZZkFFb3pzenJyZ3JPQ05XSXdKMTE3MFNzRkk4MStnWm5mZUVFRWh4?=
 =?utf-8?B?SkR5V05zVDJXbHU4TWFOdExDaFg2RkkrdEJHKy95UFdZKzFkNWdlVmNqaG5t?=
 =?utf-8?B?S2ZWUUVMZURGS1JTOXJhS0VMSHpXWXZSZXArSnFVTmc2ejhDWGRzMXB5OG12?=
 =?utf-8?B?c0NPMlQvRkZNMHYwUUFDVDlrUlBseHB2RU9DM1NScXVsbXBGdS9LUThPUVlG?=
 =?utf-8?B?cVNJWUc4ajd6dCtWYWtPWmk5YlFpc20xdTF4aWxNeW91dyt5U1RxODYzYWFw?=
 =?utf-8?B?RTNOeWJSK3h3ank3UVN2RFJLU1dEUE9DZkd3SUVJWTdCeWJhTWREc1p2dnBY?=
 =?utf-8?B?L2UxYS92UDRYM24yTFZpbDVRQlFuN1NNdzZPVWNSL3hNMVQ2bXgwSU8wNkFY?=
 =?utf-8?B?Q3M4NElFbHVxMXVPYjRtd3lydmxreGZobllBSXpNK1BxSklyK2J3SENUWkIw?=
 =?utf-8?B?ZVo2OGZPanJ1aE9vaTdqR2dZNk9FMVNBZExjZ1E2NUdMOGNjbzVGRGJ3OWJq?=
 =?utf-8?B?NURlTXZ6am5xcmswZFpUb1JjRkdqWVpuVkh5WWRLb2crUk9WRExhOTdZMGxo?=
 =?utf-8?B?ZkVDYUhRQWxnMy90R2h6TGU4S0Z2L242M3NHd1VieFRYa2hJTjVYQnlLTk93?=
 =?utf-8?B?OU1PMDFja0N4UVNrM2c3S21teEljMk92TU1zRlRmMFo4a2I4Sm5SSjNVWno2?=
 =?utf-8?B?ckZrdHRPUVJPcjUwUnBDN2lYWjFxMDNhaGNmNjBzTTEwM3lDRC84dHhxSEZv?=
 =?utf-8?B?MlVJZGNmODg1STQ1aDllUjJnVVZkb0RTd1plSmc3a0ZTUk4yVFdmQ3VLVTl5?=
 =?utf-8?B?d2Z2VTluUDFjQm9hY05uWG5RVk9ERUhieWdvb1JuMm0rOVo1L2dvMThjN3ln?=
 =?utf-8?B?QUdVYWRHcWZraG41Qk5JSkhIV1RTbU9LODJESnIxdDdaRk9WU3F1MFZ6eTg0?=
 =?utf-8?B?WkJ2Wkp4czhWaUpaY1NPeFF0RkUxSEdEWGhON0NDM1E0WTVvbGh5ZWlqVmZD?=
 =?utf-8?B?ZjloMlM1V05EdUNkMFZlWFJCTXY4UlBXTlJTZnI0UkMySjZRM1hSb0l0S3g3?=
 =?utf-8?B?MW9DNUkyM0JKeFBJMFZ2TVNRY1NSUlowaEl6SGtId0V3bGFmRmplVkc4R0dU?=
 =?utf-8?B?VUFaUVplNVZRMEQyeHFWaUNHeVIvUDg4aUNRVTErTkZBZ0hLaS9SajVid05P?=
 =?utf-8?B?QTFMU2RGYlBxeUZnSDZrQWdLWWdUdVlNMEJTeFllK01PenFrTGN5WFBtTXBj?=
 =?utf-8?Q?IplGdxt47/gEkbzYLFjcI1pHEu5iaznzYix+g?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d1c70c-47aa-4bda-6db0-08de887b8f7a
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 01:29:00.4095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xppNgZnwGMcC/fH6M9NM/BrN6qnh7FJs1/shsdI8MBBz1ZvCGK9euPTUKwZkJi7n4wPq54nlaw/HJ3znJK39DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4011

On Sat, Mar 21, 2026 at 07:08:36PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Mar 20, 2026 at 11:55:23PM +0900, Koichiro Den wrote:
> > On Fri, Feb 27, 2026 at 05:57:40PM +0900, Koichiro Den wrote:
> > > On Fri, Feb 27, 2026 at 05:49:45PM +0900, Koichiro Den wrote:
> > > > This series fixes doorbell bit/vector handling for the EPF-based NTB
> > > > pair (ntb_hw_epf <-> pci-epf-*ntb). Its primary goal is to enable safe
> > > > per-db-vector handling in the NTB core and clients (e.g. ntb_transport),
> > > > without changing the on-the-wire doorbell mapping.
> > > > 
> > > > 
> > > > Background / problem
> > > > ====================
> > > > 
> > > > ntb_hw_epf historically applies an extra offset when ringing peer
> > > > doorbells: the link event uses the first interrupt slot, and doorbells
> > > > start from the third slot (i.e. a second slot is effectively unused).
> > > > pci-epf-vntb carries the matching offset on the EP side as well.
> > > > 
> > > > As long as db_vector_count()/db_vector_mask() are not implemented, this
> > > > mismatch is mostly masked. Doorbell events are effectively treated as
> > > > "can hit any QP" and the off-by-one vector numbering does not surface
> > > > clearly.
> > > > 
> > > > However, once per-vector handling is enabled, the current state becomes
> > > > problematic:
> > > > 
> > > >   - db_valid_mask exposes bits that do not correspond to real doorbells
> > > >     (link/unused slots leak into the mask).
> > > >   - ntb_db_event() is fed with 1-based/shifted vectors, while NTB core
> > > >     expects a 0-based db_vector for doorbells.
> > > >   - On pci-epf-vntb, .peer_db_set() may be called in atomic context, but
> > > >     it directly calls pci_epc_raise_irq(), which can sleep.
> > > > 
> > > > 
> > > > Why NOT fix the root offset?
> > > > ============================
> > > > 
> > > > The natural "root" fix would be to remove the historical extra offset in
> > > > the peer_db_set() doorbell paths for ntb_hw_epf and pci-epf-vntb.
> > > > Unfortunately this would lead to interoperability issues when mixing old
> > > > and new kernel versions (old/new peers). A new side would ring a
> > > > different interrupt slot than what an old peer expects, leading to
> > > > missed or misrouted doorbells, once db_vector_count()/db_vector_mask()
> > > > are implemented.
> > > > 
> > > > Therefore this series intentionally keeps the legacy offset, and instead
> > > > fixes the surrounding pieces so the mapping is documented and handled
> > > > consistently in masks, vector numbering, and per-vector reporting.
> > > > 
> > > > 
> > > > What this series does
> > > > =====================
> > > > 
> > > > - pci-epf-vntb:
> > > > 
> > > >   - Document the legacy offset.
> > > >   - Defer MSI doorbell raises to process context to avoid sleeping in
> > > >     atomic context. This becomes relevant once multiple doorbells are
> > > >     raised concurrently at a high rate.
> > > >   - Report doorbell vectors as 0-based to ntb_db_event().
> > > >   - Fix db_valid_mask and implement db_vector_count()/db_vector_mask().
> > > > 
> > > > - ntb_hw_epf:
> > > > 
> > > >   - Document the legacy offset in ntb_epf_peer_db_set().
> > > >   - Fix db_valid_mask to cover only real doorbell bits.
> > > >   - Report 0-based db_vector to ntb_db_event() (accounting for the
> > > >     unused slot).
> > > >   - Keep db_val as a bitmask and fix db_read/db_clear semantics
> > > >     accordingly.
> > > >   - Implement db_vector_count()/db_vector_mask().
> > > > 
> > > > 
> > > > Compatibility
> > > > =============
> > > > 
> > > > By keeping the legacy offset intact, this series aims to remain
> > > > compatible across mixed kernel versions. The observable changes are
> > > > limited to correct mask/vector reporting and safer execution context
> > > > handling.
> > > > 
> > > > Patches 1-5 (PCI Endpoint) and 6-10 (NTB) are independent and can be
> > > > applied separately for each tree. I am sending them together in this
> > > > series to provide the full context and to make the cross-subsystem
> > > > compatibility constraints explicit. Ideally the whole series would be
> > > > applied in a single tree, but each subset is safe to merge on its own.
> > > > 
> > > > - Patch 1-5 can apply cleanly onto pci/endpoint latest:
> > > >   f6797680fe31 ("PCI: epf-mhi: Return 0 on success instead of positive
> > > >                  jiffies from pci_epf_mhi_edma_{read/write}")
> > > > 
> > > > - Patch 6-10 can apply cleanly onto ntb-next latest:
> > > >   7b3302c687ca ("ntb_hw_amd: Fix incorrect debug message in link disable
> > > >                  path")
> > > > 
> > > > Note: I don't have a suitable hardware to test ntb_hw_epf + pci-epf-ntb
> > > > (not vNTB) bridge scenario, but I believe no changes are needed in
> > > > pci-epf-ntb.c.
> > > > 
> > > > 
> > > > Changelog
> > > > =========
> > > > 
> > > > Changes since v1:
> > > >   - Addressed feedback from Dave (add a source code comment, introduce
> > > >     enum to eliminate magic numbers)
> > > >   - Updated source code comment in Patch 2.
> > > >   - No functional changes, so retained Reviewed-by tags by Frank and Dave.
> > > >     Thank you both for the review.
> > > 
> > > Sorry, I accidentally used an incorrect series title.
> > > The correct subject should be:
> > > 
> > >   [PATCH v2 00/10] NTB: epf: Enable per-doorbell bit handling while keeping legacy offset
> > > 
> > > For reference, v1 is:
> > > https://lore.kernel.org/linux-pci/20260224133459.1741537-1-den@valinux.co.jp/
> > > 
> > > Best regards,
> > > Koichiro
> > 
> > Hi Mani (cc: Jon, Dave),
> > 
> > This series has been sitting for a while, so I'd like to check how to proceed.
> > 
> > I'm thinking of the following approach:
> > 
> >   - get the remaining acks from the NTB side
> >     (Dave already gave Reviewed-by for Patch 6/10)
> >   - then route the whole series via the PCI EP tree
> > 
> > Does that sound reasonable?
> > 
> > If so, I can prepare a v3 rebased onto the latest pci/endpoint.
> > 
> 
> Yes please. We have queued a lot of endpoint patches for v7.1, so it makes sense
> to route this series as a whole through PCI tree.

Sounds good, I'll send the next revision (v11) with that in mind.

> 
> Also as you noted, all the NTB patches need an Ack from Dave.

I'll reach out to Dave once I send v11.

Best regards,
Koichiro

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
