Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1545E367B96
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340978; cv=none; b=D0iTGCVkn1DKHlXkFoFA8cMbuu3EMDRZlQO+/P33u8E2jmP7XIFkkDhno4ATehbknsCMTxNsgnEEkKvFQYticd3uKs7bgLQk5W2FDX3ASF/wjN3GpSlYVWq3W7AgGadr1DN8MJ5CXkBjy1NLEIbF26BE+ND0aNzpKDYA+XaM3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340978; c=relaxed/simple;
	bh=aLTwDG9P8aHH3Rbej1brOxYx4jmWhcUSytYxw3M5vrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIidy7VnOZA3a33lE4LHnTAwBEFhT/HviVMgCAdaEzPe8/owrLlDiKEPlkDwJ7y4csBuUKeuCbLdYQJQxl5TZcrXFRwZ4JObJxCVEWg0HAlbckbI6fXA3/OPhkMBPz79pY5e0B0CjgDLiDt/CsP2VDwvqAWNDn27DgwIOgDHjOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WJ3Zc+fp; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WJ3Zc+fp"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-304e58292d3so7435476eec.0
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 12:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780340976; x=1780945776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UHjttj3kR0F1DCocN2D+OE0FnOjZbokOEw8cA01QXI0=;
        b=WJ3Zc+fpiae7lgnqxt7KdCRONYurxsisALzsvZMUK7nGS05l53pDwQryXg/fM51imx
         fSf/eviRAy9rqmAOkt+JXkYMFrOZABHQiy2yer6fERAn5f9VG4dLF71JuKAAQhFk7m+5
         /weXzQ9sb1HJkRijt7pALYfkrRfF1gN6B+r5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780340976; x=1780945776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHjttj3kR0F1DCocN2D+OE0FnOjZbokOEw8cA01QXI0=;
        b=IBqYGsKysM3UmNv/Zo2EcVMl6R9ikIPGnDK8kBgj/Q13+y7rJPMJ80SLHMzecXgkAX
         NH6bM5SulebJzru2kx1VyA/93qCUSdVASQ1h8aeJqrEjfwDaWl2MCOQBtgAU/eoyPX0S
         C0b252FdMEZIeOmwvLiOWNasEUjcxI5zTXt8gfLz3Pd/uMwdlkex8dF3LUJ2tbz8Bno3
         rjj8OAf+rdztt2VdC5qVrbgc6ScymvDJc1irO8Z3sMGJUzhPVQB69Hdvupo5nDFW2Krs
         SX7ZKSAzQTSoJPvtCjFXj0lmdR1ksP3TQrnhdZkP0S0NOdSNi6D5/yCkfTKXT0u+29+B
         MBNA==
X-Forwarded-Encrypted: i=1; AFNElJ+3zk5HoGS8N24JLr8kb/Ursya8g65nH2lxdSx0AuyZuqZ+5821F9RzmdvKih1n/6CneFS4d54EaTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAyMA2CmMOq8HzrUDVrvjEUSWwj86bMhEOzjcJGlgGcRrwawMy
	RGQ0faNokw69WvHkt6m0rxh5lAQHbrWAphtFKJKGkuih45eT1MxAJ82o/1T2f6Dkow==
X-Gm-Gg: Acq92OHwL2OKxnFHXhXoMDzqKiu/dWqPNsrPhwY+FI+4bSrH1P/8bebOfhEZglmnbhT
	Lz0uYQYCzBnem04hQgGtjxLyeSw9nNEMiYIH1xriGV0ikdZQTympYAzpnK75I3z8YOPc6rJEMTH
	QyCPiJVua1ynm7tLpKeq9yQ+qA0eHhEqjyZ1cuPN9bJq+zGSi99eK+k22ZxGIcna6QRAn16to2G
	5yzowtcE+w3rhNp5zQTGMi7t6zhLW7hf8dG2O2mgk2YnE+HX5iUvHGO8NiG6RuNoCi8mD6JOQ3r
	SKjyTzL9o/KDsFGvNin9CBo24x/B/eqymQIXBmwc+IoCAgelhe2mDogNQPGrG3aWVIqAYRxZZ5K
	qUq0O3brkYQRYYheU1wJip9/1W/xHM4BzK6x7fTaEwuCGKh4soYrnOwZmWrFr4jzdcROQN25QYU
	5mp1Dyltnrrz0rbWnTXXbCUdc5Z2nPd2TnEbxoKikoIIOZ764qv87jUqHvIbyeqC3VyW9Ub7Un
X-Received: by 2002:a05:7300:c87:b0:304:cefc:5fde with SMTP id 5a478bee46e88-304fa6b5144mr5496441eec.26.1780340976037;
        Mon, 01 Jun 2026 12:09:36 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:d53d:3040:2c80:7717])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-304ed5a0b7dsm9917641eec.22.2026.06.01.12.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 12:09:35 -0700 (PDT)
Date: Mon, 1 Jun 2026 12:09:32 -0700
From: Brian Norris <briannorris@chromium.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Radu Rendec <radu@rendec.net>, Thomas Gleixner <tglx@linutronix.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Daniel Tsai <danielsftsai@google.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Brian Masney <bmasney@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Jared Kangas <jkangas@redhat.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v3 3/3] PCI: dwc: Enable MSI affinity support
Message-ID: <ah3Y7K75AbQ9jV8v@google.com>
References: <20251128212055.1409093-1-rrendec@redhat.com>
 <20251128212055.1409093-4-rrendec@redhat.com>
 <ahC8Pyuatu_AvnZp@google.com>
 <ahDvvGew5UK3KSpi@google.com>
 <73f04f467e65b13fd455a3650dc2bd106af1e5a6.camel@rendec.net>
 <ahowweKTZXteLgZS@google.com>
 <ah1At6tb_V2jxIfS@ryzen>
 <ah3XLfI7E39B1UPh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah3XLfI7E39B1UPh@google.com>

On Mon, Jun 01, 2026 at 12:02:55PM -0700, Brian Norris wrote:
> > Perhaps a long-shot, but have you tried to apply:
> > https://lore.kernel.org/linux-pci/20260519-l1ss-fix-v2-0-b2c3a4bdeb15@oss.qualcomm.com/
> 
> For the record, that's:
> 
> [PATCH v2 0/4] PCI: Introduce pci_suspend_retains_context() API
> 
> > to see if it helps your problem?
> 
> It also seemed like a long-shot, but I tried it and it does resolve my
> problems. Maybe I can provide a Tested-by there.
> 
> > https://lore.kernel.org/linux-pci/r247uuc7ilkhn65vcbsaoxhgypif37lj3r3mvb7ooqqdg55vnm@vx3ip6klg6ha/
> > also seems to mention a recent PSCI fix:
> > https://lore.kernel.org/all/20251231162126.7728-1-manivannan.sadhasivam@oss.qualcomm.com/
> 
> That's:
> [PATCH] firmware: psci: Set pm_set_resume/suspend_via_firmware() for SYSTEM_SUSPEND
> 
> > Which also sounds somewhat related.
> 
> Yes, that looks somewhat related. I tried it, and it seems to resolve my
> issue as well.

Oh, nice, I see that this was already applied to pci/next for v7.2. I
had already tested pci/next, but as luck would have it, I had pulled it
a day before Bjorn Helgaas applied the series.

I can't imagine this is a linux-stable candidate though, as it appears
to be a bit more of a "new feature" thing. I'm still stuck wondering how
this showed up as a regression for me.

Brian
