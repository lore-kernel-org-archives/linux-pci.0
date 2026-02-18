Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020108.outbound.protection.outlook.com [52.101.228.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFBB2DB7B3;
	Wed, 18 Feb 2026 03:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771385695; cv=fail; b=Mse5wFZijbTfWMsWZ6Kom2dE0jIFA4RvbkQG3xu04xDAIA9Bvy2ZyyZWeZNVO+bOC2OVDg0rHe2VQiwSvYyVe6zvkYc5oTedKBipCi1z0+Mstnk8pipONE3r+v/dRyizoQqGQsm4HRyho/vkSR67wGdq/gFXNLoQp9RrBQiUQzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771385695; c=relaxed/simple;
	bh=VUvyhC7cTMVGWnfJBw0Jm449K3wj9l76t3WUx85CevQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cm45cReludJLjKoW71OYDVpVsH9PqaJ+ZS8zgKDryI3rmykqhHOBj5fmgXp5pLWGhY1I1w8mSsYHm6uRZHBzvutsKR1LbIr4YUfzEWNp5s1XFPEkaHQ0VcXEGs+uKbKXzlHMEhFEWFpS4FqXhIHVXLZv+ygmTTRt9VxiDGbNZjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=q+K3BEc0; arc=fail smtp.client-ip=52.101.228.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="q+K3BEc0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOff00VnuAb6vwgAJ7ERwBHkKt+tILbW7xZ5RjBFRgeqLKhdIxjFHQD2w5YuiquNUF+E4JI7goqDIDlNfymVCcczuZUPq/FznaZW2uXkPr3ts92Jscu6mn7+K4FkI/jQ0ddoDRz5/wWmmZRyxM1RMQMDo9xLACNoyCqI6JnAvTe9JreixJJsa6rEwub1E/IburRs4s+WMdVwFbSw5lpj25+8AboNNrKpPYqVhCn68/SBpMLRCaU8Gl+CRNH1rQ0Q+FHGTgcbgZHQvMpn1QCwy+YizT0fCeYxG0Tb3v4xpI1uadeU3n4SJMkJiQn3mo+PFdBjTGCngAxo9pd8Poyh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3RB78lb3cDHZMh7uj5Q6B/P6EIdf58QMhIkJ8FPYO0=;
 b=uyNnomjP8Gy6qx6Zlg/SrWcLH7O/xZNfrTj3bJbNbrqmZdnvIFARWingx12y78PqyyhhzXCnldYXM8rZfHLGiu4S1Mj5vrdcX98bXxlT1Z6H3b1DA7NJKgXYQka0cjIthlF26t4xQQaozNoMbVnmqJAYOANEFOFe0jYxnRxSv8gl2t9M1E9tM59Mdo8YRqVNX4BqBr0NV6ojtMiA6xuwfwlsSItIMCJ+p4rweUhV7JwpPrGhs1n+D42GyuWyVZEyFULRaGCk32wbOSBRMqztmFfTG5kwG3KtEItmYV/Gs/8G/maUD9QcnJep8wNPYQPlxykpBk3wKDnwEYcx55TsyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3RB78lb3cDHZMh7uj5Q6B/P6EIdf58QMhIkJ8FPYO0=;
 b=q+K3BEc0fxRJu7Db5NMMGBq8z6+PJ7an92GTHESM+5gJVK/Xid8lA1ceRo3GCT2VF0kzpHP5hgVp830hSGnAqn0DKMJUlPz1bQgz1c/rMNb2eWCTDIDGq+yp6Qd0MZscTYYHi4rpxtWWW3VMiShDard8Y8/MxWs3yOgDANjmTJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4906.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 03:34:49 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 03:34:49 +0000
Date: Wed, 18 Feb 2026 12:34:47 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, heiko@sntech.de, 
	kishon@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	shawn.lin@rock-chips.com, Frank.Li@nxp.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, ntb@lists.linux.dev
Subject: Re: [PATCH v8 8/9] PCI: endpoint: pci-epf-test: Reuse pre-exposed
 doorbell targets
Message-ID: <2ltjmhbw5s6t3emem5jron6v6frmfi46k6mmooukqaviyi3ktk@wpsuu5h6fqag>
References: <20260217080601.3808847-1-den@valinux.co.jp>
 <20260217080601.3808847-9-den@valinux.co.jp>
 <aZQ_rEkzWnDeJrMe@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZQ_rEkzWnDeJrMe@ryzen>
X-ClientProxiedBy: TY4P301CA0062.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4906:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b316100-f38b-4137-65e1-08de6e9eab41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Im8pcRmYHX2Cs7qY6Mcs3OZ9UyGqOHVy6eUEUIB7RcXMQCFFFd2Jeg1dY4Sx?=
 =?us-ascii?Q?aUf7yC939KCM3DdwO27SQo2WY+1mAUuBsSJUOldtqMnRrp77AQ2zxBEhtM+H?=
 =?us-ascii?Q?1oTLK6Iv/fwy8L014DMzAFq6F5iMl98xweF1cIdE5S3V6bAQUvRGpZSCQoed?=
 =?us-ascii?Q?8IgN8X3ItkB6FyCjiVAWGqd+6zVHVzAjtFAs/Ak1WD1O+TAzpUlZFCUJ7a/F?=
 =?us-ascii?Q?KHCmI2gZAeEUQ4KLegm2HV+Ik+ByFzxmjG5Yb4qsSiTOArmq0bEPUhSUCfws?=
 =?us-ascii?Q?uv48APRgYqahsvf/TVDSZx58iRSBAaO8PYha3Sqf989gtCv9+fPl1cNRaFYC?=
 =?us-ascii?Q?ThFzax1NyShtV0BCUF0xM8jurBxGhntG8PwTBgm1qRxtqRdotpZ3Q9g9FPEQ?=
 =?us-ascii?Q?RBR+9NkmquCcDrgq3FmxxflChEyoBOScE9he93IYE8lolNgHcitCYIIT+2ZP?=
 =?us-ascii?Q?LLN0aZoR+x7JXj+eiB5TVKaPv2qL/ZQZTEr3L6cn3xpGMCGc2lyP04j/mvHR?=
 =?us-ascii?Q?bbZGW22F6cIXoWzyAuoRsafs4e5IsC1fS8U3SCBM7NZGh8ra6Ru3Ll1bD8ZO?=
 =?us-ascii?Q?3dJjvA4EIcjqZ6j3mXDhUYeBQqrVGac5sVOU4TQTvMTTjFn/kc+48uZzdYwT?=
 =?us-ascii?Q?1C2Ka3Z7xRwhgdH2JhfAOSaOvg5EfydRGI0lg8X4VhuJWnSuxnqiCcC8i/3v?=
 =?us-ascii?Q?iTtn7c19FC4u0TgWamORjzfDmOOZSqmsJe1Gx4OlI7ybdxej0gS8GO1TTKSI?=
 =?us-ascii?Q?wKm2+Cx6v0BUvum7OMAKpewlVQ8lc7yqR5C8hmiYU1BR3boSwWAIUkgq9XQE?=
 =?us-ascii?Q?avRM4sXSG4Ym+wNgI3yh4oxkbKPR7e1tO9aPJPJ877lW5awbhuQoa4XLoHwZ?=
 =?us-ascii?Q?546CyKhEuAXsAPbP9zqv9bWZuN5yoaXefRWri9M+UfyGeNWAlrdO8WtHRwGS?=
 =?us-ascii?Q?9ndu+eC5F6YK7GOWY7OspxjtqOaUuxQCz342Ouqc2t5H0bUHkhR2zllqPObC?=
 =?us-ascii?Q?aECSLoMbeuxcwH7FY6ITWgPXNtT3nAeNI51mQpRvjFWiS5xAFCwyJQZ1Ek5s?=
 =?us-ascii?Q?yTKdxMS8+0VBYwjkKV4a3lzcW0/CLbi304vJm406Ur/gYgBg607ALZc43hhx?=
 =?us-ascii?Q?/d6pw+vaANl6Jub61U0dMtb+NqFgoyPDaFJ2IRhjiqJWamo8L/jN4bP7zR4C?=
 =?us-ascii?Q?zHtPps4MCKnTq6RD3XYIHn48FZ6CLPHMSDxB0fysoOY6tSDexWiMooK5Tmkg?=
 =?us-ascii?Q?XvkdtWi//axsLuShXT1gzejlawvGJvIQ29V4Vl8WsAAuS7watPBo9thqVmSZ?=
 =?us-ascii?Q?dxCVE/1hWiOd44f3V7RQpk62UUwowkrJsq8zAMa0AoFR59fo6TUY8dcPnvgF?=
 =?us-ascii?Q?jzjB8HoguxBdOsetmIJsSq8iCeFQEy8mJYixzdqLoPUHqfXdouDm/lsYWqg8?=
 =?us-ascii?Q?sa9M0jxbCwcpsP8ZwmGGnRrZY0rMHf9/shtZyqkYJZ8grn9mH1yRsDLQztHo?=
 =?us-ascii?Q?Qv9rUYfRb0VrU0mRN/W1YsklwVl40vk76tkwAu4UuejGixQijHyIa0m2IoEz?=
 =?us-ascii?Q?BqmdeCYJJ9JozgMVbcQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c/TuMutvLwGNjampz+VSeS868M6WujkKlNMabeYLiiCHsyZet2ChteCaAY9E?=
 =?us-ascii?Q?b0V7rHp+NcXQesO+8GlV5fcn66hP2+C5oya5CNY1JdL3sjTqaK76BlyokFRm?=
 =?us-ascii?Q?L2G13oV+Fc0B5HpI8BtQOnfD/HAkfU4faOEZoa6pGuFiCukNKa5b5Kbigz3v?=
 =?us-ascii?Q?rRwvrpDIyzGYfim6EbEbYTYDpMdnGNzKiexkwc8//G9VokmaVStifqCnHGBD?=
 =?us-ascii?Q?ydmoL1erx3fh+iuL1oHYEAqsGGuA9njjeJWXFk8WDEop6tuhFUcbP5l5AKWh?=
 =?us-ascii?Q?csGFpzhDCu/eh/etsKOpwj0XI7RTY93fpjZt4sO41n+Ufg4zZ6N+mMYXNTdL?=
 =?us-ascii?Q?viKYtWPZ7zvz3RSY/h46AnQjrZwo+mKpR/6zexCbJ2pzebDYWfEL0oemBEVq?=
 =?us-ascii?Q?2TKnkekKJWznDxr4GumMRqwMrePPqqm/FQrEkEFqB0tTwIaYMmkE4zbuCF1k?=
 =?us-ascii?Q?uf9PY5fLJl+j7m2Z8pc23UWXc5DeJiLDdMEQHnCSgwriEvN9qdxAY8q+3AE0?=
 =?us-ascii?Q?OI+vZchiFQ9dmoVPFsnI0l3uMwJreT9MH+SdVjfOqAh1s/ZzBJJGVuLXuTzZ?=
 =?us-ascii?Q?k3A/T7CPAR0Ei8W1o/WCoP6pJpebu/25zyzDg+2t8sEHZQmWiGcLjMwlnZU0?=
 =?us-ascii?Q?ykrLPKwBqbm0Vy/0w1f7bhkD+Al4yEOqqwpI5Cu2MemwVBZtq7x1+9UfyzBJ?=
 =?us-ascii?Q?lcXKQ8l+qvkoXuMqKuO2IfZ3dTgBrPvIGJf30culqXK8B4NGI1vz8XmamHLE?=
 =?us-ascii?Q?WepmBBbT22ljIFqgPuP9BLmvWTrsUSZibPj3qxdBMwdQmSd/2Zm8fEeniwBP?=
 =?us-ascii?Q?MfzygMMAec8yxXFPe/PiX4OgnKB+JxPkgzQy/lh8xJ6q6tZNIy5UgS1BxTJU?=
 =?us-ascii?Q?bAwpzuoTyYnpEhZIoSrv6zsoqneFFgfYn9h3aUlBcOI9YDsvQye7XiyP7kxx?=
 =?us-ascii?Q?wqImqufWXSpZdsiQF9cVByFTLQSjUBnxqlB7KF2JfnYRacPsBCRXDYIbv2Nw?=
 =?us-ascii?Q?HCmQvxH1oEzOp2v/KnAGs75wDgQD13ibkYlsbaqygNUMJic/ZHfhoJWXcwho?=
 =?us-ascii?Q?dKYpnw2ENwfgi6bOKA/sreObpj6t89Up6ld9IqviwVz2xDeTWYibbXrYpXwj?=
 =?us-ascii?Q?nKcEeRzg4MJDvhIMt2hqjcJGZxzbjxiarrq3ZtA7P3lDRhymNFunmIo//qiP?=
 =?us-ascii?Q?EbcO7LgfcUYG5pQKQyGqaROWeA+PkoM5KU78qRVLHzEQQwtCKCyvrP17UBRc?=
 =?us-ascii?Q?HAgMYyrJ5ogL/PbsQ/5FDMhecL0svdnGDBlAo3H6Hb5KRTArFZtrrimYm+Pk?=
 =?us-ascii?Q?92EpE42VJvnOUb/Lac0yxyz4RJPWN4UILExkXS8r2DJVTMAMvDovxhcqxYHS?=
 =?us-ascii?Q?umm83TvDLNtGzuOAfPfozjqSMYO2WelLQ6jcAmmXMQLvXZ8lsL2jd4DT37r3?=
 =?us-ascii?Q?w9PPjsZU/FCiUMzGMchmCoSjLLNtI5XRanyH3RlbTlylCIfaHLe1oaF2NoCc?=
 =?us-ascii?Q?zxQtcKn1T/JlJGIEafEHCZDhoeQfVKi+gs7LwQyTkyY538wNIoUJizt1S/GA?=
 =?us-ascii?Q?o4k8DDklSnpYtEKV7GQ+OVe6aOhAu9VMmmrqmTg5+JBID9WgkWj79XwcqgPb?=
 =?us-ascii?Q?Fo6N3Ut8tTQq9nU2Oja8iGb4PYdzpShbq/uphaWqWqEp8TdzH2fwbFZlB30s?=
 =?us-ascii?Q?HD88tlpp/5TeZ4wPTv7X/pOoFvoQ0j4wKYmb1pLx+afZ5OlaPgSG9ZZoqouj?=
 =?us-ascii?Q?hvbDjBWhdGLw7iwBNRNEP6wyAni1r5r2TRHIrRX+XHub8F6wI009?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b316100-f38b-4137-65e1-08de6e9eab41
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 03:34:49.1117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZS8p5+2TstjNhGT0VimyrZK4XUVEFyot1Q8wmJszAhr69qS5f7JreCDBQLvGhOuqcnkvpyIIRetoTXvlum1rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4906

On Tue, Feb 17, 2026 at 11:15:08AM +0100, Niklas Cassel wrote:
> Hello Koichiro,
> 
> On Tue, Feb 17, 2026 at 05:06:00PM +0900, Koichiro Den wrote:
> > pci-epf-test advertises the doorbell target to the RC as a BAR number
> > and an offset, and the RC rings the doorbell with a single DWORD MMIO
> > write.
> > 
> > Some doorbell backends may report that the doorbell target is already
> > exposed via a platform-owned fixed BAR (db_msg[0].bar/offset). In that
> > case, reuse the pre-exposed window and do not reprogram the BAR with
> > pci_epc_set_bar().
> > 
> > Also honor db_msg[0].irq_flags when requesting the doorbell IRQ, and
> > only restore the original BAR mapping on disable if pci-epf-test
> > programmed it.
> > 
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> 
> (snip)
> 
> > @@ -753,22 +771,33 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
> >  	reg->doorbell_data = cpu_to_le32(msg->data);
> >  	reg->doorbell_bar = cpu_to_le32(bar);
> >  
> > -	msg = &epf->db_msg[0].msg;
> > -	ret = pci_epf_align_inbound_addr(epf, bar, ((u64)msg->address_hi << 32) | msg->address_lo,
> > -					 &epf_test->db_bar.phys_addr, &offset);
> > +	if (db->bar == NO_BAR) {
> > +		ret = pci_epf_align_inbound_addr(epf, bar,
> > +						 ((u64)msg->address_hi << 32) |
> > +						 msg->address_lo,
> > +						 &epf_test->db_bar.phys_addr,
> > +						 &offset);
> >  
> > -	if (ret)
> > -		goto err_free_irq;
> > +		if (ret)
> > +			goto err_free_irq;
> > +	}
> 
> I tried this series on Rock5b (RK3588), and was surprised to see the doorbell
> test case still failing.

Thank you very much for testing, and apologies for not being able to test on
RK3588 on my side right now.

> 
> 
> > +
> > +	if (size_add(offset, sizeof(u32)) > epf->bar[bar].size)
> > +		goto err_doorbell_cleanup;
> 
> It turns out that this check is the reason for it still failing.
> 
> You see, for a BAR that is marked as BAR_RESERVED, pci-epf-test will not
> allocate backing memory, so epf->bar[bar].size will be 0.
> 
> If I removed this check, I could get the test case to pass.
> 
> As I suggested in my previous email, perhaps this check is better suited
> in pci_epf_alloc_doorbell(). (As a DWORD alignment check inside
> pci_epf_alloc_doorbell(). pci_epf_alloc_doorbell() could itself return
> error if the doorbell is not DWORD aligned.)

Yes, and I mentioned there I would reconsider this when respinning this feature
series. For reference:
https://lore.kernel.org/linux-pci/jcjson6zedvhkpctwzfao2wfaaujtdfqsnnm3k25e2vpz2evf4@hbsegnyevisu/
I hadn't noticed the bar.size==0 possibility at that time.

I agree that this check is better placed in pci_epf_alloc_doorbell().
I'll respin accordingly.

Thanks again for the testing and review,
Koichiro

> 
> That way, you could remove this check from pci_epf_test_enable_doorbell(),
> and we don't need to care about epf->bar[bar].size.
> 
> 
> Kind regards,
> Niklas
