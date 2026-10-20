Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.99
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792478812;
	b=n5G3KWh7ay48vxpXT4uZkcbKZGmUn7/tVYgZRXQKipsLxwZAZfjb3rxgwU3Iz4h2FyV7
	 DYUDdewGtPniSlukL3vF2huT+O5DMQ7aNiwwD/MDPMUA3VXxpM2A/uHAYEz0qSCz0gnj8
	 +AaK1+UR7NO/FxpnLX1umad2H/ol9T6O7yMeCNB2vDcZ5qo5i838Z0XdgLBuMrDtrLom1
	 MItMp6d2b8YiKLAf7gR4PLao7aFHj9IBH4UwlmuhXLhkNrPvYW8rkAqwb/VMhYwDUHt8z
	 bDiiRZ9GS6/ewtvV9AOGNSQv/ZwIP8S3GdvyXovL8ccjZXmCPiiKI4SI+jldHl05N1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478812;
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
	bh=zS6ECR26+hfzrm9bIQPlHiWKsmXMuO3e3fEkGVYx0Qc=;
	b=SEguE9IaaMu2tFNTTOI7YggNNj80bRxWxz6DZskRUd2HTj9NtnoBStzGFXbl+wpE7wch
	 9tEoYqNPw9nEC8OwrzUSvha9hpVo9Zvgzr1Fp49eJItPqck+Z16V66V+TujVZC4yG8Snu
	 NFYEsUbtQ0lYthWz6nWrrVkdtuNXjcnqLQvnCOi8Gc3WUSJtZlCgShkMmnILcIQV4sQ5g
	 lPjmrhthSml1BV3QuFQzBhIdexhmN0SXPI3Srps2Sz6+24zrL4KKDazbPOmMhIut4X+Dw
	 BRUxSkwYQ0QKAenUanfcXoz1saWYatgdjoAletDB5hRaoGgg30vQym5YTLEbu5ptjyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.99
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021099.outbound.protection.outlook.com [40.107.74.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BFA606A339;
	Tue, 20 Oct 2026 06:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4BFA606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3MxgTj/5abxniybctB9JfKYnqMvEY4f2zF1K7fw4hd/UvonPUQBeCnvteMusF5YG7DYIhhS/O2ZYtJFcZunGthdC3aSmILLum/aIJ336nBog1qJgptFKapzzH/n5E633tOL9w1HHJyAwStIpgSKso36z7KHVrS5cNMpag83rYtJ2ztJ/Dc34uVIdQ0jf2QyvuiU78RBb4Vi1N6ow+SqWN7A87GYeI8ONo64cKmVJXXtT9ZO3Z2RSVqHej10H+HOkSfk8PgB0EqutJ+5dda2ifb62Ko+e74bVpET+uI/Pc6ezjD8Wxe1NWVDY+IHPgI24+Fx9yqCmJWiPAkKa8aHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zS6ECR26+hfzrm9bIQPlHiWKsmXMuO3e3fEkGVYx0Qc=;
 b=SZKiSOLESoeK6IAIeyfMobTX67fUuwMDggkSwIHyuWgCRLTLtzXTde4CkomXt/ZKzPzh5zpRGq1nmM2NuuicZeRx7Pmq/6NIMjmdI06MEHFyKBXz+xx+WdjVB4+T6NIKhbJbMKG87js6OOUtv4RVhcKb8NpPbdwzTF+AAN0pDaucpFfk0FeHHfv16zlEBs6I8Nd2+90JM3Qqqi8KfBym7gV0ZXuXq1ws3AQ98LL6son1DEJMV2Akw2PIvHkyU5jqUzgUKtS3sybkL2nMmAeRzWkEzf7HTOkLWABOyXkKCbwbjRPcvd/XC+nf7/q4lPya5FwPakO8sIWezBJpMozbww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zS6ECR26+hfzrm9bIQPlHiWKsmXMuO3e3fEkGVYx0Qc=;
 b=LtajqvkyAITEYdrUw9RPWqOht0l/B8BS56V28fdiy64zZdYu7OC2Sal8OubsOUayR/1DYCQrC6oiCYzdJlmcSMwpACrf2zHMuu4YzCa3sZ5dK1HB/YXCdp3cY+MhBEW8yK9fVstUwcSN5GDXvZudpyYDJJaEn7au26Wzk3pGZvw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS7P286MB7050.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:430::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 06:46:43 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 06:46:43 +0000
Date: Tue, 20 Oct 2026 15:46:42 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>, 
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v5 6/7] NTB: ntb_hw_epf: Discover vNTB-embedded DMA
Message-ID: <z2uxb3c3wcww6h42zq3732uk54hn4ah7qd2y6vbldgakzd25bp@7cuw7mxfatla>
References: <20261009045949.1109871-1-den@valinux.co.jp>
 <20261009045949.1109871-7-den@valinux.co.jp>
 <as09Xp_EMjPDdk4x@SMW015318>
 <vnae5ngbbkomapwx44zqszdwcx67kv7qpxuzrs6o67uo5qphs4@hxfu6p6ewgt4>
 <as5F0EQB3owMYmFV@SMW015318>
 <alflcktvzkvnoy2kbwtpfsf44vfadqoafmy7jr2ugqssxabitf@oclzw5moz2xm>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alflcktvzkvnoy2kbwtpfsf44vfadqoafmy7jr2ugqssxabitf@oclzw5moz2xm>
X-ClientProxiedBy: TY6P301CA0026.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::13) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS7P286MB7050:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f8ad9e-5d3e-477f-efaa-08df2e75e6f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|376014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|10067099003|5023799004|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Z9ttRlLQQG4Iy2bue3rXw0R8wmCNmh3KQcJ+AR+dG3TqXPGyiYLgaRiaoTxackzap2f4ViUj9fo0KfT6r9VxMoandJKT886CQfjZ0HYNsUpH1xnJesOkfcyQitk/oaYWi1MAa98eEFANLUguKyduADnFv/nPXLakNyOWXok75zGroGamiVui+JMKA0LpFNFuFfzBjD8STaVR8vTv/k00o23xSrSEEhyYqHg3YkhbIdjfj0vlh8tOmIJvxYyD0TIDTm/8YzYXqT5DmzzW52AJqZVXvdEHCVTM3one0MgwJWQuojb3YIGeFJT1ddIsj7LZlAe6W1AdrpDqaGguovB5hsHHAjwt3JZjaASChwMCSsFYDOKUMGKYooXMcNKOdBVuHEMJQ4VJ4WUaMV0wsofP+VzeDntwxHU5ubwGhRYwkpAljVMDn0/63gUFv1unlep4vrTZ2yB0fJ7CA+Myh0eVOwISulqfCkLzve8vr+gK5SdX5cQktPTmuc6oC8EoRs5wvu61ru5OqQVs4gjNoDYMAYf/FLXJPyVlVnkC62fYk4IwVnmNON6ASpuWA8LVOPMP1JqdFa8wVIzlqMUYcgvKXhAkT2YpqmOYE7KZGliXYimZbP8kZZCr++D9NhDF/Aze
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(376014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(5023799004)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?avp3R9+mVS7lgB78qOZuA/T8fhpP+rTS/msh0EjGtK5L/OwBb1VUOT8p0kAr?=
 =?us-ascii?Q?NqdPPch2ZNquMp2ZfFr5zre6fKfSJHTE74LM3CFeVdPFZBRW/PfQAzg4FoUJ?=
 =?us-ascii?Q?bLnLBxKmF0DjAxnw833cGUUqsniMa5j35QssEUu+Gy5bQZB9pi1hRvmZ0OWT?=
 =?us-ascii?Q?dWfDnJD6dN2G/xi4FMMzmFB9UZR0QXuVo1+ZcrizmM3wuMPaWfJcVDBLFSbV?=
 =?us-ascii?Q?ko/WCEXtkL6RR/KXrB7lmLTyZN5U9tUTKoWReXXxgYo6NnVrbdhYTRPnnxq8?=
 =?us-ascii?Q?ljZQvj6vqqNE/8OKCNJd6Ehu1d2EcteKXZXe9pE9DiwQKgK/gkgpZNl/jdrF?=
 =?us-ascii?Q?J+IoWO5Ujvye9OJhRTFb9K5rXw6rQs/aOjpoIAJbeE6fdyJVmSABXCrLbJSw?=
 =?us-ascii?Q?PZCTIpDfPnckd+m4YOYH8S5XFK4wIpI2Eih29qhAbUV0CTPjwCzbgo9GhO55?=
 =?us-ascii?Q?20v+GW/9SG2L89U/vbEkGRSIj3D0+xN0yKuii9MfA0CCM965JKV2Wd+6V7XC?=
 =?us-ascii?Q?GzE8WyO+m1rD9S2tgHU4douqaZyobbriMQFOqF0faMjE37y9IWxMNzXN6uZ7?=
 =?us-ascii?Q?3NdlSstv6uOW2UbxohMpc7FruxmQ2oD4auqqV4DVJstXKkFkhGFKYfqfaHVn?=
 =?us-ascii?Q?5E3KoQePFj3h1MF3qH/arPGRrm9XrZYHIZpzaJrw29iHmAo0ETf6e1mtvEtf?=
 =?us-ascii?Q?cNHF6oC71ZVV8r/Ha4PVcDJu61tt0Fl3V2GClyEdlHIhw1aBXuiF0PuhZ/x4?=
 =?us-ascii?Q?z4TJ+htA8pWB5DoTdHxAupV7yIievcVHwyZ6eBYNXHHfa4j3bH3445ifaLr/?=
 =?us-ascii?Q?oHiTBkslPTVL8xGxyXbB0NMfhIS2qqprCvah8VPc48dl6jqkW03wtPQmivyD?=
 =?us-ascii?Q?Koj4UBvOtKh5hIdhM/evWm3ASb+QLTvICBMviSkGqpzoq1JmPTkqFoLpSNnd?=
 =?us-ascii?Q?+T1vp8NmeWUsha/ef1JEiaO23DJo4uXcB+MRBL6Q5f2fR9HncFAKBC7J26hS?=
 =?us-ascii?Q?oMbHmil35qMFdPixA7vXE+qeErUzLg02/5hm1L+gWBVdvI+Y+S39rasotskb?=
 =?us-ascii?Q?0XmcBWExfYtvQLhHyUaoNh8amxuK45joCKG2MWM3Os44TNckoQYvQTURwHIQ?=
 =?us-ascii?Q?BUyovQMHaEivrSmeD6aUgib4CFYmD22UCNSS9+m7J87xlIBUOB9qAnHd+z95?=
 =?us-ascii?Q?fe758WgEaYu8GNr31g+C6iVxa1lycEOzOAxCcxI4JFKSv8LN9zagMDcxEQR4?=
 =?us-ascii?Q?wJGputY1sFL9R1nUsOSR/+iKqYZh5obcj1GSSVXJN51oVqfza+zb4ap6CKPS?=
 =?us-ascii?Q?EyB4x8OWrq+7733X1XvW6XEGnhDbdnLfkqwq6i20osU1F4FJb+7yuMROBdXO?=
 =?us-ascii?Q?FfqvrTQK68A2TunLS2t7lKMUl5ucuTlYuGvgwbPO6AOspv2mpiQyUj41wqPD?=
 =?us-ascii?Q?vreoNs2U7oIcmgSlF/LuRAp+z1gtf/NFtK1x/x5MuTt75IcmPY8uSt24pY8J?=
 =?us-ascii?Q?GximJ7ApQ6INPixDglHtF/iO/Cko2KbqKoGtze/1jpilVkePopYFDLEyswzq?=
 =?us-ascii?Q?S8h12QWW8PNFNeX2a1XmCKtoKBWYaEqTVeWhfhU2Lyp3Pm6FBq4BzKyaacns?=
 =?us-ascii?Q?OTHcutaj6jvpLgZ+EnnNXY7RCvnwfKupXhaMRFY1IYm+jquX2iUD42UiSzdt?=
 =?us-ascii?Q?3S3Jedaf3OGVcdP9HfTSgEGRQ524MzizI7KqDer3hFcaNwxnYBR610vodent?=
 =?us-ascii?Q?xwpARqN2qxrQm5sVZfAz9nPPuU7r9Qtv9z0HzZ/bhhrRiHcmHj8w?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f8ad9e-5d3e-477f-efaa-08df2e75e6f7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 06:46:43.5780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LPJK5IzIr9MAUa0PKihw+FsdkWfOelmoC2VUTRSxyQT+GyffiocWeVw5KPb6hUQmeAfDkXsD8/X4yfyJw5jHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7050

On Wed, Oct 14, 2026 at 12:50:24AM +0900, Koichiro Den wrote:
> On Tue, Oct 13, 2026 at 09:53:04AM -0500, Frank Li wrote:
> > On Tue, Oct 13, 2026 at 09:46:36AM +0900, Koichiro Den wrote:
> > > On Mon, Oct 12, 2026 at 03:04:46PM -0500, Frank Li wrote:
> > > > On Fri, Oct 09, 2026 at 01:59:48PM +0900, Koichiro Den wrote:
> > > > > A vNTB PCI function can now expose endpoint-local DMA channels to its
> > > > > host. Decode the extension and register the advertised channels before
> > > > > the NTB device, so clients of that NTB device can use the DMA
> > > > > functionality in the same PCI function. Endpoints without the extension,
> > > > > or hosts without support for its DMA type or with no DMA IRQ available,
> > > > > continue without DMA.
> > > > >
> > > > > Only DW eDMA is supported for now. Dispatch on the advertised DMA type
> > > > > and keep type-specific setup in local helpers. Support for another
> > > > > implementation can add a new case and its own helpers.
> > > > >
> > > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > > ---
> > > > > Changes in v5:
> > > > >   - Simplify the implementation by using pcim_iomap_range()
> > > > >   - Drop the unrelated MW size-limit change for pci-epf-ntb bridges.
> > > > >
> > > > >  drivers/ntb/hw/epf/ntb_hw_epf.c | 336 ++++++++++++++++++++++++++++++--
> > > > >  1 file changed, 323 insertions(+), 13 deletions(-)
> > > > >
> > > > > diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > > > > index c47607d4f8a7..7faa40d1ae00 100644
> > > > > --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> > > > > +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > > > > @@ -8,6 +8,7 @@
> > > > >
> > > > >  #include <linux/atomic.h>
> > > > >  #include <linux/delay.h>
> > > > > +#include <linux/dma/edma.h>
> > > > >  #include <linux/module.h>
> > > > >  #include <linux/pci.h>
> > > > >  #include <linux/slab.h>
> > > > > @@ -20,6 +21,7 @@
> > > > >  #define CMD_TEARDOWN_MW		4
> > > > >  #define CMD_LINK_UP		5
> > > > >  #define CMD_LINK_DOWN		6
> > > > > +#define CMD_SETUP_DMA_BAR	7
> > > > >
> > > > >  #define NTB_EPF_ARGUMENT	0x4
> > > > >  #define MSIX_ENABLE		BIT(16)
> > > > > @@ -44,6 +46,32 @@
> > > > >  #define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
> > > > >  #define NTB_EPF_DB_OFFSET(n)	(0xB4 + (n) * 4)
> > > > >
> > > > > +/* Private DMA wire extension produced by pci-epf-vntb. */
> > > > > +#define NTB_EPF_DMA_BASE	0x134
> > > > > +#define NTB_EPF_DMA_MAGIC	(NTB_EPF_DMA_BASE + 0x00)
> > > > > +#define NTB_EPF_DMA_REV_LEN	(NTB_EPF_DMA_BASE + 0x04)
> > > > > +#define NTB_EPF_DMA_TYPE	(NTB_EPF_DMA_BASE + 0x08)
> > > > > +#define NTB_EPF_DMA_REGION_BAR(base)	((base) + 0x00)
> > > > > +#define NTB_EPF_DMA_REGION_OFFSET(base)	((base) + 0x04)
> > > > > +#define NTB_EPF_DMA_REGION_SIZE(base)	((base) + 0x08)
> > > > > +#define NTB_EPF_DMA_REGION_SIZEOF	0x0C
> > > > > +#define NTB_EPF_DMA_SUBMAP_BASE	(NTB_EPF_DMA_BASE + 0x0C)
> > > > > +#define NTB_EPF_DMA_COMMON_SIZE	0x18
> > > > > +#define NTB_EPF_DMA_REG_BASE	(NTB_EPF_DMA_BASE + NTB_EPF_DMA_COMMON_SIZE)
> > > > > +#define NTB_EPF_DMA_CHAN_BASE	(NTB_EPF_DMA_REG_BASE + \
> > > > > +					 NTB_EPF_DMA_REGION_SIZEOF)
> > > > > +#define NTB_EPF_DMA_CHAN_SIZE	0x14
> > > > > +#define NTB_EPF_DMA_CHAN_DESC_BASE(n)	(NTB_EPF_DMA_CHAN_BASE + \
> > > > > +					 (n) * NTB_EPF_DMA_CHAN_SIZE + 0x00)
> > > > > +#define NTB_EPF_DMA_CHAN_DESC_ADDR_LO(n)	(NTB_EPF_DMA_CHAN_BASE + \
> > > > > +					 (n) * NTB_EPF_DMA_CHAN_SIZE + 0x0C)
> > > > > +#define NTB_EPF_DMA_CHAN_DESC_ADDR_HI(n)	(NTB_EPF_DMA_CHAN_BASE + \
> > > > > +					 (n) * NTB_EPF_DMA_CHAN_SIZE + 0x10)
> > > > > +
> > >
> > > Hi Frank, thanks for the review.
> > >
> > > >
> > > > legacy use two sets define. Can we use common header files for both epf
> > > > drivers.
> > > >
> > > > In ntb_hw_epf.c, it use readl(), in pci_endpont_vntb.c use direct memory
> > > > access.
> > > >
> > > > Can use offsetof() to avoid these define? we can move more after common
> > > > head created.
> > >
> > > I personally don't think it is a good idea to leak such feature-specific
> > > definitions into include/linux, now that we agreed upon keeping this feature
> > > local to vNTB. This contrasts with the previous PCI EPF DMA approach, which
> > > added include/linux/pci-ep-dma.h:
> > > https://lore.kernel.org/r/20260813063757.3131865-3-den@valinux.co.jp/
> > 
> > pci-ep-dma.h is used for EP controler and DMA engineer driver only.
> 
> Yeah, my point was that with the vNTB-embedded design, it just seems reasonable
> to me to do without such a header.
> 
> > 
> > >
> > > I'm aware of the duplication in the current form, but my gut is that it's still
> > > a tolerable amount, and can be seen as just an extention of the current way of
> > > defining epf_ntb_ctrl in pci-epf-vntb.c and hard-coding the offsets in
> > > ntb_hw_epf.c.
> > >
> > > So Frank, I'd appreciate it if you could elaborate a bit more, on what concrete
> > > header location and naming you have in mind. Maybe something like
> > > include/linux/pci-epf-vntb.h?
> > 
> > I think it is fine. Or include/linux/pci-epf-ntb.h, which can include
> > ntb part defination in future.
> 
> Okay, got it. To me include/linux/pci-epf-vntb.h (or pci-epf-ntb.h) still looks
> somewhat odd, but I might feel differently tomorrow morning... I'll go with your
> suggestion.
> I will respin and add a prep patch that first moves the existing epf_ntb_ctrl to
> the header and replaces the hard-coded macros in ntb_hw_epf.c with more
> readable/maintainable offset calculations, and then use the header for the
> vNTB-DMA stuff.
> 
> Mani, please let me know if you have any objections.

Hi Frank (cc: Mani),

I have submitted v6, with a new patch for the header:
https://lore.kernel.org/r/20261020054948.1218370-5-den@valinux.co.jp/

I'd appreciate another look at it when you have some bandwidth.
Thanks in advance.

Best regards,
Koichiro Den

> 
> Thanks for the review!
> 
> Best regards,
> Koichiro Den
> 
> > 
> > Frank
> > 
> > >
> > > Mani, I'd appreciate your thoughts on this as well, so we can avoid going back
> > > and forth any further.
> > >
> > > Best regards,
> > > Koichiro Den
> > >
> > > >
> > > > Frank
> > > >
> > > > > +#define NTB_EPF_DMA_MAGIC_VALUE	0x414d444e /* "NDMA": NTB DMA */
> > > > > +#define NTB_EPF_DMA_REVISION	1
> > > > > +#define NTB_EPF_DMA_TYPE_DW_EDMA	1
> > > > > +
> > > > >  /*
> > > > >   * Legacy doorbell slot layout when paired with pci-epf-*ntb:
> > > > >   *
> > > > > @@ -97,6 +125,24 @@ struct ntb_epf_irq_ctx {
> > > > >  	unsigned int irq_no;
> > > > >  };
> > > > >
> > > > > +struct ntb_epf_dma_region {
> > > > > +	unsigned int bar;
> > > > > +	resource_size_t offset;
> > > > > +	resource_size_t size;
> > > > > +};
> > > > > +
> > > > > +struct ntb_epf_dw_edma {
> > > > > +	struct dw_edma_chip chip;
> > > > > +	struct ntb_epf_dma_region reg;
> > > > > +	struct ntb_epf_dma_region ll[EDMA_MAX_RD_CH];
> > > > > +};
> > > > > +
> > > > > +struct ntb_epf_dma {
> > > > > +	struct ntb_epf_dma_region submap;
> > > > > +	unsigned int nr_irqs;
> > > > > +	u32 type;
> > > > > +};
> > > > > +
> > > > >  struct ntb_epf_dev {
> > > > >  	struct ntb_dev ntb;
> > > > >  	struct device *dev;
> > > > > @@ -108,6 +154,8 @@ struct ntb_epf_dev {
> > > > >  	unsigned int mw_count;
> > > > >  	unsigned int spad_count;
> > > > >  	unsigned int db_count;
> > > > > +	struct ntb_epf_dma dma;
> > > > > +	struct ntb_epf_dw_edma dw_edma;
> > > > >
> > > > >  	void __iomem *ctrl_reg;
> > > > >  	void __iomem *db_reg;
> > > > > @@ -162,6 +210,212 @@ static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
> > > > >  	return ret;
> > > > >  }
> > > > >
> > > > > +static bool ntb_epf_dma_region_parse(struct ntb_epf_dev *ndev, u32 base,
> > > > > +				     bool optional,
> > > > > +				     struct ntb_epf_dma_region *region)
> > > > > +{
> > > > > +	resource_size_t bar_len;
> > > > > +	u32 bar, offset, size;
> > > > > +
> > > > > +	bar = readl(ndev->ctrl_reg + NTB_EPF_DMA_REGION_BAR(base));
> > > > > +	offset = readl(ndev->ctrl_reg + NTB_EPF_DMA_REGION_OFFSET(base));
> > > > > +	size = readl(ndev->ctrl_reg + NTB_EPF_DMA_REGION_SIZE(base));
> > > > > +	region->bar = bar;
> > > > > +	region->offset = offset;
> > > > > +	region->size = size;
> > > > > +	if (!size)
> > > > > +		return optional && bar == U32_MAX && !offset;
> > > > > +	if (bar > BAR_5)
> > > > > +		return false;
> > > > > +
> > > > > +	bar_len = pci_resource_len(ndev->ntb.pdev, bar);
> > > > > +	if (offset > bar_len || size > bar_len - offset)
> > > > > +		return false;
> > > > > +
> > > > > +	return true;
> > > > > +}
> > > > > +
> > > > > +/* DW eDMA */
> > > > > +
> > > > > +static int ntb_epf_dw_edma_parse(struct ntb_epf_dev *ndev, u32 length)
> > > > > +{
> > > > > +	struct ntb_epf_dw_edma *edma = &ndev->dw_edma;
> > > > > +	struct dw_edma_chip *chip = &edma->chip;
> > > > > +	u32 count, chan_offset;
> > > > > +	unsigned int i;
> > > > > +
> > > > > +	chan_offset = NTB_EPF_DMA_CHAN_BASE - NTB_EPF_DMA_BASE;
> > > > > +	if (length < chan_offset + NTB_EPF_DMA_CHAN_SIZE ||
> > > > > +	    (length - chan_offset) % NTB_EPF_DMA_CHAN_SIZE)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	count = (length - chan_offset) / NTB_EPF_DMA_CHAN_SIZE;
> > > > > +	if (count > EDMA_MAX_RD_CH)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	if (!ntb_epf_dma_region_parse(ndev, NTB_EPF_DMA_REG_BASE, false,
> > > > > +				      &edma->reg) ||
> > > > > +	    !IS_ALIGNED(edma->reg.offset, sizeof(u32)))
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	chip->mf = EDMA_MF_EDMA_UNROLL;
> > > > > +	chip->ll_rd_cnt = count;
> > > > > +	chip->func_no = PCI_FUNC(ndev->ntb.pdev->devfn);
> > > > > +
> > > > > +	for (i = 0; i < count; i++) {
> > > > > +		u64 paddr;
> > > > > +
> > > > > +		if (!ntb_epf_dma_region_parse(ndev,
> > > > > +					      NTB_EPF_DMA_CHAN_DESC_BASE(i),
> > > > > +					      false, &edma->ll[i]) ||
> > > > > +		    !IS_ALIGNED(edma->ll[i].offset, sizeof(u32)))
> > > > > +			return -EINVAL;
> > > > > +
> > > > > +		paddr = readl(ndev->ctrl_reg +
> > > > > +			      NTB_EPF_DMA_CHAN_DESC_ADDR_LO(i));
> > > > > +		paddr |= (u64)readl(ndev->ctrl_reg +
> > > > Frank> +				    NTB_EPF_DMA_CHAN_DESC_ADDR_HI(i)) << 32;
> > > > > +		if (paddr == U64_MAX)
> > > > > +			return -EINVAL;
> > > > > +
> > > > > +		chip->ll_region_rd[i].sz = edma->ll[i].size;
> > > > > +		chip->ll_region_rd[i].paddr = paddr;
> > > > > +	}
> > > > > +	ndev->dma.nr_irqs = count;
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int ntb_epf_dw_edma_irq_vector(struct device *dev, unsigned int nr)
> > > > > +{
> > > > > +	struct ntb_epf_dev *ndev = dev_get_drvdata(dev);
> > > > > +
> > > > > +	/* DMA vectors follow the NTB link and doorbell vector block. */
> > > > > +	return pci_irq_vector(ndev->ntb.pdev, ndev->db_count + 1 + nr);
> > > > > +}
> > > > > +
> > > > > +static const struct dw_edma_plat_ops ntb_epf_dw_edma_ops = {
> > > > > +	.irq_vector = ntb_epf_dw_edma_irq_vector,
> > > > > +};
> > > > > +
> > > > > +static void __iomem *
> > > > > +ntb_epf_dw_edma_map_region(struct pci_dev *pdev,
> > > > > +			   const struct ntb_epf_dma_region *region)
> > > > > +{
> > > > > +	return pcim_iomap_range(pdev, region->bar, region->offset, region->size);
> > > > > +}
> > > > > +
> > > > > +static int ntb_epf_dw_edma_init(struct ntb_epf_dev *ndev)
> > > > > +{
> > > > > +	struct ntb_epf_dw_edma *edma = &ndev->dw_edma;
> > > > > +	struct dw_edma_chip *chip = &edma->chip;
> > > > > +	struct pci_dev *pdev = ndev->ntb.pdev;
> > > > > +	unsigned int i;
> > > > > +	int ret;
> > > > > +
> > > > > +	/* Install BAR submaps before mapping the advertised DMA regions. */
> > > > > +	ret = ntb_epf_send_command(ndev, CMD_SETUP_DMA_BAR, 0);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	chip->reg_base = ntb_epf_dw_edma_map_region(pdev, &edma->reg);
> > > > > +	if (IS_ERR(chip->reg_base))
> > > > > +		return PTR_ERR(chip->reg_base);
> > > > > +	for (i = 0; i < chip->ll_rd_cnt; i++) {
> > > > > +		chip->ll_region_rd[i].vaddr.io =
> > > > > +			ntb_epf_dw_edma_map_region(pdev, &edma->ll[i]);
> > > > > +		if (IS_ERR(chip->ll_region_rd[i].vaddr.io))
> > > > > +			return PTR_ERR(chip->ll_region_rd[i].vaddr.io);
> > > > > +	}
> > > > > +
> > > > > +	chip->dev = ndev->dev;
> > > > > +	chip->nr_irqs = ndev->dma.nr_irqs;
> > > > > +	chip->ops = &ntb_epf_dw_edma_ops;
> > > > > +	chip->flags = DW_EDMA_CHIP_PARTIAL;
> > > > > +
> > > > > +	return dw_edma_probe(chip);
> > > > > +}
> > > > > +
> > > > > +static void ntb_epf_dw_edma_deinit(struct ntb_epf_dev *ndev)
> > > > > +{
> > > > > +	dw_edma_remove(&ndev->dw_edma.chip);
> > > > > +}
> > > > > +
> > > > > +/* Common endpoint DMA */
> > > > > +
> > > > > +static int ntb_epf_dma_parse(struct ntb_epf_dev *ndev)
> > > > > +{
> > > > > +	u32 magic, rev_len, length, type;
> > > > > +	u32 spad_off;
> > > > > +	int ret;
> > > > > +
> > > > > +	/*
> > > > > +	 * Legacy endpoints place scratchpads where this extension would begin.
> > > > > +	 * Once the extension is present, malformed metadata is fatal.
> > > > > +	 */
> > > > > +	spad_off = readl(ndev->ctrl_reg + NTB_EPF_SPAD_OFFSET);
> > > > > +	if (spad_off < NTB_EPF_DMA_BASE + NTB_EPF_DMA_COMMON_SIZE)
> > > > > +		return 0;
> > > > > +
> > > > > +	magic = readl(ndev->ctrl_reg + NTB_EPF_DMA_MAGIC);
> > > > > +	if (!magic)
> > > > > +		return 0;
> > > > > +	if (magic == U32_MAX)
> > > > > +		return -EIO;
> > > > > +	if (magic != NTB_EPF_DMA_MAGIC_VALUE)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	rev_len = readl(ndev->ctrl_reg + NTB_EPF_DMA_REV_LEN);
> > > > > +	length = upper_16_bits(rev_len);
> > > > > +	if (lower_16_bits(rev_len) != NTB_EPF_DMA_REVISION ||
> > > > > +	    length < NTB_EPF_DMA_COMMON_SIZE ||
> > > > > +	    spad_off < NTB_EPF_DMA_BASE + length)
> > > > > +		return -EINVAL;
> > > > > +	if (!ntb_epf_dma_region_parse(ndev, NTB_EPF_DMA_SUBMAP_BASE, true,
> > > > > +				      &ndev->dma.submap))
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	type = readl(ndev->ctrl_reg + NTB_EPF_DMA_TYPE);
> > > > > +	if (type == U32_MAX)
> > > > > +		return -EIO;
> > > > > +
> > > > > +	switch (type) {
> > > > > +	case NTB_EPF_DMA_TYPE_DW_EDMA:
> > > > > +		if (!IS_REACHABLE(CONFIG_DW_EDMA))
> > > > > +			break;
> > > > > +		ret = ntb_epf_dw_edma_parse(ndev, length);
> > > > > +		if (!ret)
> > > > > +			ndev->dma.type = type;
> > > > > +		return ret;
> > > > > +	default:
> > > > > +		break;
> > > > > +	}
> > > > > +
> > > > > +	dev_warn(ndev->dev,
> > > > > +		 "Endpoint DMA type %u unavailable, continuing without DMA\n",
> > > > > +		 type);
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int ntb_epf_dma_init(struct ntb_epf_dev *ndev)
> > > > > +{
> > > > > +	switch (ndev->dma.type) {
> > > > > +	case NTB_EPF_DMA_TYPE_DW_EDMA:
> > > > > +		return ntb_epf_dw_edma_init(ndev);
> > > > > +	default:
> > > > > +		return 0;
> > > > > +	}
> > > > > +}
> > > > > +
> > > > > +static void ntb_epf_dma_deinit(struct ntb_epf_dev *ndev)
> > > > > +{
> > > > > +	switch (ndev->dma.type) {
> > > > > +	case NTB_EPF_DMA_TYPE_DW_EDMA:
> > > > > +		ntb_epf_dw_edma_deinit(ndev);
> > > > > +		break;
> > > > > +	}
> > > > > +}
> > > > > +
> > > > >  static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
> > > > >  {
> > > > >  	struct device *dev = ndev->dev;
> > > > > @@ -174,6 +428,23 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
> > > > >  	return ndev->barno_map[BAR_MW1 + idx];
> > > > >  }
> > > > >
> > > > > +static resource_size_t ntb_epf_mw_offset(struct ntb_epf_dev *ndev, int idx)
> > > > > +{
> > > > > +	return !idx ? readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET) : 0;
> > > > > +}
> > > > > +
> > > > > +static resource_size_t ntb_epf_mw_size(struct ntb_epf_dev *ndev, int bar)
> > > > > +{
> > > > > +	resource_size_t end;
> > > > > +
> > > > > +	end = pci_resource_len(ndev->ntb.pdev, bar);
> > > > > +	/* The DMA submap offset marks the end of an MW sharing this BAR. */
> > > > > +	if (ndev->dma.submap.size && ndev->dma.submap.bar == bar)
> > > > > +		end = min(end, ndev->dma.submap.offset);
> > > > > +
> > > > > +	return end;
> > > > > +}
> > > > > +
> > > > >  static int ntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
> > > > >  {
> > > > >  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> > > > > @@ -212,7 +483,7 @@ static int ntb_epf_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
> > > > >  		*size_align = 1;
> > > > >
> > > > >  	if (size_max)
> > > > > -		*size_max = pci_resource_len(ndev->ntb.pdev, bar);
> > > > > +		*size_max = ntb_epf_mw_size(ndev, bar);
> > > > >
> > > > >  	return 0;
> > > > >  }
> > > > > @@ -373,16 +644,20 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
> > > > >  {
> > > > >  	struct pci_dev *pdev = ndev->ntb.pdev;
> > > > >  	struct device *dev = ndev->dev;
> > > > > +	unsigned int dma_max = ndev->dma.nr_irqs;
> > > > > +	unsigned int dma_min;
> > > > >  	u32 argument = MSIX_ENABLE;
> > > > > +	unsigned int ntb_irqs;
> > > > >  	int irq;
> > > > >  	int ret;
> > > > >  	int i;
> > > > >
> > > > > -	irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max, PCI_IRQ_MSIX);
> > > > > +	irq = pci_alloc_irq_vectors(pdev, msi_min,
> > > > > +				    msi_max + dma_max, PCI_IRQ_MSIX);
> > > > >  	if (irq < 0) {
> > > > >  		dev_dbg(dev, "Failed to get MSIX interrupts\n");
> > > > > -		irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max,
> > > > > -					    PCI_IRQ_MSI);
> > > > > +		irq = pci_alloc_irq_vectors(pdev, msi_min,
> > > > > +					    msi_max + dma_max, PCI_IRQ_MSI);
> > > > >  		if (irq < 0) {
> > > > >  			dev_err(dev, "Failed to get MSI interrupts\n");
> > > > >  			return irq;
> > > > > @@ -390,8 +665,17 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
> > > > >  		argument &= ~MSIX_ENABLE;
> > > > >  	}
> > > > >
> > > > > -	ndev->db_count = irq - 1;
> > > > > -	for (i = 0; i < irq; i++) {
> > > > > +	dma_min = dma_max && irq > msi_min;
> > > > > +	/* Reserve one shared DMA IRQ when available, then give the rest to NTB. */
> > > > > +	ntb_irqs = min_t(unsigned int, irq - dma_min, msi_max);
> > > > > +	ndev->dma.nr_irqs = irq - ntb_irqs;
> > > > > +	if (dma_max && !ndev->dma.nr_irqs) {
> > > > > +		dev_warn(dev,
> > > > > +			 "No IRQ available for endpoint DMA, continuing without DMA\n");
> > > > > +		ndev->dma.type = 0;
> > > > > +	}
> > > > > +	ndev->db_count = ntb_irqs - 1;
> > > > > +	for (i = 0; i < ntb_irqs; i++) {
> > > > >  		ndev->irq_ctx[i].ndev = ndev;
> > > > >  		ndev->irq_ctx[i].irq_no = i;
> > > > >  		ret = request_irq(pci_irq_vector(pdev, i), ntb_epf_vec_isr,
> > > > > @@ -403,7 +687,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
> > > > >  	}
> > > > >
> > > > >  	ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_DOORBELL,
> > > > > -				   argument | irq);
> > > > > +				   argument | ntb_irqs);
> > > > >  	if (ret) {
> > > > >  		dev_err(dev, "Failed to configure doorbell\n");
> > > > >  		goto err_free_irq;
> > > > > @@ -486,7 +770,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
> > > > >  	if (bar < 0)
> > > > >  		return bar;
> > > > >
> > > > > -	mw_size = pci_resource_len(ntb->pdev, bar);
> > > > > +	mw_size = ntb_epf_mw_size(ndev, bar);
> > > > >
> > > > >  	if (size > mw_size) {
> > > > >  		dev_err(dev, "Size:%pa is greater than the MW size %pa\n",
> > > > > @@ -520,21 +804,20 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
> > > > >  				    phys_addr_t *base, resource_size_t *size)
> > > > >  {
> > > > >  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> > > > > -	u32 offset = 0;
> > > > > +	resource_size_t offset;
> > > > >  	int bar;
> > > > >
> > > > > -	if (idx == 0)
> > > > > -		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
> > > > > -
> > > > >  	bar = ntb_epf_mw_to_bar(ndev, idx);
> > > > >  	if (bar < 0)
> > > > >  		return bar;
> > > > >
> > > > > +	offset = ntb_epf_mw_offset(ndev, idx);
> > > > > +
> > > > >  	if (base)
> > > > >  		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
> > > > >
> > > > >  	if (size)
> > > > > -		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
> > > > > +		*size = ntb_epf_mw_size(ndev, bar) - offset;
> > > > >
> > > > >  	return 0;
> > > > >  }
> > > > > @@ -630,12 +913,30 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
> > > > >  {
> > > > >  	struct device *dev = ndev->dev;
> > > > >  	int ret;
> > > > > +	int i;
> > > > >
> > > > >  	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
> > > > >  	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
> > > > >  		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
> > > > >  		return -EINVAL;
> > > > >  	}
> > > > > +	ret = ntb_epf_dma_parse(ndev);
> > > > > +	if (ret) {
> > > > > +		dev_err(dev, "Invalid endpoint DMA layout\n");
> > > > > +		return ret;
> > > > > +	}
> > > > > +	if (ndev->dma.submap.size) {
> > > > > +		for (i = 0; i < ndev->mw_count; i++) {
> > > > > +			int bar = ntb_epf_mw_to_bar(ndev, i);
> > > > > +
> > > > > +			if (bar == ndev->dma.submap.bar &&
> > > > > +			    ntb_epf_mw_size(ndev, bar) <=
> > > > > +			    ntb_epf_mw_offset(ndev, i)) {
> > > > > +				dev_err(dev, "Invalid DMA/MW boundary\n");
> > > > > +				return -EINVAL;
> > > > > +			}
> > > > > +		}
> > > > > +	}
> > > > >
> > > > >  	/* One Link interrupt and rest doorbell interrupt */
> > > > >  	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
> > > > > @@ -785,6 +1086,12 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
> > > > >  		goto err_init_dev;
> > > > >  	}
> > > > >
> > > > > +	ret = ntb_epf_dma_init(ndev);
> > > > > +	if (ret) {
> > > > > +		dev_err(dev, "Failed to initialize endpoint DMA\n");
> > > > > +		goto err_dma_init;
> > > > > +	}
> > > > > +
> > > > >  	ret = ntb_register_device(&ndev->ntb);
> > > > >  	if (ret) {
> > > > >  		dev_err(dev, "Failed to register NTB device\n");
> > > > > @@ -794,6 +1101,8 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
> > > > >  	return 0;
> > > > >
> > > > >  err_register_dev:
> > > > > +	ntb_epf_dma_deinit(ndev);
> > > > > +err_dma_init:
> > > > >  	ntb_epf_cleanup_isr(ndev);
> > > > >
> > > > >  err_init_dev:
> > > > > @@ -807,6 +1116,7 @@ static void ntb_epf_pci_remove(struct pci_dev *pdev)
> > > > >  	struct ntb_epf_dev *ndev = pci_get_drvdata(pdev);
> > > > >
> > > > >  	ntb_unregister_device(&ndev->ntb);
> > > > > +	ntb_epf_dma_deinit(ndev);
> > > > >  	ntb_epf_cleanup_isr(ndev);
> > > > >  	ntb_epf_deinit_pci(ndev);
> > > > >  }
> > > > > --
> > > > > 2.51.0
> > > > >
> 
