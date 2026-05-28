Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59393EFFA2
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972985; cv=none; b=n85fH+kdo6IpXbkPhg99Q82ERyEu4F5Uxe2P3v/37rbWsBaq77E8i2LlP+UycoZHRX6Ku6K+Avsm8QFIsklK2Pz8pWwZedD7oDfag5t7jQpAcGc70TO9TrM52+ePzOkAufIDIucP2kKx8lyBPiLj4StFXx5UwzezfN0PhtxH6RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972985; c=relaxed/simple;
	bh=YfZssVGDne01dMYMgGTcgNvcudPc2T+XxFJkjcazgS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUUO29+kNepZcB/A5jt68WJLVzRAYI13MRtRDd9/SZnOqny28FkJ4Ar3rJXx9x6ktTV4r8ZoY45awgg/dHSSCBAdi2dFv22nMdPnDlH88oFE8M6heULRInZ3kuOu3PgHLK0Zxu1aDm/tiIk6HVSCBP9k/qeNBj9vKWAfAOKGUtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPKJhu5K; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPKJhu5K"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-90ca6f20872so1558180185a.0
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 05:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779972983; x=1780577783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlTiMO+AqzsfMF73zg1sUXIUWFi0uPkexNI2Y+w2IWA=;
        b=IPKJhu5KafV3j2zNhIWpFJG1ODUa3LK7J2/HzlQNckUSG+ivyUPTtrmnv937lxcqp0
         htLaUQbF4tS8pw5eWEawCIz6PIO8iXFdlWXwQDeklfVWuV59Y3TtGPe8hCvjFGVQAqAP
         29BIq//PeRs635L9OBM54AHaaL5ApJWJtLkcyd26Dpk5KYO2bNqpEIBC284KZMmo0A61
         9F169KPZPZ6JKO6YWj4xJ2mJj6lCVMXrD4HpWrsR0kgEuZhoRiPTiWZP+IRDUjUOsVGe
         pZGTCrBJVP6UdS/LmiXyDuKP/ogITIR6G97C1G4OtHf8iK5pRXgr4uxdIZdXhPW3uvf3
         GAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779972983; x=1780577783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BlTiMO+AqzsfMF73zg1sUXIUWFi0uPkexNI2Y+w2IWA=;
        b=inRc2v5fgJY+NvKP2G22d3ixXI8/dmg5Lq+Vn/SLkx7AYUsRWfuLFX6Id/kGP+Vhyh
         sLzwugiGnjVGqPmDKZ2XJdTh76NwlWQRCFiuDcBIyIE0q5wo49ZMicOeCQEczHy1ZzSN
         AFaUtNlAugYlOSv3nDhZe3p+STfXJPTpR1LnmMOvrLI3VtJWj4c6DL1Vdnklf9dFxd8h
         WCjawltiVx4nXzhwPWDWhN/eFqVdIDx2PJdteXTT+YBqoP7Ian6OOXIhpuSrDhWpwjso
         WcPBMYj67PkajcarTlc0Io//nG9DG7sr8/XWekQPy+jQfbiXqUu6nsEpd5D672NjAcRh
         ztSQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mQgQADojMpW3mTs62IXqyI2ZpigDTQkDjx7dVbRO07vfaGjf05SRCV118jL821jVTiBfvLaDQ5dE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoKTISJu4oWii+dgj5wKmSqQAGKnSniuXTI6Io814GFBm1+2gu
	jPQa4W21Oefc9m6Qs+Mj3q1maR9QW/fZ1LigtSyqimm4SLD1lpXnfBEf
X-Gm-Gg: Acq92OFQv3hdKaDHv831YKM3rocIWS2mwhw1VaNLMFcVOrgzj/QTPpKB1NRmbxcNUT8
	495UvGKl7CIrrnR8MTIP+edtr9tFZvVOsFuB5blCRU62NuvwrAeXVghXtkzpHaBvUOyJBjUNJbe
	m0M7NCW+Bhs0Lsog24cmrCSbUH5aW/ZnenZcZALPsS9JMEt8QHRn3x7McUSE/FxaUVnURCrCa5S
	EXsSyM8S/vWinrhkkrCQu685IupHNxl9oecIekhGpVWUGu5Ptmvy69B4szgV2Zajl0Yqr0qMWg4
	5weQ7q8IiA3r0W0Af87AJ5tZM6SSZvCt+JIWh/s8UmpkvES8u1KRIptZ2eyOxhgu29+v23XH2xt
	pu5oemsUzJmNcb+1XgguVIGu2QcN6h/Kq69uKjmmdbBS+rhS9RhkFwte2I4J4QyZgbE4wxhQxjq
	QTrO0JHh/GeREp7MYfDLN8mKEqwOA2FzJX52jzlhgoq4ejw3eOHXN2WNShDAqM//86kQFI9UpAg
	5iE/tClvac5iemA6F0w0FWNG6D08Q==
X-Received: by 2002:a05:620a:1b8a:b0:8cd:d688:7aef with SMTP id af79cd13be357-91521722eaamr138903585a.19.1779972982782;
        Thu, 28 May 2026 05:56:22 -0700 (PDT)
Received: from leonardoc-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f86e9b34sm813683585a.5.2026.05.28.05.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 05:56:22 -0700 (PDT)
From: Leonardo Costa <leoreis.costa@gmail.com>
To: kwilczynski@kernel.org
Cc: leonardo.costa@toradex.com,
	achill@achill.org,
	akpm@linux-foundation.org,
	bhelgaas@google.com,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	francesco@dolcini.it,
	gregkh@linuxfoundation.org,
	hargar@microsoft.com,
	hongxing.zhu@nxp.com,
	jonathanh@nvidia.com,
	leoreis.costa@gmail.com,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@nabladev.com,
	rwarsow@gmx.de,
	ryanmatthews@fastmail.com,
	shuah@kernel.org,
	sr@sladewatkins.com,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 6.6 000/508] 6.6.141-rc1 review
Date: Thu, 28 May 2026 09:56:05 -0300
Message-ID: <20260528125605.255471-1-leoreis.costa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526183025.GA1285841@rocinante>
References: <20260526183025.GA1285841@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Krzysztof,

> > When you have a moment, consider changes from the following series:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=sysfs
> > 
> > Test, and let us know if this fixes the problem for you.
> > 
> > I would appreciate if you could test this for us.
> 
> I realise that 6.6 is a bit of a far cry from changes against the upcoming
> 7.2 release, so you might have to massage the series/patches into sensible
> state, so to speak.
> 
> Let me know if testing is too involved, given the need to potentially
> backport a lot.  I will think of something.

I tried backporting the patches to do a test, but it turned out giving too many
errors due to the different context. Since it's not really breaking anything,
we'll leave it as it currently is.

Either way thanks a lot for clarifying this! It's good knowing the patches
where this issue was addressed.

Leonardo
