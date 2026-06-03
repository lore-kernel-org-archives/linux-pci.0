Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2DF332ED6;
	Wed,  3 Jun 2026 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490943; cv=none; b=fNq7SiKCj1VOIsyTKRE49o15+s+ZG97HumNJab4T62mZm/hMiMJvp/pQ6vYgYk62bjjAe8oswkQaH5k6lwuur6zrLK+Dq/vtvxrP3Ci3pl75BEX6y9B8yFkQ3WZ+cE5P2uEmjZ3BXvsQL3xIW/IiP5zvYaSW3U1lsxY83SYROKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490943; c=relaxed/simple;
	bh=m8DRSo5zjtdDGR4jyIC6fInyAVrYTZPTzQ4Hu8tFrPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fn6sCmB+szrQajGSbuvmkVMlPGITFP+UeBq9VgHa2JKF7wjwLlNA5Q5P2bLsKoWUfitgJbqCstg4lzJMG9Aeyn5tHhAkbKG43egV6yeEhnn0zaMOl9XO4VHGdju9MU3tsQtIR9Q3gvdbRxNoXbnuVHNF+OAeDeiq8VdPFIp1Bu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 1D09410E0C;
	Wed, 03 Jun 2026 14:49:00 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 17F1A60C92C3; Wed,  3 Jun 2026 14:49:00 +0200 (CEST)
Date: Wed, 3 Jun 2026 14:49:00 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Yingying Zheng <zhengyingying@sangfor.com.cn>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ?????? <dinghui@sangfor.com.cn>
Subject: Re: [RFC PATCH] PCI: readiness condition with Configuration RRS in
 pci_dev_wait()
Message-ID: <aiAivMSVkMTvGluD@wunner.de>
References: <96e8ff0e-b538-42d5-a328-96515fc3fa9e@sangfor.com.cn>
 <aiAhq-BO5baJBfVl@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiAhq-BO5baJBfVl@wunner.de>

On Wed, Jun 03, 2026 at 02:44:27PM +0200, Lukas Wunner wrote:
> The Supermicro server had already been updated to the latest BIOS version,
> but the BIOS update does not include updates for the PCIe switches.
> One has to contact Broadcom directly and ask for a separate firmware
> update.

Sorry, this should have been "One has to contact *Supermicro*".

We got the firmware update from Supermicro.
Broadcom always pointed to the OEM, i.e. Supermicro.

Thanks,

Lukas
