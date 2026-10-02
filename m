Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1323473C86;
	Fri,  2 Oct 2026 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932233; cv=none; b=rtteKvPkSrkk2hwuZCBvbQz7r20UZcjUCE8uecz8zit0JY0Yr7wtApIx2+CVN/aGGIGsfCg4bGR6Wmlzk94rlolQ47BNdS8nmRt/C615gnJhEkWaJE0+Y2k8LKZfF0frG1Z906Gf/3/49sDpxvedbP3LUxI/OcDoP/7QaSEdErQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932233; c=relaxed/simple;
	bh=DBbz7utPkbczKLoMsF6eyrF+3elUAxkWlgpgCQtJj14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1Axn3q/qlebFoRtGvLrh3QXOO7eUeHPuxR7CxuEPDiM1UVl/f23nUoQKu8S8/Me88SCuFHoP9xGPLyGkUmjEcV7GT1eUYdxHZk6h1mo8tWVEpTqMevWI7WRVxDfgWsUxlkkRHAuOBByXeRwKbNIf5CVK27MNRtqxis0yPKilFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=XSCjYMSz; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XSCjYMSz"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hx30D4VN7zKmjD;
	Fri, 02 Oct 2026 11:10:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790932220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBbz7utPkbczKLoMsF6eyrF+3elUAxkWlgpgCQtJj14=;
	b=XSCjYMSz16lLWW5Sv6EjVKUysSV1xMLp8dxUAnTY2QN1eGQuKEfFsn9+rB0jRRf108GZvs
	9FqCKUAGbNH3p6kn3sHEjLN5XbBEY9/EvKRqeX1kUk4s7SdzjiiZWlYgXDWPDAdFAhj1Yj
	jYazqBKDZCpxR9kzg7eQXuCTFuqTYDGjk7A8p7jdxr1LVxx6VfcP/GshdPMu8FXYXb9A7f
	8l5Octa8Etvm5sNxXQbvPte97u4PJt2LOQj+pF3SnIYT9dOQAgoZpUnef78tkJLlMHnaB8
	bJ/BfmEqYm+bSTKRMbAIJmwrgiHrIAipoO3NQwedBeuR8Nd4CuwVlVmB9GkyfA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] PCI: Write RCB only when it changes
Date: Fri,  2 Oct 2026 11:10:15 +0200
Message-ID: <20261002091016.2225082-1-stefan.roese@mailbox.org>
In-Reply-To: <9FA3B138-A24C-4F07-BAB7-7FFB2315CDC5@oracle.com>
References: <9FA3B138-A24C-4F07-BAB7-7FFB2315CDC5@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: rdqecabz8dz875tqskjs8wzkby755dmq
X-MBO-RS-ID: 7eaa7f54df0ee8737e0

Hi Håkon,

On 30 Sep 2026, at 16:41, Haakon Bugge wrote:
> Since an unconditional write to Link Control while programming RCB
> does not violate the PCIe specification, this appears to be
> device-specific behavior and should be handled with a device quirk
> instead.

You're right that the RCB write itself is legal. What is not legal is
the state it leaves behind: ASPM L0s/L1 enabled on a link whose Root
Port supports no ASPM (r7.0, sec 5.4.1.4, as Bjorn pointed out).
pcie_aspm_cap_init() returns early for such a link and never clears
ASPM Control, so this is not specific to one device.

I did look at a quirk. The existing helper, pcie_aspm_remove_cap(),
only clears the support flags, which leads into the same early return
and leaves ASPM Control set. A quirk that clears it would have to
repeat the aspm.c link checks. So v2 will fix this in aspm.c, and
keep only Bjorn's set-only RCB change in probe.c.

Thanks,
Stefan
