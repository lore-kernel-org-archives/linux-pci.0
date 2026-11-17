Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945315;
	b=5sjTeNR7A5CXBJtz1ALhMSZZg5r5VTskwUA6QwMxL4E37xqsbUz8ut8sANUK+ErJ2n+e
	 at/BVoxPnlNeirg6owDmQHilNm1Yc+OGI7yk55GfkBN8fzC7g7L/Mzfc94wuY8umgqQLK
	 ABzQ5rz1cnxF1IcfYbmU94HcoX680wSGm8Jmv/8rglafCtwm5I6clf0XW3D9KcxR5hP14
	 Utmn9l/p4ikBiafHaWv0vo3YZdHNx8RRXzvFSZI1MeI1H8GieQaA68TFFsslIzcasayjs
	 xNzHlPSiUGk62lLb3W1oD04YF2l9Ytzlp2ZGmw9SZU5/KKDSL1GJjfKS5eBxS6dzezg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945315;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=FiuczpS642z4tqeB5kPt0ZbvVVemzyyGPEF/bdILDlk=;
	b=Pb1+fFh23rZRvvrat9BYFG3c6t1LWOHnrWv5fT8NUW4JGkb0PD8mkDC2prX3jmnTbads
	 RL3Djschgd4h/fqk9L/xsCrHAVsih+yVV3sVjeY0RPeapOVPS/PUloJryHwCUeqkjIthQ
	 YtukYw1IcV/VIzemYnlrfL8h96YNdNrMpFChccg+IzVFnY4m+d/th7dEBKM3uO01fJ87Y
	 qIOhWLIio1pz9QAk9MEJXDlGYOFLDu0ca/yohA176FMLiml7mXLO/hpyuyuUXQt+NBJcA
	 l3SQ2ugqfN+oua8Kf9RU0kPaNhYVjIdrVeSqIJM2xuPJMdnQ/9LpkbpHQoidz0ZN2kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=Qn1NESUu;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1370606A332;
	Tue, 17 Nov 2026 19:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1370606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=Qn1NESUu
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 945C040E01E1;
	Tue, 17 Nov 2026 19:55:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3Ggrgw5ylJyw; Tue, 17 Nov 2026 19:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1794945308; bh=FiuczpS642z4tqeB5kPt0ZbvVVemzyyGPEF/bdILDlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qn1NESUu6sPmE0eD6d0UCNF8hJwm73CiYLKgqAT6B9WnmfbVy6r72xM6Q8ww72zRr
	 QVeQy7gY8toTEYlFdDIYqhkxaIqNke6ayI9p53/vYCUPCcXD4JNEf7H9vEDmQMDZRY
	 VpZruo9R5Zu61fGvjxJ3oCRN3h+AP3VLK15nRVvg1WjNIguzmUWX3DTEtGcjfoZzAX
	 6+Aqnlmh2TJjqo6cRR/S3gEYPRZpM/qi10Bv+7kxJmRt64sAiCKWA5qsks6uvt34Uh
	 zzm6cno7YqzOSkFH+xeZnh1fQbu/ADIxx1Dv68NCSK0AvJlh9xuESGRSqjMwlzWbJK
	 PnOAG9RJbxUTY7bgzQ+A45pidpNDKsGGTvsE3k2kkur7LHWEJOY5F2IOfEqx50QEIC
	 9tiJQtO5FfxRIDpCdyXhff+NGol8Hr5Jq0Q7QzMzVomWn1hvTx4BW2YSNSa/Z05ujO
	 NAVJNIln/2QbGwMbzNg3NJI/+LxaZLOXJfq/jOT6LclDdkoAvah9I5mOhHiHOKgZy2
	 bJ3kTDgH0/jh1WZdYNBvmNSmt/pqRAn0Wz7eg9wH1ZzMzOiJ5xCkN+Jzb8U3xH2I+w
	 SUttGPZZ0LEI090+Llzuxil1isv2q0JxSFE03XdNVSlB4Ba3+7DT8OKyCnXC5PVUYQ
	 MXFLH6qiuqo7TTo++nY2wWTA=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D1D1A40E00DC;
	Tue, 17 Nov 2026 19:54:58 +0000 (UTC)
Date: Tue, 17 Nov 2026 11:54:55 -0800
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/13] i82875p_edac: Convert to
 pci_assign_unassigned_bus_resources()
Message-ID: <20261117195455.GEavyxDycsQbYSctQr@fat_crate.local>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
 <20261116152403.2672-7-ilpo.jarvinen@linux.intel.com>
 <20261116154005.GAavsj1a11BRgBVtSd@fat_crate.local>
 <CH8PR11MB403433B2B6C13E8AA2A31130FAFC7C2@CH8PR11MB403433.namprd11.prod.outlook.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CH8PR11MB403433B2B6C13E8AA2A31130FAFC7C2@CH8PR11MB403433.namprd11.prod.outlook.com>

On Mon, Nov 16, 2026 at 05:11:09PM +0000, Luck, Tony wrote:
> > In addition to this, Tony, should we orphan this one too?
> >
> > It is a P4-something-chipset...
> 
> Looks like it was release in 2003 or so. Only supports 4GB of memory.
> Even if someone still has one powered up, unlikely that they would run
> an upstream kernel on it.
> 
> I'm OK with marking it as orphaned.

Ok, here's what I have in mind:

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Tue, 17 Nov 2026 11:49:09 -0800
Subject: [PATCH] MAINTAINERS: Add a common entry for orphaned EDAC drivers

This removes a bunch of lines in the MAINTAINERS file while having the
same result: unify orphaned EDAC drivers which are not going to receive
any more fixes due to lack of hardware, age of the hardware supported
and general lack of use.

This is also adding drivers/edac/i82875p_edac.c to the lineup which is
a 32-bit only chipset for Pentium 4 from 2003 or so.

The code is not going away - if there are users who are willing to test,
we can easily resurrect them.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 MAINTAINERS | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 31c06c57de93..f1a83cea9798 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9386,11 +9386,6 @@ L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/octeon_edac*
 
-EDAC-CAVIUM THUNDERX
-L:	linux-edac@vger.kernel.org
-S:	Orphan
-F:	drivers/edac/thunderx_edac*
-
 EDAC-CORE
 M:	Borislav Petkov <bp@alien8.de>
 M:	Tony Luck <tony.luck@intel.com>
@@ -9414,11 +9409,6 @@ L:	linux-edac@vger.kernel.org
 S:	Supported
 F:	drivers/edac/dmc520_edac.c
 
-EDAC-E752X
-L:	linux-edac@vger.kernel.org
-S:	Orphan
-F:	drivers/edac/e752x_edac.c
-
 EDAC-E7XXX
 L:	linux-edac@vger.kernel.org
 S:	Maintained
@@ -9443,11 +9433,6 @@ L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/i10nm_base.c
 
-EDAC-I3000
-L:	linux-edac@vger.kernel.org
-S:	Orphan
-F:	drivers/edac/i3000_edac.c
-
 EDAC-I5000
 R:	Andrew Luebke <andrew.luebke@gmail.com>
 L:	linux-edac@vger.kernel.org
@@ -9491,11 +9476,6 @@ L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/igen6_edac.c
 
-EDAC-MPC85XX
-L:	linux-edac@vger.kernel.org
-S:	Orphan
-F:	drivers/edac/mpc85xx_edac.[ch]
-
 EDAC-NPCM
 M:	Marvin Lin <kflin@nuvoton.com>
 M:	Stanley Chu <yschu@nuvoton.com>
@@ -9542,6 +9522,15 @@ L:	linux-edac@vger.kernel.org
 S:	Odd Fixes
 F:	drivers/edac/ti_edac.c
 
+EDAC ORPHANED DRIVERS
+L:	linux-edac@vger.kernel.org
+S:	Orphan
+F:	drivers/edac/e752x_edac.c
+F:	drivers/edac/i3000_edac.c
+F:	drivers/edac/i82875p_edac.c
+F:	drivers/edac/mpc85xx_edac.[ch]
+F:	drivers/edac/thunderx_edac*
+
 EDIROL UA-101/UA-1000 DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
 L:	linux-sound@vger.kernel.org
-- 
2.53.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
