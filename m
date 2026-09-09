Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF07C584949
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965921; cv=none; b=S/p0uy+DLqdtWgnP0tD8Pf8HqM21wdtGR1VPI6jXPmJwczLUmtqdEpbLuWDa8FKz80KAjKrbSBIVqil+B/Jk6mBxlhETLDX3lydI/nZ266/QRb6vIAMxWRxVRwBfm7wYGIKlEpXCf93FE/ZH39vyV2pSLr2oY/+awde4Rmg8DFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965921; c=relaxed/simple;
	bh=OG8rM47+wQa5telCcXnv0ivoaCzuHrNel/g8JAXQwo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Upu1MT1gVI2Bu2lTbCZwnqAIQ8FtX+Rm51uNqjLUBi1WnQdScasiLr9XT7BvwQuASgbJ9aOqSxWxXOYKHNd6+wDXSRA7RPYo4Mtfh3CP67gA4AovpnPdmxVSYTqHjCKIMms8Iu1NSYoD/L/P3Y+g3Xka18rDSgf7u2tXAyZHuwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcrX/Osr; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcrX/Osr"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso4168905e9.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788965917; x=1789570717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OG8rM47+wQa5telCcXnv0ivoaCzuHrNel/g8JAXQwo0=;
        b=gcrX/Osr7jULvPpbVsiR/YE9EUyFW21uf4qekP/mL8NCiWrT1G2PD6OTMxmnXIrSka
         zqfBu5VH68FGtu7lDQVTDlvArzM+4iBhQ5nocWDOLp7d4KKrDA67U+PjVqCsFPgU+7DZ
         ZKE0IKelzKPx5DmCzVdVlSMBGfvaT2ywShlnxBvYgzaZiNssuHexjXI5QPVZDugjDpac
         hYRskKl/Htp256c7oZMUlEvnNlloEPSRqZbz0N7Ja+UgV7SxwsaK9XS9g/kRKaacRT5h
         nJmuTTSDM15tsAc2Yk+K1Vy8KAtovzExAWL1uYxt4Vms3KMrckO0QgYfPM4ni+OzpLVc
         8VNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965917; x=1789570717;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OG8rM47+wQa5telCcXnv0ivoaCzuHrNel/g8JAXQwo0=;
        b=gyhScUhM2sXfOvIwtoD9aO3lN8SZ7pyzYJNhqG+eETWgRjIDCob6UFjmY0AnL0NkKl
         9J0wfW72FNOwv9wLPjpKh7vd41PMmtwRLZ3igLbFoSUxDLW1xeb5gxGxazQqBLQ3ZQQC
         XT/xhWSba1X7wK1vdOQqKELrs29YZa11R03ITO0+Ak/Up4CorKdUIKn95vq76bLmKQba
         bY4BFMTq40Duddt4OWGr4Vy80r74LIXU2Wzq7nAIGBDmIaUqw6+3qxbBVcZLyLjl3lQp
         3w/5KvjfEWRNOQULqN/iZDuSmqWmSQjuZe37xD2UUQ3W0L2DTRxDoxOZS2wQyCvHHI9w
         lU/A==
X-Forwarded-Encrypted: i=1; AKwUvByLFAkK8q+b/0MZwcKcikt8mcBvh3ZPzzRi8kg7TbmObtzx80QFL79/eWPy4dpxGIB4+x/yKGt4PGs=@vger.kernel.org
X-Gm-Message-State: AFuF++n16BD6paeldk90rUE3yEJi6FsS0H8ZzTjV7KHakG98VUQsen/I
	pP3s5uc8ejGSq025LSscCe0FT6qfD59/Dc4i+dvXVcrNd4S8jRsX9/2N
X-Gm-Gg: AYBFou3c4NThQceQ0vUjjhmFcE553EQ/gQ/wj18a+Yd7PnTaQFVClw8Ljb6rVljNj5p
	0EOOeAGlAP3X5Xc66rlJy+dy6HPTswoy9hclHfPdEEUwwMHhryOG84tX4FUwFx4ntT6FI4OIGcQ
	5ea/4U9IymD7Ou4KANE0r+Xqd5PHlfa79hw6jr5IiAf09PKWv2oSXug3b/piUxFjVqpE24pjZLZ
	i2++zMUGnBdVtkyIyaQkUe0NVg/SMt7oYWLVrDsIopndZKChJKeTzQT9jfnhTkI1BUktD40VTUB
	aW6Fg5fWeaKR5E5Qt6M7beE9LKMdacz8E5IS8w4vjLfszvWQSE92cFcmnXYnmT8jWyC4PJ57qqn
	P0HDmPBMWc9AWYJsUKjfbVvx5oiDXZnQwjdYZIiVtyfyO6xi7vZtK0YAvWWXODo7uoelhIGruBL
	uCuiDCJs67pxzTAgGEWNLSphkHhD8WsNFNYMo8NO00H81xBHGTRGMZXDWYM3U+1nRfl4tSiItYV
	coAnw==
X-Received: by 2002:a05:600c:8b88:b0:49c:f512:2361 with SMTP id 5b1f17b1804b1-49d2593842emr34218375e9.14.1788965916931;
        Wed, 09 Sep 2026 07:58:36 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d00a5b19dsm423987255e9.2.2026.09.09.07.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:58:36 -0700 (PDT)
Date: Wed, 9 Sep 2026 17:58:32 +0300
From: Dan Carpenter <error27@gmail.com>
To: Breno Rodrigues Alves <breno3011alves@gmail.com>
Cc: gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, arnd@arndb.de,
	linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v9 1/3] interconnect: mediatek: fix Makefile typo for
 mt8196
Message-ID: <aqF0GLDB5a-P-uvq@stanley.mountain>
References: <20260905130925.7115-1-breno3011alves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905130925.7115-1-breno3011alves@gmail.com>

What changed between versions?

staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter

