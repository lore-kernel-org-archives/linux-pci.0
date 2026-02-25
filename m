Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39C920DD52
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 23:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772062482; cv=none; b=XxkCSFeTzpKJWpi6jXGgy0OGmUB8bM//LPCgFjCdIJi6U1PXKVff7b52OYXZyYTZ9CoZ/26Y1jn2lJHNG/eI3DX8HRkElMTHNyIE+36QYmNqrcOrZPfzZpBjuUCk5YShfbWPzS26krhJTXF7+PSNBp+ZT9VxxRfpRUfn1oDS4SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772062482; c=relaxed/simple;
	bh=osfSnlLS3RF6U84Twh6FK1eEHlJivBPLYr0GmBlXMIA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c3GYIhVgOBq7Qfqs4bxSvJsk7DQYpg5bdwdfxeOSlYsVDJ9qunlegI0ZZCHgnqo1brrA5cCD77vi7lJl5BnBwN3DtOnJdoasRrn9Lsj19iVMGhbRQghhKOIJxQ8xeaxmQ9Bcs1wXbTGHedxe1pNUw8j6zTASfbfMy7gvgSWHqNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5B4gtZW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5B4gtZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE99C116D0;
	Wed, 25 Feb 2026 23:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772062482;
	bh=osfSnlLS3RF6U84Twh6FK1eEHlJivBPLYr0GmBlXMIA=;
	h=Date:From:To:Cc:Subject:From;
	b=B5B4gtZWdhA7GaIop9enO6UE7fOrpZRg50lX+l36GkvkLn5XV+RN1j/uufDQ48mNZ
	 iQI9gHDBcj5TW7v99GP0eiTE68V5VKPesOD07w+OPXKWl/8bUOVAiz+7Z/HPhDoX85
	 b3QyHOXPiMV4zwXQDe/CwXSkVr0187v5el02tivU4E1eI5OZZjNno1pAXEuxmDSCsf
	 mXOMBbrEabC6OaT/4G/g9fRMW1qWbHMgPLSHvpIOJm/OyGAnEu0F1tZLpQQ6esFPDM
	 v7C/5HuMSx4qLAenLneByOyCiZe9GT1W5uEsueBIi09Ojk05ny4lBazLnWG8bYhHGG
	 GRML2S/6vz+Ag==
Date: Wed, 25 Feb 2026 17:34:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: linux-pci@vger.kernel.org
Subject: [Bug 221130] New: [BUG] PCI: vmd: Missing Mode 3 (Dynamic Bus
 Offset) support for Intel Arrow Lake-S (0x09ab)
Message-ID: <20260225233440.GA3743606@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Forwarding to VMD maintainers since they may not follow bugzilla.  I
guess this problem only happens when VMD/RST enabled in BIOS.

From https://bugzilla.kernel.org/show_bug.cgi?id=221130 (reporter
bcc'd):

> [PROBLEM]
> On Intel Arrow Lake-S (Core Ultra 200S) platforms, the VMD controller
> (8086:09ab) fails to initialize on Linux 6.19.3. All storage devices
> (NVMe/SATA) under the VMD domain are invisible.
> 
> [DMESG LOG]
> vmd 0000:00:0e.0: Unknown Bus Offset Setting (3)
> vmd 0000:00:0e.0: probe with driver vmd failed with error -19
> 
> [ROOT CAUSE]
> Based on Intel documentation, Arrow Lake-S introduces "Mode 3"
> (BUS_RESTRICT_CFG == 3) for dynamic bus range allocation.
> Currently, drivers/pci/controller/vmd.c only handles Case 0, 1, and 2 (static
> offsets).
> The switch statement in vmd_get_bus_number_start() lacks Case 3, causing the
> driver to return -ENODEV and abort the probe.
> 
> [REPRODUCTION]
> 
> Enable VMD/RST mode in BIOS.
> 
> Boot Linux kernel 6.19 or later.
> 
> Check dmesg for "Unknown Bus Offset Setting (3)".
> 
> [PROPOSED FIXES]
> 
> Add Case 3 to vmd_get_bus_number_start() to read busn_start from config
> registers (e.g., offset 0xC8).
> 
> Implement Quirk to override Class ID 0880 to 0106 for SATA controllers behind
> VMD.
> 
> Ensure compatibility with dual-VMD domain resource allocation.
