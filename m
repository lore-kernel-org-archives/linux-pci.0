Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D5E3644C3
	for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790305147; cv=none; b=jI7tyeDoRJxkQhWeVkyoLOuj0PMUa00ufXizCtMIGzexEn6SV+p+Snvb7uqfv7utVtbMo/gxtr2T8CMFLuCjzj7BirsC9mcatE0S/AWqEAOO3qmpdW/8PPRUc2tCHW6preOMqvD68Os3lTsqVzSooGnNx6RjzYlUK0t7eOakY90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790305147; c=relaxed/simple;
	bh=IiUTAwMcYZXF1L6jbPDqHYUp2CTvYKuckRTG79gl9FQ=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=ax/aswSTVE+J0hqi0dv5NXRKlgr6dc3nlWMYctMYByyug4CunX3v3sG3MTANCtJ/UkkT1kZB/7yY55ttucPe3XPchCQLnFwpC5vSqVZKh8W9emWDbXGs4IQ+Mm0f/9nndoywEyxw7cXhpsA4EghtVXQAGhuF8S5gFkyxBBwsp9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=J8/O7KfT; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="J8/O7KfT"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e630052ebso430768eec.0
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 19:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1790305144; x=1790909944; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RjQdHCFUpAQFkD7h0DgGEd9z2MrxaGA5UT1DxSFa5zI=;
        b=J8/O7KfTeAnmLId5ZjHB/OAIl6ZzMx2KUaQcDhUDfNBmCkTvfS7vJqvemomCi0HLZX
         aexyrfe/aQcvCSUlrZ5J00u9fw+aHUjJ2SfnNmUhy5gbtmhJZwatA6l2IlML7kXjYa+Y
         W5Aj0LGpxnxUesyau1Xv0HuUxe4qKSsk9U0YSAdRUInAg6fM5F4uaKnXagd4q8O0CRJk
         CQvHVEewuaXa9RxiKlbpDyCRbvNdk6+tju0nXyDgBeW6F/F8VnpV3SLSHneXO0WeHISg
         O6Wgr4wf4P+kyC8BjlGJzogINtuinrxQnNt53cbY2ZdyJnVdrPtqI7mZN9kDNIuy/j5w
         uJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790305144; x=1790909944;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RjQdHCFUpAQFkD7h0DgGEd9z2MrxaGA5UT1DxSFa5zI=;
        b=XJ55r735I7QgvKx2PKG8jwr+PyYQwD1BL9b6+Spn3NmbZTY8ITgCRDU8gMn/rUvHSE
         X/1IHWNcd50I6Ox1WxQ6vw9jPGwSn48ruKWR8I/IWlDb+BnOCXjxDkpYtOqQMrXG2BOz
         6oWCJlycbWpPTf3pkyqFuaWtzdr5cDg+haBfffJ+4iE0NkkHlhUoKHV1YBJOncucRsFx
         LO6lgUmFgx141kj6uMCQghIWop1VSJVAbjPIj2Xklnb204YHSI3rUk3485i+afToHj8B
         WZmZltiUaA0/CCg2RSCHvDcv6e92VHCWCV/mQzX3+Yj4TKkTybi5e7HF43aL2uDAvdIm
         P83Q==
X-Gm-Message-State: AFuF++laaRttfCmf+WqJmz87JvXo+bpaRgWbWx1LsmIsIBpX3ZqMjC8P
	KpPx08KoMHEEDF8nZ7TPmfvlYbA2nXh/rvCuZOs47aIBzI0sjutLe9+rksQnZLxiZRbzqD1p6/m
	2PB+t
X-Gm-Gg: AYBFou3wIL3nRZsBeu9YEINDCi2D0tXPx6doOsH5gIDEFPntEH6DJ+w7riJ6/dovz+t
	O3ED/jjmiM9fVU6ID37wzemp/B7vmRdw7+XyZGTdF1t5AIPQBO/desRp4qn+Hc0ZSMMPDoWa/Ub
	YKoo+H+JR40LlKAvPiWbdob0TOp/APKM8ZbynCXV/q10YsZ/yRGuLV1DK+h7Hf1ENyuz468DPsC
	A4x0rYUdApOP6NpLWaoV3iaQ2OXOD/FMidRYWdkBKviC4XKFKZ1N6mvV0sMkkAKRMzx4+/Aztxq
	cYiHKkPOZaDuz3i3WCLDDcsXP4YTIrMhQnb4BEOYksYR+Zl6IrotE72WHQha5MSb6S0jukkczIH
	NwF+qhLMs5S6vyH1kQIlEnY/fCMWVEtS5m61QvGtt6oyQGz1I86rzEjqFbG+VR1N84OoVWC7+rm
	RX4gWOhLc9GrO5GtjpjOeMFHY3RHW6KrUrvmyGJJ8eZWzBFv3QHBKqJr0Ucet5rOs=
X-Received: by 2002:a05:693c:600a:b0:33b:fa13:61ca with SMTP id 5a478bee46e88-3400697503fmr3522060eec.33.1790305144181;
        Thu, 24 Sep 2026 19:59:04 -0700 (PDT)
Received: from ec7b70f3a45c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34141d2fe4bsm2711513eec.4.2026.09.24.19.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 19:59:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] linux-pci/next: (build)unused variable 'rev'
 [-Werror,-Wunused-variable] in drivers/pci/pr...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: linux-pci@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 25 Sep 2026 02:59:03 -0000
Message-ID: <179030514298.542007.4329779510355469675@kernelci.org>

New build issue found on linux-pci/next:

---
unused variable 'rev' [-Werror,-Wunused-variable] in drivers/pci/probe.o (drivers/pci/probe.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/pci/probe.c:1891:5: error: unused variable 'rev' [-Werror,-Wunused-variable]
 1891 |         u8 rev;
      |            ^~~
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:40a2fb4b078614b715f03212d3976157ae8ef6ab
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
- commit HEAD:  94e8d4e94266bb9737a5963810a3f9365cb2f39d

# Builds where the incident occurred:

## x86_64_defconfig on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ab5da1ed96a8203de994ec1

#kernelci issue maestro:40a2fb4b078614b715f03212d3976157ae8ef6ab

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
