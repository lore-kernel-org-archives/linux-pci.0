Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7163FEB33
	for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774634347; cv=none; b=tSEJo/De+xY4wOHFhH5o5zjhqffyZ7nWQrxIwUrpX9STZ78sgoLhgEzxX2SSH9qZsxwUJ/QpaN3V3Mlr9GrvDS6H/njYsYJEcEWWEV1eJWUMgFmUTcQIQL/WjyTAkWikTDQ7A2Uzghnmvg3UpAWZPpmXf6kIVp1HUgZB+YpT55I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774634347; c=relaxed/simple;
	bh=QR7NFO1I9gA2J4q6XWdIg5wHFe02t3xldWwUsW+yLp8=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=A7Atda2OHboLpUzd3tG9V/7EqexPvzUu5RZcwJHiXFSR+X48wr1NaYZH8eNl3SWu8gXWt57z4lbODQNdLn2s096c1YNHwJtv6j3tM7vRDSdi+wnwyLzmRREjpOh/ItdhnOYeAlqvh8lKb431l0IFWAbqDTfWhdCHnPFDyOUiJqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=exq2DL9P; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="exq2DL9P"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1279eced0b9so3633822c88.0
        for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1774634345; x=1775239145; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLYLmy8VW9I5DLU1uXkxzY27rJilsjPQMGLpz2LRUCQ=;
        b=exq2DL9PPh52JU2TL8A8J9TDubySoGvG7WQRTeWkaKaeDXDLdnfSr8p9Z4EGDnUAtu
         +Z57o/pbHNRbCQ/fPs9uxf4q3HXNUqI43wxEnvtpHa4l8EQNyCaqNggl7qJjx1eq5K1B
         bbkPK7DHgk1iYqOPi8Ks/8YtU7u6RinD3mRYkdHOrdYi6/SBInQCrnfkYHbIbktb9ofN
         70miRfGvQtb4jVkvAH3bYNHVPwjBoWMBdK5WgSGKgfTffzWKP84FJAsmP+j6z2Z2AUNs
         60y4zqnjSOoowNgTBiV2UXQ++WLZEz+GQXRtyueZ2/6rcW2wuPabrtrxIf05pgAR6u6f
         HXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774634345; x=1775239145;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xLYLmy8VW9I5DLU1uXkxzY27rJilsjPQMGLpz2LRUCQ=;
        b=p19LKynKK/zUZD0JQ7sZr/3xIS+JYbdV91sKYwby8PqpjaAwUv1YPjt/KTRDZuT9Sr
         bVffjAOKNpU5n4KKCDrqgctNpGnVI8I3wszSmpzCqHu1yiFVP3/v1SCOusV8isIM8c4B
         KLgqkdhX1Y8AL3zLKZQlcZg+InjZYxFfYJQ7UBXvMMh4VPzrp+RkOdUu/UQ3ojgv2dyN
         iC+8MavcdqCggoMoQF44qFfkJE0G36Y5kMNYri818cVqjJM6zkSgF92U3Ctx2w6t8+j/
         177ZpYQGtIsT+Oru4Tfq0NpNVUM8t/l6XchgJP/4LQVjrBa/15iFpYTe9u+Z9mpeq3fS
         SnZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZvKjkO/0ywyqtzQVIsL1tp4TxzrcvGFfXqkeDYXTvidVWGNrUyTcyywxGKoJd1TlXjNMq75Oc+bM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwsM8xr9AWZIIXejOtXTb52XRaDUEweu+E2amFhFVEJVHvPp8X
	FXgQC/7FEZRXj4IsXT0xl6zx6EBix+Ytmi+wnJeqKyg2gC11bIKcKz8CRXe9R9paddeW7Ij7Lf9
	6H1Am
X-Gm-Gg: ATEYQzzQ4AXenK+G3uxlcOXMkskMrJj9HF72SD4IxRLaEl3IfZORTEYYhfcqhBlNMZ2
	RqCPb5gZ63sBVSrnwOAhqreCUmFkR+y3PJOwFTwGpVjy1uNxpv0zmQ5/4n46+qXinPM1dfIkvio
	8m0yfERiwS8zYEFCYR5+c/AhR+e24b0vhWy6ghbCjFd0KNknH52ZcJHpiridQM6SiX7oC8z0SH7
	jgj6BWRYC4thTPLFA9EpHW7oK3OavCXKSiGHDaCKXqGvqEXqNOMIpYJV+g3xlnr3B6Du3vOZb3d
	D11pNLoXuVwOaAHI/wYAMvynEVAGZYUClD3dH8jJXstp+9PKMhkHJXj16bqEhoqmBoNARYVUiXH
	hBv9V/PbmxRHJc+AicDDdyPYEtRhYq0B13GkSg9qVL0fdPTTpILd4CTmm0Eu826vmxwn83zHlEI
	B1OtpH8xRaQSL2jqFe
X-Received: by 2002:a05:7022:b8a:b0:123:330b:3a0 with SMTP id a92af1059eb24-12ab28617bamr1964111c88.14.1774634344871;
        Fri, 27 Mar 2026 10:59:04 -0700 (PDT)
Received: from 0d12152ffbcd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aa6513e9bsm9937442c88.0.2026.03.27.10.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 10:59:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] linux-pci/next: (build) ignoring return value of
 function
 declared with 'warn_unused_resul...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, linux-pci@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 27 Mar 2026 17:59:03 -0000
Message-ID: <177463434349.1554.5266992356487229955@0d12152ffbcd>





Hello,

New build issue found on linux-pci/next:

---
 ignoring return value of function declared with 'warn_unused_result' attribute [-Werror,-Wunused-result] in drivers/gpu/drm/i915/display/intel_vga.o (drivers/gpu/drm/i915/display/intel_vga.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:c2145292d80ae85fd003068675e73a3d1f95c35e
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
- commit HEAD:  50451816531d66141cafe2347f9a896bd4dcb2b3


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
/tmp/kci/linux/drivers/gpu/drm/i915/display/intel_vga.c:68:2: error: ignoring return value of function declared with 'warn_unused_result' attribute [-Werror,-Wunused-result]
   68 |         vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
      |         ^~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/gpu/drm/i915/display/intel_vga.c:93:2: error: ignoring return value of function declared with 'warn_unused_result' attribute [-Werror,-Wunused-result]
   93 |         vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
      |         ^~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~
2 errors generated.

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:69c6b8d23712df3240c2a959


#kernelci issue maestro:c2145292d80ae85fd003068675e73a3d1f95c35e

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
