Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DAD470E8C;
	Fri,  2 Oct 2026 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932217; cv=none; b=i4p4cIMJd8NmsDH9GExt+pCMcV96fs7jLEvrLobt9itOvUMp3wy7yKYowu8a+fUjxvuxg5tfm45AgxnMKwvndVCrq8DvVkds4/IHDZujXW8JvXqe5yNff6/Ke9TYJmCCIrBupFCTA/bKN23+Sk4fw12wmUlNwBS88baHKmAXhCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932217; c=relaxed/simple;
	bh=mBUPp1lS8z0kfzxP1Hg90/VzoaWfuf5cIwrLnzPZWJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q57kHEjiAn3JXaAEN7itSMomiL2szcGnILY4IXe3F8JGvuu0spBAJsJbJbVZQ0r5bsyE1kbeSDEm02JqzAgX53dre3tg5apLUohr0i1li+4XJuCiHhLwfw4Vp5f4O1Zb/rXnE4jv7xwsgyQ87Qy1UPzYBbkdjJ9jS/KBf6zYlfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SCbTdCMy; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SCbTdCMy"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hx2zx61ktzKp2k;
	Fri, 02 Oct 2026 11:10:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790932205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zeT/gmsphdHF1F0lstf9koANh3MTjFXV9izEsKVQaVA=;
	b=SCbTdCMyR0m+WZUO7z4Eg/d7PZnsdb8zLK63fEkjQNgmcNAIhj0DmgapsanXxbxcV0AIQf
	86icdCixDpj9K04bsLj8i5kqRlwuBOfhKpS+jMfX7DNGJUYdrtYlGU08pu4/Fe6Wmdr72N
	YBXwHl2+6ARIVX28f3SGNxlRCH8mdStGUsugK7F8oaUD/5+xUYDAJTMa6LAzcHyNckWOww
	FuQW80A45zH+7i7Jdi/kB+2IaeZg69y5Nm6TUMIpkBhm+A93JMc9XmKUD3TUfhFKtcu1xr
	DF/qdENwXSVROUYecMZlJrcSNInq9H7NS3cp6vfxvKa2WgmwLXY2cftqnWC/pQ==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] PCI: Write RCB only when it changes
Date: Fri,  2 Oct 2026 11:09:58 +0200
Message-ID: <20261002091001.2224884-1-stefan.roese@mailbox.org>
In-Reply-To: <20260930232214.GA2654517@bhelgaas>
References: <20260930232214.GA2654517@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: m9gcz9kzzsw8ht77z3wshaeb9th5f4g8
X-MBO-RS-ID: ad96f5c6ce70f070296

On Wed, Sep 30, 2026 at 06:22:14PM -0500, Bjorn Helgaas wrote:
> In "After a host write, even of the unchanged value 0x0003, it no
> longer does so", what are you saying it no longer does?
>
> Are you saying the chip no longer clears ASPM Control during firmware
> download?

Yes, exactly. I watched Link Control with a kprobe on the config
write path. Without any host write to Link Control, it changes from
0x0003 to 0x0000 about 11-19 ms into the firmware download by
xhci-pci-renesas, between two config writes of the driver to its
download registers. Linux does not write Link Control there, so the
chip does it itself.

After a single host write of the unchanged value 0x0003, either from
pci_configure_rcb() or from a manual setpci on a kernel without
1a6845aaa6de, Link Control stays 0x0003 through the whole download.
The first MMIO access to the xHCI BAR afterwards ends in completion
timeouts, an AER error and link loss.

> But PCIe r7.0, sec 5.4.1.4, says the result is undefined if software
> enables L0s when the other end of the link doesn't support it, and I
> guess writing 0x0003 (ASPM L0s and L1 enabled) counts as enabling L0s,
> and we certainly got undefined results.

Agreed. The chip's own clearing has been hiding that ASPM is enabled
against a Root Port that supports no ASPM. So the real fix is in
aspm.c (v1 2/2, now 1/2), and the RCB write is only what exposed it.

> What if we just did this:
>
>   if (rp_lnkctl & PCI_EXP_LNKCTL_RCB)
>     pcie_capability_set_word(dev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RCB);

Fine with me. On this board RCB is clear in the Root Port, so this
also avoids the write here.

v2 makes the aspm.c change the first patch (with Fixes: and stable),
adds the saved state update that sashiko pointed out, and uses your
set-only variant as the second patch. I tested the combinations on the
board, v6.18.40 with the patches backported, 3 cold boots each:

- aspm.c patch alone: good, the "clearing ASPM Control" message shows
  up for the xHCI, after the RCB write.
- both patches: good.
- set-only patch alone, booted with pcie_aspm=off: good, the chip
  clears ASPM Control itself again.
- aspm.c patch alone, booted with pcie_aspm=off: bad, completion
  timeouts as before.

The last case is why the set-only patch now carries Fixes: and stable
as well: with pcie_aspm=off the aspm.c change never runs, and only
avoiding the Link Control write keeps the system alive. The same holds
for CONFIG_PCIEASPM=n. If you would rather take the set-only patch
without the stable tag, that is fine with me.

v2 follows.

Thanks,
Stefan
