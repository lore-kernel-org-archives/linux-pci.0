Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021131.outbound.protection.outlook.com [40.107.74.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEDE2DA749;
	Mon, 28 Sep 2026 04:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790568414; cv=fail; b=fip5KkdFDuYdwOBNYmJDnoC+8haHF0suZP0d7xdFiW2cUP7xFxA6O4mfk90xOj83W93o9mLLxM7Ms5ghpkT1teo1bUbtyktRXeamCm5FwbA+0Ux53yw0cPFWAMNYoa/ANYL4hL/+nbxrqxSPu+DZJj+ObZx/79mvHqlNHRKdx3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790568414; c=relaxed/simple;
	bh=+ezF+2yYav6hp7Z3a5tiInHc6AruHckAg/fIdP3HC84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m3mxj7KAuVWTW1yNx9ziFhPM/UDhtM2AP/v1BK3iGV+yfijzuzw5i9Z6wd6a12zlexRSX2SI9WD2MvnACYGZpNvxgqbP+SJRxfXjqvAAfZXt+Pq8ZLM5JPw+an49yrNTH1+cmJOJ57BPJaKw02F7gsLYv2r5ZKOkSzALhluPuro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=MDLqcuHy; arc=fail smtp.client-ip=40.107.74.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="MDLqcuHy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTVsmWA9vDlSS0rZZNuYV2dMqjF3o80NDeLTsdM8aLaGOVAOcsCXKAwJFeOHI+Ay4PjPu312yccSsqC8kIIfta9XMSPxVp2GlsuUuCjUNHr0Ir1bO+3LAuQmYC6aS1s5rAnvQmjiPoTGRDh4qAqgnFerPiJCCn8fKqAwnoNdU0FbMaTVAXwcW6Sk860tB423SyqNI8G3hP9n/8exdPXTRbIzYwISvdctouBEcwysZxsazvcJa/2v7yWaJJ0WOLpm6N/emaYIluQC5fJX3h6nG75f2glYftVdYDdLcZEyk9v37Ny4ZqgeCr6SX0yv+aL+BeaV2AQn3Jg3CKcOnsBADw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WD2P7hvH/E0NZA4GHrzflrGZxhuiJXbtcAzMrukdTJU=;
 b=XCW1uHkrJy9IwiCm8HXkxnNR/Mx4lhZiIPv6qZhUI9XjLY0uaKgXGd3Bm59xgpZUnMPqTg0b3nGFaT5xeVUujyO97dqggWRHGJoqXP0ulHDjL2MzXTUVij5/lLqrnleyaKX7Tas7ZVP4SWCFXnWe1qSqa+owYmPwK7eUo6PC+PV/WAY8U2uu/BrQUv8yembbPuzdAqZqL+IJfzBsugiuY75iCQjbwRBMNLnMtMAU9ywgwMvl/gEZt50B7lhf21ZGFgChvXc1XW7df+t6vCH9ndzANGH+u3OUvRF9dsyomIyTwyX0GholXa1iXTSAysLEpOhcTTzNrIW8UjmR/HRD8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WD2P7hvH/E0NZA4GHrzflrGZxhuiJXbtcAzMrukdTJU=;
 b=MDLqcuHydl8pdSYskPmMQtFFLH/CiqzCiultZffszF6PdlS5mgeAx53EqBvHBvkym1Qt8R5B+47mMcHJFoQgWg4OcTNbb9cm9/xS4qNUT/ltR9fY5hM40SGUA+fcBpqfL25S5RGV/7Q2S5gQJwrNAKMINw2QFwciD/fEgJqRUz4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYRP286MB4480.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 04:06:48 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 04:06:47 +0000
Date: Mon, 28 Sep 2026 13:06:46 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] PCI: rcar-gen4: Recover the Root Port on link down
Message-ID: <hq4dtjhols7fawrtejjvrgp52bl2qclin6jhv2cne7xiv2hywm@zpe2pp66uhze>
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-8-den@valinux.co.jp>
 <e9a60e4a-95ac-4e49-a16d-a8eca2196d4a@mailbox.org>
 <jbekhkl7ywblowemhmm4nhzzvg6bk6vpfciaebwvxe7nitfisc@3hbnpq6uz2rw>
 <e70e5f17-35aa-429e-905f-a1990d549126@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e70e5f17-35aa-429e-905f-a1990d549126@mailbox.org>
X-ClientProxiedBy: TY6P301CA0003.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYRP286MB4480:EE_
X-MS-Office365-Filtering-Correlation-Id: a91b7a16-f88a-4779-13a4-08df1d15eaa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|10070799003|1800799024|7416014|376014|4143699003|5023799004|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	IgL7OyfyTSmKwQ1jDGzDND6Qg/Ru2HBKvdcr2bL78OoGcSIRcs9BoXNDBl5pzvyUPtCtIHA/7ufkq49tsgO5vZy7BfkvLtkvvVi/DLKT692epm0sSpGrnCoqNY/lgi4Zja6Ztsp6p+wt6yN875aAKqq52z0pD0azDfFGbr6if4tFo+PiHXNz1jZDjHDdKvmPfE8T8M+WrF7gpb5D/LigKIP1AP/BoXYnwWJdKoGEWaEXjFHa6n2LbuY1y1fpzM+NQFpxKYR2tMC8cShatDfNEOo3heyFXNHiAQAjwOnkHUpF+s43rENNsBJDLj84VBqD2gVPTxGWe1empxGjAaPTCV/QS6ER2Ot0GbLbHAtJ6YUPhErLL8dj0+jzOlYwXaHPtq+SBMDHTK2RwZ90meO6UgFmOv0lSMhZoztM53Znf+fL2g2hTJ0l2pFKbhocyUlEpckcEuWSURDg4jRwJ9+GHxfd71xGWxY1RCjkSN85IU7ainvsthng9GI71TPUl1UOptfVpFxUNOw4VkgSfezIUXy2mKE5P0mYWUyP0QxcYIpHIuD1gcisGOOQw3NwidJpjzV/z7a5hAOgcsb9WUztCEt2gVqsIVHL3j0uXuYyLiqi/e+T2K100KHHp1v4CBqkI38qmwnbKluGCIQn3zdlM6TcXYRuauSxnsnHH3wyHgc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(10070799003)(1800799024)(7416014)(376014)(4143699003)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xtfhf4r2teZkJAK51j2ztBrd9wNEoT2nQPSK1RaVWRVlMx8pjy09VBA8sMAm?=
 =?us-ascii?Q?/YKUNR1b8QVPDUh/C+hsMGoBk/Y2yZ2tB/5+T8JSKD+VfQcaL2VzmWsOMKQF?=
 =?us-ascii?Q?B3CrDS7NwMsjLaxWW4M1/KwC03IBJGhY7UA1EHtUX7+STbX26Kj+wlCrm1E+?=
 =?us-ascii?Q?cmHDBiQHR5XfagITkwKhS7gmVKYTcQvC5K/PQibR4h38CaIn/WaWOK9qsywt?=
 =?us-ascii?Q?O3gAvmpeuwd678XM9/QKMLRpmFyaDPbfSqyhv+2nWxSK+dmPEKpU590cNIwR?=
 =?us-ascii?Q?hVd0e4LGE/NGByUK+zktfnVZsII96xj/dKJ3pkqtK+Z3rmENBlqbiYKMENUJ?=
 =?us-ascii?Q?9IChxNAynp95mLVFLZdO2EcLeVOfh7uyiDBKzGMa08cBZMxOimMxuo0FYVmj?=
 =?us-ascii?Q?99O6JuxBpygIY3KJkJX7ZPfx+jeSdxGPqQKmGd+fK13ktv4+IBagtCfNSplR?=
 =?us-ascii?Q?g/+AQJ0TIRZWXI5D/rPznvvhODPtOSKGXdJM2qJu4hp7vXZilE2WM8356xje?=
 =?us-ascii?Q?wcAS13O51TkuAgE/Ab/LNrhhbQoQH8ZGowprwAY3/Vecix3ozP3E1KvsAtYv?=
 =?us-ascii?Q?LhLoPxt/7lnPB9MGjxeO1rbPfKo+/0poIV/K/vODGcDWzKSp6Ei0Dv0C13g5?=
 =?us-ascii?Q?CtHEmsajhw3/U64dWpPLACijvfH3ut3YaqZMk8gAOvjLMKiCyM/z4crAA/xg?=
 =?us-ascii?Q?2YEBeeuW2LhE5Od/AHH7HA2eDmhh2luLRbWtDfvpwKbW11J+HFqTi2iOkUVM?=
 =?us-ascii?Q?/cCraQvlOS/8fH1bdIjBvnZoDbwZKK24XyxEWRO1uKjCOY7RgziB7VYeuqGt?=
 =?us-ascii?Q?p2RkL/SOnEUxg3yUyTbd1XcjwLqk2NUf+3bMAsb4CT+/d+fxtAokM4FlBe7F?=
 =?us-ascii?Q?2H/dcnAhhYM7WZSo1yTP9aJzNOs1VQXEJN0CewW5WcsSjERdLkdrhN1XGq82?=
 =?us-ascii?Q?V66kOCuvgQN3tMQOv4CpjfgCfwXu3W0RYecbgUeJrMqiprV6eztis2odj1Ws?=
 =?us-ascii?Q?nAdQpInrPcVufZFIzdHzZkeMSV/yd+cCSr+oLnU7hrmhwbMM0NoEgW416Zvu?=
 =?us-ascii?Q?SArgFyqvCMEBlmLFmKDEzPJU3csTRJKeoiRZUFRybvLMHMzCRSVWWnKlzN66?=
 =?us-ascii?Q?7x6kgHUcfPEQcGoQ+VxkqGVny0osyRKRCVGwpZm0cN29TXsCIC00KNcyiUZS?=
 =?us-ascii?Q?BoDzJYdFo/OWHfphesnD7j3zmOEVTAWd4M4t6XZMbrdSnxobSZtPSvpGoo7A?=
 =?us-ascii?Q?SU55uVU5qamKtxCUJeVDD/3P1CvOejjPpLpcWjXJ13yycYZY/Dp2mOtb+dfA?=
 =?us-ascii?Q?aywtSXXD+OK7PhzkQ4TITELOha25QIzRJdemn/sq1jgqo55Bb0osp0kNDK/o?=
 =?us-ascii?Q?Zl8dhHwQKNhAaqDj1BDDEjwVJc3w11yV7H+ejkSCsCNtEz9PgYdHXd26EoNU?=
 =?us-ascii?Q?TTmP60PALBf42Grm1GuG2pBH6L9u2O8RzXTd5FF4Ue4QTNyNYXizymIirbgx?=
 =?us-ascii?Q?nwTLmIiHgNw9Pzzn3terPEL2sWoovbXalPy4hyN99VFOZuqkzzy+4jWomier?=
 =?us-ascii?Q?ZNIhdEnYSQNiILB8DseOTw58vC0Kk1jz20V/IFyW6Q80Q340P+t9LHEnuwZG?=
 =?us-ascii?Q?Qo26V9yATaaC8vSRizrAYMtCpYxyiJoSICVBeVVpVfE1xjO93i/qavaMYRcF?=
 =?us-ascii?Q?XmcI/ggr9ruts6BlWdcdYuJY6ODgj3VaxycUzkR6hvicZ76AbcjmyaFB8/wZ?=
 =?us-ascii?Q?MeZXtXHuAs4t6tYuicrrXoYz18C9c5P6uxW6TA/2Dq8MIhdtfjpT?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a91b7a16-f88a-4779-13a4-08df1d15eaa6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 04:06:47.9022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0+gbTMwOqGxSM1TFt1VvqLUAp853HWkzqJNl+8n42VrSMOXLAfuOaNJWTTgQ8dkK4u06ST8Oz8aU3Xln9q29Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4480

On Mon, Sep 28, 2026 at 12:37:43AM +0200, Marek Vasut wrote:
> On 9/24/26 6:15 PM, Koichiro Den wrote:
> > On Tue, Sep 22, 2026 at 11:44:02PM +0200, Marek Vasut wrote:
> > > On 9/18/26 5:20 AM, Koichiro Den wrote:
> > > > On R-Car, intreq_pcim_sub carries both the integrated MSI receiver and
> > > > the controller's reset requests (smlh_req_rst_not, link_req_rst_not), so
> > > > the generic DesignWare chained handler reads the MSI status from DBI as
> > > > soon as the link goes down. On R-Car S4 that is a hazard: DBI accesses
> > > > issued within a few hundred microseconds of an unexpected link down do
> > > > not complete and hang the host. In testing, the first Root Port config
> > > > read after powering off the link partner hung unless delayed by ~300 us.
> > > 
> > > Out of curiosity, do they trigger SError, and does the firmware (TFA)
> > > trap/fix those up in EL3?
> > 
> > I haven't confirmed whether those DBI accesses trigger an SError.
> > The BL31 on the Spider I'm using should be based on rcar-s4_v2.5 [1] from the
> > Spider BSP (as I haven't updated it). I just checked that this version also sets
> > HANDLE_EA_EL3_FIRST=1, plus plat_ea_handler() is empty. So IIUC an SError would
> > be taken to EL3
> 
> Yes.
> 
> > , and the normal path would return to the kernel without fixing
> > the underlying error.
> 
> That is correct.
> 
> R-Car Gen3 does PCIe link error fixup in TFA, it looks this way:
> 
> https://github.com/ARM-software/arm-trusted-firmware/commit/0969397f295621aa26b3d14b76dd397d22be58bf

Thanks for the info! It does look similar, so now I'm wondering about (*) below.

> 
> > And, regardless of whether it's a synchronous abort or an SError:
> > - There was no crash report (via report_unhandled_exception) on the console.

(*) I checked that CRASH_REPORTING is enabled in that version, but there might
    be a separate issue with report_unhandled_exception.

> > - Once that DBI access in the small window hangs, it never recovers,
> >    whereas adding udelay(300) before the access avoids the hang. So I
> >    doubt it's just retrying the same access after a transient synchronous
> >    abort as well (though I can't rule it out).
> 
> ( It just crossed my mind, this sounds similar to 0056d29f8c1b ("PCI:
> rcar-gen4: Assure reset occurs before DBI access") )

Yes, exactly. I'm almost ready to send v2, with an explicit mention of that
commit in the cover letter. 

A delay-based approach might be an option here, but I suspect it would involve
about the same level of complexity in the end. The reset request shares
intreq_pcim_sub with iMSI-RX, while AER arrives on another IRQ, so we'd still
need to coordinate both paths to avoid unsafe DBI access.

Best regards,
Koichiro Den

> 
> > [1] https://github.com/renesas-rcar/arm-trusted-firmware/tree/rcar-s4_v2.5
> > 
> > > 
> > > > Use the pre-MSI callback to check the APP reset status before DBI is
> > > > touched. When a reset request is latched, mask the sources, ack the
> > > > request and schedule recovery work. The work calls
> > > > pci_host_handle_link_down(), which runs the AER-style recovery and
> > > > resets the controller through reset_root_port(). If the reset fails, the
> > > > sources stay masked so nothing touches the unrecovered controller.
> > > > 
> > > > Only unmasked status bits are handled and pending latches are cleared
> > > > when re-arming, so requests recorded during probe or the reset itself do
> > > > not trigger another recovery. Teardown only disables link-down
> > > > detection: MSI delivery has to keep working while devices are removed.
> > > > 
> > > > When iMSI-RX is not used (external MSI controller or pci=nomsi), the
> > > > DesignWare core does not request intreq_pcim_sub, so request it in the
> > > > driver.
> > > 
> > > Would it make sense to request the line unconditionally, to simplify the
> > > driver(s) ?
> > 
> > Yes. The pcie-rcar-gen4 can set pp->msi_irq[0] = -ENODEV just like spear13xx,
> > dra7xx and keembay for the same reason. That also removes the need for adding
> > .pre_msi_irq addition in patch 4. Some other adjustments might be needed, but I
> > believe that is the right and clean direction. I will respin with that in mind.
> > 
> > Thanks for the review, that helps a lot!
> 
> Likewise, thank you for your help !
> 
> -- 
> Best regards,
> Marek Vasut
