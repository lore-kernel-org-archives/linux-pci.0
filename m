Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E7B34B437
	for <linux-pci@vger.kernel.org>; Thu,  2 Apr 2026 22:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775168260; cv=none; b=cdjsBNzWF77qahujsWA/k8h1qnUNcBYXumMisWc1oD29KyzfgzhHeM5LtramMfKdUdLP8Ic2HrlQjw2uYWbs74lnEK1sC5bsXMcXzWJW33PkWaaRWfUch42zYI1gZk01soP1YCrZJqSZifFHqWhlezyujTcE4mxT+c5WO/L43Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775168260; c=relaxed/simple;
	bh=Gh/vEJU0EGlJkxcWfGReC2v+Rr4CHg9KxV1K21dLdvI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gCX2N4x2wYz4Qo6KDz7VBwr2KcKi3U78UupQMn3KytDI0nQbi7/PuZGoUz2nltRisy0X/IbI1jVVXdD3z45LQINcOUNlwZbW5i1iFiTYWnGEBJnjVdwjsTUrnnlL8rLyGqo2ZfxkC3TDdRii6g0BfViKtMyoCcX6xeoMOmXAOA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDE2h4op; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDE2h4op"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso18657795e9.1
        for <linux-pci@vger.kernel.org>; Thu, 02 Apr 2026 15:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775168257; x=1775773057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZvfE5Xh6joR2Ps2HxBC4h/f1h6TIhRJYVGLkpiemiQI=;
        b=jDE2h4opXDIq+xmxiTtl5AORWOMoBfNl06v185XXs0hEwWe1ouaYC8Jk0/XECSesha
         d6waRQlDlQndm3OUDRNoiPYRMWnDKrR0XvNzuI1WpA7OHky/uFQak25TNYvLrcvOKvHp
         WHzNnKoKV7C+Fahr05KrpDX251hDzZccmaenkqa5En8h6uV5eSH7a3h/HjnEjpVOOQ4L
         j9he9aHsXq0H/YJPOkHcxgSgwKtiCU61uRtajkAoVrmOwT2Uv+Hhu0nGtKlTKa5lNogG
         4uiOKPeLD2ZrNtv/QEEGj7F7X9WJW+Zt43ri/rejxOqJnULGnaHRLzP7sFiF7GdmzGKu
         vsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775168257; x=1775773057;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvfE5Xh6joR2Ps2HxBC4h/f1h6TIhRJYVGLkpiemiQI=;
        b=HdmLwC27QTyD8mu2tply5+D3HihA2/IOBb7Ije0QJ6pTOAkYh3aix3WAqEVbHBDbX/
         0Zc1yioMfLCmSD5o/gnpFKG9v7yeVAiBJngJvp8rowqPwQKzzMFXGCKLsYUNOFF0R2Ca
         Z1QQrLeX0qfWMW9lsrGWMa1UyFrwg0LXCja5MjPLIOVJlnWuv8/Fp8yOzCz4xA92EGBi
         Y/rVnJkl0QjR9OijHLCVOqD7maO4KpmOHL52eD99vkNUTpUYo4IvIDsMipHIuqs/LiQr
         zomUMJ97IGRwtIoxfEEeCJo/PoRSZTCQ/U0oIsHeI1fpm8PuYTcflrrRuWOElGnj1XRK
         bk8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTTTPGMtqeanhEryPwj4g/EzDn3iQ8RUkqB2UX/6eB5pHqAYDfaAJwTTD/kTTKiaz2eYoQUUcbw1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzY+BO3OTJXgXES88WOHZiX00ulfPVq3DsPKWEoch5O8WHAeA5
	PGps95XcgCGi4Yvwxx/Czy7dBppJlIvJecrAYGL1rmq8W83H0+7XUuTCFuIYig==
X-Gm-Gg: ATEYQzyRc4SAgUm/kR5GjebbiulhJp7A5BjgA/IL7684h0FwDvGPadfogtnJ6Xoa6uf
	n3jNZEYcrUAcJdEN4p5IKAFmqbcZLR/Brdlo1cxNcXuIEbg9R2m31D26Lker9k3iXoICuo5o2OH
	dCXwuRdxM/X5kqnaqaCmuhtKUUHo1+BEygpOivWu35tO8X4SSM+0DXTK8bAd4KbRpBZ4A8WTdr0
	w9ASwsaEKrB04Fu/276iy7C4MYfYwb+OdK29+gznmHsa6CLIEB1zbv7147v/7t7ZaQpsd3xx9Q7
	AunPqqUIbQFQjD9a5R5lSkUHXf9VhTasW9m0zXzSRbSmBSVamqlqb4389f4XlwPZOfn/Vhh/5Fj
	2DaGL25C7HS+c9gca6bn64ArNc/3oMIK1i5/6VsXq3+vkioc0T8akL+jRzDAJJqkib/6atURfKz
	X28wiDlSFdfZV+NzvyKZxZ4Pf3GTt3v665k6Hy9O0hgPuwdvjaRMCGIGsCqvDwfWXH12OYNRV/J
	gcUVIOPP8bt7pzlLcTTe86iyY8nxUMpvUiPNgl6EfqYkto87eF9n02W0OvMn5iIhA==
X-Received: by 2002:a05:600c:4743:b0:487:36c:f5ab with SMTP id 5b1f17b1804b1-488996ff833mr10662365e9.10.1775168257032;
        Thu, 02 Apr 2026 15:17:37 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f19:9500:c168:ad27:2fdd:9334? (p200300ea8f199500c168ad272fdd9334.dip0.t-ipconnect.de. [2003:ea:8f19:9500:c168:ad27:2fdd:9334])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a616sm363895755e9.2.2026.04.02.15.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 15:17:36 -0700 (PDT)
Message-ID: <cf519463-775a-4d43-be38-20742fdad407@gmail.com>
Date: Fri, 3 Apr 2026 00:17:35 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] input: pc110pad: change PCI check to get rid of orphaned
 no_pci_devices
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <dd9ea7c1-44f5-4364-a3d5-885b1c99159f@gmail.com>
Content-Language: en-US
In-Reply-To: <dd9ea7c1-44f5-4364-a3d5-885b1c99159f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

As a prerequisite for removing no_pci_devices(), replace its usage here
with an equivalent check for presence of a PCI bus.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/input/mouse/pc110pad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/pc110pad.c b/drivers/input/mouse/pc110pad.c
index efa58049f..c7a6df210 100644
--- a/drivers/input/mouse/pc110pad.c
+++ b/drivers/input/mouse/pc110pad.c
@@ -91,7 +91,7 @@ static int __init pc110pad_init(void)
 {
 	int err;
 
-	if (!no_pci_devices())
+	if (pci_find_next_bus(NULL))
 		return -ENODEV;
 
 	if (!request_region(pc110pad_io, 4, "pc110pad")) {
-- 
2.53.0


