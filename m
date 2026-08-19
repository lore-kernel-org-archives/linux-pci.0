Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C42A4399F7;
	Wed, 19 Aug 2026 10:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134959; cv=none; b=IQ6yq9KZXpcKoptPlhSMxTDHCkYc//CvgpEqNq3nXqxzvg/zrpGTuieGwAfQE9RNaUsO9j5COk3C1ttfCuMiXE3P3OOuAvod0h9RNtxwPdHkriJ3CQ6GwrsRrCTmrFuo6v4ebGnNAG5VYVi2X+lpZLm6HCtzJ5uOGzIJa/V8+s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134959; c=relaxed/simple;
	bh=uecvIOxEGG6//m/fT/qeWHykoOq7qqR701CJpMMA2us=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USs0i1qqbUDrcNnJeXfgNVoftDOd8XNE+So/OVKGJkoKLTJbhnUGM3/H+78N2eIxBtZeAhDso+SWP1vtY3KchNIwdw6KSyKOhxX7Pmgu1Yh9GZcUiFaGx2bNiGjL5stgPuoA9cT4NJKexOk3JXN/3N0VsZYwnoYLy1EBK3hx7GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Pf0IjD2u; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Pf0IjD2u"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DC3F11A1738;
	Wed, 19 Aug 2026 10:22:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A13415FF42;
	Wed, 19 Aug 2026 10:22:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5FB6211C755FF;
	Wed, 19 Aug 2026 12:22:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787134950; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8aKmlSVLQhxHhhpdXO4P8w1nP+sYAyE87ROOhRR8OKo=;
	b=Pf0IjD2uiw0sOoXXjo9b5ChfT/jyxVw5wcvKJtmPTSoRhqsQU77RFLogT4K/Uu3bgQPvKh
	W/m9yCaWXUyh0r2mMmCXH2PEhVfSu6jQYpYFgxxYLUS9ui/fvx7iJLF8lpeiwhz6GzpmND
	zw3SzmrUf/tDDAA/5cTnEJookKAmhEiMLwSVDPfyhwD11U4DdzGuo6AUmM+uAyfQI8Q2JA
	mnZK8n3B8lWG21D9Lw8+6Or11Pc8udtgUlzibyXEN0XSBajJpKrrkcHO6dj2kATpJsKyB8
	xpxQqnFAR6aYv/eZkqMZQaImQquWvcgc2hi6xttH9nMEfpzMAvNj+GVg8QIUWA==
Date: Wed, 19 Aug 2026 12:22:26 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Alex Elder <elder@riscstar.com>
Cc: bhelgaas@google.com, robh@kernel.org, daniel@riscstar.com,
 mohd.anwar@oss.qualcomm.com, lorenzo.bianconi@oss.qualcomm.com,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] PCI: of: warn on bogus device_type property
Message-ID: <20260819122226.6951c816@bootlin.com>
In-Reply-To: <20260812172247.276554-1-elder@riscstar.com>
References: <20260812172247.276554-1-elder@riscstar.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Alex,

Can you add me in Cc in all patches of the series for next iterations?

Best regards,
Hervé

On Wed, 12 Aug 2026 12:22:43 -0500
Alex Elder <elder@riscstar.com> wrote:

> The purpose of this series lies in its final patch, where a new check
> is added whenever a PCI devicetree node is found to already exist when
> one might otherwise be dynamically created.
> 
> PCI has a well-defined bus and device discovery process.  The
> PCI_DYNAMIC_OF_NODES Kconfig option allows PCI devices to *also*
> have a devicetree node.  This enables certain things that are
> not possible with PCI enumeration alone.
> 
> While working on a Qualcomm platform, I learned that some PCI
> endpoint nodes were defined with device_type = "pci" properties.
> Herve Codina pointed out that this was not correct.  Rob Herring
> indicated that people seem to have trouble getting the PCI
> devicetree nodes right, and asked whether we could warn if this
> particular problem occurred.
> 
> The last patch in this series implements that check and warning.
> The first three patches are fairly trivial changes to clean up
> some related code.  This is the only changed patch since v1.
> 
> 					-Alex
> 
> Between version 1 and version 2:
> - Check the PCI devicetree node even when PCI_DYNAMIC_OF_NODES is
>   not enabled
> 
> Version 1 is available here:
>   https://lore.kernel.org/lkml/20260807194100.455599-1-elder@riscstar.com/
> 
> Alex Elder (4):
>   PCI: of: drop the reg_num argument to of_pci_set_address()
>   PCI: of: don't zero flags in of_pci_get_addr_flags()
>   PCI: of: make a flags argument optional
>   PCI: of: introduce of_pci_verify_node()
> 
>  drivers/pci/bus.c         |  1 +
>  drivers/pci/of.c          | 26 ++++++++++++++++++++++++++
>  drivers/pci/of_property.c | 20 ++++++++++----------
>  drivers/pci/pci.h         |  3 +++
>  4 files changed, 40 insertions(+), 10 deletions(-)
> 
> 
> base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
