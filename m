Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64884A2A4A
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529578; cv=none; b=SJ59F6n6e/jIR/UkRw6yIUYDhfyt5gTnksaGKdiEyE/6M32+8rRh4CiUEpKaEtqTyam8udpiXJ5YWiM9IA1A4+xSUxSiFXJ8jCXfqYEaJ3TwM35c8L6Mj6nwMvloQ+5A6t5TZuXMA/tUHFOd2X2ETaWVBTj2KrSIOdZmblZwJwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529578; c=relaxed/simple;
	bh=qyD4bGNfcFSzPNaLFl2vhb3CFKp/crvP/9Jaao9JAyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBZGJLR1yB3u2xxPKMYLpShjOFIEBaS/H175LR8U3cFtFc/1kie1gxIVBfU8PxT6FlfwmgIwUXekntofen4g85nXxnhaJ2sOSpk8GycKex+wUpxcMqCatXof0Mgrjy7rCup12o7TgUeTgAPPRTowAKbTv0gqabm06F/LzyQrdRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=DK0H3ENh; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="DK0H3ENh"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-529a1ee0e62so13511451cf.2
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 06:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788529575; x=1789134375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iAwqufnwuKEV24w71YGykBZDHshBllwrVOx0ky+yHTQ=;
        b=DK0H3ENh98CWzmnIXzijn6sJ2jQjxAY+E1n+HO+SSMMbr0kgljjb0FRr5UTKghzdCR
         um6tA0pcevfnV054cMjT9n9B7GsixdFl5gdHHZpUJXEG46XwXj4y40MgwZngrYfSm+6Q
         eVDT4fxr/ot4bRDwd+ucMXK9Na/zujsUkl4hYIlYiSYF/pW1UfILn9MI4O4cXJMDQJmk
         W95aptIIPyk2aLfiSf37peeQzF1cm79FwydlcrELrBYpV+locayjGI+MeJuRj/ASVZBu
         XLt+yY/3Yhxk4e+2DOPvkcos/a2VZXp1G6FYbPglSI5ZZx+P0UF0WmmJ8+VQ5bm9867W
         u+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788529575; x=1789134375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iAwqufnwuKEV24w71YGykBZDHshBllwrVOx0ky+yHTQ=;
        b=KUkbmpz5oxB0hCAoc11rf67TVK2iDgJvs2bGeP1qkJUS7EkEyC2PoPvvyDtg0NixUB
         VZgUDC8AVnxRHV20IgGQXRYL0OBdv2Pkr/UR7o+54M8K0GyLpvceaxu2fR7qbZGCPAQR
         f2oJv3xXLnyNNVgzNjx+ciIsiuKf3B/l9z0LPtG6yarmS0brHUpkNvgEKR/+aRWj7aqy
         Meh28mBIaVI1x4TBH77Kz9BfGw7hCbCOaELdU/GMM8vVhPHsVBKgtMFg7wTMGZO3+fN+
         D7Jdsrs7Y5e3676M6gzXv+r8XILn8ZR/LJOFtC1K0A33/9DA3Pzc+ZclTn2nR8gMlWuv
         VMSA==
X-Forwarded-Encrypted: i=1; AKwUvByAKwxOcsipp7xdt0dtOKXEV2PUGVrVXqplTQiZtCSS2V5T7HuDG7XZMDGmTQLnWQaWxN99rm5qhW4=@vger.kernel.org
X-Gm-Message-State: AFuF++kNi0tce1Nw5I/7k6k+plGj3V6hlRWdxPTTMiJpX8ETOl0gM0RY
	LWq4L22Rusdg4zzKpC7iH5dSO1c041vy2FjyqRuxQAtlTilfg20ygLYZEDyzAN82g9U=
X-Gm-Gg: AYBFou3p/JToq0bNtJCYf5s3zQzHWb8Fss2qv55rsxSuf7Qxi1+m84Y7dVCpfjuAK0k
	cHv3usCsQNs3/xi/+Vyy1HeigKYgwQhZlYz3ZgPXrZgfNWA3w/5nCfkHDo+6K4fyBDQshQazhFI
	QxkmSdnqMMWiIaW9UK+PV8KmfKF9SzFsY1q01HvlyO+HrcnC5S3y/1R2XQyA3bCcdGzcJCkjMJo
	fvgHvg56z/+JVOtwHlBDlU0uHl2XlvA7SUgqMCV5pUVcdvjCK3RpsxJkK0I5OTa8mbV8HzkCEOX
	lqY4zSn3wXiL/300K6jA/D91eKhauEemt8HV87Evg0zMS4i285ZHmYn65IG9XCINBK2QjpBNNpB
	irvDqGbfTBUQG5zDn2uY7dHGD76k6hukspi7SG2B72j5v2KTNzeUx7mOtuiBQRWPIrc7Hok4rpY
	tizJ+utekR+wg4UwdQQoJU5EHl+dnOlM2nvmKlItvX/s3zjBZpwbrpzpkwCTUIolGA
X-Received: by 2002:a05:620a:a518:b0:92e:7d53:8e8d with SMTP id af79cd13be357-93980434f3fmr510380985a.27.1788529574458;
        Fri, 04 Sep 2026 06:46:14 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fafc3a7sm211613885a.14.2026.09.04.06.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 06:46:14 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com,
	robh@kernel.org,
	saravanak@kernel.org
Cc: herve.codina@bootlin.com,
	daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] PCI: of: don't zero flags in of_pci_get_addr_flags()
Date: Fri,  4 Sep 2026 08:46:05 -0500
Message-ID: <20260904134607.1856121-4-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904134607.1856121-1-elder@riscstar.com>
References: <20260904134607.1856121-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flags variable whose address is passed to of_pci_get_addr_flags()
is zeroed before assigning a value to it.  Skip the zeroing and just
assign it instead.

Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/pci/of_property.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 8131aa1b0b3c4..fca522f70187a 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -82,12 +82,10 @@ static int of_pci_get_addr_flags(const struct resource *res, u32 *flags)
 	else
 		return -EINVAL;
 
-	*flags = 0;
+	*flags = FIELD_PREP(OF_PCI_ADDR_FIELD_SS, ss);
 	if (res->flags & IORESOURCE_PREFETCH)
 		*flags |= OF_PCI_ADDR_FIELD_PREFETCH;
 
-	*flags |= FIELD_PREP(OF_PCI_ADDR_FIELD_SS, ss);
-
 	return 0;
 }
 
-- 
2.53.0

