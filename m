Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9935F2C237E
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772226930; cv=none; b=fPK/625eWk+J1VknfAROnoxM2HqUsek54yeR4QPhKmKY9SJySgn6EkYoAAtiDy/h92GIz6oVBkVHVpkkKfGgsMp0kZZSasRyfS25fXVD6aKUHsTtTDZNR60FKD2Ek3m5qDYYHBefDfW0KipHbFSK/Ea1kMa7ozWscoS0eH5MB/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772226930; c=relaxed/simple;
	bh=GLNKKQCpfivgD8nRR+YfFy5Iq0VKI3RCPIbSqPekDFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sc5YkMjNerQUeonQTIXpWX1hgrWCZs+Fc5kiCfb1kKLJytKGUo2jq8HXc2mJIAwCz+U5KGimq8AXdkUpAbGmMSB8GWJYCELDsr4WJmXb40C1zCbzBaNp37DbgQxBSETNB6IVaBmzhlHfl/N1qTnQXz3iH0H+ceJ9oyt9xJJnUyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id F255B202019F;
	Fri, 27 Feb 2026 22:15:23 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E26AC27C72; Fri, 27 Feb 2026 22:15:23 +0100 (CET)
Date: Fri, 27 Feb 2026 22:15:23 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sizhe Liu <liusizhe5@huawei.com>, bhelgaas@google.com,
	jonathan.cameron@huawei.com, shiju.jose@huawei.com,
	keith.busch@intel.com, linux-pci@vger.kernel.org,
	linuxarm@huawei.com, prime.zeng@hisilicon.com, fanghao11@huawei.com,
	shenyang39@huawei.com, Shuai Xue <xueshuai@linux.alibaba.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH] PCI/ERR: Clear fatal status of the reporting device
Message-ID: <aaIJa_2XiQht4swq@wunner.de>
References: <20260227102505.3966864-1-liusizhe5@huawei.com>
 <20260227163118.GA3897131@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227163118.GA3897131@bhelgaas>

On Fri, Feb 27, 2026 at 06:25:05PM +0800, Sizhe Liu wrote:
> During PCIe native AER error recovery, ERR_FATAL status bits are not cleared
> after fatal error handling. This causes stale ERR_FATAL bits to be reported
> in subsequent AER events, even after reporting "device recovery successful".

Wrong.	The bits are cleared by:

report_slot_reset()
  err_handler->slot_reset()
    pci_restore_state()
      pci_aer_clear_status()
      	pci_aer_raw_clear_status()

Is this an LLM-generated submission?  The confidently worded but incorrect
commit message seems to suggest that it is.  If so, please follow the
guidelines in Documentation/process/generated-content.rst and be
transparent about the tools you used to come up with the patch.

Thanks,

Lukas
