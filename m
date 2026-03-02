Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8628F288D6;
	Mon,  2 Mar 2026 01:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772416459; cv=pass; b=TNzvPiEiKgs+lREglD4yX64eh1PzSnjnhqXEZ5YPSu8o+q5veFd0eGyr0yH5ad+WcgHcEDWdKkBGNL7tf/lkcJaVJTQ+WK4NaaxKdtBrx9MiON3LvLKFJHa9vIc/YToTTQ1mcC5enn9jQ4+ds5dPbIXcJhCUmWZtVNQOBKNC/f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772416459; c=relaxed/simple;
	bh=UQ54CrxRe0IikY7BDQ/DkyZ/zc04kGEs1TOqGe53ZHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1OTniejDJftB0aRbmhinP8aL6psYcD4qK1HWpSanpGfLmZo6g4ulPKvusAlVSLe9FJWabNjUm2QHDRNxwaHSZh04g6yDo2Fjb6jmiYJElqEqJZ+jM6JJpUSXPmrg+PxOjoVSRqk0s3HQBuDJpTqH2XOH/ElNGt9hDVpxqh9Dk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=l1+DWnTT; arc=pass smtp.client-ip=23.83.218.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="l1+DWnTT"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E25548A2B9F;
	Mon, 02 Mar 2026 01:54:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a227.dreamhost.com (100-104-34-21.trex-nlb.outbound.svc.cluster.local [100.104.34.21])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 753428A2895;
	Mon, 02 Mar 2026 01:54:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1772416457;
	b=XvLIiz/9DL8agG9QAT8vAfJJvAV4B2jiGpbemUWKjP7v4leX1n3nfzxBcX9IDLoqTpO3QP
	f7ecEPLK0+Pm3B1hIvOZ4Bnny+TzptDfpiPQ0mXUqKmiBiUbl16y2YWkQmNJhbxQgIlxGm
	r4irk0LvaysucBrlTmUi8LR/whb5ajXkL+eaPPS8wB2lHmgmsgQyCdvR1pamXdoxjc0auD
	Qc52ltMqex0RR0w/CuyDInk8xtKYD7D99ZYPvGfZRjLXlFB6IB8X/tzbkeAngdYEXhOw16
	2BoVP1G8Uv/BXJGNkK8cisiYvZQCVlzEfnLDCoqs5nA9keZYcHqX5QF2ea22eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1772416457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=TPbTYSTNUbn5PItBwDAMH2qFJSNSNCFPSDNOYAf0fmo=;
	b=EwQddUl3Y75SgcfuFe4d37x2Qv+nl8ZnccuBG0ayXbU8GZEtmA0zm8BHxTHD3eHCaamfwr
	d4UK9ui7ffJbgsdh4JrKPn3P4nw3F/+KK+YbbO/cn4+VrRy2J6xVwh4ARVWVlf1ijiNv3H
	kPmNRjJ1q4DKCzCSmw4pQd3O+/3aW2qt4uLs3ez7tZLgA9Dpn/DT0C+BoxAGP76lnu4xCw
	x/UbC6eS9VZ0zLujLyXvVbiXJAVJ2+iwp6TH15AogJj9uFfX1zmW9U0fRP17/tPAzxo6kr
	ZDBiXqMi9cUELpH6abfbNCfeyBvgZd+grq0cIb88BewQysGDIdhNm6nUD4s1Dw==
ARC-Authentication-Results: i=1;
	rspamd-7f65b64645-cqg9t;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Average-Cellar: 30623bbe28883516_1772416457760_1261187236
X-MC-Loop-Signature: 1772416457760:3748921973
X-MC-Ingress-Time: 1772416457759
Received: from pdx1-sub0-mail-a227.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.34.21 (trex/7.1.3);
	Mon, 02 Mar 2026 01:54:17 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a227.dreamhost.com (Postfix) with ESMTPSA id 4fPMRr5Dr3z1w;
	Sun,  1 Mar 2026 17:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1772416457;
	bh=TPbTYSTNUbn5PItBwDAMH2qFJSNSNCFPSDNOYAf0fmo=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=l1+DWnTTv4Rm6oOh3EWWRVgQoCO83MSctbWGRK5DYesi9vlgMqus31tdlxWdKhTqH
	 A1NIwkr1AzLiWHIwCQjsf7/+fwKMu141vh/Np0ReT2BOFJI+pLYSPMDJvY5WqvEfsC
	 4Ahnipz7ZIpIjPP0rBVb4iaOkO+Ms+R/qxx4MbA15sR2HVT/9J0YERi2mJrXxrVpY4
	 veXofxKSihDU8GofYUwAKZ3P/RV9eoqLaxxnWvvb0xFjGFj/ts8qiMR30gVgWkf1XY
	 94LCufaOaGzboryb+aQg7cU+0b5iXbr2HP1QFS6Z0vellZxdV01GCvxW8lb60pXGZY
	 +kYcFMQmyKIEg==
Date: Sun, 1 Mar 2026 17:54:13 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 19/37] cxl/pci: Replace pci_alloc_irq_vectors() with
 pcim_alloc_irq_vectors()
Message-ID: <20260302015413.7eo4ivonpagqn735@offworld>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
 <1771861967-88542-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1771861967-88542-1-git-send-email-shawn.lin@rock-chips.com>
User-Agent: NeoMutt/20220429

On Mon, 23 Feb 2026, Shawn Lin wrote:

>pcim_enable_device() no longer automatically manages IRQ vectors via devres.
>Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
>pcim_alloc_irq_vectors() should be used.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>
>To: Davidlohr Bueso <dave@stgolabs.net>
>To: Jonathan Cameron <jonathan.cameron@huawei.com>
>To: Dave Jiang <dave.jiang@intel.com>
>To: Alison Schofield <alison.schofield@intel.com>
>To: Vishal Verma <vishal.l.verma@intel.com>
>To: Ira Weiny <ira.weiny@intel.com>
>To: Dan Williams <dan.j.williams@intel.com>
>Cc: linux-cxl@vger.kernel.org
>Cc: Bjorn Helgaas <bhelgaas@google.com>
>Cc: Philipp Stanner <phasta@kernel.org>
>Cc: linux-pci@vger.kernel.org
>Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>---
>
> drivers/cxl/pci.c | 8 ++------
> 1 file changed, 2 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>index fbb300a..de5c9ff 100644
>--- a/drivers/cxl/pci.c
>+++ b/drivers/cxl/pci.c
>@@ -565,13 +565,9 @@ static bool cxl_alloc_irq_vectors(struct pci_dev *pdev)
> 	 * Per CXL 3.0 3.1.1 CXL.io Endpoint a function on a CXL device must
> 	 * not generate INTx messages if that function participates in
> 	 * CXL.cache or CXL.mem.
>-	 *
>-	 * Additionally pci_alloc_irq_vectors() handles calling
>-	 * pci_free_irq_vectors() automatically despite not being called
>-	 * pcim_*.  See pci_setup_msi_context().
> 	 */
>-	nvecs = pci_alloc_irq_vectors(pdev, 1, CXL_PCI_DEFAULT_MAX_VECTORS,
>-				      PCI_IRQ_MSIX | PCI_IRQ_MSI);
>+	nvecs = pcim_alloc_irq_vectors(pdev, 1, CXL_PCI_DEFAULT_MAX_VECTORS,
>+				       PCI_IRQ_MSIX | PCI_IRQ_MSI);
> 	if (nvecs < 1) {
> 		dev_dbg(&pdev->dev, "Failed to alloc irq vectors: %d\n", nvecs);
> 		return false;
>-- 
>2.7.4
>
