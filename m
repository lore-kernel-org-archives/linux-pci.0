Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021077.outbound.protection.outlook.com [40.107.74.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99132DEA93;
	Thu, 15 Oct 2026 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792048687; cv=fail; b=eStBFmb22E43E0WA/l/RTTBitnTQzpuWCZm4NiogtFPiyTDzX4v4QAzYSaFPZkOnhlpVnJgT5rBdfALt+DqIH13GM3MJ9xj4W8dbfihFUOPlRNjc8fvRBBEjo8pPWn8zizfBPKTx26ygkTgr2PgAW9Hsubc3QDHfLwS9gPdVN1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792048687; c=relaxed/simple;
	bh=u6fFi/QEWUuMGB0R5xzds2ZRGCg7SooUSeZ6Ilw76sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=twRJKej0hGuvNn68uyLxKzXJxlRtQj4beYf3AIK4u2IGylsraknR7v3xiyt84axQNyUtlPnrOheNPEh2l6WfXbPz64BpF4ODGLxR5PzGbyP+3gnSKpJQoy6zIiKxmWFnb0VjvYbzhfXFRVgofG48UvoH3Zpe5URwR0CWkJCdy1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=hZ52gQBZ; arc=fail smtp.client-ip=40.107.74.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="hZ52gQBZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6/XKrEDls/Zd/f+m4Dij70jg5LXRkJOsrf2nuhFvnlIUZLk6l0kZC/3h3gMI+xpO8uTUERi6XsL/XOuz6d1OQATR96g0b5Sw9qEimDmMi69YigksgAzauo/FbnSGuF72lDG16mumoPmNchz/dtmc+rMbRYSRvgjyjaeU44fJTnJDUUIlAlQmLKA3nRoKCLhwIGNWsN8Ntr0yQq1ptByl+jnBeRgNBJMtU2J7HA3U2CeGeU+r8xytzae5XEYw25i5nNU2WuQrKnZS2i6eiYboCiPnDw7UWFUcASDB4kTGnht8FBLa1v2gI0suDX6DLa+4FLU5OjsFIbn5FhsDJfFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7qAjY5piQLTiUcTygOxzDg3EHyxHTgSmUJohxxQlR8=;
 b=SGLT4CReN4vpqjnQupgPoOKIy+z4EExYljId1rxpDP2mGcHU1JsinOMqd+nLBOMqMrsLr/mEFN6lMPCekh5YyDpIoWVnzIiRYG8MM/YzMGoqNKrIlULCb1yCYZBBM7mcRC7O6GN2OS6M2PyZxucdr/Q+1B/y1H+lU8VkSxSNC68MUy1Ny+F5VcgClZlOplqpxD2m/ox5A0I/DNE5GAHAAvYbB3LOHjKhhrL8J6zxhFCvPND1LoroV22o/G0O4lmkMgh37xu5Q8xpUHQpCTI3Xm52icT06YnV5ySYMmpeh3lLDgYl1vA94K4HvyLuKWTDbM5sGqGKrJNiOCNd8Wna8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7qAjY5piQLTiUcTygOxzDg3EHyxHTgSmUJohxxQlR8=;
 b=hZ52gQBZ3y2NJxTxdvYE7gZwMV6nCSM3BiUuETW4/0Mi9pQS7BXZ2eW8u/Q225e85k/WOv4wT4zEJDSRM0IW5ekuiSC+1wdxaPPXOmwDAojphi5D1Mph3OlsJpKwUO+3K2ZIZCUvzr4MHgJbeju0Cs+P4qv9Oobqo1BKNad6jPc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYYP286MB4692.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:19c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 07:17:51 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 07:17:50 +0000
Date: Thu, 15 Oct 2026 16:17:49 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/18] PCI: dwc: Let glue drivers hide the Root Port
 MSI capabilities
Message-ID: <bi3rvyqpdu4iq6pfyrqvx7eplyim6gmg2ijal67mpateobmtlq@gec7zewfm76r>
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-14-den@valinux.co.jp>
 <3796136c-cc01-472b-b14c-34d140a10cbf@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3796136c-cc01-472b-b14c-34d140a10cbf@rock-chips.com>
X-ClientProxiedBy: TYCP301CA0079.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::15) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYYP286MB4692:EE_
X-MS-Office365-Filtering-Correlation-Id: 09338510-91ab-4893-8531-08df2a8c6baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10070799003|7416014|6133799003|22082099003|10067099003|18002099003|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	gmfvs7wdct4vaGGjdu71Q6knbLOzPPt1saVNArK6yi8TOmp/Ed3NmsPf+Ox9Gp9NaeI4NKH46IodMYGVTXbAWlAOFRKZXWrn5PlApVIx3iff7BZiIf7ULWks4sMzcMVC1+QXAMcEpzsmAfwsWryNT1Cj7bsJDGb1JTUqUeUUJapJ/1EA9Rd6Ra0J9PSoR1RQtSbs52XUjksgirjES91n/Zfxrq6F6GLqLkZsHpxPirhWZ/GskOH8cQRAF+4AmMoypeRmzl8AVT0Foe9ey6NpAu2DILJZf1pgqZpVRFQUmsojP864q/liqaZ9K6HA8HV3OhRHg10MEvKnFwt+3KYum8cIPNG0a3adwk8q/QyR6zQ33FDYUqrFvOzkYJ0WwLaDu0s7yrpGeDdGhOr05MO+0w6y3reJOy9niEDskFn67jTXBiEJJKx9r3OZt7HE8DQFWU2c/08vmMFZdaTm9r6hHGoFvu7h7n4pFQZI37N/Qf17z3EDFlYX0BGVxHfZkay1Oaiz0A+1/n6gv1QOL+iOGsxHyJkmIg9JXjwlf7lnN1LmjfNN17m8nHG7XsGchYzJshxAf0Xra/jbwN1mT/jnvzi++Jprf/UMOzELsSIC0bkArtnlJSi0sJgZBEXIxezY/OoE2Os5RW1XkJQtGi/ydoKFds4CvSDWh39pfh7Jt8Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10070799003)(7416014)(6133799003)(22082099003)(10067099003)(18002099003)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZitMT2tsdi80RzV0bG9GTmZPK01XUUx1T3BxUmlqVk80S29uVnB4aURNaHcy?=
 =?utf-8?B?M0RZdGRmY3ArSnlUT25RQW9obytjN25WNnFGOG9mMkEzK3FhUTB5OHhDc1VM?=
 =?utf-8?B?dmo2UU9TeGNWVUpicFhQK1RtY1N1WjRHZExRWjUxNGpxUFU4UmM1cGY2d0Zz?=
 =?utf-8?B?LzRVSWRDMjlFTFFBeExyMk9UK1dLeitEa0ZsdXFXd09IYU9YREJpbVN6K21J?=
 =?utf-8?B?MVpFQjlCbEhCQkxBMFNINUJ4MWVpalJYbnJvZGcxNkxWWWE3YTV2VzZXNTRz?=
 =?utf-8?B?enZLL2RtbEJycmJ2RWVZUjZtcGh5UGdUeG5WaHJwSDBtN1NhZVNGSm85VkRC?=
 =?utf-8?B?YWJHYVdxSDhxVTQ5Smh1Y0c2YUx4d0FCVUxmWXlzZ2U1L2FZamNNclZ5NENs?=
 =?utf-8?B?Z1A0WjRrSHByT3RqaFJKOU01dE9KQkJQK000KzZsZjJ2cHI1eU1FaUpCeThh?=
 =?utf-8?B?OTE3VENiQ0M4RzcydVVIbnJVZE0rTVVNQUdEanNNQTRrelFuUjdHZVE5a01j?=
 =?utf-8?B?aEF4N24yMzBuQnltNnc5MStGc1VYOGFDcWpXY0NFWUtjdVpza1JsLzA4dEgy?=
 =?utf-8?B?ZVpWaTkvaFc2ZTlBT0JtY0h1MEl3Q0Q5SEx2NjFuRjZ6MDFZV0ZRT3lJL2o2?=
 =?utf-8?B?TkM0YkI1WlpKUUgxOGJOcXRnaG8wUHRITDA0WEFzdWVmRGpqb01lRjhTYlgx?=
 =?utf-8?B?aW5rb0xvOEZ6b21LRlR4Ymo3bEpiMEthNUsyb1JVcjgwblV1OUJ3QlN5NFBW?=
 =?utf-8?B?b2ErWlVkWnd5RmdncEdCZkdvbjFKODBGak4ydVBSODNRK054Y21rWVZqck52?=
 =?utf-8?B?RFNTV05Cd2lFRUY5aWRqRis1THcwVHlNYXgrY1dHUlNpSC9DVmppbEZIdkFu?=
 =?utf-8?B?bjhMMFpoN01CQ1p1dFhsbjlONTU1MFVvajZIN1JwNU40NVdUSjVmdE8yeXhW?=
 =?utf-8?B?Wnkzazc2RzBSdGN4UFVXdnMxdHVVc3A3NUNnSmVieXVxQjFIOFloUmxGK1Z0?=
 =?utf-8?B?K1dLbzdYSU9PS2p6UTBJMXVrdWJyOEZPSitGcjZjTHlrZUdHdHd4OG1obDNJ?=
 =?utf-8?B?dDAvbmp0QmFLM3FMaDdOUzJOaDlzWXVDUWJvaUZIZ3F5OFNUQ2RSZWJITGk3?=
 =?utf-8?B?YnpEYndBUXBFa0JLQ29oOXZtMFVpR0QyYWRMWFVPYVZZZktkSzNRdEpqR0lO?=
 =?utf-8?B?SWk0dU9JSlFRbEFSbmJoVm1CVWJnOExzbkt0dnJyMHNGY25LU1BPei9JR1FP?=
 =?utf-8?B?RTdwYmVRMTdSRUFwaU14ckxHcHBCUkhyUFFPS2NmQzhSN0RWM1BKak9HVXRE?=
 =?utf-8?B?c0ZlWmNxSEtpajFRZ05VTUdNdmRXRjJDUXpjblMyRXlHTGZyNHZFcDJrVkVY?=
 =?utf-8?B?TVlUc2lUOXFXdm1ET2V2cEVnSGkzRVFGcFJKQUdINWhydlJJd2pDb3V3ZG5E?=
 =?utf-8?B?NWRTMWtmRlhNZlJjM1JqNnFsYVBJUVBxalJoK0oxMWtCLzVwOXhyMmZoOWdW?=
 =?utf-8?B?QlVqOFBUcGFwRmROL3FVR0NrMU8zYmtkUk1zWTVJWWRqRVRvWFhkOW8yYnJ3?=
 =?utf-8?B?Sm93VW1OQWcvQUp2TWs5SmhYUnNuSWJBcG9NWDhKRkc1Mkg5ZHJRWENRZmd1?=
 =?utf-8?B?WlRoZ1RsRnc3N0pLMjIyT3dGNkhBUXh1dG5GT0gzdzlNNVJjZHBlVEViTjho?=
 =?utf-8?B?d3hTMnRYU3daOUZFMDNnS0tsakIwY0ZwZ2RhUVI1UERjelFoTlQyanhxVDJz?=
 =?utf-8?B?bzlNN2dpWFVCbmRZWmJ4M2RDNFdYT1NVUWIxdlU2TlRSQVQ2ODhka2Z3aklF?=
 =?utf-8?B?U2o4V2hxQXFsQ3BRVUFkSjVrKzZtMC9tNHFSMWRFSGZGbTZUSnJmc1lkdkhE?=
 =?utf-8?B?YTNCWG9Ib1B1QXh4dDRDZzJWaVMwcU1tTGIxK2tpUGlTa3oyZHU4WE55MUtS?=
 =?utf-8?B?UnBmNHFpakdnSEFoTFR4bW9lSHF2QU1oNWh5S1NoKzhwVFZJSmNvYmUwNU5C?=
 =?utf-8?B?aHg4WVhiNVRFeDgrbE1zSWFXV2VYWS9JYnVsVEVZUkZxUHJUMUswK25WVm81?=
 =?utf-8?B?VmE5NXpRbmlZR2p6R1BMSWpWWlloZXgyTjlicVVoMjc3MGtGU0NXZGoxZWYz?=
 =?utf-8?B?WldnSzZod2lRYW5WZUZmZHZ1QTVZWFJMQnhxSDN0eSswSVhYWHFNcXNOcmRI?=
 =?utf-8?B?aGJmRHF1aEhQdzdFTFpkanJLK3IzMHBKRWU4bnJTVTFKYUlaRFg0enp4aEZN?=
 =?utf-8?B?TkJRWmUwQ1RuczVPTHU1OW9rZlV6b21JaTBwbzR0RTVCT09SRlgrZjU0MlhJ?=
 =?utf-8?B?eG1KcTNsVWZ0T0YyMk1VWjB4eG0zL0s1c3lIeGFYS0JFdXVSeWFmUU5UZU1W?=
 =?utf-8?Q?VUP7BQaS2iHrLt/B7fuR+wC4Lx0WFpLPZhFVf?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 09338510-91ab-4893-8531-08df2a8c6baf
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 07:17:50.1353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XyK9nYm3AlICLfP3WHm3jcR1enJN/ixjBk7RDozX0wP9KMUxT8/RS4MSNeyg5izRJpyi/h8MIWekIOgotexRmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4692

On Thu, Oct 15, 2026 at 12:11:45PM +0800, Shawn Lin wrote:
> Hi Koichiro
> 
> 在 2026/10/15 星期四 11:30, Koichiro Den 写道:
> > Commit f5cd8a929c82 ("PCI: dwc: Remove MSI/MSIX capability for Root Port
> > if iMSI-RX is used as MSI controller") hides the Root Port MSI/MSI-X
> > capabilities when iMSI-RX is the MSI controller, as it cannot receive
> > the Root Port's own MSIs.
> > 
> > Some platforms cannot deliver them with an external MSI controller
> > either. The DesignWare core signals Root Port interrupts (AER, PME,
> > bandwidth, hotplug) as sideband signals on its SII interface and only
> > turns them into MSI writes with the optional SII2MSI feature. Otherwise
> > it is up to the vendor wrapper. The controller on R-Car Gen4 SoCs
> > (DWC 5.20a) appears to lack SII2MSI, and its APP block merely latches
> > the signals into status registers wired to platform IRQs, so an MSI
> > targeted at the GIC ITS is never sent.
> > 
> > Add a no_rp_msi flag so glue drivers can request the same INTx fallback
> > regardless of the MSI controller in use. It is the counterpart of
> > 'keep_rp_msi_en' from commit 3a4e8302e72f ("PCI: imx6: Keep Root Port
> > MSI capability with iMSI-RX to work around hardware bug"), which keeps
> > precedence: that one is needed for endpoint MSIs to work at all, whereas
> > hiding the capability only moves the Root Port services to INTx. The
> > removal stays in dw_pcie_setup_rc(), which also runs after a Root Port
> > reset.
> > 
> 
> With it, dw_pcie_rp will carry three flags with overlapping and
> priority-dependent semantics:
> 
>   use_imsi_rx     - the MSI controller is iMSI-RX
>   keep_rp_msi_en  - do NOT remove the RP MSI caps (i.MX6 workaround)
>   no_rp_msi       - the platform never gets the RP's own MSIs
> 
> and the resulting condition:
> 
>   if ((pp->use_imsi_rx || pp->no_rp_msi) && !pp->keep_rp_msi_en)
> 
> is getting hard to reason about. Adding no_rp_msi for a single platform
> whose controller is not even iMSI-RX makes the combination worse.
> 
> Since only R-Car Gen4 needs this, and it has its own host init, would it
> be fine for the glue driver to call dw_pcie_remove_capability()
> directly? I'd like to avoid growing the shared struct if a local
> solution is possible.

That makes sense. Let me respin and add dw_pcie_remove_capability() calls
to pcie-rcar-gen4.c's host_setup(), with a short comment.
Then I'll drop this patch ([PATCH v4 13/18]).

Thanks for the review!

Best regards,
Koichiro Den

> 
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes since v3:
> >    - No changes.
> > 
> >   drivers/pci/controller/dwc/pcie-designware-host.c | 6 ++++--
> >   drivers/pci/controller/dwc/pcie-designware.h      | 1 +
> >   2 files changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 774e1936d999..32e179603cf4 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -1191,9 +1191,11 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> >   	 * The iMSI-RX module does not support receiving MSI or MSI-X generated
> >   	 * by the Root Port. If iMSI-RX is used as the MSI controller, remove
> >   	 * the MSI and MSI-X capabilities of the Root Port to allow the drivers
> > -	 * to fall back to INTx instead.
> > +	 * to fall back to INTx instead. Glue drivers set no_rp_msi when the
> > +	 * platform never delivers the Root Port's own MSIs, whatever the MSI
> > +	 * controller in use.
> >   	 */
> > -	if (pp->use_imsi_rx && !pp->keep_rp_msi_en) {
> > +	if ((pp->use_imsi_rx || pp->no_rp_msi) && !pp->keep_rp_msi_en) {
> >   		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSI);
> >   		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSIX);
> >   	}
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 2ce61709b58c..d94116402b74 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -445,6 +445,7 @@ struct dw_pcie_host_ops {
> >   struct dw_pcie_rp {
> >   	bool			use_imsi_rx:1;
> >   	bool			keep_rp_msi_en:1;
> > +	bool			no_rp_msi:1;
> >   	bool			cfg0_io_shared:1;
> >   	u64			cfg0_base;
> >   	void __iomem		*va_cfg0_base;
> 
