Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7903FF891
	for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774634348; cv=none; b=DuSR60jvl0KfvLkXYYmoPgQlIkArrTqyhP3NzEqZUerc8KrZmg2LUhOWxKZ2KCf4MMaKC6v31G4bGn0kZPtKtKQUWShXX6cYiZZGOQdqDESLlghiVrPYw6wJY25itZYC7EOHG8oUUsdnKncOFM5DhxfF6WBgpX/qwbT5qppvyCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774634348; c=relaxed/simple;
	bh=QGsxv5H/NWd91xLC3XoNMoQifaKuzPa3XS7eTxqHdDI=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=NcrZ2dCtfv0hcOF7oFS9n8bc7WtUN0DphTCRKz6xC2/4KjmHjWhyzNo34LYALIdJh9Mk2H8vECXG+VcjzA4We1evtlJ3w1wJ5P19zxUy7K8JYpU1KpCVOeglPDCQCLfhJFkShpneK7F7hQahh7JDAjiWD7Qw8XESuC+tlTya1TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=KSPzJLEe; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="KSPzJLEe"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12a747e7b2fso1402881c88.0
        for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1774634347; x=1775239147; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mVyvpqoXzAFCvXCE/U4aH2enwrFAzQr7+8ukqaPmJw=;
        b=KSPzJLEe3Wg5w1umdsJgFu9okGSH+44h1AZfcV4Yxw22lI17ShunXYCbABUyP65njV
         xn90osWjuXil0nJDY817WVBA6huYli9Szzx2ct8gGRoJ39hHPIkKqy4Scldxk+GDDOoB
         F4Rdp/HPz6BM/oOveHyCqFdnV1bWc8R2yWrb/rRjHELKkoxh1B5yLxPapL37ICdQRc5B
         t6ZcvR242fWSohFVAtSAmtfu5mVJ0Y81Dl8Vn27l1KCRO/LNAGkH/ytpa9vWG6e48NrI
         iMaaspJGOQNVkiT7dQCxYe5vM5o9dZrodlKcL5Se0dSAw3k4/xwc4Pzg+/vPH7MbDo32
         33Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774634347; x=1775239147;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3mVyvpqoXzAFCvXCE/U4aH2enwrFAzQr7+8ukqaPmJw=;
        b=b/td6rmI5l/9IA3Cpa+J//EsYekCBbNkH/NS5c0hYPYLGbdqlryIdPYZY4sZlbJ+vo
         XpL4ph7EPjWruwxrkVIhWDQRkQ3QzjAPQh/WISE0wPS95zk9UVA0kCVt6OrTbgCBP6tC
         qDg5wW8fcWo3Wcb1U3VdJjEU7zvKXzAzl6Ozvpb1luoMHYB0iBoB4M440Wdjf8LSw+Ow
         pYpitwGW/T5EV3x7+H0uwLFwll4sbPdVrFn1Xh2NfHH/cRtwPVWs6Q8dKIIvY6BSp+Dt
         L4txXPVNEk9OPJ2S3CvPNtEIX6st8YuZy77P3MmbyHz/j6JU2XnaSBoH93qf+FtZoHOb
         PteA==
X-Forwarded-Encrypted: i=1; AJvYcCV/ikgL/IdH7r7t2rHBHvs4pCrlRn2o3PkdIi/Wr75mFTGPSpHNtDl2MKbizrc92yABaD/JgAjEN+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSRkrxrQTxWwKGlP/ZaZzIR+EGTantmGlpdnYqSNjMGPVT1XIe
	VPedxQWxLWEuggI71yOFFcoUloARuc7hWqrSCODFiw9JZD1wUPMToK7TNWdjq4k7kns=
X-Gm-Gg: ATEYQzyV3SST3VT5xg/k+qt8TsKj2GbTsC7N2DG82W0kKl5Nsjr1kCvPKx6PgkHrCeO
	kQIYSIrl4hRSGVi8phFPFeaEyi957dWpa0VY4C06iuxRoPou+z7O2J/pCXQ6WjBk5cUq4bt1+Xd
	O3JDieIXOsqWAtwUIgeB56ejp+l+mCdZS9HaUI1SLVExhV4hVebGOUh3z4Ln0j4qj/DENsF0ju2
	tWAvEHQefBzrkmsWJ0FdOaiJ4eeEx4Pr4KvoxF4jQnmRk1hp7hf0SoQ4lPDx6hn3NXCWqYrSlWY
	FVPkHpBLRcXY+rWPVp28YtDsRaIlKqeLQUfu/R5UpSKFXWOEMYTPzPmG5ygLOkKXBDmT6/0X+Sv
	Ypje195GAbNTVCj2QyhDjZGJOgM2zzjgZOClMYsHj0lqKFnq78Skc8FIfrUY6i3kELnR/7j6E/R
	f7fDdGzeKSsND3yuFs
X-Received: by 2002:a05:7022:eacd:b0:124:9fd8:4ba9 with SMTP id a92af1059eb24-12ab28848c9mr2282854c88.12.1774634346578;
        Fri, 27 Mar 2026 10:59:06 -0700 (PDT)
Received: from 0d12152ffbcd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c46a0a84sm29762eec.9.2026.03.27.10.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 10:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_linux-pci/next=3A_=28build=29_ignoring_return_val?=
 =?utf-8?q?ue_of_=E2=80=98vga=5Fget=5Funinterruptible=E2=80=99_declared_with?=
 =?utf-8?q?_a=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, linux-pci@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 27 Mar 2026 17:59:05 -0000
Message-ID: <177463434509.1554.4896275539353552635@0d12152ffbcd>





Hello,

New build issue found on linux-pci/next:

---
 ignoring return value of ‘vga_get_uninterruptible’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result] in drivers/gpu/drm/i915/display/intel_vga.o (drivers/gpu/drm/i915/display/intel_vga.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:f670fdf443306495220d2cea8670ce85a80aed1e
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
- commit HEAD:  50451816531d66141cafe2347f9a896bd4dcb2b3


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
/tmp/kci/linux/drivers/gpu/drm/i915/display/intel_vga.c:68:9: error: ignoring return value of ‘vga_get_uninterruptible’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
   68 |         vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/gpu/drm/i915/display/intel_vga.c: In function ‘intel_vga_reset_io_mem’:
/tmp/kci/linux/drivers/gpu/drm/i915/display/intel_vga.c:93:9: error: ignoring return value of ‘vga_get_uninterruptible’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
   93 |         vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+kselftest on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:69c6b9023712df3240c2a985


#kernelci issue maestro:f670fdf443306495220d2cea8670ce85a80aed1e

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
