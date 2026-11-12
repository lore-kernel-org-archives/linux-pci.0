Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451681;
	b=fF+dv7Sh88E/bWGkcYhG+UsrEZNOLPvB8zIvLYzldvisUNrKYZsioX/RxWPinX0TBrRX
	 Cgwunulw5ZwBNoUc+PKUY+O2FpZIE5enHsLU6iVRTrrc/or99gvTNvjOYl9UdR69tH54L
	 UsVeSduAfthaXwCMXx5MTWehsHScjGoyGFwyWvaVb25NbFPsAS63Z6EfRVmWdKmJdVOWh
	 j9UaMjorCGtjsBoQIAbVvHUDTEx411aCZxuZrc5DAJZMBnj1PTItLPHKTt5yWSh/jJaF5
	 RVOmh6qcCFyVHxrKSE0tEddSt8BhKU0qnkN7srm4afr5fyWRet0EMBy03D4SwWNxG4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451681;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 DKIM-Signature;
	bh=SAnMJXnsGTVFs+L4yC+ado/6PoTBthhdNN93Z0JTh+0=;
	b=l0ZiZYbP53C1YfZ9AUmZiPtMZZpHa3vloRjvKShrJ0XplZlbu/2tKn05zTeh3PNGXtNO
	 VbrEjkf+duc/IjGEFvZtHwL1X0de3QtQKx8LELYpuDVrfYam/AsH2f5Uf9PNN0gxLur4P
	 WD++bjdijcUboGKt98fLRdL3U1H0tBFFyPilC52uBdqIaGj0V/2MojroGDbTEAua6/Zq7
	 4GHcizXwRogvA7vKH0cCDRgaKsbvHKvv1VAwmriT4pyJ9VbxFqwz39yPF3XVsB/SUxbVf
	 rrJrE1wVjmwWDv8DC6YVSRRdAiq1BLaKKdXY3Xe9JXto2R6WL4c+A2BacjWVaupWHLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b="jE/4fnzx";
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id AF57A606A321;
	Thu, 12 Nov 2026 02:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF57A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=jE/4fnzx
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.3.11
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Bjorn Helgaas <bhelgaas@google.com>, Niklas Schnelle
	<schnelle@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, "Manivannan
 Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>, Frank Li
	<Frank.Li@nxp.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogWz8/Pz9dIFJlOiBbUEFUQ0hdIFBDSTogU2F2ZSB0aGUgUm9vdCBQ?=
 =?gb2312?Q?ort_state_before_a_platform-specific_reset?=
Thread-Topic: [????] Re: [PATCH] PCI: Save the Root Port state before a
 platform-specific reset
Thread-Index: AQHdcNUXSwuHXgAo90mXRYzcPov+C7cmkUEAgAMtHBA=
Date: Thu, 12 Nov 2026 02:47:53 +0000
Message-ID: <6ed5af149550457d9ac17b4f6067536d@baidu.com>
References: <20261110053348.2419-1-lirongqing@baidu.com>
 <20261110053348.2419-2-lirongqing@baidu.com> <avLu7sdyMGhig7_5@wunner.de>
In-Reply-To: <avLu7sdyMGhig7_5@wunner.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1794451676;
	bh=SAnMJXnsGTVFs+L4yC+ado/6PoTBthhdNN93Z0JTh+0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=jE/4fnzxBohm7yaK/HttJkGC4p5DINItLi+ob8Ubmh4iDTnuwVgjRvywQipGDpb7J
	 ELYWLLlNtKa5Nku/7nnCL8/Afg7ol5vqL3/Wvl4sRLSnGN4McjOXUt35swLEXfucGZ
	 SyFA1uVRP21yDyA8wT2dv6bjeI4t1wtNJMo03O+FGuIlwdgmZ/Ky8/LejA2PoBTy45
	 QvyjTOcLGtFrSDfP81oL6Mp7Fy1sIFzOnmW2+lV4jg8QwyS5jjrcArboySB1ryde11
	 DI4aK3phshlfxgKG0XETtF7Yi721uQ4UM67uqcSpm6F5e+M+/feC41YM7kqj5eDWKP
	 LVtPWarfJnEkg==

PiBUaGUgc3RhdGUgaXMgc2F2ZWQgb24gZW51bWVyYXRpb24gaW4gcGNpX2J1c19hZGRfZGV2aWNl
KCksIHNlZSBjb21taXQNCj4gYTJmMWUyMjM5MGFjLiAgUGxlYXNlIGV4cGxhaW4gd2h5IHRoYXQg
aXMgbm90IHN1ZmZpY2llbnQgZm9yIHlvdS4NCj4gDQpJdCBpcyBzdWZmaWNpZW50LiBJIGhhZCBt
aXNzZWQgdGhhdCBhMmYxZTIyMzkwYWMga2VlcHMgdGhlIHN0YXRlIHNhdmVkDQphdCBlbnVtZXJh
dGlvbiByZXVzYWJsZSBhbmQgdGhhdCBwY2lfcmVzdG9yZV9zdGF0ZSgpIG5vIGxvbmdlciBkZXBl
bmRzDQpvbiBhIGZyZXNoIHNhdmUuIFBsZWFzZSBkaXNyZWdhcmQgdGhpcyBwYXRjaC4gU29ycnkg
Zm9yIHRoZSBub2lzZS4NCnRoYW5rcw0KDQpbTGksUm9uZ3FpbmddIA0KDQoNCg==
