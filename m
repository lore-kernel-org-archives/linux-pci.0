Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [144.76.133.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EDA356A2C;
	Thu,  5 Feb 2026 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281664; cv=none; b=VSe3zkq/KZ+vdg+lQ+0NH3Xybq347+p3IzmTwpdti7E7hCE/e/RR5HW8Rp9SJtkfTxDg5yqsZkUL4QnwVzQBsnYV7nwm6nEIAraYNhdM5RTh44Em5nujuJ3iQgrrZmq35kCc1gQ7u4MvD09VNs2VwyzUsWLCHwh43kvYrA1DBD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281664; c=relaxed/simple;
	bh=SUeJNyehexqoYDeID7nGrc+f51GZT9nIaXngPQXE76E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvU07571oD0F6AOuCT5XH6A6t9mwa6vjlGbIcTbYCHfBWz5oPudWyDede44vmn24Q8tW6NnNYd4LrxTIM3ngaUJ0gEq9VT+P86c2wVd7+cMnBYR2H9m+g7MxSuiJQn9iQiQAx7fRnfUpZIsFvh7RgCMJvObCaur1R/PI11EUEMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=144.76.133.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 3F7ED2C0161B;
	Thu,  5 Feb 2026 09:54:16 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id F0B4A36476; Thu,  5 Feb 2026 09:54:15 +0100 (CET)
Date: Thu, 5 Feb 2026 09:54:15 +0100
From: Lukas Wunner <lukas@wunner.de>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	CobeChen@zhaoxin.com, ErosZhang@zhaoxin.com, TonyWWang@zhaoxin.com
Subject: Re: [PATCH v2] PCI: dpc: Increase pciehp waiting time for DPC
 recovery
Message-ID: <aYRatwSvUG0yQkHd@wunner.de>
References: <20260204035542.53232-1-LeoLiu-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204035542.53232-1-LeoLiu-oc@zhaoxin.com>

On Wed, Feb 04, 2026 at 11:55:42AM +0800, LeoLiu-oc wrote:
> For example, The execution of the ice_pci_err_detected() in the ice network
> card driver exceeded the maximum waiting time for DPC recovery, causing the
> pciehp_disable_slot() to be executed which is not needed. From the user's
> point of view, you will see that the ice network card may not be usable and
> could even cause more serious errors, such as a kernel panic. kernel panic
> is caused by a race between pciehp_disable_slot() and pcie_do_recovery().
> In practice, we would observe that the ice network card is in an
> unavailable state and a kernel panic.

Unfortunately v2 was submitted without answering all of the questions
and testing all of the things asked for during review:

https://lore.kernel.org/all/aYBoP-B2E9fp_4YZ@wunner.de/
