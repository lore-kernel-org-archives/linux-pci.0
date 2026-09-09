Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021102.outbound.protection.outlook.com [52.101.125.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CDA282F3F;
	Wed,  9 Sep 2026 02:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788920259; cv=fail; b=XahBqAcb96oqPhXErKL6Qk85qKfRKLtJBK+NT8MQvf4txD8o6wXYKZoDcIlbYjx6+YhQtbt2IbZ+qpbgtq+KESK6zL6yX1vZieSqayTp5n3DgPrYsp5Fv07+ORIugw6gV/UyMm/jVq594D/r5EBils8tvuJTakAZhU66Oj0LvW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788920259; c=relaxed/simple;
	bh=ejE8wOq/Uki+W5D5tkiIubxIAU7U1WtidtkDHlAYAhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rn13AgCySMRsbF4UQAPux6kvxF1k3AFNLUMZqrffOS59bq/DjQWThhjfb6JWGSUFXMpbF4TbjyQQMK8bfA7uM5WHEUmOMn7w5K9D5joQWtAJRA0EUJH7JIsPRE+Ve+agJj2BJuXM94GAgHszYObFTsYlnIpAcU/UxyrP9Al0gg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=u+EiTEap; arc=fail smtp.client-ip=52.101.125.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="u+EiTEap"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPtiQ2p0NfftAiCHgFLd6L3g+0m/psqcli0X8DvG6mIV8udEXQzU/k8LvBD4c5qWwKVwAZTuSDkWLj21u9L7Bc4UVwgEHvFQLg7pzfE3zeCQj0o3MLqe7PkS+lsFnzGfAhxfOjuVWlXLlDrO3QhP8M+b1lxRGqGB7DaMQeOxKbelvdKgDf/9QHPWM9n0KtWEdjXRMtxIsjp2kzmIghmXelfn+IBLntFho89tW0rUlH1EEfcyKlQVX54OiID5cneHPKr/9+TpNvbk/Fp0OFX4NEfdJQdvtca1CkCoU5MWaE5w7jXIn5ncMa3kcN5GIZcsQ5Z36RwdFuVCHLYhPueMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6WW1LXE01sW5Bm/mpenlCWVxTtIziqtvbnq8IJ6qos=;
 b=flK0z8T/YTLa6E9gZK4E5623JEUIPeBM5wfq8IHBXmTdvrCjj5GbqsqJyZYg8vpiN3vyBeKCl83ii0iAM+9kycpnF4Z7wmFTNfJ+ythgBlfHkI+NDp4Cz9UEqnIkjJQIAfGxtLoz1rzFMhfJ6yC4drPh5I7OX5lpXLXQRJ5aOOkddAN4wJk5P7ynNNJqr2+9BBEaoWrx+/t7VF1wDFO5Pm8PRyhUKk24KiHDgMPzhdvnky/SkpOHN4s1OiH8WDyhqiINY137YpXAXbZLAN2Emmkqr0XiR2vY/bi3+AaP0pUkLk89dg+MemOnWA+KGKYaSn0FBadd9qaR+K7wltbDXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6WW1LXE01sW5Bm/mpenlCWVxTtIziqtvbnq8IJ6qos=;
 b=u+EiTEapqXzob2ppwXVcqMPXlD/uyg8QyuUpp3jl6pVCCaVVRuYHtQ964EXjox4CNbv6CN6BeVuWPV4wRYVS54kxnE3j4GRMkv55SG0wkaVVaXRCHTMnVUKitOIaUML7w2zLT02iZ4hmgUeJ1jFtyGNhlOiaG1xPQggCTKGlOJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB7735.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 02:17:34 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 02:17:34 +0000
Date: Wed, 9 Sep 2026 11:17:33 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3] PCI: rcar-gen4: Add missing PM ops
Message-ID: <ain27ypszl767h3fygurivurojxctyjy2yprada6lgjef5c623@23nn7tsrecb6>
References: <20260907163554.725127-1-marek.vasut+renesas@mailbox.org>
 <74il3j2dzfdt4xhqrfjkifhnpnmgqtplon2mtzfjzkbszwegi7@vou6a5rshcvr>
 <de8e26a0-cd05-4448-8392-0fb3953e7d3f@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de8e26a0-cd05-4448-8392-0fb3953e7d3f@mailbox.org>
X-ClientProxiedBy: TYCP286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 14ef1cd4-1aa3-473e-e5c6-08df0e1882b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|10070799003|6133799003|22082099003|18002099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	dD49igbsoMmVKzd7TU4qWQipXwfrYzsDQMg39A/U89JtP1RRro6v9qmryayelTnHMyERLVxhiefpVL4XK54nw8l4KmCQqlhFN42qj176sCDcHEob7EciohZQk6Sa0AKjxLUj5PIZvWEMf64zQGi/iP2cn0RLB9izHQgbutxt0cp0IdQrFC4DuVFCdapb3CrjLk+kQhnnOCKmc8UepNbdzcj09OH05c06J8y5O7l4JwgTiqIaOIFv5rOVYnzNN4MRLm0VYVPi8LTScIH7s/jz7ZDn/bJFmvKgeJPC3HYN7wSyc6HqFCtf+35pqMUkZff9n/Ze3YjGLzCB7dk4+GcZ5wy4zM5XC1aGI3151jI4GSUcM6LPXODJrPtImRaYOZOUfKl0gJqBrO7jJ5h8fCn5t8hM2f6dP6+O452iPSN/PusrDFvy7UmoD7qM+a6TW6SpUVtolGNq+qs3FyjcN37mBfbEbu7MWHGeGZSBfs4kld0wNFMyV4N9Jrg0cLEaHcylewdMkVpStxH0iX2RL7VNpGXWo5EoDU6MhN/UNhQhe2WVl6xfTq4JnMMAVQbKMzCkRdfUDZPWmvMsLX7x00S05Era0zoOFmY+NvR9620x4BaM0z+NFOLtlKn4s3zJr6vby68dyimdkQsmjxEBegNXcRmjxQFVYXlPwTPfTSJS1Uw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(10070799003)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tTwzH+A9B2ZZBR7A9Mt9WSpfOwlMLua1wLSVhhA/s6ThjK+ZCeOX9a7IW2F8?=
 =?us-ascii?Q?vB0VRTLHioJaRjuCaI6CcSdXnFuXrfmKhM+ulRrg7hC+HKMe85yQ1lTbi6SJ?=
 =?us-ascii?Q?PEpgNlTp7Gfte6pGNZChkpnWOWs9fMy6TUufJiweYWDtHlW2P8h+qXrv8mnK?=
 =?us-ascii?Q?kseLbsyN5Btis8AxI0PXdecZuftjdT0pT8U6NX1f8x4QqMMzAoH4mThUisW+?=
 =?us-ascii?Q?eNQsAE5F4KhWWRF0f39zcBXUd1VL5pcDmDVr6zRTwiVc+dt7kuGfokZ9UDXo?=
 =?us-ascii?Q?z3oucIRNIefY8WfnY0AljQwN2sI8vWjfFL3B06rryPsTLB9ZDRWxBgOS3OoH?=
 =?us-ascii?Q?Zv2O3ETclm++N3ZHZMKMz6RLpna/xE7FX9swBAnt0NyVqgzkU0WXQHt4BKI5?=
 =?us-ascii?Q?ACMyZqVRd8zzy+xDw+ggFLoWL5hY1KC1V4522mSVBrUlKXY/nIT1BEhGBZok?=
 =?us-ascii?Q?X8MFctjY8zhFAix8mp0V0lK3Wt1+0w6hAI1EePuUrs5BejqNzUf9TxNI6hQy?=
 =?us-ascii?Q?p5DdvgPayRHaz7/Kc0uaqRbRO03+oebCnCdyGURfkt75lChopKWSGinVFhMQ?=
 =?us-ascii?Q?EKxhyxDS2zRb59tr6wYX4CzNLUUvRaJvGUUmS9sYWbc4vit2zcrmd45a5u2i?=
 =?us-ascii?Q?byhQy+BSDxtj+hIb7Rmcj61NCz9uYZrZktslv4X+3XIQlBU/a2lODB3TLaDy?=
 =?us-ascii?Q?RXg6D3T+iT9f6VjffYIphsjgj7xIwWNZdXlJaF66jOGa5NJHm9I2ajdKcO3q?=
 =?us-ascii?Q?Q+ZZaJ3o1dmBWqcgokBPmC9c6pyyfSj7fD+TykwHNUrieRdmMOOBTkl5XlUy?=
 =?us-ascii?Q?n4MY0FIwV4TtdF8kMj+gMO1dRjjN/xE5V5ghE14AYXRPOf7Z9S4YHPu6lq/A?=
 =?us-ascii?Q?Eei+lFcxLZI9JhKmF0TTwuLNZpn1vOKtIqwFYDBQcZLy5ugDdyeJWm6gUDZq?=
 =?us-ascii?Q?NCwbD65pD2zCGBAUQTp/8N9+LR8GSh7W/dCec6uKXqGk0Z9E0iyq2LO9wDdq?=
 =?us-ascii?Q?jbc8HtT4gaNk6aqJHyAHjRNJGWJAxksWCNtX7nV8zIwZokmlDBkaTLq9SHvr?=
 =?us-ascii?Q?CZEqnzHfkta8Y5wqsFi5sGgrGf1ppUcQyvo81UTflatzQ2JTqK4e9coAoWIv?=
 =?us-ascii?Q?DeVuIo/48FwaG1gEYIwG5DRQLR4L6TjexQfLZG87RceJ1VZnaLY/Et5EYaI3?=
 =?us-ascii?Q?Gwsylqwdjzdj7uc5NWjxVSeDYxLMVZ6LW9gcq/o5OGZFhSQJKW/lNCoPzuI/?=
 =?us-ascii?Q?H59i6auReGq6w6k3QUUyhLoKloESPGm5ZjTjuAQHiL5G5ud4/p1o4+OUP1Ox?=
 =?us-ascii?Q?xO+0ICVWHeaNoUxYKLNfjwdKx7K16snan6lDnSuDe9w4Ua3khattBJEbGWEm?=
 =?us-ascii?Q?oU/ddR2pJvoEEjAr34Snz3nleCnbisrOpDJ4tnh2KYJQILrdwCy6AU+QfKFg?=
 =?us-ascii?Q?EmdpwqMye4IcpqsBHjaF9ossLQvKD3VsU6gNAGuChEp6MmhMenVfrFWqxGwY?=
 =?us-ascii?Q?PhhWdzFekpJ4k8a3uOlZpHbYccpxBlIoJiGhoq28pbcO+TYrUx3dnC/b+WNJ?=
 =?us-ascii?Q?KNUJeulFJICGeCbnp6JEVN2OYkn55TMlfIlKPQMVoxxe5nvbmHQlA/uw0+tA?=
 =?us-ascii?Q?gK0vrdRqeHNNkATaY80aHv1uH7vPl2rXmW1ykeEc3uFUOGJwThMlqZrgJE3x?=
 =?us-ascii?Q?0N4aXMjShM6dEoXJ/QDIP8q1QPfvk5d32m6+kDrWRLd+thAVZ2foJlOrSOIc?=
 =?us-ascii?Q?V7MXs3rGR0XOJakw9ugBQYNL/tLSyqH06jTubBDaNViYhrY+AuKw?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ef1cd4-1aa3-473e-e5c6-08df0e1882b0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 02:17:34.5495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Zm78nKx9M9lbalw9IquoXKIg76a8FPdkjgMKRXz0n2/Qe72wscInRtZnzZBJp8JThd/Uyf03EzTFEgNwKiCng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7735

On Tue, Sep 08, 2026 at 06:29:24PM +0200, Marek Vasut wrote:
> Hello Den-san,
> 
> On 9/8/26 3:05 AM, Koichiro Den wrote:
> > On Mon, Sep 07, 2026 at 06:35:22PM +0200, Marek Vasut wrote:
> > > The R-Car Gen4 PCIe controller is part of a power domain. On R-Car S4
> > > and V4H, this is an always-on power domain which is not shut down in
> > > suspend. On R-Car V4M, this is a dedicated A2PCIPHY power domain,
> > > which is shut down during suspend, and the controller loses state,
> > > which prevents the PCIe from working after resume.
> > > 
> > > Fix this by adding generic suspend/resume noirq ops for the controller,
> > > which tear the link down on suspend, and restart it on resume. Use the
> > > same PM ops on all of R-Car Gen4 to gracefully suspend and resume the
> > > PCIe link on V4H and S4 too.
> > > 
> > > Test case which demonstrates the problem on R-Car V4M:
> > > "
> > > $ hexdump -vC /sys/bus/pci/devices/0000:00:00.0/config > /tmp/pre
> > > $ echo s2idle > /sys/power/mem_sleep
> > > $ echo platform > /sys/power/pm_test
> > > $ echo mem > /sys/power/state
> > > $ hexdump -vC /sys/bus/pci/devices/0000:00:00.0/config > /tmp/post
> > > $ diff -Naru /tmp/pre /tmp/post
> > > ...
> > > -00000000  12 19 32 00 07 05 10 00  00 00 04 06 00 00 01 00
> > > +00000000  12 19 32 00 07 05 10 00  00 00 00 ff 00 00 80 00
> > >                                            ^^^^^
> > >                                      Class 0604->00ff
> > > "
> > > 
> > > Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > ---
> > 
> > The s2idle test with pm_test=platform now passes in EP mode on S4 Spider even
> > with CONFIG_PCIE_DW_HOST=y. Thanks! Feel free to use the tag for it if it helps.
> > 
> > Tested-by: Koichiro Den <den@valinux.co.jp>
> Thank you for your test. I would like to ask -- is the EP side of PCIe link
> behaving correctly during suspend/resume cycle on your S4 setup ? Does the
> EP require any special handling during suspend/resume ?

To be clear, what I confirmed was the following:

- The panic I observed with v1 no longer occurs with this newer revision.
- I could create a vNTB EPF after running the test.
- With vNTB/ntb_netdev already connected before the test. ping resumed normally
  afterwards.

Note: I used the suspend test from the commit message on the EP:
  echo s2idle > /sys/power/mem_sleep && \
  echo platform > /sys/power/pm_test && \
  echo mem > /sys/power/state

Based on these, I believe this patch introduces no regression in EP mode on S4.
Any pre-existing EP suspend/resume issues could be addressed separately.

Best regards,
Koichiro

> 
> Thank you for your help !
> 
> -- 
> Best regards,
> Marek Vasut
