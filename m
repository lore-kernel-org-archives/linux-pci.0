Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8D43E1220;
	Wed,  6 May 2026 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778091013; cv=none; b=gW/ZbbrRGjUyoNU51vhXvXB1OUhilRkzK38AVJHzN/ylee97+C/VOYAbGxp0kjS5oBgSCS5F5XUW3T7g7/UUJWOjEWL5XDiDqEiFIKc9JrWd8+tzjkPjDH6sumyD7+mgu0hneeWH405z19tg1ldq3/RJ6YwtVDS8Y8cx0aww+w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778091013; c=relaxed/simple;
	bh=EmGTqrYyQ3YP7L/xkU9mYxd4hVI9JuyWesXhdC7VVm8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=efTwydQyFCQdS3qEtSstXhHsZSEE/kI/YUaPzLJTBIUWhCpIFR7WinC0X780Spo17odqqr/px1OVukV6Wsy9dRimYYF5imc4lZo1Xq8SSa08VlewqkN5iZEep+LSNBZgkwuaHjgLmbldY3pFkuWq50uO0k/eb5ATbud/ZrfbRoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9CBWpeG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9CBWpeG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559EEC2BCB0;
	Wed,  6 May 2026 18:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778091013;
	bh=EmGTqrYyQ3YP7L/xkU9mYxd4hVI9JuyWesXhdC7VVm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=g9CBWpeGPDhjFbmKdZ5r1suONU0+Rwru9Au/tvy9dE7P3vvhC3HU0MG025d7TjvLT
	 ay9cb/CAQbE8ZAvQc/qKiTZp6jUdKHpXMGS8q3GG+AhEzsee7SOdus4e6YKqzLHuhr
	 C6VAdgENfbeZgxJrSmeQXJklf2/SFcBSh1sXL+wIAj2kPdUU9ijY0nzIUtKGgoY/UJ
	 0z7uuKwtkqVe98OjKOKc7AwnDrR77kP+gox9lATb/moTL/20y96F8S4IIsxaU4j8WN
	 eH9dbBIsW+PjmEu0T92svOUWLfisYzfBsDdNgswcfgG0sYajVfqgEerhN5euf5UBtb
	 lLyDoCud4koAQ==
Date: Wed, 6 May 2026 13:10:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Carlos Bilbao (Lambda)" <carlos.bilbao@kernel.org>
Cc: bhelgaas@google.com, eduardo.habkost@lambdal.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bilbao@vt.edu
Subject: Re: [PATCH] PCI/ASPM: Don't reconfigure ASPM entering low-power state
Message-ID: <20260506181012.GA803978@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428040104.78524-1-carlos.bilbao@kernel.org>

On Mon, Apr 27, 2026 at 09:01:04PM -0700, Carlos Bilbao (Lambda) wrote:
> From: Carlos Bilbao <carlos.bilbao@kernel.org>
> 
> Reconfiguring ASPM when a device transitions to low-power state can enable
> L1.1/L1.2 substates on the PCIe link at a time when the device is sleeping
> and may be unable to exit them. ASPM should be reconfigured on D0 entry
> (resume), not on the way down.
> 
> pci_set_low_power_state() calls pcie_aspm_pm_state_change() after writing
> D3hot to PCI_PM_CTRL. pcie_aspm_pm_state_change() resets link->aspm_capable
> to link->aspm_support and then calls pcie_config_aspm_path(), which can
> enable ASPM L1.1/L1.2 substates on the PCIe link. If the device cannot
> recover the link from L1.2 while in D3hot, subsequent config space reads
> return 0xFFFF ("device inaccessible") and pci_power_up() fails with message
> "Unable to change power state from D3hot to D0, device inaccessible".

Carlos, do you have a few lines of dmesg showing this issue that we
could quote to help people match the issue with this fix?
