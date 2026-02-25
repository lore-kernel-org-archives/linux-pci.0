Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419CE366839
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 23:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772062978; cv=none; b=Xe+bhMe53bLzBu0NxO84WnAeK+RoZMxGjfE4UxqgZlPIEWqG0Q6Rl4/nDnXakm/YJXISnbRTw6gS9xBeGeuWLLUeGSY9dW/eY316jvpUWYREBh133U3aOiMevphbTXiEW0Mq+AdWOU30NafjH+r2rDKVIeaxnjtEnuUQQ8B+lRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772062978; c=relaxed/simple;
	bh=LbZZe+ok2eBjLEx6G445aicFL18drENJOqeAaTCnPd4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oGiAcK+PSVWD0qH+NdSCJX1FlQmXQLPqaLokt7ejcpi6DOYULy+YRGZu/m15h6ChosHV/h4NgGk9+RunRbTFs7fFfSlDltUpWP3wpHF79RiYm7FmiEbW3ywLH45TAq6fiZf6fE2D4uRST0blWW4P+rbctNzZj4EzE9smpXxCG20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmGTiaAD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmGTiaAD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEFFC116D0;
	Wed, 25 Feb 2026 23:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772062977;
	bh=LbZZe+ok2eBjLEx6G445aicFL18drENJOqeAaTCnPd4=;
	h=Date:From:To:Cc:Subject:From;
	b=jmGTiaADKR3Ble3umOm5pAK9Azs1es3gfJl/9NWdhrr1D9rMUUBC+UQHN3wOJneFT
	 ZjldEiQgq0JsU188Af3R0OFFILhBaNESXWtvNKo5Tg0+f91iGUxu2R141kHnf8yQWj
	 atE4xrY4VE/ar2PB4ho3n4RjcMPYd8DsDeXf9cAQBmOswGTa9mmY/Rd7fnILhySQZP
	 /YSDHB/rJRAF3YVKAxYZ6kvDcl26N4/40wvCTUoK9pfQmva1jvSNoUGdiXSrBjACkC
	 iKLJUlJbTQyUPtIFFBZ0i6hUnOj2OuxkbMmyVxuOVci8nXLxin8lRMAurXLm/Y8J1b
	 +Cd3PwnJlqp7w==
Date: Wed, 25 Feb 2026 17:42:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: linux-pci@vger.kernel.org
Subject: [Bug 221136] New: VMD fails on Intel Arrow Lake-S: Unknown Bus
 Offset Setting (3) & Incorrect SATA Class Code
Message-ID: <20260225234256.GA3792529@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Looks related to https://bugzilla.kernel.org/show_bug.cgi?id=221130

From https://bugzilla.kernel.org/show_bug.cgi?id=221136 (reporter
bcc'd again).

> On Intel Arrow Lake-S (ARL-S) platforms (specifically using PCH VMD
> ID `8086:09ab`), the VMD driver fails to initialize correctly,
> leaving all SATA drives in RST/VMD mode invisible. The failure stems
> from three primary issues: missing support for Mode 3 bus offsets,
> an incorrect device class code reported by the SATA controller, and
> overly restrictive BAR resource checks.

There are lots more details and what looks like a modified vmd.c (not
a patch) to fix the problem in the bugzilla.

Lin, thanks a lot for your work in discovering, debugging, and
proposing a fix for this issue.

If you start here:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html
and skim some other patches at https://lore.kernel.org/linux-pci/,
you'll see the usual process for submitting Linux kernel patches.
