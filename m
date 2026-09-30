Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05BA3B7B6B;
	Wed, 30 Sep 2026 22:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790806181; cv=none; b=qW9SUZYvr4gvey6hlVu8Elj5pALUTX3uJ1vDhCS7jjEvExRU61W7FZ8FjvCgikGuJf5HqxgFU2pYZUIyhHEKHZEcDtez/MvtBH4a4PNYphpwh9tlZTzV4xs5l46lozAYLqyt2TQGKzq8HJJbJQwBXx7SpwZ3ceX2DsXDy3mvB8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790806181; c=relaxed/simple;
	bh=ri89pLozkX5EZybEMPyM+qvry3SAvj5nGn3JHG0wxV4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Z4FdgVAblkbaCQQOVSwF25DKbmB+13poW1nHJs603harpo2oTBJxewiICl53Erzvm7uZFuVE3afVCWZRs2q8PbY72D1zEIrnqvD0oZWARSJavrNotJI3ve5dsguA80w4Y9reiLszIZon6OybE37GdYQ5OdVobzzIAMmQXelotnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XttdmJCK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XttdmJCK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBE31F000FF;
	Wed, 30 Sep 2026 22:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790806180;
	bh=+EniTJbQ+nSzemMDJu4aQcFtoXJH8AhdTcEpP1V4djU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=XttdmJCKL6MKxHBciU5Kch3dhdyFpURRWpddZilWelZvi6psv2s6rDTGc1TZn1qQw
	 6RF6viaMsDS1zIFcdxWOo6shOZw1urnqdFPZvdUAbLTCDRyTCLaAFkg23skN4jhIag
	 8lx3PNtoDGf6Tq2wLLQ/Gt771HvYFtGdrJunok9m8AznuqRlc3ks4gMolAUifB5QhG
	 ofGgCbQcWBcO6oAvNkvdtFNvUYjNuiAeqBNAV6KAbfcE0qM8StEoPn7uhM7xdjduho
	 zVik0OyRaBL7is7wKoKGm0lcmTGW7Zs6+UfR1I8M5VqnQCybZo/RPFbZq++RyHKiq1
	 axeexX8icPeow==
Date: Wed, 30 Sep 2026 17:09:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 0/2] Unify PCI suspend and hibernate paths
Message-ID: <20260930220938.GA2632481@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930213923.566846-1-superm1@kernel.org>

On Wed, Sep 30, 2026 at 04:39:21PM -0500, Mario Limonciello (AMD) wrote:
> From: Mario Limonciello <superm1@kernel.org>
> 
> Many cycles ago I sent out a kernel series for using the S4 paths when
> the system goes to S5.  Some parts of it got merged, and Rafael suggested
> to split the other parts into smaller pieces across multiple kernel cycles
> to make bisecting easier.
> 
> This series attempts to unify the PCI suspend and hibernate paths so that
> PCIe bridges with downstream devices are put into D3 at hibernate the same
> way they already are at S3 suspend.  I have been carrying it, rebasing it
> and personally using it for a while now.
> 
> v6:
>  * Fix a NEW recovery failure identified by Sashiko
>  * rebase on pci/next
> 
> Mario Limonciello (AMD) (2):
>   PCI/PM: Split out code from pci_pm_suspend_noirq() into helper
>   PCI: Align hibernate poweroff flow with suspend flow for bridges
> 
>  drivers/pci/pci-driver.c | 100 +++++++++++++++++++++++++++------------
>  1 file changed, 70 insertions(+), 30 deletions(-)

Applied to pci/pm for v7.4, thanks!
