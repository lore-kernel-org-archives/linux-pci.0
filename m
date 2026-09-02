Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A1148551D;
	Wed,  2 Sep 2026 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353040; cv=none; b=vCjkgfybvzp4Nk1dc+j78/iMRosD7B8ncotLiPNN4y46U5RHuxmEyZ71q/WJu11ho/kZ5nX1aNtDq+aOVT0HS5GahQrYVsQCz8GcL7x7RHeKtNt1SySBoV8+gSTk7FGe/7nqgeyp+hV3J3WskQj7aNM3RZzlf0LZPVJe/HbIOdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353040; c=relaxed/simple;
	bh=KWxeaw4SqgJJYFipoOgPLMzIlFPH9Zm4+s1jmrG8vBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nkOmMa05dE2IcT5V5ktSfsF+aaaOEl916iF5fz70GYCTdDclVGUMoK7ra4rMJWOKog4gnqrp16P7NdMY3lz/bJbs5oQ5PFfUNVM9FgqiHlXCXQq5eFsZopxDvX3azW7uHkSs5oNDE7AmnylIoDMouYCmxXE9mM3Eubd8r0ku1ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=vriAY52l; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="vriAY52l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1788352992;
	bh=RIYFal+fK1qzQK9RpT8qrCUAIsMarf0Kb/q1Y0aaglQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=vriAY52lqMPPMqBJ2X/FzO6uD+OdVcYijU6vTO+cSv7wGCLeoi2WH2gqrFIt8bybg
	 GVmqA9U66uepbU38AA6isqBnc3JPvBp8L/+UAFBHxWOQfmndn06O7I2dIEqdnXkRyu
	 pNvymAg9B5x+X9JCsivgmtOHeUH/T4p07ouTuccM=
X-QQ-mid: esmtpsz11t1788352985tf7711f1c
X-QQ-Originating-IP: hOX3m1P1K98ryeLZYaywOoYyspy7Wn2eDC55Gnk+wAs=
Received: from SW-U22IC-015.dc.com ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 02 Sep 2026 20:43:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14759197496904960009
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
Subject: Re: [PATCH v1 0/7] ACPI: scan: Address power management initialization and PCI devices handling
Date: Wed,  2 Sep 2026 20:42:05 +0800
Message-Id: <20260902124205.1458089-1-peixin.xie@linux.spacemit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3435655.aeNJFYEL58@rafael.j.wysocki>
References: <3435655.aeNJFYEL58@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NMGzQWUSIfvTteGTh+l0GykwvA4KWvbxHz2TrvADUloKZTGne/rEZepB
	HECXvWkNg7+ju1S2ttnv14rfyL7PKrxQiRl8zx5MSby3hbP2+6hkEmlgymw2QNY10E2mDbL
	RQ+j2hIc2RB0NRv6iGQlhBRRk/FZgoGTzPeLfsulzreuYddWJqavESFC65dGaNureFIOBQW
	AmVM4S6XjQ5YvSSC8TymR8dRRru+S9siNm3FACgmK+NuG3Bk5pYG0wI55F0FVZ4T3hYGPI+
	Rp0gsJ2a/RNC1PBBczcufdGGRpDvGjupDzgWrgNXiFvOm6taZYXIfe+DXQx9mCyOIdHutSM
	NtykN2OPZQY7dPErqIMNjnc6Sx0938rooOlg5aQZXugZwG5riTyBFiSNEjJ9JFi0B8VSeih
	98UyJxWqfywg15xrg90UGCAoCOkr2d53cqKXSaSzbJRjgCuRqGkdbWZX1ZxVAK6Muc5t/Uo
	Z8GQifdImU8cuc4Cm8lt7R7twa2LckgyrKS3swj//A8/D4Klh2McnQWQtzT2jAxfJ11vYsi
	6DMp4SpFbcaILB9aYbSvV/MF5HiGB5WfuDYnYNfO2cq/MwIpN2M7UuQYvO+sKNXUYTXINPF
	4hDbkwT7CWuG+PSjKhUcYOgJQXwhpYTXRhS+qV7b47N37c7lxJm8Mp40E/Hi5OUtEu3sOID
	2Z0T3D1hnenQV8EbF1fUffRQJ2DmnTjC53hTKdWDU93Tm3WcYF2qNXSRC5072a3BDMe6G7Q
	oydgJhEn+IUGhBfqXfcvKi+kBO1KTukNVXKL6e77tRDeS7ewWpzW/DVSbppRFU2vc0XR6PU
	7eP79FCRn6JOn9uNQaUCKEeM6nEo5bnn0oersodO8gCEOaeDT65AeyfChfURvnOzcWn8d22
	zpJEIxMBmQKvwu1zVVmzHf6GX3X+LKM2ZCUr3mCNdMWaGWzQfVfW6LhnRudPcn0vg3bMw8x
	KWG7H3sTF05bq902F3/9iyMM2HFRvBHMXCdwReHjcV237tKJWoDXsemfpt7YOBy/W9V92MT
	vd6YMqaZvm9f9SrMXMnk0IuYoBS+pEhTiR7PNJ/NjZq29Xy1Hr20uMygS3oa/ikyIhPWcxu
	wZXPD/T9KkHQh6iFLy8H3E=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

Hi Rafael,

On Mon, Aug 31, 2026 at 06:20:42PM +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> This series aims at addressing a few issues present in the core ACPI device
> enumeration code, mostly related to the acpi_bus_attach() function (that
> gets renamed in one of the patches).
> 
> The first one is that, on some systems, ACPI power management is initialized
> twice for devices that have missing dependencies to start with.  An attempt
> to address this issue had been made during the 7.3 merge window, but it had
> to be reverted [1].  The approach used here is roughly the same as in the
> reverted commit, but it takes PCI devices (which are a special case) into
> account.
> 
> The other issues are that flags are unnecessarily cleared by acpi_bus_attach()
> for devices with missing dependencies, the "initialized" ACPI device object
> flag is not particularly useful, the "visited" ACPI device object flag is
> used for two different things which is confusing at best, and that PCI
> devices are handled by acpi_bus_attach() like any other devices which is
> a mistake.
> 
> Please see the changelogs of individual patches for details.
> 
> I have tested this series on a couple of machines, but let's see what
> Sashiko has to say about it.
> 
> Thanks!

I tested the complete series on the SpacemiT K3 RISC-V Pico-ITX platform
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
