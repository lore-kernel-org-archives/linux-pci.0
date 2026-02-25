Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9083859E9
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 23:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772063793; cv=none; b=OQ8UMCn+JjJevHPCIdKTCh4zXnCxLSwda1zgNKvEe4izWCPnoK77jFPgkoQhpmK11maVyYEhyExF+nBlc1vhse2yVUZIQ4nDJe1JrcQgovN18xFR2+5n99OTGuvLgKBwRAzvzDz39J41pCD3XEuLfmzZ+vsz/hxSbCehALOwvws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772063793; c=relaxed/simple;
	bh=3A+g0NHSvpPeVU0ahycKsprBaYO2pbkZDxzGbmVf1CI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fS10J1aczPxIqYWjmXjlgE7JUw9QOmbBUUW7ou4YMQMOMPCFA2iN23jWzgKGhr9Mv/YPVX4uzUA4PUV1rjz2CCmVjlVzUKBq7PajbUkou4e+sNKnCjgm2XDlh13NBf8IFbcVglEv5vIM2/I9nWlQJ5NvOAkFt7iFaWfrUA4NJ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGEpJoFn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGEpJoFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C22C116D0;
	Wed, 25 Feb 2026 23:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772063793;
	bh=3A+g0NHSvpPeVU0ahycKsprBaYO2pbkZDxzGbmVf1CI=;
	h=Date:From:To:Cc:Subject:From;
	b=YGEpJoFnwRc2ignckS9mHL/wpOwrn1gMhIrlq02u1HlGIU1p3+jmHwsT8J5Ag1IQl
	 pIgRywcu+gFChBxWBkIgPB7Mpt97OkFXXNobo3bHbJYmQzhvROmyb2XMBZYzCvRXMg
	 ZUVVIhsypJTxjLRwKVc8KoG/DoxdkN8E6ts9ud/1i+4v5HHilNa+PcimrEqe8LIJ5h
	 vCrorkXsoMSN1l+xR6CjX/fqNncaIMfDqbcmpA54JKFttwQqRjIIfCROMqZYRAlweo
	 DwMPtFc1ULRkM7vZWH6aSyzthYQAgtMDqGvj5RrdwQIczBS73FJBZu173OuOZJEC0e
	 119tRSmaMukOA==
Date: Wed, 25 Feb 2026 17:56:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Szymon Durawa <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Subject: [Bug 221137] New: [BUG] PCI: vmd: Missing Mode 3 (Dynamic Bus
 Offset) support for Intel Arrow Lake-S (0x09ab)
Message-ID: <20260225235631.GA3793102@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Looks related to:
  https://bugzilla.kernel.org/show_bug.cgi?id=221130
  https://bugzilla.kernel.org/show_bug.cgi?id=221136

From https://bugzilla.kernel.org/show_bug.cgi?id=221137:

> 1. Overview On Intel Arrow Lake-S (ARL-S) platforms, the VMD driver
> fails to initialize the PCH-side controller (ID: 8086:09ab), causing
> all attached SATA devices in RST/VMD mode to be invisible to the
> operating system. This is primarily due to the introduction of a new
> "Mode 3" bus restriction and a dual-controller architecture that the
> current driver does not fully accommodate.
> ...

Lin, there's no need to open more bug reports for the same issue.
More reports just become distractions.

One of the comments here does point to a patch series that looks like
it might address the issue:
  https://lore.kernel.org/all/20241122085215.424736-1-szymon.durawa@linux.intel.com/

It's over a year old and it looks like it died on the vine.  There
were a few comments that were never addressed.  Probably my fault
because it looks like I didn't respond in a timely manner.
