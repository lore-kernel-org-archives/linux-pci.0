Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021077.outbound.protection.outlook.com [40.107.74.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BF629B78D;
	Fri, 20 Mar 2026 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774014117; cv=fail; b=SQUetjcbUw6uq43Sx4jQ3OepJSbNU3WQNtSX1fLvfERJHJJH/8JC6zVxdXfADUzgnGrwEzD7E4yNAmWj/CTnSG0ZDSCLzg6Px+5t5pVtgr5A0XacUjESbrDT2ShEJ3oI0thSEVpnq6P4cd9w+iedhPM9f+TSOkPlVDkp+zzf8j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774014117; c=relaxed/simple;
	bh=6vLJs7eFAHihXkWKv670YvhpiTR1g4hpSS08t0FZvds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EtPFY3zhPlTMXPEPxTor9uXQPMeKBw0gtlJQsTMQ0k4ZFSoQ8q0CQMB1oqk1joCdhVR+P43C80T1x9TMAIVvEttDVz8YnQjEutlfDtwoWjfKZ8/EMCv/WLRm2Y9jq2XFX1DEZHgYf6kE37C8NzzvgamK7jeHaSYQd03HBgFyQlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=e+79Gd3J; arc=fail smtp.client-ip=40.107.74.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="e+79Gd3J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1lNcvN1WeqWrVQANxKwmPaVSosYO14DkRixwCdiexh/eGG5Tl0vEbj7c6B9fJRLrRempbQsC6QoPTnEHlqknBYVctePZ4k9K2yO2FxKZI1wiAJ7SEmPwzym9eIapsSAwWTaJQNVO61xDFrm99TLVd5wWNyGqizGk5kppI8xet3zcoZqKZ84AH1WiEy0IUOFneTDgBcbo0E/B0ut/M/aPbNFBBB93wE8mmN30NqI/KYF9TpWxWn5Sz2Yaknbswzl+FO2VgCeHOyUvKkfTS9+BJnW0jKo2dvPm72NmViLrGteW8J8Deml9nbW9iScKMrRIpHJOT9gUjbrnPZ9HzAGJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UvQrr8jq9kM7qrdUoy75QpL57vwygWERqBa5ETcyU8=;
 b=wYZYzOAunCtaRvmGdVnEJ5FwzYh2miSP9V8vSp7H4SmOxgWaJqbxM6bfBn7xRHoWHekIA1ae40+uSG7sFK26cpQOqbLtORfkXDjOZ5et6ElVTq3UscWYwM+8uRyV3ZFuOICRLcgSVT6k+/xaHUor0+Lbc+sXMOtH5qtx7wftwiuw44x8OG5FenJGQYpVOPXm76URlKGHC/Kto6c3WfUlE5VgiRBjwDNMFd/hNsp2yL3YzL0IJcqwW/KoMWoC9m2H9RsGyrMWv+dM+/wX2TSbiibZgyPc85oRMUDCB8Q7rmXUcOC4jlCrbFLrkurRm6xb4yU+Z2o+P17vCMFkE1vgIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UvQrr8jq9kM7qrdUoy75QpL57vwygWERqBa5ETcyU8=;
 b=e+79Gd3JpTkzOdeaSwbBZdDw59pNfY46CSFOWgETKXxCiXqTZW6nA3JgLBV6bzvZyJdvvsNP96OjsEULwUNxyDDF3Vo+NGIb5O9XnHncg0dM6760rfvZhI12jTzdkWF4E2v4hcjEadhov4MDPfhZGAxT8nCTI8VO+dVnVOfofQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6659.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:324::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Fri, 20 Mar
 2026 13:41:51 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 13:41:51 +0000
Date: Fri, 20 Mar 2026 22:41:50 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Christian Bruel <christian.bruel@foss.st.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, fabrice.gasnier@foss.st.com, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests: pci_endpoint: Skip subrange map test if
 iATU allocation fails
Message-ID: <ve3nurb6cz2u3txcdamfztupjligsy55pm4sruolc75kzccg6l@q63brqyaphh2>
References: <20260318-skip-bar_subrange-tests-if-enospc-v1-0-f1a49534ebea@foss.st.com>
 <20260318-skip-bar_subrange-tests-if-enospc-v1-1-f1a49534ebea@foss.st.com>
 <vki7ty3z5jncmzeltk7udsbynffdld4xhcm3b2yjrgx25cfqkm@4ld66m3jbjqo>
 <abu4E-cQP7SBv1Gt@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abu4E-cQP7SBv1Gt@ryzen>
X-ClientProxiedBy: TY1PR01CA0197.jpnprd01.prod.outlook.com (2603:1096:403::27)
 To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: e7062367-6858-49b5-8478-08de86867120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	3XxdfAO8Vm8fhNJr9crRNb22c3v8Yn23ocf1eh+ZPaUJGWEzhRAhCtuMDeqOyFleppfZc32zrs1ht3DyySkOkmLn5FwnqvQbk6wMO2Lujhxwzg29EDzTY92UfMTa8vvZjPLmkiiBz6pynAh/OJ2TO5x1bSt6spy+FuDndif7jo+KCyiU+y9zLhgl4e/8puD8FmKx3csl57r3XGuLa5fytpfQPf98eaeji70SjJf1mhBJXA4f52uGbPRMENRlBx9s/Krp8tDmCRRALgnkOydVUd7swbXfV8LTzkHSVQDnIkRhPKU6vdqbJpQQFAk6r80UEOAjiumduTNYXcmY4k6oZDtEB3ZypE1iT/pGBH6QldEuY0DPYFXMXp6luF+wc/ZraVflf09PIr2Ptsl8nbfNGclChLTryru+6DsduKwsbWkC1rEzdptxZPPjyFFWvmMCr5b6/B+2apyvFvAk1fO6mgTLW4UJ+lHjyy394zZ42zFQmOhcXK6kxJpb3bJPUTc75EOX06zeu1KQejsvXP4joj+8/3gJLYKzJj+vH+tjRWrgf/z65J3w5r73n7+FMJnBI2OWkIMIWwJrbSvTrIOby9XRDX8X0vYxH7bxxHrhhWOO4DXvZCCAGHHpEjQGF2EE1ilE0IyB3HGPnmuO25vBF6pNbzPd3HpzT+DuOLpsB9V5anV5ayrHmibGFP8Ii/T5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iZUjBfLPDlQj99b1wy4db5S6FBqKGdbCb3df0u8hGLutO2opPy2thjxC2tlx?=
 =?us-ascii?Q?ibDPN2+cXC4ps4C4obtaR40KnFFpcQDx7XGTH+UkA6vug2jyxrSlxT+oZ+0j?=
 =?us-ascii?Q?ZdI7oTKiYgaAaZZVCvFUctVRCv+JwqFoIkN1O1Nm6/rxIMRb0jVYQ62IR+EO?=
 =?us-ascii?Q?PZFim7fn8sF3re5p0jmVxLMV0D3UCNjCVVbxVe7XszE1ov31rJP9hW5gf7Cd?=
 =?us-ascii?Q?Mi1KBY4pnjjHek/Mjyz9JEzPce4lqsYw4ZwLwYHho9acTTWyHS+IwxoAfLKD?=
 =?us-ascii?Q?Wu68qG/fow7ERJiCmjAiUX9mS7Csp+2ywkn7KB3yFbyE5QkOw29lc8zA2PZY?=
 =?us-ascii?Q?umH0f8cshXn43LsFrpEZyctKvpdIMcviLyPH5NkyQ2xabvPD657ImSF4Ix8w?=
 =?us-ascii?Q?7ayWbNVveHv8riefVOn2CFm70Hb7TAdXseA8ul27joHSBcST585txLbBTe/s?=
 =?us-ascii?Q?9o2ofkEk0dQxp/UCWL5qpBuNJXckH8ak9n0m8OQbmFprJYmHUf3zdG7FDc5E?=
 =?us-ascii?Q?ByiMqJseQpN0pZ1okPNKcR/WuSsXrsA+Z7DIolRuL1NgrOpcyRpPVdpHK/79?=
 =?us-ascii?Q?pT5dZ6Y1mvNJChXl9o5SjIiwizGDqX5PuPxabBeUOy7ZD4Cj4AFfs2QxwKjP?=
 =?us-ascii?Q?YKqQIslEwoCVJG/gUjxyAcCBSThDuwviIZp7lWSE1oHz5ypCktt3b9g5A2Qv?=
 =?us-ascii?Q?kfn4xj7l6skuiLnDErrifNn/HLKmHIjNqeTtbutiEjzm0kPs41J+WZ+mLZjW?=
 =?us-ascii?Q?yIs1Cugl8DGgVDcRsAYVTqUL8oKN21vDge/5H7wckQRZZy9m6AKvZhxda1HE?=
 =?us-ascii?Q?/aWXYJFprb/nqmu7F+B5UquGEW2oQcDxm8f/a2HR3JcJlCTj9bY/mgryt90W?=
 =?us-ascii?Q?1bkpGw6G8CG56/gKa3fkpInZtOb0Zjft8VG4DhnsXPHEDKVBR2LvBj1/mVHl?=
 =?us-ascii?Q?62C/KdYXYMpxFKISMC6/ArgGCNcX/Ka7lasxhLxr90eZh+lMxGUGqfL6w0BY?=
 =?us-ascii?Q?8HlamwTjSCdnD6++2Majsv84RJy3D/s6x9BZBpTLtpHypGDohskWPuOWTO2e?=
 =?us-ascii?Q?fSlnaTQeG1rUu4b2k4Ac/w9z5wdXf2lDOSiK3K+yvoAS9FlxX874dl9sOvXj?=
 =?us-ascii?Q?aqj2439mxVERr5yWhOXBjucE6VS8vZIVlbS57tAyb0G4tHPxibfv4eGJgXsv?=
 =?us-ascii?Q?zrUMR2LzOZQTeVBLESP/Dx7QutXhuJXnMkKiny5CaxNeoRxZmS3HzBj97nK8?=
 =?us-ascii?Q?muoAzLN5YWndqlp+IacRUJiMFraUb4SD5Ujs2yamdWgEIpW+H089B2PrKHZu?=
 =?us-ascii?Q?wtXbdwtsdPhIc7qtmZ8lEnb4ielhRe99PJBzodZQSHPBR0oWgzSDVV+U1lvZ?=
 =?us-ascii?Q?fiPYaAVEefqbWf4vs8w/51MHBZSoJk0/w0rIEdWaNo/TpL4r6lp8N9dcTO9J?=
 =?us-ascii?Q?HBzMQn5HR4LIxZ2LXxS0ppJeRzMb4tjUc6Y8+c/mas/XSjRpV966g/oGze/x?=
 =?us-ascii?Q?W5EAhNuKZqpDP+iigWlb/Etd6iRDOOk4hO//wz6e/caYAw//jNnTOPpLNmo/?=
 =?us-ascii?Q?ppuTOA2k3tWH+t6LWc6Rakcz34NzVKuogQUoFoN/CZCcyCPKl6nuvzZJn7Pn?=
 =?us-ascii?Q?69EyghD18cqzqnUdVXU5VEJIaTIejUGFnmSOuZSAvp1L4LFOK+ApVyM6lKVK?=
 =?us-ascii?Q?lsUetRBndlSL1zorRcjdfEsmytvliLEOWbgr7voy3cNTZQs9J7S54CU5/ddK?=
 =?us-ascii?Q?YxoqHOJEjj1PB5QU/LE3fzYJQwZzCSvXQCk9/q1X9WIdPbzY6HJn?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e7062367-6858-49b5-8478-08de86867120
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 13:41:51.5778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkJR1hzBXtzXRTpzeKaztsaPIMluFPhyDqYLbROvxuuGFt/qco6Tq0AnnEBU0iysm5NIzetkRXcCNCaS7JPO/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6659

On Thu, Mar 19, 2026 at 09:47:15AM +0100, Niklas Cassel wrote:
> On Thu, Mar 19, 2026 at 10:28:41AM +0900, Koichiro Den wrote:
> > On Wed, Mar 18, 2026 at 03:46:27PM +0100, Christian Bruel wrote:
> > > Handle -ENOSPC error. If the number of available inbound ATU entries is
> > > insufficient to map the subrange, skip the test instead of failing.
> > >
> > > Link: https://lore.kernel.org/linux-pci/20260317152707.GA85951@bhelgaas/T/#m87e4c24173097a0ea70195b71aab294ad8d6c283
> > > Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> > > ---
> > >  tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> > > index c417fb3a198b2d92c3060938c23807cc8bea5573..8ea2fda4539d11eb22b22800a7cb8bbaa99c91ba 100644
> > > --- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> > > +++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> > > @@ -88,6 +88,8 @@ TEST_F(pci_ep_bar, BAR_SUBRANGE_TEST)
> > >		SKIP(return, "Subrange map is not supported");
> > >	if (ret == -ENOBUFS)
> > >		SKIP(return, "BAR is reserved");
> > > +	if (ret == -ENOSPC)
> > > +		SKIP(return, "Not enough ATU entries to allocate subrange");
> >
> > Thank you for handling this!
> >
> > pci_endpoint_test_bar_subrange() can also return -ENOSPC locally:
> > https://github.com/torvalds/linux/blob/v7.0-rc4/drivers/misc/pci_endpoint_test.c#L538
> > While that is a different resource limit case, I think it would still be
> > reasonable to treat it as SKIP as well.
> 
> 	sub_size = bar_size / nsub;
> 	if (sub_size < sizeof(u32)) {
> 		ret = -ENOSPC;
> 		goto out_clear;
> 	}
> 
> What is this test for anyway?
> 
> If sub_size < 4 ?
>  return -ENOSPACE ?
> 
> ENOSPC seem like a weird return for this.
> 
> Wouldn't EINVAL be a better return code for this?

Thanks, good point.

It is to ensure that each subrange is large enough for 32-bit accesses.
I must have used -ENOSPC here thinking of it as "no space for subrange
mapping".

However, subranges smaller than 32-bit do not make sense for this test, and
-EINVAL seems more appropriate here as you pointed out. Also, the PCIe spec
defines the minimum Memory Space BAR size as 128 bytes, so subranges
smaller than that would not normally exist in practice, which also aligns
better with -EINVAL than -ENOSPC.

That would keep -ENOSPC reserved for actual resource limitations (i.e.
inbound regions limitation).

Best regards,
Koichiro

> 
> 
> Kind regards,
> Niklas
