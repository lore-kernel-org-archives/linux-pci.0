Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDF64EA38E;
	Thu, 23 Jul 2026 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823420; cv=none; b=XU84Yr/9+MPCJ8cEH6VNNOWhZZ6ayQ+dIIXTJeJSqvZOm0AfEILpYtsFgREygkxd6z1zr2fK2+R+8wSuN185GC85Xc+DOtbvKOTqu9C2DYdrsoqfG/Wp+FZ5SaxZIShWIQDoCdLjcozcXLJFq+8FHhDkR0t+C4jDMrHb5AcAaYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823420; c=relaxed/simple;
	bh=2SNDXZkFwA0M6FcciVI0mwLPgo6lF16qHBC8w+FZLOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e6rVCFqMt9ZCTMMoYFfabl+4k6i1d0Gy9FwVghZJN23ooUMPaXEiUa33elCjjFmNFa8ZVSl5RCQrs70QfuSKkmV3AR/bO/YST/hccSj7nv5DmXaMnm197DwNW0t9/P0Ggk9G8PmIfqlq6juY+S5rrGpG3uTzzOk8hmzrvm3oNSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=enrvpsoH; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=fLXL69Jv; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="enrvpsoH";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fLXL69Jv"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h5bq51Zz1zMlHw;
	Thu, 23 Jul 2026 18:16:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784823409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hpw7/UiaEy7PeKqIr+HqArMRpKTyyhCU3DTRMYChspM=;
	b=enrvpsoHV2fwfi8PAeSlnyPI2M4zF5L1oArbDBB3ev/thZA2ejiQOLxBzqINvPcpuLA/1T
	P6+O5MsfXZngLbEODCp0+Ya1+i0TwzPth8lVJqYTqjzUJ2BsGWpHG4mM5YJmBJvcbX48Rn
	zDkEKz5jvQVUu+UyTKUqrE++gfKyEoHsv9VioVo0B6VV1AkKjEPB2ljKpVw46F+D3/L+Yv
	+UP4qA1orGY5fS3lrsW7Sd8Dhobiz89r1meXVyYz0BfsiJtY9coI5rrhz31+xvwtbsD63w
	SnhiLdLAefduPmV4/1BAqKCPdVOKVWLaiPB5+gRPE7vMOQLfL2QN4zj9GFvz2g==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=fLXL69Jv;
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784823407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hpw7/UiaEy7PeKqIr+HqArMRpKTyyhCU3DTRMYChspM=;
	b=fLXL69JvAtvKZf89tnUW6yFDTqb/PzyhhI/z7epsJ2iEkUoUqJCZ+MYHldgQnUy/LlpkV+
	PQtpzC1PdJdJtP9iOCtOasbbRpjrF03GwJxrPBMf5Q5pIk3drTcEgWE8Lw+g3GvFx5TKod
	NuFfzft9i+tWFCcoIelJjosmqR79my0jWl/WIypMKNxqYtwcp/a/aAdV2jUqbFS+Tz7f9L
	T7+MN35LQZyTcYYksRtv/hXQquISleqq7fQ+fl3caWOCiszPMPwLBFb0MkGGVmJBJlfypB
	cz1b83sNJaEZGStZJy0UQ0qv70QlIA9tW1HaJH59pZBjWQUdAYwhVhl/nKoucg==
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org
Cc: Maurice Hieronymus <mhi@mailbox.org>,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: xen-pciback: would using pci_clear_master() in xen_pcibk_reset_device() break anything?
Date: Thu, 23 Jul 2026 18:16:33 +0200
Message-ID: <20260723161638.9838-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: fq69reqpoifnzd9qh68e46ix5sr3j1bp
X-MBO-RS-ID: 06c168c9acfd683c511
X-Rspamd-Queue-Id: 4h5bq51Zz1zMlHw

Hi,

I am moving `is_busmaster` out of the C bitfield in `struct pci_dev` [1],
because the bits sharing that word are written without a common lock.
xen-pciback is the only code outside drivers/pci that writes the flag,
in `xen_pcibk_reset_device()`:

	if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
		...
		if (pci_is_enabled(dev))
			pci_disable_device(dev);

		dev->is_busmaster = 0;
	} else {
		pci_read_config_word(dev, PCI_COMMAND, &cmd);
		if (cmd & (PCI_COMMAND_INVALIDATE)) {
			cmd &= ~(PCI_COMMAND_INVALIDATE);
			pci_write_config_word(dev, PCI_COMMAND, cmd);

			dev->is_busmaster = 0;
		}
	}

Lukas Wunner suggested converting both assignments to `pci_clear_master()`,
so that nothing outside drivers/pci writes the flag [2]. That is not
behavior-preserving: the assignments clear the software flag only, while
`pci_clear_master()` also clears `PCI_COMMAND_MASTER` in config space (it
skips the write only if the bit is already clear).

I do not know xen-pciback, so I cannot tell whether that difference
matters. One thing makes me suspicious: commit 7681f31ec9cd ("xen/pciback:
Don't disable PCI_COMMAND on PCI device reset.") deliberately removed a
`pci_write_config_word(dev, PCI_COMMAND, 0)` from directly above the first
assignment, and `pci_clear_master()` would put a `PCI_COMMAND` write back
at that exact spot.

So my question is simply: would converting these two assignments to
`pci_clear_master()` break anything?

If it would, I will keep xen-pciback's current semantics and export a
narrow flag-only helper instead.

[1] https://lore.kernel.org/linux-pci/20260714-pci-dev-flags-v2-1-a1d7dc441cf3@mailbox.org/
[2] https://lore.kernel.org/linux-pci/alcSjoypegNolW48@wunner.de/

Best,

Maurice
