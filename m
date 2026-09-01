Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9856F1F94F;
	Tue,  1 Sep 2026 06:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788243124; cv=none; b=BW8UkUXMFb7G9kyYh2RolMvRap56Z0rECnw8kMwHDhb+0qbYp1BcIawPAmhMvAa2jiK+p9e4gK6JrA37upyudnRGpNBiaq9egCyKvgIHY2VaJ7goJjMIQf7F/5z589PPT5rjEWaF1/biDEN0CDl/t+1vmeHEIG/8o0vVlQPeOoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788243124; c=relaxed/simple;
	bh=/MfKmKIgkC76+DBhX+r4jXtzjyclYPg6+d85ygG5Qgw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fCKg5MTly69kW5eLaa8csjqOL5kBxDkNe16zE1yFomhlZG4zy2QxoKN/GB/tzDAjhLTUZi5fuKTw/Q3+0nlGf6JBpvBxpy0BCY1b/vqTK+N4Dt8L1JEafWZNN9x5chA0qZMz4K9SZEzWAsM1hVBolhEmbUHIQd8hazCcnHa2QE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MaGIrrQe; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MaGIrrQe"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 974801A192D;
	Tue,  1 Sep 2026 06:11:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 693EC6053C;
	Tue,  1 Sep 2026 06:11:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2EA7B11C7923C;
	Tue,  1 Sep 2026 08:11:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788243109; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EMf21iM/QNSVwedceXOolAwbRcgqehu3VDqw47iT9VM=;
	b=MaGIrrQeK/9z6YwYOhvmOajs1kw44ZbNMihLXU76OjgNQ4jgJwiE/QEiyWYwfAs0fHPeGo
	XD6EjJDkq41NjAI5LWnpvExAN7GHrNNB0T0upA7whdQLhBaBB5eGexS7T3Vi7I53/Qgin2
	zrVaeBKfG5Eay1/II9USm2M6TychkTZoVsOTBC54H0rwNW9Nq9rpPHsPCi4wrjCqxmGghj
	m0aplS2XtlAJwosLQC/3b9pNXCIDmDMqL75eLgWOehkslKAnFmj8D0LxD0JpzEQ7heV1Aj
	Y4o+TkDCK2RweHJyiMDNLAmcBSDDuvftBDclE3qSZ7fCAJi4BuKaGZROzJ7rRQ==
Date: Tue, 1 Sep 2026 08:11:45 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Alex Elder <elder@riscstar.com>
Cc: bhelgaas@google.com, robh@kernel.org, saravanak@kernel.org,
 daniel@riscstar.com, mohd.anwar@oss.qualcomm.com,
 lorenzo.bianconi@oss.qualcomm.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] PCI: of: introduce of_pci_verify_node()
Message-ID: <20260901081145.25f0e993@bootlin.com>
In-Reply-To: <20260901011338.1323243-4-elder@riscstar.com>
References: <20260901011338.1323243-1-elder@riscstar.com>
	<20260901011338.1323243-4-elder@riscstar.com>
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

On Mon, 31 Aug 2026 20:13:36 -0500
Alex Elder <elder@riscstar.com> wrote:

> Commit 407d1a51921e9 ("PCI: Create device tree node for bridge") linked
> the PCI enumeration process together with devicetree, creating a devicetree
> node for discovered PCI bridges.  Its successor commit ae9813db1dc5a ("PCI:
> Add quirks to generate device tree node for Xilinx Alveo U50") shows how
> to use a PCI final fixup quirk to also create a devicetree node for a
> non-bridge PCI device.  These changes allowed devicetree overlays to
> describe components downstream of a PCI device, by providing a place to
> attach the overlay.
> 
> Note that the dynamic devicetree node is only created if the device didn't
> already have an assigned node.
> 
> Later, commit aa7b4bbcb3a1d ("arm64: dts: qcom: qcs6490-rb3gen2: Add
> TC9563 PCIe switch node") *pre-defined* devicetree nodes to represent the
> PCI device nodes that would (also) be discovered via the PCI enumeration
> process.  The devicetree node in this case is created with the content
> from the DTS file.  So when a (host) bridge is done being initialized
> during PCI enumeration, no node is dynamically created (the commits
> mentioned above do not apply).
> 
> Ideally, any pre-defined PCI devicetree node would contain exactly the
> same information as whatever the dynamic creation process would produce
> (though it could include more).
> 
> However that is not the case for the pre-defined Qualcomm RB3gen2 nodes.
> And in particular, the endpoint (function) nodes include this property:
> 
>     device_type = "pci";
> 
> This is simply wrong; that property is meant only for bridge nodes.
> 
> Rob Herring requested that a runtime check to be added to spot this
> specific error, only for non-bridge PCI devices.  Herve Codina further
> suggested we ensure that bridge PCI devices *do* define the device_type
> property, with value "pci".
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v3: - Switch a function header to use kernel-doc format
>     - Add a warning if a PCI bridge node has no device_type property
> 
>  drivers/pci/bus.c |  1 +
>  drivers/pci/of.c  | 31 +++++++++++++++++++++++++++++++
>  drivers/pci/pci.h |  3 +++
>  3 files changed, 35 insertions(+)
> 

LGTM.

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
