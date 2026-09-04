Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B917845517C;
	Fri,  4 Sep 2026 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514915; cv=none; b=pKCdGG2qHLCjtu24CTVn3RaJnY7u6emHiYU1SN84JXhj29Eps0ChHWybe3Li+CcA5/Eru0uFOm4XfVwYodpgJArpgx5MIMfjBYSGg3gkyKQE1w5RB1laAcWR/FpOznVMHliyLHIzjNU+dwEpdO6jDxChZaLfATuyEL29kUoU8+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514915; c=relaxed/simple;
	bh=eZ6RH1nJ+WautPpHPSeCyXzJNzKs0Rz0rt5v5rBPuFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XH6M0gcL4ZwzNIISqGJQFfSHdRuCVWQZFBKRO64Fc+0fYNYQa6G5e9TKBXFw2qEtBGzDpL8lGnHoSuemuPcqcN0niNRSEOBKh1CaJM2QwVKekjVtihkmsk5A3Y97YPIZ9Hqqggjwsfeizld/asfVbeuNfXXcPtE1OEhmwuuwTUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=TW8SGFlN; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="TW8SGFlN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1788514875;
	bh=lXmO7cdjhVBuQzfGcn2B6FDpZPCFL+GJNJz14cPFIy8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=TW8SGFlNOC4kIRIhuCMk/B5tMKfzH3xL7pvbkGRWhRWgBnNxjwsWOXHFEcXGgOsLo
	 IyOwDGi+UwFuW61eDF7e/6fKNiv48dQtIOhGDc4TXDerK1VeDZAKARanjQcsVoX6j+
	 bbe3Ls0APnVZZ8fAM3dEvNKqpxCVfOYtb5B10knY=
X-QQ-mid: zesmtpgz5t1788514867t1cb3adf7
X-QQ-Originating-IP: tyRt+x7aFkUeoOKrCJ6ChQKzSNutvsYwmxeKSO8P2Oo=
Received: from SW-U22IC-015.dc.com ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 04 Sep 2026 17:41:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4748388986171910191
EX-QQ-RecipientCnt: 13
From: Peixin Xie <peixin.xie@linux.spacemit.com>
To: rafael@kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	hansg@kernel.org,
	helgaas@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lukas@wunner.de,
	mika.westerberg@linux.intel.com,
	peixin.xie@linux.spacemit.com,
	sakari.ailus@linux.intel.com
Subject: Re: [PATCH v3 0/4] ACPI: scan: Adjust power management initialization and PCI devices handling
Date: Fri,  4 Sep 2026 17:40:30 +0800
Message-Id: <20260904094030.2455645-1-peixin.xie@linux.spacemit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6044499.DvuYhMxLoT@rafael.j.wysocki>
References: <6044499.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N3I7nP72NaLr1/nP8RtHgAxeo+qJrgPFu+w888Q7veYWNy5+EXECAhIr
	g5w64jyNtVRN799ShVwEfkQb5xGh/u4HhAgs8wYwyITUjqtauO51pUQDatvVSjYad+9SLC9
	gTMN67+ciMlvHetb2NJDqFHeOlAhlC/Nig3SmJuTJCGzBHBNd5cjyBpBt1M/AVoAmiig/fI
	9N1T5R7HzKcMv5g5kdjjf624TM3xk1UWD4Orm2amYaedIeqViBoaQkPZuPxi2NnisjKguWy
	rkWKc3ZRhDVJdFiONxcZ8vtlD/yFSus6HOUx8OvGgDwWN4DbNh2r9pQWqDt/Sai+bmFHLhh
	v5/t0qD5aAjTBcYJsT9WbjJDtTUMolklyDF6Z+xNcqtDpAAUE5/rCXpO4ZUBBHuSZG8r3wl
	HnOo7Id3LUr25rhceBV6mYaqWJuSQs9t27pAxFnwd77PPxcYLR7mniDxNCNTNRwJ9UymVcg
	/5HrCMgitzHmGLfnOoCAxK1Rcpwn+FVcgi9b35u2LdRAW5IYKsYeZSoxiTEM/4XbpIhhZAa
	1+0GTNCqxMaj/QEPBoLQml7XGT+paDe7GU1l97XGbKLXnIO/NcfMNLVotx8dVmUlUCVEtxW
	I5aCUqjImigbEf58nrdxXshEX1C6cYUoWsNXISm3Q7HzaiZVXGTakxdqw7IRV3QyakPkpiU
	GLqXdnmvoNeqX81Nnsm1/ysuD3xoeH5W659ACGQd6pCKAba4yVZghWbcEvZcYW5sgzS40za
	EvY0QKhDODKQfrhsPAKkoMDQpChuIsuCdBo3DMN1qioGHRGF493kUXab3bZu6HzuNLl4MUD
	Zo0jwCK8NtPG9vMl+yRJvPYYNI121RqzNjQJqAgPwxJVvovdY/tfANIfenDVHTtIiIJxbJ/
	chzfEZLS+O2iR88Ryxy66KUtnMamE/9bOB+RHAsl4oNai3JPzuIOj1sOtx6TIwNR97doBDR
	ZaXZfkM/4cKhY6uU0Lx7vLlGwx+fnC4szAkJRIizXFgTrraR0uaA+Vqs/+OAa0nSVSCt4A2
	ZgEbuMzekQfbrqXERUDy6T3TD99+ko9Js8bqIFZZ9eK0FG/RDhwgW9y+qDP+z738jCGOXYD
	g==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Hi Rafael,

On Thu, 03 Sep 2026 18:57:09 +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> This is an update of
> 
> https://lore.kernel.org/linux-acpi/5144065.31r3eYUQgx@rafael.j.wysocki/
> 
> that adds 1 patch, 3 two patches, and addresses review comments in patch [2/4].
> 
> The new patch drops in v3 is a cleanup relocating the acpi_bus_init_power()
> declaration to an internal header file in the core ACPI support code (patch
> [3/4]).
> 
> One of the patches dropped from the v2 has been folded into patch [2/4]
> and the other two have become cleanups on top of this series that can be
> done later.
> 
> Overall, the series aims at addressing a few issues present in the core ACPI
> device enumeration code, mostly related to the acpi_bus_attach() function.
> 
> The first one is that, on some systems, ACPI power management is initialized
> twice for devices that have missing dependencies to start with.  An attempt
> to address this issue had been made during the 7.3 merge window, but it had
> to be reverted [1].  The approach used here is roughly the same as in the
> reverted commit, but it takes PCI devices (which are a special case) into
> account.
> 
> In addition to the above, ACPI power management may be initialized prematurely
> for device objects whose parents are not ready for enumeration.
> 
> The other issues are that flags are unnecessarily cleared by acpi_bus_attach()
> for devices with missing dependencies and PCI devices are handled by
> acpi_bus_attach() like any other devices which is a mistake.
> 
> Please see the changelogs of individual patches for details.
> 
> Thanks!
> 
> 
> Link: https://lore.kernel.org/linux-acpi/20260820-acpi-power-resource-ref-fix-v2-1-29818173ea13@linux.spacemit.com/ [1]

I tested the complete v3 series on the SpacemiT K3 RISC-V Pico-ITX platform
where the original duplicate ACPI PowerResource reference issue was
observed.

The power resource left on by firmware is now turned off as unused after
the namespace scan. After the device dependency is satisfied, the power
resource is turned on once for the device and is turned off normally
during runtime suspend. Runtime resume also works correctly.

Tested-by: Peixin Xie <peixin.xie@linux.spacemit.com>

-- 
Best Regards,
Peixin Xie
