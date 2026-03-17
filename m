Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C49B1FC7;
	Tue, 17 Mar 2026 01:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773710455; cv=none; b=ANNiO0JDqU6IRvOozS4iwHpbvoq+8EBu4uptbgFtHH55nvpBxosRidVOnuh2XvCFYgg+eougZwTmRjnPGJTkdZ6S/kj4CY21a1Am0dCcTMD0ZtTlrKcqRJ7NFzyVnNVn6blUuId8Gcy/HDFDa+Fzu0HEA5PDG0fktheCUX+H0Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773710455; c=relaxed/simple;
	bh=cYt+IhqmWoKN+g720j+RgVKxNRtQxBml88LOLNVwa+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIJUCPLdSr+ZqkqspMGM6xb+oJGMQRMt1hSUpzC1//i5zxRGg4Hw/B5duYfjqwd3ud1vp/FVPIhnGvoQV7A1muxnGXAMkFB7shL/cmnCJragHqGLkSJ94DsggNC8mBsGepY0kAi3l3uwHwAmqi+6MslvFofI48FvdB7dnC3/S5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knVBPOHP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knVBPOHP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6401C19421;
	Tue, 17 Mar 2026 01:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773710455;
	bh=cYt+IhqmWoKN+g720j+RgVKxNRtQxBml88LOLNVwa+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=knVBPOHPoeJXRhnevHPdxMbWxtUPHMW1zDZRpbx5U7J8RjIZ/cVVjDG6mSrypS8Y/
	 XycNc8PAeG1907rsxS0kYx0roI+TTam1JYsPl0ew2fqjG8O3YjUc55/shJijfWyoc4
	 p/hJS4WdgD+QIZrqkbrgCm0raBqWE+6KbSbA+l0JlH02Bbd6KE54Bd0yPbAgzUY/4c
	 /Fkb3TTkhUsx2yi/XKGCTVygbwxpnyBL1kdggRbSC6wAhgUqO62cvESoFcwr9mgYBn
	 7VrWGu0ZOdTykMbJU11L6Ino6jEKUaY65kbBRMwESevtFGk/rHI+E+A2F/v5bpswMw
	 aoP2y3h4Kvpzg==
Date: Tue, 17 Mar 2026 10:20:53 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: lirongqing <lirongqing@baidu.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v2] PCI: sysfs: Suppress FW_BUG warning when NUMA node
 already matches
Message-ID: <20260317012053.GA1575592@rocinante>
References: <20260317002803.2353-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317002803.2353-1-lirongqing@baidu.com>

Hello,

The patch is very nice, so much cleaner now.

> The numa_node sysfs interface allows users to manually override a PCI
> device's NUMA node assignment. Currently, every write triggers a
> FW_BUG warning and taints the kernel, even when writing the same value
> that is already set.
> 
> Check if the requested node is already assigned to the device. If it
> matches, return success immediately without tainting the kernel or
> printing a warning.

Something for future reference:

  - The [PATCH][v2] would be better as [PATCH v2], as per the usual format
  - The "PCI: sysfs" prefix that we use more often is "PCI/sysfs"

No need to send v3 just to fix this, unless someone (like Bjorn) would ask.

Thank you!

	Krzysztof
