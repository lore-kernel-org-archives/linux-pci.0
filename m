Received: from aer-iport-6.cisco.com (aer-iport-6.cisco.com [173.38.203.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FCC378D98;
	Wed, 18 Mar 2026 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773830199; cv=none; b=Nn4zcx9MA3gsYlEBBWXEV4dVBq8ZKh+stY7FtTjjdYn4M35KQWs84PrGndLd6uLY1yDbkAl5dal3SFz44kLRWkeXHvOO8mEu36hCllCVGZQ1LqzvfmfbY/Ecu0Pw+XrUgrvn9Hf6lcmLpV8OqC03GuueqzHoKepjpgKKmUzXrUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773830199; c=relaxed/simple;
	bh=0weZ47fEKHg2TrOYKTAyrdg/IBGjHNvUiZE7lApFou8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKXMxyHQBROtJlqJrY61BKj/h1CUiFi7SbpiF2g0GPUwrGrrexzr9tfIYCGXai/1LhtWOVEmckxI03B4JdHYN8sJ0zo2DBBaOKwsrMHhQJm2y+X/Wph+bbl22aL4eibhbP5uQp+jjh7ODdYnjRz1QYoagcxg/WiGjvPCO+1NAWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=FCObWw9k; arc=none smtp.client-ip=173.38.203.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="FCObWw9k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=966; q=dns/txt;
  s=iport01; t=1773830197; x=1775039797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xdmNlMjM0v6+f4HcbG4T+PiVmG68ay8uHll5dAtuqJ8=;
  b=FCObWw9k9MuPxtKqOLmJHIMHjyD84n+7aGLgwjOD7Yk2LIB654r8yhch
   MWrRXH9N9+TltYcXhEX2TGszFPiNdLNHsEdD+XQTP5tp/PXR7byaam8wF
   uThXsJrn7kncksD+U3G0Iu0XJJB8/++T0um8krZXtGlmglfZ80Nvg62sy
   KpQt/7lMCJLyAapYjNKmiwGu5cPctaF54UdgwVY6R6hGPtsVhkt4b+4od
   W+K6gZguADNWGKmLngS3/5HyjENsnHF+JiUvqLQELwisMxCYhQcgdEfvq
   wYN2alg43/LTxALfy6tGEVM6w1ow4B5xw2zu+HdYzyF3CTY3ptKyz3yvD
   w==;
X-CSE-ConnectionGUID: 7z21ndVIQpyyBRu6zVx97A==
X-CSE-MsgGUID: 27n1rTWgQemyWeM5gUvPGA==
X-IPAS-Result: =?us-ascii?q?A0ATEQB2frpp/8xK/pBaglmCSIEAX0KFIJF3nhqBfw8BA?=
 =?us-ascii?q?QEPUQQBAYUHAo0iAiY1CA4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBA?=
 =?us-ascii?q?gEHBYEOE4ZchlsBAQEDIw8BRhALGAICJgICVhGDCgGCcwO0QXqBMoEBhHzZQ?=
 =?us-ascii?q?oFqBhWBCi6IVAGFAIVuJxUGfYEQhD8+hRCDDoJpBIIigQ6IP4o9SAp4HANZL?=
 =?us-ascii?q?AFVEw0KCwcFgSNDAzUSKhUjSwUtHYEjIR0XFB9YGwcFEiEqgSKCAQ+GZXkDL?=
 =?us-ascii?q?l4aDiICKBFcSj4LUgWCLAKBBwMLGA1IESw3FBsEPQFuB5AsdlaBGKcFoRGEJ?=
 =?us-ascii?q?qFYGjOEBI0TmVQuh1wvkE2kWYRogWoCOIFZTSMVgyNRGQ/XbztyAgcCBw0DC?=
 =?us-ascii?q?5NlAQE?=
IronPort-Data: A9a23:rXYbwKhk8YAqoXgfhG0n0J3jX161EBEKZh0ujC45NGQN5FlHY01je
 htvUTiOP67YNGr0ct5zbt6/8hlQuMKGnYJnQVdorSs1QX9jpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOOn9SUgvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZeEULOZ82QsaDxMsPvT8EoHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqVH6LwuB21w1
 MUAOSEnVA3dldymke2SH7wEasQLdKEHPasWt2slyXTSCuwrBMiYBa7L/tRfmjw3g6iiH96HO
 5ZfM2czKkucJUcXZj/7C7pm9AusrnDzcixVrl2cjaE2+GPUigd21dABNfKII4DWHZoKwy50o
 EqcoGKgGC0lO+WSzCu6/1fxidLRpQzSDdd6+LqQs6QCbEeo7mYTBRkZXFKgifa+jUG6VpRUL
 El80i4vq7UisU+mVN/wWzWmr3Oe+B0RQdxdF6s98g7l4q7V5RuJQ3APTxZfZ9E88sw7Xzon0
 hmOhdyBONB0mLSYUzeZs7yTtz73YXNTJm4ZbihCRgwAizX+nLwOYtv0Zo4LOMaIYhfdQFkcH
 xjiQPACuogu
IronPort-HdrOrdr: A9a23:FI2LB61Nyjty+W+CeZ4wzwqjBIkkLtp133Aq2lEZdPWaSKClfq
 eV7ZMmPH7P+VIssR4b9+xoVJPrfZqYz+8X3WBzB8bGYOCZggqVxehZhOOI/9SjIVydygc378
 hdmsZFZeEYdWIbsS4/izPIaurJB7K8gcaVuds=
X-Talos-CUID: =?us-ascii?q?9a23=3AItBtDGh/0WtuoboNNoh8FPc4VTJuLW+HlXHcHW6?=
 =?us-ascii?q?BEXd4YoeIF02u6PI7up87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AMZ30tAzIm3fRmJehZTUR63lSSnOaqP7xDhkXrao?=
 =?us-ascii?q?JgsSBJBN9HmqSsSqPbaZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,127,1770595200"; 
   d="scan'208";a="51440775"
Received: from aer-l-core-03.cisco.com ([144.254.74.204])
  by aer-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Mar 2026 10:35:26 +0000
Received: from bgl-ads-6462.cisco.com (bgl-ads-6462.cisco.com [173.39.34.78])
	by aer-l-core-03.cisco.com (Postfix) with ESMTP id E2531180006F3;
	Wed, 18 Mar 2026 10:35:24 +0000 (GMT)
From: Aadityarangan Shridhar Iyengar <adiyenga@cisco.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	adiyenga@cisco.com
Subject: Re: [PATCH] PCI/AER: Fix device reference leak in aer_inject()
Date: Wed, 18 Mar 2026 16:05:24 +0530
Message-Id: <20260318103524.49023-1-adiyenga@cisco.com>
X-Mailer: git-send-email 2.35.6
In-Reply-To: <20260317172732.58053-1-adiyenga@cisco.com>
References: <20260317172732.58053-1-adiyenga@cisco.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 173.39.34.78, bgl-ads-6462.cisco.com
X-Outbound-Node: aer-l-core-03.cisco.com

On Mon, Mar 17, 2026 at 09:17:00PM +0000, Bjorn Helgaas wrote:
> From AI
> (https://sashiko.dev/#/patchset/20260317172732.58053-1-adiyenga%40cisco.com):
> 
>   Is this description accurate? Looking at pcie_port_find_device(), it
>   uses device_for_each_child() with the find_service_iter() callback.
>   Unlike device_find_child(), neither of these functions calls
>   get_device() on the matched child device to increment its reference
>   count.

You're right, the description is inaccurate. I confused
device_for_each_child() with device_find_child(). The latter explicitly
calls get_device() on the matched child and documents that the caller
must call put_device(), but device_for_each_child() does not — the
iterator ref is dropped by klist_iter_exit() and no caller-owned
reference is returned.

Adding put_device() here would underflow the refcount, which is worse
than the original code.

Please drop this patch. Sorry for the noise.

Aditya
