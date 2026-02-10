Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5758626E706
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 01:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770686232; cv=none; b=PL2qwFd823dPFAWH2u1SxkFN5KNrz3kjlWCX+TUKGvLe8tSMnKxpUzTPguBSvmWgGK78+190Ae0wEy2K7q9LXSYn/x3M8eautyTW+gCYwZagGJDFASIxiSPniw+o6vVAwEX1DuFYO3joN7XYofufjH3Hzj7Z7QXUpjN4Zf/X0Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770686232; c=relaxed/simple;
	bh=gCyHz5YH3rkfmkuzZmj0n9TsGnwIlm/bBPk5+K4C4g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3LPwa07efqQLjS796G30TRDZW+1Dnj1FDre8RhjHiB9C5rsYWFMWsRqXCppeBmceVQrYEI5BeCMIIUfPGC/urojp29f5POlsgmw+2QeOJ5XhHNPq3qGViYouYCh1fOBxcUsgKNntDLoohhlW844W9EU404Xh/IOXd+d4mSx0oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Uaqqv2MQ; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uaqqv2MQ"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ba895adfeaso310830eec.0
        for <linux-pci@vger.kernel.org>; Mon, 09 Feb 2026 17:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770686230; x=1771291030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PKD/fyGImes3SEWgyhsAok+Gf9yh097jwYeFYhWa3NU=;
        b=Uaqqv2MQK3n4GbUMHijiw4RylPhmY6X/okfHboYAhT3/m76xRoeEjAiH0xTSkPvgyp
         celDR00zJjXBVnB9VCrhj/ZtE9K2VW7CTbLTGUwfBKJJfpuBZbgwU2VpWrItS/tqiPL7
         o++0wIObAbrpfvHyLEB9WRKbM/BtVIbscVBQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770686230; x=1771291030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKD/fyGImes3SEWgyhsAok+Gf9yh097jwYeFYhWa3NU=;
        b=VyTY0VHuccsJHzQJN3RSMIcWO+vtaUHU7XdfyZis1TluBm6B/azCCCaplrBj4+PJ4D
         ve6pyA/sh7u5LE7AhvMIxKe0My3Gzey77X5YXGFjzhFWaotT1T/x8CDr0fPC7oi00s5v
         +IdwOfQi9KVWbDqH8qu9TEpLZPnR7yyXE9WTBuXR029OMNd+TRhSWr0Zx8wmRqz2oLA1
         s3k3Rt0Pef6VPnrTB19CLnimdKgdNQbWGfbgRnJ1gbI0FuMEcriPODaWtgtRs8v3I8Cc
         uws8LEfuc0lkj/ibaV75dJjpcapDCb4xvU1Xj5sR/kA3obU3F1XxKKlHR0AWkl245VKk
         Nt+A==
X-Forwarded-Encrypted: i=1; AJvYcCWo7/rsj29Nd+M1vINGhFsp/kncmjWlP1KhoEayGLjcIQr+n19bc4w6GSKDfkFGbHHCVyb9MyCgw/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyza+AcX6rATTPBg1ybQxJxj6sLaPgV4sbPystDBH8HE5i6seis
	+a2ltA2ueXzBKttua18yeVMpPZhYPXM/8rkARqZRn70pqf/Yl5Al/qe88RXTQyXkQQ==
X-Gm-Gg: AZuq6aJvCYmCjLzv4Vpyrl/LndZ3bdApRhTqMl5xhi4bDsBDASPHD1DZuDMfH9ctxnF
	rXjst1phWQP9MVMXDnydmID46GuUTqziM0OArj+S4MbqxRmsonfCPusPC7rEMbB8dnj4JztrCv9
	styLV8Wk1ixTZ1DKiw2UwIZo/3LbQK8GWKE3yhesX8RFhoS+gqR4AaBMNIMA9fXmEPMu0P0FHbr
	lfZoluxPPZBWTL9QyS6mdxzBpq7iPbA9rHP8XEDCslGe4dHBQrYGw58ztdv25tlPQQQqQYJ155e
	dJeY0BRrSTY4O58Oty2v1UkC53xjTO9e1CSQakn9FVBXU8eVAcq4ArSR87qxbsAqIsaXwLM5BFx
	6R6zYxbT6LCWkNKuoQrNk9QgRxykPLRvCcBBTx1DSfUMZ/sQ4YULlTyfYm9B+3Rp4c4qTkyxH8o
	JkD1/i6GI17EC4OXPBrPk/U2DerkFZ7nPSvdcgOppXTPaJWYrTQQ==
X-Received: by 2002:a05:7022:60a0:b0:119:e56b:98ab with SMTP id a92af1059eb24-12703fe635cmr6926735c88.18.1770686230336;
        Mon, 09 Feb 2026 17:17:10 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:b8b8:83d8:d937:b0f8])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-127041d9c91sm11159286c88.2.2026.02.09.17.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 17:17:09 -0800 (PST)
Date: Mon, 9 Feb 2026 17:17:08 -0800
From: Brian Norris <briannorris@chromium.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH] PCI/portdrv: Allow probing even without child services
Message-ID: <aYqHFGKDjVJ_mOtp@google.com>
References: <20260109152013.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid>
 <aWHtbGzVRRpa9kd0@wunner.de>
 <aWfuyw3JHD-1F5uZ@google.com>
 <aWio-NB1csIhZJen@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWio-NB1csIhZJen@wunner.de>

(Sorry for some delay. Other priorities take over sometimes...)

On Thu, Jan 15, 2026 at 09:44:40AM +0100, Lukas Wunner wrote:
> I note that pcie_portdrv_remove() calls pci_disable_device()
> unconditionally.  You may need an extra struct with an extra flag
> to remember whether pci_disable_device() needs to be called on remove.

Note that pci_enable_device() and pci_set_master() are separate
operations. With the proposed change, we may undo the latter, but not
the former. So remove() will still need to call pci_disable_device(),
which automatically handles clearing the master bit if needed, without
extra state tracking.

So I don't see the problem here.

At any rate, I've sent v2 that I think addresses everything. Feel free
to tell me I'm wrong there if needed :)

Brian

P.S. This whole concern is likely for naught if the port actually has a
device at the other end, since pci_enable_bridge() will set the master
bit anyway.
