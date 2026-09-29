Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42133E5A0F
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668901; cv=none; b=YEvpkP59IIoCihpMGt+Xgp9C9THp+xg6w841OjlqmrWtLegSg9/8aTVzEv7crJ7BzRYOIRnevUxe1vaJ/Iawq8GwbXT8PqVgGlymmgtDt5S0fdm5yv7vDhNgy6H5LGqjpswmGBdWFYnX1CdCsUU48MG8AhMUM6Jpm/i2aBiCboY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668901; c=relaxed/simple;
	bh=2B/TYTbXRt8Au18SrvGStmKpgErFqex+vncLzTx34D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I23NHz+5FQJljpwuvVysjsbBxsuIPShQEiS58TycRY04973xT2YFnLDH+YO1+trdf7VpKDICd9ZiEbVYO9LnQl4jolyr9LpSO9OeFOWSPR3xAMkwwgFXaXxm3UU9cEKmqyGw+MSdOZhReA5k2934m03r7vbHMJG3Ah/nF+kHDc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e98g66sm; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e98g66sm"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49fe8bf173aso20312495e9.3
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 01:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790668897; x=1791273697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x1zLcvYZn4VZi4U5hyO63YaC+RdJzk1Ftxp9O+4KGx0=;
        b=e98g66smWK0rFXlzdw+vW7LEKmGKzn41ToitJ1U5iLWqqSrWZr2ikeEyku2uYffHdL
         ihy1noBHvDToVTUYcTGNegrlgR2wGUnEMvmNq5w20FvO6y4IXOsVi8LI0yusEqIjF4mc
         q2/BMyypaYZ9hsvV8YUomFkueTHfPgUKWG8j9t/igdmHPdIatii9hKyGPiRZZ0n474NW
         CrrvYGHG/Ww1/4izr6/7tqZOdv0zGHYHfDJC99/S7cgrwzxNwiQsmhoZEODuRU0+YHM/
         3rLTcMfa0r46+eJ6QxFQS6g9YgztXLcNgQcSSBoyqMvkrdygOH6NdFhZ64ca0OeNDfWV
         Lsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790668897; x=1791273697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x1zLcvYZn4VZi4U5hyO63YaC+RdJzk1Ftxp9O+4KGx0=;
        b=ihl9YRp0LPpsOOVLh6kojqgmcXI4k8FdLiiiq5Dpb84CxUC9M+QzTa3xUZ7HzLQvlM
         pGY8Q91YVk2ngOAZkjvrmk23k7cyoPwaPTHnzLaNbbltFofDc9z0I04f3TUu4FE27jLP
         kw+efzwFUvY3PqJvcQyjcm0PLzuFVZaLJEl41tJ2W2A3Ntl2R7kMgGiV/j7bGRQxUz85
         s6LrT8+07ujxB3Rcuho4W3kLj6w5KeXl3EYAQe7Ff9sja0/w8Fn8MsC30NgXwHmu7Nno
         +zFzTZty8IjUfZxYkKUXkQ2n9fy1cm3iu20EmMa4rBxSrmQz+vVXyBEyu9nk46K/X/JC
         RpnA==
X-Forwarded-Encrypted: i=1; AKwUvBwb4jkSrkLlKTQHcFda9uRyZBpqFhEjXNDdvFkmmAr7JPxnMnPKD5Yb4qFC+dChS1uW1vXwIorLvFs=@vger.kernel.org
X-Gm-Message-State: AFuF++nCUkibIw5t9+smtf6SMAVVcrhVyntWo8wvlkE7ovd5XAPyub45
	w3NLqLl4946LaBSvheYWba6HbLRpGoLYFTR57ZRaHDUZ57l/gqmgUOem
X-Gm-Gg: AYBFou368P4vUwOTNt5ZkwdXBRl6xYLYpbBLFiwsGxDZRRVVvZWN7mP9N9LJ8Kg2GmZ
	5xMuVJDpfEwB9X4N4lkSaNbHio9ZC3/lZipPTP1ochcWSilcY96sCmnp5smA47pbeHn29+0dO0U
	Zg7YQoMhdKOPx63/mYun5vgwPKjlIAgbzrqdS/QqFBfez6nBh18ipWDc8IKvii4wTRcOcg7KlxW
	I2r5t1VL/P9BPTOjtWRXWltno6AixCp9PBGLG5bzqMxSaDPT+tlDpGRQbaR7Bkis1TTFQYAZN6A
	uSoRbH24gf8YtRp5VdDqjfPFrGo7fMRvH/u1sM1B3JpyXQQRb4AETJBF+IYb0DlZR8agvOo8qKT
	hnS19tfqn0Dq0jDRUzcaWqbpxmgFk0XTzzZSzzNIGhNoxZP7JgVy2XnfmOTagzRVynP4uggTYR3
	e1x9hs1aWgkQvuVbnAXzF+ZJXRDpRyivpLAzt+RYmasLzm8BWfWukPrC/of5XdB9GcI4Bn1KJej
	kqL+/eO3/d86rWJkiL/zjvpUWugz905Gym/t/LA9ILn3oMO1QDJj94xmzJdYen2/El9Bhz0
X-Received: by 2002:a05:600d:8643:10b0:49f:bb8a:b4ce with SMTP id 5b1f17b1804b1-49fe67bc26fmr190990405e9.28.1790668897384;
        Tue, 29 Sep 2026 01:01:37 -0700 (PDT)
Received: from corecachy.localdomain (p200300eca748c8fc021d81db54571dff.dip0.t-ipconnect.de. [2003:ec:a748:c8fc:21d:81db:5457:1dff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00d46548fsm39832425e9.4.2026.09.29.01.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 01:01:36 -0700 (PDT)
From: Andreas Wild <andiwild@gmail.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	M M <restafvalendergelijke@outlook.com>,
	blaat windows <blaaaat@hotmail.com>,
	edwardmalik95@icloud.com
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with no link
Date: Tue, 29 Sep 2026 09:59:16 +0200
Message-ID: <20260929080109.53944-1-andiwild@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <87c93553-d74d-4588-bd54-0ccb2728f327@leemhuis.info>
References: <20260801201244.4421-1-andiwild@gmail.com> <20260917233355.GA1115024@bhelgaas> <b4ed1637-ac6a-4af5-ab47-e07309af200b@leemhuis.info> <alpine.DEB.2.21.2609181131520.57799@angie.orcam.me.uk> <1b2cceea-8da4-4239-a955-e0c6b475a227@leemhuis.info> <87c93553-d74d-4588-bd54-0ccb2728f327@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Sep 2026, Thorsten Leemhuis wrote:

> No reason given, just a link to a diagnostic file that from a very quick
> look showed an Oops from the Nvidia driver:
> https://paste.cachyos.org/p/49a2487.log
>
> So maybe it's a problem in that OOT driver, maybe not. [...]

I had a look at that log, and I don't think it points at the patch.

It covers two boots, both on the same 7.2.2-1-cachyos build, which
carries the patch.  The second one, from which the report was taken,
came up normally.

In the failing boot the NVIDIA driver fails to initialise the GPU
("RmInitAdapter failed! (0x24:0x72:1281)"), and about a second later
modprobe takes a general protection fault in __refill_objects_node(),
reached from mas_preallocate(): an object still on the maple_node free
list had a zeroed free pointer, as if it had been allocated or written
to while still free.  The journal ends a second after that, so this is
presumably the hang the revert mentions.

That looks like slab corruption, which usually shows up in a victim
rather than the culprit, so the lack of NVIDIA frames in the trace
doesn't clear the driver: its failed-init teardown reported leaked
objects just before.  Another candidate is 4a724bcf5d70 ("mm/slab: take
n->list_lock in __slab_try_return_freelist() to avoid race"), which only
reached stable in 7.2.7.

Nothing in the log implicates the patch, but it can't clear it either:
the patch's early return is silent, and the report only has warnings
and errors from the failing boot.  One unexplained difference between
the boots: the r8169 NIC is at 33:00.0 in the failing one and at
30:00.0 in the good one.

Best regards,
Andreas
