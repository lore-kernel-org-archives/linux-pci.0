Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794982816;
	b=XvEBOfHFpKx6TmdJsxqvh2HGs9wkpt3bQlNteSLzmgtfNyrZtDkgGee+pUCkadUVTd5e
	 hSxs8MYuJhjuIouq9R22+IsGUdQpJ53mYWXIFo9ySi7Ap8FCWtxzTJ2IRzFpyCOvR4quf
	 4FqY4NY+HvcGxbAurr3eMT+w6+1h2HgpV3rAQiOeOM+jNHPoFwCsGtqfl5blgUi03ou4E
	 MWh2p0VNVbCaLy4VJe4DGGJVWkmhc1oEj2KMmXrBstWqle3nR17Z6GCTG8ZzDVnz5qHTG
	 xIYeeWT0AfYGax6TIzRjxnO+7duv0PYOvOApQ7WigAxZ/3dRouWSLgeqPj0GdN8Y4+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794982816;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=d0Ix9gsUTiEGaSow4N/1s7rVr2v9JLfaHj/KrE0P7Zk=;
	b=vZkbtyb8TIQjlb7hqU/rdFJYUXq3w3rTm1HWXRNCX6+xbqN0VHB4ayB47NVNbnnnaQVx
	 8jVFLuAR9ig+hPLFuUADN2E9Pkb7umcabjV+98LC2O9BQF2nAKNbRZROYsJJoNo9KJ2xf
	 e9tgw4WdkeZ2wCaqgaYdnRInRlKsxe68/9jmn90Q/TnVoFMqSRDfuY/xbAGHq3A5ufDig
	 idjYIoLGnoTvjCN3AEMMYiZE2Cnazngzos8zyfLon0vQXUrQRu6uE54zVDSl7jBu9xgSi
	 /QGM5KiyLQoTre+IkKCVF7X3tiTa9ge2q1apo/aMInOuXmuMPymH1its8sLjkmGNA0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=NBKvEbc7;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E722A606A88F;
	Wed, 18 Nov 2026 06:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E722A606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=NBKvEbc7
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 91F3440E01F4;
	Wed, 18 Nov 2026 06:20:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pZyBvReVByA5; Wed, 18 Nov 2026 06:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1794982808; bh=d0Ix9gsUTiEGaSow4N/1s7rVr2v9JLfaHj/KrE0P7Zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NBKvEbc7ww5HLcaDa8yEkHbGcQavmFhF9RDFE90Hx9/2upw1VyVgYvfn/I507BGU0
	 PbxtRSFWDC0UtKpBSMj1oB65n5bMHUWcQp+YZStM9XPOh4r3MoZzmkziwfX50GpY1k
	 Re1EuVpRtuoUJvraBOOzg8peiy0U5swvO3dcBVd6kBhlFkYhvDfTnSfomN1YGjkwGA
	 6unVrhIKR1BEg1C5cx/StX109B2IAafnr4M+/Nu4x+kDebFn33DmDkkf9NaK2c66B+
	 0KCxACO59mE9X0ALaiB6Tnleu5HHNh5PUs6n4lyZHePeVpG1jUXA6ok2vDqujbvzzF
	 MJl4xRoMGcpnH/zXrmUnbBt2xY7OyXXr1k3lr3C+kKkDbO0UhdymRIXr05MHGsUzsx
	 Ykm123i38hSuvUGpLftPQ7bSbFY1LwEyg2Yy6XZd65DJTOFVy+sl029/P3H1h13Ge0
	 4ckmRMBt6/QY3G+RBBGww9qNRrwKbNZQmtb/fKc8VAg5rqw3JGhOAnVz86iVZMK43u
	 QJY41JDzL7xAvashOUlUx33HPbpvpWGWqxIuFALwssg4IYdH3OeJgSdhjIC+tnMRvu
	 /hPqSUyLoiYmW3ZMnbHtCtuKY/xBNnK9/7+Oj7pQ4v6ZLhZhgvZVVktYGoskTV4K+3
	 gE9ccUfotjkSc1GlRyapojt0=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6028940E00C2;
	Wed, 18 Nov 2026 06:19:59 +0000 (UTC)
Date: Tue, 17 Nov 2026 22:19:55 -0800
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
Message-ID: <20261118061955.GHav1DixS9NvbUqprl@fat_crate.local>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
 <20261116152403.2672-7-ilpo.jarvinen@linux.intel.com>
 <20261116154005.GAavsj1a11BRgBVtSd@fat_crate.local>
 <CH8PR11MB403433B2B6C13E8AA2A31130FAFC7C2@CH8PR11MB403433.namprd11.prod.outlook.com>
 <20261117195455.GEavyxDycsQbYSctQr@fat_crate.local>
 <CH8PR11MB403433E7312691DB4FBC415F2FFC7B2@CH8PR11MB403433.namprd11.prod.outlook.com>
 <20261118004606.GGavz1TttiWqFI9saC@fat_crate.local>
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
In-Reply-To: <20261118004606.GGavz1TttiWqFI9saC@fat_crate.local>

On Tue, Nov 17, 2026 at 04:46:06PM -0800, Borislav Petkov wrote:
> Thanks, lemme push it out.

Completely fat-fingered it on the wrong tree and missed a couple of more
orphaned ones. Below is the updated version. I've kept your Acked-by because
the patch idea is basically unchanged.

Thx.

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
Acked-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20261116152403.2672-7-ilpo.jarvinen@linux.intel.com
---
 MAINTAINERS | 46 ++++++++++------------------------------------
 1 file changed, 10 insertions(+), 36 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12406a2f4d57..4b930d531214 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2152,11 +2152,6 @@ M:	Khuong Dinh <khuong@os.amperecomputing.com>
 S:	Supported
 F:	arch/arm64/boot/dts/apm/
 
-APPLIED MICRO (APM) X-GENE SOC EDAC
-S:	Orphan
-F:	Documentation/devicetree/bindings/edac/apm,xgene-edac.yaml
-F:	drivers/edac/xgene_edac.c
-
 APPLIED MICRO (APM) X-GENE SOC ETHERNET (V2) DRIVER
 M:	Iyappan Subramanian <iyappan@os.amperecomputing.com>
 M:	Keyur Chudgar <keyur@os.amperecomputing.com>
@@ -9631,11 +9626,6 @@ L:	linux-mips@vger.kernel.org
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
@@ -9659,11 +9649,6 @@ L:	linux-edac@vger.kernel.org
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
@@ -9688,16 +9673,6 @@ L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/i10nm_base.c
 
-EDAC-I3000
-L:	linux-edac@vger.kernel.org
-S:	Orphan
-F:	drivers/edac/i3000_edac.c
-
-EDAC-I3200
-L:	linux-edac@vger.kernel.org
-S:	Orphan
-F:	drivers/edac/i3200_edac.c
-
 EDAC-I5000
 R:	Andrew Luebke <andrew.luebke@gmail.com>
 L:	linux-edac@vger.kernel.org
@@ -9722,11 +9697,6 @@ L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/i7core_edac.c
 
-EDAC-I82975X
-L:	linux-edac@vger.kernel.org
-S:	Orphan
-F:	drivers/edac/i82975x_edac.c
-
 EDAC-IE31200
 M:	Jason Baron <jbaron@akamai.com>
 L:	linux-edac@vger.kernel.org
@@ -9746,11 +9716,6 @@ L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/intel-bff.c
 
-EDAC-MPC85XX
-L:	linux-edac@vger.kernel.org
-S:	Orphan
-F:	drivers/edac/mpc85xx_edac.[ch]
-
 EDAC-NPCM
 M:	Marvin Lin <kflin@nuvoton.com>
 M:	Stanley Chu <yschu@nuvoton.com>
@@ -9797,10 +9762,19 @@ L:	linux-edac@vger.kernel.org
 S:	Odd Fixes
 F:	drivers/edac/ti_edac.c
 
-EDAC-X38
+EDAC ORPHANED DRIVERS
 L:	linux-edac@vger.kernel.org
 S:	Orphan
+F:	Documentation/devicetree/bindings/edac/apm,xgene-edac.yaml
+F:	drivers/edac/e752x_edac.c
+F:	drivers/edac/i3000_edac.c
+F:	drivers/edac/i3200_edac.c
+F:	drivers/edac/i82875p_edac.c
+F:	drivers/edac/i82975x_edac.c
+F:	drivers/edac/mpc85xx_edac.[ch]
+F:	drivers/edac/thunderx_edac*
 F:	drivers/edac/x38_edac.c
+F:	drivers/edac/xgene_edac.c
 
 EDIROL UA-101/UA-1000 DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
-- 
2.53.0


> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
