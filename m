Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8D721018A
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772155247; cv=none; b=SzoeB3tq7lySXNXqqhb4dFOkLS0A4Pf8u+1H+SC3EA7Bkf+kA9Fr3fTJXV9sqKPlneIksB8qSzUzQd/xEXua4gMdiF6bqsl3s1ApI57XHEz63ELbX3yGvHAOVfp8iFKrTon6GI/ZNiyVyzqN0JxmYLA/C9ei5rbYrIQ/AwbRnrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772155247; c=relaxed/simple;
	bh=+lFR+gNb9zIplmARwXAgu4P34e5+nuUhZmlVOE2TLcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjOptfV+kAek61Yn6N9cyPuyMfGHKmxQ1FXIZwRoAbGPW4rRPM8/jFeU0GPGuWcAY5TuunEujeND0/EF77piPkYC/GaMRe94nXhu9CvENV2IGCg4aEb6EQgfVU4YC8Ho34/zdyU/GHCk1wqxPkxeP0j/NDp5MQSSBJEv90sJURw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SM35LASY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SM35LASY"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aae146b604so11474895ad.3
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 17:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772155246; x=1772760046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfbcWVNceKv2uuWEfU98GcXmxPB2l+os7KdwCnqo0bg=;
        b=SM35LASYfnk1iDCUqxKZYom35OWopvuz2NZDatGqtKG8keY4LargfdWkTcS6hkDCpR
         qHGur80787swJYe8l0QZnm1Xcb0KQgjd1tacxNnGrovfRNysWKVKl+bs2fHsRvpY4sL9
         luGrm9pUgcKA1J2UfweOhKcNJo8/ANHpKaLHhWEU+f7KVMO6G6Wo9Ruzs7+MY7FbPAlG
         F/06yWVU0VmFDef3t9CY8mI/2WOfnFAaTXYH6UUtNJFUYNKlJx2BhqonXnclGahV6CcO
         BvgqiNL/fisnuW/QW1AME0hasBSCoN/BrSliiR2vCx3IPwBL1hZ18n8x2ta1ujTCIL+j
         nWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772155246; x=1772760046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gfbcWVNceKv2uuWEfU98GcXmxPB2l+os7KdwCnqo0bg=;
        b=YZ5HYhVKmU7Y5K9XkrqaXDfftEPbzOkd2j0P2C3GBjYpQ0eHUOOkYRMq30anSb+Xq2
         zz5ZKgetEB1VVP6NB/SxBEvIwMTtJfAFFa+Yn64PbmyrOLcznJu5prqrZUl3lTF52uns
         6P9HmGTQX3ySku80BDbqZSnBBnnRYdw/cBJdcfYZOsDEX6nQQjuwzxutpCw7WjVgppkm
         vxc29v+mTMW+en8OQLHW1JFOXDaaAQu/2pbT3RRyT3/S5NUJwPVMd7kaxn9QwscxpKEc
         jrcvClRznRqqK4paUP5F2KehjUoi/01dc4FtT6E6b3XAUN669tp7i0kMZjgkaAKC9YAr
         Mueg==
X-Forwarded-Encrypted: i=1; AJvYcCU0bYuFjraoXooFo4WWmCmhT+XowoN6Bmg/E7nMo96WGrvIUS+ol0+OqcfofhMcGIXRSA+AqnNHSKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw13PuFwcnwLMF4BBFysxwXk1683C0Ts6cQRKiwLXfiRVsFiaLK
	9Tel687liakbnN8sS97bBNja9nJ/fV9BMBcyJaFdB+tz8RMhKzFbPS3H
X-Gm-Gg: ATEYQzz4RBDRTOZPLWXARAeKLZkwzap8zw3BsajFnyL0SpewGmxzz8FTkwygGBNXbuK
	O8AjILeW3wgNuoMUSdJZPHnRQMs070qncaJk7wN+opsPX0xFuvRJVRWDS4eilR30VitFubNr+nk
	PDBNRdqYCPx0dtFzxUzUyuelLs/y15wDwRDFV8rrDBI4MYDrAgE5xYu+QqsaCKX9AM3SU//XFgn
	N4S1jZtCBOwcK9N/W0yHorCiujQxCegBT+c2P96rr4mpw6ogWD3VOwQwxe9D/rIFuMRSec+M1c2
	QcLIIw+n1hB7let1RIUYVhF/nJegSIw3oUkhxY4ksxyaOAhn0nhN9SYNMlXbL2ha5upTNPsOlNj
	fiVcYZ8I2fAWnDoJn8/yK3Qdrm80BFFpqYvciwO1ByeTQWDS83EF3mmsq2o1qSkgb+bB2eKrxh+
	WSnla1GqnCjFQ1LdIUE/ylcgjah1U=
X-Received: by 2002:a17:902:d48d:b0:2aa:d802:a010 with SMTP id d9443c01a7336-2ae2e3e71fdmr8975285ad.10.1772155246145;
        Thu, 26 Feb 2026 17:20:46 -0800 (PST)
Received: from lin-desktop ([2409:8a3c:7a0:89e0:2b12:4298:c0e:2ce])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b148bsm46336905ad.10.2026.02.26.17.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 17:20:45 -0800 (PST)
From: Lin Mohan <beilingyu65@gmail.com>
X-Google-Original-From: Lin Mohan <linmhwork@outlook.com>
To: helgaas@kernel.org
Cc: jonathan.derrick@linux.dev,
	linux-pci@vger.kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	Lin Mohan <beilingyu65@gmail.com>
Subject: Re: [Bug 221137] New: [BUG] PCI: vmd: Missing Mode 3 (Dynamic Bus Offset) support for Intel Arrow Lake-S (0x09ab)
Date: Fri, 27 Feb 2026 09:20:39 +0800
Message-ID: <20260227012039.85131-1-linmhwork@outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225235631.GA3793102@bhelgaas>
References: <20260225235631.GA3793102@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Lin Mohan" <beilingyu65@gmail.com>

On Wed, Feb 25, 2026 at 23:56 Bjorn Helgaas wrote:
> Lin, there's no need to open more bug reports for the same issue.
> More reports just become distractions.

Hi Bjorn,

Apologies for the multiple reports. This is my first time reporting
a bug to the kernel, and I am still getting familiar with the
process. Please consider Bug 221137 [1] as the final and formal
report; the others can be ignored or closed.

> One of the comments here does point to a patch series that looks like
> it might address the issue:
>   https://lore.kernel.org/all/20241122085215.424736-1-szymon.durawa@linux.intel.com/

I previously attempted to modify vmd.c myself to fix the issue, but
my changes were not successful.
